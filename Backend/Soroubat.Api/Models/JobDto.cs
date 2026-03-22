using System.Text.Json.Serialization;
namespace Soroubat.Api.Models
{
    public class JobDto
    {
        [JsonPropertyName("id")]        
        public Guid id { get; set; }
        public string No { get; set; } = string.Empty;
        public string Description { get; set; } = string.Empty;
        public string Status { get; set; } = string.Empty;
        public string PersonResponsible { get; set; } = string.Empty;
        public string ProjectManager { get; set; } = string.Empty;
        public string AffectationMagasin { get; set; } = string.Empty;
    }
}