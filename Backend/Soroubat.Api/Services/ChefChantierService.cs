using System.Net.Http.Json;
using System.Text.Json;
using Soroubat.Api.Models;
using Soroubat.Api.Interfaces;

namespace Soroubat.Api.Services
{
    /// <summary>
    /// Interroge l'API Business Central pour retrouver le numéro de projet
    /// d'un chef de chantier à partir de son adresse e-mail.
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

        public async Task<string?> GetJobNoByEmailAsync(string email)
        {
            // Encodage de l'email pour éviter toute injection OData
            // (ex : un email contenant ' pourrait terminer le filtre prématurément)
            var encodedEmail = Uri.EscapeDataString(email);
            var url = $"chefsChantier?$filter=email eq '{encodedEmail}'";

            _logger.LogInformation("[ChefChantier] Recherche du projet pour : {Email}", email);

            var response = await _httpClient.GetAsync(url);

            if (!response.IsSuccessStatusCode)
            {
                _logger.LogWarning("[ChefChantier] BC a répondu {StatusCode} pour l'email {Email}",
                    (int)response.StatusCode, email);
                return null;
            }

            var result = await response.Content
                .ReadFromJsonAsync<BCResponse<ChefChantierReadDto>>();

            var chefChantier = result?.Value?.FirstOrDefault(); // FirstOrDefault retourne le premier élément ou null si la liste value est vide

            if (chefChantier == null)
            {
                _logger.LogWarning("[ChefChantier] Aucun chef de chantier trouvé pour {Email}", email);
                return null;
            }

            if (!chefChantier.Actif)
            {
                _logger.LogWarning("[ChefChantier] Compte inactif dans BC pour {Email}", email);
                return null;
            }

            _logger.LogInformation("[ChefChantier] Projet trouvé : {ProjectNo} pour {Email}",
                chefChantier.NumProjet, email);

            return string.IsNullOrWhiteSpace(chefChantier.NumProjet) ? null : chefChantier.NumProjet;
        }
    }
}