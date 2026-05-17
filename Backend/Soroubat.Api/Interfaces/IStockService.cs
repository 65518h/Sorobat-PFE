using Soroubat.Api.Models;

namespace Soroubat.Api.Interfaces
{
    /// <summary>
    /// Contrat du service de consultation du stock chantier.
    /// Le stock est calculé par agrégation des écritures comptables articles (Item Ledger Entries)
    /// filtrées par projet depuis Business Central.
    /// L'API source est en lecture seule (InsertAllowed = false, ModifyAllowed = false, DeleteAllowed = false).
    /// </summary>
    public interface IStockService
    {
        /// <summary>
        /// Retourne le stock agrégé de tous les articles du chantier correspondant au projet,
        /// groupé par article et par emplacement, enrichi du nom complet du magasin.
        /// Le frontend peut filtrer ou grouper par locationCode / locationName librement.
        /// Les articles avec un stock nul (entrées = sorties) sont exclus du résultat.
        /// Les articles avec un stock négatif sont inclus — ils sont détectés par AlertService.
        /// </summary>
        Task<List<StockChantierReadDto>> GetStockByProjectAsync(string projectNo);
    }
}