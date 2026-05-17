using System.Text.Json.Serialization;

namespace Soroubat.Api.Models
{
    /// <summary>
    /// Représente un emplacement (Location / Magasin) Business Central
    /// tel que retourné par l'API LocationAPI (page 50177).
    /// Utilisé en lecture interne pour construire la vue stock par magasin.
    /// L'API est en lecture seule côté AL (InsertAllowed = false, ModifyAllowed = false, DeleteAllowed = false).
    /// </summary>
    public class LocationReadDto
    {
        [JsonPropertyName("id")]
        public Guid Id { get; set; }

        [JsonPropertyName("code")]
        public string Code { get; set; } = string.Empty;

        [JsonPropertyName("name")]
        public string Name { get; set; } = string.Empty;

        /// <summary>Numéro de projet auquel ce magasin est rattaché — champ de filtrage principal.</summary>
        [JsonPropertyName("affaire")]
        public string Affaire { get; set; } = string.Empty;
    }
}