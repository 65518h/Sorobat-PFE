// src/app/modules/gasoil/models/gasoil.model.ts

export interface GasoilHeader {
  id?: string;
  documentNo?: string;
  date?: string | Date;
  locationCode?: string;
  jobNo?: string;
  status?: string;
  fileNo?: string;
  gasoilLines?: GasoilLine[];
  // ✅ Flag interne pour le cache (optionnel, n'affecte pas l'API)
  _detailsLoaded?: boolean;  // Correction: boolean au lieu de GasoilHeader | undefined
}

export interface GasoilLine {
  id?: string;
  documentNo?: string;
  lineNo?: number;
  vehicleNo?: string;
  quantity?: number;
  indexType?: string;
  hourIndex?: number;
  kmIndex?: number;
  projectNo?: string;
}

export interface GasoilStats {
  totalDocuments: number;
  totalQuantity: number;
  pendingCount: number;
  validatedCount: number;
}

// Mapping des statuts
export const getGasoilStatusClass = (status: string | undefined): string => {
  if (!status) return 'status-pending';
  
  const statusLower = status.toLowerCase();
  switch (statusLower) {
    case 'en cours':
      return 'status-pending';
    case 'valider':
      return 'status-validated';
    default:
      return 'status-pending';
  }
};

export const getGasoilStatusIcon = (status: string | undefined): string => {
  if (!status) return 'pending';
  
  const statusLower = status.toLowerCase();
  switch (statusLower) {
    case 'en cours':
      return 'pending';
    case 'valider':
      return 'check_circle';
    default:
      return 'help_outline';
  }
};

export const getGasoilStatusLabel = (status: string | undefined): string => {
  if (!status) return 'En cours';
  
  const statusLower = status.toLowerCase();
  switch (statusLower) {
    case 'en cours':
      return 'En cours';
    case 'valider':
      return 'Validé';
    default:
      return status;
  }
};

export const getIndexTypeLabel = (type: string | undefined): string => {
  if (!type) return '—';
  
  switch (type) {
    case 'Hour':
      return 'Heures';
    case 'Km':
      return 'Kilomètres';
    default:
      return type;
  }
};