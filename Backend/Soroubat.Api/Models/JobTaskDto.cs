using System.Text.Json.Serialization;

namespace Soroubat.Api.Models
{
    public class JobTaskDto
    {
        [JsonPropertyName("id")]
        public Guid id { get; set; }
        public string JobNo { get; set; } = string.Empty;
        public string TaskNo { get; set; } = string.Empty;
        public string Description { get; set; } = string.Empty;
        public DateTime? DateDebut { get; set; }
        public DateTime? DateFin { get; set; }
        public decimal ProgressPct { get; set; }
        public decimal TaskProgressPct { get; set; }
        public decimal QuantityShipped { get; set; }
        public decimal InitialQuantity { get; set; }
        public string InitialUoM { get; set; } = string.Empty;
        public decimal InitialAmount { get; set; }
        public bool IsBlocked { get; set; }
    }

}