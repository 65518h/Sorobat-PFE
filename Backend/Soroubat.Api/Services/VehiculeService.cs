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

        // Options partagées : on n'envoie jamais de champs nuls à BC
        private static readonly JsonSerializerOptions _serializerOptions = new()
        {
            DefaultIgnoreCondition = JsonIgnoreCondition.WhenWritingNull
        };

        public VehiculeService(HttpClient httpClient, ILogger<VehiculeService> logger)
        {
            _httpClient = httpClient;
            _logger = logger;
        }

        // ── HELPERS PRIVÉS ────────────────────────────────────────────────────

        /// <summary>
        /// Récupère un en-tête avec ses lignes et vérifie qu'il appartient au projet du chef connecté.
        /// Lève <see cref="KeyNotFoundException"/> si introuvable.
        /// Lève <see cref="UnauthorizedAccessException"/> si le projet ne correspond pas.
        /// </summary>
        private async Task<(VehiculePointageHeaderReadDto Header, string? ETag)> GetAndVerifyHeaderAsync(
            Guid id, string projectNo)
        {
            var response = await _httpClient.GetAsync($"vehiculePointageHeaders({id})?$expand=vehiculePointageLines");

            if (response.StatusCode == System.Net.HttpStatusCode.NotFound)
                throw new KeyNotFoundException($"Le pointage '{id}' est introuvable dans Business Central.");

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            var header = await response.Content.ReadFromJsonAsync<VehiculePointageHeaderReadDto>();

            if (header == null)
                throw new KeyNotFoundException($"Le pointage '{id}' est introuvable dans Business Central.");

            if (!string.Equals(header.JobNo, projectNo, StringComparison.OrdinalIgnoreCase))
            {
                _logger.LogWarning(
                    "[Vehicule] Accès refusé : pointage {Id} appartient au projet {HeaderProject}, " +
                    "chef connecté au projet {UserProject}", id, header.JobNo, projectNo);
                throw new UnauthorizedAccessException(
                    "Accès refusé : ce pointage n'appartient pas à votre projet.");
            }

            var etag = response.Headers.ETag?.ToString();
            return (header, etag);
        }

        /// <summary>
        /// Récupère une ligne et vérifie qu'elle appartient au projet du chef connecté
        /// via le header parent.
        /// Lève <see cref="KeyNotFoundException"/> si introuvable.
        /// Lève <see cref="UnauthorizedAccessException"/> si le projet ne correspond pas.
        /// </summary>
        private async Task<(VehiculePointageLineReadDto Line, string? ETag)> GetAndVerifyLineAsync(
            Guid lineId, string projectNo)
        {
            // 1. Récupérer la ligne et son ETag
            var lineResponse = await _httpClient.GetAsync($"vehiculePointageLines({lineId})");

            if (lineResponse.StatusCode == System.Net.HttpStatusCode.NotFound)
                throw new KeyNotFoundException($"La ligne de pointage '{lineId}' est introuvable dans Business Central.");

            if (!lineResponse.IsSuccessStatusCode)
                await HandleErrorResponseAsync(lineResponse);

            var line = await lineResponse.Content.ReadFromJsonAsync<VehiculePointageLineReadDto>();

            if (line == null || string.IsNullOrEmpty(line.DocumentNo))
                throw new KeyNotFoundException($"La ligne de pointage '{lineId}' est introuvable dans Business Central.");

            // 2. SÉCURITÉ : Récupérer le header parent pour valider le jobNo
            var headerFilter = $"$filter=documentNo eq '{line.DocumentNo}'";
            var headerResponse = await _httpClient.GetAsync($"vehiculePointageHeaders?{headerFilter}");

            if (!headerResponse.IsSuccessStatusCode)
                await HandleErrorResponseAsync(headerResponse);

            var headerResult = await headerResponse.Content.ReadFromJsonAsync<BCResponse<VehiculePointageHeaderReadDto>>();
            var header = headerResult?.Value?.FirstOrDefault();

            if (header == null)
                throw new KeyNotFoundException($"Le pointage parent '{line.DocumentNo}' est introuvable dans Business Central.");

            if (!string.Equals(header.JobNo, projectNo, StringComparison.OrdinalIgnoreCase))
            {
                _logger.LogWarning(
                    "[Vehicule] Accès refusé ligne {LineId} : projet {HeaderProject} ≠ {UserProject}",
                    lineId, header.JobNo, projectNo);
                throw new UnauthorizedAccessException(
                    "Accès refusé : cette ligne n'appartient pas à votre projet.");
            }

            var etag = lineResponse.Headers.ETag?.ToString();
            return (line, etag);
        }

        // ── EN-TÊTES ──────────────────────────────────────────────────────────

        public async Task<IEnumerable<VehiculePointageHeaderReadDto>> GetAllHeadersAsync(string projectNo)
        {
            var url = $"vehiculePointageHeaders?$filter=jobNo eq '{projectNo}'";
            _logger.LogInformation("[Vehicule] GetAll pour projet {ProjectNo}", projectNo);

            var response = await _httpClient.GetAsync(url);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            var result = await response.Content.ReadFromJsonAsync<BCResponse<VehiculePointageHeaderReadDto>>();
            return result?.Value ?? Enumerable.Empty<VehiculePointageHeaderReadDto>();
        }

        public async Task<VehiculePointageHeaderReadDto> GetHeaderByIdAsync(Guid id, string projectNo)
        {
            var (header, _) = await GetAndVerifyHeaderAsync(id, projectNo);
            return header;
        }

        public async Task<VehiculePointageHeaderReadDto> CreateHeaderAsync(
            VehiculePointageHeaderCreateDto headerDto, string projectNo)
        {
            var dateAEnvoyer = headerDto.Date;

            // ÉTAPE 1 : POST avec jobNo uniquement (sans date) — voir commentaires AL ci-dessous.
            var jsonPost = new JsonObject { ["jobNo"] = projectNo }.ToJsonString();
            var contentPost = new StringContent(jsonPost, Encoding.UTF8, "application/json");

            _logger.LogInformation("[Vehicule] Création en-tête (étape 1/2 — sans date) pour projet {ProjectNo}",
                projectNo);

            var postResponse = await _httpClient.PostAsync("vehiculePointageHeaders", contentPost);

            if (!postResponse.IsSuccessStatusCode)
                await HandleErrorResponseAsync(postResponse);

            var createdHeader = await postResponse.Content.ReadFromJsonAsync<VehiculePointageHeaderReadDto>();

            if (createdHeader?.Id == null)
                throw new InvalidOperationException(
                    "Business Central n'a pas retourné l'identifiant du pointage créé.");

            // ── ÉTAPE 2 : PATCH avec la date ─────────────────────────────────
            // Ce PATCH déclenche le trigger OnValidate de Journee côté AL,
            // qui efface les éventuelles lignes existantes puis génère une ligne
            // par véhicule actif (Bloquer = false, Statut > 0) affecté au chantier.
            var etag = postResponse.Headers.ETag?.ToString();
            var patchPayload = new { date = dateAEnvoyer };
            var jsonPatch = JsonSerializer.Serialize(patchPayload);
            var patchRequest = new HttpRequestMessage(
                new HttpMethod("PATCH"), $"vehiculePointageHeaders({createdHeader.Id})")
            {
                Content = new StringContent(jsonPatch, Encoding.UTF8, "application/json")
            };
            patchRequest.Headers.TryAddWithoutValidation("If-Match", etag ?? "*");

            _logger.LogInformation(
                "[Vehicule] Création en-tête (étape 2/2 — PATCH date {Date}) pour document {DocumentNo}",
                dateAEnvoyer, createdHeader.DocumentNo);

            var patchResponse = await _httpClient.SendAsync(patchRequest);

            if (!patchResponse.IsSuccessStatusCode)
                await HandleErrorResponseAsync(patchResponse);

            // Retourner le header complet avec ses lignes générées par BC
            return await GetHeaderByIdAsync(createdHeader.Id.Value, projectNo);
        }

        public async Task<bool> DeleteHeaderAsync(Guid id, string projectNo)
        {
            // SÉCURITÉ : vérifier appartenance avant suppression
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
            // SÉCURITÉ : vérifier appartenance + validation métier
            var (existing, etag) = await GetAndVerifyHeaderAsync(id, projectNo);

            if (!string.Equals(existing.Status, "Ouvert", StringComparison.OrdinalIgnoreCase))
                throw new InvalidOperationException(
                    $"Statut actuel '{existing.Status}' — seul un pointage 'Ouvert' peut être validé.");

            var json = """{"status": "Validé"}""";
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

        // ── LIGNES ────────────────────────────────────────────────────────────

        public async Task<VehiculePointageLineReadDto> PatchLineAsync(
            Guid lineId, VehiculePointageLinePatchDto lineDto, string projectNo)
        {
            // SÉCURITÉ : vérifier appartenance + récupérer ETag
            var (_, etag) = await GetAndVerifyLineAsync(lineId, projectNo);

            var json = JsonSerializer.Serialize(lineDto, _serializerOptions);

            _logger.LogInformation("[Vehicule] PATCH ligne {LineId} — Body: {Json}", lineId, json);

            var request = new HttpRequestMessage(new HttpMethod("PATCH"), $"vehiculePointageLines({lineId})")
            {
                Content = new StringContent(json, Encoding.UTF8, "application/json")
            };
            request.Headers.TryAddWithoutValidation("If-Match", etag ?? "*");

            var response = await _httpClient.SendAsync(request);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            _logger.LogInformation("[Vehicule] PATCH ligne {LineId} — Réponse: {Status}",
                lineId, (int)response.StatusCode);

            return (await response.Content.ReadFromJsonAsync<VehiculePointageLineReadDto>())!;
        }

        // ── USAGE INTERNE (AlertService) ──────────────────────────────────────

        public async Task<IEnumerable<VehiculePointageHeaderReadDto>> GetAllHeadersWithLinesAsync(string projectNo)
        {
            var url = $"vehiculePointageHeaders?$filter=jobNo eq '{projectNo}'&$expand=vehiculePointageLines";
            _logger.LogInformation("[Vehicule] GetAllWithLines pour projet {ProjectNo}", projectNo);

            var response = await _httpClient.GetAsync(url);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            var result = await response.Content.ReadFromJsonAsync<BCResponse<VehiculePointageHeaderReadDto>>();
            return result?.Value ?? Enumerable.Empty<VehiculePointageHeaderReadDto>();
        }
    }
}