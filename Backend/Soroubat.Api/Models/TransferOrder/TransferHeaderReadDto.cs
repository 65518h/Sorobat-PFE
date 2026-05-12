using System.Text.Json.Serialization;

namespace Soroubat.Api.Models
{
    /// <summary>GET — en-tête ordre de transfert BC.</summary>
    public class TransferHeaderReadDto
    {
        [JsonPropertyName("id")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public Guid? Id { get; set; }

        [JsonPropertyName("no")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public string? No { get; set; }

        [JsonPropertyName("status")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public string? Status { get; set; }

        [JsonPropertyName("transferFromCode")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public string? TransferFromCode { get; set; }

        [JsonPropertyName("transferToCode")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public string? TransferToCode { get; set; }

        [JsonPropertyName("inTransitCode")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public string? InTransitCode { get; set; }

        [JsonPropertyName("postingDate")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public string? PostingDate { get; set; }

        [JsonPropertyName("observation")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public string? Observation { get; set; }

        [JsonPropertyName("chantierOrigine")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public string? ChantierOrigine { get; set; }

        [JsonPropertyName("chantierDestination")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public string? ChantierDestination { get; set; }

        [JsonPropertyName("idExpediteur")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public string? IdExpediteur { get; set; }

        [JsonPropertyName("idReceptionneur")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public string? IdReceptionneur { get; set; }

        [JsonPropertyName("numMateriel")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public string? NumMateriel { get; set; }

        [JsonPropertyName("numDemandeAchat")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public string? NumDemandeAchat { get; set; }

        [JsonPropertyName("transferLines")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public List<TransferLineReadDto>? TransferLines { get; set; }
    }
}
