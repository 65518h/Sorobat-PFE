using System.Text.Json.Serialization;

namespace Soroubat.Api.Models
{
    /// <summary>
    /// Corps de PATCH pour l'en-tête (page BC 50152). Uniquement les champs que le chef peut modifier —
    /// pas d'id, numéro de document ni totaux calculés.
    /// </summary>
    public class EmpAttendanceHeaderPatchDto
    {
        [JsonPropertyName("month")]
        public string? Month { get; set; }

        [JsonPropertyName("year")]
        public int? Year { get; set; }
    }
}