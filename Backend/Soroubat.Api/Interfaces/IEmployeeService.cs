using Soroubat.Api.Models;
using System.Text.Json;

namespace Soroubat.Api.Interfaces
{
    /// <summary>
    /// Contrat du service de gestion des salariés Business Central.
    /// Gère la récupération des données salarié et la vérification par reconnaissance faciale.
    /// </summary>
    public interface IEmployeeService
    {
        /// <summary>
        /// Récupère la liste des salariés depuis BC, filtrée optionnellement par projet et/ou critère.
        /// </summary>
        /// <param name="numProjet">Filtre sur le chantier — null pour tous les projets.</param>
        /// <param name="filter">Filtre OData additionnel (ex : "matricule eq 'ABC'").</param>
        /// <param name="top">Nombre maximum de résultats à retourner.</param>
        Task<JsonElement> GetEmployeesAsync(string? numProjet = null, string? filter = null, int? top = null);

        /// <summary>
        /// Vérifie l'identité d'un salarié par comparaison de visages.
        /// Retourne true si le visage capturé correspond à la photo de référence dans BC.
        /// </summary>
        Task<bool> VerifyFaceAsync(FaceVerificationPostDto request, string? numProjet);
    }
}