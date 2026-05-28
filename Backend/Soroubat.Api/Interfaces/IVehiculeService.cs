using Soroubat.Api.Models;

namespace Soroubat.Api.Interfaces
{
    /// <summary>
    /// Contrat du service de gestion des pointages véhicule Business Central.
    /// Le chef de chantier peut créer, consulter, valider et supprimer les pointages
    /// de son chantier, ainsi que mettre à jour les lignes de pointage.
    /// </summary>
    public interface IVehiculeService
    {

        /// <summary>
        /// Retourne tous les pointages véhicule du projet du chef connecté.
        /// </summary>
        Task<IEnumerable<VehiculePointageHeaderReadDto>> GetAllHeadersAsync(string projectNo);

        /// <summary>
        /// Retourne un pointage spécifique avec ses lignes via un appel ciblé ($expand=vehiculePointageLines).
        /// Lève <see cref="KeyNotFoundException"/> si le pointage est introuvable.
        /// Lève <see cref="UnauthorizedAccessException"/> si le pointage n'appartient pas au projet.
        /// </summary>
        Task<VehiculePointageHeaderReadDto> GetHeaderByIdWithLinesAsync(Guid id, string projectNo);

        /// <summary>
        /// Crée un nouvel en-tête de pointage en forçant le jobNo depuis le JWT.
        /// Lève une exception en cas d'erreur BC.
        /// </summary>
        Task<VehiculePointageHeaderReadDto> CreateHeaderAsync(VehiculePointageHeaderCreateDto headerDto, string projectNo);

        /// <summary>
        /// Supprime un pointage véhicule.
        /// Lève <see cref="KeyNotFoundException"/> si le pointage est introuvable.
        /// Lève <see cref="UnauthorizedAccessException"/> si le pointage n'appartient pas au projet.
        /// </summary>
        Task<bool> DeleteHeaderAsync(Guid id, string projectNo);

        /// <summary>
        /// Valide un pointage en passant son statut de "Ouvert" à "Validé".
        /// Lève <see cref="KeyNotFoundException"/> si le pointage est introuvable.
        /// Lève <see cref="UnauthorizedAccessException"/> si le pointage n'appartient pas au projet.
        /// Lève <see cref="InvalidOperationException"/> si le statut n'est pas "Ouvert".
        /// </summary>
        Task<bool> ValiderPointageAsync(Guid id, string projectNo);


        /// <summary>
        /// Met à jour partiellement une ligne de pointage véhicule.
        /// Lève <see cref="KeyNotFoundException"/> si la ligne est introuvable.
        /// Lève <see cref="UnauthorizedAccessException"/> si la ligne n'appartient pas au projet.
        /// </summary>
        Task<VehiculePointageLineReadDto> PatchLineAsync(Guid lineId, VehiculePointageLinePatchDto lineDto, string projectNo);


        /// <summary>
        /// Retourne tous les pointages avec leurs lignes ($expand=vehiculePointageLines).
        /// Utilisé exclusivement par <see cref="AlertService"/> pour l'analyse des alertes.
        /// Ne pas exposer directement via un endpoint HTTP.
        /// </summary>
        Task<IEnumerable<VehiculePointageHeaderReadDto>> GetAllHeadersWithLinesAsync(string projectNo);
    }
}