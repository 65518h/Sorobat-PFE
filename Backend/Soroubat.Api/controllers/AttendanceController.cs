using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Soroubat.Api.Interfaces;
using Soroubat.Api.Models;
using System.Security.Claims;

namespace Soroubat.Api.Controllers
{
    [Authorize]
    [ApiController]
    [Route("api/[controller]")]
    public class AttendanceController : ControllerBase
    {
        private readonly IEmpAttendanceService _service;
        private readonly IEmployeeService _employeeService;

        public AttendanceController(IEmpAttendanceService service, IEmployeeService employeeService)
        {
            _service = service;
            _employeeService = employeeService;
        }

        /// <summary>Numéro de projet extrait du claim JWT — null si le compte n'est pas assigné.</summary>
        private string? UserProjectNo => User.FindFirst("projectNo")?.Value;

        // ── EN-TÊTES ──────────────────────────────────────────────────────────

        /// <summary>Retourne toutes les fiches de pointage du chantier du chef connecté.</summary>
        [HttpGet]
        [ProducesResponseType(typeof(IEnumerable<EmpAttendanceReadDto>), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<ActionResult<IEnumerable<EmpAttendanceReadDto>>> GetAll()
        {
            var projectNo = UserProjectNo;
            if (string.IsNullOrEmpty(projectNo))
                return BadRequest(new { message = "Aucun projet n'est assigné à votre compte." });

            try
            {
                var headers = await _service.GetAllHeadersAsync(projectNo);
                return Ok(headers);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = ex.Message });
            }
        }

        /// <summary>Retourne une fiche de pointage avec ses lignes.</summary>
        [HttpGet("{id:guid}")]
        [ProducesResponseType(typeof(EmpAttendanceReadDto), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status403Forbidden)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<ActionResult<EmpAttendanceReadDto>> GetById(Guid id)
        {
            var projectNo = UserProjectNo;
            if (string.IsNullOrEmpty(projectNo))
                return BadRequest(new { message = "Aucun projet n'est assigné à votre compte." });

            try
            {
                var result = await _service.GetHeaderByIdAsync(id, projectNo);

                if (result == null)
                    return NotFound(new { message = "Fiche de pointage introuvable." });

                return Ok(result);
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

        /// <summary>Crée une nouvelle fiche de pointage.</summary>
        [HttpPost]
        [ProducesResponseType(typeof(EmpAttendanceReadDto), StatusCodes.Status201Created)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status409Conflict)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<ActionResult<EmpAttendanceReadDto>> CreateHeader([FromBody] EmpAttendanceHeaderCreateDto dto)
        {
            var projectNo = UserProjectNo;
            if (string.IsNullOrEmpty(projectNo))
                return BadRequest(new { message = "Aucun projet n'est assigné à votre compte." });

            try
            {
                var created = await _service.CreateHeaderAsync(dto, projectNo);
                return CreatedAtAction(nameof(GetById), new { id = created.Id }, created);
            }
            catch (InvalidOperationException ex) when (ex.Message.Contains("Deja saisie"))
            {
                return Conflict(new { message = "Un pointage existe déjà pour ce chantier sur cette période." });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = ex.Message });
            }
        }

        /// <summary>Met à jour partiellement l'en-tête d'une fiche de pointage.</summary>
        [HttpPatch("{id:guid}")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status403Forbidden)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<IActionResult> PatchHeader(Guid id, [FromBody] EmpAttendanceHeaderPatchDto dto)
        {
            var projectNo = UserProjectNo;
            if (string.IsNullOrEmpty(projectNo))
                return BadRequest(new { message = "Aucun projet n'est assigné à votre compte." });

            try
            {
                await _service.PatchHeaderAsync(id, dto, projectNo);
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

        /// <summary>Supprime une fiche de pointage.</summary>
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
                await _service.DeleteHeaderAsync(id, projectNo);
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

        // ── LIGNES ────────────────────────────────────────────────────────────

        /// <summary>Crée les lignes de pointage d'une fiche existante.</summary>
        [HttpPost("lines")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<IActionResult> CreateLines([FromBody] List<EmpAttendanceLineCreateDto> lines)
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
            catch (Exception ex)
            {
                return StatusCode(500, new { message = ex.Message });
            }
        }

        /// <summary>Met à jour partiellement une ligne de pointage (jours, matricule, affectation, qualification).</summary>
        [HttpPatch("lines/{id:guid}")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status403Forbidden)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<IActionResult> PatchLine(Guid id, [FromBody] EmpAttendanceLinePatchDto lineDto)
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

        /// <summary>Supprime une ligne de pointage.</summary>
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

        // ── RECONNAISSANCE FACIALE ────────────────────────────────────────────

        /// <summary>
        /// Marque la présence d'un salarié après vérification par reconnaissance faciale.
        /// </summary>
        [HttpPost("scan-presence")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status401Unauthorized)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<IActionResult> MarkPresenceWithFace([FromBody] FaceAttendancePostDto request)
        {
            var projectNo = UserProjectNo;
            if (string.IsNullOrEmpty(projectNo))
                return BadRequest(new { message = "Aucun projet n'est assigné à votre compte." });

            if (string.IsNullOrEmpty(request.Matricule))
                return BadRequest(new { message = "Le matricule est obligatoire." });

            // ÉTAPE 1 : Vérification de l'identité par reconnaissance faciale
            var faceRequest = new FaceVerificationPostDto
            {
                Matricule            = request.Matricule,
                CapturedImageBase64  = request.CapturedImageBase64
            };

            var isVerified = await _employeeService.VerifyFaceAsync(faceRequest, projectNo);

            if (!isVerified)
                return Unauthorized(new { message = "Reconnaissance faciale échouée." });

            // ÉTAPE 2 : Marquage de la présence si identité confirmée
            try
            {
                var success = await _service.MarkPresenceAsync(
                    request.HeaderId,
                    request.Matricule,
                    request.Day,
                    projectNo);

                if (success)
                    return Ok(new { message = $"Présence marquée pour le jour {request.Day}." });

                return BadRequest(new { message = "Erreur lors de la mise à jour du pointage." });
            }
            catch (KeyNotFoundException ex)
            {
                return NotFound(new { message = ex.Message });
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
    }
}