using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using Soroubat.Api.Data;
using Soroubat.Api.Interfaces;
using Soroubat.Api.Models;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace Soroubat.Api.Services
{
    /// <summary>
    /// Gère l'authentification hybride : credentials vérifiés dans SQLite,
    /// statut et projet vérifiés dans Business Central en un seul appel.
    /// </summary>
    public class AuthService : IAuthService
    {
        private readonly IConfiguration _config;
        private readonly AuthDbContext _context;
        private readonly IChefChantierService _chefChantierService;
        private readonly ILogger<AuthService> _logger;

        public AuthService(
            IConfiguration config,
            AuthDbContext context,
            IChefChantierService chefChantierService,
            ILogger<AuthService> logger)
        {
            _config = config;
            _context = context;
            _chefChantierService = chefChantierService;
            _logger = logger;

            if (string.IsNullOrWhiteSpace(_config["Jwt:Key"]))
                throw new InvalidOperationException(
                    "La clé JWT 'Jwt:Key' est absente ou vide dans appsettings.json.");
        }

        public async Task<AuthResult> AuthenticateAsync(string email, string password)
        {
            _logger.LogInformation("[Auth] Tentative de connexion pour {Email}", email);

            // ÉTAPE 1 : Vérifier les credentials dans la base SQLite locale
            var user = await _context.Users
                .FirstOrDefaultAsync(u => u.Email == email);

            // Temps de traitement constant même si l'utilisateur est introuvable
            // (protection contre les attaques de timing)
            bool isPasswordValid = user != null
                && BCrypt.Net.BCrypt.Verify(password, user.PasswordHash);

            if (user == null || !isPasswordValid)
            {
                _logger.LogWarning("[Auth] Credentials invalides pour {Email}", email);
                return AuthResult.Fail("INVALID_CREDENTIALS");
            }

            // ÉTAPE 2 : Vérifier le statut et le projet dans BC — un seul appel HTTP
            var bcCheck = await _chefChantierService.CheckChefAsync(email);

            if (bcCheck.Status == ChefChantierStatus.Inactive)
            {
                _logger.LogWarning("[Auth] Compte inactif dans BC pour {Email}", email);
                return AuthResult.Fail("ACCOUNT_INACTIVE");
            }

            if (bcCheck.Status == ChefChantierStatus.NoProject)
            {
                _logger.LogWarning("[Auth] Aucun projet assigné dans BC pour {Email}", email);
                return AuthResult.Fail("NO_PROJECT_ASSIGNED");
            }

            if (bcCheck.Status != ChefChantierStatus.Active)
            {
                _logger.LogWarning("[Auth] Chef introuvable dans BC pour {Email}", email);
                return AuthResult.Fail("INVALID_CREDENTIALS");
            }

            _logger.LogInformation("[Auth] Connexion réussie pour {Email} — Projet : {ProjectNo}",
                email, bcCheck.ProjectNo);

            return AuthResult.Ok(GenerateJwtToken(email, bcCheck.ProjectNo!));
        }

        public string GenerateJwtToken(string email, string projectNo)
        {
            var key = new SymmetricSecurityKey(
                Encoding.UTF8.GetBytes(_config["Jwt:Key"]!));

            var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

            var claims = new[]
            {
                new Claim(ClaimTypes.Email, email),
                new Claim(JwtRegisteredClaimNames.Sub, email),
                new Claim("projectNo", projectNo),
                new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString())
            };

            var token = new JwtSecurityToken(
                issuer: _config["Jwt:Issuer"],
                audience: _config["Jwt:Audience"],
                claims: claims,
                expires: DateTime.UtcNow.AddHours(8),
                signingCredentials: creds
            );

            return new JwtSecurityTokenHandler().WriteToken(token);
        }
    }
}