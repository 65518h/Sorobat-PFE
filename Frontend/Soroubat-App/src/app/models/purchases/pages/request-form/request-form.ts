// src/app/modules/purchases/pages/request-form/request-form.ts

import { Component, OnInit, OnDestroy, ViewChild, ChangeDetectorRef, TemplateRef, ChangeDetectionStrategy, ElementRef, ViewEncapsulation } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router, ActivatedRoute, RouterModule } from '@angular/router';
import { ReactiveFormsModule, FormBuilder, FormGroup, FormArray, Validators, FormControl, AbstractControl } from '@angular/forms';
import { Subject, takeUntil, catchError, of, finalize, forkJoin, switchMap, Observable } from 'rxjs';
import { FormsModule } from '@angular/forms';

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
import { MatPaginatorModule } from '@angular/material/paginator';
import { MatDialog, MatDialogRef, MatDialogModule } from '@angular/material/dialog';

// Scanner - html5-qrcode
import { Html5Qrcode, Html5QrcodeCameraScanConfig } from 'html5-qrcode';

// Services
import { PurchaseRequestService } from '../../services/purchase-request';
import { PurchaseRequestLineService } from '../../services/purchase-request-line.service';
import { LookupService, Project as LookupProject, Vehicule, Location, ProjectTask, Item } from '../../services/lookup.service';
import { NotificationService } from '../../../../core/services/notification';
import { AuthService } from '../../../../core/services/auth';
import { ProjectService } from '../../../projects/services/project';
import { Project as MyProject } from '../../../projects/models/project.model';
import { AudioService } from '../../../../core/services/audio.service';
import { ConfirmationDialogComponent, ConfirmationDialogData } from '../../../../core/components/confirmation-dialog/confirmation-dialog.component';

// Models
import { 
  PurchaseRequest, 
  RequestType, 
  getRequestTypeLabel,
  getRequestTypeIcon
} from '../../models/purchase-request.model';

import { 
  PurchaseRequestLine,
} from '../../models/purchase-request-line.model';

@Component({
  selector: 'app-request-form',
  templateUrl: './request-form.html',
  styleUrls: ['./request-form.css'],

  standalone: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
 
  imports: [
    CommonModule,
    ReactiveFormsModule,
    FormsModule,
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
    MatTooltipModule,
    MatPaginatorModule,
    MatDialogModule
  ]
})
export class RequestForm implements OnInit, OnDestroy {
  
  @ViewChild('stepper') stepper!: MatStepper;
  @ViewChild('articleDialog') articleDialog!: TemplateRef<any>;
  @ViewChild('enginDialog') enginDialog!: TemplateRef<any>;
  @ViewChild('locationDialog') locationDialog!: TemplateRef<any>;
  @ViewChild('taskDialog') taskDialog!: TemplateRef<any>;
  @ViewChild('requestTypeDialog') requestTypeDialog!: TemplateRef<any>;
  @ViewChild('barcodeScannerDialog') barcodeScannerDialog!: TemplateRef<any>;
  
  headerForm!: FormGroup;
  linesForm!: FormGroup;
  filteredLinesArray!: FormArray;
  
  isEditMode: boolean = false;
  requestId: string | null = null;
  requestNo: string | null = null;
  loading: boolean = false;
  submitting: boolean = false;
  creatingHeader: boolean = false;
  createdHeader: PurchaseRequest | null = null;
  
  // Projet automatique du chef de chantier
  autoProject: MyProject | null = null;
  isLoadingProject: boolean = false;
  isFormReady: boolean = false;
  
  // Flag pour éviter les doubles ouvertures de dialogues
  private isDialogOpening: boolean = false;
  
  requestTypes = Object.values(RequestType);
  
  equipment: Vehicule[] = [];
  locations: Location[] = [];
  currentProjectTasks: ProjectTask[] = [];

  
  // Pagination pour les articles
  allItems: Item[] = [];
  paginatedItems: Item[][] = [];
  itemCurrentPages: number[] = [];
  itemTotalPages: number[] = [];
  itemsPerPage: number = 50;
  
  // Filtres et sélections
  searchTerm: string = '';
  selectedType: string = 'all';
  selectedLocation: string = 'all';
  
  // Propriétés pour les dialogues
  private dialogRef: MatDialogRef<any> | null = null;
  private enginDialogRef: MatDialogRef<any> | null = null;
  private locationDialogRef: MatDialogRef<any> | null = null;
  private taskDialogRef: MatDialogRef<any> | null = null;
  private requestTypeDialogRef: MatDialogRef<any> | null = null;
  private barcodeDialogRef: MatDialogRef<any> | null = null;
  
  currentLineIndex: number = -1;
  currentLocationForLine: number = -1;
  currentTaskForLine: number = -1;
  
  articleSearchTerm: string = '';
  filteredArticles: Item[] = [];
  selectedArticle: Item | null = null;
  currentPage: number = 1;
  totalPages: number = 1;
  totalFilteredArticles: number = 0;
  pageSize: number = 200;
  
  enginSearchTerm: string = '';
  filteredEngins: Vehicule[] = [];
  
  locationSearchTerm: string = '';
  filteredLocations: Location[] = [];
  
  taskSearchTerm: string = '';
  filteredTasks: ProjectTask[] = [];
  
  // Scanner
  scanner: Html5Qrcode | null = null;
  scannerLoading: boolean = false;
  
  // Liste des types de demande
  requestTypeList: string[] = [
    'Spare part',
    'Supply and Miscellaneous',
    'Service Delivery',
    'Materials'
  ];
  
  private searchTimeout: any;
  
  private destroy$ = new Subject<void>();
  
  constructor(
    private fb: FormBuilder,
    private router: Router,
    private route: ActivatedRoute,
    private purchaseRequestService: PurchaseRequestService,
    private purchaseRequestLineService: PurchaseRequestLineService,
    private lookupService: LookupService,
    private notificationService: NotificationService,
    private authService: AuthService,
    private cdr: ChangeDetectorRef,
    private dialog: MatDialog,
    private projectService: ProjectService,
    private audioService: AudioService
  ) {
    this.initForms();
    this.filteredLinesArray = this.fb.array([]);
  }
  
  ngOnInit(): void {
    this.loadAutoProject();
    this.loadEquipment();
    this.loadLocations();
    this.loadItems();
    
    this.requestId = this.route.snapshot.paramMap.get('id');
    const url = this.router.url;
    
    console.log(' URL actuelle:', url);
    console.log(' ID récupéré:', this.requestId);
    
    if (this.requestId) {
      this.isEditMode = url.includes('/edit');
      console.log(' Mode édition:', this.isEditMode);
      this.loadRequest(this.requestId);
    } else {
      console.log(' Mode création');
    }
  }
  
  ngOnDestroy(): void {
    if (this.searchTimeout) {
      clearTimeout(this.searchTimeout);
    }
    this.destroy$.next();
    this.destroy$.complete();
    
    // Arrêter le scanner
    if (this.scanner) {
      this.scanner.stop().catch(err => console.warn('Erreur arrêt scanner:', err));
    }
    
    // Fermer tous les dialogues ouverts
    this.closeAllDialogs();
  }
  
  private closeAllDialogs(): void {
    if (this.dialogRef) this.dialogRef.close();
    if (this.enginDialogRef) this.enginDialogRef.close();
    if (this.locationDialogRef) this.locationDialogRef.close();
    if (this.taskDialogRef) this.taskDialogRef.close();
    if (this.requestTypeDialogRef) this.requestTypeDialogRef.close();
    if (this.barcodeDialogRef) this.barcodeDialogRef.close();
  }
  
  private initForms(): void {
    this.headerForm = this.fb.group({
      no: [{ value: '', disabled: true }],
      jobNo: [{ value: '', disabled: true }, Validators.required],
      jobDescription: [{ value: '', disabled: true }],
      requestType: ['', Validators.required],
      engin: [''],
      locationCode: [''],
      descriptionEngin: [{ value: '', disabled: true }],
      observation: ['']
    });
    
    this.linesForm = this.fb.group({
      lines: this.fb.array([])
    });
  }
  
  // ==================== CHARGEMENT DU PROJET AUTOMATIQUE ====================
  
  private loadAutoProject(): void {
    this.isLoadingProject = true;
    this.cdr.markForCheck();
    
    console.log(' Chargement du projet automatique...');
    
    this.projectService.getMyProject().pipe(
      takeUntil(this.destroy$),
      finalize(() => {
        this.isLoadingProject = false;
        this.cdr.markForCheck();
      }),
      catchError((error) => {
        console.error(' Erreur chargement projet:', error);
        this.notificationService.showError('Impossible de charger le projet associé à votre compte');
        return of(null);
      })
    ).subscribe({
      next: (project: MyProject | null) => {
        if (project) {
          this.autoProject = project;
          console.log(' Projet automatique chargé:', {
            no: project.no,
            id: project.id,
            description: project.description
          });
          
          this.headerForm.patchValue({
            jobNo: project.no,
            jobDescription: project.description
          });
          
          this.headerForm.get('jobNo')?.disable();
          this.headerForm.get('jobDescription')?.disable();
          
          this.loadProjectTasks(project.no);
          
          if (!this.isEditMode) {
            this.isFormReady = true;
          }
          
          this.notificationService.showInfo(`Projet associé: ${project.no} - ${project.description}`);
        } else {
          console.warn(' Aucun projet associé');
          this.notificationService.showWarning('Aucun projet associé à votre compte');
          this.isFormReady = true;
        }
        this.cdr.markForCheck();
      }
    });
  }
  
  // ==================== CHARGEMENT DES DONNÉES ====================
  
  private loadEquipment(): void {
    this.lookupService.getVehicules().pipe(
      takeUntil(this.destroy$),
      catchError((error) => {
        console.error('Erreur chargement équipements', error);
        return of([]);
      })
    ).subscribe({
      next: (equipment: Vehicule[]) => {
        this.equipment = equipment || [];
        console.log(' Équipements chargés:', this.equipment.length);
        this.filteredEngins = [...this.equipment];
        this.cdr.markForCheck();
      }
    });
  }
  
  private loadLocations(): void {
    this.lookupService.getLocations().pipe(
      takeUntil(this.destroy$),
      catchError((error) => {
        console.error('Erreur chargement magasins', error);
        return of([]);
      })
    ).subscribe({
      next: (locations: Location[]) => {
        this.locations = locations || [];
        console.log(' Magasins chargés:', this.locations.length);
        this.filteredLocations = [...this.locations];
        this.cdr.markForCheck();
      }
    });
  }
  
  private loadItems(): void {
    this.lookupService.getItems().pipe(
      takeUntil(this.destroy$),
      catchError((error) => {
        console.error('Erreur chargement items', error);
        return of([]);
      })
    ).subscribe({
      next: (items: Item[]) => {
        this.allItems = items.filter(item => item.number && item.number !== '') || [];
        console.log(' Items chargés:', this.allItems.length);
        
        this.paginatedItems = [];
        for (let i = 0; i < this.allItems.length; i += this.itemsPerPage) {
          this.paginatedItems.push(this.allItems.slice(i, i + this.itemsPerPage));
        }
        
        if (this.linesArray) {
          for (let i = 0; i < this.linesArray.length; i++) {
            this.itemCurrentPages[i] = 0;
            this.itemTotalPages[i] = this.paginatedItems.length || 1;
          }
        }
        
        console.log(' Pagination items: ', this.paginatedItems.length, 'pages');
        this.cdr.markForCheck();
      }
    });
  }
  

  
  private loadProjectTasks(projectNo: string): void {
    if (!projectNo) {
      console.warn(' loadProjectTasks appelé sans projectNo');
      return;
    }
    
    console.log(' Chargement des tâches pour le projet:', projectNo);
    
    this.lookupService.getProjectTasks(projectNo).pipe(
      takeUntil(this.destroy$),
      catchError((error) => {
        console.error(' Erreur chargement tâches:', error);
        return of([]);
      })
    ).subscribe({
      next: (tasks: ProjectTask[]) => {
        this.currentProjectTasks = tasks || [];
        this.filteredTasks = [...this.currentProjectTasks];
        console.log(` ${this.currentProjectTasks.length} tâches chargées`);
        this.cdr.markForCheck();
      }
    });
  }
  
  // ==================== CHARGEMENT DEMANDE (ÉDITION) ====================
  
  private loadRequest(id: string): void {
    this.loading = true;
    this.cdr.markForCheck();

    console.log(' Chargement demande ID:', id);
    
    this.purchaseRequestService.getById(id).pipe(
      takeUntil(this.destroy$),
      finalize(() => {
        this.loading = false;
        this.isFormReady = true;
        this.cdr.markForCheck();
      }),
      catchError((error: any) => {
        console.error(' Erreur chargement demande:', error);
        this.notificationService.showError('Impossible de charger la demande');
        this.router.navigate(['/purchases/requests']);
        return of(null);
      })
    ).subscribe({
      next: (request: PurchaseRequest | null) => {
        if (request) {
          this.requestNo = request.no || null;
          this.requestId = request.id || null;
          
          console.log(' Statut de la demande:', request.statut);
          
          this.populateForm(request);
          
          if (this.linesArray) {
            while (this.linesArray.length) {
              this.linesArray.removeAt(0);
            }
          }
          
          if (request.purchaseRequestLines?.length) {
            console.log(` Chargement de ${request.purchaseRequestLines.length} lignes`);
            request.purchaseRequestLines.forEach((line, index) => {
              this.addLineToForm(line);
              this.itemCurrentPages[index] = 0;
              this.itemTotalPages[index] = this.paginatedItems.length || 1;
            });
          }
          
          const isOpen = request.statut === 'Ouvert';
          
          if (!isOpen) {
            this.headerForm.disable();
            this.linesForm.disable();
            this.notificationService.showInfo('Cette demande n\'est plus modifiable');
          } else if (this.isEditMode) {
            this.headerForm.enable();
            this.linesForm.enable();
            this.headerForm.get('jobNo')?.disable();
            this.headerForm.get('jobDescription')?.disable();
          }
          
          if (request.jobNo) {
            this.loadProjectTasks(request.jobNo);
          }
          
          this.cdr.markForCheck();
        }
      }
    });
  }
  
  private populateForm(request: PurchaseRequest): void {
    console.log(' Population du formulaire avec:', request);
    
    const jobNo = this.autoProject?.no || request.jobNo;
    const jobDescription = this.autoProject?.description || request.jobDescription;
    
    this.headerForm.patchValue({
      no: request.no,
      jobNo: jobNo,
      jobDescription: jobDescription,
      requestType: request.requestType,
      engin: request.engin || '',
      locationCode: request.locationCode || '',
      descriptionEngin: request.descriptionEngin || '',
      observation: request.observation || ''
    });
    
    this.headerForm.get('jobNo')?.disable();
    this.headerForm.get('jobDescription')?.disable();
    
    this.cdr.markForCheck();
  }
  
  // ==================== GETTERS ====================
  
  get linesArray(): FormArray {
    return this.linesForm?.get('lines') as FormArray;
  }
  
  getLineControl(index: number, controlName: string): FormControl {
    const line = this.linesArray?.at(index) as FormGroup;
    
    if (!line) {
      return new FormControl('');
    }
    
    if (!line.get(controlName)) {
      if (controlName === 'description') {
        line.addControl(controlName, this.fb.control({ value: '', disabled: true }));
      } else {
        line.addControl(controlName, this.fb.control(''));
      }
    }
    
    return line.get(controlName) as FormControl;
  }
  
  // ==================== GESTION DES LIGNES ====================
  
  private getTypeForBackend(type: string): string {
    switch (type) {
      case 'Fixed Asset':
        return 'Fixed_x0020_Asset';
      case 'Item':
        return 'Item';
      default:
        return type;
    }
  }
  
  private getTypeForDisplay(type: string): string {
    switch (type) {
      case 'Fixed_x0020_Asset':
        return 'Fixed Asset';
      case 'Item':
        return 'Item';
      default:
        return type;
    }
  }
  
  createLineForm(line?: PurchaseRequestLine): FormGroup {
    let displayType = line?.type || 'Item';
    displayType = this.getTypeForDisplay(displayType);
    
    return this.fb.group({
      id: [line?.id || null],
      type: [displayType, Validators.required],
      no: [line?.no || '', Validators.required],
      description: [line?.description || ''],
      quantity: [line?.quantity || 1, [Validators.required, Validators.min(0.01)]],
      unitOfMeasureCode: [line?.unitOfMeasureCode || 'PIECE'],
      locationCode: [line?.locationCode || '', Validators.required],
      jobTaskNo: [line?.jobTaskNo || '0']
    });
  }
  
  addLineToForm(line?: PurchaseRequestLine): void {
    if (!this.linesArray) return;
    
    const newIndex = this.linesArray.length;
    const lineForm = this.createLineForm(line);
    this.linesArray.push(lineForm);
    
    if (line) {
      let displayType = line.type || 'Item';
      displayType = this.getTypeForDisplay(displayType);
      
      lineForm.patchValue({
        id: line.id,
        type: displayType,
        no: line.no || '',
        description: line.description || '',
        quantity: line.quantity || 1,
        unitOfMeasureCode: line.unitOfMeasureCode || 'PIECE',
        locationCode: line.locationCode || '',
        jobTaskNo: line.jobTaskNo || '0'
      });
    } else {
      lineForm.patchValue({ type: 'Item' });
    }
    
    this.itemCurrentPages[newIndex] = 0;
    this.itemTotalPages[newIndex] = this.paginatedItems.length || 1;
    
    this.updateFilteredLines();
    this.cdr.markForCheck();
  }
  
   removeLine(index: number): void {
    if (!this.linesArray) return;
    
    const line = this.linesArray.at(index);
    const itemNo = line.get('no')?.value || 'cet article';
    
    // Boîte de dialogue de confirmation élégante pour la suppression
    const dialogData: ConfirmationDialogData = {
      title: 'Supprimer la ligne',
      message: `Êtes-vous sûr de vouloir supprimer ${itemNo} ?\n\nCette action est irréversible.`,
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
      
      const lineId = this.linesArray.at(index)?.get('id')?.value;
      
      if (lineId && this.isEditMode) {
        this.purchaseRequestLineService.delete(lineId).pipe(
          takeUntil(this.destroy$)
        ).subscribe({
          next: () => {
            console.log(`Ligne ${lineId} supprimée`);
          },
          error: (error) => {
            console.error(`Erreur suppression ligne ${lineId}:`, error);
          }
        });
      }
      
      this.linesArray.removeAt(index);
      this.itemCurrentPages.splice(index, 1);
      this.itemTotalPages.splice(index, 1);
      this.updateFilteredLines();
      this.cdr.markForCheck();
      
      this.notificationService.showSuccess('Ligne supprimée');
    });
  }
  
  duplicateLine(index: number): void {
    const originalLine = this.linesArray.at(index);
    const newLine = this.createLineForm();
    
    newLine.patchValue({
      type: originalLine.get('type')?.value,
      no: originalLine.get('no')?.value,
      description: originalLine.get('description')?.value,
      quantity: originalLine.get('quantity')?.value,
      unitOfMeasureCode: originalLine.get('unitOfMeasureCode')?.value,
      locationCode: originalLine.get('locationCode')?.value,
      jobTaskNo: originalLine.get('jobTaskNo')?.value
    });
    
    this.linesArray.insert(index + 1, newLine);
    
    this.itemCurrentPages.splice(index + 1, 0, 0);
    this.itemTotalPages.splice(index + 1, 0, this.paginatedItems.length || 1);
    
    this.updateFilteredLines();
    this.notificationService.showSuccess('Ligne dupliquée');
    this.cdr.markForCheck();
  }
  
  adjustQuantity(index: number, delta: number): void {
    const quantityControl = this.getLineControl(index, 'quantity');
    let newValue = (quantityControl.value || 0) + delta;
    newValue = Math.max(0.01, newValue);
    quantityControl.setValue(newValue);
    this.cdr.markForCheck();
  }
  
  // ==================== FILTRES ET RECHERCHE ====================
  
  onSearch(): void {
    this.updateFilteredLines();
  }
  
  clearSearch(): void {
    this.searchTerm = '';
    this.onSearch();
  }
  
  onFilterChange(): void {
    this.updateFilteredLines();
  }
  
  updateFilteredLines(): void {
    if (!this.filteredLinesArray) {
      this.filteredLinesArray = this.fb.array([]);
    }
    
    while (this.filteredLinesArray.length) {
      this.filteredLinesArray.removeAt(0);
    }
    
    if (!this.linesArray) return;
    
    for (let i = 0; i < this.linesArray.length; i++) {
      const line = this.linesArray.at(i);
      const shouldShow = this.filterLine(line, i);
      
      if (shouldShow) {
        this.filteredLinesArray.push(line);
      }
    }
    
    this.cdr.markForCheck();
  }
  
  private filterLine(line: AbstractControl, index: number): boolean {
    const type = line.get('type')?.value;
    const locationCode = line.get('locationCode')?.value;
    const no = line.get('no')?.value;
    const description = line.get('description')?.value;
    
    if (this.selectedType !== 'all') {
      if (this.selectedType === 'Item' && type !== 'Item') return false;
    }
    
    if (this.selectedLocation !== 'all' && locationCode !== this.selectedLocation) {
      return false;
    }
    
    if (this.searchTerm) {
      const term = this.searchTerm.toLowerCase();
      const matchesNo = no?.toLowerCase().includes(term);
      const matchesDesc = description?.toLowerCase().includes(term);
      if (!matchesNo && !matchesDesc) return false;
    }
    
    return true;
  }
  
  getOriginalIndex(filteredIndex: number): number {
    if (!this.filteredLinesArray || !this.linesArray) return filteredIndex;
    
    const filteredControl = this.filteredLinesArray.at(filteredIndex);
    for (let i = 0; i < this.linesArray.length; i++) {
      if (this.linesArray.at(i) === filteredControl) {
        return i;
      }
    }
    return filteredIndex;
  }
  
  // ==================== STATISTIQUES ====================
  
  getUniqueTypesCount(): number {
    if (!this.linesArray) return 0;
    
    const types = new Set();
    for (let i = 0; i < this.linesArray.length; i++) {
      types.add(this.linesArray.at(i).get('type')?.value);
    }
    return types.size;
  }
  
  getUniqueLocationsCount(): number {
    if (!this.linesArray) return 0;
    
    const locations = new Set();
    for (let i = 0; i < this.linesArray.length; i++) {
      const location = this.linesArray.at(i).get('locationCode')?.value;
      if (location) locations.add(location);
    }
    return locations.size;
  }
  
 clearAllLines(): void {
    if (!this.linesArray) return;
    
    if (this.linesArray.length === 0) return;
    
    // Boîte de dialogue de confirmation élégante pour suppression de toutes les lignes
    const dialogData: ConfirmationDialogData = {
      title: 'Supprimer tous les articles',
      message: `Êtes-vous sûr de vouloir supprimer les ${this.linesArray.length} articles de la demande ?\n\nCette action est irréversible.`,
      confirmText: 'Tout supprimer',
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
      
      while (this.linesArray.length) {
        this.linesArray.removeAt(0);
      }
      
      this.itemCurrentPages = [];
      this.itemTotalPages = [];
      this.updateFilteredLines();
      this.notificationService.showSuccess('Tous les articles ont été supprimés');
      this.cdr.markForCheck();
    });
  }
  
  // ==================== CRÉATION EN-TÊTE ====================
  
  createHeaderAndContinue(): void {
    if (this.headerForm.invalid) {
      this.headerForm.markAllAsTouched();
      this.notificationService.showWarning('Veuillez remplir tous les champs obligatoires');
      return;
    }
    
    if (!this.autoProject) {
      this.notificationService.showError('Aucun projet associé à votre compte. Impossible de créer la demande.');
      return;
    }
    
    this.creatingHeader = true;
    this.cdr.markForCheck();
    
    const formValues = this.headerForm.getRawValue();
    
    const requestData: any = {
      jobNo: this.autoProject.no,
      requestType: formValues.requestType,
      engin: formValues.engin || '',
      locationCode: formValues.locationCode || '',
      observation: formValues.observation || ''
    };
    
    console.log(' Création en-tête:', requestData);
    
    this.purchaseRequestService.create(requestData).pipe(
      takeUntil(this.destroy$),
      finalize(() => {
        this.creatingHeader = false;
        this.cdr.markForCheck();
      })
    ).subscribe({
      next: (created: PurchaseRequest) => {
        this.createdHeader = created;
        this.requestNo = created.no || null;
        this.requestId = created.id || null;
        
        this.cdr.markForCheck();
        
        console.log(' En-tête créé avec succès:', created);
        this.notificationService.showSuccess(`Demande N°${created.no} créée avec succès`);
        
        if (this.autoProject?.no) {
          this.loadProjectTasks(this.autoProject.no);
        }
        
        this.stepper.next();
        this.cdr.markForCheck();
      },
      error: (error: any) => {
        console.error(' Erreur création en-tête:', error);
        const errorMessage = error.error?.message || error.message || 'Erreur lors de la création';
        this.notificationService.showError(errorMessage);
        this.cdr.markForCheck();
      }
    });
  }
  
  // ==================== CRÉATION DES LIGNES ====================
  
  private getLinesDataForCreation(documentNo: string): any[] {
    const lines: any[] = [];
    if (!this.linesArray) return lines;
    
    for (let i = 0; i < this.linesArray.length; i++) {
      const lineForm = this.linesArray.at(i);
      let typeValue = lineForm.get('type')?.value || 'Item';
      typeValue = this.getTypeForBackend(typeValue);
      
      const line = {
        documentNo: documentNo,
        jobNo: this.autoProject?.no || this.headerForm.get('jobNo')?.value,
        jobTaskNo: lineForm.get('jobTaskNo')?.value || '0',
        type: typeValue,
        no: lineForm.get('no')?.value || '',
        quantity: lineForm.get('quantity')?.value || 0,
        locationCode: lineForm.get('locationCode')?.value || ''
      };
      
      lines.push(line);
    }
    return lines;
  }
  
  createLinesAndFinish(): void {
    if (!this.linesArray || this.linesArray.length === 0) {
      this.notificationService.showWarning('Ajoutez au moins une ligne à la demande');
      return;
    }
    
    if (!this.requestNo) {
      this.notificationService.showError('Aucune demande associée');
      return;
    }
    
    this.submitting = true;
    this.cdr.markForCheck();
    
    const linesData = this.getLinesDataForCreation(this.requestNo);
    
    console.log(` Création de ${linesData.length} ligne(s) pour:`, this.requestNo);
    
    this.purchaseRequestLineService.createBatch(linesData).pipe(
      takeUntil(this.destroy$),
      finalize(() => {
        this.submitting = false;
        this.cdr.markForCheck();
      })
    ).subscribe({
      next: (response) => {
        console.log(' Lignes créées avec succès:', response);
        this.notificationService.showSuccess(`Demande ${this.requestNo} créée avec succès`);
        this.router.navigate(['/purchases/requests']);
      },
      error: (error: any) => {
        console.error(' Erreur création lignes:', error);
        this.notificationService.showError('Erreur lors de la création des lignes');
      }
    });
  }
  
  // ==================== MISE À JOUR (ÉDITION) ====================
  
  updateRequest(): void {
    if (!this.requestId) return;
    
    if (this.headerForm.invalid) {
      this.notificationService.showWarning('Veuillez remplir tous les champs obligatoires');
      return;
    }
    
    this.submitting = true;
    this.cdr.markForCheck();
    
    const formValues = this.headerForm.getRawValue();
    
    const updateData: any = {
      requestType: formValues.requestType,
      engin: formValues.engin || '',
      locationCode: formValues.locationCode || '',
      observation: formValues.observation || ''
    };
    
    console.log(' Mise à jour en-tête:', updateData);
    
    this.purchaseRequestService.update(this.requestId, updateData).pipe(
      takeUntil(this.destroy$),
      switchMap(() => this.updateAllLines()),
      finalize(() => {
        this.submitting = false;
        this.cdr.markForCheck();
      })
    ).subscribe({
      next: () => {
        this.notificationService.showSuccess('Demande mise à jour avec succès');
        this.router.navigate(['/purchases/requests']);
      },
      error: (error: any) => {
        console.error(' Erreur mise à jour:', error);
        this.notificationService.showError('Erreur lors de la mise à jour');
      }
    });
  }
  
  private updateAllLines(): Observable<any> {
    const updateObservables: Observable<any>[] = [];
    const newLinesBatch: any[] = [];
    
    if (!this.requestNo) {
      console.error(' requestNo est null');
      return of(null);
    }
    
    if (!this.linesArray) return of(null);
    
    for (let i = 0; i < this.linesArray.length; i++) {
      const lineForm = this.linesArray.at(i);
      const lineId = lineForm.get('id')?.value;
      
      const no = lineForm.get('no')?.value;
      const description = lineForm.get('description')?.value;
      const quantity = lineForm.get('quantity')?.value;
      const locationCode = lineForm.get('locationCode')?.value;
      const jobTaskNo = lineForm.get('jobTaskNo')?.value;
      let type = lineForm.get('type')?.value;
      
      if (!no) {
        this.notificationService.showError(`Ligne ${i + 1}: Veuillez sélectionner un article`);
        return of(null);
      }
      
      if (!quantity || quantity <= 0) {
        this.notificationService.showError(`Ligne ${i + 1}: La quantité doit être supérieure à 0`);
        return of(null);
      }
      
      if (!locationCode || locationCode === '') {
        this.notificationService.showError(`Ligne ${i + 1}: Veuillez sélectionner un magasin`);
        return of(null);
      }
      
      if (lineId) {
        const updateLineData: any = {
          quantity: quantity,
          locationCode: locationCode
        };
        
        if (description !== undefined && description !== null && description !== '') {
          updateLineData.description = description;
        }
        
        if (no !== undefined && no !== null && no !== '') updateLineData.no = no;
        if (jobTaskNo !== undefined && jobTaskNo !== null && jobTaskNo !== '0') updateLineData.jobTaskNo = jobTaskNo;
        
        console.log(` PATCH ligne ${lineId}:`, updateLineData);
        
        if (Object.keys(updateLineData).length > 0) {
          updateObservables.push(
            this.purchaseRequestLineService.update(lineId, updateLineData).pipe(
              catchError(error => {
                console.error(` Erreur mise à jour ligne ${lineId}:`, error);
                this.notificationService.showError(`Erreur ligne ${i + 1}`);
                return of(null);
              })
            )
          );
        }
      } else {
        let typeForBackend = this.getTypeForBackend(type || 'Item');
        
        newLinesBatch.push({
          documentNo: this.requestNo,
          jobNo: this.autoProject?.no || this.headerForm.get('jobNo')?.value,
          jobTaskNo: jobTaskNo || '0',
          type: typeForBackend,
          no: no,
          description: description || '',
          quantity: quantity,
          locationCode: locationCode
        });
      }
    }
    
    if (newLinesBatch.length > 0) {
      updateObservables.push(
        this.purchaseRequestLineService.createBatch(newLinesBatch).pipe(
          catchError(error => {
            console.error(' Erreur création batch:', error);
            this.notificationService.showError('Erreur création nouvelles lignes');
            return of(null);
          })
        )
      );
    }
    
    if (updateObservables.length === 0) {
      return of(null);
    }
    
    return forkJoin(updateObservables);
  }
  
  // ==================== DIALOGUE DE SÉLECTION D'ARTICLES ====================
  
  trackByArticleCode(index: number, item: Item): string {
    return item.number;
  }
  
  openArticleDialog(lineIndex: number): void {
    if (this.isDialogOpening || this.dialogRef) {
      return;
    }
    
    this.isDialogOpening = true;
    this.currentLineIndex = lineIndex;
    this.articleSearchTerm = '';
    this.currentPage = 1;
    this.selectedArticle = null;
    
    this.filterArticles();
    
    const overlayRef = this.dialog.open(this.articleDialog, {
      width: '850px',
      maxWidth: '90vw',
      maxHeight: '80vh',
      panelClass: 'article-dialog-panel',
      disableClose: false,
      backdropClass: 'custom-heavy-backdrop',
      hasBackdrop: true
    });
    
    this.dialogRef = overlayRef;
    
    setTimeout(() => {
      const backdrops = document.querySelectorAll('.cdk-overlay-backdrop');
      backdrops.forEach(backdrop => {
        if (backdrop.classList.contains('custom-heavy-backdrop')) {
          (backdrop as HTMLElement).style.backgroundColor = '#373737';
          (backdrop as HTMLElement).style.opacity = '0.95';
          (backdrop as HTMLElement).style.backdropFilter = 'blur(8px)';
        }
      });
    }, 0);
    
    this.dialogRef.afterClosed().subscribe(() => {
      this.dialogRef = null;
      this.isDialogOpening = false;
      this.cdr.markForCheck();
    });
  }
  
  closeArticleDialog(): void {
    if (this.dialogRef) {
      this.dialogRef.close();
      this.dialogRef = null;
    }
    this.isDialogOpening = false;
  }
  
  filterArticles(): void {
    if (this.searchTimeout) {
      clearTimeout(this.searchTimeout);
    }
    
    this.searchTimeout = setTimeout(() => {
      if (!this.allItems || this.allItems.length === 0) {
        this.filteredArticles = [];
        this.totalFilteredArticles = 0;
        this.totalPages = 1;
        this.cdr.markForCheck();
        return;
      }
      
      let filtered = [...this.allItems];
      
      if (this.articleSearchTerm && this.articleSearchTerm.trim() !== '') {
        const term = this.articleSearchTerm.toLowerCase().trim();
        filtered = filtered.filter(item =>
          (item.number && item.number.toLowerCase().includes(term)) ||
          (item.displayName && item.displayName.toLowerCase().includes(term))
        );
      }
      
      this.totalFilteredArticles = filtered.length;
      this.totalPages = Math.max(1, Math.ceil(this.totalFilteredArticles / this.pageSize));
      
      if (this.currentPage < 1) this.currentPage = 1;
      if (this.currentPage > this.totalPages) this.currentPage = this.totalPages;
      
      const start = (this.currentPage - 1) * this.pageSize;
      const end = start + this.pageSize;
      this.filteredArticles = filtered.slice(start, end);
      
      this.cdr.markForCheck();
    }, 300);
  }
  
  nextPage(): void {
    if (this.currentPage < this.totalPages) {
      this.currentPage++;
      this.filterArticles();
    }
  }
  
  previousPage(): void {
    if (this.currentPage > 1) {
      this.currentPage--;
      this.filterArticles();
    }
  }
  
  selectArticle(item: Item): void {
    this.selectedArticle = item;
    
    const lineForm = this.linesArray.at(this.currentLineIndex);
    lineForm.patchValue({
      no: item.number,
      description: item.displayName,
      unitOfMeasureCode: item.baseUnitOfMeasure
    });
    
    this.closeArticleDialog();
    this.notificationService.showSuccess(`Article "${item.displayName}" sélectionné`);
    this.cdr.markForCheck();
  }
  
  // ==================== SCANNEUR CODE-BARRES ====================
  
  openBarcodeScanner(lineIndex: number): void {
    if (this.isDialogOpening || this.barcodeDialogRef) {
      return;
    }
    
    this.isDialogOpening = true;
    this.currentLineIndex = lineIndex;
    
    const overlayRef = this.dialog.open(this.barcodeScannerDialog, {
      width: '550px',
      maxWidth: '90vw',
      panelClass: 'barcode-scanner-panel',
      disableClose: true,
      backdropClass: 'custom-heavy-backdrop',
      hasBackdrop: true
    });
    
    this.barcodeDialogRef = overlayRef;
    
    setTimeout(() => {
      const backdrops = document.querySelectorAll('.cdk-overlay-backdrop');
      backdrops.forEach(backdrop => {
        if (backdrop.classList.contains('custom-heavy-backdrop')) {
          (backdrop as HTMLElement).style.backgroundColor = '#373737';
          (backdrop as HTMLElement).style.opacity = '0.95';
          (backdrop as HTMLElement).style.backdropFilter = 'blur(8px)';
        }
      });
    }, 0);
    
    this.barcodeDialogRef.afterOpened().subscribe(() => {
      setTimeout(() => this.startScanner(), 500);
    });
    
    this.barcodeDialogRef.afterClosed().subscribe(() => {
      this.barcodeDialogRef = null;
      this.isDialogOpening = false;
      this.stopScanner();
      this.cdr.markForCheck();
    });
  }
  
  private async startScanner(): Promise<void> {
    const config: Html5QrcodeCameraScanConfig = {
      fps: 10,
      qrbox: { width: 250, height: 250 },
      aspectRatio: 1.0
    };
    
    try {
      this.scanner = new Html5Qrcode('scanner-reader');
      await this.scanner.start(
        { facingMode: 'environment' },
        config,
        (decodedText) => this.onScanSuccess(decodedText),
        (error) => {
          if (!error?.includes('No MultiFormat Readers')) {
            console.warn('Scan error:', error);
          }
        }
      );
      console.log(' Scanner démarré');
    } catch (error) {
      console.error(' Erreur démarrage scanner:', error);
      this.audioService.playError();
      this.notificationService.showError('Impossible d\'accéder à la caméra. Vérifiez les permissions.');
      this.closeBarcodeScanner();
    }
  }
  
  private async stopScanner(): Promise<void> {
    if (this.scanner) {
      try {
        await this.scanner.stop();
        this.scanner = null;
        console.log(' Scanner arrêté');
      } catch (error) {
        console.warn('Erreur arrêt scanner:', error);
      }
    }
  }
  
  closeBarcodeScanner(): void {
    if (this.barcodeDialogRef) {
      this.barcodeDialogRef.close();
      this.barcodeDialogRef = null;
    }
    this.isDialogOpening = false;
  }
  
  onScanSuccess(scannedCode: string): void {
    console.log(' Code-barres scanné:', scannedCode);
    
    this.audioService.playScanSuccess();
    
    if (this.currentLineIndex !== -1 && scannedCode) {
      this.processScannedCode(scannedCode, this.currentLineIndex);
    }
  }
  
  private processScannedCode(scannedCode: string, lineIndex: number): void {
    this.scannerLoading = true;
    this.cdr.markForCheck();
    
    // Arrêter le scanner pendant la recherche
    this.stopScanner();
    
    // Rechercher l'article par son code
    const foundItem = this.allItems.find(item => 
      item.number === scannedCode || 
      (item.number && item.number.toLowerCase() === scannedCode.toLowerCase())
    );
    
    setTimeout(() => {
      this.scannerLoading = false;
      
      if (foundItem) {
        const lineForm = this.linesArray.at(lineIndex);
        lineForm.patchValue({
          no: foundItem.number,
          description: foundItem.displayName,
          unitOfMeasureCode: foundItem.baseUnitOfMeasure || 'PIECE'
        });
        
        
        this.closeBarcodeScanner();
      } else {
        // Jouer le son d'erreur
        this.audioService.playError();
        
        // Boîte de dialogue de confirmation élégante pour article non trouvé
        const dialogData: ConfirmationDialogData = {
          title: 'Article non trouvé',
          message: `L'article "${scannedCode}" n'existe pas dans la base.\n\nSouhaitez-vous rechercher cet article manuellement ?`,
          confirmText: 'Rechercher',
          cancelText: 'Réessayer',
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
          if (confirmed) {
            // Recherche manuelle
            this.closeBarcodeScanner();
            this.openArticleDialog(lineIndex);
            setTimeout(() => {
              this.articleSearchTerm = scannedCode;
              this.filterArticles();
              this.cdr.markForCheck();
            }, 100);
          } else {
            // Réessayer de scanner
            this.startScanner();
          }
        });
      }
      
      this.cdr.markForCheck();
    }, 500);
  }
  
  // ==================== DIALOGUE ENGIN ====================
  
  openEnginDialog(): void {
    if (this.isDialogOpening || this.enginDialogRef) {
      return;
    }
    
    this.isDialogOpening = true;
    this.enginSearchTerm = '';
    this.filterEngins();
    
    const overlayRef = this.dialog.open(this.enginDialog, {
      width: '550px',
      maxWidth: '90vw',
      maxHeight: '70vh',
      panelClass: 'simple-dialog-panel',
      disableClose: false,
      backdropClass: 'custom-heavy-backdrop',
      hasBackdrop: true
    });
    
    this.enginDialogRef = overlayRef;
    
    setTimeout(() => {
      const backdrops = document.querySelectorAll('.cdk-overlay-backdrop');
      backdrops.forEach(backdrop => {
        if (backdrop.classList.contains('custom-heavy-backdrop')) {
          (backdrop as HTMLElement).style.backgroundColor = '#373737';
          (backdrop as HTMLElement).style.opacity = '0.95';
          (backdrop as HTMLElement).style.backdropFilter = 'blur(8px)';
        }
      });
    }, 0);
    
    this.enginDialogRef.afterClosed().subscribe(() => {
      this.enginDialogRef = null;
      this.isDialogOpening = false;
      this.cdr.markForCheck();
    });
  }
  
  closeEnginDialog(): void {
    if (this.enginDialogRef) {
      this.enginDialogRef.close();
      this.enginDialogRef = null;
    }
    this.isDialogOpening = false;
  }
  
  filterEngins(): void {
    if (!this.equipment || this.equipment.length === 0) {
      this.filteredEngins = [];
      return;
    }
    
    let filtered = [...this.equipment];
    
    if (this.enginSearchTerm && this.enginSearchTerm.trim() !== '') {
      const term = this.enginSearchTerm.toLowerCase().trim();
      filtered = filtered.filter(engin =>
        (engin.code && engin.code.toLowerCase().includes(term)) ||
        (engin.designation && engin.designation.toLowerCase().includes(term))
      );
    }
    
    this.filteredEngins = filtered;
    this.cdr.markForCheck();
  }
  
  selectEngin(engin: Vehicule): void {
    this.headerForm.patchValue({
      engin: engin.code,
      descriptionEngin: engin.designation
    });
    this.closeEnginDialog();
    this.notificationService.showSuccess(`Engin "${engin.code}" sélectionné`);
    this.cdr.markForCheck();
  }
  
  // ==================== DIALOGUE MAGASIN ====================
  
  openLocationDialog(lineIndex?: number): void {
    if (this.isDialogOpening || this.locationDialogRef) {
      return;
    }
    
    this.isDialogOpening = true;
    this.locationSearchTerm = '';
    this.currentLocationForLine = lineIndex !== undefined ? lineIndex : -1;
    this.filterLocations();
    
    const overlayRef = this.dialog.open(this.locationDialog, {
      width: '550px',
      maxWidth: '90vw',
      maxHeight: '70vh',
      panelClass: 'simple-dialog-panel',
      disableClose: false,
      backdropClass: 'custom-heavy-backdrop',
      hasBackdrop: true
    });
    
    this.locationDialogRef = overlayRef;
    
    setTimeout(() => {
      const backdrops = document.querySelectorAll('.cdk-overlay-backdrop');
      backdrops.forEach(backdrop => {
        if (backdrop.classList.contains('custom-heavy-backdrop')) {
          (backdrop as HTMLElement).style.backgroundColor = '#373737';
          (backdrop as HTMLElement).style.opacity = '0.95';
          (backdrop as HTMLElement).style.backdropFilter = 'blur(8px)';
        }
      });
    }, 0);
    
    this.locationDialogRef.afterClosed().subscribe(() => {
      this.locationDialogRef = null;
      this.isDialogOpening = false;
      this.cdr.markForCheck();
    });
  }
  
  closeLocationDialog(): void {
    if (this.locationDialogRef) {
      this.locationDialogRef.close();
      this.locationDialogRef = null;
    }
    this.isDialogOpening = false;
  }
  
  filterLocations(): void {
    if (!this.locations || this.locations.length === 0) {
      this.filteredLocations = [];
      return;
    }
    
    let filtered = [...this.locations];
    
    if (this.locationSearchTerm && this.locationSearchTerm.trim() !== '') {
      const term = this.locationSearchTerm.toLowerCase().trim();
      filtered = filtered.filter(location =>
        (location.code && location.code.toLowerCase().includes(term)) ||
        (location.name && location.name.toLowerCase().includes(term))
      );
    }
    
    this.filteredLocations = filtered;
    this.cdr.markForCheck();
  }
  
  selectLocation(location: Location): void {
    if (this.currentLocationForLine >= 0) {
      const lineForm = this.linesArray.at(this.currentLocationForLine);
      lineForm.patchValue({
        locationCode: location.code
      });
      this.notificationService.showSuccess(`Magasin "${location.code}" sélectionné pour la ligne`);
    } else {
      this.headerForm.patchValue({
        locationCode: location.code
      });
      this.notificationService.showSuccess(`Magasin "${location.code}" sélectionné`);
    }
    this.closeLocationDialog();
    this.cdr.markForCheck();
  }
  
  // ==================== DIALOGUE TÂCHE ====================
  
  openTaskDialog(lineIndex: number): void {
    if (this.isDialogOpening || this.taskDialogRef) {
      return;
    }
    
    this.isDialogOpening = true;
    this.currentTaskForLine = lineIndex;
    this.taskSearchTerm = '';
    this.filterTasks();
    
    const overlayRef = this.dialog.open(this.taskDialog, {
      width: '550px',
      maxWidth: '90vw',
      maxHeight: '70vh',
      panelClass: 'simple-dialog-panel',
      disableClose: false,
      backdropClass: 'custom-heavy-backdrop',
      hasBackdrop: true
    });
    
    this.taskDialogRef = overlayRef;
    
    setTimeout(() => {
      const backdrops = document.querySelectorAll('.cdk-overlay-backdrop');
      backdrops.forEach(backdrop => {
        if (backdrop.classList.contains('custom-heavy-backdrop')) {
          (backdrop as HTMLElement).style.backgroundColor = '#373737';
          (backdrop as HTMLElement).style.opacity = '0.95';
          (backdrop as HTMLElement).style.backdropFilter = 'blur(8px)';
        }
      });
    }, 0);
    
    this.taskDialogRef.afterClosed().subscribe(() => {
      this.taskDialogRef = null;
      this.isDialogOpening = false;
      this.cdr.markForCheck();
    });
  }
  
  closeTaskDialog(): void {
    if (this.taskDialogRef) {
      this.taskDialogRef.close();
      this.taskDialogRef = null;
    }
    this.isDialogOpening = false;
  }
  
  filterTasks(): void {
    if (!this.currentProjectTasks || this.currentProjectTasks.length === 0) {
      this.filteredTasks = [];
      return;
    }
    
    let filtered = [...this.currentProjectTasks];
    
    if (this.taskSearchTerm && this.taskSearchTerm.trim() !== '') {
      const term = this.taskSearchTerm.toLowerCase().trim();
      filtered = filtered.filter(task =>
        (task.taskNo && task.taskNo.toLowerCase().includes(term)) ||
        (task.description && task.description.toLowerCase().includes(term))
      );
    }
    
    this.filteredTasks = filtered;
    this.cdr.markForCheck();
  }
  
  selectTask(task: ProjectTask): void {
    if (this.currentTaskForLine >= 0) {
      const lineForm = this.linesArray.at(this.currentTaskForLine);
      lineForm.patchValue({
        jobTaskNo: task.taskNo
      });
      this.notificationService.showSuccess(`Tâche "${task.taskNo}" sélectionnée`);
    }
    this.closeTaskDialog();
    this.cdr.markForCheck();
  }
  
  // ==================== DIALOGUE TYPE DE DEMANDE ====================
  
  getRequestTypeLabel(type: string): string {
    return getRequestTypeLabel(type);
  }
  
  getRequestTypeIcon(type: string): string {
    return getRequestTypeIcon(type);
  }
  
  getRequestTypeDescription(type: string): string {
    switch (type) {
      case 'Spare part': return 'Pièces de rechange et composants mécaniques';
      case 'Supply and Miscellaneous': return 'Fournitures diverses et consommables';
      case 'Service Delivery': return 'Prestations de services externes';
      case 'Materials': return 'Matériaux de construction';
      default: return 'Type de demande';
    }
  }
  
  getRequestTypeClassForBadge(type: string): string {
    switch (type) {
      case 'Spare part': return 'spare-part';
      case 'Supply and Miscellaneous': return 'supply';
      case 'Service Delivery': return 'service';
      case 'Materials': return 'materials';
      default: return 'default';
    }
  }
  
  openRequestTypeDialog(): void {
    if (this.isDialogOpening || this.requestTypeDialogRef) {
      return;
    }
    
    this.isDialogOpening = true;
    
    const overlayRef = this.dialog.open(this.requestTypeDialog, {
      width: '550px',
      maxWidth: '90vw',
      maxHeight: '70vh',
      panelClass: 'simple-dialog-panel',
      disableClose: false,
      backdropClass: 'custom-heavy-backdrop',
      hasBackdrop: true
    });
    
    this.requestTypeDialogRef = overlayRef;
    
    setTimeout(() => {
      const backdrops = document.querySelectorAll('.cdk-overlay-backdrop');
      backdrops.forEach(backdrop => {
        if (backdrop.classList.contains('custom-heavy-backdrop')) {
          (backdrop as HTMLElement).style.backgroundColor = '#373737';
          (backdrop as HTMLElement).style.opacity = '0.95';
          (backdrop as HTMLElement).style.backdropFilter = 'blur(8px)';
        }
      });
    }, 0);
    
    this.requestTypeDialogRef.afterClosed().subscribe(() => {
      this.requestTypeDialogRef = null;
      this.isDialogOpening = false;
      this.cdr.markForCheck();
    });
  }
  
  closeRequestTypeDialog(): void {
    if (this.requestTypeDialogRef) {
      this.requestTypeDialogRef.close();
      this.requestTypeDialogRef = null;
    }
    this.isDialogOpening = false;
  }
  
  selectRequestType(type: string): void {
    this.headerForm.patchValue({
      requestType: type
    });
    this.closeRequestTypeDialog();
    this.notificationService.showSuccess(`Type "${this.getRequestTypeLabel(type)}" sélectionné`);
    this.cdr.markForCheck();
  }
  
  // ==================== ÉVÉNEMENTS ====================
  
  onSubmit(): void {
    if (this.isEditMode) {
      this.updateRequest();
    }
  }
  
  cancel(): void {
    const hasLines = this.linesArray && this.linesArray.length > 0;
    const hasChanges = this.headerForm.dirty;
    
    if (hasLines || hasChanges) {
      // Boîte de dialogue de confirmation élégante pour quitter sans sauvegarder
      const dialogData: ConfirmationDialogData = {
        title: 'Quitter sans sauvegarder',
        message: 'Vous avez des modifications non enregistrées.\n\nVoulez-vous vraiment quitter sans sauvegarder ?',
        confirmText: 'Quitter',
        cancelText: 'Continuer',
        confirmColor: 'warn',
        cancelColor: 'primary'
      };
      
      const dialogRef = this.dialog.open(ConfirmationDialogComponent, {
        data: dialogData,
        width: '450px',
        panelClass: 'confirmation-dialog-panel',
        disableClose: true
      });
      
      dialogRef.afterClosed().subscribe((confirmed: boolean) => {
        if (confirmed) {
          this.router.navigate(['/purchases/requests']);
        }
      });
    } else {
      this.router.navigate(['/purchases/requests']);
    }
  }
  formatDateForApi(date: Date | string): string {
    if (!date) return '';
    const d = new Date(date);
    return d.toISOString().split('T')[0];
  }
}

export { RequestForm as RequestFormComponent };