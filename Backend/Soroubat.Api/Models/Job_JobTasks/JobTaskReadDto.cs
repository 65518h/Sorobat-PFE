using System.Text.Json.Serialization;

namespace Soroubat.Api.Models
{
    /// <summary>
    /// Représente une tâche de projet (Job Task) Business Central.
    /// Lecture seule sauf <see cref="ProgressPct"/> qui peut être mis à jour par le chef de chantier.
    /// </summary>
    public class JobTaskReadDto
    {
        [JsonPropertyName("id")]
        public Guid Id { get; set; }

        [JsonPropertyName("jobNo")]
        public string JobNo { get; set; } = string.Empty;

        [JsonPropertyName("taskNo")]
        public string TaskNo { get; set; } = string.Empty;

        [JsonPropertyName("description")]
        public string Description { get; set; } = string.Empty;

        [JsonPropertyName("dateFin")]
        public DateTime? DateFin { get; set; }

        /// <summary>Avancement saisi manuellement par le chef de chantier (0–100 %).</summary>
        [JsonPropertyName("progressPct")]
        public decimal ProgressPct { get; set; }

        
    }
}