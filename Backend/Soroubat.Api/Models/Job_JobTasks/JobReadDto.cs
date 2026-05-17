using System.Text.Json.Serialization;

namespace Soroubat.Api.Models
{
    /// <summary>
    /// Représente un projet (Job) Business Central tel qu'il est retourné par l'API JobAPI.
    /// </summary>
    public class JobReadDto
    {
        [JsonPropertyName("id")]
        public Guid Id { get; set; }

        [JsonPropertyName("no")]
        public string No { get; set; } = string.Empty;

        [JsonPropertyName("description")]
        public string Description { get; set; } = string.Empty;

        [JsonPropertyName("status")]
        public string Status { get; set; } = string.Empty;

        [JsonPropertyName("affectationMagasin")]
        public string AffectationMagasin { get; set; } = string.Empty;

        [JsonPropertyName("startingDate")]
        public DateTime? StartingDate { get; set; }

        [JsonPropertyName("endingDate")]
        public DateTime? EndingDate { get; set; }
    }
}