using System.Text.Json.Serialization;

namespace Soroubat.Api.Models
{
    /// <summary>
    /// POST — création en-tête fiche de pointage vers BC.
    /// Le jobNo est forcé par le backend depuis le JWT — il n'est pas exposé au client.
    /// </summary>
    public class EmpAttendanceHeaderCreateDto
    {
        [JsonPropertyName("month")]
        public string? Month { get; set; }

        [JsonPropertyName("year")]
        public int? Year { get; set; }
    }
}