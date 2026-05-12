using System.Net.Http.Json;
using System.Text.Json;
using Soroubat.Api.Interfaces;

namespace Soroubat.Api.Services
{
    /// <summary>
    /// Interagit avec les Custom API Pages BC du groupe 'lookups'
    /// (APIGroup = 'lookups', APIVersion = 'v1.0', APIPublisher = 'soroubat').
    /// Fournit les données de référence (projets, tâches, articles, emplacements, véhicules…)
    /// utilisées par le frontend pour alimenter les listes déroulantes.
    /// </summary>
    public class LookupService : BaseService, ILookupService
    {
        private readonly HttpClient _httpClient;
        private readonly ILogger<LookupService> _logger;

        public LookupService(HttpClient httpClient, ILogger<LookupService> logger)
        {
            _httpClient = httpClient;
            _logger = logger;
        }

        public async Task<JsonElement> GetLookupDataAsync(
            string entitySetName,
            string projectNo,
            string? additionalFilter = null)
        {
            // Filtre automatique par projet pour les entités qui y sont liées.
            // Les autres entités (items, locations, vehicules…) sont globales — pas de filtre projet.
            string? projectFilter = entitySetName switch
            {
                "projects"     => $"code eq '{projectNo}'",
                "projectTasks" => $"projectNo eq '{projectNo}'",
                _              => null
            };

            var filters = new[] { projectFilter, additionalFilter }
                .Where(f => !string.IsNullOrEmpty(f))
                .ToList();

            var requestUri = entitySetName;
            if (filters.Any())
                requestUri += $"?$filter={string.Join(" and ", filters)}";

            _logger.LogInformation("[Lookup] GetLookupData — EntitySet: {EntitySet}, URL: {Url}",
                entitySetName, requestUri);

            var response = await _httpClient.GetAsync(requestUri);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            return await response.Content.ReadFromJsonAsync<JsonElement>();
        }
    }
}