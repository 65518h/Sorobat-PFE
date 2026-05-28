using Soroubat.Api.Models;

namespace Soroubat.Api.Interfaces
{
    /// <summary>
    /// Contrat du service de gestion des fiches de pointage salarié Business Central.
    /// Le chef de chantier peut créer, consulter, mettre à jour et supprimer les fiches
    /// de son chantier, ainsi que gérer les lignes de pointage journalier.
    /// </summary>
    public interface IEmpAttendanceService
    {

        /// <summary>
        /// Retourne toutes les fiches de pointage du projet du chef connecté.
        /// </summary>
        Task<IEnumerable<EmpAttendanceReadDto>> GetAllHeadersAsync(string projectNo);

        /// <summary>
        /// Retourne une fiche de pointage avec ses lignes ($expand=employeeAttendanceLines).
        /// Retourne null si introuvable.
        /// Lève <see cref="UnauthorizedAccessException"/> si la fiche n'appartient pas au projet.
        /// </summary>
        Task<EmpAttendanceReadDto?> GetHeaderByIdAsync(Guid id, string projectNo);

        /// <summary>
        /// Crée une nouvelle fiche de pointage en forçant le jobNo depuis le JWT.
        /// Lève <see cref="InvalidOperationException"/> si une fiche existe déjà pour ce chantier/période.
        /// </summary>
        Task<EmpAttendanceReadDto> CreateHeaderAsync(EmpAttendanceHeaderCreateDto dto, string projectNo);

        /// <summary>
        /// Met à jour partiellement l'en-tête d'une fiche de pointage.
        /// Lève <see cref="KeyNotFoundException"/> si la fiche est introuvable.
        /// Lève <see cref="UnauthorizedAccessException"/> si la fiche n'appartient pas au projet.
        /// </summary>
        Task<bool> PatchHeaderAsync(Guid id, EmpAttendanceHeaderPatchDto dto, string projectNo);

        /// <summary>
        /// Supprime une fiche de pointage.
        /// Lève <see cref="KeyNotFoundException"/> si la fiche est introuvable.
        /// Lève <see cref="UnauthorizedAccessException"/> si la fiche n'appartient pas au projet.
        /// </summary>
        Task<bool> DeleteHeaderAsync(Guid id, string projectNo);


        /// <summary>
        /// Crée les lignes de pointage d'une fiche existante.
        /// Lève une exception en cas d'erreur BC.
        /// </summary>
        Task<bool> CreateLinesAsync(List<EmpAttendanceLineCreateDto> lines, string projectNo);

        /// <summary>
        /// Met à jour partiellement une ligne de pointage.
        /// Lève <see cref="KeyNotFoundException"/> si la ligne est introuvable.
        /// Lève <see cref="UnauthorizedAccessException"/> si la ligne n'appartient pas au projet.
        /// </summary>
        Task<bool> PatchLineAsync(Guid lineId, EmpAttendanceLinePatchDto lineDto, string projectNo);

        /// <summary>
        /// Supprime une ligne de pointage.
        /// Lève <see cref="KeyNotFoundException"/> si la ligne est introuvable.
        /// Lève <see cref="UnauthorizedAccessException"/> si la ligne n'appartient pas au projet.
        /// </summary>
        Task<bool> DeleteLineAsync(Guid lineId, string projectNo);


        /// <summary>
        /// Retourne toutes les fiches de pointage avec leurs lignes ($expand=employeeAttendanceLines).
        /// Utilisé exclusivement par <see cref="AlertService"/> pour l'analyse des alertes.
        /// Ne pas exposer directement via un endpoint HTTP.
        /// </summary>
        Task<IEnumerable<EmpAttendanceReadDto>> GetAllHeadersWithLinesAsync(string projectNo);


        /// <summary>
        /// Marque la présence d'un salarié pour un jour donné sur une fiche de pointage,
        /// après vérification que la ligne appartient bien au projet du chef connecté.
        /// Lève <see cref="KeyNotFoundException"/> si le salarié n'est pas dans la fiche.
        /// Lève <see cref="ArgumentException"/> si le numéro de jour est invalide (hors 1–31).
        /// </summary>
        Task<bool> MarkPresenceAsync(Guid headerId, string employeeNo, int day, string projectNo);
    }
}