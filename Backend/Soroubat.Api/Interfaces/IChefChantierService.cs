namespace Soroubat.Api.Interfaces
{
    /// <summary>
    /// Contrat du service de récupération des informations du Chef de Chantier depuis Business Central.
    /// </summary>
    public interface IChefChantierService
    {
        /// <summary>
        /// Retourne le numéro de projet (JobNo) associé à l'adresse e-mail fournie.
        /// Retourne null si aucun chef de chantier actif n'est trouvé dans BC.
        /// </summary>
        Task<string?> GetJobNoByEmailAsync(string email);
    }
}