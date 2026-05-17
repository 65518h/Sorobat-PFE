// src/app/models/purchases/models/purchase-request.model.ts

import { PurchaseRequestLine } from "./purchase-request-line.model";

// ✅ Enums - Valeurs pour l'API Business Central
export enum PurchaseRequestStatus {
  OPEN = 'Ouvert',
  RELEASED = 'Released',              // ✅ L'API retourne "Released"
  IN_PROGRESS = 'En cours',
  PARTIAL = 'Partiellement Pris En Charge',
  COMPLETED = 'Totallement Pris En Charge',
  ARCHIVED = 'Archiver'
}

export enum RequestType {
  SPARE_PART = 'Spare part',
  SUPPLY_MISCELLANEOUS = 'Supply and Miscellaneous',
  SERVICE_DELIVERY = 'Service Delivery',
  MATERIALS = 'Materials'
}

export enum ServiceType {
  MAINTENANCE = 'Maintenance',
  PRODUCTION = 'Production',
  LOGISTIQUE = 'Logistique',
  ADMINISTRATION = 'Administration'
}

// ==================== MAPPING API ↔ AFFICHAGE ====================

/**
 * Mapping des statuts API vers l'affichage UI
 */
export const StatusDisplayMap: Record<string, string> = {
  'Ouvert': 'Open',
  'Released': 'To Approve',           // ✅ API "Released" → UI "To Approve"
  'En cours': 'In Progress',
  'Partiellement Pris En Charge': 'Partially Processed',
  'Totallement Pris En Charge': 'Fully Processed',
  'Archiver': 'Archived'
};

/**
 * Mapping des statuts UI vers l'API
 */
export const StatusApiMap: Record<string, string> = {
  'Open': 'Ouvert',
  'To Approve': 'Released',            // ✅ UI "To Approve" → API "Released"
  'In Progress': 'En cours',
  'Partially Processed': 'Partiellement Pris En Charge',
  'Fully Processed': 'Totallement Pris En Charge',
  'Archived': 'Archiver'
};

// ✅ Interface principale
export interface PurchaseRequest {
  id?: string;
  no?: string;
  jobNo: string;
  jobDescription?: string;
  requesterId: string;
  requestType: string;
  engin?: string;
  descriptionEngin?: string;
  locationCode?: string; 
  orderDate?: string | Date;
  dueDate?: string | Date;
  postingDate?: string | Date;
  status?: string;                   // Stocke la valeur API (ex: "Released")
  amount?: number;
  service?: string;
  observation?: string;
  purchaseRequestLines?: PurchaseRequestLine[];
}

// ✅ Type pour la création
export type CreatePurchaseRequest = {
  status: string;
  jobNo: string;
  requesterId: string;
  requestType: string;
  jobDescription?: string;
  engin?: string;
  locationCode?: string; 
  orderDate?: string | Date;
  dueDate?: string | Date;
  service?: string;
  observation?: string;
  purchaseRequestLines?: PurchaseRequestLine[];
};

// ✅ Type pour la mise à jour
export type UpdatePurchaseRequest = Partial<Pick<PurchaseRequest,
  'jobNo' | 'requestType' | 'service' | 'engin' | 'locationCode' | 'orderDate' | 'dueDate' | 'status' | 'observation'
>>;

// ==================== FONCTIONS STATUT ====================

/**
 * Retourne la classe CSS pour un statut donné (valeur API)
 */
export function getStatusClass(status: string | undefined): string {
  if (!status) return 'status-open';
  
  const statusMap: Record<string, string> = {
    'Open': 'status-open',
    'Released': 'status-to-approve',     // ✅ "Released" → classe "to-approve"
    'En cours': 'status-progress',
    'Partiellement Pris En Charge': 'status-partial',
    'Totallement Pris En Charge': 'status-complete',
    'Archiver': 'status-archived'
  };
  return statusMap[status] || 'status-default';
}

/**
 * Retourne le libellé affichable d'un statut (convertit la valeur API en texte UI)
 */
export function getStatusLabel(status: string | undefined): string {
  if (!status) return 'Open';
  return StatusDisplayMap[status] || status;
}

/**
 * Retourne l'icône Material pour un statut (valeur API)
 */
// purchase-request.model.ts - Modifier la fonction getStatusIcon

export function getStatusIcon(status: string | undefined): string {
  if (!status) return 'help_outline';
  
  const iconMap: Record<string, string> = {
    'Ouvert': 'add_circle_outline',        // ✅ Icône plus visible pour Ouvert
    'Open': 'add_circle_outline',          // ✅ Icône plus visible pour Open
    'Released': 'pending_actions',
    'En cours': 'pending',
    'Partiellement Pris En Charge': 'pending',
    'Totallement Pris En Charge': 'check_circle',
    'Archiver': 'archive'
  };
  return iconMap[status] || 'help_outline';
}

/**
 * Retourne la classe CSS pour le badge dans la liste (valeur API)
 */
export function getStatusClassForBadge(status: string | undefined): string {
  if (!status) return 'open';
  switch (status) {
    case 'Ouvert':
      return 'open';
    case 'Released':                      // ✅ "Released" → classe "to-approve"
      return 'to-approve';
    case 'En cours':
      return 'in-progress';
    case 'Partiellement Pris En Charge':
      return 'partial';
    case 'Totallement Pris En Charge':
      return 'complete';
    case 'Archiver':
      return 'archived';
    default:
      return 'open';
  }
}

/**
 * Retourne le libellé pour le badge dans la liste (convertit la valeur API)
 */
export function getStatusLabelForBadge(status: string | undefined): string {
  if (!status) return 'Inconnu';
  switch (status) {
    case 'Ouvert':
      return 'Open';
    case 'Released':                      // ✅ "Released" → affiche "To Approve"
      return 'To Approve';
    case 'En cours':
      return 'In Progress';
    case 'Partiellement Pris En Charge':
      return 'Pending';
    case 'Totallement Pris En Charge':
      return 'Completed';
    case 'Archiver':
      return 'Archived';
    default:
      return status;
  }
}

/**
 * Vérifie si une demande peut être soumise à approbation
 * (statut actuel = "Ouvert")
 */
export function canSubmitToApprove(status: string | undefined): boolean {
  return status === 'Open' || status === 'Ouvert';
}

/**
 * Vérifie si une demande peut être approuvée
 * (statut actuel = "Released")
 */
export function canApprove(status: string | undefined): boolean {
  return status === 'Released';
}

/**
 * Vérifie si une demande peut être modifiée
 * (statut actuel = "Ouvert")
 */
export function canEdit(status: string | undefined): boolean {
  return status === 'Ouvert' || status === 'Open';
}

/**
 * Vérifie si une demande peut être supprimée
 */
export function canDelete(status: string | undefined, requesterId: string, currentUser: string): boolean {
  return status === 'Ouvert' && requesterId === currentUser;
}

/**
 * Convertit un statut UI en valeur API
 * @param uiStatus - Statut affiché dans l'interface (ex: "To Approve")
 * @returns Valeur API correspondante (ex: "Released")
 */
export function uiStatusToApiStatus(uiStatus: string): string {
  return StatusApiMap[uiStatus] || uiStatus;
}

/**
 * Convertit une valeur API en statut UI
 * @param apiStatus - Statut reçu de l'API (ex: "Released")
 * @returns Statut affichable dans l'interface (ex: "To Approve")
 */
export function apiStatusToUiStatus(apiStatus: string): string {
  return StatusDisplayMap[apiStatus] || apiStatus;
}

// ==================== FONCTIONS DATES ====================

/**
 * Formate une date au format YYYY-MM-DD pour l'API
 */
export function formatDateOnly(date: string | Date | null | undefined): string {
  if (!date) return '';
  const d = new Date(date);
  if (isNaN(d.getTime())) return '';
  return d.toISOString().split('T')[0];
}

/**
 * Vérifie si une date est valide
 */
export function isValidDate(date: string | Date | null | undefined): boolean {
  if (!date) return false;
  const d = new Date(date);
  return !isNaN(d.getTime()) && d.getFullYear() > 1900;
}

/**
 * Vérifie si une date d'échéance est dépassée
 */
export function isOverdue(dueDate: string | Date | null | undefined): boolean {
  if (!dueDate || !isValidDate(dueDate)) return false;
  const today = new Date();
  today.setHours(0, 0, 0, 0);
  const due = new Date(dueDate);
  due.setHours(0, 0, 0, 0);
  return due < today;
}

/**
 * Formate une date au format français (DD/MM/YYYY)
 */
export function formatDate(date: string | Date | null | undefined): string {
  if (!date || !isValidDate(date)) return '';
  const d = new Date(date);
  return d.toLocaleDateString('fr-FR', {
    day: '2-digit',
    month: '2-digit',
    year: 'numeric'
  });
}

/**
 * Formate une date et heure au format français
 */
export function formatDateTime(date: string | Date | null | undefined): string {
  if (!date || !isValidDate(date)) return '';
  const d = new Date(date);
  return d.toLocaleDateString('fr-FR', {
    day: '2-digit',
    month: '2-digit',
    year: 'numeric',
    hour: '2-digit',
    minute: '2-digit'
  });
}

// ==================== FONCTIONS TYPE DE DEMANDE ====================

/**
 * Retourne le libellé affichable d'un type de demande
 */
export function getRequestTypeLabel(type: string): string {
  const typeMap: Record<string, string> = {
    'Spare part': 'Pièce détachée',
    'Supply and Miscellaneous': 'Fournitures diverses',
    'Service Delivery': 'Prestation de service',
    'Materials': 'Matériaux'
  };
  return typeMap[type] || type || 'Non spécifié';
}

/**
 * Retourne l'icône Material pour un type de demande
 */
export function getRequestTypeIcon(type: string): string {
  const iconMap: Record<string, string> = {
    'Spare part': 'build',
    'Supply and Miscellaneous': 'shopping_cart',
    'Service Delivery': 'handyman',
    'Materials': 'inventory_2'
  };
  return iconMap[type] || 'category';
}

// ==================== FONCTIONS MONTANT ====================

/**
 * Formate un montant en FCFA
 */
export function formatAmount(amount: number): string {
  if (amount === null || amount === undefined) return '0 FCFA';
  return new Intl.NumberFormat('fr-FR', { 
    minimumFractionDigits: 0, 
    maximumFractionDigits: 0 
  }).format(amount) + ' FCFA';
}