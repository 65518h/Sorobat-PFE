using Soroubat.Api.Models;

namespace Soroubat.Api.Interfaces
{
    public interface IPurchaseRequestService
    {
        // En-tête (Header)
        Task<IEnumerable<PurchaseRequest>> GetAllRequestsAsync();
        Task<PurchaseRequest> GetRequestByIdAsync(Guid id);
        Task<PurchaseRequest> CreateFullRequestAsync(PurchaseRequest request);
        Task<bool> UpdateHeaderAsync(Guid id, object partialUpdate); 
        Task<bool> DeleteRequestAsync(Guid id);

        // Lignes (Lines)
        Task<bool> UpdateLineAsync(Guid lineId, object partialUpdate);
        Task<bool> DeleteLineAsync(Guid lineId); 
    }
}