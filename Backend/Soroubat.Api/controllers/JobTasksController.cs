using Microsoft.AspNetCore.Mvc;
using Soroubat.Api.Models;   // Pour trouver JobTaskDto
using Soroubat.Api.Services; // Pour trouver IJobTaskService

namespace Soroubat.Api.Controllers
{
    [ApiController] //Indique à ASP.NET Core que cette classe n'est pas une page web classique, mais une API REST
    [Route("api/[controller]")] //http://localhost:5227/api/jobtasks dans notre cas . Angular envoie une requête HTTP de type GET vers l'URL http://localhost:5227/api/jobtasks, et ASP.NET Core sait que cette requête doit être traitée par la méthode GetTasks() de cette classe.
    public class JobTasksController : ControllerBase
    {
        private readonly IJobTaskService _service;

        public JobTasksController(IJobTaskService service) // consommation du service : ASP.NET Core va automatiquement injecter une instance de BusinessCentralService (grâce à l'enregistrement que tu as fait dans Program.cs) dans ce constructeur lorsque quelqu'un crée une instance de JobTasksController. C'est ce qu'on appelle l'injection de dépendance.
        { 
            _service = service; 
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<JobTaskDto>>> GetTasks() // ActionResult est une classe qui encapsule une réponse HTTP. Elle peut contenir des données (comme votre liste de tâches) et un code de statut (200, 404, etc.). IEnumerable<JobTaskDto> indique que la réponse contiendra une collection de JobTaskDto.
        {
            var tasks = await _service.GetAllTasksAsync();
            return Ok(tasks); // Le Ok() génère un code de statut HTTP 200 . Il transforme automatiquement votre liste d'objets C# en format JSON pour qu'Angular puisse le lire.
        }
    }
}