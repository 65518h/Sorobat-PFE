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

        public GasoilService(HttpClient httpClient, ILogger<GasoilService> logger)
        {
            _httpClient = httpClient;
            _logger     = logger;
        }


        /// <summary>
        /// Sérialise un DTO en JsonObject pour permettre l'injection de champs supplémentaires
        /// avant la sérialisation finale (ex : jobNo forcé depuis le JWT).
        /// </summary>
        private static JsonObject ToJsonObject<T>(T dto)
        {
            var node = JsonSerializer.SerializeToNode(dto, SerializerOptionsWrite);
            return (node as JsonObject) ?? new JsonObject();
        }

        /// <summary>
        /// Ajoute jobNo au DTO d'en-tête et retourne le JSON final prêt à envoyer à BC.
        /// </summary>
        private static string MergeJobNoAndSerialize(GasoilHeaderCreateDto dto, string projectNo)
        {
            var root = ToJsonObject(dto);
            root["jobNo"] = projectNo;
            return root.ToJsonString();
        }

        /// <summary>
        /// Ajoute projectNo et lineNo au DTO de ligne et retourne le JSON final.
        /// projectNo est forcé depuis le JWT — le client ne peut pas le fournir.
        /// lineNo est calculé par le backend (Max + 10 000).
        /// </summary>
        private static string MergeProjectNoLineNoAndSerialize(GasoilLineCreateDto dto, string projectNo, int lineNo)
        {
            var root = ToJsonObject(dto);
            root["projectNo"] = projectNo;
            root["lineNo"]    = lineNo;
            return root.ToJsonString();
        }


        /// <summary>
        /// Récupère un en-tête de fiche gasoil depuis BC, vérifie qu'il appartient au projet
        /// du chef connecté et retourne l'ETag pour les opérations PATCH / DELETE suivantes.
        /// Lève <see cref="KeyNotFoundException"/> si introuvable.
        /// Lève <see cref="UnauthorizedAccessException"/> si le projet ne correspond pas.
        /// </summary>
        private async Task<(GasoilHeaderReadDto Header, string? ETag)> GetAndVerifyHeaderAsync(
            Guid id, string projectNo)
        {
            var response = await _httpClient.GetAsync($"gasoilHeaders({id})");

            if (response.StatusCode == System.Net.HttpStatusCode.NotFound)
                throw new KeyNotFoundException(
                    $"La fiche gasoil '{id}' est introuvable dans Business Central.");

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            var header = await response.Content
                .ReadFromJsonAsync<GasoilHeaderReadDto>(SerializerOptionsRead);

            if (header == null)
                throw new KeyNotFoundException(
                    $"La fiche gasoil '{id}' est introuvable dans Business Central.");

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
        /// Récupère une ligne de fiche gasoil depuis BC, vérifie qu'elle appartient au projet
        /// du chef connecté via l'en-tête parent et retourne l'ETag pour les opérations PATCH / DELETE suivantes.
        /// Lève <see cref="KeyNotFoundException"/> si la ligne ou l'en-tête est introuvable.
        /// Lève <see cref="UnauthorizedAccessException"/> si le projet ne correspond pas.
        /// </summary>
        private async Task<(GasoilLineReadDto Line, string? ETag)> GetAndVerifyLineAsync(
            Guid lineId, string projectNo)
        {
            var lineResponse = await _httpClient.GetAsync($"gasoilLines({lineId})");

            if (lineResponse.StatusCode == System.Net.HttpStatusCode.NotFound)
                throw new KeyNotFoundException(
                    $"La ligne gasoil '{lineId}' est introuvable dans Business Central.");

            if (!lineResponse.IsSuccessStatusCode)
                await HandleErrorResponseAsync(lineResponse);

            var line = await lineResponse.Content
                .ReadFromJsonAsync<GasoilLineReadDto>(SerializerOptionsRead);

            if (line == null || string.IsNullOrEmpty(line.DocumentNo))
                throw new KeyNotFoundException(
                    $"La ligne gasoil '{lineId}' est introuvable dans Business Central.");

            var headerUrl      = $"gasoilHeaders?$filter=documentNo eq '{line.DocumentNo}'";
            var headerResponse = await _httpClient.GetAsync(headerUrl);

            if (!headerResponse.IsSuccessStatusCode)
                await HandleErrorResponseAsync(headerResponse);

            var headerResult = await headerResponse.Content
                .ReadFromJsonAsync<BCResponse<GasoilHeaderReadDto>>(SerializerOptionsRead);

            var header = headerResult?.Value?.FirstOrDefault();

            if (header == null)
                throw new KeyNotFoundException(
                    $"La fiche gasoil parente '{line.DocumentNo}' est introuvable dans Business Central.");

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

        /// <summary>
        /// Retourne le numéro de ligne le plus élevé pour un document donné.
        /// Utilisé pour calculer le prochain lineNo lors de la création de lignes (Max + 10 000).
        /// Retourne 0 si aucune ligne n'existe encore.
        /// </summary>
        private async Task<int> GetLastLineNoAsync(string documentNo)
        {
            var url = $"gasoilLines?$filter=documentNo eq '{documentNo}'" +
                      "&$orderby=lineNo desc&$top=1";

            var response = await _httpClient.GetAsync(url);

            if (!response.IsSuccessStatusCode)
                return 0;

            var content = await response.Content.ReadAsStringAsync();

            using var doc = JsonDocument.Parse(content);
            var root      = doc.RootElement.GetProperty("value");

            if (root.GetArrayLength() > 0)
                return root[0].GetProperty("lineNo").GetInt32();

            return 0;
        }

//métier
        public async Task<IEnumerable<GasoilHeaderReadDto>> GetAllHeadersAsync(string projectNo)
        {
            var url = $"gasoilHeaders?$filter=jobNo eq '{projectNo}'";
            _logger.LogInformation("[Gasoil] GetAll pour projet {ProjectNo}", projectNo);

            var response = await _httpClient.GetAsync(url);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            var result = await response.Content
                .ReadFromJsonAsync<BCResponse<GasoilHeaderReadDto>>(SerializerOptionsRead);

            return result?.Value ?? Enumerable.Empty<GasoilHeaderReadDto>();
        }

        public async Task<GasoilHeaderReadDto> GetHeaderByIdAsync(Guid id, string projectNo)
        {
            await GetAndVerifyHeaderAsync(id, projectNo);

            var url      = $"gasoilHeaders({id})?$expand=gasoilLines";
            var response = await _httpClient.GetAsync(url);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            return (await response.Content
                .ReadFromJsonAsync<GasoilHeaderReadDto>(SerializerOptionsRead))!;
        }

        public async Task<GasoilHeaderReadDto> CreateHeaderAsync(GasoilHeaderCreateDto headerDto, string projectNo)
        {
            var json    = MergeJobNoAndSerialize(headerDto, projectNo);
            var content = new StringContent(json, Encoding.UTF8, "application/json");

            _logger.LogInformation("[Gasoil] Création fiche pour projet {ProjectNo}", projectNo);

            var response = await _httpClient.PostAsync("gasoilHeaders", content);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            return (await response.Content
                .ReadFromJsonAsync<GasoilHeaderReadDto>(SerializerOptionsRead))!;
        }

        public async Task<GasoilHeaderReadDto> PatchHeaderAsync(Guid id, GasoilHeaderPatchDto headerDto, string projectNo)
        {
            var (_, etag) = await GetAndVerifyHeaderAsync(id, projectNo);

            var json = JsonSerializer.Serialize(headerDto, SerializerOptionsWrite);
            _logger.LogInformation("[Gasoil] PATCH fiche {Id}", id);

            var request = new HttpRequestMessage(new HttpMethod("PATCH"), $"gasoilHeaders({id})")
            {
                Content = new StringContent(json, Encoding.UTF8, "application/json")
            };
            request.Headers.TryAddWithoutValidation("If-Match", etag ?? "*");

            var response = await _httpClient.SendAsync(request);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            _logger.LogInformation("[Gasoil] PATCH fiche {Id} — Réponse : {Status}",
                id, (int)response.StatusCode);

            return (await response.Content
                .ReadFromJsonAsync<GasoilHeaderReadDto>(SerializerOptionsRead))!;
        }

        public async Task<bool> DeleteHeaderAsync(Guid id, string projectNo)
        {
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
            var (existing, etag) = await GetAndVerifyHeaderAsync(id, projectNo);

            if (!string.Equals(existing.Status, "En Cours", StringComparison.OrdinalIgnoreCase))
                throw new InvalidOperationException(
                    $"Statut actuel '{existing.Status}' — seule une fiche 'En Cours' peut être validée.");

            var json    = """{"status": "Valider"}""";
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


        public async Task<GasoilLineReadDto> CreateLineAsync(GasoilLineCreateDto lineDto, string projectNo)
        {
            if (string.IsNullOrWhiteSpace(lineDto.DocumentNo))
                throw new ArgumentException(
                    "Le numéro de document (documentNo) est obligatoire pour créer une ligne gasoil.");

            var headerUrl      = $"gasoilHeaders?$filter=documentNo eq '{lineDto.DocumentNo}'";
            var headerResponse = await _httpClient.GetAsync(headerUrl);

            if (!headerResponse.IsSuccessStatusCode)
                await HandleErrorResponseAsync(headerResponse);

            var headerResult = await headerResponse.Content
                .ReadFromJsonAsync<BCResponse<GasoilHeaderReadDto>>(SerializerOptionsRead);

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

            int currentMaxLineNo = await GetLastLineNoAsync(lineDto.DocumentNo);
            currentMaxLineNo += 10000;

            var json    = MergeProjectNoLineNoAndSerialize(lineDto, projectNo, currentMaxLineNo);
            var content = new StringContent(json, Encoding.UTF8, "application/json");

            _logger.LogInformation("[Gasoil] Création ligne {DocNo} / LineNo {LineNo}",
                lineDto.DocumentNo, currentMaxLineNo);

            var response = await _httpClient.PostAsync("gasoilLines", content);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            return (await response.Content
                .ReadFromJsonAsync<GasoilLineReadDto>(SerializerOptionsRead))!;
        }

        public async Task<GasoilLineReadDto> PatchLineAsync(Guid lineId, GasoilLinePatchDto lineDto, string projectNo)
        {
            var (_, etag) = await GetAndVerifyLineAsync(lineId, projectNo);

            var json = JsonSerializer.Serialize(lineDto, SerializerOptionsWrite);
            _logger.LogInformation("[Gasoil] PATCH ligne {LineId}", lineId);

            var request = new HttpRequestMessage(new HttpMethod("PATCH"), $"gasoilLines({lineId})")
            {
                Content = new StringContent(json, Encoding.UTF8, "application/json")
            };
            request.Headers.TryAddWithoutValidation("If-Match", etag ?? "*");

            var response = await _httpClient.SendAsync(request);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            _logger.LogInformation("[Gasoil] PATCH ligne {LineId} — Réponse : {Status}",
                lineId, (int)response.StatusCode);

            return (await response.Content
                .ReadFromJsonAsync<GasoilLineReadDto>(SerializerOptionsRead))!;
        }

        public async Task<bool> DeleteLineAsync(Guid lineId, string projectNo)
        {
            var (_, etag) = await GetAndVerifyLineAsync(lineId, projectNo);

            var request = new HttpRequestMessage(HttpMethod.Delete, $"gasoilLines({lineId})");
            request.Headers.TryAddWithoutValidation("If-Match", etag ?? "*");

            var response = await _httpClient.SendAsync(request);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            _logger.LogInformation("[Gasoil] Ligne {LineId} supprimée.", lineId);
            return true;
        }

// utilisée pour la partie alertes
        public async Task<IEnumerable<GasoilHeaderReadDto>> GetAllHeadersWithLinesAsync(string projectNo)
        {
            var url = $"gasoilHeaders?$filter=jobNo eq '{projectNo}'&$expand=gasoilLines";
            _logger.LogInformation("[Gasoil] GetAllWithLines pour projet {ProjectNo}", projectNo);

            var response = await _httpClient.GetAsync(url);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            var result = await response.Content
                .ReadFromJsonAsync<BCResponse<GasoilHeaderReadDto>>(SerializerOptionsRead);

            return result?.Value ?? Enumerable.Empty<GasoilHeaderReadDto>();
        }
    }
}