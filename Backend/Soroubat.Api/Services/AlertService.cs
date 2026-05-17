// using Soroubat.Api.Interfaces;
// using Soroubat.Api.Models;

// namespace Soroubat.Api.Services
// {
//     public class AlertService : IAlertService
//     {
//         private readonly ISiteManagementService _siteService;
//         private readonly IPurchaseRequestService _purchaseService;
//         private readonly ITransferService _transferService;
//         private readonly IStockService _stockService;
//         private readonly IVehiculeService _vehiculeService;
//         private readonly IEmpAttendanceService _attendanceService;
//         private readonly IGasoilService _gasoilService;

//         // Seuils SiteManagement
//         private const int TaskDelayGraceDays  = 0;
//         private const int NotStartedAfterDays = 3;

//         // Seuils PurchaseRequest
//         private const int PendingApprovalMaxDays = 5;  // Alerte si "To Approve" depuis plus de 5 jours
//         private const int DueDateGraceDays       = 0;  // Pas de tolérance sur la date d'échéance

//         // Seuils Transfer
//         private const int     InTransitMaxDays     = 3;    // Alerte si en transit depuis plus de 3 jours
//         private const int     OpenTransferMaxDays  = 7;    // Alerte si ouvert sans expédition depuis plus de 7 jours
//         private const decimal PartialReceiptMinPct = 80m;  // Alerte si reçu < 80 % de l'expédié

//         // Seuils Stock
//         private const decimal StockCritiqueMin  = 5m;   // Alerte si quantité <= 5 unités
//         private const int     StockDormantJours = 30;   // Alerte si aucun mouvement depuis 30 jours

//         // Seuils Pointage Véhicule
//         private const decimal HeuresMaxJournee       = 12m;  // Alerte si hoursWorked > 12h
//         private const decimal CarburantMaxParHeure   = 15m;  // Alerte si fuelConsumed/hoursWorked > 15 L/h
//         private const int     PointageOuvertMaxJours = 2;    // Alerte si pointage "Ouvert" depuis > 2 jours

//         // Seuils Gasoil
//         private const int     FicheEnCoursMaxJours  = 2;    // Alerte si "En Cours" depuis > 2 jours
//         private const decimal QuantiteMaxParLigne    = 300m; // Alerte si une ligne dépasse 300 L
//         private const decimal ConsommationTotaleMax  = 800m; // Alerte si total journalier > 800 L

//         // Seuils Pointage Salarié
//         private const decimal TauxPresenceMinPct  = 70m;  // Alerte si taux de présence < 70 %
//         private const decimal TauxAbsenceMaxPct   = 30m;  // Alerte si taux d'absence > 30 %

//         public AlertService(
//             ISiteManagementService siteService,
//             IPurchaseRequestService purchaseService,
//             ITransferService transferService,
//             IStockService stockService,
//             IVehiculeService vehiculeService,
//             IGasoilService gasoilService,
//             IEmpAttendanceService attendanceService)
//         {
//             _siteService        = siteService;
//             _purchaseService    = purchaseService;
//             _transferService    = transferService;
//             _stockService       = stockService;
//             _vehiculeService    = vehiculeService;
//             _gasoilService      = gasoilService;
//             _attendanceService  = attendanceService;
//         }

//         // ────────────────────────────────────────────────────────────────────────
//         // PARTIE 1 — SiteManagement
//         // ────────────────────────────────────────────────────────────────────────

//         public async Task<List<AlertDto>> GetSiteManagementAlertsAsync(string projectNo)
//         {
//             var alerts = new List<AlertDto>();
//             List<JobTaskReadDto> tasks;

//             try { tasks = await _siteService.GetMyTasksAsync(projectNo); }
//             catch { return alerts; }

//             var today = DateTime.Today;

//             foreach (var task in tasks)
//             {
//                 // ALERTE 1 : Tâche bloquée
//                 if (task.IsBlocked)
//                 {
//                     alerts.Add(new AlertDto
//                     {
//                         Type            = "TaskBlocked",
//                         Severity        = "Critical",
//                         Title           = "Tâche bloquée",
//                         Message         = $"La tâche \"{task.Description}\" ({task.TaskNo}) est marquée comme bloquée.",
//                         RelatedEntityNo = task.TaskNo,
//                         RelatedEntityId = task.Id
//                     });
//                     continue;
//                 }

//                 // ALERTE 2 : Retard de tâche
//                 if (task.DateFin.HasValue
//                     && task.DateFin.Value.Date.AddDays(TaskDelayGraceDays) < today
//                     && task.ProgressPct < 100)
//                 {
//                     int joursRetard = (today - task.DateFin.Value.Date).Days;
//                     alerts.Add(new AlertDto
//                     {
//                         Type            = "TaskDelay",
//                         Severity        = joursRetard > 7 ? "Critical" : "Warning",
//                         Title           = $"Retard — {task.Description}",
//                         Message         = $"La tâche \"{task.Description}\" ({task.TaskNo}) devait se terminer le "
//                                         + $"{task.DateFin.Value:dd/MM/yyyy}. Retard : {joursRetard} jour(s). "
//                                         + $"Avancement : {task.ProgressPct:F0} %.",
//                         RelatedEntityNo = task.TaskNo,
//                         RelatedEntityId = task.Id
//                     });
//                 }

//                 // ALERTE 3 : Tâche non démarrée
//                 if (task.DateDebut.HasValue
//                     && task.DateDebut.Value.Date.AddDays(NotStartedAfterDays) < today
//                     && task.ProgressPct == 0)
//                 {
//                     int joursDepuis = (today - task.DateDebut.Value.Date).Days;
//                     alerts.Add(new AlertDto
//                     {
//                         Type            = "TaskNotStarted",
//                         Severity        = "Warning",
//                         Title           = $"Non démarrée — {task.Description}",
//                         Message         = $"La tâche \"{task.Description}\" ({task.TaskNo}) aurait dû démarrer le "
//                                         + $"{task.DateDebut.Value:dd/MM/yyyy} ({joursDepuis} jour(s) écoulés) "
//                                         + "mais son avancement est encore à 0 %.",
//                         RelatedEntityNo = task.TaskNo,
//                         RelatedEntityId = task.Id
//                     });
//                 }

//                 // ALERTE 4 : Dépassement budget (version coût réel)
//                 if (task.InitialAmount > 0 && task.UsageTotalCost > task.InitialAmount)
//                 {
//                     decimal depassementPct = ((task.UsageTotalCost - task.InitialAmount)
//                                              / task.InitialAmount) * 100;
//                     alerts.Add(new AlertDto
//                     {
//                         Type            = "BudgetOverrun",
//                         Severity        = depassementPct > 20 ? "Critical" : "Warning",
//                         Title           = $"Dépassement budget — {task.Description}",
//                         Message         = $"La tâche \"{task.Description}\" ({task.TaskNo}) a un coût réel de "
//                                         + $"{task.UsageTotalCost:F2} sur un budget de {task.InitialAmount:F2} "
//                                         + $"(dépassement de {depassementPct:F1} %).",
//                         RelatedEntityNo = task.TaskNo,
//                         RelatedEntityId = task.Id
//                     });
//                 }
//             }

//             return alerts
//                 .OrderBy(a => a.Severity == "Critical" ? 0 : 1)
//                 .ThenBy(a => a.DetectedAt)
//                 .ToList();
//         }

//         // ────────────────────────────────────────────────────────────────────────
//         // PARTIE 2 — PurchaseRequest
//         // ────────────────────────────────────────────────────────────────────────

//         public async Task<List<AlertDto>> GetPurchaseRequestAlertsAsync(string projectNo)
//         {
//             var alerts = new List<AlertDto>();
//             IEnumerable<PurchaseRequestReadDto> requests;

//             try { requests = await _purchaseService.GetAllRequestsAsync(projectNo); }
//             catch { return alerts; }

//             var today = DateTime.Today;

//             foreach (var req in requests)
//             {
//                 // ── ALERTE 1 : Demande rejetée non traitée ──────────────────────
//                 if (string.Equals(req.Statut, "Rejected", StringComparison.OrdinalIgnoreCase))
//                 {
//                     alerts.Add(new AlertDto
//                     {
//                         Type            = "PurchaseRequestRejected",
//                         Severity        = "Critical",
//                         Title           = $"Demande rejetée — {req.No}",
//                         Message         = $"La demande d'achat n° {req.No} a été rejetée. "
//                                         + "Veuillez la corriger et la re-soumettre pour approbation.",
//                         RelatedEntityNo = req.No,
//                         RelatedEntityId = req.Id
//                     });
//                     continue;
//                 }

//                 // ── ALERTE 2 : En attente d'approbation trop longtemps ──────────
//                 if (string.Equals(req.Statut, "To Approve", StringComparison.OrdinalIgnoreCase)
//                     && !string.IsNullOrEmpty(req.OrderDate)
//                     && DateTime.TryParse(req.OrderDate, out var orderDate))
//                 {
//                     int joursAttente = (today - orderDate.Date).Days;

//                     if (joursAttente > PendingApprovalMaxDays)
//                     {
//                         alerts.Add(new AlertDto
//                         {
//                             Type            = "PurchaseRequestPendingTooLong",
//                             Severity        = joursAttente > 10 ? "Critical" : "Warning",
//                             Title           = $"Approbation en attente — {req.No}",
//                             Message         = $"La demande d'achat n° {req.No} est en attente d'approbation "
//                                             + $"depuis {joursAttente} jour(s) (soumise le {orderDate:dd/MM/yyyy}). "
//                                             + "Relancez le responsable.",
//                             RelatedEntityNo = req.No,
//                             RelatedEntityId = req.Id
//                         });
//                     }
//                 }

//                 // ── ALERTE 3 : Date d'échéance dépassée sans clôture ────────────
//                 var statutsTermines = new[] { "Released", "Rejected", "Closed" };
//                 if (!string.IsNullOrEmpty(req.DueDate)
//                     && DateTime.TryParse(req.DueDate, out var dueDate)
//                     && dueDate.Date.AddDays(DueDateGraceDays) < today
//                     && !statutsTermines.Contains(req.Statut, StringComparer.OrdinalIgnoreCase))
//                 {
//                     int joursRetard = (today - dueDate.Date).Days;
//                     alerts.Add(new AlertDto
//                     {
//                         Type            = "PurchaseRequestOverdue",
//                         Severity        = joursRetard > 7 ? "Critical" : "Warning",
//                         Title           = $"Échéance dépassée — {req.No}",
//                         Message         = $"La demande d'achat n° {req.No} (statut : {req.Statut}) avait une "
//                                         + $"date d'échéance au {dueDate:dd/MM/yyyy}. "
//                                         + $"Retard : {joursRetard} jour(s).",
//                         RelatedEntityNo = req.No,
//                         RelatedEntityId = req.Id
//                     });
//                 }

//                 // ── ALERTE 4 : Demande vide — aucun article saisi ───────────────
//                 if (string.Equals(req.Statut, "Open", StringComparison.OrdinalIgnoreCase)
//                     && (req.Amount ?? 0) == 0)
//                 {
//                     alerts.Add(new AlertDto
//                     {
//                         Type            = "PurchaseRequestEmpty",
//                         Severity        = "Warning",
//                         Title           = $"Demande incomplète — {req.No}",
//                         Message         = $"La demande d'achat n° {req.No} est ouverte mais ne contient "
//                                         + "aucun article (montant nul). Ajoutez des lignes ou supprimez-la.",
//                         RelatedEntityNo = req.No,
//                         RelatedEntityId = req.Id
//                     });
//                 }
//             }

//             return alerts
//                 .OrderBy(a => a.Severity == "Critical" ? 0 : 1)
//                 .ThenBy(a => a.DetectedAt)
//                 .ToList();
//         }

//         // ────────────────────────────────────────────────────────────────────────
//         // PARTIE 3 — Transfer Order
//         // ────────────────────────────────────────────────────────────────────────

//         public async Task<List<AlertDto>> GetTransferAlertsAsync(string projectNo)
//         {
//             var alerts = new List<AlertDto>();
//             IEnumerable<TransferHeaderReadDto> transfers;

//             try { transfers = await _transferService.GetAllTransfersWithLinesAsync(projectNo); }
//             catch { return alerts; }

//             var today = DateTime.Today;

//             foreach (var transfer in transfers)
//             {
//                 // On parse postingDate une seule fois pour toutes les règles du header
//                 DateTime? postingDate = null;
//                 if (!string.IsNullOrEmpty(transfer.PostingDate)
//                     && DateTime.TryParse(transfer.PostingDate, out var parsedDate))
//                 {
//                     postingDate = parsedDate;
//                 }

//                 // ── ALERTE 1 : Transfert en transit trop longtemps ──────────────────
//                 if (string.Equals(transfer.Status, "In Transit", StringComparison.OrdinalIgnoreCase)
//                     && postingDate.HasValue)
//                 {
//                     int joursEnRoute = (today - postingDate.Value.Date).Days;

//                     if (joursEnRoute > InTransitMaxDays)
//                     {
//                         alerts.Add(new AlertDto
//                         {
//                             Type            = "TransferStuckInTransit",
//                             Severity        = joursEnRoute > 7 ? "Critical" : "Warning",
//                             Title           = $"Transfert bloqué en transit — {transfer.No}",
//                             Message         = $"L'ordre de transfert n° {transfer.No} "
//                                             + $"(de {transfer.TransferFromCode} vers {transfer.TransferToCode}) "
//                                             + $"est en transit depuis {joursEnRoute} jour(s) "
//                                             + $"(expédié le {postingDate.Value:dd/MM/yyyy}). "
//                                             + "Vérifiez la livraison avec le transporteur.",
//                             RelatedEntityNo = transfer.No,
//                             RelatedEntityId = transfer.Id
//                         });
//                     }
//                 }

//                 // ── ALERTE 2 : Transfert ouvert sans expédition ─────────────────────
//                 if (string.Equals(transfer.Status, "Open", StringComparison.OrdinalIgnoreCase)
//                     && postingDate.HasValue)
//                 {
//                     int joursOuvert = (today - postingDate.Value.Date).Days;

//                     if (joursOuvert > OpenTransferMaxDays)
//                     {
//                         alerts.Add(new AlertDto
//                         {
//                             Type            = "TransferNotShipped",
//                             Severity        = "Warning",
//                             Title           = $"Transfert non expédié — {transfer.No}",
//                             Message         = $"L'ordre de transfert n° {transfer.No} est ouvert depuis {joursOuvert} jour(s) "
//                                             + $"sans avoir été expédié (créé le {postingDate.Value:dd/MM/yyyy}). "
//                                             + "Confirmez l'expédition ou supprimez cet ordre.",
//                             RelatedEntityNo = transfer.No,
//                             RelatedEntityId = transfer.Id
//                         });
//                     }
//                 }

//                 if (transfer.TransferLines == null || !transfer.TransferLines.Any())
//                     continue;

//                 foreach (var line in transfer.TransferLines)
//                 {
//                     // ── ALERTE 3 : Réception partielle ──────────────────────────────
//                     if (line.QuantityShipped.HasValue
//                         && line.QuantityShipped > 0
//                         && line.QuantityReceived.HasValue)
//                     {
//                         decimal pctRecu = (line.QuantityReceived.Value / line.QuantityShipped.Value) * 100;

//                         if (pctRecu < PartialReceiptMinPct)
//                         {
//                             decimal manquant = line.QuantityShipped.Value - line.QuantityReceived.Value;
//                             alerts.Add(new AlertDto
//                             {
//                                 Type            = "TransferPartialReceipt",
//                                 Severity        = pctRecu < 50 ? "Critical" : "Warning",
//                                 Title           = $"Réception partielle — {transfer.No} / {line.ItemNo}",
//                                 Message         = $"La ligne article {line.ItemNo} ({line.Description}) du transfert n° {transfer.No} : "
//                                                 + $"expédié {line.QuantityShipped:F2} — reçu {line.QuantityReceived:F2} {line.UnitOfMeasure}. "
//                                                 + $"Manquant : {manquant:F2} {line.UnitOfMeasure} ({100 - pctRecu:F1} %). "
//                                                 + "Vérifiez la réception physique.",
//                                 RelatedEntityNo = transfer.No,
//                                 RelatedEntityId = transfer.Id
//                             });
//                         }
//                     }

//                     // ── ALERTE 4 : Ligne sans véhicule assigné ───────────────────────
//                     if (string.Equals(transfer.Status, "Open", StringComparison.OrdinalIgnoreCase)
//                         || string.Equals(transfer.Status, "In Transit", StringComparison.OrdinalIgnoreCase))
//                     {
//                         if (string.IsNullOrWhiteSpace(line.NumVehicule))
//                         {
//                             alerts.Add(new AlertDto
//                             {
//                                 Type            = "TransferNoVehicle",
//                                 Severity        = "Warning",
//                                 Title           = $"Véhicule non assigné — {transfer.No} / {line.ItemNo}",
//                                 Message         = $"La ligne article {line.ItemNo} ({line.Description}) "
//                                                 + $"du transfert n° {transfer.No} n'a pas de véhicule assigné. "
//                                                 + "Saisissez le numéro du véhicule de transport.",
//                                 RelatedEntityNo = transfer.No,
//                                 RelatedEntityId = transfer.Id
//                             });
//                         }
//                     }
//                 }
//             }

//             return alerts
//                 .OrderBy(a => a.Severity == "Critical" ? 0 : 1)
//                 .ThenBy(a => a.DetectedAt)
//                 .ToList();
//         }

//         // ────────────────────────────────────────────────────────────────────────
//         // PARTIE 4 — Stock Magasin
//         // ────────────────────────────────────────────────────────────────────────

//         public async Task<List<AlertDto>> GetStockAlertsAsync(string projectNo)
//         {
//             var alerts = new List<AlertDto>();
//             List<StockChantierReadDto> stocks;

//             try { stocks = await _stockService.GetStockByProjectAsync(projectNo); }
//             catch { return alerts; }

//             var today = DateTime.Today;

//             foreach (var stock in stocks)
//             {
//                 string label = $"{stock.ItemNo} — {stock.ItemDescription} ({stock.LocationCode})";

//                 // ── ALERTE 1 : Stock négatif ────────────────────────────────────────
//                 if (stock.Quantity < 0)
//                 {
//                     alerts.Add(new AlertDto
//                     {
//                         Type            = "StockNégatif",
//                         Severity        = "Critical",
//                         Title           = $"Stock négatif — {stock.ItemNo}",
//                         Message         = $"L'article {label} présente un stock négatif "
//                                         + $"de {stock.Quantity:F2} unités. "
//                                         + "Vérifiez les écritures de sortie dans Business Central.",
//                         RelatedEntityNo = stock.ItemNo
//                     });
//                     continue;
//                 }

//                 // ── ALERTE 2 : Stock critique — quantité très faible ────────────────
//                 if (stock.Quantity > 0 && stock.Quantity <= StockCritiqueMin)
//                 {
//                     alerts.Add(new AlertDto
//                     {
//                         Type            = "StockCritique",
//                         Severity        = stock.Quantity <= StockCritiqueMin / 2 ? "Critical" : "Warning",
//                         Title           = $"Stock critique — {stock.ItemNo}",
//                         Message         = $"L'article {label} n'a plus que {stock.Quantity:F2} unité(s) en stock. "
//                                         + "Envisagez une demande d'approvisionnement.",
//                         RelatedEntityNo = stock.ItemNo
//                     });
//                 }

//                 // ── ALERTE 3 : Stock dormant — aucun mouvement récent ───────────────
//                 if (stock.LastPostingDate.HasValue)
//                 {
//                     int joursDepuisDernierMvt = (today - stock.LastPostingDate.Value.Date).Days;

//                     if (joursDepuisDernierMvt > StockDormantJours)
//                     {
//                         alerts.Add(new AlertDto
//                         {
//                             Type            = "StockDormant",
//                             Severity        = "Warning",
//                             Title           = $"Stock dormant — {stock.ItemNo}",
//                             Message         = $"L'article {label} n'a eu aucun mouvement depuis "
//                                             + $"{joursDepuisDernierMvt} jour(s) "
//                                             + $"(dernier mouvement le {stock.LastPostingDate.Value:dd/MM/yyyy}). "
//                                             + "Vérifiez si cet article est toujours nécessaire sur le chantier.",
//                             RelatedEntityNo = stock.ItemNo
//                         });
//                     }
//                 }
//             }

//             return alerts
//                 .OrderBy(a => a.Severity == "Critical" ? 0 : 1)
//                 .ThenBy(a => a.DetectedAt)
//                 .ToList();
//         }

//         // ────────────────────────────────────────────────────────────────────────
//         // PARTIE 5 — Pointage Véhicule
//         // ────────────────────────────────────────────────────────────────────────

//         public async Task<List<AlertDto>> GetVehiculeAlertsAsync(string projectNo)
//         {
//             var alerts = new List<AlertDto>();
//             IEnumerable<VehiculePointageHeaderReadDto> headers;

//             try { headers = await _vehiculeService.GetAllHeadersWithLinesAsync(projectNo); }
//             catch { return alerts; }

//             var today = DateTime.Today;

//             foreach (var header in headers)
//             {
//                 // Parse de la date du pointage — champ "date" (Journee dans BC)
//                 DateTime? pointageDate = null;
//                 if (!string.IsNullOrEmpty(header.Date)
//                     && DateTime.TryParse(header.Date, out var pd))
//                 {
//                     pointageDate = pd;
//                 }

//                 // ── ALERTE 1 : Pointage ouvert non validé depuis trop longtemps ─────
//                 // Un pointage "Ouvert" qui traîne plusieurs jours sans validation
//                 // fausse les statistiques de coût véhicule et de consommation.
//                 if (string.Equals(header.Status, "Ouvert", StringComparison.OrdinalIgnoreCase)
//                     && pointageDate.HasValue)
//                 {
//                     int joursOuvert = (today - pointageDate.Value.Date).Days;

//                     if (joursOuvert > PointageOuvertMaxJours)
//                     {
//                         alerts.Add(new AlertDto
//                         {
//                             Type            = "PointageNonValidé",
//                             Severity        = joursOuvert > 5 ? "Critical" : "Warning",
//                             Title           = $"Pointage non validé — {header.DocumentNo}",
//                             Message         = $"Le pointage n° {header.DocumentNo} du "
//                                             + $"{pointageDate.Value:dd/MM/yyyy} est encore ouvert "
//                                             + $"depuis {joursOuvert} jour(s). Validez-le pour clôturer la journée.",
//                             RelatedEntityNo = header.DocumentNo,
//                             RelatedEntityId = header.Id
//                         });
//                     }
//                 }

//                 // Alertes sur les lignes — on ne traite que les headers avec lignes
//                 if (header.Lines == null || !header.Lines.Any())
//                     continue;

//                 foreach (var line in header.Lines)
//                 {
//                     string labelVehicule = $"Véhicule {line.VehiculeNo} ({line.Description}) "
//                                         + $"— pointage {header.DocumentNo}";

//                     // ── ALERTE 2 : Véhicule surutilisé — trop d'heures journalières ─
//                     // HoursWorked est maintenant nullable — on ne traite que si la valeur est renseignée.
//                     if (line.HoursWorked.HasValue && line.HoursWorked > HeuresMaxJournee)
//                     {
//                         alerts.Add(new AlertDto
//                         {
//                             Type            = "VehiculeSurutilisé",
//                             Severity        = line.HoursWorked > HeuresMaxJournee * 1.5m ? "Critical" : "Warning",
//                             Title           = $"Surutilisation — {line.VehiculeNo}",
//                             Message         = $"{labelVehicule} : {line.HoursWorked:F1}h saisies "
//                                             + $"(maximum autorisé : {HeuresMaxJournee}h). "
//                                             + "Vérifiez la saisie ou signalez une utilisation exceptionnelle.",
//                             RelatedEntityNo = header.DocumentNo,
//                             RelatedEntityId = line.Id
//                         });
//                     }

//                     // ── ALERTE 3 : Index incohérent — endIndex < startIndex ──────────
//                     // StartIndex et EndIndex sont maintenant nullable — vérification défensive.
//                     if (line.EndIndex.HasValue
//                         && line.StartIndex.HasValue
//                         && line.EndIndex > 0
//                         && line.StartIndex > 0
//                         && line.EndIndex < line.StartIndex)
//                     {
//                         alerts.Add(new AlertDto
//                         {
//                             Type            = "IndexIncohérent",
//                             Severity        = "Critical",
//                             Title           = $"Index incohérent — {line.VehiculeNo}",
//                             Message         = $"{labelVehicule} : l'index final ({line.EndIndex:F0}) "
//                                             + $"est inférieur à l'index de départ ({line.StartIndex:F0}). "
//                                             + "Corrigez la saisie.",
//                             RelatedEntityNo = header.DocumentNo,
//                             RelatedEntityId = line.Id
//                         });
//                     }

//                     // ── ALERTE 4 : Panne sans motif justificatif ─────────────────────
//                     if (string.Equals(line.Status, "Panne", StringComparison.OrdinalIgnoreCase)
//                         && string.IsNullOrWhiteSpace(line.BreakdownMotiv))
//                     {
//                         alerts.Add(new AlertDto
//                         {
//                             Type            = "PanneSansMotif",
//                             Severity        = "Warning",
//                             Title           = $"Panne non justifiée — {line.VehiculeNo}",
//                             Message         = $"{labelVehicule} est marqué en panne "
//                                             + "mais aucun motif n'est renseigné. "
//                                             + "Saisissez le motif de panne pour le suivi de maintenance.",
//                             RelatedEntityNo = header.DocumentNo,
//                             RelatedEntityId = line.Id
//                         });
//                     }

//                     // ── ALERTE 5 : Consommation carburant anormalement élevée ────────
//                     // FuelConsumed et HoursWorked sont nullable — double vérification HasValue.
//                     if (line.FuelConsumed.HasValue
//                         && line.FuelConsumed > 0
//                         && line.HoursWorked.HasValue
//                         && line.HoursWorked > 0)
//                     {
//                         decimal ratioLParH = line.FuelConsumed.Value / line.HoursWorked.Value;

//                         if (ratioLParH > CarburantMaxParHeure)
//                         {
//                             alerts.Add(new AlertDto
//                             {
//                                 Type            = "ConsommationAnormale",
//                                 Severity        = ratioLParH > CarburantMaxParHeure * 1.5m ? "Critical" : "Warning",
//                                 Title           = $"Consommation anormale — {line.VehiculeNo}",
//                                 Message         = $"{labelVehicule} : consommation de {line.FuelConsumed:F1} L "
//                                                 + $"pour {line.HoursWorked:F1}h de travail "
//                                                 + $"= {ratioLParH:F1} L/h (seuil : {CarburantMaxParHeure} L/h). "
//                                                 + "Vérifiez l'état du véhicule ou la saisie carburant.",
//                                 RelatedEntityNo = header.DocumentNo,
//                                 RelatedEntityId = line.Id
//                             });
//                         }
//                     }
//                 }
//             }

//             return alerts
//                 .OrderBy(a => a.Severity == "Critical" ? 0 : 1)
//                 .ThenBy(a => a.DetectedAt)
//                 .ToList();
//         }

//         // ────────────────────────────────────────────────────────────────────────
//         // PARTIE 6 — Gasoil
//         // ────────────────────────────────────────────────────────────────────────

//         public async Task<List<AlertDto>> GetGasoilAlertsAsync(string projectNo)
//         {
//             var alerts = new List<AlertDto>();
//             IEnumerable<GasoilHeaderReadDto> headers;

//             try { headers = await _gasoilService.GetAllHeadersWithLinesAsync(projectNo); }
//             catch { return alerts; }

//             var today = DateTime.Today;

//             foreach (var header in headers)
//             {
//                 // Parse de la date de la fiche
//                 DateTime? ficheDate = null;
//                 if (!string.IsNullOrEmpty(header.Date)
//                     && DateTime.TryParse(header.Date, out var pd))
//                 {
//                     ficheDate = pd;
//                 }

//                 string labelFiche = $"Fiche n° {header.DocumentNo}";

//                 // ── ALERTE 1 : Fiche non validée depuis trop longtemps ───────────────
//                 if (string.Equals(header.Status, "En Cours", StringComparison.OrdinalIgnoreCase)
//                     && ficheDate.HasValue)
//                 {
//                     int joursOuvert = (today - ficheDate.Value.Date).Days;

//                     if (joursOuvert > FicheEnCoursMaxJours)
//                     {
//                         alerts.Add(new AlertDto
//                         {
//                             Type            = "GasoilFicheNonValidée",
//                             Severity        = joursOuvert > 5 ? "Critical" : "Warning",
//                             Title           = $"Fiche gasoil non validée — {header.DocumentNo}",
//                             Message         = $"{labelFiche} du {ficheDate.Value:dd/MM/yyyy} "
//                                             + $"est encore en cours depuis {joursOuvert} jour(s). "
//                                             + "Validez la fiche pour clôturer la consommation journalière.",
//                             RelatedEntityNo = header.DocumentNo,
//                             RelatedEntityId = header.Id
//                         });
//                     }
//                 }

//                 // ── ALERTE 2 : Index incohérent sur le header ────────────────────────
//                 if (header.StartIndex.HasValue
//                     && header.EndIndex.HasValue
//                     && header.StartIndex > 0
//                     && header.EndIndex > 0
//                     && header.EndIndex < header.StartIndex)
//                 {
//                     alerts.Add(new AlertDto
//                     {
//                         Type            = "GasoilIndexIncohérent",
//                         Severity        = "Critical",
//                         Title           = $"Index cuve incohérent — {header.DocumentNo}",
//                         Message         = $"{labelFiche} : l'index final de la cuve ({header.EndIndex:F0}) "
//                                         + $"est inférieur à l'index de départ ({header.StartIndex:F0}). "
//                                         + "Corrigez la saisie.",
//                         RelatedEntityNo = header.DocumentNo,
//                         RelatedEntityId = header.Id
//                     });
//                 }

//                 if (header.Lines == null || !header.Lines.Any())
//                     continue;

//                 // ── ALERTE 3 : Consommation totale journalière anormale ──────────────
//                 decimal totalConsommation = header.Lines
//                     .Where(l => l.Quantity.HasValue && l.Quantity > 0)
//                     .Sum(l => l.Quantity!.Value);

//                 if (totalConsommation > ConsommationTotaleMax)
//                 {
//                     alerts.Add(new AlertDto
//                     {
//                         Type            = "GasoilConsommationTotaleAnormale",
//                         Severity        = totalConsommation > ConsommationTotaleMax * 1.5m ? "Critical" : "Warning",
//                         Title           = $"Consommation totale anormale — {header.DocumentNo}",
//                         Message         = $"{labelFiche} du {ficheDate?.ToString("dd/MM/yyyy") ?? "?"} : "
//                                         + $"consommation totale de {totalConsommation:F1} L "
//                                         + $"(seuil : {ConsommationTotaleMax} L). "
//                                         + "Vérifiez les lignes de la fiche ou signalez une anomalie.",
//                         RelatedEntityNo = header.DocumentNo,
//                         RelatedEntityId = header.Id
//                     });
//                 }

//                 foreach (var line in header.Lines)
//                 {
//                     string labelVehicule = !string.IsNullOrEmpty(line.VehiclePlate)
//                         ? $"véhicule {line.VehicleNo} ({line.VehiclePlate})"
//                         : $"véhicule {line.VehicleNo}";

//                     // ── ALERTE 4 : Ligne sans véhicule assigné ───────────────────────
//                     if (string.IsNullOrWhiteSpace(line.VehicleNo))
//                     {
//                         alerts.Add(new AlertDto
//                         {
//                             Type            = "GasoilLigneSansVéhicule",
//                             Severity        = "Warning",
//                             Title           = $"Ligne sans véhicule — {header.DocumentNo}",
//                             Message         = $"{labelFiche} : une ligne (n° {line.LineNo}) "
//                                             + "n'a pas de véhicule/engin assigné. "
//                                             + "Complétez la saisie pour assurer la traçabilité.",
//                             RelatedEntityNo = header.DocumentNo,
//                             RelatedEntityId = line.Id
//                         });
//                         continue;
//                     }

//                     // ── ALERTE 5 : Quantité anormalement élevée sur une ligne ─────────
//                     if (line.Quantity.HasValue && line.Quantity > QuantiteMaxParLigne)
//                     {
//                         alerts.Add(new AlertDto
//                         {
//                             Type            = "GasoilQuantitéLigneAnormale",
//                             Severity        = line.Quantity > QuantiteMaxParLigne * 2 ? "Critical" : "Warning",
//                             Title           = $"Quantité anormale — {header.DocumentNo} / {line.VehicleNo}",
//                             Message         = $"{labelFiche} : distribution de {line.Quantity:F1} L "
//                                             + $"au {labelVehicule} "
//                                             + $"(seuil unitaire : {QuantiteMaxParLigne} L). "
//                                             + "Vérifiez si cette quantité est justifiée.",
//                             RelatedEntityNo = header.DocumentNo,
//                             RelatedEntityId = line.Id
//                         });
//                     }
//                 }
//             }

//             return alerts
//                 .OrderBy(a => a.Severity == "Critical" ? 0 : 1)
//                 .ThenBy(a => a.DetectedAt)
//                 .ToList();
//         }
//         // ────────────────────────────────────────────────────────────────────────
//         // PARTIE 7 — Pointage Salarié
//         // ────────────────────────────────────────────────────────────────────────

//         public async Task<List<AlertDto>> GetAttendanceAlertsAsync(string projectNo)
//         {
//             var alerts = new List<AlertDto>();
//             IEnumerable<EmpAttendanceReadDto> headers;

//             try { headers = await _attendanceService.GetAllHeadersWithLinesAsync(projectNo); }
//             catch { return alerts; }

//             var today = DateTime.Today;

//             foreach (var header in headers)
//             {
//                 string labelFiche = $"Fiche {header.No} ({header.Month} {header.Year})";

//                 // ── ALERTE 1 : Fiche sans lignes ─────────────────────────────────────
//                 // Une fiche créée mais sans aucun salarié pointé est probablement oubliée.
//                 if (header.Lines == null || !header.Lines.Any())
//                 {
//                     alerts.Add(new AlertDto
//                     {
//                         Type            = "AttendanceFicheSansLignes",
//                         Severity        = "Warning",
//                         Title           = $"Fiche de pointage vide — {header.No}",
//                         Message         = $"{labelFiche} ne contient aucune ligne de pointage salarié. "
//                                         + "Ajoutez les salariés à pointer ou supprimez cette fiche.",
//                         RelatedEntityNo = header.No ?? string.Empty,
//                         RelatedEntityId = header.Id
//                     });
//                     continue;
//                 }

//                 // ── ALERTE 2 : Taux de présence faible ──────────────────────────────
//                 if (header.AttendanceRate.HasValue && header.AttendanceRate < TauxPresenceMinPct)
//                 {
//                     alerts.Add(new AlertDto
//                     {
//                         Type            = "AttendanceTauxPresenceFaible",
//                         Severity        = header.AttendanceRate < TauxPresenceMinPct / 2 ? "Critical" : "Warning",
//                         Title           = $"Taux de présence faible — {header.No}",
//                         Message         = $"{labelFiche} : taux de présence de {header.AttendanceRate:F1} % "
//                                         + $"(seuil minimum : {TauxPresenceMinPct} %). "
//                                         + "Vérifiez les absences non justifiées.",
//                         RelatedEntityNo = header.No ?? string.Empty,
//                         RelatedEntityId = header.Id
//                     });
//                 }

//                 // ── ALERTE 3 : Taux d'absence élevé ─────────────────────────────────
//                 if (header.AbsenceRate.HasValue && header.AbsenceRate > TauxAbsenceMaxPct)
//                 {
//                     alerts.Add(new AlertDto
//                     {
//                         Type            = "AttendanceTauxAbsenceElevé",
//                         Severity        = header.AbsenceRate > TauxAbsenceMaxPct * 1.5m ? "Critical" : "Warning",
//                         Title           = $"Taux d'absence élevé — {header.No}",
//                         Message         = $"{labelFiche} : taux d'absence de {header.AbsenceRate:F1} % "
//                                         + $"(seuil maximum : {TauxAbsenceMaxPct} %). "
//                                         + "Analysez les causes d'absentéisme sur ce chantier.",
//                         RelatedEntityNo = header.No ?? string.Empty,
//                         RelatedEntityId = header.Id
//                     });
//                 }

//                 // ── ALERTE 4 : Salarié sans aucun pointage ───────────────────────────
//                 // Une ligne dont tous les jours sont null signifie que le salarié n'a
//                 // jamais été pointé — soit oubli de saisie, soit erreur de liste.
//                 foreach (var line in header.Lines)
//                 {
//                     var hasAnyDay = line.Day1  != null || line.Day2  != null || line.Day3  != null
//                                  || line.Day4  != null || line.Day5  != null || line.Day6  != null
//                                  || line.Day7  != null || line.Day8  != null || line.Day9  != null
//                                  || line.Day10 != null || line.Day11 != null || line.Day12 != null
//                                  || line.Day13 != null || line.Day14 != null || line.Day15 != null
//                                  || line.Day16 != null || line.Day17 != null || line.Day18 != null
//                                  || line.Day19 != null || line.Day20 != null || line.Day21 != null
//                                  || line.Day22 != null || line.Day23 != null || line.Day24 != null
//                                  || line.Day25 != null || line.Day26 != null || line.Day27 != null
//                                  || line.Day28 != null || line.Day29 != null || line.Day30 != null
//                                  || line.Day31 != null;

//                     if (!hasAnyDay)
//                     {
//                         alerts.Add(new AlertDto
//                         {
//                             Type            = "AttendanceSalariéNonPointé",
//                             Severity        = "Warning",
//                             Title           = $"Salarié non pointé — {line.EmployeeNo}",
//                             Message         = $"{labelFiche} : le salarié {line.EmployeeNo} ({line.EmployeeName}) "
//                                             + "n'a aucun jour de pointage saisi pour cette période. "
//                                             + "Vérifiez la saisie ou retirez ce salarié de la fiche.",
//                             RelatedEntityNo = header.No ?? string.Empty,
//                             RelatedEntityId = line.Id
//                         });
//                     }
//                 }
//             }

//             return alerts
//                 .OrderBy(a => a.Severity == "Critical" ? 0 : 1)
//                 .ThenBy(a => a.DetectedAt)
//                 .ToList();
//         }
//     }
// }