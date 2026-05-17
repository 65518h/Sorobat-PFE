using Soroubat.Api.Models;

namespace Soroubat.Api.Interfaces
{
    /// <summary>
    /// Contrat du service de récupération des informations du Chef de Chantier depuis Business Central.
    /// </summary>
    public interface IChefChantierService
    {
        /// <summary>
        /// Vérifie le statut BC d'un chef de chantier et retourne son numéro de projet si actif.
        /// Un seul appel BC — retourne à la fois le statut et le projectNo.
        /// </summary>
        Task<ChefChantierCheckResult> CheckChefAsync(string email);
    }
}