// src/app/modules/projects/models/project.model.ts

export interface Project {
  createdAt: any;
  // --- IDENTIFIANT UNIQUE (SystemId de Business Central) ---
  id: string;                    // ← NOUVEAU CHAMP - Identifiant unique GUID de Business Central
  
  // --- IDENTIFIANTS MÉTIER (Lecture seule) ---
  no: string;                    // N° du projet (code métier)
  description: string;           // Description
  
  // --- STATUT ---
  status: string;                // Statut (Open, En cours, Terminé, Suspendu)
  
  // --- RESPONSABLES ---
  personResponsible: string;     // Personne responsable
  projectManager: string;        // Chef de projet
  affectationMagasin: string;    // Affectation magasin
  
  // --- CHAMPS CALCULÉS POUR L'AFFICHAGE (optionnels) ---
  taskCount?: number;            // Nombre de tâches
  progress?: number;             // Avancement global en %
}

// Enum pour les statuts (optionnel)
export enum ProjectStatus {
  OPEN = 'Open',
  EN_COURS = 'En cours',
  TERMINE = 'Terminé',
  SUSPENDU = 'Suspendu',
  EN_ATTENTE = 'En attente'
}