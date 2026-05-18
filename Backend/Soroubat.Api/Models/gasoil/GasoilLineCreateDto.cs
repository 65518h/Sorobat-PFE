using System.Text.Json.Serialization;

namespace Soroubat.Api.Models
{
    /// <summary>POST — création ligne (projectNo imposé par le backend depuis le JWT, non envoyable par le client).</summary>
    public class GasoilLineCreateDto
    {
        /// <summary>N° document de la fiche gasoil parente — obligatoire pour lier la ligne à son en-tête.</summary>
        [JsonPropertyName("documentNo")]
        public string? DocumentNo { get; set; }

        /// <summary>
        /// N° de ligne — calculé par le backend (Max + 10 000) et envoyé à BC.
        /// Doit rester dans le DTO car la page AL n'auto-génère pas lineNo.
        /// </summary>


        [JsonPropertyName("vehicleNo")]
        public string? VehicleNo { get; set; }

        [JsonPropertyName("quantity")]
        public decimal? Quantity { get; set; }

        [JsonPropertyName("maxConsommation")]
        public decimal? MaxConsommation { get; set; }

        [JsonPropertyName("time")]
        public string? Time { get; set; }

        [JsonPropertyName("indexType")]
        public string? IndexType { get; set; }

        [JsonPropertyName("valeurCompteur")]
        public decimal? ValeurCompteur { get; set; }

        [JsonPropertyName("driver")]
        public string? Driver { get; set; }

        [JsonPropertyName("destination")]
        public string? Destination { get; set; }

        [JsonPropertyName("observation")]
        public string? Observation { get; set; }
    }
}