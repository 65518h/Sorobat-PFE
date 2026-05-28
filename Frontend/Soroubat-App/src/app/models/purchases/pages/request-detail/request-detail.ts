// src/app/modules/purchases/pages/request-detail/request-detail.ts

import { Component, OnInit, OnDestroy, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router, ActivatedRoute, RouterModule } from '@angular/router';
import { ReactiveFormsModule, FormBuilder, FormGroup } from '@angular/forms';
import { Subject, takeUntil, catchError, of, finalize, forkJoin } from 'rxjs';

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
import { ToastrService } from 'ngx-toastr';

import { PurchaseRequestService } from '../../services/purchase-request';
import { LookupService, Vehicule, Item, Immobilisation, ProjectTask, Location } from '../../services/lookup.service';
import { NotificationService } from '../../../../core/services/notification';
import { AuthService } from '../../../../core/services/auth';
import { AppModeService } from '../../../../core/services/app-mode.service';
import { OfflineHideActionsDirective } from '../../../../core/directives/offline-hide-actions.directive';
import { ShowOfflineMessageDirective } from '../../../../core/directives/show-offline-message.directive';

import { 
  PurchaseRequest, 
  getStatusClass,
  getStatusLabel,
  getStatusIcon,
  canSubmitToApprove,
  canApprove,
  canEdit,
  canDelete
} from '../../models/purchase-request.model';

import { 
  PurchaseRequestLine,
  getLineTypeIcon,
  getLineTypeLabel
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
    MatExpansionModule,
    OfflineHideActionsDirective,
    ShowOfflineMessageDirective
  ]
})
export class RequestDetailComponent implements OnInit, OnDestroy {
  
  request: PurchaseRequest | null = null;
  lines: PurchaseRequestLine[] = [];
  approvalHistory: ApprovalHistory[] = [];
  
  loading: boolean = true;
  error: string | null = null;
  requestId: string | null = null;
  isReadOnly: boolean = false;
  
  enginDescription: string = '';
  currentProjectTasks: ProjectTask[] = [];
  locations: Location[] = [];
  
  // Cache des magasins
  locationsCache: Map<string, string> = new Map();
  
  private destroy$ = new Subject<void>();
  
  constructor(
    private router: Router,
    private route: ActivatedRoute,
    private purchaseRequestService: PurchaseRequestService,
    private lookupService: LookupService,
    private notificationService: NotificationService,
    private authService: AuthService,
    private fb: FormBuilder,
    private cdr: ChangeDetectorRef,
    private toastr: ToastrService,
    private appMode: AppModeService
  ) {}
  
  ngOnInit(): void {
    //  S'abonner au mode offline
    this.appMode.mode$
      .pipe(takeUntil(this.destroy$))
      .subscribe(mode => {
        this.isReadOnly = mode === 'offline-readonly';
        console.log(' Mode request-detail:', this.isReadOnly ? 'offline-readonly' : 'online');
        this.cdr.detectChanges();
      });
    
    this.requestId = this.route.snapshot.paramMap.get('id');
    console.log(' ID récupéré depuis URL:', this.requestId);
    
    if (this.requestId) {
      this.loadRequestByIdentifier(this.requestId);
      this.loadApprovalHistory(this.requestId);
      this.loadLocations();
    } else {
      this.error = 'ID de demande non trouvé';
      this.loading = false;
    }
  }
  
  ngOnDestroy(): void {
    this.destroy$.next();
    this.destroy$.complete();
  }
  
  /**
   * Charge les magasins
   */
  private loadLocations(): void {
    this.lookupService.getLocations().pipe(
      takeUntil(this.destroy$),
      catchError((error) => {
        console.error(' Erreur chargement magasins:', error);
        return of([]);
      })
    ).subscribe({
      next: (locations: Location[]) => {
        this.locations = locations || [];
        // Remplir le cache des magasins
        this.locations.forEach(location => {
          if (location.code) {
            this.locationsCache.set(location.code, location.name);
          }
        });
        console.log(' Magasins chargés:', this.locations.length);
        this.cdr.detectChanges();
      }
    });
  }
  
  /**
   * Récupère le nom du magasin à partir de son code
   */
  getLocationName(locationCode: string): string {
    if (!locationCode) return '';
    return this.locationsCache.get(locationCode) || '';
  }
  
  /**
   * Charge une demande par son identifiant
   */
  loadRequestByIdentifier(identifier: string): void {
    const isGuid = /^[0-9a-f]{8}-([0-9a-f]{4}-){3}[0-9a-f]{12}$/i.test(identifier);
    
    if (isGuid) {
      this.loadRequest(identifier);
    } else {
      this.loadRequest(identifier);
    }
  }
  
  loadRequest(id: string): void {
    if (!id) return;
    
    this.loading = true;
    this.error = null;
    
    console.log(' Chargement demande avec ID:', id);
  
    this.purchaseRequestService.getById(id).pipe(
      takeUntil(this.destroy$),
      finalize(() => {
        this.loading = false;
        this.cdr.detectChanges();
      }),
      catchError((error) => {
        console.error(' Erreur chargement demande:', error);
        this.error = error.message || 'Impossible de charger la demande';
        return of(null);
      })
    ).subscribe({
      next: (request) => {
        if (request) {
          this.request = request;
          
          console.log(' Demande chargée:', request);
          
          //  Charger les tâches du projet si un projet est associé
          if (request.jobNo) {
            this.loadProjectTasks(request.jobNo);
          }
          
          if (request.purchaseRequestLines && request.purchaseRequestLines.length > 0) {
            this.lines = request.purchaseRequestLines;
            console.log(' Lignes chargées:', this.lines.length);
          } else {
            this.lines = [];
            console.log(' Aucune ligne pour cette demande');
          }
          
          // Récupérer la description de l'engin si un code engin est présent
          if (request.engin) {
            this.getEnginDescription(request.engin);
          }
          
          this.cdr.detectChanges();
        } else if (!this.error) {
          this.error = 'Demande non trouvée';
        }
      }
    });
  }
  
  /**
   * Charge les tâches d'un projet
   */
  private loadProjectTasks(projectNo: string): void {
    if (!projectNo) {
      return;
    }
    
    console.log(' Chargement des tâches pour le projet:', projectNo);
    
    this.lookupService.getProjectTasks(projectNo).pipe(
      takeUntil(this.destroy$),
      catchError((error) => {
        console.error(' Erreur chargement tâches projet:', error);
        return of([]);
      })
    ).subscribe({
      next: (tasks: ProjectTask[]) => {
        this.currentProjectTasks = tasks || [];
        console.log(` ${this.currentProjectTasks.length} tâches chargées`);
        this.cdr.detectChanges();
      }
    });
  }
  
  /**
   * Affiche le libellé de la tâche
   */
  getTaskDisplay(jobTaskNo: string | number | undefined): string {
    if (!jobTaskNo || jobTaskNo === '0' || jobTaskNo === 0) {
      return 'Tâche par défaut';
    }
    
    if (this.currentProjectTasks && this.currentProjectTasks.length > 0) {
      const task = this.currentProjectTasks.find(t => t.taskNo === String(jobTaskNo));
      if (task && task.description) {
        return `${jobTaskNo} - ${task.description}`;
      }
    }
    
    return String(jobTaskNo);
  }
  
  private getEnginDescription(enginCode: string): void {
    this.lookupService.getVehicules().pipe(
      takeUntil(this.destroy$),
      catchError((error) => {
        console.error(' Erreur chargement description engin:', error);
        return of([]);
      })
    ).subscribe({
      next: (vehicules: Vehicule[]) => {
        const engin = vehicules.find(v => v.code === enginCode);
        if (engin && engin.designation) {
          this.enginDescription = engin.designation;
          console.log(` Description engin trouvée: ${enginCode} -> ${this.enginDescription}`);
        } else {
          this.enginDescription = '';
        }
        this.cdr.detectChanges();
      }
    });
  }
  
  loadApprovalHistory(documentNo: string): void {
    // À implémenter avec l'API si nécessaire
    this.approvalHistory = [];
  }
  
  goBack(): void {
    this.router.navigate(['/purchases/requests']);
  }
  
  editRequest(): void {
    if (this.isReadOnly) {
      this.toastr.warning('Modification indisponible en mode hors ligne', 'Action indisponible');
      return;
    }
    
    if (this.canEdit() && this.request) {
      if (this.canEdit()) {
        this.router.navigate(['/purchases/request', this.request.id, 'edit']);
      } else {
        this.notificationService.showWarning('Seules les demandes ouvertes peuvent être modifiées');
      }
    } else {
      if (!this.request) {
        this.notificationService.showError('Demande non trouvée');
      } else if (!this.canEdit()) {
        this.notificationService.showWarning('Cette demande ne peut pas être modifiée');
      }
    }
  }
  
  deleteRequest(): void {
    if (this.isReadOnly) {
      this.toastr.warning('Suppression indisponible en mode hors ligne', 'Action indisponible');
      return;
    }
    
    if (!this.request?.id) {
      this.notificationService.showError('ID de demande non trouvé');
      return;
    }
    
    if (!this.canDelete()) {
      this.notificationService.showWarning('Vous ne pouvez pas supprimer cette demande');
      return;
    }
    
    if (confirm(`Supprimer définitivement la demande ${this.request?.no} ?`)) {
      this.loading = true;
      this.purchaseRequestService.delete(this.request.id).pipe(
        takeUntil(this.destroy$),
        finalize(() => {
          this.loading = false;
          this.cdr.detectChanges();
        })
      ).subscribe({
        next: () => {
          this.notificationService.showSuccess('Demande supprimée avec succès');
          this.router.navigate(['/purchases/requests']);
        },
        error: (error) => {
          console.error('Erreur suppression', error);
          this.notificationService.showError('Impossible de supprimer la demande');
        }
      });
    }
  }
  
  // src/app/modules/purchases/pages/request-detail/request-detail.ts

/**
 * Soumet une demande à l'approbation
 * POST /api/PurchaseRequest/{id}/submit
 */
submitToApprove(): void {
  if (this.isReadOnly) {
    this.toastr.warning('Action indisponible en mode hors ligne', 'Action indisponible');
    return;
  }
  
  if (!this.request?.id) {
    this.notificationService.showError('ID de demande non trouvé');
    return;
  }
  
  const id = this.request.id;
  const requestNo = this.request.no;
  
  this.notificationService.showConfirmation({
    title: 'Soumission à approbation',
    message: `Voulez-vous soumettre la demande ${requestNo} à l'approbation ?`,
    confirmText: 'Soumettre',
    cancelText: 'Annuler',
    confirmColor: 'primary'
  }).subscribe(confirmed => {
    if (confirmed) {
      this.loading = true;
      this.cdr.detectChanges();
      
      //  Appeler directement submitToApprove() comme dans la liste
      this.purchaseRequestService.submitToApprove(id).pipe(
        takeUntil(this.destroy$),
        finalize(() => {
          this.loading = false;
          this.cdr.detectChanges();
        })
      ).subscribe({
        next: (updatedRequest) => {
          if (updatedRequest) {
            // Mettre à jour la demande
            this.request = updatedRequest;
            this.lines = updatedRequest.purchaseRequestLines || [];
            this.cdr.detectChanges();
          } else {
            // Fallback: recharger la demande
            this.loadRequest(id);
          }
          this.notificationService.showSuccess(`Demande ${requestNo} soumise à l'approbation avec succès`);
          this.toastr.success(` Demande ${requestNo} soumise avec succès !`, 'Demande envoyée');
        },
        error: (error) => {
          console.error('Erreur soumission:', error);
          this.notificationService.showError('Impossible de soumettre la demande');
          this.toastr.error(` Erreur lors de la soumission de la demande ${requestNo}`, 'Échec');
        }
      });
    }
  });
}
  
  approveRequest(): void {
    if (this.isReadOnly) {
      this.toastr.warning('Action indisponible en mode hors ligne', 'Action indisponible');
      return;
    }
    
    if (!this.request?.id) return;
    
    this.notificationService.showConfirmation({
      title: 'Approbation',
      message: `Voulez-vous approuver la demande ${this.request.no} ?`,
      confirmText: 'Approuver',
      cancelText: 'Annuler',
      confirmColor: 'primary'
    }).subscribe(confirmed => {
      if (confirmed) {
        this.purchaseRequestService.updateStatus(this.request!.id!, 'En cours').pipe(
          takeUntil(this.destroy$)
        ).subscribe({
          next: () => {
            this.notificationService.showSuccess('Demande approuvée avec succès');
            if (this.request?.id) {
              this.loadRequest(this.request.id);
            }
          },
          error: (error) => {
            console.error('Erreur lors de l\'approbation', error);
            this.notificationService.showError('Impossible d\'approuver la demande');
          }
        });
      }
    });
  }
  
  rejectRequest(): void {
    if (this.isReadOnly) {
      this.toastr.warning('Action indisponible en mode hors ligne', 'Action indisponible');
      return;
    }
    
    if (!this.request?.id) return;
    
    this.notificationService.showConfirmation({
      title: 'Refus',
      message: `Voulez-vous refuser la demande ${this.request.no} ?`,
      confirmText: 'Refuser',
      cancelText: 'Annuler',
      confirmColor: 'warn'
    }).subscribe(confirmed => {
      if (confirmed) {
        this.purchaseRequestService.updateStatus(this.request!.id!, 'Refusé').pipe(
          takeUntil(this.destroy$)
        ).subscribe({
          next: () => {
            this.notificationService.showSuccess('Demande refusée');
            if (this.request?.id) {
              this.loadRequest(this.request.id);
            }
          },
          error: (error) => {
            console.error('Erreur lors du refus', error);
            this.notificationService.showError('Impossible de refuser la demande');
          }
        });
      }
    });
  }
  
  generatePurchaseOrder(): void {
    if (this.isReadOnly) {
      this.toastr.warning('Action indisponible en mode hors ligne', 'Action indisponible');
      return;
    }
    
    if (!this.request) return;
    
    this.notificationService.showConfirmation({
      title: 'Génération de commande',
      message: `Générer une commande fournisseur pour la demande ${this.request.no} ?`,
      confirmText: 'Générer',
      cancelText: 'Annuler',
      confirmColor: 'primary'
    }).subscribe(confirmed => {
      if (confirmed) {
        this.notificationService.showSuccess('Commande générée avec succès');
      }
    });
  }
  
  // ─── STATUS HELPERS ──────────────────────────────────────────────────────────

  getStatusClass(status: string | undefined): string {
    return getStatusClass(status);
  }

  getStatusLabel(status: string | undefined): string {
    return getStatusLabel(status);
  }

  getStatusIcon(status: string | undefined): string {
    return getStatusIcon(status);
  }
  
  // ─── DATE HELPERS ────────────────────────────────────────────────────────────

  isValidDate(dateStr: string | Date | null | undefined): boolean {
    if (!dateStr) return false;

    const str = typeof dateStr === 'string' ? dateStr.trim() : '';
    if (str === '' || str === '0001-01-01' || str === '0001-01-01T00:00:00') {
      return false;
    }

    const date = new Date(dateStr);
    if (isNaN(date.getTime())) return false;
    if (date.getFullYear() < 1900) return false;

    return true;
  }

  formatDate(date: string | Date | undefined | null): string {
    if (!this.isValidDate(date)) return '—';
    const d = new Date(date!);
    return d.toLocaleDateString('fr-FR', {
      day: '2-digit',
      month: '2-digit',
      year: 'numeric'
    });
  }

  // ─── PERMISSIONS ─────────────────────────────────────────────────────────────

  canEdit(): boolean {
    if (this.isReadOnly) return false;
    return canEdit(this.request?.statut);
  }
  
  canDelete(): boolean {
    if (this.isReadOnly) return false;
    if (!this.request) return false;
    const currentUser = this.authService.getCurrentUser();
    return canDelete(this.request.statut, '', currentUser?.name || '');
  }
  
  canSubmitToApprove(): boolean {
    if (this.isReadOnly) return false;
    if (!this.request) return false;
    return canSubmitToApprove(this.request.statut);
  }
  
  canApprove(): boolean {
    if (this.isReadOnly) return false;
    if (!this.request) return false;
    const isApprover = this.authService.isApprover();
    return canApprove(this.request.statut) && isApprover;
  }
  
  canGenerateOrder(): boolean {
    if (this.isReadOnly) return false;
    if (!this.request) return false;
    const isApprover = this.authService.isApprover();
    const isCompleted = this.request.statut === 'Totallement Pris En Charge';
    return isCompleted && isApprover;
  }

  // Types pour l'affichage
  getTypeLabel(type: string | undefined): string {
    return getLineTypeLabel(type);
  }

  getTypeIcon(type: string | undefined): string {
    return getLineTypeIcon(type);
  }

getStatusClassForBadge(status: string | undefined): string {
  if (!status) return 'unknown';
  
  const statusLower = status.toLowerCase();
  if (statusLower === 'ouvert') return 'open';
  if (statusLower === 'released') return 'to-approve';
  if (statusLower === 'approved') return 'approved';  
  if (statusLower === 'en cours') return 'in-progress';
  if (statusLower === 'totallement pris en charge') return 'complete';
  if (statusLower === 'fully supported') return 'complete';  
  if (statusLower === 'refusé') return 'rejected';
  
  return 'unknown';
}
}

export { RequestDetailComponent as RequestDetail };