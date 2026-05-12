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
    /// Interagit avec les APIs Business Central GasoilHeaderAPI (page 50150)
    /// et GasoilLinesAPI (page 50151) pour la gestion des fiches gasoil.
    /// </summary>
    public class GasoilService : BaseService, IGasoilService
    {
        private readonly HttpClient _httpClient;
        private readonly ILogger<GasoilService> _logger;

        // Options partagées : on n'envoie jamais de champs nuls à BC
        private static readonly JsonSerializerOptions _serializerOptions = new()
        {
            DefaultIgnoreCondition = JsonIgnoreCondition.WhenWritingNull
        };

        public GasoilService(HttpClient httpClient, ILogger<GasoilService> logger)
        {
            _httpClient = httpClient;
            _logger = logger;
        }

        private static JsonObject ToJsonObject<T>(T dto, JsonSerializerOptions o) =>
            (JsonSerializer.SerializeToNode(dto, o) as JsonObject) ?? new JsonObject();

        private static string MergeJobNoSerialize(GasoilHeaderCreateDto dto, string projectNo, JsonSerializerOptions o)
        {
            var root = ToJsonObject(dto, o);
            root["jobNo"] = projectNo;
            return root.ToJsonString();
        }

        private static string MergeProjectNoSerialize(GasoilLineCreateDto dto, string projectNo, JsonSerializerOptions o)
        {
            var root = ToJsonObject(dto, o);
            root["projectNo"] = projectNo;
            return root.ToJsonString();
        }

        // ── HELPERS PRIVÉS ────────────────────────────────────────────────────

        /// <summary>
        /// Récupère une fiche gasoil avec ses lignes et vérifie qu'elle appartient
        /// au projet du chef connecté.
        /// Lève <see cref="KeyNotFoundException"/> si introuvable.
        /// Lève <see cref="UnauthorizedAccessException"/> si le projet ne correspond pas.
        /// </summary>
        private async Task<(GasoilHeaderReadDto Header, string? ETag)> GetAndVerifyHeaderAsync(
            Guid id, string projectNo)
        {
            var response = await _httpClient.GetAsync($"gasoilHeaders({id})?$expand=gasoilLines");

            if (response.StatusCode == System.Net.HttpStatusCode.NotFound)
                throw new KeyNotFoundException($"La fiche gasoil '{id}' est introuvable dans Business Central.");

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            var header = await response.Content.ReadFromJsonAsync<GasoilHeaderReadDto>();

            if (header == null)
                throw new KeyNotFoundException($"La fiche gasoil '{id}' est introuvable dans Business Central.");

            if (!string.Equals(header.JobNo, projectNo, StringComparison.OrdinalIgnoreCase))
            {
                _logger.LogWarning(
                    "[Gasoil] Accès refusé : fiche {Id} appartient au projet {HeaderProject}, " +
                    "chef connecté au projet {UserProject}", id, header.JobNo, projectNo);
                throw new UnauthorizedAccessException(
                    "Accès refusé : cette fiche gasoil n'appartient pas à votre projet.");
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
        private async Task<(GasoilLineReadDto Line, string? ETag)> GetAndVerifyLineAsync(
            Guid lineId, string projectNo)
        {
            // 1. Récupérer la ligne et son ETag
            var lineResponse = await _httpClient.GetAsync($"gasoilLines({lineId})");

            if (lineResponse.StatusCode == System.Net.HttpStatusCode.NotFound)
                throw new KeyNotFoundException($"La ligne gasoil '{lineId}' est introuvable dans Business Central.");

            if (!lineResponse.IsSuccessStatusCode)
                await HandleErrorResponseAsync(lineResponse);

            var line = await lineResponse.Content.ReadFromJsonAsync<GasoilLineReadDto>();

            if (line == null || string.IsNullOrEmpty(line.DocumentNo))
                throw new KeyNotFoundException($"La ligne gasoil '{lineId}' est introuvable dans Business Central.");

            // 2. SÉCURITÉ : Récupérer le header parent pour valider le jobNo
            var headerFilter = $"$filter=documentNo eq '{line.DocumentNo}'";
            var headerResponse = await _httpClient.GetAsync($"gasoilHeaders?{headerFilter}");

            if (!headerResponse.IsSuccessStatusCode)
                await HandleErrorResponseAsync(headerResponse);

            var headerResult = await headerResponse.Content.ReadFromJsonAsync<BCResponse<GasoilHeaderReadDto>>();
            var header = headerResult?.Value?.FirstOrDefault();

            if (header == null)
                throw new KeyNotFoundException($"La fiche gasoil parente '{line.DocumentNo}' est introuvable dans Business Central.");

            if (!string.Equals(header.JobNo, projectNo, StringComparison.OrdinalIgnoreCase))
            {
                _logger.LogWarning(
                    "[Gasoil] Accès refusé ligne {LineId} : projet {HeaderProject} ≠ {UserProject}",
                    lineId, header.JobNo, projectNo);
                throw new UnauthorizedAccessException(
                    "Accès refusé : cette ligne n'appartient pas à votre projet.");
            }

            var etag = lineResponse.Headers.ETag?.ToString();
            return (line, etag);
        }

        // ── EN-TÊTES ──────────────────────────────────────────────────────────

        public async Task<IEnumerable<GasoilHeaderReadDto>> GetAllHeadersAsync(string projectNo)
        {
            var url = $"gasoilHeaders?$filter=jobNo eq '{projectNo}'";
            _logger.LogInformation("[Gasoil] GetAll pour projet {ProjectNo}", projectNo);

            var response = await _httpClient.GetAsync(url);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            var result = await response.Content.ReadFromJsonAsync<BCResponse<GasoilHeaderReadDto>>();
            return result?.Value ?? Enumerable.Empty<GasoilHeaderReadDto>();
        }

        public async Task<GasoilHeaderReadDto> GetHeaderByIdAsync(Guid id, string projectNo)
        {
            var (header, _) = await GetAndVerifyHeaderAsync(id, projectNo);
            return header;
        }

        public async Task<GasoilHeaderReadDto> CreateHeaderAsync(GasoilHeaderCreateDto headerDto, string projectNo)
        {
            var json    = MergeJobNoSerialize(headerDto, projectNo, _serializerOptions);
            var content = new StringContent(json, Encoding.UTF8, "application/json");

            _logger.LogInformation("[Gasoil] Création fiche pour projet {ProjectNo}", projectNo);

            var response = await _httpClient.PostAsync("gasoilHeaders", content);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            return (await response.Content.ReadFromJsonAsync<GasoilHeaderReadDto>())!;
        }

        public async Task<GasoilHeaderReadDto> PatchHeaderAsync(Guid id, GasoilHeaderPatchDto headerDto, string projectNo)
        {
            // SÉCURITÉ : vérifier appartenance + récupérer ETag
            var (_, etag) = await GetAndVerifyHeaderAsync(id, projectNo);

            var json = JsonSerializer.Serialize(headerDto, _serializerOptions);

            _logger.LogInformation("[Gasoil] PATCH fiche {Id} — Body: {Json}", id, json);

            var request = new HttpRequestMessage(new HttpMethod("PATCH"), $"gasoilHeaders({id})")
            {
                Content = new StringContent(json, Encoding.UTF8, "application/json")
            };
            request.Headers.TryAddWithoutValidation("If-Match", etag ?? "*");

            var response = await _httpClient.SendAsync(request);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            _logger.LogInformation("[Gasoil] PATCH fiche {Id} — Réponse: {Status}",
                id, (int)response.StatusCode);

            return (await response.Content.ReadFromJsonAsync<GasoilHeaderReadDto>())!;
        }

        public async Task<bool> DeleteHeaderAsync(Guid id, string projectNo)
        {
            // SÉCURITÉ : vérifier appartenance avant suppression
            var (_, etag) = await GetAndVerifyHeaderAsync(id, projectNo);

            var request = new HttpRequestMessage(HttpMethod.Delete, $"gasoilHeaders({id})");
            request.Headers.TryAddWithoutValidation("If-Match", etag ?? "*");

            var response = await _httpClient.SendAsync(request);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            _logger.LogInformation("[Gasoil] Fiche {Id} supprimée.", id);
            return true;
        }

        public async Task<bool> ValiderFicheAsync(Guid id, string projectNo)
        {
            // SÉCURITÉ : vérifier appartenance + validation métier
            var (existing, etag) = await GetAndVerifyHeaderAsync(id, projectNo);

            if (!string.Equals(existing.Status, "En Cours", StringComparison.OrdinalIgnoreCase))
                throw new InvalidOperationException(
                    $"Statut actuel '{existing.Status}' — seule une fiche 'En Cours' peut être validée.");

            var json = """{"status": "Valider"}""";
            var request = new HttpRequestMessage(new HttpMethod("PATCH"), $"gasoilHeaders({id})")
            {
                Content = new StringContent(json, Encoding.UTF8, "application/json")
            };
            request.Headers.TryAddWithoutValidation("If-Match", etag ?? "*");

            var response = await _httpClient.SendAsync(request);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            _logger.LogInformation("[Gasoil] Fiche {Id} validée.", id);
            return true;
        }

        // ── LIGNES ────────────────────────────────────────────────────────────

        public async Task<GasoilLineReadDto> CreateLineAsync(GasoilLineCreateDto lineDto, string projectNo)
        {
            // SÉCURITÉ : vérifier que le document parent appartient au projet du chef connecté
            if (string.IsNullOrWhiteSpace(lineDto.DocumentNo))
                throw new ArgumentException(
                    "Le numéro de document (documentNo) est obligatoire pour créer une ligne gasoil.");

            var headerFilter = $"$filter=documentNo eq '{lineDto.DocumentNo}'";
            var headerResponse = await _httpClient.GetAsync($"gasoilHeaders?{headerFilter}");

            if (!headerResponse.IsSuccessStatusCode)
                await HandleErrorResponseAsync(headerResponse);

            var headerResult = await headerResponse.Content.ReadFromJsonAsync<BCResponse<GasoilHeaderReadDto>>();
            var header = headerResult?.Value?.FirstOrDefault();

            if (header == null)
                throw new KeyNotFoundException(
                    $"La fiche gasoil '{lineDto.DocumentNo}' est introuvable dans Business Central.");

            if (!string.Equals(header.JobNo, projectNo, StringComparison.OrdinalIgnoreCase))
            {
                _logger.LogWarning(
                    "[Gasoil] Accès refusé création ligne : document {DocNo} appartient au projet {HeaderProject} ≠ {UserProject}",
                    lineDto.DocumentNo, header.JobNo, projectNo);
                throw new UnauthorizedAccessException(
                    "Accès refusé : cette fiche gasoil n'appartient pas à votre projet.");
            }

            var json    = MergeProjectNoSerialize(lineDto, projectNo, _serializerOptions);
            var content = new StringContent(json, Encoding.UTF8, "application/json");

            _logger.LogInformation("[Gasoil] Création ligne pour document {DocumentNo}", lineDto.DocumentNo);

            var response = await _httpClient.PostAsync("gasoilLines", content);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            return (await response.Content.ReadFromJsonAsync<GasoilLineReadDto>())!;
        }

        public async Task<GasoilLineReadDto> PatchLineAsync(Guid lineId, GasoilLinePatchDto lineDto, string projectNo)
        {
            // SÉCURITÉ : vérifier appartenance + récupérer ETag
            var (_, etag) = await GetAndVerifyLineAsync(lineId, projectNo);

            var json = JsonSerializer.Serialize(lineDto, _serializerOptions);

            _logger.LogInformation("[Gasoil] PATCH ligne {LineId} — Body: {Json}", lineId, json);

            var request = new HttpRequestMessage(new HttpMethod("PATCH"), $"gasoilLines({lineId})")
            {
                Content = new StringContent(json, Encoding.UTF8, "application/json")
            };
            request.Headers.TryAddWithoutValidation("If-Match", etag ?? "*");

            var response = await _httpClient.SendAsync(request);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            _logger.LogInformation("[Gasoil] PATCH ligne {LineId} — Réponse: {Status}",
                lineId, (int)response.StatusCode);

            return (await response.Content.ReadFromJsonAsync<GasoilLineReadDto>())!;
        }

        public async Task<bool> DeleteLineAsync(Guid lineId, string projectNo)
        {
            // SÉCURITÉ : vérifier appartenance avant suppression
            var (_, etag) = await GetAndVerifyLineAsync(lineId, projectNo);

            var request = new HttpRequestMessage(HttpMethod.Delete, $"gasoilLines({lineId})");
            request.Headers.TryAddWithoutValidation("If-Match", etag ?? "*");

            var response = await _httpClient.SendAsync(request);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            _logger.LogInformation("[Gasoil] Ligne {LineId} supprimée.", lineId);
            return true;
        }

        // ── USAGE INTERNE (AlertService) ──────────────────────────────────────

        public async Task<IEnumerable<GasoilHeaderReadDto>> GetAllHeadersWithLinesAsync(string projectNo)
        {
            var url = $"gasoilHeaders?$filter=jobNo eq '{projectNo}'&$expand=gasoilLines";
            _logger.LogInformation("[Gasoil] GetAllWithLines pour projet {ProjectNo}", projectNo);

            var response = await _httpClient.GetAsync(url);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            var result = await response.Content.ReadFromJsonAsync<BCResponse<GasoilHeaderReadDto>>();
            return result?.Value ?? Enumerable.Empty<GasoilHeaderReadDto>();
        }
    }
}