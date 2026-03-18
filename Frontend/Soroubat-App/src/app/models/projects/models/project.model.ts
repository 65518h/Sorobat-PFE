// src/app/modules/projects/models/project.model.ts

export interface Project {
  // Champs du backend (JobDto)
  no: string;                    // N° du projet
  description: string;           // Description
  status: string;                // Statut
  personResponsible: string;     // Personne responsable
  projectManager: string;        // Chef de projet
  affectationMagasin: string;    // Affectation magasin
  
  // Champs calculés pour l'affichage (optionnels)
  taskCount?: number;            // Nombre de tâches
  progress?: number;             // Avancement global en %
}

// Enum pour les statuts (optionnel)
export enum ProjectStatus {
  EN_COURS = 'En cours',
  TERMINE = 'Terminé',
  SUSPENDU = 'Suspendu',
  EN_ATTENTE = 'En attente'
}