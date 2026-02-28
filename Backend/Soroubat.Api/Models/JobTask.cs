using System.Text.Json.Serialization; 

namespace Soroubat.Api.Models
{
    public class JobTaskDto
    {
        public string JobNo { get; set; } = string.Empty; // { get; set; } est une syntaxe de propriété auto-implémentée en C#. Cela signifie que le compilateur génère automatiquement un champ privé pour stocker la valeur de la propriété, ainsi que les méthodes d'accès get et set.
        public string TaskNo { get; set; } = string.Empty;
        public string Description { get; set; } = string.Empty;
        public DateTime? DateDebut { get; set; } // Le point d'interrogation signifie que la date est nullable.
        public DateTime? DateFin { get; set; }
        public decimal ProgressPct { get; set; }
        public decimal TaskProgressPct { get; set; }
        public decimal QuantityShipped { get; set; }
        public bool IsBlocked { get; set; }
    }

    public class BCResponse<T>
    {
        [JsonPropertyName("@odata.context")] //@odata.context est une convention utilisée dans les API RESTful pour fournir des métadonnées sur la réponse. Cela peut inclure des informations sur la structure des données, les types de données, etc. 
        public string Context { get; set; } = string.Empty;
        
        [JsonPropertyName("value")] // value est la liste des éléments retournés par l'API. Le type de cette liste est générique (T), ce qui signifie que vous pouvez spécifier n'importe quel type de données lorsque vous utilisez cette classe.
        public List<T> Value { get; set; } = new List<T>();
    }
}