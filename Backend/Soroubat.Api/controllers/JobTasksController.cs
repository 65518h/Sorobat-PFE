using Microsoft.AspNetCore.Mvc;
using Soroubat.Api.Models;
using Soroubat.Api.Services;

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

        // GET: api/jobtasks
        [HttpGet]
        public async Task<ActionResult<IEnumerable<JobTaskDto>>> GetTasks()
        {
            var tasks = await _service.GetAllTasksAsync();
            return Ok(tasks);
        }

        // GET: api/jobtasks/{id}
        [HttpGet("{id}")]
        public async Task<ActionResult<JobTaskDto>> GetTask(string id)
        {
            var task = await _service.GetTaskByIdAsync(id);
            if (task == null)
            {
                return NotFound();
            }
            return Ok(task);
        }

        // GET: api/jobtasks/project/{projectId}
        [HttpGet("project/{projectId}")]
        public async Task<ActionResult<IEnumerable<JobTaskDto>>> GetTasksByProject(string projectId)
        {
            var tasks = await _service.GetTasksByProjectIdAsync(projectId);
            return Ok(tasks);
        }

        // PATCH: api/jobtasks/{id}/progress
        [HttpPatch("{id}/progress")]
        public async Task<IActionResult> UpdateTaskProgress(string id, [FromBody] int progress)
        {
            var result = await _service.UpdateTaskProgressAsync(id, progress);
            if (!result)
            {
                return NotFound();
            }
            return Ok(new { message = "Progression mise à jour avec succès" });
        }

        // POST: api/jobtasks
        [HttpPost]
        public async Task<ActionResult<JobTaskDto>> CreateTask([FromBody] JobTaskDto task)
        {
            var createdTask = await _service.CreateTaskAsync(task);
            return CreatedAtAction(nameof(GetTask), new { id = createdTask.TaskNo }, createdTask);
        }

        // PUT: api/jobtasks/{id}
        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateTask(string id, [FromBody] JobTaskDto task)
        {
            if (id != task.TaskNo)
            {
                return BadRequest();
            }

            var result = await _service.UpdateTaskAsync(id, task);
            if (!result)
            {
                return NotFound();
            }
            return NoContent();
        }

        // DELETE: api/jobtasks/{id}
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteTask(string id)
        {
            var result = await _service.DeleteTaskAsync(id);
            if (!result)
            {
                return NotFound();
            }
            return NoContent();
        }
    }
}