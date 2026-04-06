using System;
using System.Collections.Generic;
using System.Text.Json.Serialization;
namespace Soroubat.Api.Models
{
    public class PurchaseRequestDto
    {
        [JsonPropertyName("id")]
        public Guid? Id { get; set; }

        [JsonPropertyName("no")]
        public string? No { get; set; }

        [JsonPropertyName("jobNo")]
        public string JobNo { get; set; }

        [JsonPropertyName("jobDescription")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public string? JobDescription { get; set; }

        [JsonPropertyName("requesterId")]
        public string RequesterId { get; set; }

        [JsonPropertyName("requestType")]
        public string RequestType { get; set; }

        [JsonPropertyName("engin")]
        public string Engin { get; set; }

        [JsonPropertyName("descriptionEngin")]
        public string? DescriptionEngin { get; set; } // on peut laisser cette propriété nullable car elle n'est pas obligatoire dans BC, et on peut ne pas vouloir l'afficher dans l'interface si elle est vide. De plus, cela évite les problèmes de désérialisation si BC ne la retourne pas systématiquement.

        [JsonPropertyName("orderDate")]
        public DateOnly? OrderDate { get; set; }

        [JsonPropertyName("dueDate")]
        public DateOnly? DueDate { get; set; }

        [JsonPropertyName("status")]
        public string Status { get; set; }

        [JsonPropertyName("amount")]
        public decimal Amount { get; set; }

        [JsonPropertyName("service")]
        public string Service { get; set; }

        // Navigation property pour le Deep Insert
        [JsonPropertyName("purchaseRequestLines")]
        public List<PurchaseRequestLineDto> PurchaseRequestLines { get; set; } = new();
    }
}