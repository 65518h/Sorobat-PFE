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

        // ─── PROJET ───────────────────────────────────────────────────────────

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
            // 1. SÉCURITÉ : récupérer la tâche et vérifier son appartenance au projet
            _logger.LogInformation("[SiteManagement] Vérification tâche {TaskId} pour projet {ProjectNo}",
                taskId, authorizedProjectNo);

            var getResponse = await _httpClient.GetAsync($"jobTasks({taskId})");

            if (getResponse.StatusCode == System.Net.HttpStatusCode.NotFound)
                throw new KeyNotFoundException($"La tâche '{taskId}' est introuvable dans Business Central.");

            if (!getResponse.IsSuccessStatusCode)
                await HandleErrorResponseAsync(getResponse);

            var task = await getResponse.Content.ReadFromJsonAsync<JobTaskReadDto>();

            if (task == null)
                throw new KeyNotFoundException($"La tâche '{taskId}' est introuvable dans Business Central.");

            // Vérification que la tâche appartient bien au projet du chef connecté
            if (!task.JobNo.Equals(authorizedProjectNo, StringComparison.OrdinalIgnoreCase))
            {
                _logger.LogWarning("[SiteManagement] Accès refusé : tâche {TaskId} appartient au projet {TaskProject}, " +
                    "chef connecté au projet {UserProject}", 
                    taskId, task.JobNo, authorizedProjectNo);
                throw new UnauthorizedAccessException(
                    "Vous n'avez pas le droit de modifier une tâche d'un autre chantier.");
            }

            // 2. EXÉCUTION : envoi du PATCH avec l'avancement
            var patchData = new { progressPct = progress };
            var json = JsonSerializer.Serialize(patchData); // ca change le dictionnaire c# en json 
            var content = new StringContent(json, Encoding.UTF8, "application/json");

            var request = new HttpRequestMessage(new HttpMethod("PATCH"), $"jobTasks({taskId})")
            {
                Content = content
            };
            // ne pas vérifier l'accés concurrent aux ressources
            request.Headers.TryAddWithoutValidation("If-Match", "*");

            var patchResponse = await _httpClient.SendAsync(request);

            if (!patchResponse.IsSuccessStatusCode)
            {
                _logger.LogError("[SiteManagement] Échec PATCH avancement tâche {TaskId} : {StatusCode}",
                    taskId, (int)patchResponse.StatusCode);
                await HandleErrorResponseAsync(patchResponse);
            }

            _logger.LogInformation("[SiteManagement] Avancement tâche {TaskId} mis à jour à {Progress}%",
                taskId, progress);

            return true;
        }
    }
}