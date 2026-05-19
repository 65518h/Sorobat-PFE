using System.Text.Json.Serialization;

namespace Soroubat.Api.Models
{
    /// <summary>
    /// Représente un Chef de Chantier tel qu'il est retourné par l'API Business Central.
    /// </summary>
    public class ChefChantierReadDto
    {
        [JsonPropertyName("id")]
        public Guid Id { get; set; }

        [JsonPropertyName("nomEtPrenom")]
        public string NomEtPrenom { get; set; } = string.Empty;

        [JsonPropertyName("email")]
        public string Email { get; set; } = string.Empty;

        [JsonPropertyName("numProjet")]
        public string NumProjet { get; set; } = string.Empty;

        [JsonPropertyName("actif")]
        public bool Actif { get; set; }

        [JsonPropertyName("idApprobateur")]
        public string IdApprobateur { get; set; } = string.Empty;
    }
}