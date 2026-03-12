using Soroubat.Api.Models;

namespace Soroubat.Api.Interfaces
{
    public interface ISiteManagementService 
    { 
        // récupère tous les chantiers
        // Task indique que la méthode est asynchrone et retourne une liste de JobDto encapsulée dans une tâche
        Task<List<JobDto>> GetAllJobsAsync(); 

        // récupère les tâches d'un chantier spécifique
        Task<List<JobTaskDto>> GetTasksByJobAsync(string jobNo); 

        // met à jour le progrès d'une tâche spécifique
        Task<bool> UpdateTaskProgressAsync(string jobNo, string taskNo, decimal progress); 
    }
}