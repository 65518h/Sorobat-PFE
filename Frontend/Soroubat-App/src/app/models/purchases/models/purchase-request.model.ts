

import { ApprovalHistory } from "./approval.model";
import { PurchaseRequestLine } from "./purchase-request-line.model";

export interface PurchaseRequest {
  // Identifiants
  id: string;                    // SystemId (GUID) - clé primaire API
  no: string;                    // N° Demande (PR-YYYY-XXXXX) - identifiant métier
  
  // Contexte Projet
  jobNo: string;                 // N° Projet/Chantier
  jobDescription?: string;       // Libellé Projet
  
  // Demandeur
  requesterId: string;           // Identifiant demandeur
  requesterName?: string;        // Nom du demandeur (pour affichage)
  
  // Classification
  requestType: RequestType;      // Type de demande
  service: ServiceType;          // Service demandeur
  
  // Équipement (optionnel)
  engin?: string;                // Code engin
  descriptionEngin?: string;     // Désignation engin
  
  // Dates
  orderDate: Date;               // Date création
  dueDate: Date;                 // Date échéance souhaitée
  postingDate?: Date;            // Date comptabilisation (BC)
  
  // Statut et Montant
  status: PurchaseRequestStatus; // Statut de la demande
  amount: number;                // Montant total (calculé)
  
  // Observation
  observation?: string;          // Observation générale
  
  // Relations (optionnelles)
  purchaseRequestLines?: PurchaseRequestLine[]; // Lignes de la demande
  approvalHistory?: ApprovalHistory[];           // Historique validations
}

// Énumérations
export enum RequestType {
  SPARE_PART = 'Spare part',                    // Pièce détachée
  MATERIALS = 'Materials',                       // Matériaux
  SUPPLY_MISCELLANEOUS = 'Supply and Miscellaneous', // Fournitures
  SERVICE_DELIVERY = 'Service Delivery'          // Prestation
}

export enum ServiceType {
  PARC_Z4 = 'Parc Z4',
  DIRECTION_GEN = 'Direction Gen',
  DIR_AUDIT = 'Dir Audit',
  DIR_CPT_ADMIN = 'Dir Cpt Et Admin',
  DIR_FINANCIERE = 'Dir Financiere',
  CONTROLE_GESTION = 'Controle Et Gestion',
  APPRO = 'Appro',
  SECRETERIAT = 'Secreteriat',
  BASE_VIE = 'BaseVie'
}

export enum PurchaseRequestStatus {
  OPEN = 'Ouvert',                              // En cours de saisie
  IN_PROGRESS = 'Lancé',                        // En cours de traitement
  PARTIALLY_PROCESSED = 'Partiellement Pris En Charge',
  FULLY_PROCESSED = 'Totallement Pris En Charge',
  ARCHIVED = 'Archiver'
}

// Fonctions utilitaires
export function getStatusClass(status: string): string {
  const statusMap: Record<string, string> = {
    'Ouvert': 'status-open',
    'Lancé': 'status-progress',
    'Partiellement Pris En Charge': 'status-partial',
    'Totallement Pris En Charge': 'status-complete',
    'Archiver': 'status-archived'
  };
  return statusMap[status] || '';
}

export function getStatusLabel(status: string): string {
  return status;
}

// Type pour la création (sans les champs calculés)
export type CreatePurchaseRequest = Omit<PurchaseRequest, 'id' | 'no' | 'amount' | 'status'> & {
  status?: PurchaseRequestStatus;
};

// Type pour la mise à jour partielle
export type UpdatePurchaseRequest = Partial<Pick<PurchaseRequest, 
  'jobNo' | 'requestType' | 'service' | 'engin' | 'orderDate' | 'dueDate' | 'observation' | 'status'
>>;