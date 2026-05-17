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
  
  quantityToReceiveMap: Map<string, number> = new Map();
  
  private destroy$ = new Subject<void>();
  
  constructor(
    private router: Router,
    private route: ActivatedRoute,
    private transferService: TransferService,
    private notificationService: NotificationService,
    private authService: AuthService,
    private cdr: ChangeDetectorRef,
    private toastr: ToastrService,
    private appMode: AppModeService
  ) {}
  
  ngOnInit(): void {
    // ✅ S'abonner au mode offline
    this.appMode.mode$
      .pipe(takeUntil(this.destroy$))
      .subscribe(mode => {
        this.isReadOnly = mode === 'offline-readonly';
        console.log('🔔 Mode transfer-detail:', this.isReadOnly ? 'offline-readonly' : 'online');
        this.cdr.detectChanges();
      });
    
    this.isAdmin = this.authService.isApprover();
    this.transferId = this.route.snapshot.paramMap.get('id');
    
    if (this.transferId) {
      this.loadTransfer();
    } else {
      this.error = 'ID de transfert non trouvé';
      this.loading = false;
    }
  }
  
  ngOnDestroy(): void {
    this.destroy$.next();
    this.destroy$.complete();
  }
  
  loadTransfer(): void {
    if (!this.transferId) return;
    
    this.loading = true;
    this.error = null;
    
    this.transferService.getById(this.transferId).pipe(
      takeUntil(this.destroy$),
      finalize(() => {
        this.loading = false;
        this.cdr.detectChanges();
      }),
      catchError((error) => {
        console.error('❌ Erreur:', error);
        if (!this.isReadOnly) {
          this.error = 'Impossible de charger le transfert';
        } else {
          this.toastr.warning('Transfert non disponible hors ligne', 'Mode lecture seule');
        }
        return of(null);
      })
    ).subscribe({
      next: (transfer) => {
        if (transfer) {
          this.transfer = transfer;
          if (transfer.transferLines) {
            transfer.transferLines.forEach(line => {
              if (line.id) {
                this.quantityToReceiveMap.set(line.id, 0);
              }
            });
          }
        } else if (!this.error) {
          this.error = 'Transfert non trouvé';
        }
      }
    });
  }
  
  getRemainingQuantity(line: TransferLine): number {
    return (line.quantity || 0) - (line.quantityReceived || 0);
  }
  
  getTotalToReceive(): number {
    if (!this.transfer?.transferLines) return 0;
    
    let total = 0;
    for (const line of this.transfer.transferLines) {
      const qty = this.quantityToReceiveMap.get(line.id!) || 0;
      total += qty;
    }
    return total;
  }
  
  onQuantityInputChange(event: any, line: TransferLine): void {
    const value = parseInt(event.target.value, 10);
    const quantity = isNaN(value) ? 0 : value;
    const remaining = this.getRemainingQuantity(line);
    
    if (quantity < 0) {
      this.quantityToReceiveMap.set(line.id!, 0);
      event.target.value = 0;
      this.notificationService.showError('La quantité ne peut pas être négative');
      return;
    }
    
    if (quantity > remaining) {
      this.quantityToReceiveMap.set(line.id!, remaining);
      event.target.value = remaining;
      this.notificationService.showError(`La quantité ne peut pas dépasser ${remaining}`);
      return;
    }
    
    this.quantityToReceiveMap.set(line.id!, quantity);
    this.cdr.detectChanges();
  }
  
  getQuantityToReceive(lineId: string): number {
    return this.quantityToReceiveMap.get(lineId) || 0;
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
    
    const quantityToReceive = this.quantityToReceiveMap.get(line.id!) || 0;
    
    if (quantityToReceive <= 0) {
      this.notificationService.showWarning('Veuillez saisir une quantité valide');
      return;
    }
    
    if (!line.id) {
      this.notificationService.showError('ID de ligne non trouvé');
      return;
    }
    
    this.submitting = true;
    
    this.transferService.updateLineQuantity(line.id, quantityToReceive).pipe(
      takeUntil(this.destroy$),
      finalize(() => {
        this.submitting = false;
        this.cdr.detectChanges();
      })
    ).subscribe({
      next: () => {
        this.notificationService.showSuccess('Quantité réceptionnée avec succès');
        this.quantityToReceiveMap.set(line.id!, 0);
        this.loadTransfer();
      },
      error: (error) => {
        console.error('❌ Erreur:', error);
        this.notificationService.showError('Erreur lors de la réception');
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
      this.notificationService.showWarning('Aucune quantité à réceptionner');
      return;
    }
    
    for (const line of this.transfer.transferLines || []) {
      const qty = this.quantityToReceiveMap.get(line.id!) || 0;
      const remaining = this.getRemainingQuantity(line);
      if (qty > remaining) {
        this.notificationService.showError(`La quantité pour l'article ${line.itemNo} dépasse le reste à recevoir`);
        return;
      }
    }
    
    this.notificationService.showConfirmation({
      title: 'Réception complète',
      message: `Confirmer la réception de ${totalToReceive} article(s) ?`,
      confirmText: 'Valider',
      cancelText: 'Annuler'
    }).subscribe(confirmed => {
      if (confirmed) {
        this.submitting = true;
        
        this.transferService.receiveTransfer(this.transfer!.id!).pipe(
          takeUntil(this.destroy$),
          finalize(() => {
            this.submitting = false;
            this.cdr.detectChanges();
          })
        ).subscribe({
          next: () => {
            this.notificationService.showSuccess('Transfert réceptionné avec succès');
            this.router.navigate(['/transfers']);
          },
          error: (error) => {
            console.error('❌ Erreur:', error);
            this.notificationService.showError('Erreur lors de la réception');
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
            this.notificationService.showSuccess('Transfert supprimé avec succès');
            this.router.navigate(['/transfers']);
          },
          error: (error) => {
            console.error('❌ Erreur:', error);
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
      title: 'Expédition',
      message: `Confirmer l'expédition du transfert ${this.transfer.no} ?`,
      confirmText: 'Expédier',
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
            this.notificationService.showSuccess('Transfert expédié avec succès');
            this.loadTransfer();
          },
          error: (error) => {
            console.error('❌ Erreur:', error);
            this.notificationService.showError('Erreur lors de l\'expédition');
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
    return d.toLocaleDateString('fr-FR', {
      day: '2-digit',
      month: '2-digit',
      year: 'numeric'
    });
  }
}

export { TransferDetailComponent as TransferDetail };