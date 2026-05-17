using Soroubat.Api.Interfaces;
using Soroubat.Api.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Soroubat.Api.Controllers
{
    [Authorize]
    [ApiController]
    [Route("api/[controller]")]
    public class SiteManagementController : ControllerBase
    {
        private readonly ISiteManagementService _siteService;

        public SiteManagementController(ISiteManagementService siteService)
        {
            _siteService = siteService;
        }

        /// <summary>
        /// Propriété centralisée pour lire le claim "projectNo" depuis le JWT.
        /// Retourne null si le claim est absent (compte non assigné à un projet).
        /// </summary>
        // User représente un groupement d'informations dans le token JWT de l'utilisateur authentifié qui effectue les requêtes http , ca provient de ControllerBase et est automatiquement peuplé par le middleware d'authentification de ASP.NET Core.
        private string? UserProjectNo => User.FindFirst("projectNo")?.Value; 


        /// <summary>Retourne le projet Business Central assigné au chef de chantier connecté.</summary>
        [HttpGet("my-project")]
        [ProducesResponseType(typeof(JobReadDto), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<ActionResult<JobReadDto>> GetMyProject()
        {
            var projectNo = UserProjectNo;
            if (string.IsNullOrEmpty(projectNo))
                return BadRequest(new { message = "Aucun projet assigné dans votre profil." });

            try
            {
                var job = await _siteService.GetAssignedJobAsync(projectNo);
                return Ok(job);
            }
            catch (KeyNotFoundException ex)
            {
                return NotFound(new { message = ex.Message });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = ex.Message });
            }
        }

        /// <summary>Retourne la liste des tâches du projet du chef de chantier connecté.</summary>
        [HttpGet("my-tasks")]
        [ProducesResponseType(typeof(IEnumerable<JobTaskReadDto>), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<ActionResult<IEnumerable<JobTaskReadDto>>> GetMyTasks()
        {
            var projectNo = UserProjectNo;
            if (string.IsNullOrEmpty(projectNo))
                return BadRequest(new { message = "Accès refusé : aucun projet assigné." });

            try
            {
                var tasks = await _siteService.GetMyTasksAsync(projectNo);
                return Ok(tasks);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = ex.Message });
            }
        }


        /// <summary>
        /// Met à jour le pourcentage d'avancement d'une tâche identifiée par son SystemId BC.
        /// L'ID est dans l'URL (RESTful), le pourcentage dans le corps.
        /// </summary>
        [HttpPatch("tasks/{id:guid}/progress")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(typeof(ValidationProblemDetails), StatusCodes.Status400BadRequest)] // pour les erreurs de validation du DTO
        [ProducesResponseType(StatusCodes.Status403Forbidden)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<IActionResult> UpdateProgress(Guid id, [FromBody] JobTaskProgressPatchDto dto)
        {
            if (!ModelState.IsValid) // validation automatique du DTO (ex : range 0-100 pour Progress)
                return ValidationProblem(ModelState);

            var projectNo = UserProjectNo;
            if (string.IsNullOrEmpty(projectNo))
                return Unauthorized(new { message = "Aucun projet assigné dans votre profil." });

            try
            {
                var success = await _siteService.UpdateTaskProgressAsync(id, dto.Progress, projectNo);

                if (success)
                    return Ok(new { message = "Avancement mis à jour avec succès." });

                // Ce cas ne devrait pas se produire (le service lève une exception en cas d'échec)
                return StatusCode(500, new { message = "Erreur lors de la mise à jour dans Business Central." });
            }
            catch (KeyNotFoundException ex)
            {
                return NotFound(new { message = ex.Message });
            }
            catch (UnauthorizedAccessException ex)
            {
                // 403 : le chef tente de modifier une tâche d'un autre chantier
                return StatusCode(StatusCodes.Status403Forbidden, new { message = ex.Message });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = ex.Message });
            }
        }
    }
}