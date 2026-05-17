// src/app/modules/gasoil/pages/gasoil-form/gasoil-form.ts

import { Component, OnInit, OnDestroy, inject, ChangeDetectorRef, NgZone } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute, Router, RouterModule } from '@angular/router';
import { FormBuilder, FormGroup, FormArray, Validators, ReactiveFormsModule } from '@angular/forms';
import { Subject, takeUntil, finalize, of } from 'rxjs';
import { switchMap } from 'rxjs/operators';
import { FormsModule } from '@angular/forms';

// Angular Material
import { MatCardModule } from '@angular/material/card';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatSelectModule } from '@angular/material/select';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { MatTooltipModule } from '@angular/material/tooltip';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatNativeDateModule } from '@angular/material/core';
import { MatDividerModule } from '@angular/material/divider';

// Services
import { GasoilService } from '../../services/gasoil.service';
import { StockService } from '../../../../models/inventory/services/stock';
import { NotificationService } from '../../../../core/services/notification';
import { AuthService } from '../../../../core/services/auth';
import { VehiculeService, Vehicule } from '../../services/vehicule.service';

// Models
import { GasoilHeader, GasoilLine, getIndexTypeLabel } from '../../models/gasoil.model';

interface LocationOption {
  code: string;
  name: string;
}

interface VehicleLastIndex {
  kmIndex: number;
  hourIndex: number;
}

@Component({
  selector: 'app-gasoil-form',
  standalone: true,
  imports: [
    CommonModule,
    ReactiveFormsModule,
    FormsModule,
    RouterModule,
    MatCardModule,
    MatFormFieldModule,
    MatInputModule,
    MatSelectModule,
    MatButtonModule,
    MatIconModule,
    MatProgressSpinnerModule,
    MatTooltipModule,
    MatDatepickerModule,
    MatNativeDateModule,
    MatDividerModule
  ],
  templateUrl: './gasoil-form.html',
  styleUrls: ['./gasoil-form.css']
})
export class GasoilFormComponent implements OnInit, OnDestroy {
  
  private fb = inject(FormBuilder);
  private gasoilService = inject(GasoilService);
  private stockService = inject(StockService);
  private vehiculeService = inject(VehiculeService);
  private route = inject(ActivatedRoute);
  private router = inject(Router);
  private notificationService = inject(NotificationService);
  private authService = inject(AuthService);
  private cdr = inject(ChangeDetectorRef);
  private ngZone = inject(NgZone);
  
  headerForm!: FormGroup;
  loading = false;
  isEditMode = false;
  headerId: string | null = null;
  existingHeader: GasoilHeader | null = null;
  
  // Options magasins
  locationOptions: LocationOption[] = [];
  isLoadingLocations = false;
  currentProjectNo = '';
  
  // Modal magasin
  showMagasinModal = false;
  magasinSearchTerm = '';
  filteredMagasins: LocationOption[] = [];
  tempSelectedMagasin: LocationOption | null = null;
  selectedMagasin: LocationOption | null = null;
  
  // Véhicules
  vehiculesList: Vehicule[] = [];
  isLoadingVehicules = false;
  
  // Cache des derniers index des véhicules
  private lastIndexCache = new Map<string, VehicleLastIndex>();
  
  // Modal véhicule
  showVehiculeModal = false;
  vehiculeSearchTerm = '';
  filteredVehicules: Vehicule[] = [];
  tempSelectedVehicule: Vehicule | null = null;
  currentLineIndexForVehicule = -1;
  
  private destroy$ = new Subject<void>();
  
  indexTypeOptions = [
    { value: 'Horaire', label: 'Heures' },
    { value: 'Kilometrage', label: 'Kilomètres' }
  ];
  
  constructor() {
    this.initForm();
  }
  
  ngOnInit(): void {
    this.loadCurrentProject();
    this.loadLocationsFromStock();
    this.loadVehicules();
    this.checkEditMode();
  }
  
  ngOnDestroy(): void {
    this.destroy$.next();
    this.destroy$.complete();
  }
  
  private initForm(): void {
    this.headerForm = this.fb.group({
      date: [new Date().toISOString().split('T')[0], Validators.required],
      locationCode: ['', Validators.required],
      fileNo: ['', Validators.maxLength(20)],
      gasoilLines: this.fb.array([])
    });
  }
  
  get gasoilLines(): FormArray {
    return this.headerForm.get('gasoilLines') as FormArray;
  }
  
  getLinesControls(): FormGroup[] {
    return this.gasoilLines.controls as FormGroup[];
  }
  
  createLineForm(line?: GasoilLine): FormGroup {
    return this.fb.group({
      id: [line?.id || null],
      vehicleNo: [line?.vehicleNo || '', Validators.required],
      quantity: [line?.quantity || null, [Validators.required, Validators.min(0.1)]],
      indexType: [line?.indexType || 'Kilometrage'],
      hourIndex: [line?.hourIndex || null],
      kmIndex: [line?.kmIndex || null],
      lineNo: [line?.lineNo || null]
    });
  }
  
  addLine(line?: GasoilLine): void {
    if (!this.gasoilLines) {
      console.warn('⚠️ gasoilLines non disponible');
      return;
    }
    
    const lineForm = this.createLineForm(line);
    this.gasoilLines.push(lineForm);
    this.cdr.detectChanges();
  }
  
  removeLine(index: number): void {
    const line = this.gasoilLines.at(index) as FormGroup;
    const vehicleNo = line.get('vehicleNo')?.value || 'cette ligne';
    
    if (confirm(`Supprimer ${vehicleNo} ?`)) {
      this.gasoilLines.removeAt(index);
      this.cdr.detectChanges();
      
      if (this.gasoilLines.length === 0) {
        this.notificationService.showInfo('Aucune ligne de consommation. Vous pourrez en ajouter plus tard.');
      } else {
        this.notificationService.showSuccess('Ligne supprimée avec succès');
      }
    }
  }
  
  private loadCurrentProject(): void {
    const user = this.authService.getCurrentUser();
    if (user && user.projet) {
      this.currentProjectNo = user.projet;
      console.log('📁 Projet connecté:', this.currentProjectNo);
    }
  }
  
  private loadLocationsFromStock(): void {
    this.isLoadingLocations = true;
    
    this.stockService.getAllStock().pipe(
      takeUntil(this.destroy$),
      finalize(() => {
        this.isLoadingLocations = false;
      })
    ).subscribe({
      next: (stockItems) => {
        const uniqueLocations = new Map<string, string>();
        
        stockItems.forEach(item => {
          if (item.locationCode && !uniqueLocations.has(item.locationCode)) {
            const locationName = (item as any).locationName || item.locationCode;
            uniqueLocations.set(item.locationCode, locationName);
          }
        });
        
        this.locationOptions = Array.from(uniqueLocations.entries()).map(([code, name]) => ({
          code: code,
          name: name
        }));
        
        console.log(`📦 ${this.locationOptions.length} magasins chargés`);
        
        if (this.locationOptions.length === 0) {
          this.notificationService.showWarning('Aucun magasin trouvé dans votre stock');
        }
        this.cdr.detectChanges();
      },
      error: (error) => {
        console.error('❌ Erreur chargement magasins:', error);
        this.notificationService.showError('Impossible de charger la liste des magasins');
        this.locationOptions = [];
        this.cdr.detectChanges();
      }
    });
  }
  
  private loadVehicules(): void {
    this.isLoadingVehicules = true;
    
    this.vehiculeService.getVehiculesForGasoil().pipe(
      takeUntil(this.destroy$),
      finalize(() => {
        this.isLoadingVehicules = false;
        this.cdr.markForCheck();
      })
    ).subscribe({
      next: (vehicules) => {
        this.vehiculesList = vehicules;
        this.filteredVehicules = [...this.vehiculesList];
        
        if (this.vehiculesList.length > 0) {
          console.log(`✅ ${this.vehiculesList.length} véhicules éligibles`);
        } else {
          this.notificationService.showWarning('Aucun véhicule éligible');
        }
        this.cdr.detectChanges();
      },
      error: (error) => {
        console.error('❌ Erreur chargement véhicules:', error);
        this.vehiculesList = [];
        this.filteredVehicules = [];
        this.notificationService.showError('Impossible de charger la liste des véhicules');
        this.cdr.detectChanges();
      }
    });
  }
  
  getVehiculeStatusClass(statut: string): string {
    return this.vehiculeService.getVehiculeStatusClass(statut);
  }
  
  isVehiculeEligible(vehicule: Vehicule): boolean {
    return this.vehiculeService.isEligibleForGasoil(vehicule.statut);
  }
  
  getLastIndexDisplay(vehicleNo: string, indexType: string): string {
    const lastIndex = this.lastIndexCache.get(vehicleNo);
    if (!lastIndex) return '—';
    
    const value = indexType === 'Kilometrage' ? lastIndex.kmIndex : lastIndex.hourIndex;
    return value > 0 ? value.toString() : '—';
  }
  
  isIndexValid(vehicleNo: string, indexType: string, newIndex: number): { valid: boolean; message: string } {
    const lastIndex = this.lastIndexCache.get(vehicleNo);
    if (!lastIndex) return { valid: true, message: '' };
    
    const lastValue = indexType === 'Kilometrage' ? lastIndex.kmIndex : lastIndex.hourIndex;
    
    if (lastValue > 0 && newIndex <= lastValue) {
      return { 
        valid: false, 
        message: `L'index ${indexType === 'Kilometrage' ? 'kilométrique' : 'horaire'} doit être supérieur à ${lastValue}` 
      };
    }
    
    return { valid: true, message: '' };
  }
  
  adjustIndexIfNeeded(vehicleNo: string, indexType: string, currentIndex: number): number {
    const lastIndex = this.lastIndexCache.get(vehicleNo);
    if (!lastIndex) return currentIndex;
    
    const lastValue = indexType === 'Kilometrage' ? lastIndex.kmIndex : lastIndex.hourIndex;
    
    if (lastValue > 0 && currentIndex <= lastValue) {
      const newIndex = lastValue + 1;
      console.warn(`⚠️ Index pour ${vehicleNo} auto-ajusté de ${currentIndex} à ${newIndex}`);
      return newIndex;
    }
    
    return currentIndex;
  }
  
  getVehiculeDisplay(code: string): string {
    const vehicule = this.vehiculesList.find(v => v.code === code);
    if (vehicule) {
      const designation = vehicule.designation.length > 40 ? vehicule.designation.substring(0, 40) + '...' : vehicule.designation;
      return `${vehicule.code} - ${designation}`;
    }
    return code;
  }
  
  // ==================== GESTION MODAL ====================
  
  openMagasinDialog(): void {
    this.tempSelectedMagasin = this.selectedMagasin;
    this.magasinSearchTerm = '';
    this.filteredMagasins = [...this.locationOptions];
    this.showMagasinModal = true;
  }
  
  closeMagasinDialog(): void {
    this.showMagasinModal = false;
    this.tempSelectedMagasin = null;
    this.magasinSearchTerm = '';
  }
  
  filterMagasins(): void {
    const term = this.magasinSearchTerm.toLowerCase().trim();
    if (!term) {
      this.filteredMagasins = [...this.locationOptions];
    } else {
      this.filteredMagasins = this.locationOptions.filter(magasin =>
        magasin.name.toLowerCase().includes(term) ||
        magasin.code.toLowerCase().includes(term)
      );
    }
  }
  
  selectTempMagasin(magasin: LocationOption): void {
    this.tempSelectedMagasin = magasin;
  }
  
  confirmMagasinSelection(): void {
    if (this.tempSelectedMagasin) {
      this.selectedMagasin = this.tempSelectedMagasin;
      this.headerForm.patchValue({ locationCode: this.selectedMagasin.code });
      this.notificationService.showInfo(`Magasin sélectionné: ${this.selectedMagasin.name}`);
      this.cdr.detectChanges();
    }
    this.closeMagasinDialog();
  }
  
  openVehiculeDialog(lineIndex: number): void {
    this.currentLineIndexForVehicule = lineIndex;
    const currentVehicle = this.gasoilLines.at(lineIndex).get('vehicleNo')?.value;
    
    if (currentVehicle) {
      this.tempSelectedVehicule = this.vehiculesList.find(v => v.code === currentVehicle) || null;
    } else {
      this.tempSelectedVehicule = null;
    }
    
    this.vehiculeSearchTerm = '';
    this.filteredVehicules = [...this.vehiculesList];
    this.showVehiculeModal = true;
  }
  
  closeVehiculeDialog(): void {
    this.showVehiculeModal = false;
    this.tempSelectedVehicule = null;
    this.vehiculeSearchTerm = '';
    this.currentLineIndexForVehicule = -1;
  }
  
  filterVehicules(): void {
    const term = this.vehiculeSearchTerm.toLowerCase().trim();
    if (!term) {
      this.filteredVehicules = [...this.vehiculesList];
    } else {
      this.filteredVehicules = this.vehiculesList.filter(vehicule =>
        vehicule.code.toLowerCase().includes(term) ||
        vehicule.designation.toLowerCase().includes(term)
      );
    }
  }
  
  selectTempVehicule(vehicule: Vehicule): void {
    this.tempSelectedVehicule = vehicule;
  }
  
  confirmVehiculeSelection(): void {
    if (this.tempSelectedVehicule && this.currentLineIndexForVehicule >= 0) {
      const line = this.gasoilLines.at(this.currentLineIndexForVehicule) as FormGroup;
      line.patchValue({ vehicleNo: this.tempSelectedVehicule.code });
      this.notificationService.showInfo(`Véhicule sélectionné: ${this.tempSelectedVehicule.code}`);
      this.cdr.detectChanges();
    }
    this.closeVehiculeDialog();
  }
  
  // ==================== FIN GESTION MODAL ====================
  
  private checkEditMode(): void {
    const id = this.route.snapshot.paramMap.get('id');
    if (id) {
      this.isEditMode = true;
      this.headerId = id;
      console.log('📝 Mode édition, ID:', id);
      this.loadHeader(id);
    } else {
      console.log('➕ Mode création');
      if (this.gasoilLines.length === 0) {
        this.addLine();
      }
    }
  }
  
  private loadHeader(id: string): void {
    this.loading = true;
    this.cdr.detectChanges();
    
    this.gasoilService.getById(id)
      .pipe(
        takeUntil(this.destroy$),
        finalize(() => {
          this.loading = false;
          this.cdr.detectChanges();
        })
      )
      .subscribe({
        next: (header) => {
          console.log('📦 Header reçu:', header);
          this.existingHeader = header;
          this.ngZone.run(() => {
            this.populateForm(header);
          });
        },
        error: (error) => {
          console.error('❌ Erreur chargement:', error);
          this.notificationService.showError('Impossible de charger la fiche gasoil');
          this.router.navigate(['/gasoil/list']);
          this.cdr.detectChanges();
        }
      });
  }
  
  private populateForm(header: GasoilHeader): void {
    if (header.status === 'Valider') {
      this.headerForm.disable();
      this.notificationService.showWarning('Cette fiche est déjà validée, modification impossible');
    }
    
    // Sélectionner le magasin
    if (header.locationCode) {
      const magasin = this.locationOptions.find(opt => opt.code === header.locationCode);
      if (magasin) {
        this.selectedMagasin = magasin;
      } else {
        this.selectedMagasin = {
          code: header.locationCode,
          name: header.locationCode
        };
      }
      console.log('🏪 Magasin sélectionné:', this.selectedMagasin);
    }
    
    this.headerForm.patchValue({
      date: header.date ? new Date(header.date).toISOString().split('T')[0] : '',
      locationCode: header.locationCode,
      fileNo: header.fileNo
    });
    
    // Vider les lignes existantes
    while (this.gasoilLines.length) {
      this.gasoilLines.removeAt(0);
    }
    
    // Ajouter les lignes existantes
    if (header.gasoilLines && header.gasoilLines.length > 0) {
      header.gasoilLines.forEach(line => {
        this.addLine(line);
      });
    } else if (!this.isEditMode) {
      this.addLine();
    }
    
    this.cdr.detectChanges();
  }
  
  private validateAllLines(linesToAdd: any[]): { isValid: boolean; errors: string[] } {
    const errors: string[] = [];
    
    linesToAdd.forEach((line, idx) => {
      if (line.quantity <= 0) {
        errors.push(`Ligne ${idx + 1} (${line.vehicleNo}): La quantité doit être supérieure à 0`);
      }
      
      const validation = this.isIndexValid(line.vehicleNo, line.indexType, 
        line.indexType === 'Kilometrage' ? line.kmIndex : line.hourIndex);
      
      if (!validation.valid) {
        errors.push(`Ligne ${idx + 1} (${line.vehicleNo}): ${validation.message}`);
      }
    });
    
    return { isValid: errors.length === 0, errors };
  }
  
  onSubmit(): void {
    if (this.headerForm.invalid) {
      this.headerForm.markAllAsTouched();
      this.notificationService.showError('Veuillez remplir tous les champs obligatoires');
      return;
    }
    
    const formValue = this.headerForm.getRawValue();
    
    // Tronquer le fileNo à 20 caractères
    let fileNo = formValue.fileNo || '';
    if (fileNo.length > 20) {
      fileNo = fileNo.substring(0, 20);
      this.notificationService.showWarning(`Le dossier a été tronqué à 20 caractères`);
    }
    
    const linesToAdd = formValue.gasoilLines
      .filter((line: any) => line.vehicleNo && line.vehicleNo.trim() !== '')
      .map((line: any) => {
        let kmIndex = Number(line.kmIndex) || 0;
        let hourIndex = Number(line.hourIndex) || 0;
        
        if (line.indexType === 'Kilometrage') {
          kmIndex = this.adjustIndexIfNeeded(line.vehicleNo, 'Kilometrage', kmIndex);
        } else if (line.indexType === 'Horaire') {
          hourIndex = this.adjustIndexIfNeeded(line.vehicleNo, 'Horaire', hourIndex);
        }
        
        return {
          id: line.id,
          lineNo: line.lineNo,
          vehicleNo: line.vehicleNo,
          quantity: Number(line.quantity),
          indexType: line.indexType,
          hourIndex: hourIndex,
          kmIndex: kmIndex
        };
      });
    
    const validation = this.validateAllLines(linesToAdd);
    if (!validation.isValid) {
      validation.errors.forEach(err => this.notificationService.showError(err));
      return;
    }
    
    const headerData: any = {
      date: formValue.date,
      locationCode: formValue.locationCode,
      fileNo: fileNo
    };
    
    Object.keys(headerData).forEach(key => {
      if (headerData[key] === undefined || headerData[key] === null) {
        delete headerData[key];
      }
    });
    
    console.log('📤 Création/Mise à jour du header:', headerData);
    this.loading = true;
    this.cdr.detectChanges();
    
    if (this.isEditMode && this.headerId) {
      this.updateHeaderAndLines(this.headerId, headerData, linesToAdd);
    } else {
      this.createHeaderAndLines(headerData, linesToAdd);
    }
  }
  
  private createHeaderAndLines(headerData: any, linesToAdd: any[]): void {
    this.gasoilService.create(headerData)
      .pipe(takeUntil(this.destroy$))
      .subscribe({
        next: (response) => {
          console.log('✅ Header créé:', response);
          
          if (linesToAdd.length === 0) {
            this.loading = false;
            this.notificationService.showSuccess(`Fiche gasoil créée - N° ${response.documentNo}`);
            this.router.navigate(['/gasoil', response.id]);
          } else {
            this.addLinesSequentially(response.id!, response.documentNo!, linesToAdd, 0);
          }
        },
        error: (error) => {
          console.error('❌ Erreur création:', error);
          this.loading = false;
          this.notificationService.showError('Erreur lors de la création');
          this.cdr.detectChanges();
        }
      });
  }
  
  private addLinesSequentially(headerId: string, documentNo: string, linesToAdd: any[], index: number): void {
    if (index >= linesToAdd.length) {
      this.loading = false;
      this.notificationService.showSuccess(`Fiche gasoil créée - N° ${documentNo}`);
      this.router.navigate(['/gasoil', headerId]);
      return;
    }
    
    const line = linesToAdd[index];
    const lineData = {
      documentNo: documentNo,
      vehicleNo: line.vehicleNo,
      quantity: Number(line.quantity),
      indexType: line.indexType,
      hourIndex: line.indexType === 'Horaire' ? (Number(line.hourIndex) || 0) : 0,
      kmIndex: line.indexType === 'Kilometrage' ? (Number(line.kmIndex) || 0) : 0,
      projectNo: this.currentProjectNo
    };
    
    this.gasoilService.addLine(lineData)
      .pipe(takeUntil(this.destroy$))
      .subscribe({
        next: () => {
          this.addLinesSequentially(headerId, documentNo, linesToAdd, index + 1);
        },
        error: (error) => {
          console.error(`❌ Erreur ligne ${index + 1}:`, error);
          this.loading = false;
          this.notificationService.showError(`Erreur lors de l'ajout de la ligne ${index + 1}`);
        }
      });
  }
  
  private updateHeaderAndLines(id: string, headerData: any, newLines: any[]): void {
    // Mise à jour optimiste de l'affichage
    if (headerData.locationCode) {
      const magasin = this.locationOptions.find(opt => opt.code === headerData.locationCode);
      this.selectedMagasin = magasin || { code: headerData.locationCode, name: headerData.locationCode };
      this.headerForm.patchValue({ locationCode: headerData.locationCode });
    }
    
    this.gasoilService.update(id, headerData)
      .pipe(
        takeUntil(this.destroy$),
        switchMap(() => this.gasoilService.getById(id))
      )
      .subscribe({
        next: (header) => {
          this.syncLines(header.gasoilLines || [], newLines, header.documentNo!);
        },
        error: (error) => {
          console.error('❌ Erreur mise à jour:', error);
          this.loading = false;
          this.notificationService.showError('Erreur lors de la mise à jour');
          this.cdr.detectChanges();
        }
      });
  }
  
  private syncLines(existingLines: GasoilLine[], newLines: any[], documentNo: string): void {
    let completed = 0;
    
    const existingIds = new Set(existingLines.filter(l => l.id).map(l => l.id));
    const newIds = new Set(newLines.filter(l => l.id).map(l => l.id));
    
    const linesToDelete = existingLines.filter(line => line.id && !newIds.has(line.id));
    const linesToUpdate = newLines.filter(newLine => newLine.id && existingIds.has(newLine.id));
    const linesToCreate = newLines.filter(newLine => !newLine.id);
    
    const totalOps = linesToDelete.length + linesToUpdate.length + linesToCreate.length;
    
    console.log(`📊 Opérations: ${linesToDelete.length} suppression(s), ${linesToUpdate.length} mise(s) à jour, ${linesToCreate.length} création(s)`);
    
    if (totalOps === 0) {
      this.finishUpdate();
      return;
    }
    
    const onComplete = () => {
      completed++;
      if (completed === totalOps) {
        this.finishUpdate();
      }
    };
    
    // Supprimer
    linesToDelete.forEach(line => {
      if (line.id) {
        this.gasoilService.deleteLine(line.id).subscribe({ next: onComplete, error: onComplete });
      } else {
        onComplete();
      }
    });
    
    // Mettre à jour
    linesToUpdate.forEach(newLine => {
      const existingLine = existingLines.find(l => l.id === newLine.id);
      if (existingLine && existingLine.id) {
        const updateData: any = {};
        if (newLine.quantity !== existingLine.quantity) updateData.quantity = newLine.quantity;
        if (newLine.kmIndex !== existingLine.kmIndex && newLine.indexType === 'Kilometrage') updateData.kmIndex = newLine.kmIndex;
        if (newLine.hourIndex !== existingLine.hourIndex && newLine.indexType === 'Horaire') updateData.hourIndex = newLine.hourIndex;
        
        if (Object.keys(updateData).length > 0) {
          this.gasoilService.updateLine(existingLine.id, updateData).subscribe({ next: onComplete, error: onComplete });
        } else {
          onComplete();
        }
      } else {
        onComplete();
      }
    });
    
    // Créer
    linesToCreate.forEach(newLine => {
      const lineData = {
        documentNo: documentNo,
        vehicleNo: newLine.vehicleNo,
        quantity: newLine.quantity,
        indexType: newLine.indexType,
        hourIndex: newLine.indexType === 'Horaire' ? (newLine.hourIndex || 0) : 0,
        kmIndex: newLine.indexType === 'Kilometrage' ? (newLine.kmIndex || 0) : 0,
        projectNo: this.currentProjectNo
      };
      this.gasoilService.addLine(lineData).subscribe({ next: onComplete, error: onComplete });
    });
  }
  
  private finishUpdate(): void {
    this.loading = false;
    this.notificationService.showSuccess('Fiche gasoil mise à jour avec succès');
    this.router.navigate(['/gasoil', this.headerId]);
    this.cdr.detectChanges();
  }
  
  private logErrorDetails(error: any, context: string): void {
    console.error(`========== ERREUR - ${context} ==========`);
    console.error(`Statut: ${error.status}`);
    if (error.error) {
      console.error('Message:', error.error.message || error.error);
    }
  }
  
  cancel(): void {
    if (this.headerId) {
      this.router.navigate(['/gasoil', this.headerId]);
    } else {
      this.router.navigate(['/gasoil/list']);
    }
  }
  
  getTotalQuantity(): number {
    let total = 0;
    this.gasoilLines.controls.forEach(control => {
      total += control.get('quantity')?.value || 0;
    });
    return total;
  }
  
  getIndexTypeLabel(type: string): string {
    return getIndexTypeLabel(type);
  }
  
  isFieldInvalid(fieldName: string): boolean {
    const field = this.headerForm.get(fieldName);
    return !!field && field.invalid && (field.dirty || field.touched);
  }
  
  isLineFieldInvalid(lineIndex: number, fieldName: string): boolean {
    const line = this.gasoilLines.at(lineIndex) as FormGroup;
    const field = line.get(fieldName);
    return !!field && field.invalid && (field.dirty || field.touched);
  }
}

export { GasoilFormComponent as ty };