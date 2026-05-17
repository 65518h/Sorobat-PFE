// src/app/models/inventory/components/stock-detail/stock-detail.component.ts

import { Component, Inject, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { MatIconModule } from '@angular/material/icon';
import { MatButtonModule } from '@angular/material/button';
import { MatTabsModule } from '@angular/material/tabs';
import { MatDialog } from '@angular/material/dialog';
import { StockItem } from '../../models/stock.model';

export interface Movement {
  id: number;
  type: 'in' | 'out' | 'transfer';
  icon: string;
  title: string;
  date: Date;
  quantity: number;
  user?: string;
}

@Component({
  selector: 'app-stock-detail',
  standalone: true,
  imports: [
    CommonModule,
    MatIconModule,
    MatButtonModule,
    MatTabsModule
  ],
  templateUrl: './stock-detail.html',
  styleUrls: ['./stock-detail.css']
})
export class StockDetailComponent implements OnInit {
  
  movements: Movement[] = [];
  lastUpdate: Date = new Date();
  totalEntries: number = 0;
  totalExits: number = 0;
  stockRotation: number = 0;
  
  constructor(
    @Inject(MAT_DIALOG_DATA) public data: StockItem,
    private dialogRef: MatDialogRef<StockDetailComponent>,
    private dialog: MatDialog
  ) {}
  
  ngOnInit(): void {
    this.loadMockMovements();
    this.calculateStats();
  }
  
  private loadMockMovements(): void {
    // Données mockées - À remplacer par votre API
    this.movements = [
      {
        id: 1,
        type: 'in',
        icon: 'add_circle',
        title: 'Entrée de stock',
        date: new Date(Date.now() - 2 * 24 * 60 * 60 * 1000),
        quantity: 50,
        user: 'Admin'
      },
      {
        id: 2,
        type: 'out',
        icon: 'remove_circle',
        title: 'Sortie de stock',
        date: new Date(Date.now() - 5 * 24 * 60 * 60 * 1000),
        quantity: -15,
        user: 'Jean Dupont'
      },
      {
        id: 3,
        type: 'transfer',
        icon: 'swap_horiz',
        title: 'Transfert vers Magasin B',
        date: new Date(Date.now() - 10 * 24 * 60 * 60 * 1000),
        quantity: -10,
        user: 'Marie Martin'
      }
    ];
  }
  
  private calculateStats(): void {
    this.totalEntries = this.movements
      .filter(m => m.type === 'in')
      .reduce((sum, m) => sum + m.quantity, 0);
    
    this.totalExits = Math.abs(this.movements
      .filter(m => m.type === 'out')
      .reduce((sum, m) => sum + m.quantity, 0));
    
    const totalMouvements = this.totalEntries + this.totalExits;
    this.stockRotation = totalMouvements > 0 
      ? Math.round((this.totalExits / totalMouvements) * 100) 
      : 0;
  }
  
  getQuantityClass(quantity: number): string {
    if (quantity <= 0) return 'out';
    if (quantity <= 10) return 'low';
    return 'normal';
  }
  
  getStatusClass(): string {
    if (this.data.quantity <= 0) return 'out';
    if (this.data.quantity <= 10) return 'low';
    return 'normal';
  }
  
  getStatusIcon(): string {
    if (this.data.quantity <= 0) return 'error';
    if (this.data.quantity <= 10) return 'warning';
    return 'check_circle';
  }
  
  getStatusText(): string {
    if (this.data.quantity <= 0) return 'Rupture de stock';
    if (this.data.quantity <= 10) return 'Stock faible';
    return 'Stock normal';
  }
  
  get hasAlert(): boolean {
    return this.data.quantity <= 10;
  }
  
  formatQuantity(quantity: number): string {
    return new Intl.NumberFormat('fr-FR').format(quantity);
  }
  
  close(): void {
    this.dialogRef.close();
  }
  
  edit(): void {
    console.log('Modifier l\'article', this.data);
    // Implémenter la logique d'édition
  }
  
  print(): void {
    console.log('Imprimer les détails', this.data);
    // Implémenter la logique d'impression
  }
  
  requestStock(): void {
    console.log('Demander réapprovisionnement', this.data);
    // Implémenter la logique de demande
  }
  
  urgentRequest(): void {
    console.log('Demande urgente', this.data);
    // Implémenter la logique de demande urgente
  }
  
  addStock(): void {
    console.log('Ajouter du stock', this.data);
    // Implémenter la logique d'entrée de stock
  }
  
  removeStock(): void {
    console.log('Retirer du stock', this.data);
    // Implémenter la logique de sortie de stock
  }
  
  transferStock(): void {
    console.log('Transférer du stock', this.data);
    // Implémenter la logique de transfert
  }
}