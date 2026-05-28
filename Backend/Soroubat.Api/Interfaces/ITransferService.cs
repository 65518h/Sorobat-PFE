using Soroubat.Api.Models;

namespace Soroubat.Api.Interfaces
{
    /// <summary>
    /// Contrat du service de gestion des ordres de transfert Business Central.
    /// Le chef de chantier peut consulter les transferts qui lui sont destinés,
    /// enregistrer la réception (qtyToReceive, numVehicule) sur les lignes,
    /// et mettre à jour la date de réception sur l'en-tête.
    /// </summary>
    public interface ITransferService
    {

        /// <summary>
        /// Retourne tous les ordres de transfert dont le chantier de destination
        /// correspond au projet du chef connecté.
        /// </summary>
        Task<IEnumerable<TransferHeaderReadDto>> GetAllTransfersAsync(string projectNo);

        /// <summary>
        /// Retourne un ordre de transfert avec ses lignes ($expand=transferLines).
        /// Lève <see cref="KeyNotFoundException"/> si l'ID n'existe pas dans BC.
        /// Lève <see cref="UnauthorizedAccessException"/> si le transfert n'appartient pas au projet.
        /// </summary>
        Task<TransferHeaderReadDto> GetTransferByIdAsync(Guid id, string projectNo);

        /// <summary>
        /// Met à jour la date de réception d'un ordre de transfert.
        /// Lève <see cref="KeyNotFoundException"/> si l'ID n'existe pas dans BC.
        /// Lève <see cref="UnauthorizedAccessException"/> si le transfert n'appartient pas au projet.
        /// </summary>
        Task<bool> PatchHeaderAsync(Guid id, TransferHeaderPatchDto headerDto, string projectNo);


        /// <summary>
        /// Met à jour les champs de réception d'une ligne de transfert
        /// (qtyToReceive et/ou numVehicule — seuls champs modifiables côté AL).
        /// Lève <see cref="KeyNotFoundException"/> si la ligne est introuvable.
        /// Lève <see cref="UnauthorizedAccessException"/> si la ligne n'appartient pas au projet.
        /// </summary>
        Task<bool> PatchLineAsync(Guid lineId, TransferLinePatchDto lineDto, string projectNo);


        /// <summary>
        /// Retourne tous les ordres de transfert avec leurs lignes ($expand=transferLines).
        /// Utilisé exclusivement par AlertService pour l'analyse des alertes.
        /// Ne pas exposer directement via un endpoint HTTP.
        /// </summary>
        Task<IEnumerable<TransferHeaderReadDto>> GetAllTransfersWithLinesAsync(string projectNo);
    }
}