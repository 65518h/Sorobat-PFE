 using System.Text.Json.Serialization;

namespace Soroubat.Api.Models
{
    /// <summary>POST — création ligne. <c>lineNo</c> et <c>jobNo</c> sont forcés par l'API après validation.</summary>
    public class PurchaseRequestLineCreateDto
    {
        [JsonPropertyName("documentNo")]
        public string? DocumentNo { get; set; }

        [JsonPropertyName("type")]
        public string? Type { get; set; }

        [JsonPropertyName("no")]
        public string? No { get; set; }


        [JsonPropertyName("observation")]
        public string? Observation { get; set; }

        [JsonPropertyName("quantity")]
        public decimal? Quantity { get; set; }

        [JsonPropertyName("locationCode")]
        public string? LocationCode { get; set; }


        [JsonPropertyName("jobTaskNo")]
        public string? JobTaskNo { get; set; }

    }
}