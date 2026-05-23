using Soroubat.Api.Interfaces;
using Soroubat.Api.Models;

namespace Soroubat.Api.Services
{
    /// <summary>
    /// Génère les alertes métier pour toutes les catégories du projet.
    /// Chaque méthode est autonome et retourne une liste vide en cas d'erreur BC
    /// pour ne pas bloquer les autres catégories lors d'un appel agrégé.
    /// Les seuils sont définis comme constantes privées pour faciliter la maintenance.
    /// </summary>
    public class AlertService : IAlertService
    {
        private readonly ISiteManagementService  _siteService;
        private readonly IPurchaseRequestService _purchaseService;
        private readonly ITransferService        _transferService;
        private readonly IStockService           _stockService;
        private readonly IVehiculeService        _vehiculeService;
        private readonly IGasoilService          _gasoilService;
        private readonly IEmpAttendanceService   _attendanceService;
        private readonly ILogger<AlertService>   _logger;

        // ── Seuils SiteManagement ─────────────────────────────────────────────
        /// <summary>Nombre de jours de retard avant alerte Warning sur une tâche.</summary>
        private const int TaskDelayWarningDays  = 3;
        /// <summary>Nombre de jours de retard avant alerte Critical sur une tâche.</summary>
        private const int TaskDelayCriticalDays = 7;
        /// <summary>Avancement minimal attendu (%) pour une tâche dont la date de fin est dépassée.</summary>
        private const decimal TaskMinProgressPct = 100m;

        // ── Seuils PurchaseRequest ────────────────────────────────────────────
        /// <summary>Nombre de jours maximum autorisé en attente d'approbation avant Warning.</summary>
        private const int PendingApprovalWarningDays  = 5;
        /// <summary>Nombre de jours maximum autorisé en attente d'approbation avant Critical.</summary>
        private const int PendingApprovalCriticalDays = 10;

        // ── Seuils Transfer ───────────────────────────────────────────────────
        /// <summary>Nombre de jours maximum en transit avant Warning.</summary>
        private const int InTransitWarningDays  = 3;
        /// <summary>Nombre de jours maximum en transit avant Critical.</summary>
        private const int InTransitCriticalDays = 7;
        /// <summary>Nombre de jours maximum sans expédition (statut Open) avant Warning.</summary>
        private const int OpenTransferMaxDays   = 5;
        /// <summary>Pourcentage minimal de réception pour ne pas déclencher une alerte réception partielle.</summary>
        private const decimal PartialReceiptMinPct = 80m;

        // ── Seuils Stock ──────────────────────────────────────────────────────
        /// <summary>Quantité en dessous de laquelle le stock est considéré critique.</summary>
        private const decimal StockCritiqueMin  = 5m;
        /// <summary>Nombre de jours sans mouvement avant alerte stock dormant.</summary>
        private const int     StockDormantJours = 30;

        // ── Seuils Pointage Véhicule ──────────────────────────────────────────
        /// <summary>Nombre d'heures journalières maximum avant alerte surutilisation.</summary>
        private const decimal HeuresMaxJournee      = 12m;
        /// <summary>Nombre de jours sans validation avant alerte pointage non validé.</summary>
        private const int     PointageOuvertMaxJours = 2;
        /// <summary>Ratio carburant (L/h) maximum avant alerte consommation anormale.</summary>
        private const decimal CarburantMaxParHeure  = 15m;

        // ── Seuils Gasoil ─────────────────────────────────────────────────────
        /// <summary>Nombre de jours sans validation avant alerte fiche non validée.</summary>
        private const int     FicheEnCoursMaxJours     = 2;
        /// <summary>Consommation totale journalière (L) au-delà de laquelle une alerte est déclenchée.</summary>
        private const decimal ConsommationTotaleMax    = 500m;
        /// <summary>Quantité par ligne (L) au-delà de laquelle une alerte est déclenchée.</summary>
        private const decimal ConsommationLigneMax     = 150m;

        public AlertService(
            ISiteManagementService  siteService,
            IPurchaseRequestService purchaseService,
            ITransferService        transferService,
            IStockService           stockService,
            IVehiculeService        vehiculeService,
            IGasoilService          gasoilService,
            IEmpAttendanceService   attendanceService,
            ILogger<AlertService>   logger)
        {
            _siteService       = siteService;
            _purchaseService   = purchaseService;
            _transferService   = transferService;
            _stockService      = stockService;
            _vehiculeService   = vehiculeService;
            _gasoilService     = gasoilService;
            _attendanceService = attendanceService;
            _logger            = logger;
        }

        // ── Méthode utilitaire de tri ─────────────────────────────────────────

        /// <summary>
        /// Trie les alertes par sévérité décroissante (Critical → Warning → Info),
        /// puis par date de détection croissante.
        /// </summary>
        private static List<AlertDto> SortAlerts(List<AlertDto> alerts)
        {
            return alerts
                .OrderBy(a => a.Severity == "Critical" ? 0 : a.Severity == "Warning" ? 1 : 2)
                .ThenBy(a => a.DetectedAt)
                .ToList();
        }

        // ────────────────────────────────────────────────────────────────────────
        // PARTIE 1 — SiteManagement (Tâches Projet)
        // ────────────────────────────────────────────────────────────────────────

        /// <summary>
        /// Alertes sur les tâches du projet :
        ///   - Tâche en retard : date de fin dépassée et avancement inférieur à 100 %.
        ///   - Tâche non démarrée : date de fin dans moins de X jours et avancement à 0 %.
        /// </summary>
        // public async Task<List<AlertDto>> GetSiteManagementAlertsAsync(string projectNo)
        // {
        //     var alerts = new List<AlertDto>();
        //     List<JobTaskReadDto> tasks;

        //     try
        //     {
        //         tasks = await _siteService.GetMyTasksAsync(projectNo);
        //     }
        //     catch (Exception ex)
        //     {
        //         _logger.LogWarning(ex, "[AlertService] Impossible de récupérer les tâches pour {ProjectNo}", projectNo);
        //         return alerts;
        //     }

        //     var today = DateTime.Today;

        //     foreach (var task in tasks)
        //     {
        //         // ── ALERTE 1 : Tâche en retard ──────────────────────────────────────
        //         // La date de fin est dépassée et la tâche n'est pas à 100 %.
        //         if (task.DateFin.HasValue
        //             && task.DateFin.Value.Date < today
        //             && task.ProgressPct < TaskMinProgressPct)
        //         {
        //             int joursRetard = (today - task.DateFin.Value.Date).Days;
        //             string severity = joursRetard >= TaskDelayCriticalDays ? "Critical" : "Warning";

        //             alerts.Add(new AlertDto
        //             {
        //                 Type            = "TaskDelay",
        //                 Severity        = severity,
        //                 Title           = $"Tâche en retard — {task.TaskNo}",
        //                 Message         = $"La tâche \"{task.Description}\" (N° {task.TaskNo}) "
        //                                 + $"devait être terminée le {task.DateFin.Value:dd/MM/yyyy}. "
        //                                 + $"Retard : {joursRetard} jour(s). "
        //                                 + $"Avancement actuel : {task.ProgressPct:F0} %.",
        //                 RelatedEntityNo = task.TaskNo,
        //                 RelatedEntityId = task.Id
        //             });
        //         }

        //         // ── ALERTE 2 : Tâche non démarrée — échéance proche ─────────────────
        //         // La date de fin arrive dans moins de TaskDelayWarningDays jours
        //         // mais l'avancement est encore à 0 %.
        //         if (task.DateFin.HasValue
        //             && task.DateFin.Value.Date >= today
        //             && task.ProgressPct == 0m)
        //         {
        //             int joursRestants = (task.DateFin.Value.Date - today).Days;

        //             if (joursRestants <= TaskDelayWarningDays)
        //             {
        //                 alerts.Add(new AlertDto
        //                 {
        //                     Type            = "TaskNotStarted",
        //                     Severity        = "Warning",
        //                     Title           = $"Tâche non démarrée — {task.TaskNo}",
        //                     Message         = $"La tâche \"{task.Description}\" (N° {task.TaskNo}) "
        //                                     + $"n'a pas encore démarré (avancement : 0 %) "
        //                                     + $"alors que la date de fin est dans {joursRestants} jour(s) "
        //                                     + $"(le {task.DateFin.Value:dd/MM/yyyy}).",
        //                     RelatedEntityNo = task.TaskNo,
        //                     RelatedEntityId = task.Id
        //                 });
        //             }
        //         }
        //     }

        //     return SortAlerts(alerts);
        // }

        // ────────────────────────────────────────────────────────────────────────
        // PARTIE 2 — PurchaseRequest (Demandes d'Achat)
        // ────────────────────────────────────────────────────────────────────────

        /// <summary>
        /// Alertes sur les demandes d'achat :
        ///   - Demande rejetée : statut "Rejected", action requise.
        ///   - En attente trop longtemps : statut "To Approve" depuis plus de X jours
        ///     (basé sur DateSaisie, seule date disponible dans le DTO).
        ///   - Demande sans lignes : statut "Open" mais aucune ligne créée.
        /// </summary>
        public async Task<List<AlertDto>> GetPurchaseRequestAlertsAsync(string projectNo)
        {
            var alerts = new List<AlertDto>();
            IEnumerable<PurchaseRequestReadDto> requests;

            try
            {
                requests = await _purchaseService.GetAllRequestsAsync(projectNo);
            }
            catch (Exception ex)
            {
                _logger.LogWarning(ex, "[AlertService] Impossible de récupérer les demandes d'achat pour {ProjectNo}", projectNo);
                return alerts;
            }

            var today = DateTime.Today;

            foreach (var req in requests)
            {
                // ── ALERTE 1 : Demande rejetée non traitée ──────────────────────────
                if (string.Equals(req.Statut, "Rejected", StringComparison.OrdinalIgnoreCase))
                {
                    alerts.Add(new AlertDto
                    {
                        Type            = "PurchaseRequestRejected",
                        Severity        = "Critical",
                        Title           = $"Demande rejetée — {req.No}",
                        Message         = $"La demande d'achat n° {req.No} a été rejetée. "
                                        + "Veuillez la corriger et la re-soumettre pour approbation.",
                        RelatedEntityNo = req.No ?? string.Empty,
                        RelatedEntityId = req.Id
                    });
                    continue;
                }

                // ── ALERTE 2 : En attente d'approbation trop longtemps ──────────────
                // DateSaisie est la seule date disponible dans PurchaseRequestReadDto.
                if (string.Equals(req.Statut, "To Approve", StringComparison.OrdinalIgnoreCase)
                    && req.DateSaisie.HasValue)
                {
                    int joursAttente = (today - req.DateSaisie.Value.Date).Days;

                    if (joursAttente > PendingApprovalWarningDays)
                    {
                        string severity = joursAttente >= PendingApprovalCriticalDays ? "Critical" : "Warning";

                        alerts.Add(new AlertDto
                        {
                            Type            = "PurchaseRequestPendingTooLong",
                            Severity        = severity,
                            Title           = $"Approbation en attente — {req.No}",
                            Message         = $"La demande d'achat n° {req.No} est en attente d'approbation "
                                            + $"depuis {joursAttente} jour(s) "
                                            + $"(saisie le {req.DateSaisie.Value:dd/MM/yyyy}). "
                                            + "Relancez le responsable.",
                            RelatedEntityNo = req.No ?? string.Empty,
                            RelatedEntityId = req.Id
                        });
                    }
                }

                // ── ALERTE 3 : Demande ouverte sans lignes ───────────────────────────
                // PurchaseRequestLines null ou vide = aucun article saisi.
                if (string.Equals(req.Statut, "Open", StringComparison.OrdinalIgnoreCase)
                    && (req.PurchaseRequestLines == null || !req.PurchaseRequestLines.Any()))
                {
                    alerts.Add(new AlertDto
                    {
                        Type            = "PurchaseRequestEmpty",
                        Severity        = "Warning",
                        Title           = $"Demande incomplète — {req.No}",
                        Message         = $"La demande d'achat n° {req.No} est ouverte "
                                        + "mais ne contient aucune ligne article. "
                                        + "Ajoutez des lignes ou supprimez cette demande.",
                        RelatedEntityNo = req.No ?? string.Empty,
                        RelatedEntityId = req.Id
                    });
                }
            }

            return SortAlerts(alerts);
        }

        // ────────────────────────────────────────────────────────────────────────
        // PARTIE 3 — Transfer (Ordres de Transfert)
        // ────────────────────────────────────────────────────────────────────────

        /// <summary>
        /// Alertes sur les ordres de transfert :
        ///   - Transfert bloqué en transit trop longtemps.
        ///   - Transfert ouvert non expédié depuis trop longtemps.
        ///   - Réception partielle : quantité reçue inférieure à X % de la quantité expédiée.
        ///   - Véhicule non assigné sur une ligne d'un transfert actif.
        /// </summary>
        public async Task<List<AlertDto>> GetTransferAlertsAsync(string projectNo)
        {
            var alerts = new List<AlertDto>();
            IEnumerable<TransferHeaderReadDto> transfers;

            try
            {
                transfers = await _transferService.GetAllTransfersWithLinesAsync(projectNo);
            }
            catch (Exception ex)
            {
                _logger.LogWarning(ex, "[AlertService] Impossible de récupérer les transferts pour {ProjectNo}", projectNo);
                return alerts;
            }

            var today = DateTime.Today;

            foreach (var transfer in transfers)
            {
                // PostingDate est un DateTime? dans TransferHeaderReadDto — pas de parsing nécessaire.
                DateTime? postingDate = transfer.PostingDate;

                // ── ALERTE 1 : Transfert bloqué en transit trop longtemps ────────────
                if (string.Equals(transfer.Status, "In Transit", StringComparison.OrdinalIgnoreCase)
                    && postingDate.HasValue)
                {
                    int joursEnRoute = (today - postingDate.Value.Date).Days;

                    if (joursEnRoute > InTransitWarningDays)
                    {
                        string severity = joursEnRoute >= InTransitCriticalDays ? "Critical" : "Warning";

                        alerts.Add(new AlertDto
                        {
                            Type            = "TransferStuckInTransit",
                            Severity        = severity,
                            Title           = $"Transfert bloqué en transit — {transfer.No}",
                            Message         = $"L'ordre de transfert n° {transfer.No} "
                                            + $"(de {transfer.TransferFromCode} vers {transfer.TransferToCode}) "
                                            + $"est en transit depuis {joursEnRoute} jour(s) "
                                            + $"(expédié le {postingDate.Value:dd/MM/yyyy}). "
                                            + "Vérifiez la livraison avec le transporteur.",
                            RelatedEntityNo = transfer.No ?? string.Empty,
                            RelatedEntityId = transfer.Id
                        });
                    }
                }

                // ── ALERTE 2 : Transfert ouvert sans expédition ──────────────────────
                if (string.Equals(transfer.Status, "Open", StringComparison.OrdinalIgnoreCase)
                    && postingDate.HasValue)
                {
                    int joursOuvert = (today - postingDate.Value.Date).Days;

                    if (joursOuvert > OpenTransferMaxDays)
                    {
                        alerts.Add(new AlertDto
                        {
                            Type            = "TransferNotShipped",
                            Severity        = "Warning",
                            Title           = $"Transfert non expédié — {transfer.No}",
                            Message         = $"L'ordre de transfert n° {transfer.No} est ouvert depuis {joursOuvert} jour(s) "
                                            + $"sans avoir été expédié (créé le {postingDate.Value:dd/MM/yyyy}). "
                                            + "Confirmez l'expédition ou supprimez cet ordre.",
                            RelatedEntityNo = transfer.No ?? string.Empty,
                            RelatedEntityId = transfer.Id
                        });
                    }
                }

                if (transfer.TransferLines == null || !transfer.TransferLines.Any())
                    continue;

                foreach (var line in transfer.TransferLines)
                {
                    // ── ALERTE 3 : Réception partielle ──────────────────────────────────
                    if (line.QuantityShipped.HasValue
                        && line.QuantityShipped > 0
                        && line.QuantityReceived.HasValue)
                    {
                        decimal pctRecu = (line.QuantityReceived.Value / line.QuantityShipped.Value) * 100m;

                        if (pctRecu < PartialReceiptMinPct)
                        {
                            decimal manquant = line.QuantityShipped.Value - line.QuantityReceived.Value;
                            string severity  = pctRecu < 50m ? "Critical" : "Warning";

                            alerts.Add(new AlertDto
                            {
                                Type            = "TransferPartialReceipt",
                                Severity        = severity,
                                Title           = $"Réception partielle — {transfer.No} / {line.ItemNo}",
                                Message         = $"Article {line.ItemNo} ({line.Description}) "
                                                + $"du transfert n° {transfer.No} : "
                                                + $"expédié {line.QuantityShipped:F2} — reçu {line.QuantityReceived:F2} {line.UnitOfMeasure}. "
                                                + $"Manquant : {manquant:F2} {line.UnitOfMeasure} ({100m - pctRecu:F1} %). "
                                                + "Vérifiez la réception physique.",
                                RelatedEntityNo = transfer.No ?? string.Empty,
                                RelatedEntityId = transfer.Id
                            });
                        }
                    }

                    // ── ALERTE 4 : Véhicule non assigné sur une ligne active ─────────────
                    // Pertinent uniquement pour les transferts en cours (Open ou In Transit).
                    bool transferActif = string.Equals(transfer.Status, "Open", StringComparison.OrdinalIgnoreCase)
                                     || string.Equals(transfer.Status, "In Transit", StringComparison.OrdinalIgnoreCase);

                    if (transferActif && string.IsNullOrWhiteSpace(line.NumVehicule))
                    {
                        alerts.Add(new AlertDto
                        {
                            Type            = "TransferNoVehicle",
                            Severity        = "Warning",
                            Title           = $"Véhicule non assigné — {transfer.No} / {line.ItemNo}",
                            Message         = $"La ligne article {line.ItemNo} ({line.Description}) "
                                            + $"du transfert n° {transfer.No} n'a pas de véhicule assigné. "
                                            + "Saisissez le numéro du véhicule de transport.",
                            RelatedEntityNo = transfer.No ?? string.Empty,
                            RelatedEntityId = transfer.Id
                        });
                    }
                }
            }

            return SortAlerts(alerts);
        }

        // ────────────────────────────────────────────────────────────────────────
        // PARTIE 4 — Stock Magasin
        // ────────────────────────────────────────────────────────────────────────

        /// <summary>
        /// Alertes sur le stock du chantier :
        ///   - Stock négatif : incohérence dans les écritures BC.
        ///   - Stock critique : quantité très faible, risque d'arrêt chantier.
        ///   - Stock dormant : aucun mouvement depuis plus de X jours.
        /// </summary>
        public async Task<List<AlertDto>> GetStockAlertsAsync(string projectNo)
        {
            var alerts = new List<AlertDto>();
            List<StockChantierReadDto> stocks;

            try
            {
                stocks = await _stockService.GetStockByProjectAsync(projectNo);
            }
            catch (Exception ex)
            {
                _logger.LogWarning(ex, "[AlertService] Impossible de récupérer le stock pour {ProjectNo}", projectNo);
                return alerts;
            }

            var today = DateTime.Today;

            foreach (var stock in stocks)
            {
                string label = $"{stock.ItemNo} — {stock.ItemDescription} ({stock.LocationCode})";

                // ── ALERTE 1 : Stock négatif ─────────────────────────────────────────
                if (stock.Quantity < 0)
                {
                    alerts.Add(new AlertDto
                    {
                        Type            = "StockNegatif",
                        Severity        = "Critical",
                        Title           = $"Stock négatif — {stock.ItemNo}",
                        Message         = $"L'article {label} présente un stock négatif "
                                        + $"de {stock.Quantity:F2} unité(s). "
                                        + "Vérifiez les écritures de sortie dans Business Central.",
                        RelatedEntityNo = stock.ItemNo
                    });
                    continue;
                }

                // ── ALERTE 2 : Stock critique ─────────────────────────────────────────
                // Quantité positive mais très faible — risque de rupture.
                if (stock.Quantity > 0 && stock.Quantity <= StockCritiqueMin)
                {
                    string severity = stock.Quantity <= StockCritiqueMin / 2m ? "Critical" : "Warning";

                    alerts.Add(new AlertDto
                    {
                        Type            = "StockCritique",
                        Severity        = severity,
                        Title           = $"Stock critique — {stock.ItemNo}",
                        Message         = $"L'article {label} n'a plus que {stock.Quantity:F2} unité(s) en stock "
                                        + $"(seuil critique : {StockCritiqueMin}). "
                                        + "Envisagez une demande d'approvisionnement.",
                        RelatedEntityNo = stock.ItemNo
                    });
                }

                // ── ALERTE 3 : Stock dormant ──────────────────────────────────────────
                // Aucun mouvement depuis X jours — article potentiellement inutile.
                if (stock.LastPostingDate.HasValue)
                {
                    int joursDepuisDernierMvt = (today - stock.LastPostingDate.Value.Date).Days;

                    if (joursDepuisDernierMvt > StockDormantJours)
                    {
                        alerts.Add(new AlertDto
                        {
                            Type            = "StockDormant",
                            Severity        = "Warning",
                            Title           = $"Stock dormant — {stock.ItemNo}",
                            Message         = $"L'article {label} n'a eu aucun mouvement depuis "
                                            + $"{joursDepuisDernierMvt} jour(s) "
                                            + $"(dernier mouvement le {stock.LastPostingDate.Value:dd/MM/yyyy}). "
                                            + "Vérifiez si cet article est toujours nécessaire sur le chantier.",
                            RelatedEntityNo = stock.ItemNo
                        });
                    }
                }
            }

            return SortAlerts(alerts);
        }

        // ────────────────────────────────────────────────────────────────────────
        // PARTIE 5 — Pointage Véhicule
        // ────────────────────────────────────────────────────────────────────────

        /// <summary>
        /// Alertes sur les pointages véhicule :
        ///   - Pointage non validé depuis trop longtemps.
        ///   - Véhicule surutilisé : heures travaillées > seuil journalier.
        ///   - Index incohérent : index final inférieur à l'index de départ.
        ///   - Consommation carburant anormalement élevée par rapport aux heures travaillées.
        /// </summary>
        public async Task<List<AlertDto>> GetVehiculeAlertsAsync(string projectNo)
        {
            var alerts = new List<AlertDto>();
            IEnumerable<VehiculePointageHeaderReadDto> headers;

            try
            {
                headers = await _vehiculeService.GetAllHeadersWithLinesAsync(projectNo);
            }
            catch (Exception ex)
            {
                _logger.LogWarning(ex, "[AlertService] Impossible de récupérer les pointages véhicule pour {ProjectNo}", projectNo);
                return alerts;
            }

            var today = DateTime.Today;

            foreach (var header in headers)
            {
                // Le champ date est une string dans VehiculePointageHeaderReadDto (Journee dans BC).
                DateTime? pointageDate = null;
                if (!string.IsNullOrEmpty(header.Date)
                    && DateTime.TryParse(header.Date, out var parsedDate))
                {
                    pointageDate = parsedDate;
                }

                // ── ALERTE 1 : Pointage ouvert non validé depuis trop longtemps ─────────
                if (string.Equals(header.Status, "Ouvert", StringComparison.OrdinalIgnoreCase)
                    && pointageDate.HasValue)
                {
                    int joursOuvert = (today - pointageDate.Value.Date).Days;

                    if (joursOuvert > PointageOuvertMaxJours)
                    {
                        string severity = joursOuvert > PointageOuvertMaxJours * 2 ? "Critical" : "Warning";

                        alerts.Add(new AlertDto
                        {
                            Type            = "PointageNonValide",
                            Severity        = severity,
                            Title           = $"Pointage non validé — {header.DocumentNo}",
                            Message         = $"Le pointage n° {header.DocumentNo} du "
                                            + $"{pointageDate.Value:dd/MM/yyyy} est encore ouvert "
                                            + $"depuis {joursOuvert} jour(s). "
                                            + "Validez-le pour clôturer la journée.",
                            RelatedEntityNo = header.DocumentNo ?? string.Empty,
                            RelatedEntityId = header.Id
                        });
                    }
                }

                if (header.VehiculePointageLines == null || !header.VehiculePointageLines.Any())
                    continue;

                foreach (var line in header.VehiculePointageLines)
                {
                    string labelVehicule = $"Véhicule {line.VehiculeNo} ({line.Description}) "
                                        + $"— pointage {header.DocumentNo}";

                    // ── ALERTE 2 : Véhicule surutilisé ──────────────────────────────────
                    if (line.HoursWorked.HasValue && line.HoursWorked > HeuresMaxJournee)
                    {
                        string severity = line.HoursWorked > HeuresMaxJournee * 1.5m ? "Critical" : "Warning";

                        alerts.Add(new AlertDto
                        {
                            Type            = "VehiculeSurutilise",
                            Severity        = severity,
                            Title           = $"Surutilisation — {line.VehiculeNo}",
                            Message         = $"{labelVehicule} : {line.HoursWorked:F1}h saisies "
                                            + $"(maximum autorisé : {HeuresMaxJournee}h). "
                                            + "Vérifiez la saisie ou signalez une utilisation exceptionnelle.",
                            RelatedEntityNo = header.DocumentNo ?? string.Empty,
                            RelatedEntityId = line.Id
                        });
                    }

                    // ── ALERTE 3 : Index incohérent ───────────────────────────────────────
                    // EndIndex < StartIndex = saisie erronée du kilométrage ou de l'horamètre.
                    if (line.EndIndex.HasValue
                        && line.StartIndex.HasValue
                        && line.EndIndex > 0
                        && line.StartIndex > 0
                        && line.EndIndex < line.StartIndex)
                    {
                        alerts.Add(new AlertDto
                        {
                            Type            = "IndexIncoherent",
                            Severity        = "Critical",
                            Title           = $"Index incohérent — {line.VehiculeNo}",
                            Message         = $"{labelVehicule} : l'index final ({line.EndIndex:F0}) "
                                            + $"est inférieur à l'index de départ ({line.StartIndex:F0}). "
                                            + "Corrigez la saisie.",
                            RelatedEntityNo = header.DocumentNo ?? string.Empty,
                            RelatedEntityId = line.Id
                        });
                    }

                    // ── ALERTE 4 : Consommation carburant anormale ───────────────────────
                    // FuelConsumed et HoursWorked sont les seuls champs disponibles
                    // dans VehiculePointageLineReadDto pour évaluer la consommation.
                    if (line.FuelConsumed.HasValue
                        && line.FuelConsumed > 0
                        && line.HoursWorked.HasValue
                        && line.HoursWorked > 0)
                    {
                        decimal ratioLParH = line.FuelConsumed.Value / line.HoursWorked.Value;

                        if (ratioLParH > CarburantMaxParHeure)
                        {
                            string severity = ratioLParH > CarburantMaxParHeure * 1.5m ? "Critical" : "Warning";

                            alerts.Add(new AlertDto
                            {
                                Type            = "ConsommationAnormale",
                                Severity        = severity,
                                Title           = $"Consommation anormale — {line.VehiculeNo}",
                                Message         = $"{labelVehicule} : consommation de {line.FuelConsumed:F1} L "
                                                + $"pour {line.HoursWorked:F1}h de travail "
                                                + $"= {ratioLParH:F1} L/h (seuil : {CarburantMaxParHeure} L/h). "
                                                + "Vérifiez l'état du véhicule ou la saisie carburant.",
                                RelatedEntityNo = header.DocumentNo ?? string.Empty,
                                RelatedEntityId = line.Id
                            });
                        }
                    }
                }
            }

            return SortAlerts(alerts);
        }

        // ────────────────────────────────────────────────────────────────────────
        // PARTIE 6 — Gasoil (Fiches de Distribution)
        // ────────────────────────────────────────────────────────────────────────

        /// <summary>
        /// Alertes sur les fiches gasoil :
        ///   - Fiche non validée depuis trop longtemps.
        ///   - Consommation totale journalière anormalement élevée.
        ///   - Ligne sans véhicule assigné.
        ///   - Quantité par ligne anormalement élevée.
        /// Note : les index de cuve (StartIndex/EndIndex) ne sont pas dans GasoilHeaderReadDto,
        ///        ni dans GasoilLineReadDto — les alertes d'index sont donc impossibles
        ///        sans modification des DTOs et des pages AL.
        /// </summary>
        public async Task<List<AlertDto>> GetGasoilAlertsAsync(string projectNo)
        {
            var alerts = new List<AlertDto>();
            IEnumerable<GasoilHeaderReadDto> headers;

            try
            {
                headers = await _gasoilService.GetAllHeadersWithLinesAsync(projectNo);
            }
            catch (Exception ex)
            {
                _logger.LogWarning(ex, "[AlertService] Impossible de récupérer les fiches gasoil pour {ProjectNo}", projectNo);
                return alerts;
            }

            var today = DateTime.Today;

            foreach (var header in headers)
            {
                // Le champ date est une string dans GasoilHeaderReadDto (Journee dans BC).
                DateTime? ficheDate = null;
                if (!string.IsNullOrEmpty(header.Date)
                    && DateTime.TryParse(header.Date, out var parsedDate))
                {
                    ficheDate = parsedDate;
                }

                string labelFiche = $"Fiche n° {header.DocumentNo}";

                // ── ALERTE 1 : Fiche non validée depuis trop longtemps ───────────────────
                if (string.Equals(header.Status, "En Cours", StringComparison.OrdinalIgnoreCase)
                    && ficheDate.HasValue)
                {
                    int joursOuvert = (today - ficheDate.Value.Date).Days;

                    if (joursOuvert > FicheEnCoursMaxJours)
                    {
                        string severity = joursOuvert > FicheEnCoursMaxJours * 2 ? "Critical" : "Warning";

                        alerts.Add(new AlertDto
                        {
                            Type            = "GasoilFicheNonValidee",
                            Severity        = severity,
                            Title           = $"Fiche gasoil non validée — {header.DocumentNo}",
                            Message         = $"{labelFiche} du {ficheDate.Value:dd/MM/yyyy} "
                                            + $"est encore en cours depuis {joursOuvert} jour(s). "
                                            + "Validez la fiche pour clôturer la consommation journalière.",
                            RelatedEntityNo = header.DocumentNo ?? string.Empty,
                            RelatedEntityId = header.Id
                        });
                    }
                }

                if (header.Lines == null || !header.Lines.Any())
                    continue;

                // ── ALERTE 2 : Consommation totale journalière anormale ──────────────────
                decimal totalConsommation = header.Lines
                    .Where(l => l.Quantity.HasValue && l.Quantity > 0)
                    .Sum(l => l.Quantity!.Value);

                if (totalConsommation > ConsommationTotaleMax)
                {
                    string severity = totalConsommation > ConsommationTotaleMax * 1.5m ? "Critical" : "Warning";

                    alerts.Add(new AlertDto
                    {
                        Type            = "GasoilConsommationTotaleAnormale",
                        Severity        = severity,
                        Title           = $"Consommation totale anormale — {header.DocumentNo}",
                        Message         = $"{labelFiche} du {ficheDate?.ToString("dd/MM/yyyy") ?? "?"} : "
                                        + $"consommation totale de {totalConsommation:F1} L "
                                        + $"(seuil : {ConsommationTotaleMax} L). "
                                        + "Vérifiez les lignes de la fiche ou signalez une anomalie.",
                        RelatedEntityNo = header.DocumentNo ?? string.Empty,
                        RelatedEntityId = header.Id
                    });
                }

                foreach (var line in header.Lines)
                {
                    // ── ALERTE 3 : Ligne sans véhicule assigné ───────────────────────────
                    if (string.IsNullOrWhiteSpace(line.VehicleNo))
                    {
                        alerts.Add(new AlertDto
                        {
                            Type            = "GasoilLigneSansVehicule",
                            Severity        = "Warning",
                            Title           = $"Ligne sans véhicule — {header.DocumentNo}",
                            Message         = $"{labelFiche} du {ficheDate?.ToString("dd/MM/yyyy") ?? "?"} : "
                                            + "une ligne de distribution ne contient pas de véhicule assigné. "
                                            + "Saisissez le numéro du véhicule concerné.",
                            RelatedEntityNo = header.DocumentNo ?? string.Empty,
                            RelatedEntityId = line.Id
                        });
                    }

                    // ── ALERTE 4 : Quantité par ligne anormalement élevée ────────────────
                    if (line.Quantity.HasValue && line.Quantity > ConsommationLigneMax)
                    {
                        string severity = line.Quantity > ConsommationLigneMax * 1.5m ? "Critical" : "Warning";

                        alerts.Add(new AlertDto
                        {
                            Type            = "GasoilQuantiteLigneAnormale",
                            Severity        = severity,
                            Title           = $"Quantité anormale — {line.VehicleNo ?? "véhicule inconnu"}",
                            Message         = $"{labelFiche} : véhicule {line.VehicleNo ?? "non défini"} "
                                            + $"a reçu {line.Quantity:F1} L "
                                            + $"(seuil par distribution : {ConsommationLigneMax} L). "
                                            + "Vérifiez la saisie ou confirmez un plein exceptionnel.",
                            RelatedEntityNo = header.DocumentNo ?? string.Empty,
                            RelatedEntityId = line.Id
                        });
                    }
                }
            }

            return SortAlerts(alerts);
        }

        // ────────────────────────────────────────────────────────────────────────
        // PARTIE 7 — Pointage Salarié (Attendance)
        // ────────────────────────────────────────────────────────────────────────

        /// <summary>
        /// Alertes sur les fiches de pointage salarié :
        ///   - Fiche sans lignes : aucun salarié saisi pour le mois.
        ///   - Salarié sans aucun jour saisi : toutes les colonnes Day1..Day31 sont nulles ou vides.
        /// Note : les totaux (totalPresentDays, totalAbsentDays…) sont calculés par BC
        ///        côté AL via CalculateTotals() et sont disponibles en lecture.
        ///        On les utilise ici pour détecter un salarié entièrement absent.
        /// </summary>
        public async Task<List<AlertDto>> GetAttendanceAlertsAsync(string projectNo)
        {
            var alerts = new List<AlertDto>();
            IEnumerable<EmpAttendanceReadDto> headers;

            try
            {
                headers = await _attendanceService.GetAllHeadersWithLinesAsync(projectNo);
            }
            catch (Exception ex)
            {
                _logger.LogWarning(ex, "[AlertService] Impossible de récupérer les fiches pointage pour {ProjectNo}", projectNo);
                return alerts;
            }

            foreach (var header in headers)
            {
                string labelFiche = $"Fiche n° {header.No} ({header.Month} {header.Year})";

                // ── ALERTE 1 : Fiche sans lignes ─────────────────────────────────────────
                if (header.Lines == null || !header.Lines.Any())
                {
                    alerts.Add(new AlertDto
                    {
                        Type            = "AttendanceFicheSansLignes",
                        Severity        = "Warning",
                        Title           = $"Fiche pointage vide — {header.No}",
                        Message         = $"{labelFiche} ne contient aucune ligne salarié. "
                                        + "Ajoutez les salariés du chantier pour ce mois.",
                        RelatedEntityNo = header.No ?? string.Empty,
                        RelatedEntityId = header.Id
                    });
                    continue;
                }

                foreach (var line in header.Lines)
                {
                    // ── ALERTE 2 : Salarié sans aucun jour saisi ─────────────────────────
                    // On considère qu'un salarié n'a aucun pointage si tous ses champs
                    // Day1..Day31 sont null ou vides ET que totalPresentDays est 0 ou null.
                    bool aucunJourSaisi = IsAllDaysEmpty(line);
                    bool totalPresentNul = !line.TotalPresentDays.HasValue
                                        || line.TotalPresentDays.Value == 0;

                    if (aucunJourSaisi && totalPresentNul)
                    {
                        string nomSalarie = !string.IsNullOrEmpty(line.EmployeeName)
                            ? line.EmployeeName
                            : line.EmployeeNo ?? "Inconnu";

                        alerts.Add(new AlertDto
                        {
                            Type            = "AttendanceSalarieNonPointe",
                            Severity        = "Warning",
                            Title           = $"Salarié non pointé — {line.EmployeeNo}",
                            Message         = $"{labelFiche} : le salarié {nomSalarie} (matricule {line.EmployeeNo}) "
                                            + "n'a aucun jour saisi pour ce mois. "
                                            + "Vérifiez si son pointage a bien été renseigné.",
                            RelatedEntityNo = header.No ?? string.Empty,
                            RelatedEntityId = line.Id
                        });
                    }
                }
            }

            return SortAlerts(alerts);
        }

        // ── Helper Attendance ─────────────────────────────────────────────────

        /// <summary>
        /// Vérifie si tous les champs Day1..Day31 d'une ligne de pointage sont null ou vides.
        /// Méthode explicite (non réflexive) pour rester cohérent avec le pattern BuildDayPatch
        /// utilisé dans AttendanceService.
        /// </summary>
        private static bool IsAllDaysEmpty(EmpAttendanceLineReadDto line)
        {
            return string.IsNullOrEmpty(line.Day1)
                && string.IsNullOrEmpty(line.Day2)
                && string.IsNullOrEmpty(line.Day3)
                && string.IsNullOrEmpty(line.Day4)
                && string.IsNullOrEmpty(line.Day5)
                && string.IsNullOrEmpty(line.Day6)
                && string.IsNullOrEmpty(line.Day7)
                && string.IsNullOrEmpty(line.Day8)
                && string.IsNullOrEmpty(line.Day9)
                && string.IsNullOrEmpty(line.Day10)
                && string.IsNullOrEmpty(line.Day11)
                && string.IsNullOrEmpty(line.Day12)
                && string.IsNullOrEmpty(line.Day13)
                && string.IsNullOrEmpty(line.Day14)
                && string.IsNullOrEmpty(line.Day15)
                && string.IsNullOrEmpty(line.Day16)
                && string.IsNullOrEmpty(line.Day17)
                && string.IsNullOrEmpty(line.Day18)
                && string.IsNullOrEmpty(line.Day19)
                && string.IsNullOrEmpty(line.Day20)
                && string.IsNullOrEmpty(line.Day21)
                && string.IsNullOrEmpty(line.Day22)
                && string.IsNullOrEmpty(line.Day23)
                && string.IsNullOrEmpty(line.Day24)
                && string.IsNullOrEmpty(line.Day25)
                && string.IsNullOrEmpty(line.Day26)
                && string.IsNullOrEmpty(line.Day27)
                && string.IsNullOrEmpty(line.Day28)
                && string.IsNullOrEmpty(line.Day29)
                && string.IsNullOrEmpty(line.Day30)
                && string.IsNullOrEmpty(line.Day31);
        }
    }
}