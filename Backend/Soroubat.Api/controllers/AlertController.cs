using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Soroubat.Api.Interfaces;
using Soroubat.Api.Models;

namespace Soroubat.Api.Controllers
{
    [Authorize]
    [ApiController]
    [Route("api/[controller]")]
    public class AlertsController : ControllerBase
    {
        private readonly IAlertService _alertService;

        public AlertsController(IAlertService alertService)
        {
            _alertService = alertService;
        }

        /// <summary>Numéro de projet extrait du claim JWT — null si le compte n'est pas assigné.</summary>
        private string? UserProjectNo => User.FindFirst("projectNo")?.Value;


        // /// <summary>
        // /// Retourne les alertes liées aux tâches du projet
        // /// (retards, tâches non démarrées à l'approche de leur échéance).
        // /// </summary>
        // [HttpGet("site-management")]
        // [ProducesResponseType(typeof(List<AlertDto>), StatusCodes.Status200OK)]
        // [ProducesResponseType(StatusCodes.Status400BadRequest)]
        // [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        // public async Task<ActionResult<List<AlertDto>>> GetSiteManagementAlerts()
        // {
        //     var projectNo = UserProjectNo;
        //     if (string.IsNullOrEmpty(projectNo))
        //         return BadRequest(new { message = "Aucun projet n'est assigné à votre compte." });

        //     try
        //     {
        //         var alerts = await _alertService.GetSiteManagementAlertsAsync(projectNo);
        //         return Ok(alerts);
        //     }
        //     catch (Exception ex)
        //     {
        //         return StatusCode(500, new { message = ex.Message });
        //     }
        // }

        /// <summary>
        /// Retourne les alertes liées aux demandes d'achat du projet
        /// (rejetées, en attente trop longtemps, demandes sans lignes).
        /// </summary>
        [HttpGet("purchase-requests")]
        [ProducesResponseType(typeof(List<AlertDto>), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<ActionResult<List<AlertDto>>> GetPurchaseRequestAlerts()
        {
            var projectNo = UserProjectNo;
            if (string.IsNullOrEmpty(projectNo))
                return BadRequest(new { message = "Aucun projet n'est assigné à votre compte." });

            try
            {
                var alerts = await _alertService.GetPurchaseRequestAlertsAsync(projectNo);
                return Ok(alerts);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = ex.Message });
            }
        }

        /// <summary>
        /// Retourne les alertes liées aux ordres de transfert du projet
        /// (transit bloqué, non expédié, réception partielle, véhicule non assigné).
        /// </summary>
        [HttpGet("transfers")]
        [ProducesResponseType(typeof(List<AlertDto>), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<ActionResult<List<AlertDto>>> GetTransferAlerts()
        {
            var projectNo = UserProjectNo;
            if (string.IsNullOrEmpty(projectNo))
                return BadRequest(new { message = "Aucun projet n'est assigné à votre compte." });

            try
            {
                var alerts = await _alertService.GetTransferAlertsAsync(projectNo);
                return Ok(alerts);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = ex.Message });
            }
        }

        /// <summary>
        /// Retourne les alertes liées au stock du projet
        /// (stock négatif, stock critique, stock dormant).
        /// </summary>
        [HttpGet("stock")]
        [ProducesResponseType(typeof(List<AlertDto>), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<ActionResult<List<AlertDto>>> GetStockAlerts()
        {
            var projectNo = UserProjectNo;
            if (string.IsNullOrEmpty(projectNo))
                return BadRequest(new { message = "Aucun projet n'est assigné à votre compte." });

            try
            {
                var alerts = await _alertService.GetStockAlertsAsync(projectNo);
                return Ok(alerts);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = ex.Message });
            }
        }

        /// <summary>
        /// Retourne les alertes liées aux pointages véhicule du projet
        /// (pointage non validé, surutilisation, index incohérent, consommation anormale).
        /// </summary>
        [HttpGet("vehicules")]
        [ProducesResponseType(typeof(List<AlertDto>), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<ActionResult<List<AlertDto>>> GetVehiculeAlerts()
        {
            var projectNo = UserProjectNo;
            if (string.IsNullOrEmpty(projectNo))
                return BadRequest(new { message = "Aucun projet n'est assigné à votre compte." });

            try
            {
                var alerts = await _alertService.GetVehiculeAlertsAsync(projectNo);
                return Ok(alerts);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = ex.Message });
            }
        }

        /// <summary>
        /// Retourne les alertes liées aux fiches gasoil du projet
        /// (fiche non validée, consommation totale anormale, ligne sans véhicule, quantité anormale).
        /// </summary>
        [HttpGet("gasoil")]
        [ProducesResponseType(typeof(List<AlertDto>), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<ActionResult<List<AlertDto>>> GetGasoilAlerts()
        {
            var projectNo = UserProjectNo;
            if (string.IsNullOrEmpty(projectNo))
                return BadRequest(new { message = "Aucun projet n'est assigné à votre compte." });

            try
            {
                var alerts = await _alertService.GetGasoilAlertsAsync(projectNo);
                return Ok(alerts);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = ex.Message });
            }
        }

        /// <summary>
        /// Retourne les alertes liées aux fiches de pointage salarié du projet
        /// (fiche sans lignes, salarié sans aucun jour saisi).
        /// </summary>
        [HttpGet("attendance")]
        [ProducesResponseType(typeof(List<AlertDto>), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<ActionResult<List<AlertDto>>> GetAttendanceAlerts()
        {
            var projectNo = UserProjectNo;
            if (string.IsNullOrEmpty(projectNo))
                return BadRequest(new { message = "Aucun projet n'est assigné à votre compte." });

            try
            {
                var alerts = await _alertService.GetAttendanceAlertsAsync(projectNo);
                return Ok(alerts);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = ex.Message });
            }
        }

        // ── AGRÉGATEUR GLOBAL ─────────────────────────────────────────────────

        /// <summary>
        /// Retourne toutes les alertes du projet, toutes catégories confondues.
        /// Les 7 catégories sont interrogées en parallèle pour minimiser la latence.
        /// Les Critical sont retournées en tête de liste, puis Warning, puis Info.
        /// En cas d'erreur BC sur une catégorie, les autres catégories ne sont pas bloquées
        /// (chaque méthode de service retourne une liste vide en cas d'erreur).
        /// </summary>
        [HttpGet("all")]
        [ProducesResponseType(typeof(List<AlertDto>), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<ActionResult<List<AlertDto>>> GetAllAlerts()
        {
            var projectNo = UserProjectNo;
            if (string.IsNullOrEmpty(projectNo))
                return BadRequest(new { message = "Aucun projet n'est assigné à votre compte." });

            try
            {
                // Exécution en parallèle des 7 catégories.
                // Chaque méthode de service gère ses propres erreurs BC en retournant
                // une liste vide — Task.WhenAll ne peut donc pas échouer partiellement.
                var results = await Task.WhenAll(
                    // _alertService.GetSiteManagementAlertsAsync(projectNo),
                    _alertService.GetPurchaseRequestAlertsAsync(projectNo),
                    _alertService.GetTransferAlertsAsync(projectNo),
                    _alertService.GetStockAlertsAsync(projectNo),
                    _alertService.GetVehiculeAlertsAsync(projectNo),
                    _alertService.GetGasoilAlertsAsync(projectNo),
                    _alertService.GetAttendanceAlertsAsync(projectNo)
                );

                var all = results
                    .SelectMany(list => list)
                    .OrderBy(a => a.Severity == "Critical" ? 0 : a.Severity == "Warning" ? 1 : 2)
                    .ThenBy(a => a.DetectedAt)
                    .ToList();

                return Ok(all);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = ex.Message });
            }
        }
    }
}