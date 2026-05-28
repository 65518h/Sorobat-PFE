using System.Net.Http.Json;
using Soroubat.Api.Interfaces;
using Soroubat.Api.Models;

namespace Soroubat.Api.Services
{
    /// <summary>
    /// Interagit avec les APIs Business Central ItemLedgerEntryAPI (page 50145)
    /// et LocationAPI (page 50177) pour calculer le stock réel d'un chantier
    /// par agrégation des écritures comptables articles.
    /// </summary>
    public class StockService : BaseService, IStockService
    {
        private readonly HttpClient _httpClient;
        private readonly ILogger<StockService> _logger;

        public StockService(HttpClient httpClient, ILogger<StockService> logger)
        {
            _httpClient = httpClient;
            _logger = logger;
        }

        public async Task<List<StockChantierReadDto>> GetStockByProjectAsync(string projectNo)
        {
            _logger.LogInformation("[Stock] Récupération du stock pour le projet {ProjectNo}", projectNo);

            var locationsTask = FetchLocationsByProjectAsync(projectNo);
            var entriesTask   = FetchItemLedgerEntriesByProjectAsync(projectNo);

            await Task.WhenAll(locationsTask, entriesTask);

            var entries = entriesTask.Result;

            if (entries.Count == 0)
            {
                _logger.LogInformation("[Stock] Aucune écriture trouvée pour le projet {ProjectNo}", projectNo);
                return new List<StockChantierReadDto>();
            }

            var stock = AggregateStock(entries, projectNo);

            _logger.LogInformation("[Stock] {Count} article(s) en stock pour le projet {ProjectNo}",
                stock.Count, projectNo);

            return stock;
        }


        private static List<StockChantierReadDto> AggregateStock(List<ItemLedgerEntryReadDto> entries, string projectNo)
        {
            return entries
                .GroupBy(entry => new
                {
                    entry.ItemNo,
                    entry.LocationCode,
                    entry.Description
                })
                .Select(groupe => new StockChantierReadDto
                {
                    ItemNo          = groupe.Key.ItemNo,
                    ItemDescription = groupe.Key.Description,
                    LocationCode    = groupe.Key.LocationCode,
                    Quantity        = groupe.Sum(entry => entry.Quantity),
                    JobNo           = projectNo,
                    LastPostingDate = groupe.Max(entry => entry.PostingDate)
                })
                .Where(stock => stock.Quantity != 0)
                .OrderBy(stock => stock.LocationCode)
                .ThenBy(stock => stock.ItemDescription)
                .ToList();
        }


        /// <summary>
        /// Récupère les magasins BC rattachés à un projet (Affaire = projectNo).
        /// </summary>
        private async Task<List<LocationReadDto>> FetchLocationsByProjectAsync(string projectNo)
        {
            var encodedProjectNo = Uri.EscapeDataString(projectNo);
            var url = $"locations?$filter=affaire eq '{encodedProjectNo}'";

            _logger.LogInformation("[Stock] Récupération des magasins pour le projet {ProjectNo}", projectNo);

            var response = await _httpClient.GetAsync(url);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            var data = await response.Content.ReadFromJsonAsync<BCResponse<LocationReadDto>>();
            return data?.Value ?? new List<LocationReadDto>();
        }

        /// <summary>
        /// Récupère les écritures comptables articles BC filtrées par numéro de projet.
        /// </summary>
        private async Task<List<ItemLedgerEntryReadDto>> FetchItemLedgerEntriesByProjectAsync(string projectNo)
        {
            var encodedProjectNo = Uri.EscapeDataString(projectNo);
            var url = $"itemLedgerEntries?$filter=jobNo eq '{encodedProjectNo}'";

            _logger.LogInformation("[Stock] Récupération des écritures articles pour le projet {ProjectNo}", projectNo);

            var response = await _httpClient.GetAsync(url);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            var data = await response.Content.ReadFromJsonAsync<BCResponse<ItemLedgerEntryReadDto>>();
            return data?.Value ?? new List<ItemLedgerEntryReadDto>();
        }
    }
}