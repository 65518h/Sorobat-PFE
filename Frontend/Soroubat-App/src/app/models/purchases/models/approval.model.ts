// src/app/models/purchases/models/approval.model.ts

export interface ApprovalHistory {
  id: string;
  documentNo: string;
  approverId: string;
  approverName: string;
  approvalDate: Date;
  decision: string;  //  Changer en string au lieu de l'énumération
  comment?: string;
  level: number;
}

// Garder l'énumération pour référence et constantes
export enum ApprovalDecision {
  APPROVED = 'Approuvé',
  REFUSED = 'Refusé',
  PENDING = 'En attente'
}

export enum LineStatus {
  PENDING = 'En attente',
  APPROVED = 'Approuvé',
  REFUSED = 'Refusé',
  TRANSFERRED = 'Transféré'
}

export interface ApprovalRequest {
  documentNo: string;
  decision: string;
  comment?: string;
  lineId?: string;
}