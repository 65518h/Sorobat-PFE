using System.Text.Json.Serialization;

namespace Soroubat.Api.Models
{
    /// <summary>GET — ligne ordre de transfert BC.</summary>
    public class TransferLineReadDto
    {
        [JsonPropertyName("id")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public Guid? Id { get; set; }

        [JsonPropertyName("documentNo")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public string? DocumentNo { get; set; }

        [JsonPropertyName("lineNo")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public int? LineNo { get; set; }

        [JsonPropertyName("itemNo")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public string? ItemNo { get; set; }

        [JsonPropertyName("description")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public string? Description { get; set; }

        [JsonPropertyName("quantity")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public decimal? Quantity { get; set; }

        [JsonPropertyName("quantityShipped")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public decimal? QuantityShipped { get; set; }

        [JsonPropertyName("quantityReceived")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public decimal? QuantityReceived { get; set; }

        [JsonPropertyName("qtyToReceive")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public decimal? QtyToReceive { get; set; }

        [JsonPropertyName("unitOfMeasure")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public string? UnitOfMeasure { get; set; }

        [JsonPropertyName("stock")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public decimal? Stock { get; set; }

        [JsonPropertyName("numVehicule")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public string? NumVehicule { get; set; }

        [JsonPropertyName("affaire")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public string? Affaire { get; set; }

        [JsonPropertyName("descriptionSoroubat")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public string? DescriptionSoroubat { get; set; }
    }

 
}
