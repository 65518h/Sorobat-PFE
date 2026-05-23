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
            "projects",       // page 50124 — ProjectLookupAPI
            "projectTasks",   // page 50125 — ProjectTaskLookupAPI
            "locations",      // page 50126 — LocationLookupAPI
            "items",          // page 50133 — ItemLookupAPI
            "vehicules",      // page 50134 — VehiculeLookupAPI
            "requesters",     // page 50140 — RequesterLookupAPI
            "fixedAssets",    // page 50144 — FixedAssetLookupAPI
            "employees",      // page 50154 — EmployeeLookupAPI
            "chefsChantier",  // page 50155 — ChefChantierLookup
            "shippingAgents", // page 50181 — ShippingAgentAPI  (chauffeurs pour lignes gasoil)
            "postCodes",      // page 50182 — PostCodeAPI       (destinations pour lignes gasoil)
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

            // Filtre automatique par projet pour les entités qui y sont liées.
            // Toutes les autres entités sont globales — pas de filtre projet appliqué.
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