using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Soroubat.Api.Interfaces;
using Soroubat.Api.Models;

namespace Soroubat.Api.Controllers
{
    [Authorize]
    [ApiController]
    [Route("api/[controller]")]
    public class GasoilController : ControllerBase
    {
        private readonly IGasoilService _gasoilService;

        public GasoilController(IGasoilService gasoilService)
        {
            _gasoilService = gasoilService;
        }

        /// <summary>Numéro de projet extrait du claim JWT — null si le compte n'est pas assigné.</summary>
        private string? UserProjectNo => User.FindFirst("projectNo")?.Value;


        /// <summary>Retourne toutes les fiches gasoil du chantier du chef connecté.</summary>
        [HttpGet("headers")]
        [ProducesResponseType(typeof(IEnumerable<GasoilHeaderReadDto>), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<ActionResult<IEnumerable<GasoilHeaderReadDto>>> GetAll()
        {
            var projectNo = UserProjectNo;
            if (string.IsNullOrEmpty(projectNo))
                return BadRequest(new { message = "Aucun projet n'est assigné à votre compte." });

            try
            {
                var headers = await _gasoilService.GetAllHeadersAsync(projectNo);
                return Ok(headers);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = ex.Message });
            }
        }

        /// <summary>Retourne une fiche gasoil avec ses lignes.</summary>
        [HttpGet("headers/{id:guid}")]
        [ProducesResponseType(typeof(GasoilHeaderReadDto), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status403Forbidden)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<ActionResult<GasoilHeaderReadDto>> GetById(Guid id)
        {
            var projectNo = UserProjectNo;
            if (string.IsNullOrEmpty(projectNo))
                return BadRequest(new { message = "Aucun projet n'est assigné à votre compte." });

            try
            {
                var header = await _gasoilService.GetHeaderByIdAsync(id, projectNo);
                return Ok(header);
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

        /// <summary>Crée une nouvelle fiche gasoil.</summary>
        [HttpPost("headers")]
        [ProducesResponseType(typeof(GasoilHeaderReadDto), StatusCodes.Status201Created)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<ActionResult<GasoilHeaderReadDto>> CreateHeader([FromBody] GasoilHeaderCreateDto headerDto)
        {
            var projectNo = UserProjectNo;
            if (string.IsNullOrEmpty(projectNo))
                return BadRequest(new { message = "Aucun projet n'est assigné à votre compte." });

            try
            {
                var created = await _gasoilService.CreateHeaderAsync(headerDto, projectNo);
                return CreatedAtAction(nameof(GetById), new { id = created.Id }, created);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = ex.Message });
            }
        }

        /// <summary>Met à jour partiellement une fiche gasoil.</summary>
        [HttpPatch("headers/{id:guid}")]
        [ProducesResponseType(typeof(GasoilHeaderReadDto), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status403Forbidden)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<ActionResult<GasoilHeaderReadDto>> PatchHeader(Guid id, [FromBody] GasoilHeaderPatchDto headerDto)
        {
            var projectNo = UserProjectNo;
            if (string.IsNullOrEmpty(projectNo))
                return BadRequest(new { message = "Aucun projet n'est assigné à votre compte." });

            try
            {
                var updated = await _gasoilService.PatchHeaderAsync(id, headerDto, projectNo);
                return Ok(updated);
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

        /// <summary>Supprime une fiche gasoil.</summary>
        [HttpDelete("headers/{id:guid}")]
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
                await _gasoilService.DeleteHeaderAsync(id, projectNo);
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

        /// <summary>
        /// Valide une fiche gasoil en faisant passer son statut de "En Cours" à "Validé".
        /// La fiche doit être au statut "En Cours".
        /// </summary>
        [HttpPost("headers/{id:guid}/valider")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status403Forbidden)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<IActionResult> ValiderFiche(Guid id)
        {
            var projectNo = UserProjectNo;
            if (string.IsNullOrEmpty(projectNo))
                return BadRequest(new { message = "Aucun projet n'est assigné à votre compte." });

            try
            {
                await _gasoilService.ValiderFicheAsync(id, projectNo);
                return Ok(new { message = "Fiche gasoil validée avec succès." });
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



        /// <summary>Crée une nouvelle ligne de distribution gasoil.</summary>
        [HttpPost("lines")]
        [ProducesResponseType(typeof(GasoilLineReadDto), StatusCodes.Status201Created)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status403Forbidden)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<ActionResult<GasoilLineReadDto>> CreateLine([FromBody] GasoilLineCreateDto lineDto)
        {
            var projectNo = UserProjectNo;
            if (string.IsNullOrEmpty(projectNo))
                return BadRequest(new { message = "Aucun projet n'est assigné à votre compte." });

            try
            {
                var created = await _gasoilService.CreateLineAsync(lineDto, projectNo);
                return CreatedAtAction(nameof(GetById), new { id = created.Id }, created);
            }
            catch (ArgumentException ex)
            {
                return BadRequest(new { message = ex.Message });
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

        /// <summary>Met à jour partiellement une ligne de distribution gasoil.</summary>
        [HttpPatch("lines/{id:guid}")]
        [ProducesResponseType(typeof(GasoilLineReadDto), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status403Forbidden)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<ActionResult<GasoilLineReadDto>> PatchLine(Guid id, [FromBody] GasoilLinePatchDto lineDto)
        {
            var projectNo = UserProjectNo;
            if (string.IsNullOrEmpty(projectNo))
                return BadRequest(new { message = "Aucun projet n'est assigné à votre compte." });

            try
            {
                var updated = await _gasoilService.PatchLineAsync(id, lineDto, projectNo);
                return Ok(updated);
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

        /// <summary>Supprime une ligne de distribution gasoil.</summary>
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
                await _gasoilService.DeleteLineAsync(id, projectNo);
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