using System.Text.Json.Serialization;

namespace Soroubat.Api.Models
{
    // Pour les réponses de succès (Listes)
    public class BCResponse<T>
    {
        [JsonPropertyName("@odata.context")] //[jsonPropertyName] indique qu'il faut chercher une propriété "@odata.context" dans le JSON pour la mapper à la propriété Context de cette classe
        // de plus , ca gére les caractères spéciaux dans le nom de la propriété JSON (comme @ et .) qui ne sont pas valides en tant que noms de propriétés C#
        // la varibale context est utilisée pour stocker des métadonnées sur la réponse de BC, comme le type d'entité retourné, les liens vers les ressources associées . 
        // c'est ajouté à la réponse BC quand il s'agit d'une collection d'entités (ex: GET /purchaseRequests) et pas pour une entité unique (ex: GET /purchaseRequests(id)) .
        public string Context { get; set; } = string.Empty;
        
        [JsonPropertyName("value")]
        public List<T> Value { get; set; } = new List<T>();
    }

    // Pour les réponses d'erreur
    public class BCResponseError
    {
        [JsonPropertyName("error")]
        public BCResponseErrorDetail? Error { get; set; }
    }

    public class BCResponseErrorDetail
    {
        [JsonPropertyName("code")]
        public string Code { get; set; } = string.Empty;

        [JsonPropertyName("message")]
        public string Message { get; set; } = string.Empty;
    }
}