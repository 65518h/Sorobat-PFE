using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Soroubat.Api.Interfaces;
using Soroubat.Api.Models;

namespace Soroubat.Api.Controllers
{
    [Authorize]
    [ApiController]
    [Route("api/[controller]")]
    public class StockController : ControllerBase
    {
        private readonly IStockService _stockService;

        public StockController(IStockService stockService)
        {
            _stockService = stockService;
        }

        /// <summary>Numéro de projet extrait du claim JWT — null si le compte n'est pas assigné.</summary>
        private string? UserProjectNo => User.FindFirst("projectNo")?.Value;

        /// <summary>
        /// Retourne le stock agrégé de tous les articles du chantier du chef connecté,
        /// groupé par article et par emplacement, enrichi du nom complet du magasin.
        /// Le frontend peut filtrer ou grouper par locationCode / locationName librement.
        /// Une liste vide indique que le chantier n'a aucun article en stock.
        /// </summary>
        [HttpGet("my-stock")]
        [ProducesResponseType(typeof(IEnumerable<StockChantierReadDto>), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<ActionResult<IEnumerable<StockChantierReadDto>>> GetMyStock()
        {
            var projectNo = UserProjectNo;
            if (string.IsNullOrEmpty(projectNo))
                return BadRequest(new { message = "Aucun projet n'est assigné à votre compte." });

            try
            {
                var stock = await _stockService.GetStockByProjectAsync(projectNo);
                return Ok(stock);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = ex.Message });
            }
        }
    }
}