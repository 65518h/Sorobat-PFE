using Soroubat.Api.Models;

namespace Soroubat.Api.Interfaces
{
    /// <summary>
    /// Contrat du service de gestion des ordres de transfert Business Central.
    /// Le chef de chantier peut consulter les transferts qui lui sont destinés
    /// et enregistrer la réception (qtyToReceive, numVehicule) sur les lignes.
    /// </summary>
    public interface ITransferService
    {
        // ── En-têtes (Headers) ───────────────────────────────────────────────

        /// <summary>
        /// Retourne tous les ordres de transfert dont le chantier de destination
        /// correspond au projet du chef connecté.
        /// </summary>
        Task<IEnumerable<TransferHeaderReadDto>> GetAllTransfersAsync(string projectNo);

        /// <summary>
        /// Retourne un ordre de transfert avec ses lignes ($expand=transferLines).
        /// Retourne null si introuvable ou si le chantier de destination ne correspond pas.
        /// Lève <see cref="KeyNotFoundException"/> si l'ID n'existe pas dans BC.
        /// Lève <see cref="UnauthorizedAccessException"/> si le transfert n'appartient pas au projet.
        /// </summary>
        Task<TransferHeaderReadDto?> GetTransferByIdAsync(Guid id, string projectNo);

        // ── Lignes ───────────────────────────────────────────────────────────

        /// <summary>
        /// Met à jour les champs de réception d'une ligne de transfert
        /// (qtyToReceive et/ou numVehicule — seuls champs modifiables côté AL).
        /// Lève <see cref="KeyNotFoundException"/> si la ligne est introuvable.
        /// Lève <see cref="UnauthorizedAccessException"/> si la ligne n'appartient pas au projet.
        /// </summary>
        Task<bool> PatchLineAsync(Guid lineId, TransferLinePatchDto lineDto, string projectNo);

        // ── Usage interne (AlertService) ─────────────────────────────────────

        /// <summary>
        /// Retourne tous les ordres de transfert avec leurs lignes ($expand=transferLines).
        /// Utilisé exclusivement par <see cref="AlertService"/> pour l'analyse des alertes.
        /// Ne pas exposer directement via un endpoint HTTP.
        /// </summary>
        Task<IEnumerable<TransferHeaderReadDto>> GetAllTransfersWithLinesAsync(string projectNo);
    }
}