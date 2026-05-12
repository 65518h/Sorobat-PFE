using System.Text.Json.Serialization;

namespace Soroubat.Api.Models
{
    /// <summary>GET — ligne pointage véhicule BC (page 50149).</summary>
    public class VehiculePointageLineReadDto
    {
        [JsonPropertyName("id")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public Guid? Id { get; set; }

        [JsonPropertyName("documentNo")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public string? DocumentNo { get; set; }

        [JsonPropertyName("vehiculeNo")]
        public string? VehiculeNo { get; set; }

        [JsonPropertyName("description")]
        public string? Description { get; set; }

        [JsonPropertyName("status")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public string? Status { get; set; }

        [JsonPropertyName("hoursWorked")]
        public decimal? HoursWorked { get; set; }

        [JsonPropertyName("startIndex")]
        public decimal? StartIndex { get; set; }

        [JsonPropertyName("endIndex")]
        public decimal? EndIndex { get; set; }

        [JsonPropertyName("fuelConsumed")]
        public decimal? FuelConsumed { get; set; }

        [JsonPropertyName("breakdownMotiv")]
        public string? BreakdownMotiv { get; set; }

        [JsonPropertyName("marche")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public string? Marche { get; set; }
    }


}
