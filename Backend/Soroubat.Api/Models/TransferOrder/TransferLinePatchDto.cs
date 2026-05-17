   using System.Text.Json.Serialization;

namespace Soroubat.Api.Models
{
   /// <summary>PATCH — champs modifiables par le chef (réception).</summary>
    public class TransferLinePatchDto
    {
        [JsonPropertyName("qtyToReceive")]
        public decimal? QtyToReceive { get; set; }

        // [JsonPropertyName("numVehicule")]
        // public string? NumVehicule { get; set; }
    }
}