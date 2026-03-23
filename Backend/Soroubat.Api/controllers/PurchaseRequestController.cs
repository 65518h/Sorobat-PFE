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
        public async Task<ActionResult<IEnumerable<PurchaseRequestDto>>> GetAll()
        {
            try 
            {
                var requests = await _service.GetAllRequestsAsync();
                return Ok(requests);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = ex.Message });
            }
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<PurchaseRequestDto>> GetById(Guid id)
        {
            try 
            {
                var request = await _service.GetRequestByIdAsync(id);
                if (request == null) return NotFound();
                return Ok(request);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = ex.Message });
            }
        }

        [HttpPost]
        public async Task<ActionResult<PurchaseRequestDto>> Create([FromBody] PurchaseRequestDto request)
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
        // en utilisant JsonElement , angular sera chargé de construire le corps de la requête de mise à jour partielle en format JSON et de l'envoyer tel quel au backend, qui pourra ensuite le traiter dynamiquement sans avoir besoin d'une classe spécifique pour chaque type de mise à jour.
        // L'attribut [FromBody] dit à .NET : "Va chercher le texte dans le corps de la requête et essaie de le faire entrer dans le paramètre que j'ai défini (le JsonElement ou le Dto spécifique)". 
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
            try 
            {
                var success = await _service.DeleteRequestAsync(id);
                if (success) return NoContent();
                return BadRequest("Impossible de supprimer la demande");
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
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
            try 
            {
                var success = await _service.DeleteLineAsync(id);
                if (success) return NoContent();
                return BadRequest("Impossible de supprimer la ligne.");
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }
    }
}