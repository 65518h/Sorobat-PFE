using System.Text.Json.Serialization;

namespace Soroubat.Api.Models
{
    /// <summary>
    /// Représente le stock agrégé d'un article sur un chantier.
    /// Construit par agrégation des écritures comptables articles (Item Ledger Entries)
    /// groupées par article et par emplacement.
    /// Ce DTO est retourné directement au client — il ne contient aucun champ technique interne.
    /// </summary>
    public class StockChantierReadDto
    {
        [JsonPropertyName("itemNo")]
        public string ItemNo { get; set; } = string.Empty;

        [JsonPropertyName("itemDescription")]
        public string ItemDescription { get; set; } = string.Empty;

        [JsonPropertyName("locationCode")]
        public string LocationCode { get; set; } = string.Empty;

        /// <summary>
        /// Stock réel = somme de toutes les écritures de l'article sur l'emplacement.
        /// Peut être négatif en cas d'incohérence d'écritures dans BC (détecté par AlertService).
        /// </summary>
        [JsonPropertyName("quantity")]
        public decimal Quantity { get; set; }

        [JsonPropertyName("jobNo")]
        public string JobNo { get; set; } = string.Empty;

        /// <summary>
        /// Date du dernier mouvement de stock pour cet article sur cet emplacement.
        /// Utilisée par AlertService pour détecter les stocks dormants.
        /// </summary>
        [JsonPropertyName("lastPostingDate")]
        public DateTime? LastPostingDate { get; set; }
    }
}