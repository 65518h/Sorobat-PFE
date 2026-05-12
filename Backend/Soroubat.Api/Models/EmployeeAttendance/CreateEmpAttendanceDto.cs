using System.Text.Json.Serialization;

namespace Soroubat.Api.Models
{
    /// <summary>
    /// POST — création en-tête fiche pointage vers BC.
    /// Le jobNo est forcé par le backend depuis le JWT (ignorer toute valeur client).
    /// </summary>
    public class EmpAttendanceHeaderCreateDto
    {
        [JsonPropertyName("jobNo")]
        public string? JobNo { get; set; }

        [JsonPropertyName("month")]
        public string? Month { get; set; }

        [JsonPropertyName("year")]
        public int? Year { get; set; }
    }
}
