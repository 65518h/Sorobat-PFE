export interface JobTask {
  jobNo: string;
  taskNo: string;
  description: string;
  dateDebut?: string;
  dateFin?: string;
  progressPct: number;
  taskProgressPct: number;
  quantityShipped: number;
  isBlocked: boolean;
}
