using Soroubat.Api.Interfaces;
using Soroubat.Api.Models;
using System.Text;
using System.Text.Json;
using System.Net.Http.Json;

// le namespace sert à organiser le code et à éviter les conflits de noms entre différentes parties de l'application. Ici, Soroubat.Api.Services indique que ce fichier fait partie des services de l'API Soroubat.
namespace Soroubat.Api.Services
{
    public class SiteManagementService : BaseService , ISiteManagementService 
    {
        private readonly HttpClient _httpClient;
        // c'est l'url de base de l'API exposée par BC, à ajuster selon votre configuration

        public SiteManagementService(HttpClient httpClient)
        {
            _httpClient = httpClient;
        }

        public async Task<List<JobDto>> GetAllJobsAsync()
        {
            // GetAsync("jobs") envoie une requête GET à l'endpoint "jobs" de l'API BC
            var response = await _httpClient.GetAsync("jobs"); 
            
            // Nouveau : gestion d'erreur au lieu de EnsureSuccessStatusCode pour avoir le message de BC
            if (!response.IsSuccessStatusCode) await HandleErrorResponse(response); // on utilise handleErrorResponse dans les service pour extraire le message d'erreur de BC et le propager au contrôleur en cas où BC retourne une erreur (ex: problème de connexion, endpoint incorrect, etc.)

            var data = await response.Content.ReadFromJsonAsync<BCResponse<JobDto>>();
            
            // Contrôle sur result : on lève une exception si les données sont nulles au lieu de retourner une liste vide par erreur
            if (data?.Value == null)
            {
                throw new Exception("Le format des données reçues pour les chantiers est invalide.");
            }

            return data.Value;
        }

        public async Task<List<JobTaskDto>> GetTasksByJobAsync(string jobNo) // le paramétre jobNo sera passé dans l'url.
        {
            // Filtrage OData pour ne récupérer que les tâches d'un chantier précis
            // exemple de url : http://localhost:7048/BC240/api/soroubat/siteManagement/v1.0/jobTasks?$filter=jobNo eq 'DESCHAMPS, 8 ET' 
            // un filter est utilisé ici ( pas un expand ) car on n'a pas besoin d'obtenir toutes les infos du job 
            var response = await _httpClient.GetAsync($"jobTasks?$filter=jobNo eq '{jobNo}'"); 
            
            // si le filtre n'est pas spécifié, BC renverra toutes les tâches de tous les chantiers
            if (!response.IsSuccessStatusCode) await HandleErrorResponse(response);

            var data = await response.Content.ReadFromJsonAsync<BCResponse<JobTaskDto>>();
            
            // Contrôle sur result : on vérifie que la désérialisation a fonctionné
            if (data?.Value == null)
            {
                throw new Exception("Le format des données reçues pour les tâches est invalide.");
            }

            return data.Value;
        }

        public async Task<bool> UpdateTaskProgressAsync(Guid id, decimal progress)
        {
            // c'est l'url spécifique pour mettre à jour une tâche précise, on utilise le guid technique (id) pour identifier la tâche à mettre à jour
            var url = $"jobTasks({id})";            
            // On n'envoie que le champ modifiable
            var patchData = new { progressPct = progress };
            
            // il faut sérialiser les données en JSON pour les envoyer dans le corps de la requête PATCH
            // aprés utf8 sert transofrmer le json en bytes pour le transport
            var json = JsonSerializer.Serialize(patchData); 
            
            // application/json est le type de contenu attendu par BC pour les requêtes PATCH
            var content = new StringContent(json, Encoding.UTF8, "application/json"); 

            var request = new HttpRequestMessage(new HttpMethod("PATCH"), url) { Content = content };
            request.Headers.Add("If-Match", "*"); // pour éviter les problèmes de concurrence, on utilise If-Match avec * pour dire que la mise à jour doit se faire même si la ressource a été modifiée depuis sa dernière récupération
            
            var response = await _httpClient.SendAsync(request); // c'est là ou la requéte patch est envoyée à BC
            
            if (!response.IsSuccessStatusCode)
            {
                // Utilisation de la méthode centralisée pour extraire l'erreur réelle de BC
                await HandleErrorResponse(response);
            }
            
            return response.IsSuccessStatusCode;
        }

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