using Soroubat.Api.Interfaces;
using Soroubat.Api.Models;
using System.Text;
using System.Text.Json;

namespace Soroubat.Api.Services
{
    public class SiteManagementService : ISiteManagementService
    {
        private readonly HttpClient _httpClient;
        // c'est l'url de base de l'API exposée par BC, à ajuster selon votre configuration
        private readonly string _apiBaseUrl = "http://localhost:7048/BC243/api/soroubat/siteManagement/v1.0/"; 

        public SiteManagementService(HttpClient httpClient)
        {
            _httpClient = httpClient;
        }

        public async Task<List<JobDto>> GetAllJobsAsync()
        {
            // GetAsync($"{_apiBaseUrl}jobs") envoie une requête GET à l'endpoint "jobs" de l'API BC
            var response = await _httpClient.GetAsync($"{_apiBaseUrl}jobs"); 
            response.EnsureSuccessStatusCode();
            var data = await response.Content.ReadFromJsonAsync<BCResponse<JobDto>>();
            return data?.Value ?? new List<JobDto>();
        }

        public async Task<List<JobTaskDto>> GetTasksByJobAsync(string jobNo)
        {
            // Filtrage OData pour ne récupérer que les tâches d'un chantier précis
            // exemple de url : http://localhost:7048/BC240/api/soroubat/siteManagement/v1.0/jobTasks?$filter=jobNo eq 'DESCHAMPS, 8 ET' 
            var response = await _httpClient.GetAsync($"{_apiBaseUrl}jobTasks?$filter=jobNo eq '{jobNo}'"); 
            
            // si le filtre n'est pas spécifié, BC renverra toutes les tâches de tous les chantiers
            response.EnsureSuccessStatusCode();
            var data = await response.Content.ReadFromJsonAsync<BCResponse<JobTaskDto>>();
            return data?.Value ?? new List<JobTaskDto>();
        }

        public async Task<bool> UpdateTaskProgressAsync(string jobNo, string taskNo, decimal progress)
        {
            // c'est l'url spécifique pour mettre à jour une tâche précise, en utilisant les clés de partition jobNo et taskNo
            var url = $"{_apiBaseUrl}jobTasks(jobNo='{jobNo}',taskNo='{taskNo}')";
            
            // On n'envoie que le champ modifiable
            var patchData = new { progressPct = progress };
            
            // il faut sérialiser les données en JSON pour les envoyer dans le corps de la requête PATCH
            // aprés utf8 sert transofrmer le json en bytes pour le transport
            var json = JsonSerializer.Serialize(patchData); 
            
            // application/json est le type de contenu attendu par BC pour les requêtes PATCH
            var content = new StringContent(json, Encoding.UTF8, "application/json"); 

            var request = new HttpRequestMessage(new HttpMethod("PATCH"), url) { Content = content };
            request.Headers.Add("If-Match", "*");
            var response = await _httpClient.SendAsync(request); // c'est là ou la requéte patch est envoyée à BC
            if (!response.IsSuccessStatusCode)
            {
                var errorContent = await response.Content.ReadAsStringAsync();
                // Affichez errorContent dans votre console ou votre debugger
                throw new Exception($"Erreur BC: {errorContent}");
            }
            
            return response.IsSuccessStatusCode;
        }
    }
}