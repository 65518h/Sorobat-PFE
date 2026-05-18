using System.Text.Json.Serialization;

namespace Soroubat.Api.Models
{
    /// <summary>
    /// PATCH ligne — uniquement les champs saisis par le chef de chantier.
    /// Exclus : id, documentNo (clé technique), lineNo (non modifiable après création),
    /// projectNo (forcé par le backend depuis le JWT — non modifiable directement).
    /// </summary>
    public class GasoilLinePatchDto
    {
        [JsonPropertyName("vehicleNo")]
        public string? VehicleNo { get; set; }

        [JsonPropertyName("quantity")]
        public decimal? Quantity { get; set; }

        [JsonPropertyName("maxConsommation")]
        public decimal? MaxConsommation { get; set; }

        [JsonPropertyName("indexType")]
        public string? IndexType { get; set; }

        [JsonPropertyName("valeurCompteur")]
        public decimal? ValeurCompteur { get; set; }

        [JsonPropertyName("driver")]
        public string? Driver { get; set; }

        [JsonPropertyName("destination")]
        public string? Destination { get; set; }

        [JsonPropertyName("observation")]
        public string? Observation { get; set; }
    }
}