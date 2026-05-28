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
    /// Interagit avec les APIs Business Central PurchaseRequestAPI et PurchaseRequestLineAPI.
    /// </summary>
    public class PurchaseRequestService : BaseService, IPurchaseRequestService
    {
        private readonly HttpClient _httpClient;
        private readonly ILogger<PurchaseRequestService> _logger;

        // les régels de sérialisation
        /// <summary>Sérialisation en écriture : ignore les propriétés null pour ne pas écraser les valeurs BC.</summary>
        private static readonly JsonSerializerOptions SerializerOptionsWrite = new()
        {
            DefaultIgnoreCondition = JsonIgnoreCondition.WhenWritingNull
        };

        /// <summary>Désérialisation en lecture : insensible à la casse, nommage camelCase.</summary>
        private static readonly JsonSerializerOptions SerializerOptionsRead = new()
        {
            PropertyNameCaseInsensitive  = true,
            PropertyNamingPolicy         = JsonNamingPolicy.CamelCase
        };

        public PurchaseRequestService(HttpClient httpClient, ILogger<PurchaseRequestService> logger)
        {
            _httpClient = httpClient;
            _logger     = logger;
        }

        
        // helpers
        /// <summary>
        /// Récupère un en-tête de demande d'achat depuis BC, vérifie qu'il appartient au projet
        /// du chef connecté et retourne l'ETag pour les opérations PATCH / DELETE suivantes.
        /// Lève <see cref="KeyNotFoundException"/> si introuvable.
        /// Lève <see cref="UnauthorizedAccessException"/> si le projet ne correspond pas.
        /// </summary>
        private async Task<(PurchaseRequestReadDto Header, string? ETag)> GetAndVerifyHeaderAsync(
            Guid id, string projectNo)
        {
            var response = await _httpClient.GetAsync($"purchaseRequests({id})");

            if (response.StatusCode == System.Net.HttpStatusCode.NotFound)
                throw new KeyNotFoundException(
                    $"La demande d'achat '{id}' est introuvable dans Business Central.");

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            var header = await response.Content
                .ReadFromJsonAsync<PurchaseRequestReadDto>(SerializerOptionsRead);

            if (header == null)
                throw new KeyNotFoundException(
                    $"La demande d'achat '{id}' est introuvable dans Business Central.");

            if (!string.Equals(header.JobNo, projectNo, StringComparison.OrdinalIgnoreCase))
            {
                _logger.LogWarning(
                    "[PR] Accès refusé : demande {Id} appartient au projet {HeaderProject}, " +
                    "chef connecté au projet {UserProject}", id, header.JobNo, projectNo);
                throw new UnauthorizedAccessException(
                    "Accès refusé : cette demande n'appartient pas à votre projet.");
            }

            var etag = response.Headers.ETag?.ToString();
            return (header, etag);
        }

        /// <summary>
        /// Récupère une ligne de demande d'achat depuis BC, vérifie qu'elle appartient au projet
        /// du chef connecté et retourne l'ETag pour les opérations PATCH / DELETE suivantes.
        /// Lève <see cref="KeyNotFoundException"/> si introuvable.
        /// Lève <see cref="UnauthorizedAccessException"/> si le projet ne correspond pas.
        /// </summary>
        private async Task<(PurchaseRequestLineReadDto Line, string? ETag)> GetAndVerifyLineAsync(
            Guid lineId, string projectNo)
        {
            var response = await _httpClient.GetAsync($"purchaseRequestLines({lineId})");

            if (response.StatusCode == System.Net.HttpStatusCode.NotFound)
                throw new KeyNotFoundException(
                    $"La ligne '{lineId}' est introuvable dans Business Central.");

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            var line = await response.Content
                .ReadFromJsonAsync<PurchaseRequestLineReadDto>(SerializerOptionsRead);

            if (line == null)
                throw new KeyNotFoundException(
                    $"La ligne '{lineId}' est introuvable dans Business Central.");

            if (!string.Equals(line.JobNo, projectNo, StringComparison.OrdinalIgnoreCase))
            {
                _logger.LogWarning(
                    "[PR] Accès refusé ligne {LineId} : projet {LineProject} ≠ {UserProject}",
                    lineId, line.JobNo, projectNo);
                throw new UnauthorizedAccessException(
                    "Accès refusé : cette ligne n'appartient pas à votre projet.");
            }

            var etag = response.Headers.ETag?.ToString();
            return (line, etag);
        }

        /// <summary>
        /// Retourne le numéro de ligne le plus élevé pour un document donné.
        /// Utilisé pour calculer le prochain lineNo lors de la création de lignes (Max + 10 000).
        /// Retourne 0 si aucune ligne n'existe encore.
        /// </summary>
        private async Task<int> GetLastLineNoAsync(string documentNo)
        {
            var url = $"purchaseRequestLines?$filter=documentNo eq '{documentNo}'" +
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

        // métier
        public async Task<IEnumerable<PurchaseRequestReadDto>> GetAllRequestsAsync(string projectNo)
        {
            var url = $"purchaseRequests?$filter=jobNo eq '{projectNo}'";
            _logger.LogInformation("[PR] GetAll pour projet {ProjectNo}", projectNo);

            var response = await _httpClient.GetAsync(url);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            var result = await response.Content
                .ReadFromJsonAsync<BCResponse<PurchaseRequestReadDto>>(SerializerOptionsRead);

            return result?.Value ?? Enumerable.Empty<PurchaseRequestReadDto>();
        }

        public async Task<PurchaseRequestReadDto?> GetRequestByIdAsync(Guid id, string projectNo)
        {
            var url      = $"purchaseRequests({id})?$expand=purchaseRequestLines";
            var response = await _httpClient.GetAsync(url);

            if (response.StatusCode == System.Net.HttpStatusCode.NotFound)
                return null;

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            var request = await response.Content
                .ReadFromJsonAsync<PurchaseRequestReadDto>(SerializerOptionsRead);

            if (request != null &&
                !string.Equals(request.JobNo, projectNo, StringComparison.OrdinalIgnoreCase))
            {
                _logger.LogWarning(
                    "[PR] Accès refusé : demande {Id} appartient au projet {HeaderProject}, " +
                    "chef connecté au projet {UserProject}", id, request.JobNo, projectNo);
                throw new UnauthorizedAccessException(
                    "Accès refusé : cette demande n'appartient pas à votre projet.");
            }

            return request;
        }

        public async Task<PurchaseRequestReadDto> CreateHeaderAsync(
            PurchaseRequestCreateDto header, string projectNo)
        {
            var node = JsonSerializer.SerializeToNode(header, SerializerOptionsWrite)
                as JsonObject ?? new JsonObject();
            node["jobNo"] = projectNo;

            var json    = node.ToJsonString();
            var content = new StringContent(json, Encoding.UTF8, "application/json");

            _logger.LogInformation("[PR] Création en-tête pour projet {ProjectNo}", projectNo);

            var response = await _httpClient.PostAsync("purchaseRequests", content);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            return (await response.Content
                .ReadFromJsonAsync<PurchaseRequestReadDto>(SerializerOptionsRead))!;
        }

        public async Task<bool> CreateLinesAsync(
            List<PurchaseRequestLineCreateDto> lines, string projectNo)
        {
            if (lines == null || !lines.Any())
                return false;

            var firstDocNo = lines.First().DocumentNo;

            if (string.IsNullOrWhiteSpace(firstDocNo))
                throw new ArgumentException(
                    "Le numéro de document (DocumentNo) est obligatoire pour créer des lignes.");

            int currentMaxLineNo = await GetLastLineNoAsync(firstDocNo);

            foreach (var line in lines)
            {
                currentMaxLineNo += 10000;

                var node = JsonSerializer.SerializeToNode(line, SerializerOptionsWrite)
                    as JsonObject ?? new JsonObject();
                node["jobNo"]  = projectNo;
                node["lineNo"] = currentMaxLineNo;

                var json    = node.ToJsonString();
                var content = new StringContent(json, Encoding.UTF8, "application/json");

                _logger.LogInformation("[PR] Création ligne {DocNo} / LineNo {LineNo}",
                    line.DocumentNo, currentMaxLineNo);

                var response = await _httpClient.PostAsync("purchaseRequestLines", content);

                if (!response.IsSuccessStatusCode)
                    await HandleErrorResponseAsync(response);
            }

            return true;
        }

        public async Task<bool> PatchHeaderAsync(
            Guid id, PurchaseRequestPatchDto header, string projectNo)
        {
            var (_, etag) = await GetAndVerifyHeaderAsync(id, projectNo);

            var json = JsonSerializer.Serialize(header, SerializerOptionsWrite);
            _logger.LogInformation("[PR] PATCH en-tête {Id}", id);

            var request = new HttpRequestMessage(new HttpMethod("PATCH"), $"purchaseRequests({id})")
            {
                Content = new StringContent(json, Encoding.UTF8, "application/json")
            };
            request.Headers.TryAddWithoutValidation("If-Match", etag ?? "*");

            var response = await _httpClient.SendAsync(request);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            _logger.LogInformation("[PR] PATCH en-tête {Id} — Réponse : {Status}",
                id, (int)response.StatusCode);

            return true;
        }

        public async Task<bool> SubmitForApprovalAsync(Guid id, string projectNo)
        {
            var (existing, etag) = await GetAndVerifyHeaderAsync(id, projectNo);

            var currentStatut = existing.Statut ?? string.Empty;
            if (!string.Equals(currentStatut, "Open", StringComparison.OrdinalIgnoreCase))
                throw new InvalidOperationException(
                    $"Statut actuel '{currentStatut}' — seule une demande 'Open' peut être soumise.");

            var json    = """{"statut": "To Approve"}""";
            var request = new HttpRequestMessage(new HttpMethod("PATCH"), $"purchaseRequests({id})")
            {
                Content = new StringContent(json, Encoding.UTF8, "application/json")
            };
            request.Headers.TryAddWithoutValidation("If-Match", etag ?? "*");

            var response = await _httpClient.SendAsync(request);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            _logger.LogInformation("[PR] Demande {Id} soumise pour approbation.", id);
            return true;
        }

        public async Task<bool> DeleteRequestAsync(Guid id, string projectNo)
        {
            // ici la suppression en cascade est gérée par BC
            var (_, etag) = await GetAndVerifyHeaderAsync(id, projectNo);

            var request = new HttpRequestMessage(HttpMethod.Delete, $"purchaseRequests({id})");
            request.Headers.TryAddWithoutValidation("If-Match", etag ?? "*");

            var response = await _httpClient.SendAsync(request);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            _logger.LogInformation("[PR] Demande {Id} supprimée.", id);
            return true;
        }

        public async Task<bool> PatchLineAsync(
            Guid lineId, PurchaseRequestLinePatchDto lineDto, string projectNo)
        {
            var (_, etag) = await GetAndVerifyLineAsync(lineId, projectNo);

            var json    = JsonSerializer.Serialize(lineDto, SerializerOptionsWrite);
            var request = new HttpRequestMessage(new HttpMethod("PATCH"), $"purchaseRequestLines({lineId})")
            {
                Content = new StringContent(json, Encoding.UTF8, "application/json")
            };
            request.Headers.TryAddWithoutValidation("If-Match", etag ?? "*");

            var response = await _httpClient.SendAsync(request);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            _logger.LogInformation("[PR] PATCH ligne {LineId} — Réponse : {Status}",
                lineId, (int)response.StatusCode);

            return true;
        }

        public async Task<bool> DeleteLineAsync(Guid lineId, string projectNo)
        {
            var (_, etag) = await GetAndVerifyLineAsync(lineId, projectNo);

            var request = new HttpRequestMessage(HttpMethod.Delete, $"purchaseRequestLines({lineId})");
            request.Headers.TryAddWithoutValidation("If-Match", etag ?? "*");

            var response = await _httpClient.SendAsync(request);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            _logger.LogInformation("[PR] Ligne {LineId} supprimée.", lineId);
            return true;
        }
    }
}