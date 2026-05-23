// src/app/models/purchases/models/purchase-request-line.model.ts

// ==================== ENUM ====================
export enum LineType {
  ARTICLE = 'Item',
  IMMOBILISATION = 'Fixed Asset'
}

// ==================== INTERFACE PRINCIPALE ====================
/**
 * Ligne de demande d'achat - Alignée avec PurchaseRequestLineReadDto du backend
 */
export interface PurchaseRequestLine {
  id?: string;                    //  Id (Guid) - Backend: Id
  documentNo?: string;            //  Backend: DocumentNo
  lineNo?: number;                //  Backend: LineNo
  type?: string;                  //  Backend: Type (Item, Fixed Asset)
  no?: string;                    //  Backend: No (Code article/immobilisation)
  description?: string;           //  Backend: Description
  observation?: string;           //  Backend: Observation
  quantity: number;               //  Backend: Quantity
  unitOfMeasureCode?: string;     //  Backend: UnitOfMeasureCode
  locationCode?: string;          //  Backend: LocationCode
  jobNo?: string;                 //  Backend: JobNo
  jobTaskNo?: string;             //  Backend: JobTaskNo
}

// ==================== TYPE POUR LA CRÉATION ====================
/**
 * Données nécessaires pour créer une ligne
 */
export type CreatePurchaseRequestLine = {
  documentNo: string;             // Numéro de la demande
  jobNo: string;                  // Projet (forcé par le backend)
  type: string;                   // Type: 'Item' ou 'Fixed Asset'
  no: string;                     // Code article/immobilisation
  quantity: number;               // Quantité
  locationCode: string;           // Code magasin
  jobTaskNo?: string;             // Tâche (optionnel)
  observation?: string;           // Observation (optionnel)
};

// ==================== TYPE POUR LA MISE À JOUR ====================
/**
 * Champs modifiables pour une ligne (PATCH)
 * Aligné avec PurchaseRequestLinePatchDto du backend
 */
export type UpdatePurchaseRequestLine = Partial<{
  type: string;                   // Type modifiable
  no: string;                     // N° Article modifiable
  description: string;            // Description modifiable
  observation: string;            // Observation modifiable
  quantity: number;               // Quantité modifiable
  locationCode: string;           // Magasin modifiable
  jobTaskNo: string;              // Tâche modifiable
}>;

// ==================== FONCTIONS UTILITAIRES ====================

/**
 * Retourne le libellé du type de ligne
 */
export function getLineTypeLabel(type: string | undefined): string {
  switch (type) {
    case 'Item':
      return 'Article';
    case 'Fixed Asset':
    case 'Fixed_x0020_Asset':
      return 'Immobilisation';
    default:
      return type || '—';
  }
}

/**
 * Retourne l'icône du type de ligne
 */
export function getLineTypeIcon(type: string | undefined): string {
  switch (type) {
    case 'Item':
      return 'inventory_2';
    case 'Fixed Asset':
    case 'Fixed_x0020_Asset':
      return 'business_center';
    default:
      return 'category';
  }
}

/**
 * Convertit un type d'affichage en type backend
 */
export function getTypeForBackend(type: string): string {
  switch (type) {
    case 'Article':
      return 'Item';
    case 'Immobilisation':
      return 'Fixed Asset';
    default:
      return type;
  }
}

/**
 * Convertit un type backend en type d'affichage
 */
export function getTypeForDisplay(type: string): string {
  switch (type) {
    case 'Item':
      return 'Article';
    case 'Fixed Asset':
    case 'Fixed_x0020_Asset':
      return 'Immobilisation';
    default:
      return type;
  }
}