using System.Text.Json.Serialization;

namespace Soroubat.Api.Models
{
    /// <summary>
    /// GET — en-tête fiche pointage salarié BC (page 50152).
    /// Les champs calculés automatiquement par BC portent JsonIgnore WhenWritingNull
    /// pour ne jamais être renvoyés lors d'une création ou d'un PATCH.
    /// </summary>
    public class EmpAttendanceReadDto
    {
        /// <summary>SystemId BC — assigné par BC à la création, ignoré à l'envoi.</summary>
        [JsonPropertyName("id")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public Guid? Id { get; set; }

        /// <summary>Numéro de document BC — auto-incrémenté, ignoré à l'envoi.</summary>
        [JsonPropertyName("no")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public string? No { get; set; }

        /// <summary>
        /// Numéro de projet (Chantier dans BC) — forcé par le backend depuis le JWT.
        /// Ignoré à l'envoi si null pour éviter d'écraser la valeur lors d'un PATCH.
        /// </summary>
        [JsonPropertyName("jobNo")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public string? JobNo { get; set; }

        /// <summary>Mois du pointage (ex : "Janvier").</summary>
        [JsonPropertyName("month")]
        public string? Month { get; set; }

        /// <summary>Année du pointage.</summary>
        [JsonPropertyName("year")]
        public int? Year { get; set; }

        /// <summary>Nombre total de salariés — calculé par BC, ignoré à l'envoi.</summary>
        [JsonPropertyName("totalStaff")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public int? TotalStaff { get; set; }

        /// <summary>
        /// Lignes du pointage — ignorées à l'envoi (gérées séparément).
        /// Présentes uniquement dans les réponses GET avec $expand=employeeAttendanceLines.
        /// </summary>
        [JsonPropertyName("employeeAttendanceLines")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public List<EmpAttendanceLineReadDto>? Lines { get; set; }
    }


}