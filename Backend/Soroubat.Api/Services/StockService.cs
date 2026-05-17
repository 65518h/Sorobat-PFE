using System.Net.Http.Json;
using Soroubat.Api.Interfaces;
using Soroubat.Api.Models;

namespace Soroubat.Api.Services
{
    /// <summary>
    /// Interagit avec l'API Business Central ItemLedgerEntryAPI (page 50145)
    /// pour calculer le stock réel d'un chantier par agrégation des écritures comptables articles.
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
            var url = $"itemLedgerEntries?$filter=jobNo eq '{projectNo}'";
            _logger.LogInformation("[Stock] Récupération des écritures pour le projet {ProjectNo}", projectNo);

            var response = await _httpClient.GetAsync(url);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);


            var data = await response.Content.ReadFromJsonAsync<BCResponse<ItemLedgerEntryReadDto>>();

            if (data?.Value == null || !data.Value.Any())
            {
                _logger.LogInformation("[Stock] Aucune écriture trouvée pour le projet {ProjectNo}", projectNo);
                return new List<StockChantierReadDto>();
            }

            // AGRÉGATION : groupement par article et emplacement pour obtenir le stock réel.
            // La somme des quantités (entrées positives + sorties négatives) donne le stock courant.
            // Les articles avec un stock nul (mouvements équilibrés) sont exclus du résultat.
            // Les articles avec un stock négatif sont conservés : AlertService les détecte comme anomalie.
            var stockAgrege = data.Value
                .GroupBy(entry => new
                {
                    entry.ItemNo,
                    entry.LocationCode,
                    entry.ItemDescription
                })
                .Select(groupe => new StockChantierReadDto // chaque groupe agrégé devient un objet StockChantierReadDto
                {
                    ItemNo          = groupe.Key.ItemNo,
                    ItemDescription = groupe.Key.ItemDescription,
                    LocationCode    = groupe.Key.LocationCode,
                    Quantity        = groupe.Sum(entry => entry.Quantity),
                    JobNo           = projectNo,
                    LastPostingDate = groupe.Max(entry => entry.PostingDate) // pour affichier la date du dernier mouvement de l'article
                })
                .Where(stock => stock.Quantity != 0) // on elimine les stocks nuls mais on garde les stocks négatifs ( peut étre utile pour les alertes )
                .OrderBy(stock => stock.ItemDescription) // plus lisible pour le chef de chantier que le itemNo
                .ToList();

            _logger.LogInformation("[Stock] {Count} article(s) en stock pour le projet {ProjectNo}",
                stockAgrege.Count, projectNo);

            return stockAgrege;
        }
    }
}