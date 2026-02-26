using Microsoft.AspNetCore.Mvc;
using Soroubat.Api.Models;   // Pour trouver JobTaskDto
using Soroubat.Api.Services; // Pour trouver IJobTaskService

namespace Soroubat.Api.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class JobTasksController : ControllerBase
    {
        private readonly IJobTaskService _service;

        public JobTasksController(IJobTaskService service) 
        { 
            _service = service; 
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<JobTaskDto>>> GetTasks()
        {
            var tasks = await _service.GetAllTasksAsync();
            return Ok(tasks);
        }
    }
}