// src/app/modules/projects/models/project.model.ts

export interface Project {
  // --- IDENTIFIANT UNIQUE ---
  id: string;
  
  // --- IDENTIFIANTS MÉTIER ---
  no: string;
  description: string;
  
  // --- STATUT ---
  status: string;
  
  // --- RESPONSABLES ---
  personResponsible: string;
  projectManager: string;
  affectationMagasin: string;
  
  // --- DATES (de l'API) ---
  startingDate?: string;    // ← AJOUTER
  endingDate?: string;      // ← AJOUTER
  
  // --- CHAMPS CALCULÉS POUR L'AFFICHAGE ---
  taskCount?: number;
  progress?: number;
  createdAt?: string;
}