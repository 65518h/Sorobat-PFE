using Microsoft.AspNetCore.Mvc;
using Soroubat.Api.Models;
using Soroubat.Api.Interfaces;
// on n'ajoute pas de using pour les services d'authentification spécifiques pour assurer le principe d'injection de dépendances et de séparation des préoccupations. Le contrôleur ne doit pas connaître les détails d'implémentation du service d'authentification, il doit juste appeler une interface.

namespace Soroubat.Api.Controllers
{
    [ApiController] // permet la validation auto , gestion des erreurs ...
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
        /// </summary>
        [HttpPost("login")]
        // utilent pour documenter les réponses possibles de l'endpoint, notamment pour Swagger/OpenAPI. Cela aide les développeurs à comprendre ce que l'endpoint retourne et dans quelles conditions.
        [ProducesResponseType(typeof(object), StatusCodes.Status200OK)]
        [ProducesResponseType(typeof(ValidationProblemDetails), StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status401Unauthorized)]
        public async Task<IActionResult> Login([FromBody] LoginPostDto loginDto)
        {
            // ModelState vérifie automatiquement les [Required] et [EmailAddress] du LoginDTO.
            // Si le JSON est malformé ou qu'un champ obligatoire manque, on retourne 400.
            if (!ModelState.IsValid)
                return ValidationProblem(ModelState);

            var token = await _authService.AuthenticateAsync(loginDto.Email, loginDto.Password);

            if (token == null)
                return Unauthorized(new { message = "Email ou mot de passe incorrect." });

            return Ok(new { token });
        }
    }
}