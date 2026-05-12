using Soroubat.Api.Models;

namespace Soroubat.Api.Interfaces
{
    /// <summary>
    /// Contrat du service de gestion des fiches gasoil Business Central.
    /// Le chef de chantier peut créer, consulter, mettre à jour, valider et supprimer
    /// les fiches gasoil de son chantier, ainsi que gérer les lignes de distribution.
    /// </summary>
    public interface IGasoilService
    {
        // ── En-têtes (Headers) ───────────────────────────────────────────────

        /// <summary>
        /// Retourne toutes les fiches gasoil du projet du chef connecté.
        /// </summary>
        Task<IEnumerable<GasoilHeaderReadDto>> GetAllHeadersAsync(string projectNo);

        /// <summary>
        /// Retourne une fiche gasoil avec ses lignes ($expand=gasoilLines).
        /// Lève <see cref="KeyNotFoundException"/> si la fiche est introuvable.
        /// Lève <see cref="UnauthorizedAccessException"/> si la fiche n'appartient pas au projet.
        /// </summary>
        Task<GasoilHeaderReadDto> GetHeaderByIdAsync(Guid id, string projectNo);

        /// <summary>
        /// Crée une nouvelle fiche gasoil en forçant le jobNo depuis le JWT.
        /// Lève une exception en cas d'erreur BC.
        /// </summary>
        Task<GasoilHeaderReadDto> CreateHeaderAsync(GasoilHeaderCreateDto headerDto, string projectNo);

        /// <summary>
        /// Met à jour partiellement une fiche gasoil.
        /// Lève <see cref="KeyNotFoundException"/> si la fiche est introuvable.
        /// Lève <see cref="UnauthorizedAccessException"/> si la fiche n'appartient pas au projet.
        /// </summary>
        Task<GasoilHeaderReadDto> PatchHeaderAsync(Guid id, GasoilHeaderPatchDto headerDto, string projectNo);

        /// <summary>
        /// Supprime une fiche gasoil.
        /// Lève <see cref="KeyNotFoundException"/> si la fiche est introuvable.
        /// Lève <see cref="UnauthorizedAccessException"/> si la fiche n'appartient pas au projet.
        /// </summary>
        Task<bool> DeleteHeaderAsync(Guid id, string projectNo);

        /// <summary>
        /// Valide une fiche gasoil en passant son statut de "En Cours" à "Validé".
        /// Lève <see cref="KeyNotFoundException"/> si la fiche est introuvable.
        /// Lève <see cref="UnauthorizedAccessException"/> si la fiche n'appartient pas au projet.
        /// Lève <see cref="InvalidOperationException"/> si le statut n'est pas "En Cours".
        /// </summary>
        Task<bool> ValiderFicheAsync(Guid id, string projectNo);

        // ── Lignes ───────────────────────────────────────────────────────────

        /// <summary>
        /// Crée une nouvelle ligne de distribution gasoil.
        /// Vérifie que le document parent appartient au projet du chef connecté.
        /// Lève <see cref="KeyNotFoundException"/> si le document parent est introuvable.
        /// Lève <see cref="UnauthorizedAccessException"/> si le document n'appartient pas au projet.
        /// </summary>
        Task<GasoilLineReadDto> CreateLineAsync(GasoilLineCreateDto lineDto, string projectNo);

        /// <summary>
        /// Met à jour partiellement une ligne de distribution gasoil.
        /// Lève <see cref="KeyNotFoundException"/> si la ligne est introuvable.
        /// Lève <see cref="UnauthorizedAccessException"/> si la ligne n'appartient pas au projet.
        /// </summary>
        Task<GasoilLineReadDto> PatchLineAsync(Guid lineId, GasoilLinePatchDto lineDto, string projectNo);

        /// <summary>
        /// Supprime une ligne de distribution gasoil.
        /// Lève <see cref="KeyNotFoundException"/> si la ligne est introuvable.
        /// Lève <see cref="UnauthorizedAccessException"/> si la ligne n'appartient pas au projet.
        /// </summary>
        Task<bool> DeleteLineAsync(Guid lineId, string projectNo);

        // ── Usage interne (AlertService) ─────────────────────────────────────

        /// <summary>
        /// Retourne toutes les fiches gasoil avec leurs lignes ($expand=gasoilLines).
        /// Utilisé exclusivement par <see cref="AlertService"/> pour l'analyse des alertes.
        /// Ne pas exposer directement via un endpoint HTTP.
        /// </summary>
        Task<IEnumerable<GasoilHeaderReadDto>> GetAllHeadersWithLinesAsync(string projectNo);
    }
}