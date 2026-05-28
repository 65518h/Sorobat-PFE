using Microsoft.AspNetCore.Mvc; // permet d'utiliser les attributs de routage et les types de retour d'action
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
        ///   401 INVALID_CREDENTIALS :  email/mot de passe invalides ou email inconnu dans BC.
        ///   403 ACCOUNT_INACTIVE    :  compte existant mais désactivé dans BC.
        ///   403 NO_PROJECT_ASSIGNED :  compte actif mais sans projet assigné dans BC.
        /// </summary>
        [HttpPost("login")]
        [ProducesResponseType(typeof(object), StatusCodes.Status200OK)]
        [ProducesResponseType(typeof(ValidationProblemDetails), StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status401Unauthorized)]
        [ProducesResponseType(StatusCodes.Status403Forbidden)]
        public async Task<IActionResult> Login([FromBody] LoginPostDto loginDto)
        {
            if (!ModelState.IsValid) // modelState sert à vérifier que les données reçues respectent les règles de validation définies dans le DTO (ex: [Required], [EmailAddress], etc.)
                return ValidationProblem(ModelState);

            var result = await _authService.AuthenticateAsync(loginDto.Email, loginDto.Password); // await permet d'attendre la fin de l'exécution de la méthode AuthenticateAsync qui est asynchrone.  

            if (!result.Success)
            {
                return result.ErrorCode switch
                {
                    "ACCOUNT_INACTIVE" => StatusCode(StatusCodes.Status403Forbidden,
                        new { message = "Votre compte est désactivé. Contactez votre administrateur." }),

                    "NO_PROJECT_ASSIGNED" => StatusCode(StatusCodes.Status403Forbidden,
                        new { message = "Votre compte n'est associé à aucun projet. Contactez votre administrateur." }),

                    _ => Unauthorized(new { message = "Email ou mot de passe incorrect." }) // invalid credentials est géré ici , ca retourne le code statut 401
                    // on peut ajouter autres cas d'erreur
                };
            }

            return Ok(new { token = result.Token });
        }
    }
}