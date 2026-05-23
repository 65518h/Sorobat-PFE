using System.Text.Json.Serialization;

namespace Soroubat.Api.Models
{
    /// <summary>GET — en-tête ordre de transfert BC.</summary>
    public class TransferHeaderReadDto
    {
        [JsonPropertyName("id")]
        public Guid? Id { get; set; }

        [JsonPropertyName("no")]
        public string? No { get; set; }

        [JsonPropertyName("status")]
        public string? Status { get; set; }

        [JsonPropertyName("transferFromCode")]
        public string? TransferFromCode { get; set; }

        [JsonPropertyName("transferToCode")]
        public string? TransferToCode { get; set; }

        [JsonPropertyName("postingDate")]
        public DateTime? PostingDate { get; set; }

        [JsonPropertyName("observation")]
        public string? Observation { get; set; }

        [JsonPropertyName("chantierOrigine")]
        public string? ChantierOrigine { get; set; }

        [JsonPropertyName("chantierDestination")]
        public string? ChantierDestination { get; set; }

        [JsonPropertyName("receiptDate")]
        public DateTime? ReceiptDate { get; set; }

        [JsonPropertyName("transferLines")]
        public List<TransferLineReadDto>? TransferLines { get; set; }
    }
}