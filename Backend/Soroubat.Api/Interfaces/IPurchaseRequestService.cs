using Soroubat.Api.Models;

namespace Soroubat.Api.Interfaces
{
    /// <summary>
    /// Contrat du service de gestion des demandes d'achat Business Central.
    /// </summary>
    public interface IPurchaseRequestService
    {
        // ── En-tête (Header) ─────────────────────────────────────────────────

        /// <summary>
        /// Retourne toutes les demandes d'achat du projet du chef connecté.
        /// </summary>
        Task<IEnumerable<PurchaseRequestReadDto>> GetAllRequestsAsync(string projectNo);

        /// <summary>
        /// Retourne une demande d'achat avec ses lignes.
        /// Lève <see cref="UnauthorizedAccessException"/> si la demande n'appartient pas au projet.
        /// Retourne null si introuvable.
        /// </summary>
        Task<PurchaseRequestReadDto?> GetRequestByIdAsync(Guid id, string projectNo);

        /// <summary>
        /// Crée l'en-tête d'une demande d'achat en forçant le jobNo depuis le JWT.
        /// Lève une exception en cas d'erreur BC.
        /// </summary>
        Task<PurchaseRequestReadDto> CreateHeaderAsync(PurchaseRequestCreateDto header, string projectNo);

        /// <summary>
        /// Crée les lignes d'une demande d'achat existante.
        /// Lève <see cref="ArgumentException"/> si DocumentNo est absent.
        /// Lève une exception en cas d'erreur BC.
        /// </summary>
        Task<bool> CreateLinesAsync(List<PurchaseRequestLineCreateDto> lines, string projectNo);

        /// <summary>
        /// Met à jour partiellement l'en-tête d'une demande d'achat.
        /// Lève <see cref="UnauthorizedAccessException"/> si la demande n'appartient pas au projet.
        /// Lève <see cref="KeyNotFoundException"/> si introuvable.
        /// </summary>
        Task<bool> PatchHeaderAsync(Guid id, PurchaseRequestPatchDto header, string projectNo);

        /// <summary>
        /// Soumet une demande d'achat pour approbation (Open → To Approve).
        /// Lève <see cref="UnauthorizedAccessException"/> si la demande n'appartient pas au projet.
        /// Lève <see cref="InvalidOperationException"/> si le statut n'est pas "Open".
        /// Lève <see cref="KeyNotFoundException"/> si introuvable.
        /// </summary>
        Task<bool> SubmitForApprovalAsync(Guid id, string projectNo);

        /// <summary>
        /// Supprime une demande d'achat.
        /// Lève <see cref="UnauthorizedAccessException"/> si la demande n'appartient pas au projet.
        /// Lève <see cref="KeyNotFoundException"/> si introuvable.
        /// </summary>
        Task<bool> DeleteRequestAsync(Guid id, string projectNo);

        // ── Lignes ───────────────────────────────────────────────────────────

        /// <summary>
        /// Met à jour partiellement une ligne de demande d'achat.
        /// Lève <see cref="UnauthorizedAccessException"/> si la ligne n'appartient pas au projet.
        /// Lève <see cref="KeyNotFoundException"/> si introuvable.
        /// </summary>
        Task<bool> PatchLineAsync(Guid lineId, PurchaseRequestLinePatchDto lineDto, string projectNo);

        /// <summary>
        /// Supprime une ligne de demande d'achat.
        /// Lève <see cref="UnauthorizedAccessException"/> si la ligne n'appartient pas au projet.
        /// Lève <see cref="KeyNotFoundException"/> si introuvable.
        /// </summary>
        Task<bool> DeleteLineAsync(Guid lineId, string projectNo);
    }
}