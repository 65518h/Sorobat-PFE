using System.Text.Json.Serialization;

namespace Soroubat.Api.Models
{
    /// <summary>
    /// Représente une alerte générée par le système à partir des données BC.
    /// </summary>
    public class AlertDto
    {
        /// <summary>Identifiant unique de l'alerte (généré côté backend).</summary>
        [JsonPropertyName("id")]
        public Guid Id { get; set; } = Guid.NewGuid();

        /// <summary>
        /// Catégorie de l'alerte.
        /// SiteManagement   : "TaskDelay" | "TaskNotStarted"
        /// PurchaseRequest  : "PurchaseRequestRejected" | "PurchaseRequestPendingTooLong" | "PurchaseRequestEmpty"
        /// Transfer         : "TransferStuckInTransit" | "TransferNotShipped" | "TransferPartialReceipt" | "TransferNoVehicle"
        /// Stock            : "StockNegatif" | "StockCritique" | "StockDormant"
        /// Vehicule         : "PointageNonValide" | "VehiculeSurutilise" | "IndexIncoherent" | "ConsommationAnormale"
        /// Gasoil           : "GasoilFicheNonValidee" | "GasoilConsommationTotaleAnormale" | "GasoilLigneSansVehicule" | "GasoilQuantiteLigneAnormale"
        /// Attendance       : "AttendanceFicheSansLignes" | "AttendanceSalarieNonPointe"
        /// </summary>
        [JsonPropertyName("type")]
        public string Type { get; set; } = string.Empty;

        /// <summary>
        /// Niveau de sévérité.
        /// Valeurs possibles : "Info" | "Warning" | "Critical"
        /// </summary>
        [JsonPropertyName("severity")]
        public string Severity { get; set; } = string.Empty;

        /// <summary>Titre court affiché dans le badge de notification Angular.</summary>
        [JsonPropertyName("title")]
        public string Title { get; set; } = string.Empty;

        /// <summary>Message détaillé affiché dans le panneau d'alertes.</summary>
        [JsonPropertyName("message")]
        public string Message { get; set; } = string.Empty;

        /// <summary>
        /// Numéro métier de l'entité concernée (TaskNo, documentNo, itemNo…).
        /// Permet au frontend de naviguer vers la ressource en question.
        /// </summary>
        [JsonPropertyName("relatedEntityNo")]
        public string RelatedEntityNo { get; set; } = string.Empty;

        /// <summary>SystemId BC de l'entité concernée — utile pour un PATCH direct depuis le frontend.</summary>
        [JsonPropertyName("relatedEntityId")]
        public Guid? RelatedEntityId { get; set; }

        /// <summary>Horodatage de la détection (UTC).</summary>
        [JsonPropertyName("detectedAt")]
        public DateTime DetectedAt { get; set; } = DateTime.UtcNow;
    }
}