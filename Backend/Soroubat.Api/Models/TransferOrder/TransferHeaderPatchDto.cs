using System.Text.Json.Serialization;

namespace Soroubat.Api.Models
{
    /// <summary>
    /// PATCH en-tête — seul <c>receiptDate</c> est modifiable par le chef de chantier
    /// (Editable = true côté AL TransferHeaderAPI50136).
    /// Les champs <c>status</c>, <c>postingDate</c> et <c>observation</c> sont également éditables
    /// côté AL mais restent sous contrôle BC — non exposés ici.
    /// </summary>
    public class TransferHeaderPatchDto
    {
        [JsonPropertyName("receiptDate")]
        public String? ReceiptDate { get; set; }
    }
}