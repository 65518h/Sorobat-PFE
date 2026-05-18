using System.Text.Json.Serialization;

namespace Soroubat.Api.Models
{
    /// <summary>
    /// GET — en-tête pointage véhicule BC (page 50148).
    /// Retourné au client ; les lignes sont incluses uniquement lors d'un appel avec $expand.
    /// </summary>
    public class VehiculePointageHeaderReadDto
    {
        [JsonPropertyName("id")]
        public Guid? Id { get; set; }

        [JsonPropertyName("documentNo")]
        public string? DocumentNo { get; set; }

        [JsonPropertyName("jobNo")]
        public string? JobNo { get; set; }

        [JsonPropertyName("date")]
        public string? Date { get; set; }

        [JsonPropertyName("status")]
        public string? Status { get; set; }

        /// <summary>
        /// Lignes incluses uniquement lors d'un appel $expand=vehiculePointageLines.
        /// Null si l'en-tête est retourné sans expand.
        /// </summary>
        [JsonPropertyName("vehiculePointageLines")]
        public List<VehiculePointageLineReadDto>? VehiculePointageLines { get; set; }
    }
}