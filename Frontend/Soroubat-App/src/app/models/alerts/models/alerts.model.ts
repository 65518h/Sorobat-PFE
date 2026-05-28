// src/app/models/alerts/models/alert.model.ts

export interface Alert {
  id: string;                           // Identifiant unique
  type: string;                         // Catégorie d'alerte
  severity: 'Critical' | 'Warning' | 'Info';  // Niveau de sévérité
  title: string;                        // Titre court
  message: string;                      // Message détaillé
  relatedEntityNo: string;              // Numéro métier de l'entité concernée
  relatedEntityId: string | null;       // SystemId BC de l'entité (optionnel)
  detectedAt: Date;                     // Date de détection
  
  // Champ local (non stocké dans le backend)
  read?: boolean;                       // Statut de lecture (stocké localStorage)
}

export interface AlertStats {
  total: number;
  critical: number;
  warning: number;
  info: number;
}

export const DOMAINS = [

  { key: 'purchaseRequests', name: 'Demandes d\'achat', icon: 'shopping_cart', color: 'amber' },
  { key: 'transfers', name: 'Ordres de transfert', icon: 'local_shipping', color: 'cyan' },
  { key: 'stock', name: 'Stock', icon: 'inventory_2', color: 'teal' },
  { key: 'vehicules', name: 'Engins', icon: 'construction', color: 'orange' },
  { key: 'gasoil', name: 'Gasoil', icon: 'local_gas_station', color: 'green' },
  { key: 'attendance', name: 'Pointage employés', icon: 'event_available', color: 'purple' }
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