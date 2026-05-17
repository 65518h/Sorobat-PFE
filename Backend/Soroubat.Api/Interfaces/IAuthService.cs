using Soroubat.Api.Models;

namespace Soroubat.Api.Interfaces
{
    /// <summary>
    /// Contrat du service d'authentification.
    /// </summary>
    public interface IAuthService
    {
        /// <summary>
        /// Vérifie les identifiants dans la base SQLite locale, puis valide le statut BC.
        /// Retourne un AuthResult avec le JWT en cas de succès, ou un code d'erreur précis en cas d'échec.
        /// </summary>
        Task<AuthResult> AuthenticateAsync(string email, string password);

        /// <summary>
        /// Génère un jeton JWT signé contenant l'email et le numéro de projet du chef de chantier.
        /// </summary>
        string GenerateJwtToken(string email, string projectNo);
    }
}