using System.Text.Json.Serialization;

namespace Soroubat.Api.Models
{
    /// <summary>
    /// PATCH ligne — uniquement les champs saisis par le chef de chantier.
    /// Exclus : id, documentNo (clé technique), marche (forcé par le backend depuis le JWT),
    /// status (géré par BC, non modifiable directement via l'API).
    /// </summary>
    public class VehiculePointageLinePatchDto
    {


        [JsonPropertyName("hoursWorked")]
        public decimal? HoursWorked { get; set; }

        [JsonPropertyName("startIndex")]
        public decimal? StartIndex { get; set; }

        [JsonPropertyName("endIndex")]
        public decimal? EndIndex { get; set; }

        [JsonPropertyName("status")]
        public string? Status { get; set; }
    }
}