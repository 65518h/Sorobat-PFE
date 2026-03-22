using System;
using System.Collections.Generic;
using System.Text.Json.Serialization;

namespace Soroubat.Api.Models
{
    public class PurchaseRequestLine
    {
        [JsonPropertyName("id")]
        public Guid Id { get; set; }

        [JsonPropertyName("documentNo")]
        public string DocumentNo { get; set; }

        [JsonPropertyName("lineNo")]
        public int LineNo { get; set; }

        [JsonPropertyName("transferer")]
        public bool Transferer { get; set; } // Correspond au champ AL corrigé sans accent

        [JsonPropertyName("type")]
        public string Type { get; set; }

        [JsonPropertyName("no")]
        public string No { get; set; }

        [JsonPropertyName("description")]
        public string Description { get; set; }

        [JsonPropertyName("description2")]
        public string Description2 { get; set; }

        [JsonPropertyName("quantity")]
        public decimal Quantity { get; set; }

        [JsonPropertyName("unitOfMeasureCode")]
        public string UnitOfMeasureCode { get; set; }

        [JsonPropertyName("locationCode")]
        public string LocationCode { get; set; }

        [JsonPropertyName("variantCode")]
        public string VariantCode { get; set; }

        [JsonPropertyName("jobNo")]
        public string JobNo { get; set; }

        [JsonPropertyName("jobTaskNo")]
        public string JobTaskNo { get; set; }

        [JsonPropertyName("engin")]
        public string Engin { get; set; }

        [JsonPropertyName("lineAmount")]
        public decimal LineAmount { get; set; }
    }
}