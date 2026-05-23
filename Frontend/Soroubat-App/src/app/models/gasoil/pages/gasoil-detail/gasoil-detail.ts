// src/app/modules/gasoil/pages/gasoil-detail/gasoil-detail.ts

import { Component, OnInit, OnDestroy, inject, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute, Router, RouterModule } from '@angular/router';
import { Subject, takeUntil, finalize } from 'rxjs';

// Angular Material
import { MatCardModule } from '@angular/material/card';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { MatTooltipModule } from '@angular/material/tooltip';
import { MatDividerModule } from '@angular/material/divider';
import { MatChipsModule } from '@angular/material/chips';
import { MatDialog, MatDialogModule } from '@angular/material/dialog';
import { ToastrService } from 'ngx-toastr';

// Services
import { GasoilService } from '../../services/gasoil.service';
import { NotificationService } from '../../../../core/services/notification';
import { AppModeService } from '../../../../core/services/app-mode.service';
import { OfflineHideActionsDirective } from '../../../../core/directives/offline-hide-actions.directive';
import { ShowOfflineMessageDirective } from '../../../../core/directives/show-offline-message.directive';
import { ConfirmationDialogComponent, ConfirmationDialogData } from '../../../../core/components/confirmation-dialog/confirmation-dialog.component';

// Models
import { GasoilHeader, getGasoilStatusClass, getGasoilStatusIcon, getGasoilStatusLabel, getIndexTypeLabel } from '../../models/gasoil.model';

@Component({
  selector: 'app-gasoil-detail',
  standalone: true,
  imports: [
    CommonModule,
    RouterModule,
    MatCardModule,
    MatButtonModule,
    MatIconModule,
    MatProgressSpinnerModule,
    MatTooltipModule,
    MatDividerModule,
    MatChipsModule,
    MatDialogModule,
    OfflineHideActionsDirective,
    ShowOfflineMessageDirective
  ],
  templateUrl: './gasoil-detail.html',
  styleUrls: ['./gasoil-detail.css']
})
export class GasoilDetailComponent implements OnInit, OnDestroy {
  
  private gasoilService = inject(GasoilService);
  private route = inject(ActivatedRoute);
  private router = inject(Router);
  private notificationService = inject(NotificationService);
  private cdr = inject(ChangeDetectorRef);
  private toastr = inject(ToastrService);
  private appMode = inject(AppModeService);
  private dialog = inject(MatDialog);
  
  header: GasoilHeader | null = null;
  loading = false;
  deleting = false;
  validating = false;
  headerId: string | null = null;
  isReadOnly: boolean = false;
  
  private destroy$ = new Subject<void>();
  
  ngOnInit(): void {
    // S'abonner au mode offline
    this.appMode.mode$
      .pipe(takeUntil(this.destroy$))
      .subscribe(mode => {
        this.isReadOnly = mode === 'offline-readonly';
        console.log('Mode gasoil-detail:', this.isReadOnly ? 'offline-readonly' : 'online');
        this.cdr.detectChanges();
      });
    
    // Vérifier les données passées par navigation
    const navigation = this.router.getCurrentNavigation();
    const stateData = navigation?.extras?.state as { header: GasoilHeader };
    
    if (stateData?.header && stateData.header.gasoilLines && stateData.header.gasoilLines.length > 0) {
      console.log('Utilisation des données en cache, lignes:', stateData.header.gasoilLines.length);
      this.header = stateData.header;
      this.loading = false;
      this.cdr.detectChanges();
      return;
    }
    
    // Sinon charger normalement
    this.headerId = this.route.snapshot.paramMap.get('id');
    if (this.headerId) {
      this.loadHeader();
    } else {
      this.router.navigate(['/gasoil/list']);
    }
  }
  
  ngOnDestroy(): void {
    this.destroy$.next();
    this.destroy$.complete();
  }
  
  private loadHeader(): void {
    if (!this.headerId) return;
    
    this.loading = true;
    this.cdr.detectChanges();
    
    this.gasoilService.getById(this.headerId)
      .pipe(
        takeUntil(this.destroy$),
        finalize(() => {
          this.loading = false;
          this.cdr.detectChanges();
        })
      )
      .subscribe({
        next: (data: GasoilHeader) => {
          console.log('Fiche chargée:', data);
          this.header = data;
          this.cdr.detectChanges();
        },
        error: (error: any) => {
          console.error('Erreur:', error);
          if (!this.isReadOnly) {
            this.notificationService.showError('Impossible de charger la fiche gasoil');
          } else {
            this.toastr.warning('Fiche non disponible hors ligne', 'Mode lecture seule');
          }
          setTimeout(() => {
            this.router.navigate(['/gasoil/list']);
          }, 2000);
        }
      });
  }
  
  editHeader(): void {
    if (this.isReadOnly) {
      this.toastr.warning('Modification indisponible en mode hors ligne', 'Action indisponible');
      return;
    }
    
    if (this.header?.id && this.header.status !== 'Valider') {
      this.router.navigate(['/gasoil/edit', this.header.id]);
    } else if (this.header?.status === 'Valider') {
      this.notificationService.showWarning('Cette fiche est déjà validée et ne peut pas être modifiée');
    }
  }
  
  // NOUVELLE METHODE deleteHeader AVEC DIALOGUE DE CONFIRMATION
  deleteHeader(): void {
    if (this.isReadOnly) {
      this.toastr.warning('Suppression indisponible en mode hors ligne', 'Action indisponible');
      return;
    }
    
    if (!this.header?.id) return;
    
    if (this.header.status === 'Valider') {
      this.notificationService.showWarning('Les fiches validées ne peuvent pas être supprimées');
      return;
    }
    
    const totalQuantity = this.getTotalQuantity();
    const quantityText = totalQuantity > 0 ? `\n\nQuantité totale: ${totalQuantity} L` : '';
    
    // Boîte de dialogue de confirmation élégante pour la suppression
    const dialogData: ConfirmationDialogData = {
      title: 'Supprimer la fiche gasoil',
      message: `Êtes-vous sûr de vouloir supprimer la fiche ${this.header.documentNo} ?${quantityText}\n\nCette action est irréversible.`,
      confirmText: 'Supprimer',
      cancelText: 'Annuler',
      confirmColor: 'warn',
      cancelColor: 'basic'
    };
    
    const dialogRef = this.dialog.open(ConfirmationDialogComponent, {
      data: dialogData,
      width: '450px',
      panelClass: 'confirmation-dialog-panel',
      disableClose: true
    });
    
    dialogRef.afterClosed().subscribe((confirmed: boolean) => {
      if (!confirmed) return;
      
      this.deleting = true;
      this.cdr.detectChanges();
      
      this.gasoilService.delete(this.header!.id!)
        .pipe(
          takeUntil(this.destroy$),
          finalize(() => {
            this.deleting = false;
            this.cdr.detectChanges();
          })
        )
        .subscribe({
          next: () => {
            this.notificationService.showSuccess('Fiche supprimée avec succès');
            this.toastr.success(`Fiche ${this.header!.documentNo} supprimée`, 'Suppression réussie');
            this.router.navigate(['/gasoil/list']);
          },
          error: (error: any) => {
            console.error('Erreur suppression:', error);
            this.notificationService.showError('Erreur lors de la suppression');
            this.toastr.error(`Erreur lors de la suppression de la fiche ${this.header!.documentNo}`, 'Échec');
          }
        });
    });
  }
  
  // NOUVELLE METHODE validateHeader AVEC DIALOGUE DE CONFIRMATION
  validateHeader(): void {
    if (this.isReadOnly) {
      this.toastr.warning('Validation indisponible en mode hors ligne', 'Action indisponible');
      return;
    }
    
    if (!this.header?.id) return;
    
    if (this.header.status === 'Valider') {
      this.notificationService.showWarning('Cette fiche est déjà validée');
      return;
    }
    
    const totalQuantity = this.getTotalQuantity();
    const quantityText = totalQuantity > 0 ? `\n\nQuantité totale: ${totalQuantity} L` : '';
    
    // Boîte de dialogue de confirmation élégante pour la validation
    const dialogData: ConfirmationDialogData = {
      title: 'Valider la fiche gasoil',
      message: `Confirmez-vous la validation de la fiche ${this.header.documentNo} ?${quantityText}\n\nUne fois validée, la fiche sera définitivement enregistrée et ne pourra plus être modifiée.`,
      confirmText: 'Valider',
      cancelText: 'Annuler',
      confirmColor: 'primary',
      cancelColor: 'basic'
    };
    
    const dialogRef = this.dialog.open(ConfirmationDialogComponent, {
      data: dialogData,
      width: '450px',
      panelClass: 'confirmation-dialog-panel',
      disableClose: true
    });
    
    dialogRef.afterClosed().subscribe((confirmed: boolean) => {
      if (!confirmed) return;
      
      this.validating = true;
      this.cdr.detectChanges();
      
      this.gasoilService.validate(this.header!.id!)
        .pipe(
          takeUntil(this.destroy$),
          finalize(() => {
            this.validating = false;
            this.cdr.detectChanges();
          })
        )
        .subscribe({
          next: () => {
            this.notificationService.showSuccess('Fiche validée avec succès');
            this.toastr.success(`Fiche ${this.header!.documentNo} validée avec succès`, 'Validation réussie');
            this.loadHeader();
          },
          error: (error: any) => {
            console.error('Erreur validation:', error);
            this.notificationService.showError(error.error?.message || 'Erreur lors de la validation');
            this.toastr.error(`Erreur lors de la validation de la fiche ${this.header!.documentNo}`, 'Échec');
          }
        });
    });
  }
  
  goBack(): void {
    this.router.navigate(['/gasoil/list']);
  }
  
  canEdit(): boolean {
    if (this.isReadOnly) return false;
    return this.header?.status !== 'Valider';
  }
  
  getStatusClass(): string {
    return getGasoilStatusClass(this.header?.status);
  }
  
  getStatusIcon(): string {
    return getGasoilStatusIcon(this.header?.status);
  }
  
  getStatusLabel(): string {
    return getGasoilStatusLabel(this.header?.status);
  }
  
  getIndexTypeLabel(type: string | undefined): string {
    return getIndexTypeLabel(type);
  }
  
  formatDate(date: string | Date | undefined): string {
    if (!date) return '—';
    const d = new Date(date);
    return d.toLocaleDateString('fr-FR', {
      day: '2-digit',
      month: 'long',
      year: 'numeric'
    });
  }
  
  formatNumber(value: number | undefined): string {
    if (value === undefined || value === null) return '—';
    return new Intl.NumberFormat('fr-FR').format(value);
  }
  
  formatDecimal(value: number | undefined): string {
    if (value === undefined || value === null) return '—';
    return new Intl.NumberFormat('fr-FR', {
      minimumFractionDigits: 2,
      maximumFractionDigits: 2
    }).format(value);
  }
  
  getTotalQuantity(): number {
    return this.header?.gasoilLines?.reduce((sum, l) => sum + (l.quantity || 0), 0) || 0;
  }
  
  getLineCount(): number {
    return this.header?.gasoilLines?.length || 0;
  }
}