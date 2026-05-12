using System.Text.Json.Serialization;

namespace Soroubat.Api.Models
{
    /// <summary>Lecture OData / GET — PurchaseRequestAPI (champs renvoyés par BC).</summary>
    public class PurchaseRequestReadDto
    {
        [JsonPropertyName("id")]
        public Guid Id { get; set; }

        [JsonPropertyName("no")]
        public string? No { get; set; }

        [JsonPropertyName("observation")]
        public string? Observation { get; set; }

        [JsonPropertyName("jobNo")]
        public string? JobNo { get; set; }

        [JsonPropertyName("jobDescription")]
        public string? JobDescription { get; set; }

        [JsonPropertyName("requesterId")]
        public string? RequesterId { get; set; }

        [JsonPropertyName("requestType")]
        public string? RequestType { get; set; }

        [JsonPropertyName("engin")]
        public string? Engin { get; set; }

        [JsonPropertyName("descriptionEngin")]
        public string? DescriptionEngin { get; set; }

        [JsonPropertyName("locationCode")]
        public string? LocationCode { get; set; }

        [JsonPropertyName("orderDate")]
        public string? OrderDate { get; set; }

        [JsonPropertyName("dueDate")]
        public string? DueDate { get; set; }

        [JsonPropertyName("statut")]
        public string? Statut { get; set; }

        /// <summary>Montant total — calcul BC ; nullable si absent dans la réponse.</summary>
        [JsonPropertyName("amount")]
        public decimal? Amount { get; set; }

        [JsonPropertyName("service")]
        public string? Service { get; set; }

        [JsonPropertyName("purchaseRequestLines")]
        public List<PurchaseRequestLineReadDto>? PurchaseRequestLines { get; set; }
    }

}
