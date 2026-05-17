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
  PurchaseRequestLine
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
  
  // Cache des articles pour les descriptions
  itemsCache: Map<string, string> = new Map();
  // Cache des immobilisations pour les descriptions
  immobilisationsCache: Map<string, string> = new Map();
  // Cache des magasins
  locationsCache: Map<string, string> = new Map();
  
  displayedColumns: string[] = ['type', 'no', 'description', 'quantity', 'unit', 'location', 'jobTask', 'engin', 'lineAmount'];
  
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
    // ✅ S'abonner au mode offline
    this.appMode.mode$
      .pipe(takeUntil(this.destroy$))
      .subscribe(mode => {
        this.isReadOnly = mode === 'offline-readonly';
        console.log('🔔 Mode request-detail:', this.isReadOnly ? 'offline-readonly' : 'online');
        this.cdr.detectChanges();
      });
    
    this.requestId = this.route.snapshot.paramMap.get('id');
    console.log('📌 ID/N° récupéré depuis URL:', this.requestId);
    
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
        console.error('❌ Erreur chargement magasins:', error);
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
        console.log('✅ Magasins chargés:', this.locations.length);
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
   * Charge une demande par son identifiant (GUID ou numéro)
   */
  loadRequestByIdentifier(identifier: string): void {
    const isGuid = /^[0-9a-f]{8}-([0-9a-f]{4}-){3}[0-9a-f]{12}$/i.test(identifier);
    
    if (isGuid) {
      this.loadRequest(identifier);
    } else {
      this.findAndLoadRequestByNo(identifier);
    }
  }
  
  /**
   * Trouve une demande par son numéro puis la charge
   */
  private findAndLoadRequestByNo(requestNo: string): void {
    this.loading = true;
    this.error = null;
    
    console.log('📡 Recherche de la demande par numéro:', requestNo);
    
    this.purchaseRequestService.getAll().pipe(
      takeUntil(this.destroy$),
      catchError((error) => {
        console.error('❌ Erreur recherche demande:', error);
        this.error = 'Impossible de trouver la demande';
        this.loading = false;
        this.cdr.detectChanges();
        return of([]);
      })
    ).subscribe({
      next: (requests) => {
        const foundRequest = requests.find(r => r.no === requestNo);
        
        if (foundRequest && foundRequest.id) {
          console.log('✅ Demande trouvée avec ID:', foundRequest.id);
          this.loadRequest(foundRequest.id);
        } else {
          console.error('❌ Demande non trouvée pour le numéro:', requestNo);
          this.loading = false;
          this.error = `Demande ${requestNo} non trouvée`;
          this.cdr.detectChanges();
        }
      },
      error: (error) => {
        console.error('❌ Erreur:', error);
        this.loading = false;
        this.error = 'Erreur lors de la recherche';
        this.cdr.detectChanges();
      }
    });
  }
  
  loadRequest(id: string): void {
    if (!id) return;
    
    this.loading = true;
    this.error = null;
    
    console.log('📡 Chargement demande avec ID:', id);
  
    this.purchaseRequestService.getById(id).pipe(
      takeUntil(this.destroy$),
      finalize(() => {
        this.loading = false;
        this.cdr.detectChanges();
      }),
      catchError((error) => {
        console.error('❌ Erreur chargement demande:', error);
        this.error = error.message || 'Impossible de charger la demande';
        return of(null);
      })
    ).subscribe({
      next: (request) => {
        if (request) {
          this.request = request;
          
          console.log('📋 Demande chargée:', request);
          console.log('📋 Statut reçu de l\'API:', request.status);
          
          // ✅ Charger les tâches du projet si un projet est associé
          if (request.jobNo) {
            this.loadProjectTasks(request.jobNo);
          }
          
          if (request.purchaseRequestLines && request.purchaseRequestLines.length > 0) {
            this.lines = request.purchaseRequestLines;
            console.log('✅ Lignes chargées depuis l\'en-tête:', this.lines.length);
            
            // ✅ Vérifier si des descriptions sont manquantes (articles et immobilisations)
            this.checkAndLoadMissingData();
          } else {
            this.lines = [];
            console.log('ℹ️ Aucune ligne pour cette demande');
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
      console.warn('⚠️ loadProjectTasks appelé sans projectNo');
      return;
    }
    
    console.log('🔍 Chargement des tâches pour le projet:', projectNo);
    
    this.lookupService.getProjectTasks(projectNo).pipe(
      takeUntil(this.destroy$),
      catchError((error) => {
        console.error('❌ Erreur chargement tâches projet:', error);
        return of([]);
      })
    ).subscribe({
      next: (tasks: ProjectTask[]) => {
        this.currentProjectTasks = tasks || [];
        console.log(`✅ ${this.currentProjectTasks.length} tâches chargées pour le projet:`, projectNo);
        this.cdr.detectChanges();
      }
    });
  }
  
  /**
   * Affiche le libellé de la tâche avec son numéro
   */
  getTaskDisplay(jobTaskNo: string | number | undefined): string {
    if (!jobTaskNo || jobTaskNo === '0' || jobTaskNo === 0) {
      return 'Tâche par défaut';
    }
    
    // Chercher la tâche dans la liste des tâches du projet
    if (this.currentProjectTasks && this.currentProjectTasks.length > 0) {
      const task = this.currentProjectTasks.find(t => t.taskNo === String(jobTaskNo));
      if (task && task.description) {
        return `${jobTaskNo} - ${task.description}`;
      }
    }
    
    return String(jobTaskNo);
  }
  
  /**
   * Vérifie et charge les descriptions et unités manquantes pour les articles ET les immobilisations
   */
  private checkAndLoadMissingData(): void {
    // Identifier les lignes sans description ou sans unité
    const linesMissingData = this.lines.filter(line => 
      (!line.description && line.no) || (!line.unitOfMeasureCode && line.no)
    );
    
    if (linesMissingData.length === 0) {
      console.log('✅ Toutes les descriptions et unités sont déjà présentes');
      return;
    }
    
    console.log(`📝 ${linesMissingData.length} ligne(s) avec données manquantes à charger`);
    
    // Séparer les articles des immobilisations
    const itemsToLoad = linesMissingData.filter(line => line.type === 'Item');
    const immobilisationsToLoad = linesMissingData.filter(line => line.type === 'Fixed Asset' || line.type === 'Fixed_x0020_Asset');
    
    console.log(`📦 Articles à charger: ${itemsToLoad.length}`);
    console.log(`🏗️ Immobilisations à charger: ${immobilisationsToLoad.length}`);
    
    // Charger les deux en parallèle
    forkJoin({
      items: this.lookupService.getItems(),
      immobilisations: this.lookupService.getImmobilisations()
    }).pipe(
      takeUntil(this.destroy$)
    ).subscribe({
      next: (result) => {
        // Créer des maps pour accès rapide
        const itemsMap = new Map<string, Item>();
        result.items.forEach(item => {
          if (item.number) {
            itemsMap.set(item.number, item);
          }
        });
        
        const immobilisationsMap = new Map<string, Immobilisation>();
        result.immobilisations.forEach(imm => {
          if (imm.number) {
            immobilisationsMap.set(imm.number, imm);
          }
        });
        
        let updatedCount = 0;
        
        // Mettre à jour les articles
        for (const line of itemsToLoad) {
          const item = itemsMap.get(line.no || '');
          if (item) {
            if (!line.description && item.displayName) {
              line.description = item.displayName;
              updatedCount++;
              console.log(`✅ Description article trouvée pour ${line.no}: ${item.displayName}`);
            }
            if (!line.unitOfMeasureCode && item.baseUnitOfMeasure) {
              line.unitOfMeasureCode = item.baseUnitOfMeasure;
              updatedCount++;
              console.log(`✅ Unité article trouvée pour ${line.no}: ${item.baseUnitOfMeasure}`);
            }
          } else {
            console.log(`⚠️ Aucune information trouvée pour l'article: ${line.no}`);
          }
        }
        
        // Mettre à jour les immobilisations
        for (const line of immobilisationsToLoad) {
          const immobilisation = immobilisationsMap.get(line.no || '');
          if (immobilisation) {
            if (!line.description && immobilisation.displayName) {
              line.description = immobilisation.displayName;
              updatedCount++;
              console.log(`✅ Description immobilisation trouvée pour ${line.no}: ${immobilisation.displayName}`);
            }
            // Les immobilisations n'ont pas d'unité par défaut
            if (!line.unitOfMeasureCode) {
              line.unitOfMeasureCode = 'PIECE';
              updatedCount++;
            }
          } else {
            console.log(`⚠️ Aucune information trouvée pour l'immobilisation: ${line.no}`);
          }
        }
        
        console.log(`✅ ${updatedCount} information(s) chargée(s) avec succès`);
        this.cdr.detectChanges();
      },
      error: (error) => {
        console.error('❌ Erreur chargement des données:', error);
      }
    });
  }
  
  private getEnginDescription(enginCode: string): void {
    this.lookupService.getVehicules().pipe(
      takeUntil(this.destroy$),
      catchError((error) => {
        console.error('❌ Erreur chargement description engin:', error);
        return of([]);
      })
    ).subscribe({
      next: (vehicules: Vehicule[]) => {
        const engin = vehicules.find(v => v.code === enginCode);
        if (engin && engin.designation) {
          this.enginDescription = engin.designation;
          console.log(`✅ Description engin trouvée pour ${enginCode}:`, this.enginDescription);
        } else {
          this.enginDescription = '';
          console.log(`ℹ️ Aucune description trouvée pour l'engin: ${enginCode}`);
        }
        this.cdr.detectChanges();
      }
    });
  }
  
  loadApprovalHistory(documentNo: string): void {
    this.approvalHistory = [
      {
        id: '1',
        documentNo: documentNo,
        approverId: 'MARTIN',
        approverName: 'Martin Dupont',
        approvalDate: new Date(),
        decision: 'Approuvé',
        comment: 'Demande validée',
        level: 1
      }
    ];
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
      const isOpen = this.request.status === 'Ouvert' || this.request.status === 'Open';
      
      if (isOpen) {
        this.router.navigate(['/purchases/request', this.request.id, 'edit']);
      } else {
        this.notificationService.showWarning('Seules les demandes à l\'état "Ouvert" peuvent être modifiées');
      }
    } else {
      if (!this.request) {
        this.notificationService.showError('Impossible de modifier : demande non trouvée');
      } else if (!this.canEdit()) {
        this.notificationService.showWarning('Vous n\'avez pas les droits pour modifier cette demande');
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
  
  /**
   * Soumet une demande à l'approbation (statut -> "Released")
   */
  submitToApprove(): void {
    if (this.isReadOnly) {
      this.toastr.warning('Action indisponible en mode hors ligne', 'Action indisponible');
      return;
    }
    
    if (!this.request?.id) return;
    
    this.notificationService.showConfirmation({
      title: 'Soumission à approbation',
      message: `Voulez-vous soumettre la demande ${this.request.no} à l'approbation ?`,
      confirmText: 'Soumettre',
      cancelText: 'Annuler',
      confirmColor: 'primary'
    }).subscribe(confirmed => {
      if (confirmed) {
        this.purchaseRequestService.updateStatus(this.request!.id!, 'Released').pipe(
          takeUntil(this.destroy$)
        ).subscribe({
          next: () => {
            this.notificationService.showSuccess('Demande soumise à l\'approbation avec succès');
            if (this.request?.id) {
              this.loadRequest(this.request.id);
            }
          },
          error: (error) => {
            console.error('Erreur lors de la soumission', error);
            this.notificationService.showError('Impossible de soumettre la demande à l\'approbation');
          }
        });
      }
    });
  }
  
  /**
   * Approuve une demande
   */
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
  
  /**
   * Refuse une demande
   */
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
    if (str === '' || str === '0001-01-01' || str === '0001-01-01T00:00:00' || str === '0001-01-01T00:00:00Z') {
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

  formatDateTime(date: string | Date | undefined | null): string {
    if (!this.isValidDate(date)) return '—';
    const d = new Date(date!);
    return d.toLocaleDateString('fr-FR', {
      day: '2-digit',
      month: '2-digit',
      year: 'numeric'
    }) + ' à ' + d.toLocaleTimeString('fr-FR', { hour: '2-digit', minute: '2-digit' });
  }

  isOverdue(dueDate: string | Date | undefined | null): boolean {
    if (!this.isValidDate(dueDate)) return false;
    const today = new Date();
    today.setHours(0, 0, 0, 0);
    const due = new Date(dueDate!);
    due.setHours(0, 0, 0, 0);
    return due < today;
  }

  // ─── AMOUNT HELPER ───────────────────────────────────────────────────────────

  formatAmount(amount: number): string {
    if (amount === null || amount === undefined) return '0 FCFA';
    return new Intl.NumberFormat('fr-FR', { 
      minimumFractionDigits: 0, 
      maximumFractionDigits: 0 
    }).format(amount) + ' FCFA';
  }

  getTotalAmount(): number {
    return this.lines.reduce((sum, line) => sum + (line.lineAmount || 0), 0);
  }

  // ─── PERMISSIONS ─────────────────────────────────────────────────────────────

  canEdit(): boolean {
    if (this.isReadOnly) return false;
    return canEdit(this.request?.status);
  }
  
  canDelete(): boolean {
    if (this.isReadOnly) return false;
    if (!this.request) return false;
    const currentUser = this.authService.getCurrentUser();
    return canDelete(this.request.status, this.request.requesterId || '', currentUser?.name || '');
  }
  
  canSubmitToApprove(): boolean {
    if (this.isReadOnly) return false;
    if (!this.request) return false;
    const currentUser = this.authService.getCurrentUser();
    const isRequester = this.request.requesterId === currentUser?.name;
    return canSubmitToApprove(this.request.status) && isRequester;
  }
  
  canApprove(): boolean {
    if (this.isReadOnly) return false;
    if (!this.request) return false;
    const isApprover = this.authService.isApprover();
    return canApprove(this.request.status) && isApprover;
  }
  
  canGenerateOrder(): boolean {
    if (this.isReadOnly) return false;
    if (!this.request) return false;
    const isApprover = this.authService.isApprover();
    const isCompleted = this.request.status === 'Totallement Pris En Charge';
    return isCompleted && isApprover;
  }

  // Types pour l'affichage
  getTypeLabel(type: string | undefined): string {
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

  getTypeClass(type: string | undefined): string {
    switch (type) {
      case 'Item':
        return 'type-item';
      case 'Fixed Asset':
      case 'Fixed_x0020_Asset':
        return 'type-immobilisation';
      default:
        return 'type-default';
    }
  }

  getTypeIcon(type: string | undefined): string {
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

  getStatusClassForBadge(status: string | undefined): string {
    if (!status) return 'unknown';
    
    const statusLower = status.toLowerCase();
    if (statusLower === 'ouvert' || statusLower === 'open') return 'open';
    if (statusLower === 'released' || statusLower === 'to approve') return 'to-approve';
    if (statusLower === 'en cours' || statusLower === 'in progress') return 'in-progress';
    if (statusLower === 'totallement pris en charge' || statusLower === 'completed') return 'complete';
    if (statusLower === 'rejeté' || statusLower === 'rejected') return 'rejected';
    
    return 'unknown';
  }
}

export { RequestDetailComponent as RequestDetail };