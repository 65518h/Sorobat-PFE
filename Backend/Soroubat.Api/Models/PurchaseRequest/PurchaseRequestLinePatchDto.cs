    using System.Text.Json.Serialization;

namespace Soroubat.Api.Models
{
    /// <summary>PATCH — uniquement les champs modifiables côté page AL (pas d'id, pas documentNo / lineNo / transferer / lineAmount).</summary>
    public class PurchaseRequestLinePatchDto
    {
        [JsonPropertyName("type")]
        public string? Type { get; set; }

        [JsonPropertyName("description")]
        public string? Description { get; set; }

        [JsonPropertyName("description2")]
        public string? Description2 { get; set; }

        [JsonPropertyName("quantity")]
        public decimal? Quantity { get; set; }

        [JsonPropertyName("locationCode")]
        public string? LocationCode { get; set; }

        [JsonPropertyName("variantCode")]
        public string? VariantCode { get; set; }

        [JsonPropertyName("jobTaskNo")]
        public string? JobTaskNo { get; set; }

        [JsonPropertyName("engin")]
        public string? Engin { get; set; }
    }
}