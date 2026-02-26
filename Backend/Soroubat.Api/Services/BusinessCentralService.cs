using Soroubat.Api.Models;

namespace Soroubat.Api.Services
{
    public interface IJobTaskService {
        Task<List<JobTaskDto>> GetAllTasksAsync();
    }

    public class BusinessCentralService : IJobTaskService
    {
        private readonly HttpClient _httpClient;
        private readonly string _bcUrl = "http://localhost:7048/BC240/api/soroubat/siteManagement/v1.0/companies(ce6ec497-e411-ef11-9f8d-6045bdacdbf6)/jobTasks";
        // on peut aussi mettre l'url Odata du webservice

        public BusinessCentralService(HttpClient httpClient)
        {
            _httpClient = httpClient;
        }

        public async Task<List<JobTaskDto>> GetAllTasksAsync()
        {
            // Envoi de la requête GET
            var response = await _httpClient.GetAsync(_bcUrl);
            response.EnsureSuccessStatusCode();

            var data = await response.Content.ReadFromJsonAsync<BCResponse<JobTaskDto>>();
            return data?.Value ?? new List<JobTaskDto>();
        }
    }
}