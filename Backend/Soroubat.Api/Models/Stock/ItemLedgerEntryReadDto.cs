using System.Text.Json.Serialization;

namespace Soroubat.Api.Models
{
    /// <summary>
    /// Représente une écriture comptable article (Item Ledger Entry) telle que
    /// retournée par l'API Business Central ItemLedgerEntryAPI (page 50145).
    /// Ce DTO est utilisé exclusivement en lecture interne pour l'agrégation du stock —
    /// il n'est jamais retourné directement au client.
    /// L'API est en lecture seule côté AL (InsertAllowed = false, ModifyAllowed = false, DeleteAllowed = false).
    /// </summary>
    public class ItemLedgerEntryReadDto
    {
        [JsonPropertyName("entryNo")]
        public int EntryNo { get; set; }

        [JsonPropertyName("itemNo")]
        public string ItemNo { get; set; } = string.Empty;

        /// <summary>Désignation article — FlowField calculé par BC (Designation Article).</summary>
        [JsonPropertyName("itemDescription")]
        public string ItemDescription { get; set; } = string.Empty;

        [JsonPropertyName("locationCode")]
        public string LocationCode { get; set; } = string.Empty;

        /// <summary>
        /// Quantité de l'écriture — positive pour les entrées, négative pour les sorties.
        /// La somme de toutes les écritures d'un article donne le stock réel.
        /// </summary>
        [JsonPropertyName("quantity")]
        public decimal Quantity { get; set; }

        /// <summary>Numéro de projet — champ de filtrage principal.</summary>
        [JsonPropertyName("jobNo")]
        public string JobNo { get; set; } = string.Empty;

        /// <summary>Date de validation de l'écriture — utilisée pour calculer LastPostingDate.</summary>
        [JsonPropertyName("postingDate")]
        public DateTime? PostingDate { get; set; }
    }
}