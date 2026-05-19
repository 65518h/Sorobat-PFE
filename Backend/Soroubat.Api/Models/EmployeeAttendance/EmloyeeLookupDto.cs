using System.Text.Json.Serialization;

namespace Soroubat.Api.Models
{
    /// <summary>
    /// Représente un salarié tel que retourné par l'API Business Central EmployeeLookupAPI (page 50154).
    /// Utilisé en lecture interne uniquement — jamais retourné directement au client.
    /// L'API est en lecture seule côté AL (InsertAllowed = false, ModifyAllowed = false, DeleteAllowed = false).
    /// </summary>
    public class EmployeeLookupDto
    {
        [JsonPropertyName("id")]
        public Guid Id { get; set; }

        [JsonPropertyName("matricule")]
        public string Matricule { get; set; } = string.Empty;

        [JsonPropertyName("firstName")]
        public string FirstName { get; set; } = string.Empty;

        [JsonPropertyName("lastName")]
        public string LastName { get; set; } = string.Empty;

        [JsonPropertyName("fonction")]
        public string Fonction { get; set; } = string.Empty;

        [JsonPropertyName("chantier")]
        public string Chantier { get; set; } = string.Empty;

        /// <summary>Photo de référence du salarié encodée en Base64 — utilisée pour la reconnaissance faciale.</summary>
        [JsonPropertyName("imageBase64")]
        public string ImageBase64 { get; set; } = string.Empty;
    }

    /// <summary>Corps de la requête POST pour la vérification d'identité par reconnaissance faciale.</summary>
    public class FaceVerificationPostDto
    {
        [JsonPropertyName("matricule")]
        public string Matricule { get; set; } = string.Empty;

        [JsonPropertyName("capturedImageBase64")]
        public string CapturedImageBase64 { get; set; } = string.Empty;
    }

    /// <summary>
    /// Corps de la requête POST pour marquer la présence d'un salarié après reconnaissance faciale.
    /// Combine la vérification d'identité et le marquage de présence en un seul appel.
    /// </summary>

}