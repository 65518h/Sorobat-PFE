// src/app/models/purchases/pages/request-form/request-form.ts

import { Component, OnInit, OnDestroy, ViewChild, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router, ActivatedRoute, RouterModule } from '@angular/router';
import { ReactiveFormsModule, FormBuilder, FormGroup, FormArray, Validators, FormControl } from '@angular/forms';
import { Subject, takeUntil, catchError, of, switchMap, finalize } from 'rxjs';

// Angular Material Modules
import { MatStepperModule, MatStepper } from '@angular/material/stepper';
import { MatCardModule } from '@angular/material/card';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatSelectModule } from '@angular/material/select';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatNativeDateModule } from '@angular/material/core';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatTableModule } from '@angular/material/table';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { MatTooltipModule } from '@angular/material/tooltip';

// Services
import { PurchaseRequestService } from '../../services/purchase-request';
import { PurchaseRequestLineService } from '../../services/purchase-request-line.service';
import { NotificationService } from '../../../../core/services/notification';
import { AuthService } from '../../../../core/services/auth';
import { ProjectService } from '../../../projects/services/project';

// Models
import { 
  PurchaseRequest, 
  PurchaseRequestStatus, 
  RequestType, 
  ServiceType 
} from '../../models/purchase-request.model';

import { 
  PurchaseRequestLine, 
  LineType, 
  CreatePurchaseRequestLine 
} from '../../models/purchase-request-line.model';

// ✅ Données mock pour les équipements
const MOCK_EQUIPMENT = [
  { code: 'ENG-001', description: 'Pelle hydraulique CAT 320' },
  { code: 'ENG-002', description: 'Chargeuse CAT 950' },
  { code: 'ENG-003', description: 'Camion benne Mercedes' },
  { code: 'ENG-004', description: 'Niveleuse CAT 140' },
  { code: 'ENG-005', description: 'Compacteur' },
  { code: 'ENG-006', description: 'Rouleau compresseur' }
];

@Component({
  selector: 'app-request-form',
  templateUrl: './request-form.html',
  styleUrls: ['./request-form.css'],
  standalone: true,
  imports: [
    CommonModule,
    ReactiveFormsModule,
    RouterModule,
    MatStepperModule,
    MatCardModule,
    MatFormFieldModule,
    MatInputModule,
    MatSelectModule,
    MatDatepickerModule,
    MatNativeDateModule,
    MatButtonModule,
    MatIconModule,
    MatTableModule,
    MatCheckboxModule,
    MatProgressSpinnerModule,
    MatTooltipModule
  ]
})
export class RequestForm implements OnInit, OnDestroy {
  
  @ViewChild('stepper') stepper!: MatStepper;
  
  headerForm!: FormGroup;
  linesForm!: FormGroup;
  
  isEditMode: boolean = false;
  requestId: string | null = null;
  requestNo: string | null = null;
  loading: boolean = false;
  submitting: boolean = false;
  
  requestTypes = Object.values(RequestType);
  services = Object.values(ServiceType);
  lineTypes = Object.values(LineType);
  
  projects: any[] = [];
  // ✅ Données mock pour les équipements
  equipment: any[] = MOCK_EQUIPMENT;
  
  stockStatuses: Map<string, any> = new Map();
  
  displayedColumns: string[] = ['type', 'no', 'description', 'quantity', 'unit', 'location', 'jobTask', 'engin', 'amount', 'actions'];
  
  private destroy$ = new Subject<void>();
  
  constructor(
    private fb: FormBuilder,
    private router: Router,
    private route: ActivatedRoute,
    private purchaseRequestService: PurchaseRequestService,
    private purchaseRequestLineService: PurchaseRequestLineService,
    private notificationService: NotificationService,
    private authService: AuthService,
    private projectService: ProjectService,
    private cdr: ChangeDetectorRef
  ) {
    this.initForms();
  }
  
  ngOnInit(): void {
    this.initNewRequest();
    
    // Charger les projets
    this.loadProjects();
    
    this.requestId = this.route.snapshot.paramMap.get('id');
    if (this.requestId) {
      this.isEditMode = true;
      this.loadRequest(this.requestId);
    }
  }
  
  ngOnDestroy(): void {
    this.destroy$.next();
    this.destroy$.complete();
  }
  
  initForms(): void {
    this.headerForm = this.fb.group({
      no: [{ value: '', disabled: true }],
      jobNo: ['', Validators.required],
      jobDescription: [{ value: '', disabled: true }],
      requesterId: [{ value: '', disabled: true }],
      requestType: ['', Validators.required],
      service: ['', Validators.required],
      engin: [''],
      descriptionEngin: [{ value: '', disabled: true }],
      orderDate: [new Date(), Validators.required],
      dueDate: ['', Validators.required],
      observation: ['']
    });
    
    this.linesForm = this.fb.group({
      lines: this.fb.array([])
    });
  }
  
  initNewRequest(): void {
    const currentUser = this.authService.getCurrentUser();
    if (currentUser) {
      this.headerForm.patchValue({
        requesterId: currentUser.name || currentUser.username,
        orderDate: new Date()
      });
    }
    
    const defaultDueDate = new Date();
    defaultDueDate.setDate(defaultDueDate.getDate() + 7);
    this.headerForm.patchValue({
      dueDate: defaultDueDate
    });
  }
  
  loadProjects(): void {
    this.projectService.getProjects().pipe(
      takeUntil(this.destroy$),
      catchError((error) => {
        console.error('Erreur chargement projets', error);
        return of([]);
      })
    ).subscribe({
      next: (projects: any[]) => {
        this.projects = projects || [];
        console.log('✅ Projets chargés:', this.projects.length);
        this.cdr.detectChanges();
      }
    });
  }
  
  loadRequest(id: string): void {
    this.loading = true;
    this.cdr.detectChanges();
    
    this.purchaseRequestService.getById(id).pipe(
      takeUntil(this.destroy$),
      finalize(() => {
        this.loading = false;
        this.cdr.detectChanges();
      }),
      catchError((error: any) => {
        console.error('Erreur chargement demande', error);
        this.notificationService.showError('Impossible de charger la demande');
        this.router.navigate(['/purchases/requests']);
        return of(null);
      })
    ).subscribe({
      next: (request: PurchaseRequest | null) => {
        if (request) {
          this.requestNo = request.no;
          this.populateForm(request);
          
          if (request.purchaseRequestLines?.length) {
            request.purchaseRequestLines.forEach(line => {
              this.addLineToForm(line);
            });
          }
          
          if (request.status !== PurchaseRequestStatus.OPEN) {
            this.headerForm.disable();
            this.linesForm.disable();
            this.notificationService.showInfo('Cette demande n\'est plus modifiable');
          }
        }
      }
    });
  }
  
  populateForm(request: PurchaseRequest): void {
    this.headerForm.patchValue({
      no: request.no,
      jobNo: request.jobNo,
      jobDescription: request.jobDescription,
      requesterId: request.requesterId,
      requestType: request.requestType,
      service: request.service,
      engin: request.engin,
      descriptionEngin: request.descriptionEngin,
      orderDate: request.orderDate ? new Date(request.orderDate) : new Date(),
      dueDate: request.dueDate ? new Date(request.dueDate) : null,
      observation: request.observation
    });
    this.cdr.detectChanges();
  }
  
  get linesArray(): FormArray {
    return this.linesForm.get('lines') as FormArray;
  }
  
  createLineForm(line?: PurchaseRequestLine): FormGroup {
    return this.fb.group({
      id: [line?.id || null],
      transferer: [line?.transferer || false],
      type: [line?.type || LineType.ITEM, Validators.required],
      no: [line?.no || '', Validators.required],
      description: [line?.description || ''],
      description2: [line?.description2 || ''],
      quantity: [line?.quantity || 1, [Validators.required, Validators.min(0.01)]],
      unitOfMeasureCode: [line?.unitOfMeasureCode || 'PCE', Validators.required],
      locationCode: [line?.locationCode || '', Validators.required],
      variantCode: [line?.variantCode || ''],
      jobTaskNo: [line?.jobTaskNo || '0'],
      engin: [line?.engin || ''],
      unitCost: [line?.unitCost || 0, [Validators.min(0)]],
      lineAmount: [{ value: line?.lineAmount || 0, disabled: true }]
    });
  }
  
  addLineToForm(line?: PurchaseRequestLine): void {
    this.linesArray.push(this.createLineForm(line));
    this.cdr.detectChanges();
  }
  
  removeLine(index: number): void {
    this.linesArray.removeAt(index);
    this.cdr.detectChanges();
  }
  
  calculateLineAmount(index: number): void {
    const lineForm = this.linesArray.at(index);
    const quantity = lineForm.get('quantity')?.value || 0;
    const unitCost = lineForm.get('unitCost')?.value || 0;
    const lineAmount = quantity * unitCost;
    lineForm.patchValue({ lineAmount });
  }
  
  getTotalAmount(): number {
    let total = 0;
    for (let i = 0; i < this.linesArray.length; i++) {
      const amount = this.linesArray.at(i).get('lineAmount')?.value || 0;
      total += amount;
    }
    return total;
  }
  
  onProjectSelected(jobNo: string): void {
    const project = this.projects.find(p => p.no === jobNo);
    if (project) {
      this.headerForm.patchValue({
        jobDescription: project.description
      });
      this.cdr.detectChanges();
    }
  }
  
  onEnginSelected(enginCode: string): void {
    const engin = this.equipment.find(e => e.code === enginCode);
    if (engin) {
      this.headerForm.patchValue({
        descriptionEngin: engin.description
      });
      this.cdr.detectChanges();
    }
  }
  
  onSubmit(): void {
    if (this.headerForm.invalid) {
      this.headerForm.markAllAsTouched();
      this.notificationService.showWarning('Veuillez remplir tous les champs obligatoires');
      return;
    }
    
    if (this.linesArray.length === 0) {
      this.notificationService.showWarning('Ajoutez au moins une ligne à la demande');
      return;
    }
    
    this.submitting = true;
    this.cdr.detectChanges();
    
    const requestData: any = {
      jobNo: this.headerForm.get('jobNo')?.value,
      requestType: this.headerForm.get('requestType')?.value,
      service: this.headerForm.get('service')?.value,
      engin: this.headerForm.get('engin')?.value || '',
      orderDate: this.headerForm.get('orderDate')?.value,
      dueDate: this.headerForm.get('dueDate')?.value,
      observation: this.headerForm.get('observation')?.value || ''
    };
    
    if (this.isEditMode && this.requestId) {
      this.purchaseRequestService.update(this.requestId, requestData).pipe(
        takeUntil(this.destroy$),
        switchMap(() => this.saveLines(this.requestId!)),
        finalize(() => {
          this.submitting = false;
          this.cdr.detectChanges();
        })
      ).subscribe({
        next: () => {
          this.notificationService.showSuccess('Demande mise à jour avec succès');
          this.router.navigate(['/purchases/request', this.requestId]);
        },
        error: (error: any) => {
          console.error('Erreur mise à jour', error);
          this.notificationService.showError('Erreur lors de la mise à jour');
        }
      });
    } else {
      requestData.requesterId = this.authService.getUserId();
      requestData.purchaseRequestLines = this.getLinesData();
      
      this.purchaseRequestService.create(requestData).pipe(
        takeUntil(this.destroy$),
        finalize(() => {
          this.submitting = false;
          this.cdr.detectChanges();
        })
      ).subscribe({
        next: (created: PurchaseRequest) => {
          this.notificationService.showSuccess('Demande créée avec succès');
          this.router.navigate(['/purchases/request', created.id]);
        },
        error: (error: any) => {
          console.error('Erreur création', error);
          this.notificationService.showError('Erreur lors de la création');
        }
      });
    }
  }
  
  saveLines(documentId: string): Promise<void> {
    return new Promise((resolve, reject) => {
      const linePromises: Promise<any>[] = [];
      const currentLines = this.getLinesData();
      
      for (const line of currentLines) {
        if (line.id) {
          linePromises.push(
            this.purchaseRequestLineService.update(line.id, {
              quantity: line.quantity,
              description: line.description,
              description2: line.description2,
              locationCode: line.locationCode,
              jobTaskNo: line.jobTaskNo,
              engin: line.engin,
              unitCost: line.unitCost
            }).toPromise()
          );
        } else {
          linePromises.push(
            this.purchaseRequestLineService.create({
              documentNo: documentId,
              transferer: false,
              type: line.type,
              no: line.no,
              description: line.description,
              description2: line.description2,
              quantity: line.quantity,
              unitOfMeasureCode: line.unitOfMeasureCode,
              locationCode: line.locationCode,
              variantCode: line.variantCode,
              jobTaskNo: line.jobTaskNo,
              engin: line.engin,
              unitCost: line.unitCost
            }).toPromise()
          );
        }
      }
      
      Promise.all(linePromises).then(() => {
        resolve();
      }).catch((error) => {
        console.error('Erreur sauvegarde lignes', error);
        reject(error);
      });
    });
  }
  
  getLinesData(): any[] {
    const lines: any[] = [];
    for (let i = 0; i < this.linesArray.length; i++) {
      const lineForm = this.linesArray.at(i);
      lines.push({
        id: lineForm.get('id')?.value,
        transferer: lineForm.get('transferer')?.value,
        type: lineForm.get('type')?.value,
        no: lineForm.get('no')?.value,
        description: lineForm.get('description')?.value,
        description2: lineForm.get('description2')?.value,
        quantity: lineForm.get('quantity')?.value,
        unitOfMeasureCode: lineForm.get('unitOfMeasureCode')?.value,
        locationCode: lineForm.get('locationCode')?.value,
        variantCode: lineForm.get('variantCode')?.value,
        jobTaskNo: lineForm.get('jobTaskNo')?.value,
        engin: lineForm.get('engin')?.value,
        unitCost: lineForm.get('unitCost')?.value
      });
    }
    return lines;
  }
  
  cancel(): void {
    if (this.linesArray.length > 0 || this.headerForm.dirty) {
      if (confirm('Voulez-vous quitter sans enregistrer ?')) {
        this.router.navigate(['/purchases/requests']);
      }
    } else {
      this.router.navigate(['/purchases/requests']);
    }
  }
  
  onItemSelected(index: number): void {
    // À implémenter si nécessaire
  }
  
  onQuantityChange(index: number): void {
    this.calculateLineAmount(index);
  }
  
  onUnitCostChange(index: number): void {
    this.calculateLineAmount(index);
  }
  
  formatAmount(amount: number): string {
    return new Intl.NumberFormat('fr-FR', { 
      minimumFractionDigits: 2, 
      maximumFractionDigits: 2 
    }).format(amount) + ' FCFA';
  }
  
  formatDate(date: Date | string): string {
    if (!date) return '';
    const d = new Date(date);
    return d.toLocaleDateString('fr-FR');
  }




  // Données pour les statistiques (si nécessaire)
statsData = [
  { icon: 'description', iconClass: 'total', value: 0, label: 'Total demandes' }
];

// Formatage court pour les dates
formatDateShort(date: string): string {
  if (!date) return '';
  const d = new Date(date);
  return d.toLocaleDateString('fr-FR');
}

getLineControl(index: number, controlName: string): FormControl {
  const line = this.linesArray.at(index);
  return line.get(controlName) as FormControl;
}





getLineAmount(index: number): number {
  const control = this.getLineControl(index, 'lineAmount');
  return control?.value || 0;
}
}

export { RequestForm as RequestFormComponent };