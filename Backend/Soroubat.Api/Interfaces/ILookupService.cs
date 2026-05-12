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
        /// "projects"     — projets (filtrés sur le projet du chef connecté)
        /// "projectTasks" — tâches projet (filtrées sur le projet du chef connecté)
        /// "locations"    — emplacements/magasins (pas de filtre projet)
        /// "items"        — articles (pas de filtre projet)
        /// "vehicules"    — véhicules/engins (pas de filtre projet)
        /// "requesters"   — demandeurs (pas de filtre projet)
        /// "fixedAssets"  — immobilisations (pas de filtre projet)
        /// "employees"    — salariés (pas de filtre projet — utiliser EmployeeService pour un filtre par chantier)
        /// </param>
        /// <param name="projectNo">Numéro de projet du chef connecté — utilisé pour filtrer projects et projectTasks.</param>
        /// <param name="additionalFilter">Filtre OData additionnel libre (ex : "status eq 'Open'").</param>
        Task<JsonElement> GetLookupDataAsync(
            string entitySetName,
            string projectNo,
            string? additionalFilter = null);
    }
}