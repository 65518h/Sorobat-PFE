using System.Text.Json.Serialization;

namespace Soroubat.Api.Models
{ 
    /// <summary>PATCH en-tête — champs que le flux métier permet de modifier hors soumission/statut dédiée.</summary>
    public class PurchaseRequestPatchDto
    {
        [JsonPropertyName("observation")]
        public string? Observation { get; set; }

        [JsonPropertyName("engin")]
        public string? Engin { get; set; }

        [JsonPropertyName("locationCode")]
        public string? LocationCode { get; set; }

        [JsonPropertyName("orderDate")]
        public string? OrderDate { get; set; }

        [JsonPropertyName("dueDate")]
        public string? DueDate { get; set; }

        [JsonPropertyName("service")]
        public string? Service { get; set; }
    }
}