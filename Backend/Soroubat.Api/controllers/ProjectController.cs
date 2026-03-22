using Soroubat.Api.Interfaces;
using Microsoft.AspNetCore.Mvc;
using Soroubat.Api.Models;

namespace Soroubat.Api.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ProjectsController : ControllerBase
    {
        //déclaration
        private readonly ISiteManagementService _siteService; // c'est pour dire que cette classe aura une inerface ISiteManagementService qui sera utilisée pour accéder aux données de chantier. (résérvation)

        public ProjectsController(ISiteManagementService service) 
        {
            // _siteservice est une référence à l'interface ISiteManagementService qui passe au service concret SiteManagementService pour fournir l'implémentation de ce service . c'est le principe de l'injection de dépendance qui assure un couplage faible entre le contrôleur et le service.
            _siteService = service; // affectaion
        }

        [HttpGet]
        // Task indique qu'un résultat sera retourné de manière 
        // ActionResult est un type de retour qui encapsule une réponse HTTP, ce qui permet de retourner différents types de réponses (Ok, NotFound, BadRequest, etc.) selon le résultat de l'opération
        // IEnumerable<JobDto> indique que le résultat attendu est une collection d'objets iterable de type JobDto
        public async Task<ActionResult<IEnumerable<JobDto>>> GetJobs()
        {
            // on n'utlile pas une variable success dans ce cas puisque si la récupération a échoué on recevra une liste vide .
            var jobs = await _siteService.GetAllJobsAsync(); // await est utilisé pour attendre la complétion de l'opération asynchrone GetAllJobsAsync() 
            if (jobs == null) return NotFound();
            return Ok(jobs); // ok jobs retourne une réponse HTTP 200 avec la liste des chantiers récupérés depuis BC à partir de la méthode GetAllJobsAsync() du service ISiteManagementService
        }

        [HttpGet("{jobNo}/tasks")]
        public async Task<ActionResult<IEnumerable<JobTaskDto>>> GetTasks(string jobNo)
        {
            var tasks = await _siteService.GetTasksByJobAsync(jobNo);
            return Ok(tasks);
        }

        [HttpPatch("update-progress")] // la méthode patch est utilisée pour les mises à jour partielles
        public async Task<IActionResult> UpdateProgress([FromBody] UpdateProgressRequest request) 
        {
            // on utilise success pour savoir si la mise à jour a réussi ou pas.
            var success = await _siteService.UpdateTaskProgressAsync(request.Id, request.Progress);
            if (success) return Ok(new { message = "Mise à jour réussie" });
            return BadRequest("Échec de la mise à jour");
        }
    }

    public class UpdateProgressRequest // c'est la classe qui génére le formulaire de données attendu dans le corps de la requête PATCH pour mettre à jour le progrès d'une tâche
    {
        public Guid Id { get; set; }
        public decimal Progress { get; set; }
    }
}