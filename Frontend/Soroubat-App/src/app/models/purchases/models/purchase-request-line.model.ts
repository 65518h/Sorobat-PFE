

import { LineStatus } from './approval.model';

export interface PurchaseRequestLine {
  // Identifiants
  id: string;                    // SystemId (GUID) - clé primaire API
  documentNo: string;            // N° Document parent
  lineNo: number;                // N° Ligne (ordre)
  
  // Transfert
  transferer: boolean;           // Case à cocher pour transfert vers commande
  
  // Informations article
  type: LineType;                // Type de ligne
  no: string;                    // N° Article/Compte/Immobilisation
  description: string;           // Description
  description2?: string;         // Observation complémentaire
  
  // Quantités
  quantity: number;              // Quantité demandée
  unitOfMeasureCode: string;     // Unité de mesure (PCE, KG, M, etc.)
  unitCost?: number;             // Prix unitaire
  lineAmount: number;            // Montant ligne = quantity × unitCost
  
  // Dimensions logistiques
  locationCode: string;          // Code magasin de destination
  variantCode?: string;          // Code variante (couleur, taille)
  
  // Contexte projet (peut différer de l'en-tête)
  jobNo?: string;                // N° Projet
  jobTaskNo?: string;            // N° Tâche projet (par défaut '0')
  
  // Équipement
  engin?: string;                // Code engin
  
  // Statut ligne
  statut?: LineStatus;           // Statut de la ligne (En attente, Approuvé, Refusé, Transféré)
  reasonRefusal?: string;        // Motif de refus
  
  // Lien avec commande
  associatedPurchaseOrder?: string; // Commande fournisseur associée
  
  // Contrôle stock (affichage - non stocké)
  stockAvailable?: number;       // Stock disponible (calculé)
  stockInProgress?: number;      // Stock en cours (calculé)
  quantityOrderedNotDelivered?: number; // Quantité commandée non livrée (calculé)
}

export enum LineType {
  ITEM = 'Item',
  FIXED_ASSET = 'Fixed Asset',
  G_L_ACCOUNT = 'G/L Account',
  RESOURCE = 'Resource'
}

// Type pour la création d'une ligne
export type CreatePurchaseRequestLine = Omit<PurchaseRequestLine, 'id' | 'lineNo' | 'lineAmount'> & {
  lineAmount?: number;
};

// Type pour la mise à jour partielle
export type UpdatePurchaseRequestLine = Partial<Pick<PurchaseRequestLine,
  'transferer' | 'quantity' | 'description' | 'description2' | 'locationCode' | 'jobTaskNo' | 'engin' | 'unitCost'
>>;