using System.Text.Json.Serialization;

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
        public decimal InitialQuantity { get; set; }
        public string InitialUoM { get; set; } = string.Empty;
        public decimal InitialAmount { get; set; }
        public bool IsBlocked { get; set; }
    }

    public class BCResponse<T>
    {
        [JsonPropertyName("@odata.context")] //json property name pour mapper le champ "@odata.context" de la réponse BC à la propriété Context de cette classe générique
        public string Context { get; set; } = string.Empty;
        
        [JsonPropertyName("value")]
        public List<T> Value { get; set; } = new List<T>();
    }
}