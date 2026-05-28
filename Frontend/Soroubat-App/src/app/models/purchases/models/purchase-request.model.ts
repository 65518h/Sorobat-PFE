// src/app/models/purchases/models/purchase-request.model.ts

import { PurchaseRequestLine } from "./purchase-request-line.model";

//  Enums - Valeurs pour l'API Business Central
export enum PurchaseRequestStatus {
  OPEN = 'Ouvert',
  RELEASED = 'Released',
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

// ==================== MAPPING API ↔ AFFICHAGE ====================

export const StatusDisplayMap: Record<string, string> = {
  'Ouvert': 'Open',
  'Released': 'To Approve',
  'En cours': 'In Progress',
  'Partiellement Pris En Charge': 'Partially Processed',
  'Totallement Pris En Charge': 'Fully Processed',
  'Archiver': 'Archived'
};

export const StatusApiMap: Record<string, string> = {
  'Open': 'Ouvert',
  'To Approve': 'Released',
  'In Progress': 'En cours',
  'Partially Processed': 'Partiellement Pris En Charge',
  'Fully Processed': 'Totallement Pris En Charge',
  'Archived': 'Archiver'
};

//  Interface principale - ALIGNÉE AVEC LE BACKEND
export interface PurchaseRequest {
  id?: string;
  no?: string;
  jobNo: string;
  jobDescription?: string;
  requestType: string;
  engin?: string;
  descriptionEngin?: string;
  locationCode?: string;
  dateSaisie?: string | Date;        //  Date de saisie (remplace orderDate)
  statut?: string;                    //  Statut API
  observation?: string;
  purchaseRequestLines?: PurchaseRequestLine[];
}

//  Type pour la création
export type CreatePurchaseRequest = {
  jobNo: string;
  requestType: string;
  observation?: string;
  engin?: string;
  locationCode?: string;
};

//  Type pour la mise à jour
export type UpdatePurchaseRequest = Partial<Pick<PurchaseRequest,
  'requestType' | 'engin' | 'locationCode' | 'observation'
>>;

// ==================== FONCTIONS STATUT ====================

export function getStatusClass(status: string | undefined): string {
  if (!status) return 'status-open';
  
  const statusMap: Record<string, string> = {
    'Ouvert': 'status-open',
    'Released': 'status-to-approve',
    'En cours': 'status-progress',
    'Partiellement Pris En Charge': 'status-partial',
    'Totallement Pris En Charge': 'status-complete',
    'Archiver': 'status-archived'
  };
  return statusMap[status] || 'status-default';
}

export function getStatusLabel(status: string | undefined): string {
  if (!status) return 'Open';
  return StatusDisplayMap[status] || status;
}

export function getStatusIcon(status: string | undefined): string {
  if (!status) return 'help_outline';
  
  const iconMap: Record<string, string> = {
    'Ouvert': 'add_circle_outline',
    'Released': 'pending_actions',
    'En cours': 'pending',
    'approved': 'check_circle',
    'Partiellement Pris En Charge': 'pending',
    'Fully Supported': 'check_circle',
    'Archiver': 'archive',
    'Rejected': 'cancel'
  };
  return iconMap[status] || 'help_outline';
}

export function getStatusClassForBadge(status: string | undefined): string {
  if (!status) return 'unknown';
  
  switch (status) {
    case 'Ouvert':
    case 'Open':
      return 'open';
    case 'Released':
      return 'released';
    case 'approved':
    case 'Approved':
      return 'approved';
    case 'En cours':
      return 'in-progress';
    case 'Fully Supported':
    case 'Totallement Pris En Charge':
      return 'complete';
    case 'Partiellement Pris En Charge':
      return 'partial';
    case 'Rejected':
    case 'Refusé':
      return 'rejected';
    case 'Archiver':
      return 'archived';
    default:
      return 'unknown';
  }
}

export function getStatusLabelForBadge(status: string | undefined): string {
  if (!status) return 'Inconnu';
  
  switch (status) {
    case 'Ouvert':
      return 'Open';
    case 'Released':
      return 'To Approve';
    case 'approved':
      return 'Approved';
    case 'En cours':
      return 'In Progress';
    case 'Fully Supported':
    case 'Totallement Pris En Charge':
      return 'fully supported';
    case 'Partiellement Pris En Charge':
      return 'Partial';
    case 'Rejected':
    case 'Refusé':
      return 'Rejected';
    case 'Archiver':
      return 'Archived';
    default:
      return status;
  }
}

export function canSubmitToApprove(status: string | undefined): boolean {
  return status === 'Ouvert';
}

export function canApprove(status: string | undefined): boolean {
  return status === 'Released';
}

export function canEdit(status: string | undefined): boolean {
  return status === 'Ouvert';
}

export function canDelete(status: string | undefined, requesterId: string, currentUser: string): boolean {
  return status === 'Ouvert' && requesterId === currentUser;
}

export function uiStatusToApiStatus(uiStatus: string): string {
  return StatusApiMap[uiStatus] || uiStatus;
}

export function apiStatusToUiStatus(apiStatus: string): string {
  return StatusDisplayMap[apiStatus] || apiStatus;
}

// ==================== FONCTIONS DATES ====================

export function formatDateOnly(date: string | Date | null | undefined): string {
  if (!date) return '';
  const d = new Date(date);
  if (isNaN(d.getTime())) return '';
  return d.toISOString().split('T')[0];
}

export function isValidDate(date: string | Date | null | undefined): boolean {
  if (!date) return false;
  const d = new Date(date);
  return !isNaN(d.getTime()) && d.getFullYear() > 1900;
}

export function formatDate(date: string | Date | null | undefined): string {
  if (!date || !isValidDate(date)) return '—';
  const d = new Date(date);
  return d.toLocaleDateString('fr-FR', {
    day: '2-digit',
    month: '2-digit',
    year: 'numeric'
  });
}

export function formatDateTime(date: string | Date | null | undefined): string {
  if (!date || !isValidDate(date)) return '—';
  const d = new Date(date);
  return d.toLocaleDateString('fr-FR', {
    day: '2-digit',
    month: '2-digit',
    year: 'numeric'
  }) + ' à ' + d.toLocaleTimeString('fr-FR', { hour: '2-digit', minute: '2-digit' });
}

// ==================== FONCTIONS TYPE DE DEMANDE ====================

export function getRequestTypeLabel(type: string): string {
  const typeMap: Record<string, string> = {
    'Spare part': 'Pièce détachée',
    'Supply and Miscellaneous': 'Fournitures diverses',
    'Service Delivery': 'Prestation de service',
    'Materials': 'Matériaux'
  };
  return typeMap[type] || type || 'Non spécifié';
}

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

