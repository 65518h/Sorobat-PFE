// src/app/modules/equipment/pages/vehicule-pointage-line-edit/vehicule-pointage-line-edit.ts

import { Component, OnInit, OnDestroy, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute, Router, RouterModule } from '@angular/router';
import { FormsModule, ReactiveFormsModule, FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Subject, takeUntil, finalize } from 'rxjs';

// Angular Material
import { MatCardModule } from '@angular/material/card';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatSelectModule } from '@angular/material/select';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { MatTooltipModule } from '@angular/material/tooltip';

// Services
import { VehiculePointageService } from '../../../services/vehicule-pointage.service';
import { NotificationService } from '../../../../../core/services/notification';

@Component({
  selector: 'app-vehicule-pointage-line-edit',
  standalone: true,
  imports: [
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    RouterModule,
    MatCardModule,
    MatFormFieldModule,
    MatInputModule,
    MatSelectModule,
    MatButtonModule,
    MatIconModule,
    MatProgressSpinnerModule,
    MatTooltipModule
  ],
  templateUrl: './vehicule-pointage-line-edit.html',
  styleUrls: ['./vehicule-pointage-line-edit.css']
})
export class VehiculePointageLineEditComponent implements OnInit, OnDestroy {
  
  lineForm!: FormGroup;
  pointageId: string | null = null;
  lineId: string | null = null;
  loading = false;
  submitting = false;
  indexError: boolean = false;
  
  private destroy$ = new Subject<void>();
  
  constructor(
    private fb: FormBuilder,
    private route: ActivatedRoute,
    private router: Router,
    private vehiculePointageService: VehiculePointageService,
    private notificationService: NotificationService,
    private cdr: ChangeDetectorRef
  ) {}
  
  ngOnInit(): void {
    this.pointageId = this.route.snapshot.paramMap.get('pointageId');
    this.lineId = this.route.snapshot.paramMap.get('lineId');
    
    console.log('📝 Pointage ID:', this.pointageId);
    console.log('📝 Line ID:', this.lineId);
    
    this.initForm();
    this.loadDataFromParams();
  }
  
  ngOnDestroy(): void {
    this.destroy$.next();
    this.destroy$.complete();
  }
  
  private initForm(): void {
    this.lineForm = this.fb.group({
      vehiculeNo: [{ value: '', disabled: true }],
      description: [{ value: '', disabled: true }],
      hoursWorked: [0, [Validators.required, Validators.min(0)]],
      startIndex: [0, [Validators.required, Validators.min(0)]],
      endIndex: [0, [Validators.required, Validators.min(0)]],
      fuelConsumed: [{ value: 0, disabled: true }],
      status: ['Fonctionnel', Validators.required],
      breakdownMotiv: ['']
    });
  }
  
  private loadDataFromParams(): void {
    const queryParams = this.route.snapshot.queryParams;
    
    console.log('📥 QueryParams reçus:', queryParams);
    
    const vehiculeNo = queryParams['vehiculeNo'] || '';
    const description = queryParams['description'] || '';
    const hoursWorked = Number(queryParams['hoursWorked']) || 0;
    const startIndex = Number(queryParams['startIndex']) || 0;
    const endIndex = Number(queryParams['endIndex']) || 0;
    const fuelConsumed = Number(queryParams['fuelConsumed']) || 0;
    const status = queryParams['status'] || 'Fonctionnel';
    const breakdownMotiv = queryParams['breakdownMotiv'] || '';
    
    console.log('📦 Données parsées:', {
      vehiculeNo,
      description,
      hoursWorked,
      startIndex,
      endIndex,
      fuelConsumed,
      status,
      breakdownMotiv
    });
    
    this.lineForm.patchValue({
      vehiculeNo: vehiculeNo,
      description: description,
      hoursWorked: hoursWorked,
      startIndex: startIndex,
      endIndex: endIndex,
      fuelConsumed: fuelConsumed,
      status: status,
      breakdownMotiv: breakdownMotiv
    });
    
    // Appliquer les règles de validation en fonction du statut
    this.applyStatusRules();
    this.validateIndexes();
    
    console.log('📦 Formulaire après patch:', this.lineForm.getRawValue());
    this.cdr.detectChanges();
  }
  
  /**
   * Vérifie si le statut est un statut de panne/problème
   */
  isBreakdownStatus(): boolean {
    const status = this.lineForm.get('status')?.value;
    return ['Panne', 'Accident', 'Mauvais Temps'].includes(status);
  }
  
  /**
   * Vérifie si le véhicule est réformé
   */
  isReformed(): boolean {
    const status = this.lineForm.get('status')?.value;
    return status === 'Réformé';
  }
  
  /**
   * Vérifie si le véhicule est opérationnel (peut travailler)
   */
  isOperational(): boolean {
    const status = this.lineForm.get('status')?.value;
    return status === 'Fonctionnel' || status === 'Disponible';
  }
  
  /**
   * Applique les règles de validation en fonction du statut
   */
  
  private applyStatusRules(): void {
  const status = this.lineForm.get('status')?.value;
  const breakdownControl = this.lineForm.get('breakdownMotiv');
  const hoursControl = this.lineForm.get('hoursWorked');
  const startIndexControl = this.lineForm.get('startIndex');
  const endIndexControl = this.lineForm.get('endIndex');
  
  // Gestion des statuts de panne
  if (this.isBreakdownStatus()) {
    breakdownControl?.setValidators([Validators.required]);
    hoursControl?.setValue(0);
    hoursControl?.disable();
  } else {
    breakdownControl?.clearValidators();
    breakdownControl?.setValue('');
    breakdownControl?.updateValueAndValidity();
    
    // ✅ Disponible : heures = 0 et désactivé
    if (status === 'Disponible') {
      hoursControl?.setValue(0);
      hoursControl?.disable();
    } 
    // Fonctionnel : heures modifiables
    else if (status === 'Fonctionnel') {
      hoursControl?.enable();
    }
  }
  
  // Gestion du statut Réformé
  if (this.isReformed()) {
    hoursControl?.setValue(0);
    hoursControl?.disable();
    startIndexControl?.disable();
    endIndexControl?.disable();
  } else {
    startIndexControl?.enable();
    endIndexControl?.enable();
  }
  
  breakdownControl?.updateValueAndValidity();
}
  
  /**
   * Appelé quand le statut change
   */
  onStatusChange(): void {
    this.applyStatusRules();
    this.validateIndexes();
    this.cdr.detectChanges();
  }
  
  /**
   * Valide que l'index fin >= index départ
   */
  validateIndexes(): void {
    const start = this.lineForm.get('startIndex')?.value || 0;
    const end = this.lineForm.get('endIndex')?.value || 0;
    
    this.indexError = end < start;
    
    if (this.indexError) {
      this.lineForm.get('endIndex')?.setErrors({ invalidIndex: true });
    } else {
      const currentErrors = this.lineForm.get('endIndex')?.errors;
      if (currentErrors) {
        delete currentErrors['invalidIndex'];
        if (Object.keys(currentErrors).length === 0) {
          this.lineForm.get('endIndex')?.setErrors(null);
        }
      }
    }
    
    this.cdr.detectChanges();
  }
  
  getDistance(): number {
    const start = this.lineForm.get('startIndex')?.value || 0;
    const end = this.lineForm.get('endIndex')?.value || 0;
    if (this.isReformed()) return 0;
    return Math.max(0, end - start);
  }
  
  updateDistance(): void {
    this.validateIndexes();
    this.cdr.detectChanges();
  }
  
  /**
   * Vérifie si le formulaire est valide
   */
  isFormValid(): boolean {
    if (this.indexError) return false;
    if (this.lineForm.invalid) return false;
    if (this.isBreakdownStatus()) {
      const motiv = this.lineForm.get('breakdownMotiv')?.value;
      if (!motiv || motiv.trim() === '') return false;
    }
    return true;
  }
  
  onSubmit(): void {
    if (!this.isFormValid()) {
      if (this.indexError) {
        this.notificationService.showWarning('L\'index fin doit être supérieur ou égal à l\'index départ');
      } else {
        this.lineForm.markAllAsTouched();
        this.notificationService.showWarning('Veuillez remplir tous les champs obligatoires');
      }
      return;
    }
    
    this.submitting = true;
    
    const formValue = this.lineForm.getRawValue();
    
    // Envoyer uniquement les champs modifiables
    const updateData: any = {
      hoursWorked: formValue.hoursWorked,
      startIndex: formValue.startIndex,
      endIndex: formValue.endIndex,
      status: formValue.status
    };
    
    // Ajouter le motif de panne si applicable
    if (this.isBreakdownStatus() && formValue.breakdownMotiv) {
      updateData.breakdownMotiv = formValue.breakdownMotiv;
    }
    
    console.log('📤 Envoi des modifications:', updateData);
    
    this.vehiculePointageService.updateLine(this.lineId!, updateData).pipe(
      takeUntil(this.destroy$),
      finalize(() => {
        this.submitting = false;
        this.cdr.detectChanges();
      })
    ).subscribe({
      next: () => {
        this.notificationService.showSuccess('Véhicule modifié avec succès');
        this.router.navigate(['/equipment/pointage', this.pointageId]);
      },
      error: (error) => {
        console.error('Erreur mise à jour:', error);
        const errorMsg = error.error?.message || 'Erreur lors de la modification du véhicule';
        this.notificationService.showError(errorMsg);
      }
    });
  }
  
  cancel(): void {
    this.router.navigate(['/equipment/pointage', this.pointageId]);
  }
}