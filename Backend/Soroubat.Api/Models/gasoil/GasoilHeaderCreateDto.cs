using System.Text.Json.Serialization;

namespace Soroubat.Api.Models
{
    /// <summary>POST — création en-tête (chantier imposé côté serveur).</summary>
    public class GasoilHeaderCreateDto
    {
        [JsonPropertyName("date")]
        public string? Date { get; set; }

        [JsonPropertyName("locationCode")]
        public string? LocationCode { get; set; }
        
        [JsonPropertyName("fileNo")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public string? FileNo { get; set; }
    }
}