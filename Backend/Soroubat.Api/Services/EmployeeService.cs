using FaceRecognitionDotNet;
using System.Net.Http.Json;
using System.Text.Json;
using System.Drawing;
using Soroubat.Api.Interfaces;
using Soroubat.Api.Models;

namespace Soroubat.Api.Services
{
    /// <summary>
    /// Interagit avec l'API Business Central EmployeeLookupAPI (page 50154)
    /// et assure la logique de reconnaissance faciale via FaceRecognitionDotNet.
    /// Ce service est utilisé en interne uniquement — l'accès direct aux données salarié
    /// n'est pas exposé via un endpoint HTTP.
    /// </summary>
    public class EmployeeService : BaseService, IEmployeeService
    {
        private readonly HttpClient _httpClient;
        private readonly ILogger<EmployeeService> _logger;
        private readonly string _modelsPath;

        /// <summary>Désérialisation en lecture : insensible à la casse, nommage camelCase.</summary>
        private static readonly JsonSerializerOptions SerializerOptionsRead = new()
        {
            PropertyNameCaseInsensitive = true,
            PropertyNamingPolicy        = JsonNamingPolicy.CamelCase
        };

        public EmployeeService(HttpClient httpClient, ILogger<EmployeeService> logger, IWebHostEnvironment env)
        {
            _httpClient = httpClient;
            _logger     = logger;
            // Chemin vers les modèles de reconnaissance faciale (.dat)
            // À télécharger depuis dlib et placer dans le dossier Models/FaceRef du projet.
            _modelsPath = Path.Combine(env.ContentRootPath, "Models", "FaceRef");
        }

        public async Task<bool> VerifyFaceAsync(FaceVerificationPostDto request, string? projectNo)
        {
            try
            {
                // Récupérer la photo de référence du salarié depuis BC.
                // Le filtre sur le projet est volontairement ignoré ici : un salarié peut avoir
                // été réaffecté entre la création de la fiche et le scan. On filtre uniquement
                // par matricule pour garantir l'unicité de la photo de référence.
                var encodedMatricule = Uri.EscapeDataString(request.Matricule);
                var url = $"employees?$filter=matricule eq '{encodedMatricule}'&$top=1";

                _logger.LogInformation("[Employee] Recherche salarié pour vérification faciale — Matricule : {Matricule}",
                    request.Matricule);

                var response = await _httpClient.GetAsync(url);

                if (!response.IsSuccessStatusCode)
                    await HandleErrorResponseAsync(response);

                var result = await response.Content
                    .ReadFromJsonAsync<BCResponse<EmployeeLookupDto>>(SerializerOptionsRead);

                var employee = result?.Value?.FirstOrDefault();

                if (employee == null)
                {
                    _logger.LogWarning("[Employee] Salarié introuvable pour le matricule {Matricule}",
                        request.Matricule);
                    return false;
                }

                if (string.IsNullOrEmpty(employee.ImageBase64))
                {
                    _logger.LogWarning("[Employee] Pas de photo de référence pour le matricule {Matricule}",
                        request.Matricule);
                    return false;
                }

                var cleanCaptured  = CleanBase64(request.CapturedImageBase64);
                var cleanReference = CleanBase64(employee.ImageBase64);

                return CompareImages(cleanCaptured, cleanReference);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "[Employee] Erreur lors de la vérification faciale du matricule {Matricule}",
                    request.Matricule);
                return false;
            }
        }

        // ── HELPERS PRIVÉS ────────────────────────────────────────────────────

        /// <summary>
        /// Compare deux visages encodés en Base64 en utilisant FaceRecognitionDotNet.
        /// Retourne true si la distance euclidienne est inférieure au seuil standard dlib (0.6).
        /// </summary>
        private bool CompareImages(string capturedBase64, string referenceBase64)
        {
            using var fr = FaceRecognition.Create(_modelsPath);

            byte[] capturedBytes  = Convert.FromBase64String(capturedBase64);
            byte[] referenceBytes = Convert.FromBase64String(referenceBase64);

            using var msCaptured      = new MemoryStream(capturedBytes);
            using var bitmapCaptured  = new Bitmap(msCaptured);
            using var imgCaptured     = FaceRecognition.LoadImage(bitmapCaptured);

            using var msReference     = new MemoryStream(referenceBytes);
            using var bitmapReference = new Bitmap(msReference);
            using var imgReference    = FaceRecognition.LoadImage(bitmapReference);

            var encodingCaptured  = fr.FaceEncodings(imgCaptured).FirstOrDefault();
            var encodingReference = fr.FaceEncodings(imgReference).FirstOrDefault();

            if (encodingCaptured == null || encodingReference == null)
            {
                _logger.LogWarning("[Employee] Visage non détecté sur l'une des photos.");
                return false;
            }

            // Comparaison par distance euclidienne — seuil 0.6 (standard dlib)
            double distance = FaceRecognition.FaceDistance(encodingCaptured, encodingReference);
            _logger.LogInformation("[Employee] Distance faciale calculée : {Distance}", distance);

            return distance < 0.6;
        }

        /// <summary>
        /// Supprime le préfixe data URI éventuel (ex : "data:image/png;base64,")
        /// d'une chaîne Base64 avant décodage.
        /// </summary>
        private static string CleanBase64(string? base64)
        {
            if (string.IsNullOrEmpty(base64))
                return string.Empty;

            return base64.Contains(",") ? base64.Split(',')[1] : base64;
        }
    }
}