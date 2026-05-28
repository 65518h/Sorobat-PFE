using Newtonsoft.Json;
using System.Text.Json.Serialization;

namespace Soroubat.Api.Models
{
public class BCResponse<T>
{
    [JsonProperty("@odata.context")]
    [JsonPropertyName("@odata.context")]
    public string Context { get; set; } = string.Empty;

    [JsonProperty("value")]
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