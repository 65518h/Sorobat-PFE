// modules/projects/models/project.model.ts
export interface Task {
  id: string;                     // ← Obligatoire
  jobNo: string;
  taskNo: string;
  description: string;
  responsible?: string;
  dateDebut?: Date;
  dateFin?: Date;
  progressPct: number;
  isBlocked: boolean;
  status?: string;
}

export interface Project {
  id: string;
  number: string;
  name: string;
  description: string;
  customerName: string;
  responsible: string;
  startDate: Date;
  endDate: Date;
  progress: number;
  status: 'En cours' | 'Terminé' | 'Suspendu' | 'Annulé';
  taskCount?: number;
}