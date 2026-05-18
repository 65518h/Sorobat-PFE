using System.Text.Json.Serialization;

namespace Soroubat.Api.Models
{
    /// <summary>
    /// PATCH ligne — uniquement les champs modifiables côté page AL.
    /// Exclus : id, documentNo, lineNo, jobNo (forcé par JWT), unitOfMeasureCode (calculé par BC).
    /// </summary>
    public class PurchaseRequestLinePatchDto
    {
        [JsonPropertyName("type")]
        public string? Type { get; set; }

        /// <summary>N° Article — éditable dans AL, peut être modifié après création.</summary>
        [JsonPropertyName("no")]
        public string? No { get; set; }

        [JsonPropertyName("description")]
        public string? Description { get; set; }

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