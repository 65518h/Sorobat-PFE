using Microsoft.AspNetCore.Mvc;
using System.Text.Json;
using Soroubat.Api.Interfaces;
using Soroubat.Api.Models;

namespace Soroubat.Api.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class PurchaseRequestController : ControllerBase
    {
        private readonly IPurchaseRequestService _service;

        public PurchaseRequestController(IPurchaseRequestService service)
        {
            _service = service;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<PurchaseRequest>>> GetAll()
        {
            var requests = await _service.GetAllRequestsAsync();
            return Ok(requests);
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<PurchaseRequest>> GetById(Guid id)
        {
            var request = await _service.GetRequestByIdAsync(id);
            if (request == null) return NotFound();
            return Ok(request);
        }

        [HttpPost]
        public async Task<ActionResult<PurchaseRequest>> Create([FromBody] PurchaseRequest request)
        {
            try 
            {
                var result = await _service.CreateFullRequestAsync(request);
                return CreatedAtAction(nameof(GetById), new { id = result.Id }, result);
            } 
            catch (Exception ex) 
            {
                return BadRequest(new { message = ex.Message });
            }
        }

        [HttpPatch("{id}")]
        public async Task<IActionResult> PatchHeader(Guid id, [FromBody] JsonElement body)
        {
            try 
            {
                var success = await _service.UpdateHeaderAsync(id, body);
                if (success) return NoContent();
                return BadRequest("Échec de la mise à jour de l'en-tête");
            } 
            catch (Exception ex) 
            {
                return BadRequest(new { message = ex.Message });
            }
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteHeader(Guid id)
        {
            var success = await _service.DeleteRequestAsync(id);
            if (success) return NoContent();
            return BadRequest("Impossible de supprimer la demande");
        }

        // --- ACTIONS SUR LES LIGNES ---

        [HttpPatch("lines/{id}")]
        public async Task<IActionResult> PatchLine(Guid id, [FromBody] JsonElement body)
        {
            try 
            {
                var success = await _service.UpdateLineAsync(id, body);
                if (success) return NoContent();
                return BadRequest("Échec de la mise à jour de la ligne");
            } 
            catch (Exception ex) 
            {
                return BadRequest(new { message = ex.Message });
            }
        }

        [HttpDelete("lines/{id}")]
        public async Task<IActionResult> DeleteLine(Guid id)
        {
            var success = await _service.DeleteLineAsync(id);
            if (success) return NoContent();
            return BadRequest("Impossible de supprimer la ligne.");
        }
    }
}