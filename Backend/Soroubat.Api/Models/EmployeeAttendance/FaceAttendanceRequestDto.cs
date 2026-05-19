using System.Text.Json.Serialization;

namespace Soroubat.Api.Models
{
    /// <summary>
    /// Corps de la requête POST pour marquer la présence d'un salarié après reconnaissance faciale.
    /// Combine la vérification d'identité et le marquage de présence en un seul appel.
    /// </summary>
    public class FaceAttendancePostDto
    {
        /// <summary>Identifiant de la fiche de pointage (en-tête) dans laquelle marquer la présence.</summary>
        [JsonPropertyName("headerId")]
        public Guid HeaderId { get; set; }

        /// <summary>Matricule du salarié à identifier et à pointer.</summary>
        [JsonPropertyName("matricule")]
        public string Matricule { get; set; } = string.Empty;

        /// <summary>Photo capturée en Base64 — comparée à la photo de référence dans BC.</summary>
        [JsonPropertyName("capturedImageBase64")]
        public string CapturedImageBase64 { get; set; } = string.Empty;

        /// <summary>Numéro du jour à marquer (1 à 31).</summary>
        [JsonPropertyName("day")]
        public int Day { get; set; }
    }
}
