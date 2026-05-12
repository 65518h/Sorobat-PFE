namespace Soroubat.Api.Interfaces
{
    /// <summary>
    /// Contrat du service d'authentification.
    /// </summary>
    public interface IAuthService
    {
        /// <summary>
        /// Vérifie les identifiants dans la base locale et retourne un JWT si valides.
        /// Retourne null si l'email ou le mot de passe est incorrect.
        /// </summary>
        Task<string?> AuthenticateAsync(string email, string password);

        /// <summary>
        /// Génère un jeton JWT signé contenant l'email et le numéro de projet du chef de chantier.
        /// </summary>
        string GenerateJwtToken(string email, string projectNo);
    }
}