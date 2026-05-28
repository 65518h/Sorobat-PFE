// src/app/models/transfers/pages/transfer-detail/transfer-detail.ts

import { Component, OnInit, OnDestroy, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router, ActivatedRoute, RouterModule } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { Subject, takeUntil, finalize, catchError, of } from 'rxjs';

// Angular Material Modules
import { MatCardModule } from '@angular/material/card';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatTableModule } from '@angular/material/table';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { MatTooltipModule } from '@angular/material/tooltip';
import { MatInputModule } from '@angular/material/input';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatDividerModule } from '@angular/material/divider';
import { ToastrService } from 'ngx-toastr';

// Services
import { TransferService } from '../../services/transfer.service';
import { NotificationService } from '../../../../core/services/notification';
import { AuthService } from '../../../../core/services/auth';
import { AppModeService } from '../../../../core/services/app-mode.service';
import { CacheService } from '../../../../core/services/cache.service';
import { OfflineHideActionsDirective } from '../../../../core/directives/offline-hide-actions.directive';
import { ShowOfflineMessageDirective } from '../../../../core/directives/show-offline-message.directive';
import { TransferHeader, TransferLine, getTransferStatusClass, getTransferStatusLabel, getTransferStatusIcon } from '../../models/transfer.model';

@Component({
  selector: 'app-transfer-detail',
  templateUrl: './transfer-detail.html',
  styleUrls: ['./transfer-detail.css'],
  standalone: true,
  imports: [
    CommonModule,
    FormsModule,
    RouterModule,
    MatCardModule,
    MatButtonModule,
    MatIconModule,
    MatTableModule,
    MatProgressSpinnerModule,
    MatTooltipModule,
    MatInputModule,
    MatFormFieldModule,
    MatDividerModule,
    OfflineHideActionsDirective,
    ShowOfflineMessageDirective
  ]
})
export class TransferDetailComponent implements OnInit, OnDestroy {
  
  transfer: TransferHeader | null = null;
  loading: boolean = true;
  error: string | null = null;
  transferId: string | null = null;
  submitting: boolean = false;
  
  isAdmin: boolean = false;
  isReadOnly: boolean = false;
  isOnline: boolean = true;
  
  // Map pour stocker les quantités à recevoir
  qtyToReceiveMap: Map<string, number> = new Map();
  
  // Pour la modification de la date de réception
  editableReceiptDate: string = '';
  isEditingReceiptDate: boolean = false;
  updatingReceiptDate: boolean = false;
  private originalReceiptDate: string = '';
  
  private destroy$ = new Subject<void>();
  
  // Méthode utilitaire pour obtenir la date du jour
  private getTodayDate(): string {
    const today = new Date();
    const year = today.getFullYear();
    const month = String(today.getMonth() + 1).padStart(2, '0');
    const day = String(today.getDate()).padStart(2, '0');
    return `${year}-${month}-${day}`;
  }
  
  constructor(
    private router: Router,
    private route: ActivatedRoute,
    private transferService: TransferService,
    private notificationService: NotificationService,
    private authService: AuthService,
    private cdr: ChangeDetectorRef,
    private toastr: ToastrService,
    private appMode: AppModeService,
    private cacheService: CacheService
  ) {}
  
  ngOnInit(): void {
    this.appMode.mode$
      .pipe(takeUntil(this.destroy$))
      .subscribe(mode => {
        this.isReadOnly = mode === 'offline-readonly';
        this.isOnline = mode === 'online';
        console.log('Mode transfer-detail:', this.isReadOnly ? 'offline-readonly' : 'online');
        this.cdr.detectChanges();
      });
    
    this.isAdmin = this.authService.isApprover();
    this.transferId = this.route.snapshot.paramMap.get('id');
    
    if (this.transferId) {
      this.loadTransfer();
    } else {
      this.error = 'ID de transfert non trouve';
      this.loading = false;
    }
  }
  
  ngOnDestroy(): void {
    this.destroy$.next();
    this.destroy$.complete();
  }
  
  async loadTransfer(): Promise<void> {
    if (!this.transferId) return;
    
    this.loading = true;
    this.error = null;
    
    const cacheKey = `transfer-detail-${this.transferId}`;
    
    try {
      const cachedTransfer = await this.cacheService.getFromCache(cacheKey);
      
      if (cachedTransfer) {
        console.log('Transfert charge depuis le cache');
        this.applyTransferData(cachedTransfer);
        this.loading = false;
        this.cdr.detectChanges();
      }
      
      if (this.isOnline) {
        console.log('Chargement du transfert depuis l\'API...');
        
        this.transferService.getById(this.transferId).pipe(
          takeUntil(this.destroy$),
          finalize(() => {
            this.cdr.detectChanges();
          })
        ).subscribe({
          next: async (transfer) => {
            if (transfer) {
              console.log('Transfert frais recu');
              this.applyTransferData(transfer);
              await this.cacheService.saveToCache(cacheKey, transfer);
              console.log('Transfert mis en cache');
            }
            this.loading = false;
            this.cdr.detectChanges();
          },
          error: (error) => {
            console.error('Erreur:', error);
            if (!cachedTransfer) {
              if (!this.isReadOnly) {
                this.error = 'Impossible de charger le transfert';
              } else {
                this.toastr.warning('Transfert non disponible hors ligne', 'Mode lecture seule');
              }
              this.loading = false;
            }
            this.cdr.detectChanges();
          }
        });
      } else if (!cachedTransfer) {
        this.error = 'Transfert non disponible hors ligne';
        this.loading = false;
        this.toastr.warning('Aucune donnee en cache pour ce transfert', 'Mode hors ligne');
        this.cdr.detectChanges();
      }
      
    } catch (error) {
      console.error('Erreur chargement cache:', error);
      this.error = 'Erreur lors du chargement';
      this.loading = false;
      this.cdr.detectChanges();
    }
  }
  
  private applyTransferData(transfer: TransferHeader): void {
    this.transfer = transfer;
    
    if (transfer.receiptDate) {
      this.editableReceiptDate = this.formatDateForInput(transfer.receiptDate);
    } else {
      this.editableReceiptDate = '';
    }
    
    if (transfer.transferLines) {
      transfer.transferLines.forEach(line => {
        if (line.id) {
          this.qtyToReceiveMap.set(line.id, 0);
        }
      });
    }
    
    this.cdr.detectChanges();
  }
  
  getRemainingQuantity(line: TransferLine): number {
    return (line.quantity || 0) - (line.quantityReceived || 0);
  }
  
  getTotalToReceive(): number {
    if (!this.transfer?.transferLines) return 0;
    
    let total = 0;
    for (const line of this.transfer.transferLines) {
      const qty = this.getQuantityToReceive(line.id || '');
      total += qty;
    }
    return total;
  }
  
  getQuantityToReceive(lineId: string): number {
    return this.qtyToReceiveMap.get(lineId) || 0;
  }
  
  onQuantityInputChange(event: any, line: TransferLine): void {
    const value = parseInt(event.target.value, 10);
    const quantity = isNaN(value) ? 0 : value;
    const remaining = this.getRemainingQuantity(line);
    
    if (quantity < 0) {
      this.qtyToReceiveMap.set(line.id!, 0);
      event.target.value = 0;
      this.notificationService.showError('La quantite ne peut pas etre negative');
      return;
    }
    
    if (quantity > remaining) {
      this.qtyToReceiveMap.set(line.id!, remaining);
      event.target.value = remaining;
      this.notificationService.showError(`La quantite ne peut pas depasser ${remaining}`);
      return;
    }
    
    this.qtyToReceiveMap.set(line.id!, quantity);
    this.cdr.detectChanges();
  }
  
  canReceiveLine(line: TransferLine): boolean {
    const remaining = this.getRemainingQuantity(line);
    return !this.isAdmin && this.transfer?.status === 'Released' && remaining > 0 && !this.isReadOnly;
  }
  
  receiveLine(line: TransferLine, index: number): void {
    if (this.isReadOnly) {
      this.toastr.warning('Action indisponible en mode hors ligne', 'Action indisponible');
      return;
    }
    
    const quantityToReceive = this.getQuantityToReceive(line.id || '');
    
    if (quantityToReceive <= 0) {
      this.notificationService.showWarning('Veuillez saisir une quantite valide');
      return;
    }
    
    if (!line.id) {
      this.notificationService.showError('ID de ligne non trouve');
      return;
    }
    
    const receptionDate = this.getTodayDate();
    
    this.submitting = true;
    
    this.transferService.updateLineQuantity(line.id, quantityToReceive, receptionDate).pipe(
      takeUntil(this.destroy$),
      finalize(() => {
        this.submitting = false;
        this.cdr.detectChanges();
      })
    ).subscribe({
      next: () => {
        this.notificationService.showSuccess('Quantite receptionnee avec succes');
        this.qtyToReceiveMap.set(line.id!, 0);
        this.loadTransfer();
      },
      error: (error) => {
        console.error('Erreur:', error);
        this.notificationService.showError('Erreur lors de la reception');
      }
    });
  }
  
  receiveAll(): void {
    if (this.isReadOnly) {
      this.toastr.warning('Action indisponible en mode hors ligne', 'Action indisponible');
      return;
    }
    
    if (!this.transfer?.id) return;
    
    const totalToReceive = this.getTotalToReceive();
    
    if (totalToReceive === 0) {
      this.notificationService.showWarning('Aucune quantite a receptionner');
      return;
    }
    
    for (const line of this.transfer.transferLines || []) {
      const qty = this.getQuantityToReceive(line.id || '');
      const remaining = this.getRemainingQuantity(line);
      if (qty > remaining) {
        this.notificationService.showError(`La quantite pour l'article ${line.itemNo} depasse le reste a recevoir`);
        return;
      }
    }
    
    const receptionDate = this.getTodayDate();
    
    this.notificationService.showConfirmation({
      title: 'Reception complete',
      message: `Confirmer la reception de ${totalToReceive} article(s) ?\n\nDate de reception : ${new Date(receptionDate).toLocaleDateString('fr-FR')}`,
      confirmText: 'Valider',
      cancelText: 'Annuler'
    }).subscribe(confirmed => {
      if (confirmed) {
        this.submitting = true;
        
        this.transferService.receiveTransfer(this.transfer!.id!, receptionDate).pipe(
          takeUntil(this.destroy$),
          finalize(() => {
            this.submitting = false;
            this.cdr.detectChanges();
          })
        ).subscribe({
          next: () => {
            this.notificationService.showSuccess('Transfert receptionne avec succes');
            this.router.navigate(['/transfers']);
          },
          error: (error) => {
            console.error('Erreur:', error);
            this.notificationService.showError('Erreur lors de la reception');
          }
        });
      }
    });
  }
  
  editTransfer(): void {
    if (this.isReadOnly) {
      this.toastr.warning('Modification indisponible en mode hors ligne', 'Action indisponible');
      return;
    }
    
    if (this.transfer?.id) {
      this.router.navigate(['/transfers', this.transfer.id, 'edit']);
    }
  }
  
  deleteTransfer(): void {
    if (this.isReadOnly) {
      this.toastr.warning('Suppression indisponible en mode hors ligne', 'Action indisponible');
      return;
    }
    
    if (!this.transfer?.id) return;
    
    this.notificationService.showConfirmation({
      title: 'Suppression',
      message: `Supprimer le transfert ${this.transfer.no} ?`,
      confirmText: 'Supprimer',
      cancelText: 'Annuler',
      confirmColor: 'warn'
    }).subscribe(confirmed => {
      if (confirmed) {
        this.submitting = true;
        
        this.transferService.delete(this.transfer!.id!).pipe(
          takeUntil(this.destroy$),
          finalize(() => {
            this.submitting = false;
            this.cdr.detectChanges();
          })
        ).subscribe({
          next: () => {
            this.notificationService.showSuccess('Transfert supprime avec succes');
            this.router.navigate(['/transfers']);
          },
          error: (error) => {
            console.error('Erreur:', error);
            this.notificationService.showError('Erreur lors de la suppression');
          }
        });
      }
    });
  }
  
  releaseTransfer(): void {
    if (this.isReadOnly) {
      this.toastr.warning('Action indisponible en mode hors ligne', 'Action indisponible');
      return;
    }
    
    if (!this.transfer?.id) return;
    
    this.notificationService.showConfirmation({
      title: 'Expedition',
      message: `Confirmer l'expedition du transfert ${this.transfer.no} ?`,
      confirmText: 'Expedier',
      cancelText: 'Annuler'
    }).subscribe(confirmed => {
      if (confirmed) {
        this.submitting = true;
        
        this.transferService.releaseTransfer(this.transfer!.id!).pipe(
          takeUntil(this.destroy$),
          finalize(() => {
            this.submitting = false;
            this.cdr.detectChanges();
          })
        ).subscribe({
          next: () => {
            this.notificationService.showSuccess('Transfert expedie avec succes');
            this.loadTransfer();
          },
          error: (error) => {
            console.error('Erreur:', error);
            this.notificationService.showError('Erreur lors de l\'expedition');
          }
        });
      }
    });
  }
  
  goBack(): void {
    this.router.navigate(['/transfers']);
  }
  
  getStatusClass(status: string | undefined): string {
    return getTransferStatusClass(status || '');
  }
  
  getStatusLabel(status: string | undefined): string {
    return getTransferStatusLabel(status || '');
  }
  
  getStatusIcon(status: string | undefined): string {
    return getTransferStatusIcon(status || '');
  }
  
  formatDate(date: string | Date | undefined): string {
    if (!date) return '';
    const d = new Date(date);
    if (isNaN(d.getTime())) return '';
    return d.toLocaleDateString('fr-FR', {
      day: '2-digit',
      month: '2-digit',
      year: 'numeric'
    });
  }
  
  formatReceiptDate(date: string | Date | undefined): string {
    if (!date) return 'Non receptionne';
    return this.formatDate(date);
  }
  
  // ==================== METHODES POUR LA DATE DE RECEPTION ====================
  
  formatDateForInput(date: string | Date | undefined): string {
    if (!date) return '';
    const d = new Date(date);
    if (isNaN(d.getTime())) return '';
    const year = d.getFullYear();
    const month = String(d.getMonth() + 1).padStart(2, '0');
    const day = String(d.getDate()).padStart(2, '0');
    return `${year}-${month}-${day}`;
  }
  
  canEditReceiptDate(): boolean {
    const isOpenStatus = this.transfer?.status === 'Ouvert' || this.transfer?.status === 'Open';
    return !this.isAdmin && isOpenStatus && !this.isReadOnly;
  }
  
  //  METHODE MODIFIEE: La date du jour est TOUJOURS préremplie
  startEditReceiptDate(): void {
    if (this.canEditReceiptDate()) {
      // Sauvegarder l'ancienne date
      this.originalReceiptDate = this.editableReceiptDate;
      
      //  TOUJOURS mettre la date d'aujourd'hui quand on clique sur modifier
      // Peu importe qu'il y ait une date existante ou non
      this.editableReceiptDate = this.getTodayDate();
      console.log('Date de reception preremplie avec la date du jour:', this.editableReceiptDate);
      
      // Activer le mode édition
      this.isEditingReceiptDate = true;
    }
  }
  
  cancelEditReceiptDate(): void {
    this.isEditingReceiptDate = false;
    this.editableReceiptDate = this.originalReceiptDate;
    this.updatingReceiptDate = false;
  }
  
  onReceiptDateChange(event: any): void {
    const newDate = event.target.value;
    if (newDate) {
      this.editableReceiptDate = newDate;
    }
  }
  
  validateReceiptDate(): void {
    if (!this.editableReceiptDate) {
      this.notificationService.showError('Veuillez selectionner une date');
      return;
    }
    
    const dateObj = new Date(this.editableReceiptDate);
    
    if (isNaN(dateObj.getTime())) {
      this.notificationService.showError('Date invalide');
      return;
    }
    
    this.updatingReceiptDate = true;
    
    this.transferService.updateReceiptDate(this.transfer!.id!, dateObj).pipe(
      takeUntil(this.destroy$),
      finalize(() => {
        this.updatingReceiptDate = false;
        this.cdr.detectChanges();
      })
    ).subscribe({
      next: () => {
        this.notificationService.showSuccess('Date de reception mise a jour');
        if (this.transfer) {
          this.transfer.receiptDate = dateObj;
        }
        this.editableReceiptDate = this.formatDateForInput(dateObj);
        this.originalReceiptDate = this.editableReceiptDate;
        this.isEditingReceiptDate = false;
        this.cdr.detectChanges();
      },
      error: (error) => {
        console.error('Erreur validateReceiptDate:', error);
        const errorMessage = error.error?.message || 'Erreur lors de la mise a jour de la date';
        this.notificationService.showError(errorMessage);
        this.editableReceiptDate = this.originalReceiptDate;
      }
    });
  }
}

export { TransferDetailComponent as TransferDetail };