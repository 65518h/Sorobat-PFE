using System.Text.Json.Serialization;

namespace Soroubat.Api.Models
{
    /// <summary>Lecture — ligne renvoyée par BC (PurchaseRequestLineAPI).</summary>
    public class PurchaseRequestLineReadDto
    {
        [JsonPropertyName("id")]
        public Guid Id { get; set; }

        [JsonPropertyName("documentNo")]
        public string? DocumentNo { get; set; }

        [JsonPropertyName("lineNo")]
        public int LineNo { get; set; }


        [JsonPropertyName("type")]
        public string? Type { get; set; }

        [JsonPropertyName("no")]
        public string? No { get; set; }

        [JsonPropertyName("description")]
        public string? Description { get; set; }

        [JsonPropertyName("observation")]
        public string? Observation { get; set; }

        [JsonPropertyName("quantity")]
        public decimal? Quantity { get; set; }

        [JsonPropertyName("unitOfMeasureCode")]
        public string? UnitOfMeasureCode { get; set; }

        [JsonPropertyName("locationCode")]
        public string? LocationCode { get; set; }


        [JsonPropertyName("jobNo")]
        public string? JobNo { get; set; }

        [JsonPropertyName("jobTaskNo")]
        public string? JobTaskNo { get; set; }

    }




}