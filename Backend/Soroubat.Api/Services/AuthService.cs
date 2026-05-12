using Microsoft.IdentityModel.Tokens;
using Soroubat.Api.Interfaces;
using Soroubat.Api.Data;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using Microsoft.EntityFrameworkCore;

namespace Soroubat.Api.Services
{
    /// <summary>
    /// Gère l'authentification locale (SQLite + BCrypt) et la génération des JWT.
    /// </summary>
    public class AuthService : IAuthService
    {
        private readonly IConfiguration _config; // pour accéder à la clé secrète du JWT et autres paramètres de configuration dans appsettings.json
        private readonly AuthDbContext _context; // C'est la passerelle vers votre base de données locale (SQLite)
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

            // Guard clause : on vérifie la clé JWT dès le démarrage pour un message d'erreur clair
            if (string.IsNullOrWhiteSpace(_config["Jwt:Key"])) // jwt : key c'est la clé privée pour signer les tokens
                throw new InvalidOperationException(
                    "La clé JWT 'Jwt:Key' est absente ou vide dans appsettings.json.");
        }

        public async Task<string?> AuthenticateAsync(string email, string password)
        {
            // 1. Recherche de l'utilisateur dans la base SQLite locale
            var user = await _context.Users
                .FirstOrDefaultAsync(u => u.Email == email);

            // 2. Vérification sécurisée du mot de passe avec BCrypt
            //    On utilise un temps de traitement constant même si l'utilisateur n'existe pas
            //    (protection contre les attaques de timing)
            if (user == null || !BCrypt.Net.BCrypt.Verify(password, user.PasswordHash))
            {
                _logger.LogWarning("[Auth] Tentative de connexion échouée pour {Email}", email);
                return null;
            }

            // 3. Récupération du numéro de projet depuis Business Central
            var projectNo = await _chefChantierService.GetJobNoByEmailAsync(email);

            if (string.IsNullOrWhiteSpace(projectNo))
            {
                // On permet la connexion mais le token indiquera qu'aucun projet n'est assigné.
                // Les contrôleurs protégés vérifieront ce claim et refuseront l'accès si nécessaire.
                _logger.LogWarning("[Auth] Connexion réussie pour {Email} mais aucun projet BC actif trouvé.", email);
            }
            else
            {
                _logger.LogInformation("[Auth] Connexion réussie pour {Email} — Projet : {ProjectNo}",
                    email, projectNo);
            }

            // 4. Génération du JWT — "N/A" si aucun projet n'est assigné dans BC
            return GenerateJwtToken(user.Email, projectNo ?? "N/A");
        }

        public string GenerateJwtToken(string email, string projectNo)
        {
            // La clé a déjà été vérifiée dans le constructeur — on peut l'utiliser directement
            var key = new SymmetricSecurityKey(
                Encoding.UTF8.GetBytes(_config["Jwt:Key"]!));

            var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

            var claims = new[]
            {
                new Claim(ClaimTypes.Email, email),
                new Claim(JwtRegisteredClaimNames.Sub, email),
                // Claim métier : numéro de projet lu par tous les contrôleurs protégés
                new Claim("projectNo", projectNo),
                // Identifiant unique du token (utile pour la révocation future)
                new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString())
            };

            var token = new JwtSecurityToken(
                issuer: _config["Jwt:Issuer"],
                audience: _config["Jwt:Audience"],
                claims: claims,
                // UtcNow (et non DateTime.Now) est la norme pour les JWT — évite les problèmes de fuseau horaire
                expires: DateTime.UtcNow.AddHours(8),
                signingCredentials: creds
            );

            return new JwtSecurityTokenHandler().WriteToken(token);
        }
    }
}