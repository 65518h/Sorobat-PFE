using System.Text.Json.Serialization;

namespace Soroubat.Api.Models
{
    /// <summary>
    /// Représente le stock agrégé d'un article dans un magasin spécifique du chantier.
    /// Construit par croisement des données Location et Item Ledger Entry.
    /// Retourné directement au client — ne contient aucun champ technique interne.
    /// </summary>
    public class MagasinStockReadDto
    {
        /// <summary>Code de l'emplacement BC (ex : "MAG-001").</summary>
        [JsonPropertyName("locationCode")]
        public string LocationCode { get; set; } = string.Empty;

        /// <summary>Nom complet du magasin.</summary>
        [JsonPropertyName("locationName")]
        public string LocationName { get; set; } = string.Empty;

        [JsonPropertyName("itemNo")]
        public string ItemNo { get; set; } = string.Empty;

        [JsonPropertyName("itemDescription")]
        public string ItemDescription { get; set; } = string.Empty;

        /// <summary>
        /// Stock réel = somme de toutes les écritures de l'article sur ce magasin.
        /// Peut être négatif en cas d'incohérence dans BC (détecté par AlertService).
        /// </summary>
        [JsonPropertyName("quantity")]
        public decimal Quantity { get; set; }

        [JsonPropertyName("jobNo")]
        public string JobNo { get; set; } = string.Empty;

        /// <summary>Date du dernier mouvement de stock pour cet article sur ce magasin.</summary>
        [JsonPropertyName("lastPostingDate")]
        public DateTime? LastPostingDate { get; set; }
    }
}