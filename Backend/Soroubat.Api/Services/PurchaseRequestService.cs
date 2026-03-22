using System.Net.Http.Json;
using System.Text;
using System.Text.Json;
using System.Text.Json.Serialization;
using Soroubat.Api.Interfaces;
using Soroubat.Api.Models;

namespace Soroubat.Api.Services 
{
    public class PurchaseRequestService : IPurchaseRequestService
    {
        private readonly HttpClient _httpClient;

        public PurchaseRequestService(HttpClient httpClient)
        {
            _httpClient = httpClient;
        }

        // --- MÉTHODES EN-TÊTE (HEADER) ---

        public async Task<IEnumerable<PurchaseRequest>> GetAllRequestsAsync()
        {
            var response = await _httpClient.GetAsync("purchaseRequests"); // purcahseRequests est ajouté au baseAddress dans Program.cs
            if (response.IsSuccessStatusCode)
            {
                // readFromJsonAsync assure que le json retourné par BC (texte brut) est désérialisé en un objet BCResponse<PurchaseRequest>
                var result = await response.Content.ReadFromJsonAsync<BCResponse<PurchaseRequest>>(); 
                return result?.Value ?? new List<PurchaseRequest>(); // retourne result.value ou une liste vide si result est null
            }
            return new List<PurchaseRequest>(); // En cas d'erreur, retourner une liste vide . on peut générer une exception au lieu de retourner une liste vide
        }

        public async Task<PurchaseRequest> GetRequestByIdAsync(Guid id)
        {
            return await _httpClient.GetFromJsonAsync<PurchaseRequest>($"purchaseRequests({id})?$expand=purchaseRequestLines");
        }

        public async Task<PurchaseRequest> CreateFullRequestAsync(PurchaseRequest request)
        {
            var response = await _httpClient.PostAsJsonAsync("purchaseRequests", request);
            if (!response.IsSuccessStatusCode) await HandleErrorResponse(response);
            return await response.Content.ReadFromJsonAsync<PurchaseRequest>();
        }

        public async Task<bool> UpdateHeaderAsync(Guid id, object partialUpdate)
        {
            var url = $"purchaseRequests({id})";
            return await SendPatchRequest(url, partialUpdate);
        }

        public async Task<bool> DeleteRequestAsync(Guid id)
        {
            var response = await _httpClient.DeleteAsync($"purchaseRequests({id})");
            return response.IsSuccessStatusCode;
        }

        // --- MÉTHODES LIGNES (LINES) ---

        public async Task<bool> UpdateLineAsync(Guid lineId, object partialUpdate)
        {
            var url = $"purchaseRequestLines({lineId})";
            return await SendPatchRequest(url, partialUpdate);
        }

        public async Task<bool> DeleteLineAsync(Guid lineId)
        {
            var response = await _httpClient.DeleteAsync($"purchaseRequestLines({lineId})");
            return response.IsSuccessStatusCode;
        }

        // --- OUTILS PRIVÉS ---

        private async Task<bool> SendPatchRequest(string url, object body)
        {
            var json = JsonSerializer.Serialize(body);
            var content = new StringContent(json, Encoding.UTF8, "application/json");
            var request = new HttpRequestMessage(HttpMethod.Patch, url) { Content = content };
            request.Headers.Add("If-Match", "*"); 

            var response = await _httpClient.SendAsync(request);
            if (!response.IsSuccessStatusCode) await HandleErrorResponse(response);
            return response.IsSuccessStatusCode;
        }

        private async Task HandleErrorResponse(HttpResponseMessage response)
        {
            var errorContent = await response.Content.ReadAsStringAsync();
            try {
                var bcError = JsonSerializer.Deserialize<BCResponseError>(errorContent);
                throw new Exception(bcError?.Error?.Message ?? errorContent);
            } catch (JsonException) {
                throw new Exception($"Erreur HTTP {(int)response.StatusCode}: {errorContent}");
            }
        }
    }
  
}