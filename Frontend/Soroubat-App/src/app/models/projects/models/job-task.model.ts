// src/app/models/job-task.model.ts
export interface JobTask {
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
}