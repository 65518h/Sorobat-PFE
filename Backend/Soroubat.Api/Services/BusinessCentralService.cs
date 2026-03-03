using Soroubat.Api.Models;

namespace Soroubat.Api.Services
{
    public class BusinessCentralService : IJobTaskService
    {
        private readonly HttpClient _httpClient;
        private readonly string _bcUrl = "http://localhost:7048/BC243/api/soroubat/siteManagement/v1.0/companies(ce6ec497-e411-ef11-9f8d-6045bdacdbf6)";

        public BusinessCentralService(HttpClient httpClient)
        {
            _httpClient = httpClient;
        }

        // GET: Récupérer toutes les tâches
        public async Task<List<JobTaskDto>> GetAllTasksAsync()
        {
            try
            {
                var response = await _httpClient.GetAsync($"{_bcUrl}/jobTasks");
                response.EnsureSuccessStatusCode();

                var data = await response.Content.ReadFromJsonAsync<BCResponse<JobTaskDto>>();
                return data?.Value ?? new List<JobTaskDto>();
            }
            catch (Exception ex)
            {
                // Log l'erreur
                Console.WriteLine($"Erreur lors de la récupération des tâches: {ex.Message}");
                return new List<JobTaskDto>();
            }
        }

        // GET: Récupérer une tâche par ID
        public async Task<JobTaskDto?> GetTaskByIdAsync(string id)
        {
            try
            {
                var response = await _httpClient.GetAsync($"{_bcUrl}/jobTasks?$filter=taskNo eq '{id}'");
                response.EnsureSuccessStatusCode();

                var data = await response.Content.ReadFromJsonAsync<BCResponse<JobTaskDto>>();
                return data?.Value?.FirstOrDefault();
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Erreur lors de la récupération de la tâche {id}: {ex.Message}");
                return null;
            }
        }

        // GET: Récupérer les tâches par projet
        public async Task<List<JobTaskDto>> GetTasksByProjectIdAsync(string projectId)
        {
            try
            {
                var response = await _httpClient.GetAsync($"{_bcUrl}/jobTasks?$filter=jobNo eq '{projectId}'");
                response.EnsureSuccessStatusCode();

                var data = await response.Content.ReadFromJsonAsync<BCResponse<JobTaskDto>>();
                return data?.Value ?? new List<JobTaskDto>();
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Erreur lors de la récupération des tâches du projet {projectId}: {ex.Message}");
                return new List<JobTaskDto>();
            }
        }

        // PATCH: Mettre à jour la progression d'une tâche
        public async Task<bool> UpdateTaskProgressAsync(string id, int progress)
        {
            try
            {
                var update = new { ProgressPct = progress };
                var response = await _httpClient.PatchAsJsonAsync($"{_bcUrl}/jobTasks('{id}')", update);
                return response.IsSuccessStatusCode;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Erreur lors de la mise à jour de la tâche {id}: {ex.Message}");
                return false;
            }
        }

        // POST: Créer une nouvelle tâche
        public async Task<JobTaskDto> CreateTaskAsync(JobTaskDto task)
        {
            try
            {
                var response = await _httpClient.PostAsJsonAsync($"{_bcUrl}/jobTasks", task);
                response.EnsureSuccessStatusCode();

                var createdTask = await response.Content.ReadFromJsonAsync<JobTaskDto>();
                return createdTask ?? task;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Erreur lors de la création de la tâche: {ex.Message}");
                throw;
            }
        }

        // PUT: Mettre à jour une tâche complète
        public async Task<bool> UpdateTaskAsync(string id, JobTaskDto task)
        {
            try
            {
                var response = await _httpClient.PutAsJsonAsync($"{_bcUrl}/jobTasks('{id}')", task);
                return response.IsSuccessStatusCode;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Erreur lors de la mise à jour de la tâche {id}: {ex.Message}");
                return false;
            }
        }

        // DELETE: Supprimer une tâche
        public async Task<bool> DeleteTaskAsync(string id)
        {
            try
            {
                var response = await _httpClient.DeleteAsync($"{_bcUrl}/jobTasks('{id}')");
                return response.IsSuccessStatusCode;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Erreur lors de la suppression de la tâche {id}: {ex.Message}");
                return false;
            }
        }
    }

    
}