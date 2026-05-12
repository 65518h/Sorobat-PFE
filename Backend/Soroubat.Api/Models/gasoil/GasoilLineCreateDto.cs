using System.Text.Json.Serialization;

namespace Soroubat.Api.Models
{
/// <summary>POST — création ligne (projectNo imposé côté serveur).</summary>
    public class GasoilLineCreateDto
    {
        [JsonPropertyName("documentNo")]
        public string? DocumentNo { get; set; }

        [JsonPropertyName("vehicleNo")]
        public string? VehicleNo { get; set; }

        [JsonPropertyName("quantity")]
        public decimal? Quantity { get; set; }

        [JsonPropertyName("time")]
        public string? Time { get; set; }

        [JsonPropertyName("indexType")]
        public string? IndexType { get; set; }

        [JsonPropertyName("hourIndex")]
        public decimal? HourIndex { get; set; }

        [JsonPropertyName("kmIndex")]
        public decimal? KmIndex { get; set; }

        [JsonPropertyName("driver")]
        public string? Driver { get; set; }
    }
}