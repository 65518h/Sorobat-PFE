using Soroubat.Api.Models;

namespace Soroubat.Api.Interfaces
{
    /// <summary>
    /// Contrat du service de gestion des chantiers (Jobs et Job Tasks Business Central).
    /// </summary>
    public interface ISiteManagementService
    {
        /// <summary>
        /// Retourne le projet (Job) assigné au chef de chantier connecté.
        /// Lève une exception si le projet est introuvable dans BC.
        /// </summary>
        Task<JobReadDto> GetAssignedJobAsync(string projectNo);

        /// <summary>
        /// Retourne la liste des tâches du projet du chef de chantier connecté.
        /// </summary>
        Task<List<JobTaskReadDto>> GetMyTasksAsync(string projectNo);

        /// <summary>
        /// Met à jour le pourcentage d'avancement d'une tâche après vérification
        /// que la tâche appartient bien au projet du chef connecté.
        /// Lève <see cref="UnauthorizedAccessException"/> si le projet ne correspond pas.
        /// Lève <see cref="KeyNotFoundException"/> si la tâche est introuvable.
        /// </summary>
        Task<bool> UpdateTaskProgressAsync(Guid taskId, decimal progress, string authorizedProjectNo);
    }
}