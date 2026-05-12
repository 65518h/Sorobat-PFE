using System.Text.Json.Serialization;

namespace Soroubat.Api.Models
{
    /// <summary>GET — en-tête fiche gasoil BC (page 50150).</summary>
    public class GasoilHeaderReadDto
    {
        [JsonPropertyName("id")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public Guid? Id { get; set; }

        [JsonPropertyName("documentNo")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public string? DocumentNo { get; set; }

        [JsonPropertyName("date")]
        public string? Date { get; set; }

        [JsonPropertyName("locationCode")]
        public string? LocationCode { get; set; }

        [JsonPropertyName("jobNo")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public string? JobNo { get; set; }

        [JsonPropertyName("status")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public string? Status { get; set; }

        [JsonPropertyName("fileNo")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public string? FileNo { get; set; }

        [JsonPropertyName("startIndex")]
        public decimal? StartIndex { get; set; }

        [JsonPropertyName("endIndex")]
        public decimal? EndIndex { get; set; }

        [JsonPropertyName("gasoilLines")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public List<GasoilLineReadDto>? Lines { get; set; }
    }




}
