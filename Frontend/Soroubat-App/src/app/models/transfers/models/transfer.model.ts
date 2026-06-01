// src/app/models/transfers/models/transfer.model.ts

export interface TransferHeader {
  id?: string;
  no?: string;
  status?: string;
  transferFromCode?: string;
  transferToCode?: string;
  inTransitCode?: string;
  postingDate?: string | Date;
  receiptDate?: string | Date;  
  observation?: string;
  chantierOrigine?: string;
  chantierDestination?: string;
  idExpediteur?: string;
  idReceptionneur?: string;
  numMateriel?: string;
 
  transferLines?: TransferLine[];
}

export interface TransferLine {
  id?: string;
  documentNo?: string;
  lineNo?: number;
  itemNo?: string;
  description?: string;
  quantity?: number;
  quantityShipped?: number;
  quantityReceived?: number;
  qtyToReceive?: number;  //  Quantité à recevoir (saisie par le chef)
  unitOfMeasure?: string;
  stock?: number;
  numVehicule?: string;
  affaire?: string;
  descriptionSoroubat?: string;
}

export enum TransferStatus {
  OPEN = 'Open',
  RELEASED = 'Released',
  RECEIVED = 'Received',
  CANCELLED = 'Cancelled'
}

export function getTransferStatusClass(status: string): string {
  const statusMap: Record<string, string> = {
    'Open': 'status-open',
    'Released': 'status-released',
    'Received': 'status-received',
    'Cancelled': 'status-cancelled'
  };
  return statusMap[status] || 'status-default';
}

export function getTransferStatusLabel(status: string): string {
  const labelMap: Record<string, string> = {
    'Open': 'Ouvert',
    'Released': 'Lancé',
    'Received': 'Réceptionné',
    'Cancelled': 'Annulé'
  };
  return labelMap[status] || status;
}

export function getTransferStatusIcon(status: string): string {
  const iconMap: Record<string, string> = {
    'Open': 'radio_button_unchecked',
    'Released': 'local_shipping',
    'Received': 'check_circle',
    'Cancelled': 'cancel'
  };
  return iconMap[status] || 'help_outline';
}