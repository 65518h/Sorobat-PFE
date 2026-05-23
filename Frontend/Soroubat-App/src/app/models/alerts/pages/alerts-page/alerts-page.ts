// src/app/modules/alerts/pages/alerts-page/alerts-page.component.ts

import { Component, OnInit, OnDestroy, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router, RouterModule } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { Subject, takeUntil, debounceTime, distinctUntilChanged, of } from 'rxjs';
import { catchError } from 'rxjs/operators';

// Angular Material
import { MatCardModule } from '@angular/material/card';
import { MatIconModule } from '@angular/material/icon';
import { MatButtonModule } from '@angular/material/button';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { MatTooltipModule } from '@angular/material/tooltip';
import { MatBadgeModule } from '@angular/material/badge';
import { MatPaginatorModule } from '@angular/material/paginator';

// Services
import { AlertsService } from '../../services/alerts.service';
import { NotificationService } from '../../../../core/services/notification';
import { Alert, DOMAINS } from '../../../alerts/models/alerts.model';
import { AppModeService } from '../../../../core/services/app-mode.service';
import { CacheService } from '../../../../core/services/cache.service';
import { OfflineHideActionsDirective } from '../../../../core/directives/offline-hide-actions.directive';
import { ShowOfflineMessageDirective } from '../../../../core/directives/show-offline-message.directive';

@Component({
  selector: 'app-alerts-page',
  standalone: true,
  imports: [
    CommonModule,
    FormsModule,
    RouterModule,
    MatCardModule,
    MatIconModule,
    MatButtonModule,
    MatProgressSpinnerModule,
    MatTooltipModule,
    MatBadgeModule,
    MatPaginatorModule,
    OfflineHideActionsDirective,
    ShowOfflineMessageDirective
  ],
  templateUrl: './alerts-page.html',
  styleUrls: ['./alerts-page.css']
})
export class AlertsPageComponent implements OnInit, OnDestroy {
  
  // Alertes par domaine (corrigé selon les endpoints disponibles)
  purchaseAlerts: Alert[] = [];
  transferAlerts: Alert[] = [];
  stockAlerts: Alert[] = [];
  vehiculeAlerts: Alert[] = [];
  gasoilAlerts: Alert[] = [];
  attendanceAlerts: Alert[] = [];
  
  // Pagination par section
  pageSizePerSection: number = 10;
  currentPage: { [key: string]: number } = {
    purchaseRequests: 1,
    transfers: 1,
    stock: 1,
    vehicules: 1,
    gasoil: 1,
    attendance: 1
  };
  
  // Filtres
  selectedDomain: string = 'all';
  selectedSeverity: string = 'all';
  searchTerm: string = '';
  loading: boolean = false;
  
  // Nouveaux filtres
  showAdvancedFilters: boolean = false;
  selectedPeriod: string = 'all';
  selectedReadStatus: string = 'all';
  sortBy: string = 'date_desc';
  unreadCount: number = 0;
  
  // Domaines
  domains = DOMAINS;
  
  // Statistiques
  totalAlerts: number = 0;
  criticalCount: number = 0;
  warningCount: number = 0;
  infoCount: number = 0;
  
  // Mode offline
  isReadOnly: boolean = false;
  
  private destroy$ = new Subject<void>();
  private searchSubject = new Subject<string>();
  
  constructor(
    private alertsService: AlertsService,
    private notificationService: NotificationService,
    private router: Router,
    private cdr: ChangeDetectorRef,
    private appMode: AppModeService,
    private cacheService: CacheService
  ) {}
  
  ngOnInit(): void {
    // S'abonner au mode offline
    this.appMode.mode$
      .pipe(takeUntil(this.destroy$))
      .subscribe(mode => {
        this.isReadOnly = mode === 'offline-readonly';
        console.log('🔔 Mode alertes:', this.isReadOnly ? 'offline-readonly' : 'online');
        this.cdr.detectChanges();
      });
    
    this.loadAllAlerts();
    this.setupSearchDebounce();
  }
  
  ngOnDestroy(): void {
    this.destroy$.next();
    this.destroy$.complete();
  }
  
  private setupSearchDebounce(): void {
    this.searchSubject.pipe(
      debounceTime(500),
      distinctUntilChanged(),
      takeUntil(this.destroy$)
    ).subscribe(() => {
      this.resetAllPages();
      this.calculateStats();
      this.applyFilters();
    });
  }
  
  loadAllAlerts(): void {
    this.loading = true;
    this.cdr.detectChanges();
    
    const limitPerDomain = 50;
    const cacheKey = 'alerts-all-domains';
    
    // TOUJOURS charger le cache d'abord pour l'affichage immédiat
    this.cacheService.getFromCache(cacheKey).then(cachedData => {
      if (cachedData) {
        console.log('📦 Alertes: Chargement depuis le cache');
        this.applyAlertsData(cachedData);
        this.loading = false;
        this.cdr.detectChanges();
        
        // Si on est en ligne, rafraîchir en arrière-plan
        if (!this.isReadOnly) {
          this.refreshAlertsInBackground(cacheKey, limitPerDomain);
        }
      } else if (!this.isReadOnly) {
        // Cache vide ET en ligne → initialiser le cache
        console.log('🔄 Cache vide, initialisation...');
        this.initializeCacheFromApi(cacheKey, limitPerDomain);
      } else {
        // Cache vide et hors ligne → message d'erreur
        console.log('⚠️ Aucune donnée en cache et mode offline');
        this.loading = false;
        this.notificationService.showWarning(
          '❌ Aucune donnée disponible hors ligne. Veuillez vous connecter une première fois pour mettre en cache les alertes.'
        );
        this.cdr.detectChanges();
      }
    }).catch(error => {
      console.error('❌ Erreur accès cache:', error);
      if (!this.isReadOnly) {
        this.initializeCacheFromApi(cacheKey, limitPerDomain);
      } else {
        this.loading = false;
        this.notificationService.showError('Impossible d\'accéder au cache local');
        this.cdr.detectChanges();
      }
    });
  }
  
  private initializeCacheFromApi(cacheKey: string, limitPerDomain: number): void {
    this.alertsService.getAllAlertsByDomain(limitPerDomain).pipe(
      takeUntil(this.destroy$),
      catchError(error => {
        console.error('❌ Erreur initialisation cache:', error);
        this.loading = false;
        this.notificationService.showError('Erreur lors du chargement initial des alertes');
        this.cdr.detectChanges();
        return of(null);
      })
    ).subscribe({
      next: (alerts) => {
        if (alerts) {
          this.applyAlertsData(alerts);
          this.cacheService.saveToCache(cacheKey, alerts);
          console.log('💾 Cache initialisé avec succès');
          this.notificationService.showSuccess('Alertes chargées et mises en cache');
        } else {
          // Même si alerts est null, on initialise avec des tableaux vides
          const emptyData = {
            purchaseRequests: [],
            transfers: [],
            stock: [],
            vehicules: [],
            gasoil: [],
            attendance: []
          };
          this.applyAlertsData(emptyData);
          this.cacheService.saveToCache(cacheKey, emptyData);
          console.log('💾 Cache initialisé (vide)');
        }
        this.loading = false;
        this.cdr.detectChanges();
      },
      error: () => {
        this.loading = false;
        this.cdr.detectChanges();
      }
    });
  }
  
  private refreshAlertsInBackground(cacheKey: string, limitPerDomain: number): void {
    this.alertsService.getAllAlertsByDomain(limitPerDomain).pipe(
      takeUntil(this.destroy$),
      catchError(error => {
        console.error('❌ Erreur rafraîchissement alertes:', error);
        return of(null);
      })
    ).subscribe({
      next: (alerts) => {
        if (alerts) {
          const hasChanges = this.hasAlertsChanged(alerts);
          this.applyAlertsData(alerts);
          this.cacheService.saveToCache(cacheKey, alerts);
          if (hasChanges) {
            console.log('💾 Alertes mises à jour en cache');
            this.notificationService.showInfo('Nouvelles alertes disponibles');
          }
          this.cdr.detectChanges();
        }
      }
    });
  }
  
  private hasAlertsChanged(newAlerts: any): boolean {
    const currentTotal = this.purchaseAlerts.length + this.transferAlerts.length + 
                         this.stockAlerts.length + this.vehiculeAlerts.length + 
                         this.gasoilAlerts.length + this.attendanceAlerts.length;
    const newTotal = (newAlerts.purchaseRequests?.length || 0) + (newAlerts.transfers?.length || 0) +
                     (newAlerts.stock?.length || 0) + (newAlerts.vehicules?.length || 0) +
                     (newAlerts.gasoil?.length || 0) + (newAlerts.attendance?.length || 0);
    return currentTotal !== newTotal;
  }
  
  private applyAlertsData(alerts: any): void {
    this.purchaseAlerts = alerts.purchaseRequests || [];
    this.transferAlerts = alerts.transfers || [];
    this.stockAlerts = alerts.stock || [];
    this.vehiculeAlerts = alerts.vehicules || [];
    this.gasoilAlerts = alerts.gasoil || [];
    this.attendanceAlerts = alerts.attendance || [];
    
    this.resetAllPages();
    this.calculateStats();
    this.applyFilters();
    
    console.log('✅ Alertes chargées:', {
      purchase: this.purchaseAlerts.length,
      transfer: this.transferAlerts.length,
      stock: this.stockAlerts.length,
      vehicule: this.vehiculeAlerts.length,
      gasoil: this.gasoilAlerts.length,
      attendance: this.attendanceAlerts.length,
      mode: this.isReadOnly ? 'offline' : 'online'
    });
  }
  
  // Récupère les alertes paginées pour une section
  getPaginatedAlerts(domainKey: string): Alert[] {
    const allAlerts = this.getFilteredDomainAlerts(domainKey);
    const startIndex = (this.currentPage[domainKey] - 1) * this.pageSizePerSection;
    const endIndex = startIndex + this.pageSizePerSection;
    return allAlerts.slice(startIndex, endIndex);
  }
  
  // Calcule le nombre total de pages pour une section
  getTotalPages(domainKey: string): number {
    const totalAlerts = this.getFilteredDomainAlerts(domainKey).length;
    return Math.ceil(totalAlerts / this.pageSizePerSection);
  }
  
  // Change de page pour une section spécifique
  changePage(domainKey: string, direction: 'prev' | 'next'): void {
    const totalPages = this.getTotalPages(domainKey);
    if (direction === 'prev' && this.currentPage[domainKey] > 1) {
      this.currentPage[domainKey]--;
    } else if (direction === 'next' && this.currentPage[domainKey] < totalPages) {
      this.currentPage[domainKey]++;
    }
    this.cdr.detectChanges();
  }
  
  // Réinitialise toutes les pages à 1
  private resetAllPages(): void {
    Object.keys(this.currentPage).forEach(key => {
      this.currentPage[key] = 1;
    });
  }
  
  // MÉTHODE PRINCIPALE - Retourne les alertes filtrées par domaine
  getFilteredDomainAlerts(domainKey: string): Alert[] {
    let alerts: Alert[] = [];
    
    // Récupérer les alertes du domaine
    switch(domainKey) {
      case 'purchaseRequests':
        alerts = [...this.purchaseAlerts];
        break;
      case 'transfers':
        alerts = [...this.transferAlerts];
        break;
      case 'stock':
        alerts = [...this.stockAlerts];
        break;
      case 'vehicules':
        alerts = [...this.vehiculeAlerts];
        break;
      case 'gasoil':
        alerts = [...this.gasoilAlerts];
        break;
      case 'attendance':
        alerts = [...this.attendanceAlerts];
        break;
      default:
        return [];
    }
    
    // Filtrer par sévérité
    if (this.selectedSeverity !== 'all') {
      alerts = alerts.filter(a => a.severity === this.selectedSeverity);
    }
    
    // Filtrer par statut de lecture
    if (this.selectedReadStatus !== 'all') {
      const isReadStatus = this.selectedReadStatus === 'read';
      alerts = alerts.filter(a => this.isRead(a.id) === isReadStatus);
    }
    
    // Filtrer par période
    if (this.selectedPeriod !== 'all') {
      const now = new Date();
      const today = new Date(now.getFullYear(), now.getMonth(), now.getDate());
      
      alerts = alerts.filter(a => {
        const alertDate = new Date(a.detectedAt);
        
        switch(this.selectedPeriod) {
          case 'today':
            return alertDate >= today;
          case 'week':
            const weekAgo = new Date(now.getTime() - 7 * 24 * 60 * 60 * 1000);
            return alertDate >= weekAgo;
          case 'month':
            const monthAgo = new Date(now.getTime() - 30 * 24 * 60 * 60 * 1000);
            return alertDate >= monthAgo;
          default:
            return true;
        }
      });
    }
    
    // Filtrer par recherche
    if (this.searchTerm && this.searchTerm.trim()) {
      const term = this.searchTerm.toLowerCase().trim();
      alerts = alerts.filter(a =>
        a.title.toLowerCase().includes(term) ||
        a.message.toLowerCase().includes(term) ||
        a.relatedEntityNo.toLowerCase().includes(term) ||
        a.type.toLowerCase().includes(term)
      );
    }
    
    // Trier les alertes
    alerts = this.sortAlerts(alerts);
    
    return alerts;
  }
  
  // Méthode de tri
  private sortAlerts(alerts: Alert[]): Alert[] {
    switch(this.sortBy) {
      case 'date_asc':
        return [...alerts].sort((a, b) => new Date(a.detectedAt).getTime() - new Date(b.detectedAt).getTime());
      case 'severity':
        const severityOrder = { 'Critical': 3, 'Warning': 2, 'Info': 1 };
        return [...alerts].sort((a, b) => severityOrder[b.severity] - severityOrder[a.severity]);
      case 'date_desc':
      default:
        return [...alerts].sort((a, b) => new Date(b.detectedAt).getTime() - new Date(a.detectedAt).getTime());
    }
  }
  
  // Méthode pour obtenir le compteur d'un domaine
  getDomainCount(domainKey: string): number {
    return this.getFilteredDomainAlerts(domainKey).length;
  }
  
  // Méthode pour vérifier s'il y a des domaines filtrés
  getFilteredDomainsCount(): number {
    let count = 0;
    if (this.getFilteredDomainAlerts('purchaseRequests').length > 0) count++;
    if (this.getFilteredDomainAlerts('transfers').length > 0) count++;
    if (this.getFilteredDomainAlerts('stock').length > 0) count++;
    if (this.getFilteredDomainAlerts('vehicules').length > 0) count++;
    if (this.getFilteredDomainAlerts('gasoil').length > 0) count++;
    if (this.getFilteredDomainAlerts('attendance').length > 0) count++;
    return count;
  }
  
  // Vérifie si un domaine a des alertes après filtres
  hasDomainAlerts(domainKey: string): boolean {
    return this.getFilteredDomainAlerts(domainKey).length > 0;
  }
  
  // Calculer les statistiques
  calculateStats(): void {
    let allAlerts = this.getAllAlertsForCurrentDomain();
    allAlerts = this.applyAllFilters(allAlerts);
    
    this.criticalCount = allAlerts.filter(a => a.severity === 'Critical').length;
    this.warningCount = allAlerts.filter(a => a.severity === 'Warning').length;
    this.infoCount = allAlerts.filter(a => a.severity === 'Info').length;
    this.unreadCount = allAlerts.filter(a => !this.isRead(a.id)).length;
  }
  
  private getAllAlertsForCurrentDomain(): Alert[] {
    if (this.selectedDomain === 'all') {
      return [
        ...this.purchaseAlerts,
        ...this.transferAlerts,
        ...this.stockAlerts,
        ...this.vehiculeAlerts,
        ...this.gasoilAlerts,
        ...this.attendanceAlerts
      ];
    }
    
    switch(this.selectedDomain) {
      case 'purchaseRequests': return [...this.purchaseAlerts];
      case 'transfers': return [...this.transferAlerts];
      case 'stock': return [...this.stockAlerts];
      case 'vehicules': return [...this.vehiculeAlerts];
      case 'gasoil': return [...this.gasoilAlerts];
      case 'attendance': return [...this.attendanceAlerts];
      default: return [];
    }
  }
  
  private applyAllFilters(alerts: Alert[]): Alert[] {
    let filtered = [...alerts];
    
    if (this.selectedSeverity !== 'all') {
      filtered = filtered.filter(a => a.severity === this.selectedSeverity);
    }
    
    if (this.selectedReadStatus !== 'all') {
      const isReadStatus = this.selectedReadStatus === 'read';
      filtered = filtered.filter(a => this.isRead(a.id) === isReadStatus);
    }
    
    if (this.selectedPeriod !== 'all') {
      const now = new Date();
      const today = new Date(now.getFullYear(), now.getMonth(), now.getDate());
      
      filtered = filtered.filter(a => {
        const alertDate = new Date(a.detectedAt);
        switch(this.selectedPeriod) {
          case 'today': return alertDate >= today;
          case 'week': return alertDate >= new Date(now.getTime() - 7 * 24 * 60 * 60 * 1000);
          case 'month': return alertDate >= new Date(now.getTime() - 30 * 24 * 60 * 60 * 1000);
          default: return true;
        }
      });
    }
    
    if (this.searchTerm && this.searchTerm.trim()) {
      const term = this.searchTerm.toLowerCase().trim();
      filtered = filtered.filter(a =>
        a.title.toLowerCase().includes(term) ||
        a.message.toLowerCase().includes(term) ||
        a.relatedEntityNo.toLowerCase().includes(term) ||
        a.type.toLowerCase().includes(term)
      );
    }
    
    return filtered;
  }
  
  applyFilters(): void {
    let total = 0;
    
    if (this.selectedDomain === 'all' || this.selectedDomain === 'purchaseRequests') {
      total += this.getFilteredDomainAlerts('purchaseRequests').length;
    }
    if (this.selectedDomain === 'all' || this.selectedDomain === 'transfers') {
      total += this.getFilteredDomainAlerts('transfers').length;
    }
    if (this.selectedDomain === 'all' || this.selectedDomain === 'stock') {
      total += this.getFilteredDomainAlerts('stock').length;
    }
    if (this.selectedDomain === 'all' || this.selectedDomain === 'vehicules') {
      total += this.getFilteredDomainAlerts('vehicules').length;
    }
    if (this.selectedDomain === 'all' || this.selectedDomain === 'gasoil') {
      total += this.getFilteredDomainAlerts('gasoil').length;
    }
    if (this.selectedDomain === 'all' || this.selectedDomain === 'attendance') {
      total += this.getFilteredDomainAlerts('attendance').length;
    }
    
    this.totalAlerts = total;
    this.cdr.detectChanges();
  }
  
  // Filtres avec mise à jour des stats
  filterByDomain(domain: string): void {
    this.selectedDomain = domain;
    this.resetAllPages();
    this.calculateStats();
    this.applyFilters();
  }
  
  filterBySeverity(severity: string): void {
    this.selectedSeverity = severity;
    this.resetAllPages();
    this.calculateStats();
    this.applyFilters();
  }
  
  filterByPeriod(period: string): void {
    this.selectedPeriod = period;
    this.resetAllPages();
    this.calculateStats();
    this.applyFilters();
  }
  
  filterByReadStatus(status: string): void {
    this.selectedReadStatus = status;
    this.resetAllPages();
    this.calculateStats();
    this.applyFilters();
  }
  
  sortByDate(order: 'asc' | 'desc'): void {
    this.sortBy = order === 'desc' ? 'date_desc' : 'date_asc';
    this.resetAllPages();
    this.applyFilters();
  }
  
  sortBySeverity(): void {
    this.sortBy = 'severity';
    this.resetAllPages();
    this.applyFilters();
  }
  
  onSearchChange(): void {
    this.searchSubject.next(this.searchTerm);
  }
  
  clearSearch(): void {
    this.searchTerm = '';
    this.resetAllPages();
    this.calculateStats();
    this.applyFilters();
  }
  
  quickSearch(keyword: string): void {
    this.searchTerm = keyword;
    this.resetAllPages();
    this.calculateStats();
    this.applyFilters();
    this.notificationService.showInfo(`Recherche : "${keyword}"`);
  }
  
  hasActiveFilters(): boolean {
    return this.selectedSeverity !== 'all' ||
           this.selectedDomain !== 'all' ||
           this.searchTerm !== '' ||
           this.selectedPeriod !== 'all' ||
           this.selectedReadStatus !== 'all';
  }
  
  clearAllFilters(): void {
    this.selectedSeverity = 'all';
    this.selectedDomain = 'all';
    this.searchTerm = '';
    this.selectedPeriod = 'all';
    this.selectedReadStatus = 'all';
    this.sortBy = 'date_desc';
    this.resetAllPages();
    this.calculateStats();
    this.applyFilters();
    this.notificationService.showInfo('Tous les filtres ont été réinitialisés');
  }
  
  toggleAdvancedFilters(): void {
    this.showAdvancedFilters = !this.showAdvancedFilters;
  }
  
  refreshAll(): void {
    if (this.isReadOnly) {
      this.notificationService.showWarning('Mode hors ligne - Rafraîchissement non disponible');
      return;
    }
    this.alertsService.clearCache();
    this.loadAllAlerts();
    this.notificationService.showInfo('Rafraîchissement des alertes...');
  }
  
  markAsRead(alertId: string): void {
    this.alertsService.markAsRead(alertId);
    this.updateAlertInLists(alertId);
    this.calculateStats();
    this.applyFilters();
    this.cdr.detectChanges();
  }
  
  markAllAsRead(): void {
    const allAlerts = [
      ...this.purchaseAlerts,
      ...this.transferAlerts,
      ...this.stockAlerts,
      ...this.vehiculeAlerts,
      ...this.gasoilAlerts,
      ...this.attendanceAlerts
    ];
    
    allAlerts.forEach(alert => {
      this.alertsService.markAsRead(alert.id);
    });
    
    this.calculateStats();
    this.applyFilters();
    this.notificationService.showSuccess('Toutes les alertes ont été marquées comme lues');
    this.cdr.detectChanges();
  }
  
  private updateAlertInLists(alertId: string): void {
    this.purchaseAlerts = this.updateSingleAlert(this.purchaseAlerts, alertId);
    this.transferAlerts = this.updateSingleAlert(this.transferAlerts, alertId);
    this.stockAlerts = this.updateSingleAlert(this.stockAlerts, alertId);
    this.vehiculeAlerts = this.updateSingleAlert(this.vehiculeAlerts, alertId);
    this.gasoilAlerts = this.updateSingleAlert(this.gasoilAlerts, alertId);
    this.attendanceAlerts = this.updateSingleAlert(this.attendanceAlerts, alertId);
  }
  
  private updateSingleAlert(alerts: Alert[], alertId: string): Alert[] {
    const index = alerts.findIndex(a => a.id === alertId);
    if (index !== -1) {
      alerts[index] = { ...alerts[index], read: true };
    }
    return [...alerts];
  }
  
  isRead(alertId: string): boolean {
    return this.alertsService.isRead(alertId);
  }
  
  onAlertClick(alert: Alert): void {
    this.alertsService.markAsRead(alert.id);
    this.navigateToAlert(alert);
  }
  
  navigateToAlert(alert: Alert): void {
    const routes: Record<string, string> = {
      // Demandes d'achat
      'PurchaseRequestRejected': '/purchases/requests',
      'PurchaseRequestPendingTooLong': '/purchases/requests',
      'PurchaseRequestEmpty': '/purchases/requests',
      
      // Transferts
      'TransferStuckInTransit': '/transfers',
      'TransferNotShipped': '/transfers',
      'TransferPartialReceipt': '/transfers',
      'TransferNoVehicle': '/transfers',
      
      // Stock
      'StockNegatif': '/inventory',
      'StockCritique': '/inventory',
      'StockDormant': '/inventory',
      
      // Véhicules
      'PointageNonValide': '/equipment',
      'VehiculeSurutilise': '/equipment',
      'IndexIncoherent': '/equipment',
      'ConsommationAnormale': '/equipment',
      
      // Gasoil
      'GasoilFicheNonValidee': '/gasoil',
      'GasoilConsommationTotaleAnormale': '/gasoil',
      'GasoilLigneSansVehicule': '/gasoil',
      'GasoilQuantiteLigneAnormale': '/gasoil',
      
      // Pointage
      'AttendanceFicheSansLignes': '/attendance',
      'AttendanceSalarieNonPointe': '/attendance'
    };
    
    const route = routes[alert.type] || '/dashboard';
    this.router.navigate([route], { queryParams: { highlight: alert.relatedEntityNo } });
  }
  
  getSeverityIcon(severity: string): string {
    switch(severity) {
      case 'Critical': return 'error';
      case 'Warning': return 'warning';
      default: return 'info';
    }
  }
  
  getSeverityClass(severity: string): string {
    return severity.toLowerCase();
  }
  
  // Debug helper
  getTotalAlertsCount(): number {
    return this.purchaseAlerts.length + this.transferAlerts.length + 
           this.stockAlerts.length + this.vehiculeAlerts.length + 
           this.gasoilAlerts.length + this.attendanceAlerts.length;
  }
}