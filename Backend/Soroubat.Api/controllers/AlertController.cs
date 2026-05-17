// using Microsoft.AspNetCore.Authorization;
// using Microsoft.AspNetCore.Mvc;
// using Soroubat.Api.Interfaces;
// using Soroubat.Api.Models;

// namespace Soroubat.Api.Controllers
// {
//     [Authorize]
//     [ApiController]
//     [Route("api/[controller]")]
//     public class AlertsController : ControllerBase
//     {
//         private readonly IAlertService _alertService;

//         public AlertsController(IAlertService alertService)
//         {
//             _alertService = alertService;
//         }

//         /// <summary>Numéro de projet extrait du claim JWT — null si le compte n'est pas assigné.</summary>
//         private string? UserProjectNo => User.FindFirst("projectNo")?.Value;

//         // ── CATÉGORIES ────────────────────────────────────────────────────────

//         /// <summary>Retourne les alertes liées aux tâches du projet.</summary>
//         [HttpGet("site-management")]
//         [ProducesResponseType(typeof(List<AlertDto>), StatusCodes.Status200OK)]
//         [ProducesResponseType(StatusCodes.Status400BadRequest)]
//         [ProducesResponseType(StatusCodes.Status500InternalServerError)]
//         public async Task<ActionResult<List<AlertDto>>> GetSiteManagementAlerts()
//         {
//             var projectNo = UserProjectNo;
//             if (string.IsNullOrEmpty(projectNo))
//                 return BadRequest(new { message = "Aucun projet n'est assigné à votre compte." });

//             try
//             {
//                 return Ok(await _alertService.GetSiteManagementAlertsAsync(projectNo));
//             }
//             catch (Exception ex)
//             {
//                 return StatusCode(500, new { message = ex.Message });
//             }
//         }

//         /// <summary>Retourne les alertes liées aux demandes d'achat du projet.</summary>
//         [HttpGet("purchase-requests")]
//         [ProducesResponseType(typeof(List<AlertDto>), StatusCodes.Status200OK)]
//         [ProducesResponseType(StatusCodes.Status400BadRequest)]
//         [ProducesResponseType(StatusCodes.Status500InternalServerError)]
//         public async Task<ActionResult<List<AlertDto>>> GetPurchaseRequestAlerts()
//         {
//             var projectNo = UserProjectNo;
//             if (string.IsNullOrEmpty(projectNo))
//                 return BadRequest(new { message = "Aucun projet n'est assigné à votre compte." });

//             try
//             {
//                 return Ok(await _alertService.GetPurchaseRequestAlertsAsync(projectNo));
//             }
//             catch (Exception ex)
//             {
//                 return StatusCode(500, new { message = ex.Message });
//             }
//         }

//         /// <summary>Retourne les alertes liées aux ordres de transfert du projet.</summary>
//         [HttpGet("transfers")]
//         [ProducesResponseType(typeof(List<AlertDto>), StatusCodes.Status200OK)]
//         [ProducesResponseType(StatusCodes.Status400BadRequest)]
//         [ProducesResponseType(StatusCodes.Status500InternalServerError)]
//         public async Task<ActionResult<List<AlertDto>>> GetTransferAlerts()
//         {
//             var projectNo = UserProjectNo;
//             if (string.IsNullOrEmpty(projectNo))
//                 return BadRequest(new { message = "Aucun projet n'est assigné à votre compte." });

//             try
//             {
//                 return Ok(await _alertService.GetTransferAlertsAsync(projectNo));
//             }
//             catch (Exception ex)
//             {
//                 return StatusCode(500, new { message = ex.Message });
//             }
//         }

//         /// <summary>Retourne les alertes liées au stock du projet.</summary>
//         [HttpGet("stock")]
//         [ProducesResponseType(typeof(List<AlertDto>), StatusCodes.Status200OK)]
//         [ProducesResponseType(StatusCodes.Status400BadRequest)]
//         [ProducesResponseType(StatusCodes.Status500InternalServerError)]
//         public async Task<ActionResult<List<AlertDto>>> GetStockAlerts()
//         {
//             var projectNo = UserProjectNo;
//             if (string.IsNullOrEmpty(projectNo))
//                 return BadRequest(new { message = "Aucun projet n'est assigné à votre compte." });

//             try
//             {
//                 return Ok(await _alertService.GetStockAlertsAsync(projectNo));
//             }
//             catch (Exception ex)
//             {
//                 return StatusCode(500, new { message = ex.Message });
//             }
//         }

//         /// <summary>Retourne les alertes liées aux pointages véhicule du projet.</summary>
//         [HttpGet("vehicules")]
//         [ProducesResponseType(typeof(List<AlertDto>), StatusCodes.Status200OK)]
//         [ProducesResponseType(StatusCodes.Status400BadRequest)]
//         [ProducesResponseType(StatusCodes.Status500InternalServerError)]
//         public async Task<ActionResult<List<AlertDto>>> GetVehiculeAlerts()
//         {
//             var projectNo = UserProjectNo;
//             if (string.IsNullOrEmpty(projectNo))
//                 return BadRequest(new { message = "Aucun projet n'est assigné à votre compte." });

//             try
//             {
//                 return Ok(await _alertService.GetVehiculeAlertsAsync(projectNo));
//             }
//             catch (Exception ex)
//             {
//                 return StatusCode(500, new { message = ex.Message });
//             }
//         }

//         /// <summary>Retourne les alertes liées aux fiches gasoil du projet.</summary>
//         [HttpGet("gasoil")]
//         [ProducesResponseType(typeof(List<AlertDto>), StatusCodes.Status200OK)]
//         [ProducesResponseType(StatusCodes.Status400BadRequest)]
//         [ProducesResponseType(StatusCodes.Status500InternalServerError)]
//         public async Task<ActionResult<List<AlertDto>>> GetGasoilAlerts()
//         {
//             var projectNo = UserProjectNo;
//             if (string.IsNullOrEmpty(projectNo))
//                 return BadRequest(new { message = "Aucun projet n'est assigné à votre compte." });

//             try
//             {
//                 return Ok(await _alertService.GetGasoilAlertsAsync(projectNo));
//             }
//             catch (Exception ex)
//             {
//                 return StatusCode(500, new { message = ex.Message });
//             }
//         }

//         /// <summary>Retourne les alertes liées aux fiches de pointage salarié du projet.</summary>
//         [HttpGet("attendance")]
//         [ProducesResponseType(typeof(List<AlertDto>), StatusCodes.Status200OK)]
//         [ProducesResponseType(StatusCodes.Status400BadRequest)]
//         [ProducesResponseType(StatusCodes.Status500InternalServerError)]
//         public async Task<ActionResult<List<AlertDto>>> GetAttendanceAlerts()
//         {
//             var projectNo = UserProjectNo;
//             if (string.IsNullOrEmpty(projectNo))
//                 return BadRequest(new { message = "Aucun projet n'est assigné à votre compte." });

//             try
//             {
//                 return Ok(await _alertService.GetAttendanceAlertsAsync(projectNo));
//             }
//             catch (Exception ex)
//             {
//                 return StatusCode(500, new { message = ex.Message });
//             }
//         }

//         // ── AGRÉGATEUR GLOBAL ─────────────────────────────────────────────────

//         /// <summary>
//         /// Retourne toutes les alertes du projet, toutes catégories confondues.
//         /// Les 6 catégories sont interrogées en parallèle pour minimiser la latence.
//         /// Les Critical sont retournées en tête de liste.
//         /// </summary>
//         [HttpGet("all")]
//         [ProducesResponseType(typeof(List<AlertDto>), StatusCodes.Status200OK)]
//         [ProducesResponseType(StatusCodes.Status400BadRequest)]
//         [ProducesResponseType(StatusCodes.Status500InternalServerError)]
//         public async Task<ActionResult<List<AlertDto>>> GetAllAlerts()
//         {
//             var projectNo = UserProjectNo;
//             if (string.IsNullOrEmpty(projectNo))
//                 return BadRequest(new { message = "Aucun projet n'est assigné à votre compte." });

//             try
//             {
//                 // Exécution en parallèle des 6 catégories — chaque service gère ses propres
//                 // erreurs BC en retournant une liste vide, donc WhenAll ne peut pas échouer
//                 // partiellement sur une exception BC non interceptée.
//                 var results = await Task.WhenAll(
//                     _alertService.GetSiteManagementAlertsAsync(projectNo),
//                     _alertService.GetPurchaseRequestAlertsAsync(projectNo),
//                     _alertService.GetTransferAlertsAsync(projectNo),
//                     _alertService.GetStockAlertsAsync(projectNo),
//                     _alertService.GetVehiculeAlertsAsync(projectNo),
//                     _alertService.GetGasoilAlertsAsync(projectNo),
//                     _alertService.GetAttendanceAlertsAsync(projectNo)
//                 );

//                 var all = results
//                     .SelectMany(list => list)
//                     .OrderBy(a => a.Severity == "Critical" ? 0 : 1)
//                     .ThenBy(a => a.DetectedAt)
//                     .ToList();

//                 return Ok(all);
//             }
//             catch (Exception ex)
//             {
//                 return StatusCode(500, new { message = ex.Message });
//             }
//         }
//     }
// }