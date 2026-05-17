// src/app/models/alerts/models/alert.model.ts

export interface Alert {
  id: string;
  type: string;
  severity: 'Critical' | 'Warning' | 'Info';
  title: string;
  message: string;
  relatedEntityNo: string;
  relatedEntityId: string;
  detectedAt: Date;
  status?: string;  // ← CORRECTION : propriété string, pas une fonction !
  read?: boolean;
}

export interface AlertStats {
  total: number;
  critical: number;
  warning: number;
  info: number;
}

export const DOMAINS = [
  { key: 'siteManagement', name: 'Gestion de chantier', icon: 'business_center', color: 'purple' },
  { key: 'purchaseRequests', name: 'Demandes d\'achat', icon: 'shopping_cart', color: 'amber' },
  { key: 'transfers', name: 'Ordres de transfert', icon: 'local_shipping', color: 'cyan' },
  { key: 'stock', name: 'Stock', icon: 'inventory_2', color: 'teal' },
  { key: 'vehicules', name: 'Engins', icon: 'construction', color: 'orange' },
  { key: 'gasoil', name: 'Gasoil', icon: 'local_gas_station', color: 'green' }
];

export function getSeverityIcon(severity: string): string {
  switch (severity) {
    case 'Critical': return 'error';
    case 'Warning': return 'warning';
    default: return 'info';
  }
}

export function getSeverityColor(severity: string): string {
  switch (severity) {
    case 'Critical': return '#dc2626';
    case 'Warning': return '#f59e0b';
    default: return '#3b82f6';
  }
}