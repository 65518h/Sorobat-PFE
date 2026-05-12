using System.Text.Json.Serialization;

namespace Soroubat.Api.Models
{
    /// <summary>POST api/attendance/scan-presence — marquage présence après reconnaissance faciale.</summary>
    public class FaceAttendancePostDto
    {
        [JsonPropertyName("matricule")]
        public string? Matricule { get; set; }

        [JsonPropertyName("capturedImageBase64")]
        public string? CapturedImageBase64 { get; set; }

        [JsonPropertyName("headerId")]
        public Guid HeaderId { get; set; }

        [JsonPropertyName("day")]
        public int Day { get; set; }
    }
}
