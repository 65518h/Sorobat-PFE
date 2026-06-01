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
    
    console.log('Pointage ID:', this.pointageId);
    console.log('Line ID:', this.lineId);
    
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
      hoursWorked: [0, [Validators.required, Validators.min(0), Validators.max(10)]],
      startIndex: [0, [Validators.required, Validators.min(0)]],
      endIndex: [0, [Validators.required, Validators.min(0)]],
      fuelConsumed: [{ value: 0, disabled: true }],
      status: ['Fonctionnel', Validators.required]
    });
  }
  
  private loadDataFromParams(): void {
    setTimeout(() => {
      const queryParams = this.route.snapshot.queryParams;
      
      console.log('QueryParams recus:', queryParams);
      
      const vehiculeNo = queryParams['vehiculeNo'] || '';
      const description = queryParams['description'] || '';
      let hoursWorked = Number(queryParams['hoursWorked']) || 0;
      const startIndex = Number(queryParams['startIndex']) || 0;
      const endIndex = Number(queryParams['endIndex']) || 0;
      const fuelConsumed = Number(queryParams['fuelConsumed']) || 0;
      const status = queryParams['status'] || 'Fonctionnel';
      
      // S'assurer que hoursWorked est soit 0 soit 10
      if (hoursWorked !== 0 && hoursWorked !== 10) {
        hoursWorked = hoursWorked > 5 ? 10 : 0;
      }
      
      console.log('Donnees parsees:', {
        vehiculeNo,
        description,
        hoursWorked,
        startIndex,
        endIndex,
        fuelConsumed,
        status
      });
      
      this.lineForm.patchValue({
        vehiculeNo: vehiculeNo,
        description: description,
        hoursWorked: hoursWorked,
        startIndex: startIndex,
        endIndex: endIndex,
        fuelConsumed: fuelConsumed,
        status: status
      });
      
      this.applyStatusRules();
      this.validateIndexes();
      
      console.log('Formulaire apres patch:', this.lineForm.getRawValue());
      this.cdr.detectChanges();
    }, 100);
  }
  
  /**
   * Verifie si le vehicule est reforme
   */
  isReformed(): boolean {
    const status = this.lineForm.get('status')?.value;
    return status === 'Réformé';
  }
  
  /**
   * Verifie si le vehicule est operationnel (peut travailler)
   */
  isOperational(): boolean {
    const status = this.lineForm.get('status')?.value;
    return status === 'Fonctionnel' || status === 'Disponible';
  }
  
  /**
   * Applique les regles de validation en fonction du statut
   */
  private applyStatusRules(): void {
    const status = this.lineForm.get('status')?.value;
    const hoursControl = this.lineForm.get('hoursWorked');
    const startIndexControl = this.lineForm.get('startIndex');
    const endIndexControl = this.lineForm.get('endIndex');
    
    // Gestion du statut Reforme
    if (this.isReformed()) {
      hoursControl?.setValue(0);
      hoursControl?.disable();
      startIndexControl?.disable();
      endIndexControl?.disable();
    }
    // Gestion du statut Disponible
    else if (status === 'Disponible') {
      hoursControl?.setValue(0);
      hoursControl?.disable();
      startIndexControl?.enable();
      endIndexControl?.enable();
    }
    // Gestion du statut Fonctionnel
    else if (status === 'Fonctionnel') {
      hoursControl?.enable();
      startIndexControl?.enable();
      endIndexControl?.enable();
    }
    // Autres statuts (Panne, Accident, Mauvais Temps)
    else {
      hoursControl?.setValue(0);
      hoursControl?.disable();
      startIndexControl?.enable();
      endIndexControl?.enable();
    }
  }
  
  /**
   * Appele quand le statut change
   */
  onStatusChange(): void {
    this.applyStatusRules();
    this.validateIndexes();
    this.cdr.detectChanges();
  }
  
  /**
   * Valide que l'index fin >= index depart
   */
  validateIndexes(): void {
    const start = this.lineForm.get('startIndex')?.value || 0;
    const end = this.lineForm.get('endIndex')?.value || 0;
    
    if (this.isReformed()) {
      this.indexError = false;
      return;
    }
    
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
  
  isFormValid(): boolean {
    if (this.indexError) return false;
    if (this.lineForm.invalid) return false;
    return true;
  }
  
  onSubmit(): void {
    // Récupérer les valeurs brutes
    const rawFormValue = this.lineForm.getRawValue();
    
    // S'assurer que les valeurs sont des nombres valides
    let hoursWorked = parseFloat(rawFormValue.hoursWorked);
    let startIndex = parseFloat(rawFormValue.startIndex);
    let endIndex = parseFloat(rawFormValue.endIndex);
    
    // Vérifier si les valeurs sont NaN
    if (isNaN(hoursWorked)) hoursWorked = 0;
    if (isNaN(startIndex)) startIndex = 0;
    if (isNaN(endIndex)) endIndex = 0;
    
    // Forcer hoursWorked à être 0 ou 10
    if (hoursWorked !== 0 && hoursWorked !== 10) {
      hoursWorked = hoursWorked > 5 ? 10 : 0;
      this.lineForm.get('hoursWorked')?.setValue(hoursWorked);
    }
    
    const status = rawFormValue.status;
    
    console.log('Valeurs traitees:', {
      hoursWorkedRaw: rawFormValue.hoursWorked,
      hoursWorkedParsed: hoursWorked,
      startIndexRaw: rawFormValue.startIndex,
      startIndexParsed: startIndex,
      endIndexRaw: rawFormValue.endIndex,
      endIndexParsed: endIndex,
      status: status
    });
    
    // Validation
    if (!this.isFormValid()) {
      if (this.indexError) {
        this.notificationService.showWarning('L\'index fin doit etre superieur ou egal a l\'index depart');
      } else {
        this.lineForm.markAllAsTouched();
        this.notificationService.showWarning('Veuillez remplir tous les champs obligatoires');
      }
      return;
    }
    
    this.submitting = true;
    
    // Construire l'objet de mise à jour
    const updateData: any = {
      status: status
    };
    
    // Ajouter les heures si le véhicule n'est pas réformé et pas en panne
    const shouldAddHours = !this.isReformed() && 
                           status !== 'Panne' && 
                           status !== 'Accident' && 
                           status !== 'Mauvais Temps';
    
    if (shouldAddHours) {
      updateData.hoursWorked = hoursWorked;
    }
    
    // Ajouter les index si le véhicule n'est pas réformé
    if (!this.isReformed()) {
      updateData.startIndex = startIndex;
      updateData.endIndex = endIndex;
    }
    
    console.log('Donnees envoyees a l\'API:', updateData);
    
    this.vehiculePointageService.updateLine(this.lineId!, updateData).pipe(
      takeUntil(this.destroy$),
      finalize(() => {
        this.submitting = false;
        this.cdr.detectChanges();
      })
    ).subscribe({
      next: (response) => {
        console.log('Reponse API:', response);
        this.notificationService.showSuccess('Vehicule modifie avec succes');
        this.router.navigate(['/equipment/pointage', this.pointageId]);
      },
      error: (error) => {
        console.error('Erreur mise a jour:', error);
        const errorMsg = error.error?.message || 'Erreur lors de la modification du vehicule';
        this.notificationService.showError(errorMsg);
      }
    });
  }
  
  cancel(): void {
    this.router.navigate(['/equipment/pointage', this.pointageId]);
  }
}

export { VehiculePointageLineEditComponent as VehiculePointageLineEdit };