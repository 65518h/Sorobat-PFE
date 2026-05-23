using Soroubat.Api.Models;

namespace Soroubat.Api.Interfaces
{
    /// <summary>
    /// Contrat du service de génération des alertes métier.
    /// Chaque méthode analyse les données BC d'une catégorie et retourne
    /// la liste des alertes détectées pour le projet du chef connecté.
    /// En cas d'erreur BC, la méthode retourne une liste vide (pas d'exception propagée)
    /// pour ne pas bloquer les autres catégories d'alertes.
    /// </summary>
    public interface IAlertService
    {
        /// <summary>
        /// Retourne les alertes liées aux tâches du projet
        /// (retards sur date de fin, tâches non démarrées après leur date de début).
        /// </summary>
        // Task<List<AlertDto>> GetSiteManagementAlertsAsync(string projectNo);

        /// <summary>
        /// Retourne les alertes liées aux demandes d'achat du projet
        /// (rejetées, en attente d'approbation trop longtemps, demandes sans lignes).
        /// </summary>
        Task<List<AlertDto>> GetPurchaseRequestAlertsAsync(string projectNo);

        /// <summary>
        /// Retourne les alertes liées aux ordres de transfert du projet
        /// (transit bloqué trop longtemps, non expédié, réception partielle, véhicule non assigné).
        /// </summary>
        Task<List<AlertDto>> GetTransferAlertsAsync(string projectNo);

        /// <summary>
        /// Retourne les alertes liées au stock du projet
        /// (stock négatif, stock critique faible, stock dormant sans mouvement récent).
        /// </summary>
        Task<List<AlertDto>> GetStockAlertsAsync(string projectNo);

        /// <summary>
        /// Retourne les alertes liées aux pointages véhicule du projet
        /// (pointage non validé trop longtemps, surutilisation horaire,
        /// index kilométrique/horaire incohérent, consommation carburant anormale).
        /// </summary>
        Task<List<AlertDto>> GetVehiculeAlertsAsync(string projectNo);

        /// <summary>
        /// Retourne les alertes liées aux fiches gasoil du projet
        /// (fiche non validée trop longtemps, consommation totale journalière anormale,
        /// ligne sans véhicule assigné, quantité par ligne anormalement élevée).
        /// </summary>
        Task<List<AlertDto>> GetGasoilAlertsAsync(string projectNo);

        /// <summary>
        /// Retourne les alertes liées aux fiches de pointage salarié du projet
        /// (fiche sans lignes de pointage, salarié présent dans la fiche sans aucun jour saisi).
        /// </summary>
        Task<List<AlertDto>> GetAttendanceAlertsAsync(string projectNo);
    }
}