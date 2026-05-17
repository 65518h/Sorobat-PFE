using System.Net.Http.Json;
using Soroubat.Api.Models;
using Soroubat.Api.Interfaces;

namespace Soroubat.Api.Services
{
    /// <summary>
    /// Interroge l'API Business Central pour vérifier le statut d'un chef de chantier
    /// et récupérer son numéro de projet en un seul appel.
    /// </summary>
    public class ChefChantierService : IChefChantierService
    {
        private readonly HttpClient _httpClient;
        private readonly ILogger<ChefChantierService> _logger;

        public ChefChantierService(HttpClient httpClient, ILogger<ChefChantierService> logger)
        {
            _httpClient = httpClient;
            _logger = logger;
        }

        public async Task<ChefChantierCheckResult> CheckChefAsync(string email)
        {
            var encodedEmail = Uri.EscapeDataString(email);
            var url = $"chefsChantier?$filter=email eq '{encodedEmail}'";

            _logger.LogInformation("[ChefChantier] Vérification BC pour : {Email}", email);

            var response = await _httpClient.GetAsync(url);

            if (!response.IsSuccessStatusCode)
            {
                _logger.LogWarning("[ChefChantier] BC a répondu {StatusCode} pour {Email}",
                    (int)response.StatusCode, email);
                return ChefChantierCheckResult.Fail(ChefChantierStatus.NotFound);
            }

            var result = await response.Content
                .ReadFromJsonAsync<BCResponse<ChefChantierReadDto>>();

            var chef = result?.Value?.FirstOrDefault();

            if (chef == null)
            {
                _logger.LogWarning("[ChefChantier] Aucun chef de chantier trouvé pour {Email}", email);
                return ChefChantierCheckResult.Fail(ChefChantierStatus.NotFound);
            }

            if (!chef.Actif)
            {
                _logger.LogWarning("[ChefChantier] Compte inactif dans BC pour {Email}", email);
                return ChefChantierCheckResult.Fail(ChefChantierStatus.Inactive);
            }

            if (string.IsNullOrWhiteSpace(chef.NumProjet))
            {
                _logger.LogWarning("[ChefChantier] Aucun projet assigné dans BC pour {Email}", email);
                return ChefChantierCheckResult.Fail(ChefChantierStatus.NoProject);
            }

            _logger.LogInformation("[ChefChantier] Vérification réussie pour {Email} — Projet : {ProjectNo}",
                email, chef.NumProjet);

            return ChefChantierCheckResult.Active(chef.NumProjet);
        }
    }
}