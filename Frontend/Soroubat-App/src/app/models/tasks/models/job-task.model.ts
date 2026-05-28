// src/app/modules/tasks/models/job-task.model.ts

export interface JobTask {
  // IDENTIFIANT UNIQUE
  id: string;
  
  // IDENTIFIANTS MÉTIER
  jobNo: string;
  taskNo: string;
  description: string;
  
 
  
  // AVANCEMENT
  progressPct: number;      // Avancement saisi par le chef de chantier (0-100)
  
  // STATUT (calculé côté frontend)
  isBlocked?: boolean;      // Indique si la tâche est bloquée
  
  // CHAMPS CALCULÉS POUR L'AFFICHAGE (dérivés)
  status?: string;          // 'Terminé', 'En cours', 'En attente', 'Bloqué', 'En retard'
}