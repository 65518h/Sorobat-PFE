using System.Text.Json.Serialization;

namespace Soroubat.Api.Models
{
    /// <summary>GET — ligne fiche gasoil BC (page 50151).</summary>
    public class GasoilLineReadDto
    {
        [JsonPropertyName("id")]
        public Guid? Id { get; set; }

        [JsonPropertyName("documentNo")]
        public string? DocumentNo { get; set; }

        [JsonPropertyName("lineNo")]
        public int? LineNo { get; set; }

        [JsonPropertyName("vehicleNo")]
        public string? VehicleNo { get; set; }

        [JsonPropertyName("quantity")]
        public decimal? Quantity { get; set; }

        [JsonPropertyName("maxConsommation")]
        public decimal? MaxConsommation { get; set; }

        [JsonPropertyName("time")]
        public string? Time { get; set; }

        [JsonPropertyName("indexType")]
        public string? IndexType { get; set; }

        [JsonPropertyName("valeurCompteur")]
        public decimal? ValeurCompteur { get; set; }

        [JsonPropertyName("driver")]
        public string? Driver { get; set; }

        [JsonPropertyName("destination")]
        public string? Destination { get; set; }

        [JsonPropertyName("projectNo")]
        public string? ProjectNo { get; set; }

        [JsonPropertyName("observation")]
        public string? Observation { get; set; }
    }
}