// src/app/models/purchases/pages/request-detail/request-detail.ts

import { Component, OnInit, OnDestroy, ViewChild } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router, ActivatedRoute, RouterModule } from '@angular/router';
import { ReactiveFormsModule, FormBuilder, FormGroup } from '@angular/forms';
import { Subject, takeUntil, catchError, of, finalize } from 'rxjs';

// Angular Material Modules
import { MatCardModule } from '@angular/material/card';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatTableModule } from '@angular/material/table';
import { MatChipsModule } from '@angular/material/chips';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { MatTooltipModule } from '@angular/material/tooltip';
import { MatDividerModule } from '@angular/material/divider';
import { MatTabsModule } from '@angular/material/tabs';
import { MatExpansionModule } from '@angular/material/expansion';

// Services
import { PurchaseRequestService } from '../../services/purchase-request';
import { PurchaseRequestLineService } from '../../services/purchase-request-line.service';
import { NotificationService } from '../../../../core/services/notification';
import { AuthService } from '../../../../core/services/auth';

// Models
import { 
  PurchaseRequest, 
  PurchaseRequestStatus, 
  RequestType, 
  ServiceType,
  getStatusClass,
  getStatusLabel
} from '../../models/purchase-request.model';

import { 
  PurchaseRequestLine, 
  LineType 
} from '../../models/purchase-request-line.model';

import { ApprovalHistory } from '../../models/approval.model';

@Component({
  selector: 'app-request-detail',
  templateUrl: './request-detail.html',
  styleUrls: ['./request-detail.css'],
  standalone: true,
  imports: [
    CommonModule,
    ReactiveFormsModule,
    RouterModule,
    MatCardModule,
    MatButtonModule,
    MatIconModule,
    MatTableModule,
    MatChipsModule,
    MatProgressSpinnerModule,
    MatTooltipModule,
    MatDividerModule,
    MatTabsModule,
    MatExpansionModule
  ]
})
export class RequestDetail implements OnInit, OnDestroy {
  
  @ViewChild('stepper') stepper: any;
  
  // Données
  request: PurchaseRequest | null = null;
  lines: PurchaseRequestLine[] = [];
  approvalHistory: ApprovalHistory[] = [];
  
  // États
  loading: boolean = true;
  error: string | null = null;
  requestId: string | null = null;
  
  // Colonnes du tableau des lignes
  displayedColumns: string[] = ['type', 'no', 'description', 'quantity', 'unit', 'location', 'jobTask', 'engin', 'unitCost', 'lineAmount'];
  
  // Statuts pour les badges
  statusOptions = Object.values(PurchaseRequestStatus);
  
  private destroy$ = new Subject<void>();
  
  constructor(
    private router: Router,
    private route: ActivatedRoute,
    private purchaseRequestService: PurchaseRequestService,
    private purchaseRequestLineService: PurchaseRequestLineService,
    private notificationService: NotificationService,
    private authService: AuthService,
    private fb: FormBuilder
  ) {}
  
  ngOnInit(): void {
    this.requestId = this.route.snapshot.paramMap.get('id');
    if (this.requestId) {
      this.loadRequest(this.requestId);
      this.loadApprovalHistory(this.requestId);
    } else {
      this.error = 'ID de demande non trouvé';
      this.loading = false;
    }
  }
  
  ngOnDestroy(): void {
    this.destroy$.next();
    this.destroy$.complete();
  }
  
  loadRequest(id: string): void {
    this.loading = true;
    this.error = null;
    
    this.purchaseRequestService.getById(id).pipe(
      takeUntil(this.destroy$),
      finalize(() => {
        this.loading = false;
      }),
      catchError((error: any) => {
        console.error('Erreur chargement demande', error);
        this.error = 'Impossible de charger la demande';
        return of(null);
      })
    ).subscribe({
      next: (request: PurchaseRequest | null) => {
        if (request) {
          this.request = request;
          this.lines = request.purchaseRequestLines || [];
          console.log('✅ Demande chargée:', request.no);
        } else {
          this.error = 'Demande non trouvée';
        }
      }
    });
  }
  
  loadApprovalHistory(documentNo: string): void {
    // ✅ Correction: utiliser des strings au lieu de l'énumération
    this.approvalHistory = [
      {
        id: '1',
        documentNo: documentNo,
        approverId: 'MARTIN',
        approverName: 'Martin Dupont',
        approvalDate: new Date(),
        decision: 'Approuvé',  // ✅ String
        comment: 'Demande validée',
        level: 1
      }
    ];
  }
  
  // ==================== ACTIONS ====================
  
  editRequest(): void {
    if (this.requestId && this.canEdit()) {
      this.router.navigate(['/purchases/request', this.requestId, 'edit']);
    }
  }
  
  deleteRequest(): void {
    if (!this.request || !this.canDelete()) return;
    
    if (confirm(`Supprimer définitivement la demande ${this.request.no} ?`)) {
      this.loading = true;
      this.purchaseRequestService.delete(this.request.id).pipe(
        takeUntil(this.destroy$),
        finalize(() => {
          this.loading = false;
        }),
        catchError((error: any) => {
          console.error('Erreur suppression', error);
          this.notificationService.showError('Impossible de supprimer la demande');
          return of(null);
        })
      ).subscribe({
        next: () => {
          this.notificationService.showSuccess('Demande supprimée avec succès');
          this.router.navigate(['/purchases/requests']);
        }
      });
    }
  }
  
  approveRequest(): void {
    if (!this.request) return;
    
    this.notificationService.showConfirmation({
      title: 'Approbation',
      message: `Voulez-vous approuver la demande ${this.request.no} ?`,
      confirmText: 'Approuver',
      cancelText: 'Annuler',
      confirmColor: 'primary'
    }).subscribe(confirmed => {
      if (confirmed) {
        // Appel API d'approbation
        this.notificationService.showSuccess('Demande approuvée avec succès');
        this.loadRequest(this.request!.id);
      }
    });
  }
  
  refuseRequest(): void {
    if (!this.request) return;
    
    this.notificationService.showConfirmation({
      title: 'Refus',
      message: `Voulez-vous refuser la demande ${this.request.no} ?`,
      confirmText: 'Refuser',
      cancelText: 'Annuler',
      confirmColor: 'warn'
    }).subscribe(confirmed => {
      if (confirmed) {
        // Appel API de refus
        this.notificationService.showSuccess('Demande refusée');
        this.loadRequest(this.request!.id);
      }
    });
  }
  
  generatePurchaseOrder(): void {
    if (!this.request) return;
    
    this.notificationService.showConfirmation({
      title: 'Génération de commande',
      message: `Générer une commande fournisseur pour la demande ${this.request.no} ?`,
      confirmText: 'Générer',
      cancelText: 'Annuler',
      confirmColor: 'primary'
    }).subscribe(confirmed => {
      if (confirmed) {
        // Appel API de génération de commande
        this.notificationService.showSuccess('Commande générée avec succès');
      }
    });
  }
  
  goBack(): void {
    this.router.navigate(['/purchases/requests']);
  }
  
  // ==================== UTILITAIRES ====================
  
  getStatusClass(status: string): string {
    return getStatusClass(status);
  }
  
  getStatusLabel(status: string): string {
    return getStatusLabel(status);
  }
  
  formatDate(date: Date | string): string {
    if (!date) return '—';
    const d = new Date(date);
    return d.toLocaleDateString('fr-FR');
  }
  
  formatDateTime(date: Date | string): string {
    if (!date) return '—';
    const d = new Date(date);
    return d.toLocaleDateString('fr-FR') + ' à ' + d.toLocaleTimeString('fr-FR', { hour: '2-digit', minute: '2-digit' });
  }
  
  formatAmount(amount: number): string {
    if (!amount && amount !== 0) return '—';
    return new Intl.NumberFormat('fr-FR', { 
      minimumFractionDigits: 2, 
      maximumFractionDigits: 2 
    }).format(amount) + ' FCFA';
  }
  
  isOverdue(dueDate: Date | string): boolean {
    if (!dueDate) return false;
    const today = new Date();
    today.setHours(0, 0, 0, 0);
    const due = new Date(dueDate);
    due.setHours(0, 0, 0, 0);
    return due < today;
  }
  
  canEdit(): boolean {
    if (!this.request) return false;
    const currentUser = this.authService.getCurrentUser();
    const isApprover = this.authService.isApprover();
    return this.request.status === PurchaseRequestStatus.OPEN && 
           (this.request.requesterId === currentUser?.id || isApprover);
  }
  
  canDelete(): boolean {
    if (!this.request) return false;
    const currentUser = this.authService.getCurrentUser();
    return this.request.status === PurchaseRequestStatus.OPEN && 
           this.request.requesterId === currentUser?.id;
  }
  
  canApprove(): boolean {
    if (!this.request) return false;
    const isApprover = this.authService.isApprover();
    // ✅ Correction: utiliser IN_PROGRESS au lieu de APPROVED
    return this.request.status === PurchaseRequestStatus.IN_PROGRESS && isApprover;
  }
  
  canGenerateOrder(): boolean {
    if (!this.request) return false;
    const isApprover = this.authService.isApprover();
    // ✅ Correction: utiliser APPROVED après l'avoir ajouté dans l'énumération
    return this.request.status === (PurchaseRequestStatus as any).APPROVED && isApprover;
  }
  
  getTotalAmount(): number {
    return this.lines.reduce((sum, line) => sum + (line.lineAmount || 0), 0);
  }
  
  getStatusIcon(status: string): string {
    switch (status) {
      case 'Ouvert': return 'pending';
      case 'Lancé': return 'play_circle';
      case 'Approuvé': return 'check_circle';
      case 'Partiellement Pris En Charge': return 'hourglass_empty';
      case 'Totallement Pris En Charge': return 'check_circle';
      case 'Archiver': return 'archive';
      default: return 'info';
    }
  }
  
  getTypeIcon(type: string): string {
    switch (type) {
      case 'Item': return 'inventory_2';
      case 'Fixed Asset': return 'handyman';
      case 'G/L Account': return 'account_balance';
      case 'Resource': return 'people';
      default: return 'category';
    }
  }
}

export { RequestDetail as RequestDetailComponent };