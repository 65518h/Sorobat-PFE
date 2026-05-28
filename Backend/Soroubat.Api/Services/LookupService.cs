using System.Net.Http.Json;
using System.Text.Json;
using Soroubat.Api.Interfaces;

namespace Soroubat.Api.Services
{
    /// <summary>
    /// Interagit avec les Custom API Pages BC du groupe 'lookups'
    /// (APIGroup = 'lookups', APIVersion = 'v1.0', APIPublisher = 'soroubat').
    /// Fournit les données de référence (projets, tâches, articles, emplacements, véhicules,
    /// chauffeurs, destinations…) utilisées par le frontend pour alimenter les listes déroulantes.
    /// </summary>
    public class LookupService : BaseService, ILookupService
    {
        private readonly HttpClient _httpClient;
        private readonly ILogger<LookupService> _logger;

        /// <summary>
        /// Liste des entity sets autorisés — protège contre les injections OData via l'URL.
        /// Chaque valeur correspond à l'EntitySetName d'une Custom API Page du groupe 'lookups'.
        /// </summary>
        private static readonly HashSet<string> AllowedEntitySets = new(StringComparer.OrdinalIgnoreCase)
        {
            "projects",       // page 50124 
            "projectTasks",   // page 50125 
            "locations",      // page 50126 
            "items",          // page 50133 
            "vehicules",      // page 50134 
            "requesters",     // page 50140 
            "fixedAssets",    // page 50144 
            "employees",      // page 50154 
            "chefsChantier",  // page 50155 
            "shippingAgents", // page 50181 
            "postCodes",      // page 50182 
        };

        public LookupService(HttpClient httpClient, ILogger<LookupService> logger)
        {
            _httpClient = httpClient;
            _logger     = logger;
        }

        public async Task<JsonElement> GetLookupDataAsync(
            string entitySetName,
            string projectNo,
            string? additionalFilter = null)
        {
            if (!AllowedEntitySets.Contains(entitySetName))
                throw new ArgumentException(
                    $"Entité de lookup inconnue : '{entitySetName}'. " +
                    $"Valeurs autorisées : {string.Join(", ", AllowedEntitySets)}.");


            string? projectFilter = entitySetName switch
            {
                "projects"     => $"code eq '{projectNo}'",
                "projectTasks" => $"projectNo eq '{projectNo}'",
                _              => null
            };

            var filters = new List<string>();

            if (!string.IsNullOrEmpty(projectFilter))
                filters.Add(projectFilter);

            if (!string.IsNullOrEmpty(additionalFilter))
                filters.Add(additionalFilter);

            var requestUri = entitySetName;
            if (filters.Count > 0)
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