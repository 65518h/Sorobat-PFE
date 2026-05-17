// src/app/modules/equipment/models/vehicule-pointage.model.ts

// ==================== ENUMS ====================

/**
 * Statut du pointage (en-tête)
 */
export enum VehiculePointageStatus {
  DRAFT = 'Brouillon',
  VALIDATED = 'Validé',
  CLOSED = 'Clôturé',
  CANCELLED = 'Annulé',
  OPEN = 'Ouvert'
}

/**
 * Statut du véhicule
 */
export enum VehiculeStatus {
  FUNCTIONAL = 'Fonctionnel',
  BROKEN = 'Panne',
  REFORMED = 'Réformé',
  AVAILABLE = 'Disponible'
}

/**
 * Type de véhicule
 */
export enum VehiculeType {
  TRUCK = 'Camion',
  EXCAVATOR = 'Pelle mécanique',
  BULLDOZER = 'Bouteur',
  GRADER = 'Niveleuse',
  LOADER = 'Chargeuse',
  CRANE = 'Grue',
  ROLLER = 'Compacteur',
  DUMP_TRUCK = 'Tombereau',
  OTHER = 'Autre'
}

// ==================== MODÈLE PRINCIPAL ====================

/**
 * En-tête du pointage des véhicules
 */
export interface VehiculePointageHeader {
  no: string | undefined;
  /** Identifiant unique */
  id?: string;
  /** Numéro du document de pointage */
  documentNo?: string;
  /** Numéro du projet/chantier */
  jobNo: string;
  /** Description du projet */
  jobDescription?: string;
  /** Date du pointage */
  date: Date | string;
  /** Statut du pointage */
  status?: string;
  /** Observations générales */
  observation?: string;
  /** Créé par */
  createdBy?: string;
  /** Date de création */
  createdAt?: Date | string;
  /** Validé par */
  validatedBy?: string;
  /** Date de validation */
  validatedAt?: Date | string;
  /** Clôturé par */
  closedBy?: string;
  /** Date de clôture */
  closedAt?: Date | string;
  
  // ✅ Propriété retournée par l'API
  vehiculePointageLines?: VehiculePointageLine[];
  
  // ✅ Propriétés pour la compatibilité
  lines?: VehiculePointageLine[];
  totalVehicules?: number;
  totalHours?: number;
  totalDistance?: number;
  totalFuel?: number;
  totalEstimatedCost?: number;
}

/**
 * Ligne de pointage (détail par véhicule)
 */
export interface VehiculePointageLine {
  /** Identifiant unique */
  id?: string;
  /** Numéro du document parent */
  documentNo?: string;
  /** Code du véhicule */
  vehiculeNo: string;
  /** Description de l'activité */
  description?: string;
  /** Statut de la ligne */
  status?: string;
  /** Heures travaillées */
  hoursWorked: number;
  /** Index de départ (compteur) */
  startIndex: number;
  /** Index de fin (compteur) */
  endIndex: number;
  /** Carburant consommé (litres) */
  fuelConsumed?: number;
  /** Motif de panne (si applicable) */
  breakdownMotiv?: string;
  /** Conducteur */
  driver?: string;
  /** Nature des travaux */
  workType?: string;
  /** Observations */
  remarks?: string;
  /** Coût estimé de la ligne */
  estimatedCost?: number;
}

// ==================== TYPES POUR LES RÉSUMÉS ====================

/**
 * Récapitulatif d'un pointage
 */
export interface VehiculePointageSummary {
  totalVehicules: number;
  totalHours: number;
  totalDistance: number;
  totalFuel: number;
  averageFuelConsumption: number;
  totalEstimatedCost: number;
  brokenVehicules: number;
}

/**
 * Calculs dérivés pour une ligne de pointage
 */
export interface VehiculePointageMetrics {
  distance: number;
  averageConsumption: number;
  estimatedFuelCost: number;
  productivity: number;
}

// ==================== FONCTIONS UTILITAIRES ====================

/**
 * Calcule les métriques pour une ligne de pointage
 */
export function calculateVehiculePointageMetrics(line: VehiculePointageLine): VehiculePointageMetrics {
  const distance = Math.max(0, (line.endIndex || 0) - (line.startIndex || 0));
  const averageConsumption = distance > 0 && line.fuelConsumed 
    ? (line.fuelConsumed / distance) * 100 
    : 0;
  const productivity = line.hoursWorked > 0 
    ? distance / line.hoursWorked 
    : 0;
  
  return {
    distance: Math.round(distance),
    averageConsumption: Number(averageConsumption.toFixed(2)),
    estimatedFuelCost: Math.round((line.fuelConsumed || 0) * 850),
    productivity: Number(productivity.toFixed(2))
  };
}

/**
 * Calcule le récapitulatif d'un pointage
 */
export function calculateVehiculePointageSummary(lines: VehiculePointageLine[]): VehiculePointageSummary {
  if (!lines || lines.length === 0) {
    return {
      totalVehicules: 0,
      totalHours: 0,
      totalDistance: 0,
      totalFuel: 0,
      averageFuelConsumption: 0,
      totalEstimatedCost: 0,
      brokenVehicules: 0
    };
  }
  
  const totalVehicules = lines.length;
  const totalHours = lines.reduce((sum, l) => sum + (l.hoursWorked || 0), 0);
  const totalDistance = lines.reduce((sum, l) => sum + Math.max(0, (l.endIndex || 0) - (l.startIndex || 0)), 0);
  const totalFuel = lines.reduce((sum, l) => sum + (l.fuelConsumed || 0), 0);
  const brokenVehicules = lines.filter(l => l.breakdownMotiv && l.breakdownMotiv.trim() !== '').length;
  const averageFuelConsumption = totalDistance > 0 ? (totalFuel / totalDistance) * 100 : 0;
  
  return {
    totalVehicules,
    totalHours: Number(totalHours.toFixed(2)),
    totalDistance: Math.round(totalDistance),
    totalFuel: Math.round(totalFuel),
    averageFuelConsumption: Number(averageFuelConsumption.toFixed(2)),
    totalEstimatedCost: Math.round((totalFuel * 850) + (totalHours * 5000)),
    brokenVehicules
  };
}

/**
 * Retourne la classe CSS pour le statut du pointage
 */
export function getPointageStatusClass(status: string): string {
  switch (status) {
    case 'Brouillon': return 'status-draft';
    case 'Validé': return 'status-validated';
    case 'Clôturé': return 'status-closed';
    case 'Ouvert': return 'status-open';
    default: return '';
  }
}

/**
 * Retourne l'icône pour le statut du pointage
 */
export function getPointageStatusIcon(status: string): string {
  switch (status) {
    case 'Brouillon': return 'edit_note';
    case 'Validé': return 'check_circle';
    case 'Clôturé': return 'lock';
    case 'Ouvert': return 'radio_button_checked';
    default: return 'help_outline';
  }
}

/**
 * Retourne la classe CSS pour le statut du véhicule
 */
export function getVehiculeStatusClass(status: string): string {
  switch (status) {
    case 'Fonctionnel': return 'status-functional';
    case 'Panne': return 'status-broken';
    case 'Réformé': return 'status-reformed';
    case 'Disponible': return 'status-available';
    default: return '';
  }
}

/**
 * Retourne l'icône pour le statut du véhicule
 */
export function getVehiculeStatusIcon(status: string): string {
  switch (status) {
    case 'Fonctionnel': return 'check_circle';
    case 'Panne': return 'error';
    case 'Réformé': return 'delete_forever';
    case 'Disponible': return 'radio_button_checked';
    default: return 'help_outline';
  }
}

/**
 * Formate une date pour l'affichage
 */
export function formatVehiculePointageDate(date: Date | string | undefined): string {
  if (!date) return '—';
  const d = new Date(date);
  if (isNaN(d.getTime()) || d.getFullYear() === 1) return '—';
  return d.toLocaleDateString('fr-FR');
}

/**
 * Formate un nombre pour l'affichage
 */
export function formatVehiculePointageNumber(value: number | undefined, decimals: number = 0): string {
  if (value === undefined || value === null) return '0';
  return value.toLocaleString('fr-FR', {
    minimumFractionDigits: decimals,
    maximumFractionDigits: decimals
  });
}