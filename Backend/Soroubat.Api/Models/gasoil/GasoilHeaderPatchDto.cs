using System.Text.Json.Serialization;

namespace Soroubat.Api.Models
{
    /// <summary>PATCH — champs modifiables sur l'en-tête (hors statut / validation dédiée).</summary>
    public class GasoilHeaderPatchDto
    {
        [JsonPropertyName("date")]
        public string? Date { get; set; }

        [JsonPropertyName("locationCode")]
        public string? LocationCode { get; set; }

        [JsonPropertyName("startIndex")]
        public decimal? StartIndex { get; set; }

        [JsonPropertyName("endIndex")]
        public decimal? EndIndex { get; set; }
    }
}