using System.Net.Http.Json;
using System.Text;
using System.Text.Json;
using System.Text.Json.Serialization;
using Soroubat.Api.Interfaces;
using Soroubat.Api.Models;

namespace Soroubat.Api.Services 
{
    public class PurchaseRequestService :  BaseService, IPurchaseRequestService 
    {
        private readonly HttpClient _httpClient;

        public PurchaseRequestService(HttpClient httpClient)
        {
            _httpClient = httpClient;
        }

        // --- MÉTHODES EN-TÊTE (HEADER) ---

        public async Task<IEnumerable<PurchaseRequestDto>> GetAllRequestsAsync()
        {
            var response = await _httpClient.GetAsync("purchaseRequests"); // purchaseRequests est ajouté au baseAddress dans Program.cs
            
            if (response.IsSuccessStatusCode)
            {
                // readFromJsonAsync assure que le json retourné par BC (texte brut) est désérialisé en un objet BCResponse<PurchaseRequestDto>
                var result = await response.Content.ReadFromJsonAsync<BCResponse<PurchaseRequestDto>>(); 
                
                // Contrôle strict sur result : on s'assure que la liste existe bien
                if (result?.Value == null)
                {
                    throw new Exception("Impossible de lire la liste des demandes : format de données BC invalide.");
                }

                return result.Value; // on utilise .Value ici car on s'attend à une collection d'entités, même si elle est vide, et pas à un objet unique
            }

            await HandleErrorResponse(response);
            throw new Exception("Erreur lors de la récupération des demandes.");
        }

        public async Task<PurchaseRequestDto> GetRequestByIdAsync(Guid id)
        {   
            // on utilise expand au lieu de filter pour récupérer de plus les informations sur la demande d'achat .
            var response = await _httpClient.GetAsync($"purchaseRequests({id})?$expand=purchaseRequestLines");
            if (!response.IsSuccessStatusCode) await HandleErrorResponse(response);

            var result = await response.Content.ReadFromJsonAsync<PurchaseRequestDto>();
            
            if (result == null)
            {
                throw new Exception("La demande d'achat est vide ou n'a pas pu être lue.");
            }

            return result; // on n'utilise pas .Value ici car on s'attend à un objet unique (comme racine ) et pas à une liste
        }

        public async Task<PurchaseRequestDto> CreateFullRequestAsync(PurchaseRequestDto request)
        {
            var response = await _httpClient.PostAsJsonAsync("purchaseRequests", request);
            if (!response.IsSuccessStatusCode) await HandleErrorResponse(response);
            
            var result = await response.Content.ReadFromJsonAsync<PurchaseRequestDto>();
            if (result == null) throw new Exception("La demande a été créée mais la réponse est illisible.");
            
            return result; // on retourne result ici pour s'assurer que le client reçoit bien toutes les données de la demande créée, y compris l'id généré par BC et les lignes associées si elles ont été créées en même temps
        }

        public async Task<bool> UpdateHeaderAsync(Guid id, object partialUpdate)
        {
            var url = $"purchaseRequests({id})";
            return await SendPatchRequest(url, partialUpdate);
        }

        public async Task<bool> DeleteRequestAsync(Guid id)
        {
            var response = await _httpClient.DeleteAsync($"purchaseRequests({id})");
            if (!response.IsSuccessStatusCode) await HandleErrorResponse(response);
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
            if (!response.IsSuccessStatusCode) await HandleErrorResponse(response);
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

        // ce que fait exactement cette méthode : elle lit le contenu de la réponse d'erreur de BC, 
        // essaie de le désérialiser en un objet BCResponseError pour extraire le message d'erreur spécifique de BC, et si la désérialisation échoue (par exemple si le format de l'erreur n'est pas celui attendu), elle lance une exception générique avec le code d'état HTTP et le contenu brut de l'erreur
        private async Task HandleErrorResponse(HttpResponseMessage response)
        {
            var errorContent = await response.Content.ReadAsStringAsync();
            try {
                var bcError = JsonSerializer.Deserialize<BCResponseError>(errorContent);
                throw new Exception(bcError?.Error?.Message ?? errorContent);
            } catch (JsonException) {
                throw new Exception($"Réponse de Business Central illisible (Format JSON invalide). Code HTTP {(int)response.StatusCode}. Contenu brut : {errorContent}");
            }
        }
    }
}
