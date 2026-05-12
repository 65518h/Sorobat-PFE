using System.ComponentModel.DataAnnotations;

namespace Soroubat.Api.Models
{
    /// <summary>
    /// Corps de la requête PATCH pour mettre à jour l'avancement d'une tâche de projet.
    /// </summary>
    public class JobTaskProgressPatchDto
    {
        /// <summary>Pourcentage d'avancement (0 à 100).</summary>
        [Required]
        [Range(0, 100, ErrorMessage = "L'avancement doit être compris entre 0 et 100 %.")]
        public decimal Progress { get; set; }
    }
}