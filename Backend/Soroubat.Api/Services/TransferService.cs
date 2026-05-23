using System.Net.Http.Json;
using System.Text;
using System.Text.Json;
using System.Text.Json.Serialization;
using Soroubat.Api.Interfaces;
using Soroubat.Api.Models;

namespace Soroubat.Api.Services
{
    /// <summary>
    /// Interagit avec les APIs Business Central TransferHeaderAPI et TransferLineAPI.
    /// Le chef de chantier peut consulter les transferts qui lui sont destinés,
    /// enregistrer la réception sur les lignes (qtyToReceive, numVehicule)
    /// et mettre à jour la date de réception sur l'en-tête (receiptDate).
    /// </summary>
    public class TransferService : BaseService, ITransferService
    {
        private readonly HttpClient _httpClient;
        private readonly ILogger<TransferService> _logger;

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

        public TransferService(HttpClient httpClient, ILogger<TransferService> logger)
        {
            _httpClient = httpClient;
            _logger     = logger;
        }

        // ── Méthodes helper de vérification ──────────────────────────────────

        /// <summary>
        /// Récupère un en-tête de transfert depuis BC, vérifie qu'il appartient au chantier
        /// du chef connecté et retourne l'ETag pour les opérations PATCH suivantes.
        /// Lève <see cref="KeyNotFoundException"/> si introuvable.
        /// Lève <see cref="UnauthorizedAccessException"/> si le chantier de destination ne correspond pas.
        /// </summary>
        private async Task<(TransferHeaderReadDto Header, string? ETag)> GetAndVerifyHeaderAsync(
            Guid id, string projectNo)
        {
            var response = await _httpClient.GetAsync($"transferHeaders({id})");

            if (response.StatusCode == System.Net.HttpStatusCode.NotFound)
                throw new KeyNotFoundException(
                    $"L'ordre de transfert '{id}' est introuvable dans Business Central.");

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            var header = await response.Content
                .ReadFromJsonAsync<TransferHeaderReadDto>(SerializerOptionsRead);

            if (header == null)
                throw new KeyNotFoundException(
                    $"L'ordre de transfert '{id}' est introuvable dans Business Central.");

            if (!string.Equals(header.ChantierDestination, projectNo, StringComparison.OrdinalIgnoreCase))
            {
                _logger.LogWarning(
                    "[Transfer] Accès refusé en-tête {Id} : chantierDestination {HeaderProject} ≠ {UserProject}",
                    id, header.ChantierDestination, projectNo);
                throw new UnauthorizedAccessException(
                    "Accès refusé : cet ordre de transfert n'appartient pas à votre chantier.");
            }

            var etag = response.Headers.ETag?.ToString();
            return (header, etag);
        }

        /// <summary>
        /// Récupère une ligne de transfert depuis BC, vérifie qu'elle appartient au chantier
        /// du chef connecté via l'en-tête parent et retourne l'ETag pour les opérations PATCH suivantes.
        /// Lève <see cref="KeyNotFoundException"/> si la ligne ou l'en-tête est introuvable.
        /// Lève <see cref="UnauthorizedAccessException"/> si le chantier de destination ne correspond pas.
        /// </summary>
        private async Task<(TransferLineReadDto Line, string? ETag)> GetAndVerifyLineAsync(
            Guid lineId, string projectNo)
        {
            var lineResponse = await _httpClient.GetAsync($"transferLines({lineId})");

            if (lineResponse.StatusCode == System.Net.HttpStatusCode.NotFound)
                throw new KeyNotFoundException(
                    $"La ligne de transfert '{lineId}' est introuvable dans Business Central.");

            if (!lineResponse.IsSuccessStatusCode)
                await HandleErrorResponseAsync(lineResponse);

            var line = await lineResponse.Content
                .ReadFromJsonAsync<TransferLineReadDto>(SerializerOptionsRead);

            if (line == null || string.IsNullOrEmpty(line.DocumentNo))
                throw new KeyNotFoundException(
                    $"La ligne de transfert '{lineId}' est introuvable dans Business Central.");

            var headerUrl      = $"transferHeaders?$filter=no eq '{line.DocumentNo}'";
            var headerResponse = await _httpClient.GetAsync(headerUrl);

            if (!headerResponse.IsSuccessStatusCode)
                await HandleErrorResponseAsync(headerResponse);

            var headerResult = await headerResponse.Content
                .ReadFromJsonAsync<BCResponse<TransferHeaderReadDto>>(SerializerOptionsRead);

            var header = headerResult?.Value?.FirstOrDefault();

            if (header == null)
                throw new KeyNotFoundException(
                    $"L'ordre de transfert '{line.DocumentNo}' est introuvable dans Business Central.");

            if (!string.Equals(header.ChantierDestination, projectNo, StringComparison.OrdinalIgnoreCase))
            {
                _logger.LogWarning(
                    "[Transfer] Accès refusé ligne {LineId} : chantierDestination {HeaderProject} ≠ {UserProject}",
                    lineId, header.ChantierDestination, projectNo);
                throw new UnauthorizedAccessException(
                    "Accès refusé : cette ligne n'appartient pas à votre chantier.");
            }

            var etag = lineResponse.Headers.ETag?.ToString();
            return (line, etag);
        }

        // ── Méthodes métier ───────────────────────────────────────────────────

        public async Task<IEnumerable<TransferHeaderReadDto>> GetAllTransfersAsync(string projectNo)
        {
            var url = $"transferHeaders?$filter=chantierDestination eq '{projectNo}'";
            _logger.LogInformation("[Transfer] GetAll pour chantier {ProjectNo}", projectNo);

            var response = await _httpClient.GetAsync(url);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            var result = await response.Content
                .ReadFromJsonAsync<BCResponse<TransferHeaderReadDto>>(SerializerOptionsRead);

            return result?.Value ?? Enumerable.Empty<TransferHeaderReadDto>();
        }

        public async Task<TransferHeaderReadDto> GetTransferByIdAsync(Guid id, string projectNo)
        {
            var url      = $"transferHeaders({id})?$expand=transferLines";
            var response = await _httpClient.GetAsync(url);

            if (response.StatusCode == System.Net.HttpStatusCode.NotFound)
                throw new KeyNotFoundException(
                    $"L'ordre de transfert '{id}' est introuvable dans Business Central.");

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            var transfer = await response.Content
                .ReadFromJsonAsync<TransferHeaderReadDto>(SerializerOptionsRead);

            if (transfer == null)
                throw new KeyNotFoundException(
                    $"L'ordre de transfert '{id}' est introuvable dans Business Central.");

            if (!string.Equals(transfer.ChantierDestination, projectNo, StringComparison.OrdinalIgnoreCase))
            {
                _logger.LogWarning(
                    "[Transfer] Accès refusé transfert {Id} : chantierDestination {HeaderProject} ≠ {UserProject}",
                    id, transfer.ChantierDestination, projectNo);
                throw new UnauthorizedAccessException(
                    "Accès refusé : cet ordre de transfert n'appartient pas à votre chantier.");
            }

            return transfer;
        }

        public async Task<bool> PatchHeaderAsync(Guid id, TransferHeaderPatchDto headerDto, string projectNo)
        {
            var (_, etag) = await GetAndVerifyHeaderAsync(id, projectNo);

            var json = JsonSerializer.Serialize(headerDto, SerializerOptionsWrite);
            _logger.LogInformation("[Transfer] PATCH en-tête {Id}", id);

            var request = new HttpRequestMessage(new HttpMethod("PATCH"), $"transferHeaders({id})")
            {
                Content = new StringContent(json, Encoding.UTF8, "application/json")
            };
            request.Headers.TryAddWithoutValidation("If-Match", etag ?? "*");

            var response = await _httpClient.SendAsync(request);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            _logger.LogInformation("[Transfer] PATCH en-tête {Id} — Réponse : {Status}",
                id, (int)response.StatusCode);

            return true;
        }

        public async Task<bool> PatchLineAsync(Guid lineId, TransferLinePatchDto lineDto, string projectNo)
        {
            var (_, etag) = await GetAndVerifyLineAsync(lineId, projectNo);

            var json = JsonSerializer.Serialize(lineDto, SerializerOptionsWrite);
            _logger.LogInformation("[Transfer] PATCH ligne {LineId}", lineId);

            var request = new HttpRequestMessage(new HttpMethod("PATCH"), $"transferLines({lineId})")
            {
                Content = new StringContent(json, Encoding.UTF8, "application/json")
            };
            request.Headers.TryAddWithoutValidation("If-Match", etag ?? "*");

            var response = await _httpClient.SendAsync(request);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            _logger.LogInformation("[Transfer] PATCH ligne {LineId} — Réponse : {Status}",
                lineId, (int)response.StatusCode);

            return true;
        }

        public async Task<IEnumerable<TransferHeaderReadDto>> GetAllTransfersWithLinesAsync(string projectNo)
        {
            var url = $"transferHeaders?$filter=chantierDestination eq '{projectNo}'&$expand=transferLines";
            _logger.LogInformation("[Transfer] GetAllWithLines pour chantier {ProjectNo}", projectNo);

            var response = await _httpClient.GetAsync(url);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            var result = await response.Content
                .ReadFromJsonAsync<BCResponse<TransferHeaderReadDto>>(SerializerOptionsRead);

            return result?.Value ?? Enumerable.Empty<TransferHeaderReadDto>();
        }
    }
}