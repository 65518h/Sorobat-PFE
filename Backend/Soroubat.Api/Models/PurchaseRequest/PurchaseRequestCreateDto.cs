   using System.Text.Json.Serialization;

namespace Soroubat.Api.Models
{
   /// <summary>POST création en-tête — sous-ensemble éditable côté client.</summary>
    public class PurchaseRequestCreateDto
    {
        [JsonPropertyName("observation")]
        public string? Observation { get; set; }

        [JsonPropertyName("requesterId")]
        public string? RequesterId { get; set; }

        [JsonPropertyName("requestType")]
        public string? RequestType { get; set; }

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