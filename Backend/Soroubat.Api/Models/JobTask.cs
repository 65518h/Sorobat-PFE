using System.Text.Json.Serialization; // <--- LA LIGNE MANQUANTE POUR LE JSON

namespace Soroubat.Api.Models
{
    public class JobTaskDto
    {
        public string JobNo { get; set; } = string.Empty;
        public string TaskNo { get; set; } = string.Empty;
        public string Description { get; set; } = string.Empty;
        public DateTime? DateDebut { get; set; }
        public DateTime? DateFin { get; set; }
        public decimal ProgressPct { get; set; }
        public decimal TaskProgressPct { get; set; }
        public decimal QuantityShipped { get; set; }
        public bool IsBlocked { get; set; }
    }

    public class BCResponse<T>
    {
        [JsonPropertyName("@odata.context")]
        public string Context { get; set; } = string.Empty;
        
        [JsonPropertyName("value")]
        public List<T> Value { get; set; } = new List<T>();
    }
}