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
        /// (retards, tâches bloquées, non démarrées, dépassements budget).
        /// </summary>
        Task<List<AlertDto>> GetSiteManagementAlertsAsync(string projectNo);

        /// <summary>
        /// Retourne les alertes liées aux demandes d'achat du projet
        /// (rejetées, en attente trop longtemps, échéance dépassée, demandes vides).
        /// </summary>
        Task<List<AlertDto>> GetPurchaseRequestAlertsAsync(string projectNo);

        /// <summary>
        /// Retourne les alertes liées aux ordres de transfert du projet
        /// (transit bloqué, non expédié, réception partielle, véhicule non assigné).
        /// </summary>
        Task<List<AlertDto>> GetTransferAlertsAsync(string projectNo);

        /// <summary>
        /// Retourne les alertes liées au stock du projet
        /// (stock négatif, stock critique, stock dormant).
        /// </summary>
        Task<List<AlertDto>> GetStockAlertsAsync(string projectNo);

        /// <summary>
        /// Retourne les alertes liées aux pointages véhicule du projet
        /// (pointage non validé, surutilisation, index incohérent, panne sans motif, consommation anormale).
        /// </summary>
        Task<List<AlertDto>> GetVehiculeAlertsAsync(string projectNo);

        /// <summary>
        /// Retourne les alertes liées aux fiches de pointage salarié du projet
        /// (fiche sans lignes, taux de présence faible, taux d'absence élevé, salarié sans pointage).
        /// </summary>
        Task<List<AlertDto>> GetAttendanceAlertsAsync(string projectNo);

        /// <summary>
        /// Retourne les alertes liées aux fiches gasoil du projet
        /// (fiche non validée, index incohérent, consommation totale anormale, ligne sans véhicule, quantité anormale).
        /// </summary>
        Task<List<AlertDto>> GetGasoilAlertsAsync(string projectNo);
    }
}