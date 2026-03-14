using Soroubat.Api.Interfaces;
using Microsoft.AspNetCore.Mvc;
using Soroubat.Api.Models;

namespace Soroubat.Api.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ProjectsController : ControllerBase
    {
        private readonly ISiteManagementService _siteService;

        public ProjectsController(ISiteManagementService service)
        {
            _siteService = service;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<JobDto>>> GetJobs()
        {
            var jobs = await _siteService.GetAllJobsAsync();
            return Ok(jobs);
        }

        [HttpGet("{jobNo}/tasks")]
        public async Task<ActionResult<IEnumerable<JobTaskDto>>> GetTasks(string jobNo)
        {
            var tasks = await _siteService.GetTasksByJobAsync(jobNo);
            return Ok(tasks);
        }

        [HttpPatch("update-progress")] // la méthode patch est utilisée pour les mises à jour partielles
        public async Task<IActionResult> UpdateProgress([FromBody] UpdateProgressRequest request) 
        // IactionResult est un type de retour plus générique qui permet de retourner différents types de réponses HTTP (Ok, BadRequest, NotFound, etc.) selon le résultat de l'opération
        {
            var success = await _siteService.UpdateTaskProgressAsync(request.JobNo, request.TaskNo, request.Progress);
            if (success) return Ok(new { message = "Mise à jour réussie" });
            return BadRequest("Échec de la mise à jour");
        }
    }

    public class UpdateProgressRequest // c'est la classe qui génére le formulaire de données attendu dans le corps de la requête PATCH pour mettre à jour le progrès d'une tâche
    {
        public string JobNo { get; set; } = string.Empty;
        public string TaskNo { get; set; } = string.Empty;
        public decimal Progress { get; set; }
    }
}