using Soroubat.Api.Models;

namespace Soroubat.Api.Interfaces
{
    /// <summary>
    /// Contrat du service de gestion des salariés Business Central.
    /// Gère la récupération des données salarié et la vérification par reconnaissance faciale.
    /// Ce service est utilisé en interne uniquement — aucun endpoint HTTP ne l'expose directement.
    /// </summary>
    public interface IEmployeeService
    {
        /// <summary>
        /// Vérifie l'identité d'un salarié par comparaison de visages.
        /// Retourne true si le visage capturé correspond à la photo de référence dans BC.
        /// </summary>
        Task<bool> VerifyFaceAsync(FaceVerificationPostDto request, string? projectNo);
    }
}