// src/app/models/tasks/models/job-task.model.ts

export interface JobTask {
  id: string;                    // correspond à JobTaskReadDto.Id
  jobNo: string;                 // correspond à JobTaskReadDto.JobNo
  taskNo: string;                // correspond à JobTaskReadDto.TaskNo
  description: string;           // correspond à JobTaskReadDto.Description
  dateFin?: string;              // correspond à JobTaskReadDto.DateFin
  progressPct: number;           // correspond à JobTaskReadDto.ProgressPct
  isBlocked?: boolean;           // Propriété additionnelle pour le blocage
  taskProgressPct?: number;      // Pour compatibilité (alias de progressPct)
  quantityShipped?: number;      // Pour compatibilité
  initialQuantity?: number;      // Pour compatibilité
  initialUoM?: string;           // Pour compatibilité
  initialAmount?: number;        // Pour compatibilité
  status?: string;               // Pour compatibilité
  dateDebut?: string;            // Pour compatibilité
}