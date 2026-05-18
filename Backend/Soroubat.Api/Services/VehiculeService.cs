using System.Net.Http.Json;
using System.Text;
using System.Text.Json;
using System.Text.Json.Nodes;
using System.Text.Json.Serialization;
using Soroubat.Api.Interfaces;
using Soroubat.Api.Models;

namespace Soroubat.Api.Services
{
    /// <summary>
    /// Interagit avec les APIs Business Central VehiculePointageHeaderAPI (page 50148)
    /// et VehiculePointageLineAPI (page 50149) pour la gestion des pointages véhicule.
    /// </summary>
    public class VehiculeService : BaseService, IVehiculeService
    {
        private readonly HttpClient _httpClient;
        private readonly ILogger<VehiculeService> _logger;

        /// <summary>Sérialisation en écriture : ignore les propriétés null pour ne pas écraser les valeurs BC.</summary>
        private static readonly JsonSerializerOptions SerializerOptionsWrite = new()
        {
            DefaultIgnoreCondition = JsonIgnoreCondition.WhenWritingNull
        };

        /// <summary>Désérialisation en lecture : insensible à la casse, nommage camelCase.</summary>
        private static readonly JsonSerializerOptions SerializerOptionsRead = new()
        {
            PropertyNameCaseInsensitive = true,
            PropertyNamingPolicy        = JsonNamingPolicy.CamelCase
        };

        public VehiculeService(HttpClient httpClient, ILogger<VehiculeService> logger)
        {
            _httpClient = httpClient;
            _logger     = logger;
        }

        // ── Méthodes helper de vérification ──────────────────────────────────

        /// <summary>
        /// Récupère un en-tête de pointage depuis BC, vérifie qu'il appartient au projet
        /// du chef connecté et retourne l'ETag pour les opérations PATCH / DELETE suivantes.
        /// Lève <see cref="KeyNotFoundException"/> si introuvable.
        /// Lève <see cref="UnauthorizedAccessException"/> si le projet ne correspond pas.
        /// </summary>
        private async Task<(VehiculePointageHeaderReadDto Header, string? ETag)> GetAndVerifyHeaderAsync(
            Guid id, string projectNo)
        {
            var response = await _httpClient.GetAsync($"vehiculePointageHeaders({id})");

            if (response.StatusCode == System.Net.HttpStatusCode.NotFound)
                throw new KeyNotFoundException(
                    $"Le pointage '{id}' est introuvable dans Business Central.");

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            var header = await response.Content
                .ReadFromJsonAsync<VehiculePointageHeaderReadDto>(SerializerOptionsRead);

            if (header == null)
                throw new KeyNotFoundException(
                    $"Le pointage '{id}' est introuvable dans Business Central.");

            if (!string.Equals(header.JobNo, projectNo, StringComparison.OrdinalIgnoreCase))
            {
                _logger.LogWarning(
                    "[Vehicule] Accès refusé en-tête {Id} : jobNo {HeaderProject} ≠ {UserProject}",
                    id, header.JobNo, projectNo);
                throw new UnauthorizedAccessException(
                    "Accès refusé : ce pointage n'appartient pas à votre projet.");
            }

            var etag = response.Headers.ETag?.ToString();
            return (header, etag);
        }

        /// <summary>
        /// Récupère une ligne de pointage depuis BC, vérifie qu'elle appartient au projet
        /// du chef connecté via l'en-tête parent et retourne l'ETag pour les opérations PATCH suivantes.
        /// Lève <see cref="KeyNotFoundException"/> si la ligne ou l'en-tête est introuvable.
        /// Lève <see cref="UnauthorizedAccessException"/> si le projet ne correspond pas.
        /// </summary>
        private async Task<(VehiculePointageLineReadDto Line, string? ETag)> GetAndVerifyLineAsync(
            Guid lineId, string projectNo)
        {
            var lineResponse = await _httpClient.GetAsync($"vehiculePointageLines({lineId})");

            if (lineResponse.StatusCode == System.Net.HttpStatusCode.NotFound)
                throw new KeyNotFoundException(
                    $"La ligne de pointage '{lineId}' est introuvable dans Business Central.");

            if (!lineResponse.IsSuccessStatusCode)
                await HandleErrorResponseAsync(lineResponse);

            var line = await lineResponse.Content
                .ReadFromJsonAsync<VehiculePointageLineReadDto>(SerializerOptionsRead);

            if (line == null || string.IsNullOrEmpty(line.DocumentNo))
                throw new KeyNotFoundException(
                    $"La ligne de pointage '{lineId}' est introuvable dans Business Central.");

            // Vérification de sécurité via l'en-tête parent
            var headerUrl      = $"vehiculePointageHeaders?$filter=documentNo eq '{line.DocumentNo}'";
            var headerResponse = await _httpClient.GetAsync(headerUrl);

            if (!headerResponse.IsSuccessStatusCode)
                await HandleErrorResponseAsync(headerResponse);

            var headerResult = await headerResponse.Content
                .ReadFromJsonAsync<BCResponse<VehiculePointageHeaderReadDto>>(SerializerOptionsRead);

            var header = headerResult?.Value?.FirstOrDefault();

            if (header == null)
                throw new KeyNotFoundException(
                    $"Le pointage parent '{line.DocumentNo}' est introuvable dans Business Central.");

            if (!string.Equals(header.JobNo, projectNo, StringComparison.OrdinalIgnoreCase))
            {
                _logger.LogWarning(
                    "[Vehicule] Accès refusé ligne {LineId} : jobNo {HeaderProject} ≠ {UserProject}",
                    lineId, header.JobNo, projectNo);
                throw new UnauthorizedAccessException(
                    "Accès refusé : cette ligne n'appartient pas à votre projet.");
            }

            var etag = lineResponse.Headers.ETag?.ToString();
            return (line, etag);
        }

        // ── Méthodes métier ───────────────────────────────────────────────────

        public async Task<IEnumerable<VehiculePointageHeaderReadDto>> GetAllHeadersAsync(string projectNo)
        {
            var url = $"vehiculePointageHeaders?$filter=jobNo eq '{projectNo}'";
            _logger.LogInformation("[Vehicule] GetAll pour projet {ProjectNo}", projectNo);

            var response = await _httpClient.GetAsync(url);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            var result = await response.Content
                .ReadFromJsonAsync<BCResponse<VehiculePointageHeaderReadDto>>(SerializerOptionsRead);

            return result?.Value ?? Enumerable.Empty<VehiculePointageHeaderReadDto>();
        }

        public async Task<VehiculePointageHeaderReadDto> GetHeaderByIdWithLinesAsync(Guid id, string projectNo)
        {
            // Vérification de sécurité sur l'en-tête seul (sans lignes)
            await GetAndVerifyHeaderAsync(id, projectNo);

            // Appel ciblé avec $expand pour retourner les lignes au client
            var url      = $"vehiculePointageHeaders({id})?$expand=vehiculePointageLines";
            var response = await _httpClient.GetAsync(url);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            return (await response.Content
                .ReadFromJsonAsync<VehiculePointageHeaderReadDto>(SerializerOptionsRead))!;
        }

        public async Task<VehiculePointageHeaderReadDto> CreateHeaderAsync(
            VehiculePointageHeaderCreateDto headerDto, string projectNo)
        {
            // ── ÉTAPE 1 : POST avec jobNo uniquement ─────────────────────────
            // La date est envoyée séparément dans un second PATCH car le trigger OnValidate
            // de Journee côté AL génère les lignes véhicule — ce trigger ne se déclenche
            // pas lors de l'insertion initiale.
            var jsonPost    = new JsonObject { ["jobNo"] = projectNo }.ToJsonString();
            var contentPost = new StringContent(jsonPost, Encoding.UTF8, "application/json");

            _logger.LogInformation(
                "[Vehicule] Création en-tête (étape 1/2 — sans date) pour projet {ProjectNo}", projectNo);

            var postResponse = await _httpClient.PostAsync("vehiculePointageHeaders", contentPost);

            if (!postResponse.IsSuccessStatusCode)
                await HandleErrorResponseAsync(postResponse);

            var createdHeader = await postResponse.Content
                .ReadFromJsonAsync<VehiculePointageHeaderReadDto>(SerializerOptionsRead);

            if (createdHeader?.Id == null)
                throw new InvalidOperationException(
                    "Business Central n'a pas retourné l'identifiant du pointage créé.");

            // ── ÉTAPE 2 : PATCH avec la date ─────────────────────────────────
            // Ce PATCH déclenche le trigger OnValidate de Journee côté AL,
            // qui efface les éventuelles lignes existantes puis génère une ligne
            // par véhicule actif (Bloquer = false) affecté au chantier.
            var etag         = postResponse.Headers.ETag?.ToString();
            var patchPayload = new JsonObject { ["date"] = headerDto.Date };
            var jsonPatch    = patchPayload.ToJsonString();

            var patchRequest = new HttpRequestMessage(
                new HttpMethod("PATCH"), $"vehiculePointageHeaders({createdHeader.Id})")
            {
                Content = new StringContent(jsonPatch, Encoding.UTF8, "application/json")
            };
            patchRequest.Headers.TryAddWithoutValidation("If-Match", etag ?? "*");

            _logger.LogInformation(
                "[Vehicule] Création en-tête (étape 2/2 — PATCH date {Date}) pour document {DocumentNo}",
                headerDto.Date, createdHeader.DocumentNo);

            var patchResponse = await _httpClient.SendAsync(patchRequest);

            if (!patchResponse.IsSuccessStatusCode)
                await HandleErrorResponseAsync(patchResponse);

            // Retourner l'en-tête complet avec les lignes générées par BC
            return await GetHeaderByIdWithLinesAsync(createdHeader.Id.Value, projectNo);
        }

        public async Task<bool> DeleteHeaderAsync(Guid id, string projectNo)
        {
            var (_, etag) = await GetAndVerifyHeaderAsync(id, projectNo);

            var request = new HttpRequestMessage(HttpMethod.Delete, $"vehiculePointageHeaders({id})");
            request.Headers.TryAddWithoutValidation("If-Match", etag ?? "*");

            var response = await _httpClient.SendAsync(request);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            _logger.LogInformation("[Vehicule] Pointage {Id} supprimé.", id);
            return true;
        }

        public async Task<bool> ValiderPointageAsync(Guid id, string projectNo)
        {
            var (existing, etag) = await GetAndVerifyHeaderAsync(id, projectNo);

            if (!string.Equals(existing.Status, "Ouvert", StringComparison.OrdinalIgnoreCase))
                throw new InvalidOperationException(
                    $"Statut actuel '{existing.Status}' — seul un pointage 'Ouvert' peut être validé.");

            // On ne modifie que le statut — les autres champs ne sont pas envoyés
            var json    = """{"status": "Validé"}""";
            var request = new HttpRequestMessage(new HttpMethod("PATCH"), $"vehiculePointageHeaders({id})")
            {
                Content = new StringContent(json, Encoding.UTF8, "application/json")
            };
            request.Headers.TryAddWithoutValidation("If-Match", etag ?? "*");

            var response = await _httpClient.SendAsync(request);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            _logger.LogInformation("[Vehicule] Pointage {Id} validé.", id);
            return true;
        }

        // ── Lignes ────────────────────────────────────────────────────────────

        public async Task<VehiculePointageLineReadDto> PatchLineAsync(
            Guid lineId, VehiculePointageLinePatchDto lineDto, string projectNo)
        {
            var (_, etag) = await GetAndVerifyLineAsync(lineId, projectNo);

            // marche (jobNo de la ligne) est forcé côté AL — non envoyé dans le PATCH.
            // Seuls les champs du PatchDto (saisie chef) sont transmis à BC.
            var json    = JsonSerializer.Serialize(lineDto, SerializerOptionsWrite);
            var request = new HttpRequestMessage(new HttpMethod("PATCH"), $"vehiculePointageLines({lineId})")
            {
                Content = new StringContent(json, Encoding.UTF8, "application/json")
            };
            request.Headers.TryAddWithoutValidation("If-Match", etag ?? "*");

            _logger.LogInformation("[Vehicule] PATCH ligne {LineId}", lineId);

            var response = await _httpClient.SendAsync(request);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            _logger.LogInformation("[Vehicule] PATCH ligne {LineId} — Réponse : {Status}",
                lineId, (int)response.StatusCode);

            return (await response.Content
                .ReadFromJsonAsync<VehiculePointageLineReadDto>(SerializerOptionsRead))!;
        }

        // ── Usage interne (AlertService) ──────────────────────────────────────

        public async Task<IEnumerable<VehiculePointageHeaderReadDto>> GetAllHeadersWithLinesAsync(string projectNo)
        {
            var url = $"vehiculePointageHeaders?$filter=jobNo eq '{projectNo}'&$expand=vehiculePointageLines";
            _logger.LogInformation("[Vehicule] GetAllWithLines pour projet {ProjectNo}", projectNo);

            var response = await _httpClient.GetAsync(url);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            var result = await response.Content
                .ReadFromJsonAsync<BCResponse<VehiculePointageHeaderReadDto>>(SerializerOptionsRead);

            return result?.Value ?? Enumerable.Empty<VehiculePointageHeaderReadDto>();
        }
    }
}