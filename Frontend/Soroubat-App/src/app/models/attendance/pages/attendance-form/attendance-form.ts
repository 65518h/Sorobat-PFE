// src/app/modules/attendance/pages/attendance-form/attendance-form.ts

import { Component, OnInit, OnDestroy, TemplateRef, ViewChild, ChangeDetectorRef, NgZone } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormBuilder, FormGroup, ReactiveFormsModule, Validators, FormsModule } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { Subject, takeUntil } from 'rxjs';
import { AttendanceService } from '../../services/attendance.service';
import { AttendanceLine, CreateAttendanceHeader } from '../../models/attendance.model';
import { AuthService } from '../../../../core/services/auth';
import { ToastrService } from 'ngx-toastr';
import { MatDialog, MatDialogModule } from '@angular/material/dialog';
import { MatTooltipModule } from '@angular/material/tooltip';
import { EmployeeService, Employee } from '../../services/employee.service';
import { FaceScannerDialogComponent } from '../../components/face-scanner-dialog/face-scanner-dialog';

// Angular Material
import { MatCardModule } from '@angular/material/card';
import { MatIconModule } from '@angular/material/icon';
import { MatButtonModule } from '@angular/material/button';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';

@Component({
  selector: 'app-attendance-form',
  standalone: true,
  imports: [
    CommonModule,
    ReactiveFormsModule,
    FormsModule,
    MatCardModule,
    MatIconModule,
    MatButtonModule,
    MatProgressSpinnerModule,
    MatDialogModule,
    MatTooltipModule
  ],
  templateUrl: './attendance-form.html',
  styleUrls: ['./attendance-form.css']
})
export class AttendanceFormComponent implements OnInit, OnDestroy {
  
  @ViewChild('employeeSearchDialog') employeeSearchDialog!: TemplateRef<any>;
  @ViewChild('globalFaceScanDialog') globalFaceScanDialog!: TemplateRef<any>;
  
  attendanceForm!: FormGroup;
  loading = false;
  saving = false;
  isEditMode = false;
  attendanceId: string = '';
  currentJobNo: string = '';
  currentUser: any = null;
  attendanceLines: AttendanceLine[] = [];
  daysInMonth: number[] = [];
  currentDocumentNo: string = '';
  
  // Propriétés pour la recherche d'employés
  allEmployees: Employee[] = [];
  filteredEmployees: Employee[] = [];
  searchTerm: string = '';
  employeesLoaded: boolean = false;
  
  // Pagination
  currentPage: number = 1;
  pageSize: number = 20;
  totalCount: number = 0;
  totalPages: number = 0;
  loadingEmployees: boolean = false;
  
  // Ligne en cours d'édition
  private currentEditingLine: AttendanceLine | null = null;
  private currentEditingIndex: number = -1;
  
  // Scan facial global
  scanMatricule: string = '';
  foundEmployee: Employee | null = null;
  selectedDay: number = 1;
  isScanning: boolean = false;
  
  months = [
    { value: 'Janvier', label: 'Janvier' },
    { value: 'Février', label: 'Février' },
    { value: 'Mars', label: 'Mars' },
    { value: 'Avril', label: 'Avril' },
    { value: 'Mai', label: 'Mai' },
    { value: 'Juin', label: 'Juin' },
    { value: 'Juillet', label: 'Juillet' },
    { value: 'Août', label: 'Août' },
    { value: 'Septembre', label: 'Septembre' },
    { value: 'Octobre', label: 'Octobre' },
    { value: 'Novembre', label: 'Novembre' },
    { value: 'Décembre', label: 'Décembre' }
  ];
  
  private destroy$ = new Subject<void>();
  
  constructor(
    private fb: FormBuilder,
    private route: ActivatedRoute,
    private router: Router,
    private attendanceService: AttendanceService,
    private authService: AuthService,
    private toastr: ToastrService,
    private dialog: MatDialog,
    private employeeService: EmployeeService,
    private cdr: ChangeDetectorRef,
    private ngZone: NgZone
  ) {
    this.initForm();
    this.loadUserProject();
  }
  
  ngOnInit(): void {
    this.route.paramMap.subscribe(params => {
      const id = params.get('id');
      if (id) {
        this.isEditMode = true;
        this.attendanceId = id;
        this.loadAttendance();
      } else {
        this.isEditMode = false;
        this.attendanceForm.patchValue({ jobNo: this.currentJobNo });
      }
    });
  }
  
  ngOnDestroy(): void {
    this.destroy$.next();
    this.destroy$.complete();
  }
  
  private loadUserProject(): void {
    this.currentUser = this.authService.getUser();
    if (this.currentUser && this.currentUser.projet) {
      this.currentJobNo = this.currentUser.projet;
    }
  }
  
  private initForm(): void {
    const currentYear = new Date().getFullYear();
    
    this.attendanceForm = this.fb.group({
      month: ['', Validators.required],
      year: [currentYear, [Validators.required, Validators.min(2020), Validators.max(2030)]],
      jobNo: [{ value: '', disabled: true }],
      totalStaff: [{ value: 0, disabled: true }]
    });
  }
  
  private initDaysInMonth(): void {
    if (!this.attendanceForm) return;
    
    const month = this.attendanceForm.get('month')?.value;
    const year = this.attendanceForm.get('year')?.value;
    
    const monthMap: Record<string, number> = {
      'Janvier': 31, 'Février': 28, 'Mars': 31, 'Avril': 30,
      'Mai': 31, 'Juin': 30, 'Juillet': 31, 'Août': 31,
      'Septembre': 30, 'Octobre': 31, 'Novembre': 30, 'Décembre': 31
    };
    
    let days = monthMap[month] || 30;
    if (month === 'Février' && this.isLeapYear(year)) {
      days = 29;
    }
    
    this.daysInMonth = Array.from({ length: days }, (_, i) => i + 1);
    
    const currentDate = new Date().getDate();
    this.selectedDay = currentDate <= days ? currentDate : 1;
  }
  
  private isLeapYear(year: number): boolean {
    return (year % 4 === 0 && year % 100 !== 0) || (year % 400 === 0);
  }
  
  private loadAttendance(): void {
    if (!this.attendanceId) return;
    
    this.loading = true;
    this.cdr.detectChanges();
    
    this.attendanceService.getFullAttendance(this.attendanceId)
      .pipe(takeUntil(this.destroy$))
      .subscribe({
        next: (data) => {
          this.currentDocumentNo = data.no || '';
          this.attendanceForm.patchValue({
            month: data.month,
            year: data.year,
            jobNo: data.jobNo,
            totalStaff: data.totalStaff
          });
          
          this.attendanceLines = data.employeeAttendanceLines || data.lines || [];
          this.initDaysInMonth();
          this.loading = false;
          this.cdr.detectChanges();
          
          this.loadAllEmployees();
        },
        error: (error) => {
          console.error('Erreur:', error);
          this.ngZone.run(() => {
            this.toastr.error('Impossible de charger le pointage');
          });
          this.loading = false;
          this.cdr.detectChanges();
          this.goBack();
        }
      });
  }
  
  // ==================== CHARGEMENT DES EMPLOYÉS ====================
  
  private loadAllEmployees(): void {
    if (this.employeesLoaded) {
      console.log(`📋 ${this.allEmployees.length} employés déjà en cache`);
      this.totalCount = this.allEmployees.length;
      this.totalPages = Math.ceil(this.allEmployees.length / this.pageSize);
      return;
    }
    
    this.employeeService.getAllEmployees().subscribe({
      next: (employees) => {
        this.allEmployees = employees;
        this.filteredEmployees = [...employees];
        this.employeesLoaded = true;
        this.totalCount = employees.length;
        this.totalPages = Math.ceil(employees.length / this.pageSize);
        this.currentPage = 1;
        console.log(`✅ ${employees.length} employés chargés en cache, ${this.totalPages} pages`);
      },
      error: (error) => {
        console.error('❌ Erreur chargement employés:', error);
        this.allEmployees = [];
        this.filteredEmployees = [];
        this.totalCount = 0;
        this.totalPages = 0;
      }
    });
  }
  
  // ==================== GESTION DES LIGNES ====================
  
  addNewEmptyLine(): void {
    if (!this.currentDocumentNo) {
      console.warn('Numéro de document non disponible');
      return;
    }
    
    const tempId = `temp_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`;
    
    const newLine: AttendanceLine = {
      id: tempId,
      documentNo: this.currentDocumentNo,
      employeeNo: '',
      employeeName: '',
      assignment: '',
      qualification: ''
    };
    
    this.attendanceLines.push(newLine);
    (newLine as any).__isTemp = true;
    this.cdr.detectChanges();
    
    this.ngZone.run(() => {
      this.toastr.info('Nouvelle ligne ajoutée, cliquez sur le champ employé pour sélectionner');
    });
  }
  
  openEmployeeSearch(line: AttendanceLine, index: number): void {
    this.currentEditingLine = line;
    this.currentEditingIndex = index;
    this.searchTerm = '';
    this.currentPage = 1;
    this.filteredEmployees = [...this.allEmployees];
    this.totalCount = this.filteredEmployees.length;
    this.totalPages = Math.ceil(this.filteredEmployees.length / this.pageSize);
    this.dialog.open(this.employeeSearchDialog, { 
      width: '650px',
      panelClass: 'employee-search-dialog'
    });
  }
  
  onSearchInput(value: string): void {
    console.log('🔎 Recherche:', value);
    this.searchTerm = value;
    this.currentPage = 1;
    
    if (!value || value.trim().length < 2) {
      this.filteredEmployees = [...this.allEmployees];
    } else {
      const term = value.toLowerCase().trim();
      this.filteredEmployees = this.allEmployees.filter(emp => 
        emp.matricule.toLowerCase().includes(term) ||
        emp.firstName.toLowerCase().includes(term) ||
        emp.lastName.toLowerCase().includes(term) ||
        `${emp.lastName} ${emp.firstName}`.toLowerCase().includes(term)
      );
    }
    
    this.totalCount = this.filteredEmployees.length;
    this.totalPages = Math.ceil(this.filteredEmployees.length / this.pageSize);
    console.log(`📊 ${this.filteredEmployees.length} résultats, ${this.totalPages} pages`);
  }
  
  getPaginatedEmployees(): Employee[] {
    const start = (this.currentPage - 1) * this.pageSize;
    const end = start + this.pageSize;
    return this.filteredEmployees.slice(start, end);
  }
  
  goToPage(page: number): void {
    if (page < 1 || page > this.totalPages) return;
    this.currentPage = page;
  }
  
  clearSearch(): void {
    this.searchTerm = '';
    this.currentPage = 1;
    this.filteredEmployees = [...this.allEmployees];
    this.totalCount = this.filteredEmployees.length;
    this.totalPages = Math.ceil(this.filteredEmployees.length / this.pageSize);
  }
  
  // ✅ Fonction utilitaire pour tronquer une chaîne à 20 caractères
  private truncateString(str: string, maxLength: number = 20): string {
    if (!str) return '';
    if (str.length <= maxLength) return str;
    return str.substring(0, maxLength);
  }
  
  selectEmployeeForCurrentLine(employee: Employee): void {
    if (!this.currentEditingLine) return;
    
    // ✅ Tronquer la fonction à 20 caractères maximum
    const assignment = this.truncateString(employee.fonction || '');
    
    this.currentEditingLine.employeeNo = employee.matricule;
    this.currentEditingLine.employeeName = `${employee.lastName} ${employee.firstName}`.trim();
    this.currentEditingLine.assignment = assignment;
    
    if (assignment !== (employee.fonction || '')) {
      console.log(`⚠️ Fonction tronquée: "${employee.fonction}" -> "${assignment}"`);
    }
    
    const isTemp = (this.currentEditingLine as any).__isTemp;
    
    if (isTemp) {
      delete (this.currentEditingLine as any).__isTemp;
      delete (this.currentEditingLine as any).id;
      
      const newLine: AttendanceLine = {
        documentNo: this.currentDocumentNo,
        employeeNo: this.currentEditingLine.employeeNo,
        employeeName: this.currentEditingLine.employeeName,
        assignment: this.currentEditingLine.assignment,
        qualification: this.currentEditingLine.qualification || ''
      };
      
      this.attendanceService.createLines([newLine])
        .pipe(takeUntil(this.destroy$))
        .subscribe({
          next: () => {
            this.ngZone.run(() => {
              this.toastr.success(`Employé ${this.currentEditingLine!.employeeName} ajouté`);
            });
            this.loadAttendance();
            this.closeEmployeeDialog();
          },
          error: (error) => {
            console.error('Erreur création:', error);
            this.ngZone.run(() => {
              this.toastr.error('Erreur lors de l\'ajout');
            });
          }
        });
    } else {
      this.attendanceService.updateLine(this.currentEditingLine.id!, {
        employeeNo: this.currentEditingLine.employeeNo,
        employeeName: this.currentEditingLine.employeeName,
        assignment: this.currentEditingLine.assignment
      }).pipe(takeUntil(this.destroy$))
        .subscribe({
          next: () => {
            this.ngZone.run(() => {
              this.toastr.success(`Employé ${this.currentEditingLine!.employeeName} modifié`);
            });
            this.loadAttendance();
            this.closeEmployeeDialog();
          },
          error: (error) => {
            console.error('Erreur mise à jour:', error);
            this.ngZone.run(() => {
              this.toastr.error('Erreur lors de la modification');
            });
          }
        });
    }
  }
  
  deleteLine(line: AttendanceLine): void {
    const isTemp = (line as any).__isTemp;
    
    if (isTemp) {
      const index = this.attendanceLines.indexOf(line);
      if (index > -1) {
        this.attendanceLines.splice(index, 1);
        this.cdr.detectChanges();
      }
      this.ngZone.run(() => {
        this.toastr.info('Ligne supprimée');
      });
    } else {
      if (confirm(`Supprimer ${line.employeeName || 'cet employé'} de ce pointage ?`)) {
        this.attendanceService.deleteLine(line.id!)
          .pipe(takeUntil(this.destroy$))
          .subscribe({
            next: () => {
              this.ngZone.run(() => {
                this.toastr.success('Employé supprimé');
              });
              this.loadAttendance();
            },
            error: (error) => {
              console.error('Erreur:', error);
              this.ngZone.run(() => {
                this.toastr.error('Erreur lors de la suppression');
              });
            }
          });
      }
    }
  }
  
  closeEmployeeDialog(): void {
    this.dialog.closeAll();
    this.currentEditingLine = null;
    this.currentEditingIndex = -1;
  }
  
  // ==================== MÉTHODES DU TABLEAU ====================
  
  getDayValue(line: AttendanceLine, day: number): string {
    const key = `day${day}` as keyof AttendanceLine;
    return (line[key] as string) || '';
  }
  
  updateDayValue(line: AttendanceLine, day: number, event: Event): void {
    const select = event.target as HTMLSelectElement;
    const value = select.value;
    const key = `day${day}` as keyof AttendanceLine;
    (line as any)[key] = value;
    (line as any).__modified = true;
  }
  
  // ✅ MODIFIÉ: Ne compter que 'P' comme présent
  calculateLineTotalPresent(line: AttendanceLine): number {
    let total = 0;
    for (let day = 1; day <= this.daysInMonth.length; day++) {
      const key = `day${day}` as keyof AttendanceLine;
      const value = line[key] as string;
      // ✅ Seulement 'P' est considéré comme présent
      if (value && value === 'P') {
        total++;
      }
    }
    return total;
  }
  
  getTotalPresentClass(total: number): string {
    if (total >= 20) return 'excellent';
    if (total >= 15) return 'good';
    if (total >= 10) return 'average';
    return 'low';
  }
  
  // ✅ MODIFIÉ: Mise à jour des classes CSS
  getStatusClass(code: string): string {
    if (code === 'P') return 'present';
    if (['C', 'CEXP', 'C1/2'].includes(code)) return 'leave';
    if (code === 'F') return 'holiday';
    if (code === 'A') return 'absent';
    return 'empty';
  }
  
  isWeekend(day: number): boolean {
    const month = this.attendanceForm.get('month')?.value;
    const year = this.attendanceForm.get('year')?.value;
    if (!month || !year) return false;
    
    const monthIndex = this.getMonthIndex(month);
    const date = new Date(year, monthIndex, day);
    const dayOfWeek = date.getDay();
    return dayOfWeek === 0 || dayOfWeek === 6;
  }
  
  private getMonthIndex(monthName: string): number {
    const months = ['Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin',
      'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'];
    return months.indexOf(monthName);
  }
  
  // ==================== SCAN FACIAL GLOBAL ====================
  
  openGlobalFaceScan(): void {
    if (this.attendanceLines.length === 0) {
      this.toastr.warning('Aucun employé dans ce pointage. Ajoutez des employés d\'abord.');
      return;
    }
    
    if (!this.employeesLoaded) {
      this.loadAllEmployees();
    }
    
    this.scanMatricule = '';
    this.foundEmployee = null;
    
    const currentDate = new Date().getDate();
    this.selectedDay = currentDate <= this.daysInMonth.length ? currentDate : 1;
    
    const dialogRef = this.dialog.open(this.globalFaceScanDialog, {
      width: '500px',
      panelClass: 'global-scan-dialog',
      disableClose: false,
      autoFocus: false
    });
    
    dialogRef.afterOpened().subscribe(() => {
      setTimeout(() => {
        const input = document.querySelector('.global-scan-dialog .dialog-input') as HTMLInputElement;
        if (input) {
          input.focus();
        }
      }, 100);
    });
  }
  
  closeGlobalScanDialog(): void {
    this.dialog.closeAll();
    this.scanMatricule = '';
    this.foundEmployee = null;
  }
  
  onMatriculeChange(): void {
    if (!this.scanMatricule || this.scanMatricule.trim() === '') {
      this.foundEmployee = null;
      return;
    }
    
    const trimmedMatricule = this.scanMatricule.trim();
    this.foundEmployee = this.allEmployees.find(emp => 
      emp.matricule === trimmedMatricule
    ) || null;
    
    console.log('Recherche employé:', trimmedMatricule, 'Trouvé:', this.foundEmployee?.lastName || 'Non trouvé');
    this.cdr.detectChanges();
  }
  
  decrementDay(): void {
    if (this.selectedDay > 1) {
      this.selectedDay--;
    }
  }
  
  incrementDay(): void {
    if (this.selectedDay < this.daysInMonth.length) {
      this.selectedDay++;
    }
  }
  
  startGlobalFaceScan(): void {
    const trimmedMatricule = this.scanMatricule?.trim();
    
    if (!trimmedMatricule) {
      this.toastr.warning('Veuillez saisir un matricule');
      return;
    }
    
    const employee = this.allEmployees.find(emp => emp.matricule === trimmedMatricule);
    
    if (!employee) {
      this.toastr.error(`Aucun employé trouvé avec le matricule "${trimmedMatricule}"`);
      return;
    }
    
    // ✅ Sauvegarder le jour actuel avant de fermer le dialogue
    const currentDay = this.selectedDay;
    
    if (!currentDay || currentDay < 1 || currentDay > this.daysInMonth.length) {
      this.toastr.warning(`Le jour doit être entre 1 et ${this.daysInMonth.length}`);
      return;
    }
    
    const existingLine = this.attendanceLines.find(line => line.employeeNo === trimmedMatricule);
    
    // Fermer le dialogue de sélection
    this.closeGlobalScanDialog();
    
    if (!existingLine) {
      // ✅ Passer le jour sauvegardé
      this.addAndScanEmployeeWithDay(employee, currentDay);
    } else {
      // ✅ Passer le jour sauvegardé
      this.openFaceScannerWithDay(employee, currentDay);
    }
  }
  
  // ✅ Nouvelle méthode pour ajouter un employé avec un jour spécifique
  addAndScanEmployeeWithDay(employee: Employee, day: number): void {
    if (!this.currentDocumentNo) {
      this.toastr.error('Erreur technique');
      return;
    }
    
    const assignment = this.truncateString(employee.fonction || '');
    
    if (assignment !== (employee.fonction || '')) {
      console.log(`⚠️ Fonction tronquée: "${employee.fonction}" -> "${assignment}"`);
    }
    
    const newLine: AttendanceLine = {
      documentNo: this.currentDocumentNo,
      employeeNo: employee.matricule,
      employeeName: `${employee.lastName} ${employee.firstName}`.trim(),
      assignment: assignment,
      qualification: ''
    };
    
    this.attendanceService.createLines([newLine])
      .pipe(takeUntil(this.destroy$))
      .subscribe({
        next: () => {
          this.toastr.success(`✅ ${employee.lastName} ${employee.firstName} ajouté au pointage`);
          this.loadAttendance();
          
          setTimeout(() => {
            const freshEmployee = this.attendanceLines.find(line => line.employeeNo === employee.matricule);
            if (freshEmployee) {
              // ✅ Utiliser le jour sauvegardé
              this.openFaceScannerWithDay(employee, day);
            } else {
              this.toastr.error('Erreur après ajout');
            }
          }, 1500);
        },
        error: (error) => {
          console.error('Erreur:', error);
          this.toastr.error('Erreur lors de l\'ajout');
        }
      });
  }
  
  // ✅ Nouvelle méthode pour ouvrir le scanner avec un jour spécifique
  openFaceScannerWithDay(employee: Employee, day: number): void {
    console.log(`Ouverture du dialogue de scan facial pour ${employee.lastName} - Jour ${day}`);
    
    const dialogRef = this.dialog.open(FaceScannerDialogComponent, {
      width: '600px',
      panelClass: 'face-scanner-dialog',
      data: {
        headerId: this.attendanceId,
        employeeMatricule: employee.matricule,
        day: day,  // ✅ Utiliser le jour passé en paramètre
        employeeName: `${employee.lastName} ${employee.firstName}`
      },
      disableClose: true,
      backdropClass: 'dialog-backdrop'
    });
    
    dialogRef.afterClosed().subscribe(result => {
      console.log('Dialogue de scan fermé', result);
      if (result && result.success) {
        this.toastr.success(`Présence marquée pour le jour ${result.day}`);
        this.loadAttendance();
      }
    });
  }
  
  // Garder la méthode existante pour compatibilité (utilise le jour sélectionné)
  openFaceScanner(employee: Employee): void {
    this.openFaceScannerWithDay(employee, this.selectedDay);
  }
  
  // Garder la méthode existante pour compatibilité
  addAndScanEmployee(employee: Employee): void {
    this.addAndScanEmployeeWithDay(employee, this.selectedDay);
  }
  
  // ==================== SAUVEGARDE ====================
  
  saveAllChanges(): void {
    this.saving = true;
    this.cdr.detectChanges();
    
    const formValue = this.attendanceForm.getRawValue();
    
    const savePromises: Promise<any>[] = [];
    
    if (this.isEditMode && this.attendanceForm.dirty) {
      const headerData = {
        month: formValue.month,
        year: formValue.year
      };
      
      savePromises.push(
        this.attendanceService.updateHeader(this.attendanceId, headerData)
          .toPromise()
          .catch(error => {
            console.error('❌ Erreur header:', error);
            return null;
          })
      );
    }
    
    const linesToSave = this.attendanceLines.filter(line => !(line as any).__isTemp);
    const modifiedLines = linesToSave.filter(line => (line as any).__modified);
    
    modifiedLines.forEach(line => {
      const updateData: any = {
        employeeNo: line.employeeNo
      };
      
      for (let day = 1; day <= this.daysInMonth.length; day++) {
        const key = `day${day}`;
        const value = (line as any)[key];
        updateData[key] = (value && value !== '') ? value : null;
      }
      
      savePromises.push(
        this.attendanceService.updateLine(line.id!, updateData)
          .toPromise()
          .catch(error => {
            console.error(`❌ Erreur ligne ${line.id}:`, error);
            return null;
          })
      );
    });
    
    if (savePromises.length === 0) {
      this.ngZone.run(() => {
        this.toastr.info('Aucune modification à enregistrer');
      });
      this.saving = false;
      this.cdr.detectChanges();
      return;
    }
    
    Promise.all(savePromises)
      .then(results => {
        const successCount = results.filter(r => r !== null).length;
        this.ngZone.run(() => {
          if (successCount > 0) {
            this.toastr.success(`${successCount} modification(s) enregistrée(s)`);
          }
          if (successCount < savePromises.length) {
            this.toastr.warning(`${savePromises.length - successCount} erreur(s)`);
          }
        });
        
        this.loadAttendance();
        this.attendanceForm.markAsPristine();
        this.attendanceLines.forEach(line => {
          (line as any).__modified = false;
        });
      })
      .catch(error => {
        console.error('Erreur sauvegarde:', error);
        this.ngZone.run(() => {
          this.toastr.error('Erreur lors de la sauvegarde');
        });
      })
      .finally(() => {
        this.saving = false;
        this.cdr.detectChanges();
      });
  }
  
  onSubmit(): void {
    if (this.attendanceForm.invalid) {
      this.ngZone.run(() => {
        this.toastr.warning('Veuillez remplir tous les champs');
      });
      return;
    }
    
    this.loading = true;
    this.cdr.detectChanges();
    const formValue = this.attendanceForm.getRawValue();
    
    if (this.isEditMode) {
      const updateData = {
        month: formValue.month,
        year: formValue.year
      };
      
      this.attendanceService.updateHeader(this.attendanceId, updateData)
        .pipe(takeUntil(this.destroy$))
        .subscribe({
          next: () => {
            this.ngZone.run(() => {
              this.toastr.success('Pointage mis à jour avec succès');
            });
            this.router.navigate(['/attendance']);
            this.loading = false;
            this.cdr.detectChanges();
          },
          error: (error) => {
            console.error('❌ Erreur mise à jour:', error);
            this.ngZone.run(() => {
              if (error.status === 409) {
                this.toastr.error('Un pointage existe déjà pour cette période');
              } else {
                this.toastr.error('Erreur lors de la mise à jour');
              }
            });
            this.loading = false;
            this.cdr.detectChanges();
          }
        });
    } else {
      const data: CreateAttendanceHeader = {
        month: formValue.month,
        year: formValue.year,
        jobNo: this.currentJobNo
      };
      
      this.attendanceService.createHeader(data)
        .pipe(takeUntil(this.destroy$))
        .subscribe({
          next: (result) => {
            this.ngZone.run(() => {
              this.toastr.success('Pointage créé avec succès');
            });
            this.router.navigate(['/attendance', 'edit', result.id]);
            this.loading = false;
            this.cdr.detectChanges();
          },
          error: (error) => {
            console.error('Erreur:', error);
            this.ngZone.run(() => {
              if (error.status === 409) {
                this.toastr.error('Un pointage existe déjà pour cette période');
              } else {
                this.toastr.error('Erreur lors de la création');
              }
            });
            this.loading = false;
            this.cdr.detectChanges();
          }
        });
    }
  }
  
  deleteAttendance(): void {
    if (!this.attendanceId) return;
    
    if (confirm('Supprimer ce pointage ?')) {
      this.loading = true;
      this.cdr.detectChanges();
      
      this.attendanceService.deleteHeader(this.attendanceId)
        .pipe(takeUntil(this.destroy$))
        .subscribe({
          next: () => {
            this.ngZone.run(() => {
              this.toastr.success('Pointage supprimé');
            });
            this.router.navigate(['/attendance']);
            this.loading = false;
            this.cdr.detectChanges();
          },
          error: (error) => {
            console.error('Erreur:', error);
            this.ngZone.run(() => {
              this.toastr.error('Erreur lors de la suppression');
            });
            this.loading = false;
            this.cdr.detectChanges();
          }
        });
    }
  }
  
  goBack(): void {
    this.router.navigate(['/attendance']);
  }
}