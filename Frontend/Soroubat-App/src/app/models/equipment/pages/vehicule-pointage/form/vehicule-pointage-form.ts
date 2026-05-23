// vehicule-pointage-form.ts

import { Component, OnInit, OnDestroy, ChangeDetectorRef, ChangeDetectionStrategy } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute, Router, RouterModule } from '@angular/router';
import { FormsModule, ReactiveFormsModule, FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Subject, takeUntil, finalize } from 'rxjs';

// Angular Material
import { MatCardModule } from '@angular/material/card';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { MatTooltipModule } from '@angular/material/tooltip';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatNativeDateModule } from '@angular/material/core';

// Services
import { VehiculePointageService } from '../../../services/vehicule-pointage.service';
import { AuthService } from '../../../../../core/services/auth';
import { NotificationService } from '../../../../../core/services/notification';

// Models
import { VehiculePointageHeader } from '../../../models/vehicule-pointage.model';

@Component({
  selector: 'app-vehicule-pointage-form',
  standalone: true,
  imports: [
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    RouterModule,
    MatCardModule,
    MatFormFieldModule,
    MatInputModule,
    MatButtonModule,
    MatIconModule,
    MatProgressSpinnerModule,
    MatTooltipModule,
    MatDatepickerModule,
    MatNativeDateModule
  ],
  templateUrl: './vehicule-pointage-form.html',
  styleUrls: ['./vehicule-pointage-form.css'],
  changeDetection: ChangeDetectionStrategy.OnPush
})
export class VehiculePointageFormComponent implements OnInit, OnDestroy {
  
  pointageForm!: FormGroup;
  pointageId: string | null = null;
  isEditMode = false;
  isCreateMode = false;
  loading = false;
  submitting = false;
  errorMessage = '';
  
  // Statuts modifiables (Brouillon ou Ouvert seulement)
  private editableStatuses = ['brouillon', 'ouvert'];
  private currentStatus: string = '';
  
  private destroy$ = new Subject<void>();
  
  constructor(
    private fb: FormBuilder,
    private route: ActivatedRoute,
    private router: Router,
    private vehiculePointageService: VehiculePointageService,
    private authService: AuthService,
    private notificationService: NotificationService,
    private cdr: ChangeDetectorRef
  ) {
    this.initForm();
  }
  
  ngOnInit(): void {
    // Vérifier le mode
    this.pointageId = this.route.snapshot.paramMap.get('id');
    this.isEditMode = !!this.pointageId;
    this.isCreateMode = !this.isEditMode;
    
    if (this.isEditMode) {
      this.loadPointage();
    } else {
      // Mode création
      this.setupCreateMode();
    }
  }
  
  ngOnDestroy(): void {
    this.destroy$.next();
    this.destroy$.complete();
  }
  
  private initForm(): void {
    this.pointageForm = this.fb.group({
      date: [new Date(), Validators.required]
    });
  }
  
  private setupCreateMode(): void {
    console.log('📝 Mode création activé - Formulaire simplifié (uniquement la date)');
  }
  
  loadPointage(): void {
    if (!this.pointageId) return;
    
    this.loading = true;
    this.cdr.detectChanges();
    
    this.vehiculePointageService.getHeaderById(this.pointageId).pipe(
      takeUntil(this.destroy$),
      finalize(() => {
        this.loading = false;
        this.cdr.detectChanges();
      })
    ).subscribe({
      next: (data) => {
        console.log('📦 Header du pointage chargé:', {
          id: data.id,
          documentNo: data.documentNo,
          jobNo: data.jobNo,
          date: data.date,
          status: data.status,
          observation: data.observation
        });
        
        this.currentStatus = data.status || '';
        
        const status = (data.status || '').toLowerCase();
        if (!this.editableStatuses.includes(status)) {
          this.notificationService.showWarning(`Ce pointage est "${data.status}" et ne peut pas être modifié. Seuls les brouillons ou les pointages ouverts sont modifiables.`);
          this.router.navigate(['/equipment/pointages']);
          return;
        }
        
        this.pointageForm.patchValue({
          date: this.parseDate(data.date)
        });
        
        this.cdr.detectChanges();
      },
      error: (error) => {
        console.error('❌ Erreur chargement pointage', error);
        this.errorMessage = 'Impossible de charger le pointage';
        this.cdr.detectChanges();
      }
    });
  }
  
  private parseDate(date: string | Date | undefined): Date {
    if (!date) return new Date();
    if (date instanceof Date) return date;
    
    if (typeof date === 'string' && date.includes('/')) {
      const parts = date.split('/');
      if (parts.length === 3) {
        const day = parseInt(parts[0], 10);
        const month = parseInt(parts[1], 10) - 1;
        const year = parseInt(parts[2], 10);
        return new Date(year, month, day);
      }
    }
    
    if (typeof date === 'string' && date.includes('-')) {
      return new Date(date);
    }
    
    return new Date(date);
  }
  
  private formatDateForApi(date: Date | string): string {
    const d = new Date(date);
    const year = d.getFullYear();
    const month = String(d.getMonth() + 1).padStart(2, '0');
    const day = String(d.getDate()).padStart(2, '0');
    return `${year}-${month}-${day}`;
  }
  
  onSubmit(): void {
    if (this.pointageForm.invalid) {
      this.pointageForm.markAllAsTouched();
      this.notificationService.showWarning('Veuillez sélectionner une date');
      return;
    }
    
    this.submitting = true;
    this.cdr.detectChanges();
    
    const formValue = this.pointageForm.getRawValue();
    
    if (this.isCreateMode) {
      // ⭐ Mode création : envoyer uniquement la date
      const newPointage = {
        date: this.formatDateForApi(formValue.date)
      };
      
      console.log('📤 Création d\'un nouveau pointage:', newPointage);
      
      this.vehiculePointageService.createHeader(newPointage).pipe(
        takeUntil(this.destroy$),
        finalize(() => {
          this.submitting = false;
          this.cdr.detectChanges();
        })
      ).subscribe({
        next: (response) => {
          console.log('✅ Pointage créé avec succès:', response);
          this.notificationService.showSuccess(`Pointage ${response.documentNo} créé avec succès`);
          // Rediriger vers le détail du pointage pour ajouter les véhicules
          this.router.navigate(['/equipment/pointage', response.id]);
        },
        error: (error) => {
          console.error('❌ Erreur création pointage:', error);
          const errorMsg = error.error?.message || 'Erreur lors de la création du pointage';
          this.notificationService.showError(errorMsg);
          this.submitting = false;
          this.cdr.detectChanges();
        }
      });
    } else {
      // Mode édition : mettre à jour uniquement les observations (si vous voulez garder cette fonctionnalité)
      // Ou rediriger vers le détail
      this.router.navigate(['/equipment/pointage', this.pointageId]);
    }
  }
  
  cancel(): void {
    this.router.navigate(['/equipment/pointages']);
  }








  // vehicule-pointage-form.ts - Ajouter ces méthodes

/**
 * Formate la date pour l'aperçu (jour)
 */
formatDatePreview(date: Date): string {
  if (!date) return '--';
  const d = new Date(date);
  return d.getDate().toString().padStart(2, '0');
}

/**
 * Retourne le jour de la semaine
 */
getWeekday(date: Date): string {
  if (!date) return '';
  const days = ['Dimanche', 'Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi'];
  return days[new Date(date).getDay()];
}

/**
 * Retourne le mois et l'année
 */
getMonthYear(date: Date): string {
  if (!date) return '';
  const months = ['Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin', 'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'];
  const d = new Date(date);
  return `${months[d.getMonth()]} ${d.getFullYear()}`;
}
}