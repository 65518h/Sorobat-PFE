// src/app/models/purchases/models/purchase-request-line.model.ts

// ✅ Ajouter export devant l'enum
export enum LineType {
  ARTICLE = 'Article',
  IMMOBILISATION = 'Immobilisation'
}

export interface PurchaseRequestLine {
  id?: string;
  documentNo?: string;
  lineNo?: number;
  transferer: boolean;
  type: string;
  no?: string;
  description?: string;
  description2?: string;
  quantity: number;
  unitOfMeasureCode?: string;
  locationCode?: string;
  variantCode?: string;
  jobNo?: string;
  jobTaskNo?: string;
  engin?: string;
  lineAmount?: number;
}

export type CreatePurchaseRequestLine = {
  documentNo: string;
  transferer: boolean;
  type: string;
  no?: string;
  description?: string;
  description2?: string;
  quantity: number;
  unitOfMeasureCode?: string;
  locationCode?: string;
  variantCode?: string;
  jobNo?: string;
  jobTaskNo?: string;
  engin?: string;
};

export type UpdatePurchaseRequestLine = Partial<Pick<PurchaseRequestLine,
  'transferer' | 'quantity' | 'description' | 'description2' | 
  'locationCode' | 'jobTaskNo' | 'engin' | 'type' | 'no' | 
  'unitOfMeasureCode' | 'variantCode'
>>;
// ✅ Ajouter export devant la fonction utilitaire
export function calculateLineAmount(quantity: number, price?: number): number {
  if (!price) return 0;
  return quantity * price;
}