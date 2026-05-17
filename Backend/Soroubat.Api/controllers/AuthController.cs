using Microsoft.AspNetCore.Mvc;
using Soroubat.Api.Models;
using Soroubat.Api.Interfaces;

namespace Soroubat.Api.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AuthController : ControllerBase
    {
        private readonly IAuthService _authService;

        public AuthController(IAuthService authService)
        {
            _authService = authService;
        }

        /// <summary>
        /// Authentifie un chef de chantier et retourne un JWT signé.
        /// Codes d'erreur retournés :
        ///   401 INVALID_CREDENTIALS — email/mot de passe invalides ou email inconnu dans BC.
        ///   403 ACCOUNT_INACTIVE    — compte existant mais désactivé dans BC.
        ///   403 NO_PROJECT_ASSIGNED — compte actif mais sans projet assigné dans BC.
        /// </summary>
        [HttpPost("login")]
        [ProducesResponseType(typeof(object), StatusCodes.Status200OK)]
        [ProducesResponseType(typeof(ValidationProblemDetails), StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status401Unauthorized)]
        [ProducesResponseType(StatusCodes.Status403Forbidden)]
        public async Task<IActionResult> Login([FromBody] LoginPostDto loginDto)
        {
            if (!ModelState.IsValid)
                return ValidationProblem(ModelState);

            var result = await _authService.AuthenticateAsync(loginDto.Email, loginDto.Password);

            if (!result.Success)
            {
                return result.ErrorCode switch
                {
                    "ACCOUNT_INACTIVE" => StatusCode(StatusCodes.Status403Forbidden,
                        new { message = "Votre compte est désactivé. Contactez votre administrateur." }),

                    "NO_PROJECT_ASSIGNED" => StatusCode(StatusCodes.Status403Forbidden,
                        new { message = "Votre compte n'est associé à aucun projet. Contactez votre administrateur." }),

                    _ => Unauthorized(new { message = "Email ou mot de passe incorrect." })
                };
            }

            return Ok(new { token = result.Token });
        }
    }
}