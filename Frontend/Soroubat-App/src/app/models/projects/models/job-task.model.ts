// src/app/models/tasks/models/job-task.model.ts

export interface JobTask {
  id: string;
  jobNo: string;
  taskNo: string;
  description: string;
  dateDebut?: string;
  dateFin?: string;
  progressPct: number;
  taskProgressPct: number;
  quantityShipped: number;
  initialQuantity: number;
  initialUoM: string;
  initialAmount: number;
  isBlocked: boolean;
  status: string;  // ✅ Rendu obligatoire
}