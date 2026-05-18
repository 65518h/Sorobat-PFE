using System.Text.Json;

namespace Soroubat.Api.Interfaces
{
    /// <summary>
    /// Contrat du service de lookup Business Central.
    /// Expose les données de référence (listes de valeurs) utilisées par le frontend
    /// pour alimenter les listes déroulantes des formulaires.
    /// Toutes les entités sont exposées via les Custom API Pages du groupe 'lookups'.
    /// </summary>
    public interface ILookupService
    {
        /// <summary>
        /// Retourne les données d'une entité de référence BC, filtrées par projet si applicable.
        /// </summary>
        /// <param name="entitySetName">
        /// Nom de l'entity set BC à interroger. Valeurs supportées :
        /// "projects"       — projets (filtrés sur le projet du chef connecté)          — page 50124
        /// "projectTasks"   — tâches projet (filtrées sur le projet du chef connecté)   — page 50125
        /// "locations"      — emplacements/magasins (pas de filtre projet)              — page 50126
        /// "items"          — articles (pas de filtre projet)                           — page 50133
        /// "vehicules"      — véhicules/engins (pas de filtre projet)                   — page 50134
        /// "requesters"     — demandeurs (pas de filtre projet)                         — page 50140
        /// "fixedAssets"    — immobilisations (pas de filtre projet)                    — page 50144
        /// "employees"      — salariés (pas de filtre projet)                           — page 50154
        /// "chefsChantier"  — chefs de chantier (pas de filtre projet)                  — page 50155
        /// "shippingAgents" — transporteurs/chauffeurs (pas de filtre projet)           — page 50181
        /// "postCodes"      — codes postaux/destinations (pas de filtre projet)         — page 50182
        /// </param>
        /// <param name="projectNo">Numéro de projet du chef connecté — utilisé pour filtrer projects et projectTasks.</param>
        /// <param name="additionalFilter">Filtre OData additionnel libre (ex : "status eq 'Open'").</param>
        Task<JsonElement> GetLookupDataAsync(
            string entitySetName,
            string projectNo,
            string? additionalFilter = null);
    }
}