using Soroubat.Api.Interfaces;
using Soroubat.Api.Models;
using System.Text;
using System.Text.Json;
using System.Net.Http.Json;

namespace Soroubat.Api.Services
{
    /// <summary>
    /// Interagit avec les APIs Business Central JobAPI et JobTaskAPI
    /// pour la consultation et la mise à jour des projets et tâches de chantier.
    /// </summary>
    public class SiteManagementService : BaseService, ISiteManagementService
    {
        private readonly HttpClient _httpClient;
        private readonly ILogger<SiteManagementService> _logger;

        public SiteManagementService(HttpClient httpClient, ILogger<SiteManagementService> logger)
        {
            _httpClient = httpClient;
            _logger = logger;
        }


        public async Task<JobReadDto> GetAssignedJobAsync(string projectNo)
        {
            var url = $"jobs?$filter=no eq '{projectNo}'";
            _logger.LogInformation("[SiteManagement] Récupération du projet {ProjectNo}", projectNo);

            var response = await _httpClient.GetAsync(url);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            var data = await response.Content.ReadFromJsonAsync<BCResponse<JobReadDto>>();
            var job = data?.Value?.FirstOrDefault();

            if (job == null)
            {
                _logger.LogWarning("[SiteManagement] Projet introuvable dans BC : {ProjectNo}", projectNo);
                throw new KeyNotFoundException($"Le projet '{projectNo}' est introuvable dans Business Central.");
            }

            return job;
        }



        public async Task<List<JobTaskReadDto>> GetMyTasksAsync(string projectNo)
        {
            var url = $"jobTasks?$filter=jobNo eq '{projectNo}'";
            _logger.LogInformation("[SiteManagement] Récupération des tâches du projet {ProjectNo}", projectNo);

            var response = await _httpClient.GetAsync(url);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            var data = await response.Content.ReadFromJsonAsync<BCResponse<JobTaskReadDto>>();
            return data?.Value ?? new List<JobTaskReadDto>();
        }


        public async Task<bool> UpdateTaskProgressAsync(Guid taskId, decimal progress, string authorizedProjectNo)
        {
            var (_, etag) = await GetAndVerifyTaskAsync(taskId, authorizedProjectNo);

            var patchData = new { progressPct = progress };
            var json      = JsonSerializer.Serialize(patchData);
            var request   = new HttpRequestMessage(HttpMethod.Patch, $"jobTasks({taskId})")
            {
                Content = new StringContent(json, Encoding.UTF8, "application/json")
            };
            request.Headers.TryAddWithoutValidation("If-Match", etag ?? "*");

            var response = await _httpClient.SendAsync(request);

            if (!response.IsSuccessStatusCode)
            {
                _logger.LogError("[SiteManagement] Échec PATCH avancement tâche {TaskId} : {StatusCode}",
                    taskId, (int)response.StatusCode);
                await HandleErrorResponseAsync(response);
            }

            _logger.LogInformation("[SiteManagement] Avancement tâche {TaskId} mis à jour à {Progress}%",
                taskId, progress);

            return true;
        }
        

        // helpers 
        private async Task<(JobTaskReadDto Task, string? ETag)> GetAndVerifyTaskAsync(Guid taskId, string projectNo)
        {
            var response = await _httpClient.GetAsync($"jobTasks({taskId})");

            if (response.StatusCode == System.Net.HttpStatusCode.NotFound)
                throw new KeyNotFoundException(
                    $"La tâche '{taskId}' est introuvable dans Business Central.");

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            var task = await response.Content.ReadFromJsonAsync<JobTaskReadDto>();

            if (task == null)
                throw new KeyNotFoundException(
                    $"La tâche '{taskId}' est introuvable dans Business Central.");

            if (!task.JobNo.Equals(projectNo, StringComparison.OrdinalIgnoreCase))
            {
                _logger.LogWarning(
                    "[SiteManagement] Accès refusé : tâche {TaskId} appartient au projet {TaskProject}, " +
                    "chef connecté au projet {UserProject}",
                    taskId, task.JobNo, projectNo);
                throw new UnauthorizedAccessException(
                    "Vous n'avez pas le droit de modifier une tâche d'un autre chantier.");
            }

            var etag = response.Headers.ETag?.ToString();
            return (task, etag);
        }
    }
}