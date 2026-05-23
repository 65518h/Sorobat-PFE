// src/app/modules/projects/models/project.model.ts

export interface Project {
  // IDENTIFIANT UNIQUE
  id: string;
  
  // IDENTIFIANTS MÉTIER (conformes au backend JobReadDto)
  no: string;                    // correspond à JobReadDto.No
  description: string;           // correspond à JobReadDto.Description
  
  // STATUT
  status: string;                // correspond à JobReadDto.Status
  
  // MAGASIN
  affectationMagasin: string;    // correspond à JobReadDto.AffectationMagasin
  
  // DATES (conformes au backend)
  startingDate?: string;         // correspond à JobReadDto.StartingDate
  endingDate?: string;           // correspond à JobReadDto.EndingDate
  
  // CHAMPS CALCULÉS POUR L'AFFICHAGE (dérivés des tâches)
  taskCount?: number;
  progress?: number;
}