using System.Text.Json.Serialization;

namespace Soroubat.Api.Models
{
    /// <summary>
    /// GET — ligne pointage véhicule BC (page 50149).
    /// Le champ <c>marche</c> (jobNo de la ligne) n'est pas exposé au client —
    /// il est forcé par le backend depuis le JWT lors de la création/modification.
    /// </summary>
    public class VehiculePointageLineReadDto
    {
        [JsonPropertyName("id")]
        public Guid? Id { get; set; }

        [JsonPropertyName("documentNo")]
        public string? DocumentNo { get; set; }

        [JsonPropertyName("vehiculeNo")]
        public string? VehiculeNo { get; set; }

        [JsonPropertyName("description")]
        public string? Description { get; set; }

        /// <summary>Statut de la ligne — calculé/géré par BC, non modifiable directement.</summary>
        [JsonPropertyName("status")]
        public string? Status { get; set; }

        [JsonPropertyName("hoursWorked")]
        public decimal? HoursWorked { get; set; }

        [JsonPropertyName("startIndex")]
        public decimal? StartIndex { get; set; }

        [JsonPropertyName("endIndex")]
        public decimal? EndIndex { get; set; }

        
    }
}