using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Soroubat.Api.Interfaces;
using Soroubat.Api.Models;

namespace Soroubat.Api.Controllers
{
    [Authorize]
    [ApiController]
    [Route("api/[controller]")]
    public class EmployeeController : ControllerBase
    {
        private readonly IEmployeeService _employeeService;

        public EmployeeController(IEmployeeService employeeService)
        {
            _employeeService = employeeService;
        }

        /// <summary>Numéro de projet extrait du claim JWT — null si le compte n'est pas assigné.</summary>
        private string? UserProjectNo => User.FindFirst("projectNo")?.Value;

        /// <summary>
        /// Retourne la liste des salariés, filtrée par projet du chef connecté par défaut.
        /// </summary>
        [HttpGet]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status401Unauthorized)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<IActionResult> GetAllEmployees(
            [FromQuery] string? filter = null,
            [FromQuery] bool useProjectFilter = true,
            [FromQuery] int top = 10)
        {
            try
            {
                string? numProjet = null;
                if (useProjectFilter)
                {
                    numProjet = UserProjectNo;
                    if (string.IsNullOrEmpty(numProjet))
                        return BadRequest(new { message = "Aucun projet n'est assigné à votre compte." });
                }

                var data = await _employeeService.GetEmployeesAsync(numProjet, filter, top);
                return Ok(data);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = ex.Message });
            }
        }

        /// <summary>
        /// Vérifie l'identité d'un salarié par reconnaissance faciale.
        /// </summary>
        [HttpPost("scan")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status401Unauthorized)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<IActionResult> ScanFace([FromBody] FaceVerificationPostDto request)
        {
            var projectNo = UserProjectNo;
            if (string.IsNullOrEmpty(projectNo))
                return BadRequest(new { message = "Aucun projet n'est assigné à votre compte." });

            try
            {
                var isVerified = await _employeeService.VerifyFaceAsync(request, projectNo);

                if (isVerified)
                    return Ok(new { status = "Success", message = "Salarié identifié." });

                return Unauthorized(new { status = "Failed", message = "Échec de reconnaissance faciale." });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = ex.Message });
            }
        }
    }
}