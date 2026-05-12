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
    /// Le chef de chantier peut consulter les transferts qui lui sont destinés
    /// et enregistrer la réception sur les lignes (qtyToReceive, numVehicule).
    /// </summary>
    public class TransferService : BaseService, ITransferService
    {
        private readonly HttpClient _httpClient;
        private readonly ILogger<TransferService> _logger;

        // Options partagées : on n'envoie jamais de champs nuls à BC
        private static readonly JsonSerializerOptions _serializerOptions = new()
        {
            DefaultIgnoreCondition = JsonIgnoreCondition.WhenWritingNull
        };

        public TransferService(HttpClient httpClient, ILogger<TransferService> logger)
        {
            _httpClient = httpClient;
            _logger = logger;
        }

        // ── HELPERS PRIVÉS ────────────────────────────────────────────────────

        /// <summary>
        /// Récupère une ligne et vérifie qu'elle appartient au projet du chef connecté
        /// via le header parent (chantierDestination).
        /// Lève <see cref="KeyNotFoundException"/> si introuvable.
        /// Lève <see cref="UnauthorizedAccessException"/> si le projet ne correspond pas.
        /// </summary>
        private async Task<(TransferLineReadDto Line, string? ETag)> GetAndVerifyLineAsync(
            Guid lineId, string projectNo)
        {
            // 1. Récupérer la ligne et son ETag pour la gestion de concurrence BC
            var lineResponse = await _httpClient.GetAsync($"transferLines({lineId})");

            if (lineResponse.StatusCode == System.Net.HttpStatusCode.NotFound)
                throw new KeyNotFoundException($"La ligne de transfert '{lineId}' est introuvable dans Business Central.");

            if (!lineResponse.IsSuccessStatusCode)
                await HandleErrorResponseAsync(lineResponse);

            var line = await lineResponse.Content.ReadFromJsonAsync<TransferLineReadDto>();

            if (line == null || string.IsNullOrEmpty(line.DocumentNo))
                throw new KeyNotFoundException($"La ligne de transfert '{lineId}' est introuvable dans Business Central.");

            // 2. SÉCURITÉ : Récupérer le header parent pour valider le chantierDestination
            var headerFilter = $"$filter=no eq '{line.DocumentNo}'";
            var headerResponse = await _httpClient.GetAsync($"transferHeaders?{headerFilter}");

            if (!headerResponse.IsSuccessStatusCode)
                await HandleErrorResponseAsync(headerResponse);

            var headerResult = await headerResponse.Content.ReadFromJsonAsync<BCResponse<TransferHeaderReadDto>>();
            var header = headerResult?.Value?.FirstOrDefault();

            if (header == null)
                throw new KeyNotFoundException($"L'ordre de transfert '{line.DocumentNo}' est introuvable dans Business Central.");

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

        // ── EN-TÊTES ──────────────────────────────────────────────────────────

        public async Task<IEnumerable<TransferHeaderReadDto>> GetAllTransfersAsync(string projectNo)
        {
            var url = $"transferHeaders?$filter=chantierDestination eq '{projectNo}'";
            _logger.LogInformation("[Transfer] GetAll pour chantier {ProjectNo}", projectNo);

            var response = await _httpClient.GetAsync(url);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            var result = await response.Content.ReadFromJsonAsync<BCResponse<TransferHeaderReadDto>>();
            return result?.Value ?? Enumerable.Empty<TransferHeaderReadDto>();
        }

        public async Task<TransferHeaderReadDto?> GetTransferByIdAsync(Guid id, string projectNo)
        {
            var url = $"transferHeaders({id})?$expand=transferLines";
            var response = await _httpClient.GetAsync(url);

            if (response.StatusCode == System.Net.HttpStatusCode.NotFound)
                return null;

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            var transfer = await response.Content.ReadFromJsonAsync<TransferHeaderReadDto>();

            if (transfer == null)
                return null;

            // Vérification que le transfert est bien destiné au chantier du chef connecté
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

        // ── LIGNES ────────────────────────────────────────────────────────────

        public async Task<bool> PatchLineAsync(Guid lineId, TransferLinePatchDto lineDto, string projectNo)
        {
            // SÉCURITÉ : vérifier appartenance + récupérer ETag
            var (_, etag) = await GetAndVerifyLineAsync(lineId, projectNo);

            var json = JsonSerializer.Serialize(lineDto, _serializerOptions);

            _logger.LogInformation("[Transfer] PATCH ligne {LineId} — Body: {Json}", lineId, json);

            var request = new HttpRequestMessage(new HttpMethod("PATCH"), $"transferLines({lineId})")
            {
                Content = new StringContent(json, Encoding.UTF8, "application/json")
            };
            request.Headers.TryAddWithoutValidation("If-Match", etag ?? "*");

            var response = await _httpClient.SendAsync(request);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            _logger.LogInformation("[Transfer] PATCH ligne {LineId} — Réponse: {Status}",
                lineId, (int)response.StatusCode);

            return true;
        }

        // ── USAGE INTERNE (AlertService) ──────────────────────────────────────

        public async Task<IEnumerable<TransferHeaderReadDto>> GetAllTransfersWithLinesAsync(string projectNo)
        {
            var url = $"transferHeaders?$filter=chantierDestination eq '{projectNo}'&$expand=transferLines";
            _logger.LogInformation("[Transfer] GetAllWithLines pour chantier {ProjectNo}", projectNo);

            var response = await _httpClient.GetAsync(url);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            var result = await response.Content.ReadFromJsonAsync<BCResponse<TransferHeaderReadDto>>();
            return result?.Value ?? Enumerable.Empty<TransferHeaderReadDto>();
        }
    }
}