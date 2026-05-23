using System.Text.Json.Serialization;

namespace Soroubat.Api.Models
{
    /// <summary>Lecture OData / GET — PurchaseRequestAPI (champs renvoyés par BC).</summary>
    public class PurchaseRequestReadDto
    {
        [JsonPropertyName("id")]
        public Guid Id { get; set; }

        [JsonPropertyName("no")]
        public string? No { get; set; }

        [JsonPropertyName("observation")]
        public string? Observation { get; set; }

        [JsonPropertyName("jobNo")]
        public string? JobNo { get; set; }

        /// <summary>Libellé du projet — calculé automatiquement par BC, non modifiable.</summary>
        [JsonPropertyName("jobDescription")]
        public string? JobDescription { get; set; }

        [JsonPropertyName("requestType")]
        public string? RequestType { get; set; }

        [JsonPropertyName("engin")]
        public string? Engin { get; set; }

        /// <summary>Description de l'engin — calculée automatiquement par BC, non modifiable.</summary>
        [JsonPropertyName("descriptionEngin")]
        public string? DescriptionEngin { get; set; }

        [JsonPropertyName("locationCode")]
        public string? LocationCode { get; set; }

        /// <summary>Date de saisie — remplie automatiquement par BC à la création, non modifiable.</summary>
        [JsonPropertyName("dateSaisie")]
        public DateTime? DateSaisie { get; set; }

        [JsonPropertyName("statut")]
        public string? Statut { get; set; }

        [JsonPropertyName("purchaseRequestLines")]
        public List<PurchaseRequestLineReadDto>? PurchaseRequestLines { get; set; }
    }
}