using System.Text.Json.Serialization;

namespace Soroubat.Api.Models
{
    /// <summary>
    /// Représente le stock agrégé d'un article sur un chantier,
    /// groupé par article et par emplacement.
    /// Retourné directement au client — le frontend gère le filtrage par magasin.
    /// </summary>
    public class StockChantierReadDto
    {
        [JsonPropertyName("itemNo")]
        public string ItemNo { get; set; } = string.Empty;

        [JsonPropertyName("itemDescription")]
        public string ItemDescription { get; set; } = string.Empty;

        [JsonPropertyName("locationCode")]
        public string LocationCode { get; set; } = string.Empty;

        /// <summary>Nom complet du magasin — résolu depuis LocationAPI en un seul appel partagé.</summary>
        [JsonPropertyName("locationName")]
        public string LocationName { get; set; } = string.Empty;

        /// <summary>
        /// Stock réel = somme de toutes les écritures de l'article sur l'emplacement.
        /// Peut être négatif en cas d'incohérence dans BC (détecté par AlertService).
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