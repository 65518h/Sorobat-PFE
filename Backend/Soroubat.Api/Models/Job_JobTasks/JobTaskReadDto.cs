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

        [JsonPropertyName("dateDebut")]
        public DateTime? DateDebut { get; set; }

        [JsonPropertyName("dateFin")]
        public DateTime? DateFin { get; set; }

        /// <summary>Avancement saisi manuellement par le chef de chantier (0–100 %).</summary>
        [JsonPropertyName("progressPct")]
        public decimal ProgressPct { get; set; }

        /// <summary>Avancement calculé automatiquement depuis les quantités réalisées (lecture seule).</summary>
        [JsonPropertyName("taskProgressPct")]
        public decimal TaskProgressPct { get; set; }

        [JsonPropertyName("quantityShipped")]
        public decimal QuantityShipped { get; set; }

        [JsonPropertyName("initialQuantity")]
        public decimal InitialQuantity { get; set; }

        [JsonPropertyName("initialUoM")]
        public string InitialUoM { get; set; } = string.Empty;

        [JsonPropertyName("initialAmount")]
        public decimal InitialAmount { get; set; }

        [JsonPropertyName("usageTotalCost")]
        public decimal UsageTotalCost { get; set; }

        [JsonPropertyName("isBlocked")]
        public bool IsBlocked { get; set; }
    }
}