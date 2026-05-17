using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Soroubat.Api.Interfaces;
using Soroubat.Api.Models;

namespace Soroubat.Api.Controllers
{
    [Authorize]
    [ApiController]
    [Route("api/[controller]")]
    public class PurchaseRequestController : ControllerBase
    {
        private readonly IPurchaseRequestService _service;

        public PurchaseRequestController(IPurchaseRequestService service)
        {
            _service = service;
        }

        /// <summary>Numéro de projet extrait du claim JWT — null si le compte n'est pas assigné.</summary>
        private string? UserProjectNo => User.FindFirst("projectNo")?.Value;


        /// <summary>Retourne toutes les demandes d'achat du projet du chef connecté.</summary>
        [HttpGet]
        [ProducesResponseType(typeof(IEnumerable<PurchaseRequestReadDto>), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<ActionResult<IEnumerable<PurchaseRequestReadDto>>> GetAll() //IEnumerable permet de retouner n'importe quel type de collection (List, Array...)
        {
            var projectNo = UserProjectNo;
            if (string.IsNullOrEmpty(projectNo))
                return BadRequest(new { message = "Aucun projet n'est assigné à votre compte." });

            try
            {
                var requests = await _service.GetAllRequestsAsync(projectNo);
                return Ok(requests);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = ex.Message });
            }
        }

        /// <summary>Retourne une demande d'achat avec ses lignes.</summary>
        [HttpGet("{id:guid}")]
        [ProducesResponseType(typeof(PurchaseRequestReadDto), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status403Forbidden)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<ActionResult<PurchaseRequestReadDto>> GetById(Guid id)
        {
            var projectNo = UserProjectNo;
            if (string.IsNullOrEmpty(projectNo))
                return BadRequest(new { message = "Aucun projet n'est assigné à votre compte." });

            try
            {
                var request = await _service.GetRequestByIdAsync(id, projectNo);

                if (request == null)
                    return NotFound(new { message = "Demande d'achat introuvable." });

                return Ok(request);
            }
            catch (UnauthorizedAccessException ex)
            {
                return StatusCode(StatusCodes.Status403Forbidden, new { message = ex.Message });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = ex.Message });
            }
        }

        /// <summary>Crée l'en-tête d'une nouvelle demande d'achat.</summary>
        [HttpPost]
        // typeof transforme la classe en un type décrivant la structure de la réponse
        [ProducesResponseType(typeof(PurchaseRequestReadDto), StatusCodes.Status201Created)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<ActionResult<PurchaseRequestReadDto>> CreateHeader([FromBody] PurchaseRequestCreateDto requestDto)
        {
            var projectNo = UserProjectNo;
            if (string.IsNullOrEmpty(projectNo))
                return BadRequest(new { message = "Aucun projet n'est associé à votre compte." });

            try
            {
                var created = await _service.CreateHeaderAsync(requestDto, projectNo);
                return CreatedAtAction(nameof(GetById), new { id = created.Id }, created);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = ex.Message });
            }
        }

        /// <summary>Crée les lignes d'une demande d'achat existante.</summary>
        [HttpPost("lines")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<IActionResult> CreateLines([FromBody] List<PurchaseRequestLineCreateDto> lines)
        {
            var projectNo = UserProjectNo;
            if (string.IsNullOrEmpty(projectNo))
                return BadRequest(new { message = "Aucun projet n'est assigné à votre compte." });

            if (lines == null || !lines.Any())
                return BadRequest(new { message = "La liste des lignes est vide." });

            try
            {
                await _service.CreateLinesAsync(lines, projectNo);
                return Ok(new { message = "Lignes créées avec succès." });
            }
            catch (ArgumentException ex)
            {
                return BadRequest(new { message = ex.Message });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = ex.Message });
            }
        }

        /// <summary>Met à jour partiellement l'en-tête d'une demande d'achat.</summary>
        [HttpPatch("{id:guid}")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status403Forbidden)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<IActionResult> UpdateHeader(Guid id, [FromBody] PurchaseRequestPatchDto headerDto)
        {
            var projectNo = UserProjectNo;
            if (string.IsNullOrEmpty(projectNo))
                return BadRequest(new { message = "Aucun projet n'est assigné à votre compte." });

            try
            {
                await _service.PatchHeaderAsync(id, headerDto, projectNo);
                return Ok(new { message = "En-tête mis à jour avec succès." });
            }
            catch (KeyNotFoundException ex)
            {
                return NotFound(new { message = ex.Message });
            }
            catch (UnauthorizedAccessException ex)
            {
                return StatusCode(StatusCodes.Status403Forbidden, new { message = ex.Message });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = ex.Message });
            }
        }

        /// <summary>
        /// Soumet une demande d'achat pour approbation.
        /// La demande doit être au statut "Open".
        /// </summary>
        [HttpPost("{id:guid}/submit")] // on utilie post et non pas patch ici car on change le statut de la demande et pas une partie de son contenu
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status403Forbidden)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<IActionResult> SubmitForApproval(Guid id)
        {
            var projectNo = UserProjectNo;
            if (string.IsNullOrEmpty(projectNo))
                return BadRequest(new { message = "Aucun projet n'est assigné à votre compte." });

            try
            {
                await _service.SubmitForApprovalAsync(id, projectNo);
                return Ok(new { message = "Demande soumise pour approbation avec succès." });
            }
            catch (KeyNotFoundException ex)
            {
                return NotFound(new { message = ex.Message });
            }
            catch (UnauthorizedAccessException ex)
            {
                return StatusCode(StatusCodes.Status403Forbidden, new { message = ex.Message });
            }
            catch (InvalidOperationException ex)
            {
                return BadRequest(new { message = ex.Message });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = ex.Message });
            }
        }

        /// <summary>Supprime une demande d'achat.</summary>
        [HttpDelete("{id:guid}")]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status403Forbidden)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<IActionResult> DeleteHeader(Guid id)
        {
            var projectNo = UserProjectNo;
            if (string.IsNullOrEmpty(projectNo))
                return BadRequest(new { message = "Aucun projet n'est assigné à votre compte." });

            try
            {
                await _service.DeleteRequestAsync(id, projectNo);
                return NoContent();
            }
            catch (KeyNotFoundException ex)
            {
                return NotFound(new { message = ex.Message });
            }
            catch (UnauthorizedAccessException ex)
            {
                return StatusCode(StatusCodes.Status403Forbidden, new { message = ex.Message });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = ex.Message });
            }
        }


        /// <summary>Met à jour partiellement une ligne de demande d'achat.</summary>
        [HttpPatch("lines/{id:guid}")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status403Forbidden)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<IActionResult> UpdateLine(Guid id, [FromBody] PurchaseRequestLinePatchDto lineDto)
        {
            var projectNo = UserProjectNo;
            if (string.IsNullOrEmpty(projectNo))
                return BadRequest(new { message = "Aucun projet n'est assigné à votre compte." });

            try
            {
                await _service.PatchLineAsync(id, lineDto, projectNo);
                return Ok(new { message = "Ligne mise à jour avec succès." });
            }
            catch (KeyNotFoundException ex)
            {
                return NotFound(new { message = ex.Message });
            }
            catch (UnauthorizedAccessException ex)
            {
                return StatusCode(StatusCodes.Status403Forbidden, new { message = ex.Message });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = ex.Message });
            }
        }

        /// <summary>Supprime une ligne de demande d'achat.</summary>
        [HttpDelete("lines/{id:guid}")]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status403Forbidden)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<IActionResult> DeleteLine(Guid id)
        {
            var projectNo = UserProjectNo;
            if (string.IsNullOrEmpty(projectNo))
                return BadRequest(new { message = "Aucun projet n'est assigné à votre compte." });

            try
            {
                await _service.DeleteLineAsync(id, projectNo);
                return NoContent();
            }
            catch (KeyNotFoundException ex)
            {
                return NotFound(new { message = ex.Message });
            }
            catch (UnauthorizedAccessException ex)
            {
                return StatusCode(StatusCodes.Status403Forbidden, new { message = ex.Message });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = ex.Message });
            }
        }
    }
}