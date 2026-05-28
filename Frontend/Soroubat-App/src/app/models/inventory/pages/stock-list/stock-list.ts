// src/app/modules/inventory/pages/stock-list/stock-list.ts

import { Component, OnInit, OnDestroy, ChangeDetectorRef, ViewChild, TemplateRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule, ReactiveFormsModule, FormBuilder, FormGroup } from '@angular/forms';
import { Subject, takeUntil, debounceTime, distinctUntilChanged, interval } from 'rxjs';
import { StockService } from '../../services/stock';
import { StockItem, StockStats } from '../../models/stock.model';
import { AuthService } from '../../../../core/services/auth';
import { SiteManagementService, Site } from '../../services/site-management.service';
import { AlertsCounterService } from '../../../../core/services/alerts-counter.service';
import { MatDialog, MatDialogRef } from '@angular/material/dialog';
import { StockDetailComponent } from '../stock-detail/stock-detail';
import { ToastrService } from 'ngx-toastr';
import { Router } from '@angular/router';
import { AudioService } from '../../../../core/services/audio.service';
import { SoundService } from '../../../../core/services/sound.service';
import { AppModeService } from '../../../../core/services/app-mode.service';
import { OfflineSyncService } from '../../../../core/services/offline-sync.service';
import { OfflineHideActionsDirective } from '../../../../core/directives/offline-hide-actions.directive';
import { ShowOfflineMessageDirective } from '../../../../core/directives/show-offline-message.directive';
import { ConfirmationDialogComponent, ConfirmationDialogData } from '../../../../core/components/confirmation-dialog/confirmation-dialog.component';

// Scanner - html5-qrcode
import { Html5Qrcode, Html5QrcodeCameraScanConfig } from 'html5-qrcode';

// Angular Material
import { MatCardModule } from '@angular/material/card';
import { MatInputModule } from '@angular/material/input';
import { MatSelectModule } from '@angular/material/select';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { MatPaginatorModule, MatPaginator, PageEvent } from '@angular/material/paginator';
import { MatTooltipModule } from '@angular/material/tooltip';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatDialogModule } from '@angular/material/dialog';
import { MatChipsModule } from '@angular/material/chips';

@Component({
  selector: 'app-stock-list',
  standalone: true,
  imports: [
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    MatCardModule,
    MatInputModule,
    MatSelectModule,
    MatButtonModule,
    MatIconModule,
    MatProgressSpinnerModule,
    MatPaginatorModule,
    MatTooltipModule,
    MatFormFieldModule,
    MatDialogModule,
    MatChipsModule,
    OfflineHideActionsDirective,
    ShowOfflineMessageDirective
  ],
  templateUrl: './stock-list.html',
  styleUrls: ['./stock-list.css']
})
export class StockListComponent implements OnInit, OnDestroy {
  
  @ViewChild('barcodeScannerDialog') barcodeScannerDialog!: TemplateRef<any>;
  
  stockItems: StockItem[] = [];
  filteredStockItems: StockItem[] = [];
  paginatedItems: StockItem[] = [];
  loading = false;
  errorMessage = '';
  isReadOnly: boolean = false;
  
  // Pagination
  @ViewChild(MatPaginator) paginator!: MatPaginator;
  pageSize = 20;
  pageIndex = 0;
  totalItems = 0;
  
  // Filtres
  filterForm!: FormGroup;
  filtersExpanded = false;
  
  // Infos utilisateur
  currentLocationCode: string = '';
  currentJobNo: string = '';
  currentJobDescription: string = '';
  userName: string = '';
  
  // Compteur d'alertes
  alertCount: number = 0;
  
  // Liste des magasins uniques pour le filtre
  uniqueLocations: string[] = [];
  
  // Scanner
  private barcodeDialogRef: MatDialogRef<any> | null = null;
  private scanner: Html5Qrcode | null = null;
  scannerLoading: boolean = false;
  private isDialogOpening: boolean = false;
  
  // Statistiques
  stats: StockStats = {
    totalItems: 0,
    totalQuantity: 0,
    uniqueLocations: 0,
    uniqueJobs: 0,
    lowStockCount: 0,
    outOfStockCount: 0
  };
  
  private destroy$ = new Subject<void>();
  
  constructor(
    private stockService: StockService,
    private authService: AuthService,
    private siteManagementService: SiteManagementService,
    private alertsCounterService: AlertsCounterService,
    private fb: FormBuilder,
    private cdr: ChangeDetectorRef,
    private dialog: MatDialog,
    private toastr: ToastrService,
    private router: Router,
    private audioService: AudioService,
    private soundService: SoundService,
    private appMode: AppModeService,
    private offlineSync: OfflineSyncService
  ) {
    this.initForm();
  }
  
  ngOnInit(): void {
    // S'abonner au mode offline
    this.appMode.mode$
      .pipe(takeUntil(this.destroy$))
      .subscribe(mode => {
        this.isReadOnly = mode === 'offline-readonly';
        console.log('Mode stock-list:', this.isReadOnly ? 'offline-readonly' : 'online');
        this.cdr.detectChanges();
      });
    
    // S'abonner aux compteurs d'alertes
    this.subscribeToAlertCounts();
    
    // Récupérer les informations de l'utilisateur connecté
    const user = this.authService.getUser();
    
    if (user) {
      this.currentJobNo = user.projet || '';
      this.userName = user.name;
      this.currentJobDescription = user.name || '';
      
      console.log('Utilisateur connecté:', this.userName);
      console.log('Projet associé:', this.currentJobNo);
      
      // Récupérer le magasin depuis l'API SiteManagement (juste pour l'affichage)
      if (this.currentJobNo) {
        this.loadMagasinForDisplay();
      } else {
        this.loadStock();
      }
    } else {
      this.loadStock();
    }
    
    this.setupFilters();
    this.startAutoRefresh();
  }
  
  ngOnDestroy(): void {
    this.destroy$.next();
    this.destroy$.complete();
    this.stopScanner();
  }
  
  // ==================== ALERTES ====================
  
  private startAutoRefresh(): void {
    interval(120000).pipe(takeUntil(this.destroy$)).subscribe(() => {
      if (!this.loading && !this.isReadOnly) {
        this.alertsCounterService.refresh();
      }
    });
  }
  
  private subscribeToAlertCounts(): void {
    this.alertsCounterService.counts$
      .pipe(takeUntil(this.destroy$))
      .subscribe(counts => {
        this.alertCount = counts.stock;
        this.cdr.detectChanges();
      });
  }
  
  /**
   * Navigation vers le centre d'alertes avec filtre stock
   */
  navigateToAlerts(): void {
    if (this.isReadOnly) {
      this.toastr.info('Alertes indisponibles en mode hors ligne', 'Mode lecture seule');
      return;
    }
    
    if (this.alertCount > 0) {
      this.soundService.playDefaultSound();
      this.toastr.info(`Vous avez ${this.alertCount} alerte(s) dans la gestion de stock`, 'Alertes disponibles', {
        positionClass: 'toast-top-right',
        timeOut: 6000,
        closeButton: true,
        progressBar: true
      });
    }
    
    this.router.navigate(['/alerts'], {
      queryParams: { 
        filterDomain: 'stock',
        source: 'stock-page'
      }
    });
  }
  
  // ==================== CHARGEMENT ====================
  
  /**
   * Charge le magasin associé depuis l'API SiteManagement (juste pour l'affichage)
   * Ne filtre PAS les données de stock
   */
  private loadMagasinForDisplay(): void {
    console.log('Chargement du magasin pour affichage...');
    
    this.siteManagementService.getMyProject().pipe(
      takeUntil(this.destroy$)
    ).subscribe({
      next: (project: Site | null) => {
        if (project && project.affectationMagasin) {
          this.currentLocationCode = project.affectationMagasin;
          console.log('Magasin associé (affichage uniquement):', this.currentLocationCode);
          
          if (project.description && !this.currentJobDescription) {
            this.currentJobDescription = project.description;
          }
          
          // Sauvegarder dans localStorage pour persistance
          const user = this.authService.getUser();
          if (user) {
            user.magasin = this.currentLocationCode;
            localStorage.setItem('user', JSON.stringify(user));
          }
        } else {
          console.warn('Aucun magasin associé au projet');
          this.currentLocationCode = '';
        }
        
        // Charger le stock SANS filtrer par le magasin
        this.loadStock();
      },
      error: (error) => {
        console.error('Erreur récupération magasin:', error);
        this.currentLocationCode = '';
        this.loadStock();
      }
    });
  }
  
  loadStock(): void {
    this.loading = true;
    this.errorMessage = '';
    this.cdr.detectChanges();
    
    console.log('Chargement du stock...');
    console.log('Magasin associé (affichage uniquement):', this.currentLocationCode);
    
    this.stockService.getAllStock().subscribe({
      next: (data) => {
        console.log('Stock reçu:', data?.length || 0, 'articles');
        
        this.stockItems = data || [];
        
        // Extraire la liste des magasins uniques
        this.uniqueLocations = [...new Set(this.stockItems.map(item => item.locationCode))];
        console.log('Magasins disponibles:', this.uniqueLocations);
        
        // Ne pas filtrer par currentLocationCode - afficher TOUS les articles
        this.filteredStockItems = [...this.stockItems];
        
        // Appliquer les filtres
        this.applyFilters();
        this.calculateStats();
        this.loading = false;
        this.cdr.detectChanges();
      },
      error: (error) => {
        console.error('Erreur chargement stock:', error);
        this.errorMessage = 'Impossible de charger les données de stock. Veuillez réessayer.';
        this.loading = false;
        this.cdr.detectChanges();
      }
    });
  }
  
  refresh(): void {
    if (this.isReadOnly) {
      this.toastr.info('Actualisation indisponible en mode hors ligne', 'Mode lecture seule');
      return;
    }
    this.loadStock();
    this.alertsCounterService.refresh();
    this.toastr.info('Rafraîchissement des données...', 'Actualisation', {
      positionClass: 'toast-top-right',
      timeOut: 1500
    });
  }
  
  // ==================== FILTRES ====================
  
  private initForm(): void {
    this.filterForm = this.fb.group({
      searchTerm: [''],
      locationCode: ['all'],
      stockStatus: ['all']
    });
  }
  
  private setupFilters(): void {
    this.filterForm.valueChanges
      .pipe(
        debounceTime(500),
        distinctUntilChanged(),
        takeUntil(this.destroy$)
      )
      .subscribe(() => {
        this.pageIndex = 0;
        this.applyFilters();
      });
  }
  
  applyFilters(): void {
    const formValue = this.filterForm.value;
    let filteredData = [...this.stockItems];
    
    // Filtre par recherche (code ou description)
    if (formValue.searchTerm && formValue.searchTerm.trim()) {
      const term = formValue.searchTerm.toLowerCase().trim();
      filteredData = filteredData.filter(item => 
        item.itemNo?.toLowerCase().includes(term) || 
        item.itemDescription?.toLowerCase().includes(term)
      );
    }
    
    // Filtre par magasin (uniquement si l'utilisateur en sélectionne un dans le filtre)
    if (formValue.locationCode && formValue.locationCode !== 'all') {
      filteredData = filteredData.filter(item => 
        item.locationCode === formValue.locationCode
      );
    }
    
    // Filtre par statut de stock
    if (formValue.stockStatus === 'low') {
      filteredData = filteredData.filter(item => item.quantity > 0 && item.quantity <= 10);
    } else if (formValue.stockStatus === 'out') {
      filteredData = filteredData.filter(item => item.quantity <= 0);
    }
    
    this.filteredStockItems = filteredData;
    this.totalItems = filteredData.length;
    this.pageIndex = 0;
    this.updatePagination();
    
    // Recalculer les stats après filtrage
    this.calculateStats();
  }
  
  private updatePagination(): void {
    const start = this.pageIndex * this.pageSize;
    const end = start + this.pageSize;
    this.paginatedItems = this.filteredStockItems.slice(start, end);
  }
  
  onPageChange(event: PageEvent): void {
    this.pageIndex = event.pageIndex;
    this.pageSize = event.pageSize;
    this.updatePagination();
  }
  
  private calculateStats(): void {
    const totalQuantity = this.filteredStockItems.reduce((sum, i) => sum + i.quantity, 0);
    const lowStockCount = this.filteredStockItems.filter(i => i.quantity > 0 && i.quantity <= 10).length;
    const outOfStockCount = this.filteredStockItems.filter(i => i.quantity <= 0).length;
    const uniqueLocations = new Set(this.filteredStockItems.map(i => i.locationCode)).size;
    const uniqueJobs = new Set(this.filteredStockItems.map(i => i.jobNo)).size;
    
    this.stats = {
      totalItems: this.filteredStockItems.length,
      totalQuantity: totalQuantity,
      uniqueLocations: uniqueLocations,
      uniqueJobs: uniqueJobs,
      lowStockCount: lowStockCount,
      outOfStockCount: outOfStockCount
    };
    
    console.log('Statistiques:', this.stats);
  }
  
  resetFilters(): void {
    this.filterForm.patchValue({
      searchTerm: '',
      locationCode: 'all',
      stockStatus: 'all'
    });
    this.pageIndex = 0;
    this.applyFilters();
  }
  
  toggleFilters(): void {
    this.filtersExpanded = !this.filtersExpanded;
  }
  
  hasActiveFilters(): boolean {
    const formValue = this.filterForm.value;
    return !!(formValue.searchTerm || 
      (formValue.locationCode && formValue.locationCode !== 'all') ||
      (formValue.stockStatus && formValue.stockStatus !== 'all'));
  }
  
  getActiveFiltersCount(): number {
    const formValue = this.filterForm.value;
    let count = 0;
    if (formValue.searchTerm) count++;
    if (formValue.locationCode && formValue.locationCode !== 'all') count++;
    if (formValue.stockStatus && formValue.stockStatus !== 'all') count++;
    return count;
  }
  
  getSelectedLocationName(): string {
    const selectedCode = this.filterForm.get('locationCode')?.value;
    if (!selectedCode || selectedCode === 'all') return 'Tous les magasins';
    return selectedCode;
  }
  
  // ==================== UTILITAIRES ====================
  
  getQuantityClass(quantity: number): string {
    if (quantity <= 0) return 'quantity-out';
    if (quantity <= 10) return 'quantity-low';
    return 'quantity-normal';
  }
  
  getQuantityIcon(quantity: number): string {
    if (quantity <= 0) return 'error';
    if (quantity <= 10) return 'warning';
    return 'check_circle';
  }
  
  getQuantityText(quantity: number): string {
    if (quantity <= 0) return 'Rupture';
    if (quantity <= 10) return 'Stock faible';
    return 'Normal';
  }
  
  formatQuantity(quantity: number): string {
    return new Intl.NumberFormat('fr-FR').format(quantity);
  }
  
  formatLargeNumber(value: number): string {
    if (value >= 1_000_000) {
      return (value / 1_000_000).toFixed(1) + 'M';
    }
    if (value >= 1_000) {
      return (value / 1_000).toFixed(1) + 'k';
    }
    return value.toLocaleString('fr-FR');
  }
  
  viewItem(item: StockItem): void {
    console.log('Voir détails:', item.itemNo);
    this.dialog.open(StockDetailComponent, {
      data: item,
      width: '600px',
      maxWidth: '90vw',
      panelClass: 'stock-detail-dialog'
    });
  }
  
  // ==================== SCANNEUR CODE-BARRES ====================
  
  /**
   * Ouvre le dialogue du scanner de code-barres
   */
  openBarcodeScanner(): void {
    if (this.isDialogOpening || this.barcodeDialogRef) {
      return;
    }
    
    this.isDialogOpening = true;
    
    const dialogRef = this.dialog.open(this.barcodeScannerDialog, {
      width: '550px',
      maxWidth: '90vw',
      panelClass: 'barcode-scanner-panel',
      disableClose: true,
      backdropClass: 'custom-heavy-backdrop',
      hasBackdrop: true
    });
    
    this.barcodeDialogRef = dialogRef;
    
    // Style du backdrop
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
    
    dialogRef.afterOpened().subscribe(() => {
      setTimeout(() => this.startScanner(), 500);
    });
    
    dialogRef.afterClosed().subscribe(() => {
      this.barcodeDialogRef = null;
      this.isDialogOpening = false;
      this.stopScanner();
      this.cdr.detectChanges();
    });
  }
  
  /**
   * Ferme le dialogue du scanner
   */
  closeBarcodeScanner(): void {
    if (this.barcodeDialogRef) {
      this.barcodeDialogRef.close();
      this.barcodeDialogRef = null;
    }
    this.isDialogOpening = false;
  }
  
  /**
   * Démarre le scanner
   */
  private async startScanner(): Promise<void> {
    const config: Html5QrcodeCameraScanConfig = {
      fps: 10,
      qrbox: { width: 250, height: 250 },
      aspectRatio: 1.0
    };
    
    try {
      this.scanner = new Html5Qrcode('scanner-reader-stock');
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
      console.log('Scanner démarré');
    } catch (error) {
      console.error('Erreur démarrage scanner:', error);
      this.audioService.playError();
      this.toastr.error('Impossible d\'accéder à la caméra. Vérifiez les permissions.', 'Erreur');
      this.closeBarcodeScanner();
    }
  }
  
  /**
   * Arrête le scanner
   */
  private async stopScanner(): Promise<void> {
    if (this.scanner) {
      try {
        await this.scanner.stop();
        this.scanner = null;
        console.log('Scanner arrêté');
      } catch (error) {
        console.warn('Erreur arrêt scanner:', error);
      }
    }
  }
  
  /**
   * Callback appelé lors du scan d'un code-barres
   */
  onScanSuccess(scannedCode: string): void {
    console.log('Code-barres scanné:', scannedCode);
    
    // Jouer le son de scan réussi
    this.audioService.playScanSuccess();
    
    if (scannedCode) {
      this.processScannedCode(scannedCode);
    }
  }
  
  /**
   * Traite le code scanné et recherche l'article correspondant
   */
  private processScannedCode(scannedCode: string): void {
    this.scannerLoading = true;
    this.cdr.detectChanges();
    
    // Arrêter le scanner pendant la recherche
    this.stopScanner();
    
    // Rechercher l'article par son code
    const foundItem = this.stockItems.find(item => 
      item.itemNo === scannedCode || 
      (item.itemNo && item.itemNo.toLowerCase() === scannedCode.toLowerCase())
    );
    
    setTimeout(() => {
      this.scannerLoading = false;
      
      if (foundItem) {
        // Succès - ouvrir le détail de l'article
        this.toastr.success(`Article "${foundItem.itemNo}" trouvé !`, 'Succès', {
          positionClass: 'toast-top-right',
          timeOut: 3000
        });
        this.closeBarcodeScanner();
        this.viewItem(foundItem);
      } else {
        // Jouer le son d'erreur
        this.audioService.playError();
        
        // Boîte de dialogue de confirmation élégante pour article non trouvé
        const dialogData: ConfirmationDialogData = {
          title: 'Article non trouvé',
          message: `L'article "${scannedCode}" n'existe pas dans le stock.\n\nSouhaitez-vous réessayer de scanner un autre code-barres ?`,
          confirmText: 'Réessayer',
          cancelText: 'Fermer',
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
            // Réessayer - rouvrir le scanner
            this.startScanner();
          } else {
            // Fermer le dialogue du scanner
            this.closeBarcodeScanner();
          }
        });
      }
      
      this.cdr.detectChanges();
    }, 500);
  }
  
  /**
   * Formate la date du dernier mouvement
   */
  formatLastPostingDate(date: string | null | undefined): string {
    if (!date) return '—';
    
    try {
      let d: Date;
      if (date.includes('T')) {
        d = new Date(date);
      } else if (date.includes('-')) {
        const parts = date.split('-');
        d = new Date(parseInt(parts[0]), parseInt(parts[1]) - 1, parseInt(parts[2]));
      } else {
        d = new Date(date);
      }
      
      if (isNaN(d.getTime())) return '—';
      if (d.getFullYear() < 1900) return '—';
      
      const day = d.getDate().toString().padStart(2, '0');
      const month = (d.getMonth() + 1).toString().padStart(2, '0');
      const year = d.getFullYear();
      
      return `${day}/${month}/${year}`;
    } catch {
      return '—';
    }
  }
}

export { StockListComponent as StockList };