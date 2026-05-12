using System.Text.Json.Serialization;

namespace Soroubat.Api.Models
{
    /// <summary>POST — création en-tête (job imposé côté serveur ; date appliquée en 2ᵉ temps par le service).</summary>
    public class VehiculePointageHeaderCreateDto
    {
        [JsonPropertyName("date")]
        public string? Date { get; set; }
    }
}