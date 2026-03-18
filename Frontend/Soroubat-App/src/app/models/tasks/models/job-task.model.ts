// src/app/models/job-task.model.ts
export interface JobTask {
  // --- IDENTIFIANTS (Lecture seule pour protéger l'intégrité) ---
  jobNo: string;
  taskNo: string;
  description: string;

  //// --- SAISIE AVANCEMENT (Modifiables par le chef de chantier) ---
        // Cruciaux pour le suivi temporel sur le site Web

  dateDebut?: string;
  dateFin?: string;

  // Pourcentages d'avancement saisis par les chefs de chantier
  progressPct: number;

  //// un champ d'avacement théorique calculé en fonction de la quantité réalisée vs la quantité initiale, pour comparer avec le progressPct saisi manuellement
                
  taskProgressPct: number;

  // --- DONNÉES DE VENTE (Lecture seule pour consultation uniquement) ---
    // Utile pour comparer le réalisé par rapport à l'objectif de vente

  quantityShipped: number; // quantité consommée ou réalisée
  initialQuantity: number; //quantité initiale prévue pour la tâche
  initialUoM: string; // Unité de mesure initiale (ex: m3, tonnes, heures)
  initialAmount: number; // Montant initial prévu pour la tâche
  isBlocked: boolean; // Indique si la tâche est bloquée (ex: en attente de validation, problème sur le chantier, etc.)
}