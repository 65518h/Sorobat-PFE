using Soroubat.Api.Models;

namespace Soroubat.Api.Services
{
    public interface IJobTaskService { //Je te promets (Task) de revenir vers toi avec une liste (List) de tâches structurées (JobTaskDto) dès que j'aurai fini d'interroger Business Central.
        Task<List<JobTaskDto>> GetAllTasksAsync(); 
        // Le rôle de Task est de représenter une opération qui est en cours, mais qui n'est pas encore terminée.
        // GetAllTasks : C'est le nom explicite de ce que fait la méthode (Récupérer toutes les tâches).
        // Async : C'est une convention de nommage obligatoire en C#. Toutes les méthodes qui renvoient une Task doivent se terminer par le suffixe Async. Cela prévient instantanément le développeur qui utilise votre code qu'il devra utiliser le mot-clé await.
    }

    public class BusinessCentralService : IJobTaskService //classe doit obligatoirement posséder une méthode GetAllTasksAsync()
    {
        private readonly HttpClient _httpClient; // C'est l'outil qui sait envoyer des requêtes GET, POST, etc.
        private readonly string _bcUrl = "http://localhost:7048/BC240/api/soroubat/siteManagement/v1.0/companies(ce6ec497-e411-ef11-9f8d-6045bdacdbf6)/jobTasks";
        // on peut aussi mettre l'url Odata du webservice

        public BusinessCentralService(HttpClient httpClient)
        {
            _httpClient = httpClient; // le undercore est une convention de nommage pour indiquer que c'est un champ privé.
        }

        public async Task<List<JobTaskDto>> GetAllTasksAsync()
        {
            // Envoi de la requête GET
            var response = await _httpClient.GetAsync(_bcUrl);
            response.EnsureSuccessStatusCode();

            var data = await response.Content.ReadFromJsonAsync<BCResponse<JobTaskDto>>();
            return data?.Value ?? new List<JobTaskDto>();
            //Si data n'est pas nul, donne-moi sa propriété Value, sinon donne-moi une nouvelle liste vide de JobTaskDto.
        }
    }
}