// models/task.model.ts
export interface JobTask {
  id: string;                    // ← Rendre obligatoire (enlever ?)
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