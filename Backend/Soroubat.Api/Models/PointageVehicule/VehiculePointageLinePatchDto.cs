using System.Text.Json.Serialization;

namespace Soroubat.Api.Models
{
    /// <summary>PATCH — champs saisis par le chef (partiel).</summary>
    public class VehiculePointageLinePatchDto
    {
        [JsonPropertyName("vehiculeNo")]
        public string? VehiculeNo { get; set; }

        [JsonPropertyName("description")]
        public string? Description { get; set; }

        [JsonPropertyName("status")]
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
        public string? Marche { get; set; }
    }
}