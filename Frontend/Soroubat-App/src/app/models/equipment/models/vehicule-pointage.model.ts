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
 * Statut du véhicule (pour la ligne)
 * Correspond aux valeurs du backend
 */
export enum VehiculeLineStatus {
  FUNCTIONAL = 'Fonctionnel',
  BROKEN = 'Panne',
  ACCIDENT = 'Accident',
  BAD_WEATHER = 'Mauvais Temps',
  AVAILABLE = 'Disponible',
  REFORMED = 'Réformé'
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
 * Compatible avec le backend VehiculePointageHeaderReadDto
 */
export interface VehiculePointageHeader {
  jobDescription: any;
  /** Identifiant unique (GUID) */
  id?: string;
  /** Numéro du document de pointage */
  documentNo?: string;
  /** Numéro du projet/chantier */
  jobNo?: string;
  /** Date du pointage (format YYYY-MM-DD ou Date) */
  date?: string | Date;
  /** Statut du pointage: Brouillon, Ouvert, Validé, Clôturé, Annulé */
  status?: string;
  /** Observations générales */
  observation?: string;
  
  //  Propriété retournée par l'API avec expand
  vehiculePointageLines?: VehiculePointageLine[];
  
  //  Propriétés calculées pour le frontend
  no?: string;  // Alias pour documentNo
  lines?: VehiculePointageLine[];
  totalVehicules?: number;
  totalHours?: number;
  totalDistance?: number;
  totalFuel?: number;
  totalEstimatedCost?: number;
}

/**
 * Ligne de pointage (détail par véhicule)
 * Compatible avec le backend VehiculePointageLineReadDto
 */
export interface VehiculePointageLine {
  /** Identifiant unique (GUID) */
  id?: string;
  /** Numéro du document parent */
  documentNo?: string;
  /** Code du véhicule */
  vehiculeNo: string;
  /** Description de l'activité */
  description?: string;
  /** Statut de la ligne (Fonctionnel, Panne, Accident, Mauvais Temps, Disponible, Réformé) */
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

// ==================== DTO POUR LES REQUÊTES API ====================

/**
 * DTO pour la création d'un en-tête
 * POST /api/VehiculePointage
 * Body: { "date": "YYYY-MM-DD" }
 */
export interface VehiculePointageHeaderCreateDto {
  date: string;  // Format: YYYY-MM-DD
}

/**
 * DTO pour la mise à jour d'un en-tête
 * PATCH /api/VehiculePointage/{id}
 */
export interface VehiculePointageHeaderPatchDto {
  date?: string;
  status?: string;
  observation?: string;
}

/**
 * DTO pour la mise à jour d'une ligne
 * PATCH /api/VehiculePointage/lines/{id}
 * Seuls les champs modifiables sont envoyés
 */
export interface VehiculePointageLinePatchDto {
  hoursWorked?: number;
  startIndex?: number;
  endIndex?: number;
  status?: string;
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
  const brokenVehicules = lines.filter(l => l.status === 'Panne' || l.status === 'Accident').length;
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
 * Retourne la classe CSS pour le statut du pointage (en-tête)
 */
export function getPointageStatusClass(status: string | undefined): string {
  if (!status) return '';
  const s = status.toLowerCase();
  switch (s) {
    case 'brouillon': return 'status-draft';
    case 'ouvert': return 'status-open';
    case 'validé': return 'status-validated';
    case 'clôturé': return 'status-closed';
    case 'annulé': return 'status-cancelled';
    default: return '';
  }
}

/**
 * Retourne l'icône pour le statut du pointage (en-tête)
 */
export function getPointageStatusIcon(status: string | undefined): string {
  if (!status) return 'help_outline';
  const s = status.toLowerCase();
  switch (s) {
    case 'brouillon': return 'edit_note';
    case 'ouvert': return 'radio_button_unchecked';
    case 'validé': return 'check_circle';
    case 'clôturé': return 'lock';
    case 'annulé': return 'cancel';
    default: return 'help_outline';
  }
}

/**
 * Retourne la classe CSS pour le statut du véhicule (ligne)
 */
export function getVehiculeStatusClass(status: string | undefined): string {
  if (!status) return '';
  switch (status) {
    case 'Fonctionnel': return 'status-functional';
    case 'Panne': return 'status-broken';
    case 'Accident': return 'status-accident';
    case 'Mauvais Temps': return 'status-bad-weather';
    case 'Disponible': return 'status-available';
    case 'Réformé': return 'status-reformed';
    default: return '';
  }
}

/**
 * Retourne l'icône pour le statut du véhicule (ligne)
 */
export function getVehiculeStatusIcon(status: string | undefined): string {
  if (!status) return 'help_outline';
  switch (status) {
    case 'Fonctionnel': return 'check_circle';
    case 'Panne': return 'error';
    case 'Accident': return 'warning';
    case 'Mauvais Temps': return 'thunderstorm';
    case 'Disponible': return 'radio_button_checked';
    case 'Réformé': return 'delete_forever';
    default: return 'help_outline';
  }
}

/**
 * Formate une date pour l'affichage
 */
export function formatVehiculePointageDate(date: string | Date | undefined): string {
  if (!date) return '—';
  const d = new Date(date);
  if (isNaN(d.getTime()) || d.getFullYear() === 1) return '—';
  return d.toLocaleDateString('fr-FR', {
    day: '2-digit',
    month: '2-digit',
    year: 'numeric'
  });
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

/**
 * Convertit une date en format YYYY-MM-DD pour l'API
 */
export function formatDateForAPI(date: Date | string): string {
  const d = new Date(date);
  const year = d.getFullYear();
  const month = String(d.getMonth() + 1).padStart(2, '0');
  const day = String(d.getDate()).padStart(2, '0');
  return `${year}-${month}-${day}`;
}