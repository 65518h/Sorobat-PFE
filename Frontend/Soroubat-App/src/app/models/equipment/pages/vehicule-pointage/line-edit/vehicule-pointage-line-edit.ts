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
      breakdownMotiv: [{ value: '', disabled: true }]
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
    
    console.log('📦 Formulaire après patch:', this.lineForm.getRawValue());
    this.cdr.detectChanges();
  }
  
  getDistance(): number {
    const start = this.lineForm.get('startIndex')?.value || 0;
    const end = this.lineForm.get('endIndex')?.value || 0;
    return Math.max(0, end - start);
  }
  
  updateDistance(): void {
    this.cdr.detectChanges();
  }
  
  onSubmit(): void {
    if (this.lineForm.invalid) {
      this.lineForm.markAllAsTouched();
      this.notificationService.showWarning('Veuillez remplir tous les champs obligatoires');
      return;
    }
    
    this.submitting = true;
    
    const formValue = this.lineForm.getRawValue();
    
    // Envoyer uniquement les champs modifiables
    const updateData = {
      hoursWorked: formValue.hoursWorked,
      startIndex: formValue.startIndex,
      endIndex: formValue.endIndex,
      status: formValue.status
    };
    
    console.log('📤 Envoi des modifications:', updateData);
    
    this.vehiculePointageService.updateLine(this.lineId!, updateData).pipe(
      takeUntil(this.destroy$),
      finalize(() => {
        this.submitting = false;
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
        this.submitting = false;
      }
    });
  }
  
  cancel(): void {
    this.router.navigate(['/equipment/pointage', this.pointageId]);
  }
}