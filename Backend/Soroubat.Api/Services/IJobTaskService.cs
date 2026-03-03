using Soroubat.Api.Models;

namespace Soroubat.Api.Services
{
    public interface IJobTaskService
    {
        // Récupérer toutes les tâches
        Task<List<JobTaskDto>> GetAllTasksAsync();
        
        // Récupérer une tâche par son ID
        Task<JobTaskDto?> GetTaskByIdAsync(string id);
        
        // Récupérer les tâches d'un projet spécifique
        Task<List<JobTaskDto>> GetTasksByProjectIdAsync(string projectId);
        
        // Mettre à jour la progression d'une tâche
        Task<bool> UpdateTaskProgressAsync(string id, int progress);
        
        // Créer une nouvelle tâche
        Task<JobTaskDto> CreateTaskAsync(JobTaskDto task);
        
        // Mettre à jour une tâche complète
        Task<bool> UpdateTaskAsync(string id, JobTaskDto task);
        
        // Supprimer une tâche
        Task<bool> DeleteTaskAsync(string id);
    }
}