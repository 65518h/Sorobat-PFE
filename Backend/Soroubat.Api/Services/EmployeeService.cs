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
    /// </summary>
    public class EmployeeService : BaseService, IEmployeeService
    {
        private readonly HttpClient _httpClient;
        private readonly ILogger<EmployeeService> _logger;
        private readonly string _modelsPath;

        public EmployeeService(HttpClient httpClient, ILogger<EmployeeService> logger, IWebHostEnvironment env)
        {
            _httpClient = httpClient;
            _logger = logger;
            // Chemin vers les modèles de reconnaissance faciale (.dat)
            // À télécharger depuis dlib et placer dans le dossier Models/FaceRef du projet
            _modelsPath = Path.Combine(env.ContentRootPath, "Models", "FaceRef");
        }


        public async Task<JsonElement> GetEmployeesAsync(
            string? numProjet = null, string? filter = null, int? top = null)
        {
            var queryParams = new List<string>();
            var filters = new List<string>();

            if (!string.IsNullOrEmpty(numProjet))
                filters.Add($"chantier eq '{numProjet}'");

            if (!string.IsNullOrEmpty(filter))
                filters.Add(filter);

            if (filters.Any())
                queryParams.Add($"$filter={string.Join(" and ", filters)}");

            if (top.HasValue)
                queryParams.Add($"$top={top.Value}");

            var requestUri = "employees";
            if (queryParams.Any())
                requestUri += "?" + string.Join("&", queryParams);

            _logger.LogInformation("[Employee] GetEmployees — URL: {Url}", requestUri);

            var response = await _httpClient.GetAsync(requestUri);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            return await response.Content.ReadFromJsonAsync<JsonElement>();
        }


        public async Task<bool> VerifyFaceAsync(FaceVerificationPostDto request, string? numProjet)
        {
            try
            {
                // 1. Récupérer la photo de référence du salarié depuis BC
                var filter = $"matricule eq '{request.Matricule}'";
                // var employeeData = await GetEmployeesAsync(numProjet, filter, top: 1);
                var employeeData = await GetEmployeesAsync(null, filter, top: 1);

                if (!employeeData.TryGetProperty("value", out var employees)
                    || employees.GetArrayLength() == 0)
                {
                    _logger.LogWarning("[Employee] Salarié introuvable pour le matricule {Matricule}",
                        request.Matricule);
                    return false;
                }

                var bcBase64 = employees[0].GetProperty("imageBase64").GetString();
                if (string.IsNullOrEmpty(bcBase64))
                {
                    _logger.LogWarning("[Employee] Pas de photo de référence pour le matricule {Matricule}",
                        request.Matricule);
                    return false;
                }

                // 2. Nettoyer les chaînes Base64 (suppression du header data:image/... si présent)
                var cleanCaptured  = CleanBase64(request.CapturedImageBase64);
                var cleanReference = CleanBase64(bcBase64);

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

        private bool CompareImages(string capturedBase64, string referenceBase64)
        {
            // Initialisation du moteur avec le chemin des modèles (.dat)
            using var fr = FaceRecognition.Create(_modelsPath);

            // Décodage des chaînes Base64 en tableaux d'octets
            byte[] capturedBytes  = Convert.FromBase64String(capturedBase64);
            byte[] referenceBytes = Convert.FromBase64String(referenceBase64);

            // Conversion byte[] → MemoryStream → Bitmap → FaceRecognition Image
            using var msCaptured    = new MemoryStream(capturedBytes);
            using var bitmapCaptured = new Bitmap(msCaptured);
            using var imgCaptured   = FaceRecognition.LoadImage(bitmapCaptured);

            using var msReference    = new MemoryStream(referenceBytes);
            using var bitmapReference = new Bitmap(msReference);
            using var imgReference   = FaceRecognition.LoadImage(bitmapReference);

            // Extraction des caractéristiques faciales (encodings)
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

        private static string CleanBase64(string? base64)
        {
            if (string.IsNullOrEmpty(base64))
                return string.Empty;

            return base64.Contains(",") ? base64.Split(',')[1] : base64;
        }
    }
}