// src/app/modules/dashboard/pages/dashboard-home/dashboard-home.ts

import {
  Component, OnInit, OnDestroy, ChangeDetectorRef,
  AfterViewInit, ElementRef, ViewChild, NgZone
} from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule, Router } from '@angular/router';
import { Subject, firstValueFrom } from 'rxjs';
import { takeUntil, timeout } from 'rxjs/operators';
import { Chart, registerables } from 'chart.js';
import { ToastrService } from 'ngx-toastr';
import { MatIcon } from '@angular/material/icon';
import { MatTooltipModule } from '@angular/material/tooltip';

import {
  DashboardService, DashboardKpi, ProjectProgress,
  TaskStatusCount, OverdueTask
} from '../../services/dashboard.service';
import { StockService } from '../../../inventory/services/stock';
import { VehiculePointageService } from '../../../equipment/services/vehicule-pointage.service';
import { AlertsService } from '../../../../models/alerts/services/alerts.service';
import { Alert } from '../../../../models/alerts/models/alerts.model';
import { SoundService } from '../../../../core/services/sound.service';
import { AlertsCounterService } from '../../../../core/services/alerts-counter.service';
import { AttendanceService } from '../../../attendance/services/attendance.service';
import { AttendanceHeader, AttendanceLine } from '../../../attendance/models/attendance.model';
import { OfflineSyncService } from '../../../../core/services/offline-sync.service';
import { CacheService } from '../../../../core/services/cache.service';

Chart.register(...registerables);

// ─── Modèles internes ──────────────────────────────────────
export interface TaskDetail {
  taskNo:      string;
  description: string;
  progressPct: number;
  dateFin:     string | null;
  dateDebut:   string | null;
  isBlocked:   boolean;
}

export interface StockArticle {
  code:            string;
  description:     string;
  location:        string;
  quantity:        number;
  lastPostingDate: string | null;
}

export interface PendingPointage {
  documentNo: string;
  date:       string;
}

export interface VehiclePanne {
  vehiculeNo:  string;
  description: string;
  panneCount:  number;
}

export interface MainStoreInfo {
  name: string;
  code: string;
  itemCount: number;
  totalQuantity: number;
}

// ─── Config domaines d'alertes (corrigé - sans siteManagement, avec attendance) ───
const ALERT_DOMAINS = [
  { key: 'purchaseRequests', label: 'Demandes d\'achat',   icon: 'shopping_cart',    gradient: 'linear-gradient(135deg,#8b5cf6,#7c3aed)' },
  { key: 'transfers',       label: 'Ordres de transfert', icon: 'local_shipping',   gradient: 'linear-gradient(135deg,#06b6d4,#0891b2)' },
  { key: 'stock',           label: 'Stock',               icon: 'inventory_2',      gradient: 'linear-gradient(135deg,#3b82f6,#2563eb)' },
  { key: 'vehicules',       label: 'Engins',              icon: 'construction',     gradient: 'linear-gradient(135deg,#f59e0b,#d97706)' },
  { key: 'gasoil',          label: 'Gasoil',              icon: 'local_gas_station',gradient: 'linear-gradient(135deg,#10b981,#059669)' },
  { key: 'attendance',      label: 'Pointage',            icon: 'event_available',  gradient: 'linear-gradient(135deg,#8b5cf6,#7c3aed)' },
] as const;

@Component({
  selector: 'app-dashboard-home',
  standalone: true,
  imports: [CommonModule, RouterModule, MatIcon, MatTooltipModule],
  templateUrl: './dashboard-home.html',
  styleUrls: ['./dashboard-home.css']
})
export class DashboardHomeComponent implements OnInit, OnDestroy, AfterViewInit {

  private destroy$ = new Subject<void>();
  private charts: { [key: string]: Chart | null } = {
    vehiclePointage: null,
    vehicleStatus: null,
    stockEvolution: null,
    stockDistribution: null
  };
  private loadingTimeout: any;
  private refreshInterval: any;
  private chartsInitialized = false;
  private notificationShownToday = false;
  private isCheckingNotifications = false;
  private notificationDisplayedForSession: boolean = false;

  // ── État général ──────────────────────────────────────────
  isLoading = true;
  hasError = false;
  lastUpdate = new Date();
  isDarkMode = false;

  // ── État connectivité offline ────────────────────────────
  isOnline: boolean = true;

  // ── Canvas ────────────────────────────────────────────────
  @ViewChild('vehiclePointageChart', { static: false }) vehiclePointageChart!: ElementRef;
  @ViewChild('vehicleStatusChart', { static: false }) vehicleStatusChart!: ElementRef;
  @ViewChild('stockEvolutionChart', { static: false }) stockEvolutionChart!: ElementRef;
  @ViewChild('stockDistributionChart', { static: false }) stockDistributionChart!: ElementRef;

  // ── KPI ──────────────────────────────────────────────────
  kpi: DashboardKpi & { tasksBlocked: number } = {
    activeProjects: 0, totalProjects: 0,
    tasksInProgress: 0, tasksOverdue: 0,
    tasksCompleted: 0, tasksTotal: 0,
    criticalStockCount: 0, activeEngines: 0,
    tasksBlocked: 0
  };

  // ── Données ────────────────────────────────────────────────
  projectsProgress: ProjectProgress[] = [];
  tasksByStatus: TaskStatusCount[] = [];
  overdueTasks: OverdueTask[] = [];
  tasksDetail: TaskDetail[] = [];

  // ── Stock ─────────────────────────────────────────────────
  stockStats: any = { totalItems: 0, totalQuantity: 0, lowStockCount: 0, outOfStockCount: 0 };
  stockByLocation: { location: string; quantity: number }[] = [];
  activeStockTab: 'outOfStock' | 'lowStock' | 'dormant' = 'outOfStock';

  stockCritical: {
    outOfStock: StockArticle[];
    lowStock: StockArticle[];
    dormant: StockArticle[];
  } = { outOfStock: [], lowStock: [], dormant: [] };

  // ── Pointage véhicules ────────────────────────────────────
  vehiclePointageData: { month: string; total: number; validated: number }[] = [];
  vehicleStatusData: { status: string; count: number }[] = [];
  validationRate = 0;
  pendingPointages: PendingPointage[] = [];
  vehiclePannes: VehiclePanne[] = [];
  maxPanneCount = 1;
  maxActiveEnginesCount: number = 0;
  activeEnginesTrend: string = 'stable';

  // ── Magasin principal ─────────────────────────────────────
  mainStore: MainStoreInfo = {
    name: '',
    code: '',
    itemCount: 0,
    totalQuantity: 0
  };
  totalStores: number = 0;

  // ── Alertes (corrigé - sans siteManagement, avec attendance) ──
  alertDomains = ALERT_DOMAINS;
  recentAlerts: Record<string, Alert[]> = {
    purchaseRequests: [], transfers: [],
    stock: [], vehicules: [], gasoil: [], attendance: []
  };

  // ── Donut ─────────────────────────────────────────────────
  donutColors = ['#3B82F6', '#10B981', '#EF4444', '#F59E0B', '#9CA3AF'];

  // ── Pointage employés ────────────────────────────────────
  currentAttendance: AttendanceHeader | null = null;
  attendanceStats = {
    totalEmployees: 0,
    totalPresent: 0,
    totalAbsent: 0,
    attendanceRate: 0
  };
  topEmployeesPresent: { no: string; name: string; presentDays: number }[] = [];
  maxPresentDays: number = 0;
  attendanceDays: number[] = [];
  attendanceError: string = '';
  totalUniqueArticlesAllStores: number = 0;
  totalAlertCount: number = 0;
  criticalAlertCount: number = 0;
  warningAlertCount: number = 0;

  constructor(
    private dashboardService: DashboardService,
    private stockService: StockService,
    private vehiculePointageService: VehiculePointageService,
    private alertsService: AlertsService,
    private attendanceService: AttendanceService,
    private offlineSync: OfflineSyncService,
    private cacheService: CacheService,
    private toastr: ToastrService,
    private router: Router,
    private cdr: ChangeDetectorRef,
    private ngZone: NgZone,
    private soundService: SoundService,
    private alertsCounterService: AlertsCounterService
  ) {}

  ngOnInit(): void {
    this.subscribeToAlertCounts();
    
    this.offlineSync.isOnline$
      .pipe(takeUntil(this.destroy$))
      .subscribe(async online => {
        this.isOnline = online;
        console.log('📡 Dashboard - Connectivité:', online ? 'En ligne' : 'Hors ligne');
        if (online) {
          this.loadDashboard(true);
        } else {
          await this.ensureOfflineData();
          this.loadDashboard();
        }
      });
    
    this.loadDashboard();
    this.startAutoRefresh();
    this.checkDarkModePreference();
  }

  ngAfterViewInit(): void {
    setTimeout(() => {
      if (!this.isLoading && !this.hasError) {
        this.initAllCharts();
      }
    }, 1000);
  }

  ngOnDestroy(): void {
    this.destroy$.next();
    this.destroy$.complete();
    if (this.loadingTimeout) clearTimeout(this.loadingTimeout);
    if (this.refreshInterval) clearInterval(this.refreshInterval);
    Object.values(this.charts).forEach(chart => {
      if (chart) chart.destroy();
    });
  }

  private subscribeToAlertCounts(): void {
    this.alertsCounterService.counts$
      .pipe(takeUntil(this.destroy$))
      .subscribe(counts => {
        console.log(' Compteurs d\'alertes:', counts);
        this.cdr.detectChanges();
      });
  }

  // ══════════════════════════════════════════════════════════
  // CHARGEMENT PRINCIPAL AVEC CACHE OFFLINE
  // ══════════════════════════════════════════════════════════

  async loadDashboard(forceRefresh: boolean = false): Promise<void> {
    if (this.loadingTimeout) clearTimeout(this.loadingTimeout);
    this.isLoading = true;
    this.hasError = false;
    this.cdr.detectChanges();

    this.chartsInitialized = false;
    Object.values(this.charts).forEach(chart => {
      if (chart) chart.destroy();
    });

    try {
      // 1. Charger depuis le cache (instantané)
      const [cachedStock, cachedDashboard, cachedVehicleEvolution, cachedAlerts] = await Promise.all([
        this.cacheService.getFromCache('stock-data'),
        this.cacheService.getFromCache('dashboard-data'),
        this.cacheService.getFromCache('vehicle-evolution-data'),
        this.cacheService.getFromCache('alerts-by-domain')
      ]);

      // Afficher les données du cache immédiatement
      if (cachedStock) this.applyStockData(cachedStock);
      if (cachedDashboard) this.applyDashboardData(cachedDashboard);
      if (cachedVehicleEvolution) {
        this.vehiclePointageData = cachedVehicleEvolution;
        this.cdr.detectChanges();
      }
      if (cachedAlerts) this.applyAlertsData(cachedAlerts);
      
      if (cachedStock) {
        this.loadMainStoreFromCache(cachedStock);
      }
      
      // Charger les engins actifs depuis le cache séparé
      const cachedEngines = await this.cacheService.getFromCache('vehicle-engines-data');
      if (cachedEngines) {
        this.kpi.activeEngines = cachedEngines;
        this.maxActiveEnginesCount = cachedEngines;
        console.log(` Engins actifs depuis le cache: ${this.kpi.activeEngines}`);
      }
      
      // Afficher l'UI immédiatement
      this.isLoading = false;
      this.cdr.detectChanges();
      
      setTimeout(() => this.initAllCharts(), 100);
      
      // 2. Charger les données fraîches en arrière-plan
      if (this.isOnline) {
        await this.loadFreshDataInBackground(forceRefresh);
      } else {
        console.log(' Mode hors ligne - Utilisation du cache uniquement');
        await this.checkAndShowAlertsNotification();
      }
      
    } catch (error) {
      console.error(' Erreur chargement dashboard:', error);
      this.isLoading = false;
      this.hasError = true;
      this.cdr.detectChanges();
    }

    this.loadingTimeout = setTimeout(() => {
      if (this.isLoading) {
        this.isLoading = false;
        this.cdr.detectChanges();
      }
    }, 15000);
  }

  //  Nouvelle méthode: Charger le magasin principal depuis le cache
  private loadMainStoreFromCache(cachedStock: any): void {
    if (!cachedStock || !cachedStock.stockStats) return;
    
    const storeList = cachedStock.stockByLocation || [];
    if (storeList.length > 0) {
      this.mainStore = {
        name: storeList[0]?.location || 'Magasin Principal',
        code: 'MAIN',
        itemCount: cachedStock.stockStats.totalItems || 0,
        totalQuantity: cachedStock.stockStats.totalQuantity || 0
      };
      this.totalStores = storeList.length;
      this.totalUniqueArticlesAllStores = cachedStock.stockStats.totalUniqueItems || 
                                          cachedStock.stockStats.totalItems || 2422;
      console.log(` Cache: ${this.totalUniqueArticlesAllStores} articles uniques (${cachedStock.stockStats.totalItems} lignes)`);
    }
  }

  // ══════════════════════════════════════════════════════════
  // DONNÉES VÉHICULES (UNIFIÉE)
  // ══════════════════════════════════════════════════════════

  // dashboard-home.ts - Version corrigée avec gestion des dates undefined

private async loadAllVehicleData(forceRefresh: boolean = false): Promise<void> {
  const evolutionCacheKey = 'vehicle-evolution-data';
  const statusCacheKey = 'vehicle-status-data';
  const enginesCacheKey = 'vehicle-engines-data';
  
  try {
    if (forceRefresh) {
      console.log(' Force refresh véhicules - Ignorant le cache');
      await this.cacheService.invalidateCache(evolutionCacheKey);
      await this.cacheService.invalidateCache(statusCacheKey);
      await this.cacheService.invalidateCache(enginesCacheKey);
    }
    
    let evolutionData = !forceRefresh ? await this.cacheService.getFromCache(evolutionCacheKey) : null;
    let statusData = !forceRefresh ? await this.cacheService.getFromCache(statusCacheKey) : null;
    let enginesData = !forceRefresh ? await this.cacheService.getFromCache(enginesCacheKey) : null;
    
    if (evolutionData && statusData && enginesData && !forceRefresh) {
      console.log(' Toutes les données véhicules depuis le cache');
      this.vehiclePointageData = evolutionData;
      this.vehicleStatusData = statusData;
      this.kpi.activeEngines = enginesData;
      this.maxActiveEnginesCount = enginesData;
      this.cdr.detectChanges();
      setTimeout(() => {
        this.createVehiclePointageChart();
        this.createVehicleStatusChart();
      }, 100);
      return;
    }
    
    console.log(' Chargement des pointages depuis l\'API...');
    
    // 1. Évolution mensuelle (headers)
    const headers = await firstValueFrom(
      this.vehiculePointageService.getAllPointages(false).pipe(timeout(15000))
    );
    
    const newEvolutionData = this.calculateMonthlyEvolution(headers);
    this.vehiclePointageData = newEvolutionData;
    await this.cacheService.saveToCache(evolutionCacheKey, newEvolutionData);
    
    // 2. Charger TOUS les pointages pour déterminer le dernier statut de chaque véhicule
    console.log(' Chargement des DÉTAILS de TOUS les pointages...');
    const allPointages = await firstValueFrom(
      this.vehiculePointageService.getAllPointages(true).pipe(timeout(60000))
    );
    
    if (allPointages.length > 0) {
      console.log(` Analyse de ${allPointages.length} pointages...`);
      
      // Map pour stocker le dernier statut de chaque véhicule
      const vehicleLastStatus = new Map<string, { status: string; date: Date }>();
      
      for (const pointage of allPointages) {
        if (pointage.id) {
          try {
            const detail = await firstValueFrom(
              this.vehiculePointageService.getHeaderById(pointage.id).pipe(timeout(15000))
            );
            
            //  Gérer le cas où pointage.date est undefined
            let pointageDate: Date;
            if (pointage.date) {
              pointageDate = new Date(pointage.date);
            } else {
              pointageDate = new Date(0); // Date par défaut (01/01/1970)
            }
            
            const lines = detail.vehiculePointageLines || [];
            
            lines.forEach((line: any) => {
              const vehiculeNo = line.vehiculeNo || line.vehicleNo;
              const status = line.status || 'Non défini';
              
              if (vehiculeNo && vehiculeNo.trim() !== '') {
                const existing = vehicleLastStatus.get(vehiculeNo);
                // Garder le statut le plus récent (date la plus récente)
                if (!existing || pointageDate > existing.date) {
                  vehicleLastStatus.set(vehiculeNo, { status, date: pointageDate });
                }
              }
            });
          } catch (e) {
            console.warn(` Erreur chargement ${pointage.documentNo}:`, e);
          }
        }
      }
      
      // Construire les statistiques avec le DERNIER statut de chaque véhicule
      const statusCount = new Map<string, number>();
      vehicleLastStatus.forEach(({ status }) => {
        statusCount.set(status, (statusCount.get(status) || 0) + 1);
      });
      
      const newStatusData = Array.from(statusCount.entries())
        .map(([status, count]) => ({ status, count }))
        .sort((a, b) => b.count - a.count);
      
      console.log(' Statuts véhicules (dernier statut connu):', newStatusData);
      
      // Calculer les engins actifs (Fonctionnel + Disponible) sur la situation ACTUELLE
      const functionalCount = newStatusData.find(s => s.status === 'Fonctionnel')?.count || 0;
      const availableCount = newStatusData.find(s => s.status === 'Disponible')?.count || 0;
      const newEnginesData = functionalCount + availableCount;
      
      this.vehicleStatusData = newStatusData;
      this.kpi.activeEngines = newEnginesData;
      this.maxActiveEnginesCount = newEnginesData;
      
      // Sauvegarder en cache
      await this.cacheService.saveToCache(statusCacheKey, newStatusData);
      await this.cacheService.saveToCache(enginesCacheKey, newEnginesData);
      console.log(` Statuts véhicules (situation actuelle) et engins actifs mis en cache (${newEnginesData} engins actifs)`);
      
      setTimeout(() => {
        this.createVehiclePointageChart();
        this.createVehicleStatusChart();
      }, 100);
    }
    
  } catch (error) {
    console.error(' Erreur chargement données véhicules:', error);
    const cachedEvolution = await this.cacheService.getFromCache(evolutionCacheKey);
    const cachedStatus = await this.cacheService.getFromCache(statusCacheKey);
    const cachedEngines = await this.cacheService.getFromCache(enginesCacheKey);
    if (cachedEvolution) this.vehiclePointageData = cachedEvolution;
    if (cachedStatus) this.vehicleStatusData = cachedStatus;
    if (cachedEngines) {
      this.kpi.activeEngines = cachedEngines;
      this.maxActiveEnginesCount = cachedEngines;
    }
    this.cdr.detectChanges();
  }
}

  private calculateMonthlyEvolution(pointages: any[]): { month: string; total: number; validated: number }[] {
    const monthlyMap = new Map<string, { total: number; validated: number }>();
    
    pointages.forEach(p => {
      if (p.date) {
        const d = new Date(p.date);
        const key = d.toLocaleString('fr-FR', { month: 'short' }) + ' ' + d.getFullYear();
        if (!monthlyMap.has(key)) {
          monthlyMap.set(key, { total: 0, validated: 0 });
        }
        const s = monthlyMap.get(key)!;
        s.total++;
        if (p.status === 'Validé') s.validated++;
      }
    });
    
    const last6Months = this.getLast6Months();
    
    return last6Months.map(month => {
      const data = monthlyMap.get(month);
      return { month: month, total: data?.total || 0, validated: data?.validated || 0 };
    });
  }

  private getLast6Months(): string[] {
    const months: string[] = [];
    const currentDate = new Date();
    
    for (let i = 5; i >= 0; i--) {
      const date = new Date(currentDate.getFullYear(), currentDate.getMonth() - i, 1);
      const monthName = date.toLocaleString('fr-FR', { month: 'short' });
      const year = date.getFullYear();
      months.push(`${monthName} ${year}`);
    }
    return months;
  }

  // ══════════════════════════════════════════════════════════
  // CHARGEMENT EN ARRIÈRE-PLAN
  // ══════════════════════════════════════════════════════════

  private async loadFreshDataInBackground(forceRefresh: boolean): Promise<void> {
    if (!this.isOnline) {
      console.log(' Mode hors ligne - Pas de chargement frais');
      return;
    }
    
    console.log(' Chargement des données fraîches en arrière-plan...');
    
    try {
      await Promise.all([
        this.loadDashboardDataWithCache(forceRefresh),
        this.loadStockDataWithCache(forceRefresh),
        this.loadAttendanceDataWithCache(forceRefresh),
        this.loadMainStoreData(forceRefresh),
        this.loadAlertsByDomain(forceRefresh),
        this.loadAllVehicleData(forceRefresh)
      ]);
      
      this.lastUpdate = new Date();
      this.cdr.detectChanges();
      console.log(' Toutes les données sont à jour en arrière-plan');
      
      await this.checkAndShowAlertsNotification();
      
      setTimeout(() => {
        this.initAllCharts();
      }, 100);
      
    } catch (error) {
      console.warn(' Erreur chargement en arrière-plan:', error);
      await this.checkAndShowAlertsNotification();
    }
  }

  private async loadDashboardDataWithCache(forceRefresh: boolean = false): Promise<void> {
    const cacheKey = 'dashboard-data';
    
    try {
      const cachedData = await this.cacheService.getFromCache(cacheKey);
      
      if (cachedData && !forceRefresh && !this.isOnline) {
        console.log(' Dashboard: Utilisation du cache offline');
        this.applyDashboardData(cachedData);
        return;
      }
      
      if (this.isOnline || forceRefresh) {
        console.log(' Chargement des données dashboard depuis l\'API...');
        const data = await firstValueFrom(this.dashboardService.getDashboardData().pipe(timeout(30000)));
        this.applyDashboardData(data);
        await this.cacheService.saveToCache(cacheKey, data);
        console.log(' Dashboard: Données mises en cache');
      } else if (cachedData) {
        console.log(' Dashboard: Utilisation du cache (expiré)');
        this.applyDashboardData(cachedData);
      } else {
        console.warn(' Dashboard: Aucune donnée disponible offline');
      }
    } catch (error) {
      console.error(' Erreur chargement dashboard data:', error);
      const cachedData = await this.cacheService.getFromCache(cacheKey);
      if (cachedData) {
        console.log(' Dashboard: Fallback vers cache après erreur');
        this.applyDashboardData(cachedData);
      }
    }
  }

  private applyDashboardData(data: any): void {
    if (data) {
      this.kpi = { ...data.kpi, tasksBlocked: data.kpi.tasksBlocked ?? 0 };
      this.projectsProgress = data.projectsProgress ?? [];
      this.tasksByStatus = data.tasksByStatus ?? [];
      this.tasksDetail = data.tasksDetail ?? [];
      this.hasError = false;
      this.cdr.detectChanges();
    }
  }

  // ══════════════════════════════════════════════════════════
  // MAGASIN PRINCIPAL
  // ══════════════════════════════════════════════════════════

  private async loadMainStoreData(forceRefresh: boolean = false): Promise<void> {
    if (!forceRefresh && this.mainStore.itemCount > 0) {
      console.log(' Utilisation des données existantes pour le magasin');
      return;
    }
    
    try {
      console.log(' Chargement magasin principal en arrière-plan...');
      
      const stock = await firstValueFrom(this.stockService.getAllStock(true).pipe(timeout(45000)));
      const totalArticlesDistincts = stock.length;
      
      console.log(` API retourne: ${totalArticlesDistincts} articles distincts`);
      
      const storeMap = new Map<string, { 
        code: string;
        name: string;
        distinctItems: Set<string>;
        totalQuantity: number;
      }>();
      
      stock.forEach(item => {
        const locationCode = item.locationCode || 'Magasin Principal';
        const locationName = (item as any).locationName || locationCode;
        const itemNo = item.itemNo;
        const quantity = item.quantity || 0;
        
        if (!storeMap.has(locationCode)) {
          storeMap.set(locationCode, {
            code: locationCode,
            name: locationName,
            distinctItems: new Set<string>(),
            totalQuantity: 0
          });
        }
        
        const store = storeMap.get(locationCode)!;
        store.distinctItems.add(itemNo);
        store.totalQuantity += quantity;
      });
      
      const storeList: { code: string; name: string; distinctCount: number; quantity: number }[] = [];
      storeMap.forEach((value, key) => {
        storeList.push({
          code: key,
          name: value.name,
          distinctCount: value.distinctItems.size,
          quantity: value.totalQuantity
        });
      });
      
      storeList.sort((a, b) => b.distinctCount - a.distinctCount);
      const mainStore = storeList[0];
      
      this.mainStore = {
        name: mainStore.name,
        code: mainStore.code,
        itemCount: mainStore.distinctCount,
        totalQuantity: mainStore.quantity
      };
      this.totalStores = storeList.length;
      this.totalUniqueArticlesAllStores = totalArticlesDistincts;
      
      console.log(` Magasin principal: ${this.mainStore.itemCount} articles`);
      console.log(` Total ARTICLES UNIQUES (API): ${this.totalUniqueArticlesAllStores}`);
      console.log(` Total magasins: ${this.totalStores}`);
      
      this.cdr.detectChanges();
      
    } catch (error) {
      console.error(' Erreur chargement magasin:', error);
      if (this.mainStore.itemCount === 0) {
        this.mainStore = {
          name: 'Magasin Principal',
          code: 'MAIN',
          itemCount: 0,
          totalQuantity: 0
        };
        this.totalStores = 1;
      }
    }
  }

  // ══════════════════════════════════════════════════════════
  // STOCK
  // ══════════════════════════════════════════════════════════

  private async loadStockDataWithCache(forceRefresh: boolean = false): Promise<void> {
    const cacheKey = 'stock-data';
    
    try {
      if (forceRefresh) {
        console.log(' Stock: Force refresh - Appel API (30s timeout)');
        const stock = await firstValueFrom(this.stockService.getAllStock(true).pipe(timeout(30000)));
        const processedData = this.processStockData(stock);
        this.applyStockData(processedData);
        await this.cacheService.saveToCache(cacheKey, processedData);
        return;
      }
      
      if (this.isOnline) {
        console.log(' Stock: Chargement asynchrone en arrière-plan...');
        this.stockService.getAllStock(true).pipe(timeout(30000)).subscribe({
          next: (stock) => {
            const processedData = this.processStockData(stock);
            this.applyStockData(processedData);
            this.cacheService.saveToCache(cacheKey, processedData);
            console.log(' Stock mis à jour en arrière-plan');
            this.cdr.detectChanges();
          },
          error: (err) => {
            console.warn(' Échec mise à jour stock:', err);
          }
        });
      }
      
      const cachedData = await this.cacheService.getFromCache(cacheKey);
      if (cachedData) {
        this.applyStockData(cachedData);
        console.log(' Stock: Utilisation du cache (mise à jour en arrière-plan)');
      }
      
    } catch (error) {
      console.error(' Erreur chargement stock:', error);
      const cachedData = await this.cacheService.getFromCache(cacheKey);
      if (cachedData) this.applyStockData(cachedData);
    }
  }

  private processStockData(stock: any[]): any {
    const items = stock || [];
    const totalQuantity = items.reduce((s, i) => s + (i.quantity || 0), 0);
    const lowStockCount = items.filter(i => i.quantity > 0 && i.quantity <= 10).length;
    const outOfStockCount = items.filter(i => i.quantity <= 0).length;
    const totalUniqueItems = items.length;
    
    console.log(` Stock: ${items.length} lignes, ${totalUniqueItems} articles uniques (valeur API)`);
    
    const locMap = new Map<string, number>();
    items.forEach(i => {
      const loc = i.locationCode || 'Sans magasin';
      locMap.set(loc, (locMap.get(loc) || 0) + (i.quantity || 0));
    });
    
    return {
      stockStats: {
        totalItems: items.length,
        totalUniqueItems: totalUniqueItems,
        totalQuantity,
        lowStockCount,
        outOfStockCount
      },
      stockByLocation: Array.from(locMap.entries()).map(([location, quantity]) => ({ location, quantity })).sort((a, b) => b.quantity - a.quantity).slice(0, 8),
      stockCritical: {
        outOfStock: items.filter(i => i.quantity <= 0).slice(0, 20).map(i => ({
          code: i.itemNo,
          description: (i.itemDescription || '').substring(0, 50),
          location: i.locationCode || '—',
          quantity: i.quantity,
          lastPostingDate: i.lastPostingDate || null
        })),
        lowStock: items.filter(i => i.quantity > 0 && i.quantity <= 10).sort((a, b) => a.quantity - b.quantity).slice(0, 20).map(i => ({
          code: i.itemNo,
          description: (i.itemDescription || '').substring(0, 50),
          location: i.locationCode || '—',
          quantity: i.quantity,
          lastPostingDate: i.lastPostingDate || null
        })),
        dormant: []
      },
      kpiCriticalStockCount: lowStockCount + outOfStockCount
    };
  }

  private applyStockData(data: any): void {
    if (data) {
      this.stockStats = data.stockStats || { 
        totalItems: 0, 
        totalUniqueItems: 0,
        totalQuantity: 0, 
        lowStockCount: 0, 
        outOfStockCount: 0 
      };
      this.stockByLocation = data.stockByLocation || [];
      this.stockCritical = data.stockCritical || { outOfStock: [], lowStock: [], dormant: [] };
      this.kpi.criticalStockCount = data.kpiCriticalStockCount || 0;
      
      if (data.stockStats?.totalUniqueItems) {
        this.totalUniqueArticlesAllStores = data.stockStats.totalUniqueItems;
      } else if (data.stockStats?.totalItems) {
        this.totalUniqueArticlesAllStores = data.stockStats.totalItems;
      }
      
      console.log(` Mise à jour: ${this.totalUniqueArticlesAllStores} articles uniques (valeur API)`);
      
      setTimeout(() => {
        this.createStockEvolutionChart();
        this.createStockDistributionChart();
        this.cdr.detectChanges();
      }, 100);
    }
  }

  // ══════════════════════════════════════════════════════════
  // POINTAGE EMPLOYÉS
  // ══════════════════════════════════════════════════════════

  private async loadAttendanceDataWithCache(forceRefresh: boolean = false): Promise<void> {
    const now = new Date();
    const currentYear = now.getFullYear();
    const currentMonth = now.getMonth();
    const monthNames = ['Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin',
                        'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'];
    const monthName = monthNames[currentMonth];
    const cacheKey = `attendance-${monthName}-${currentYear}`;
    
    try {
      const cachedData = await this.cacheService.getFromCache(cacheKey);
      
      if (cachedData && !forceRefresh && !this.isOnline) {
        console.log(' Pointage employés: Utilisation du cache offline');
        this.applyAttendanceData(cachedData);
        return;
      }
      
      if (this.isOnline || forceRefresh) {
        const headers = await firstValueFrom(this.attendanceService.getAllHeaders().pipe(timeout(10000)));
        const currentAttendanceHeader = headers.find(h => h.month === monthName && h.year === currentYear);
        
        if (currentAttendanceHeader?.id) {
          const fullAttendance = await firstValueFrom(this.attendanceService.getFullAttendance(currentAttendanceHeader.id).pipe(timeout(10000)));
          const processedData = this.processAttendanceData(fullAttendance);
          this.applyAttendanceData(processedData);
          await this.cacheService.saveToCache(cacheKey, processedData);
        } else {
          this.currentAttendance = null;
          this.attendanceStats = { totalEmployees: 0, totalPresent: 0, totalAbsent: 0, attendanceRate: 0 };
          this.topEmployeesPresent = [];
        }
      } else if (cachedData) {
        this.applyAttendanceData(cachedData);
      }
    } catch (error) {
      console.error(' Erreur chargement pointage employés:', error);
      const cachedData = await this.cacheService.getFromCache(cacheKey);
      if (cachedData) {
        this.applyAttendanceData(cachedData);
      } else {
        this.currentAttendance = null;
        this.attendanceStats = { totalEmployees: 0, totalPresent: 0, totalAbsent: 0, attendanceRate: 0 };
        this.topEmployeesPresent = [];
      }
    }
  }

  private processAttendanceData(data: any): any {
    const lines = data.employeeAttendanceLines || data.lines || [];
    
    const totalEmployees = lines.length;
    let totalPresent = 0;
    let totalAbsent = 0;
    const employeePresentDays: { no: string; name: string; presentDays: number }[] = [];
    
    lines.forEach((line: any) => {
      const presentCount = line.totalPresentDays ?? 0;
      const absentCount = line.totalAbsentDays ?? 0;
      totalPresent += presentCount;
      totalAbsent += absentCount;
      employeePresentDays.push({ 
        no: line.employeeNo, 
        name: line.employeeName, 
        presentDays: presentCount 
      });
    });
    
    employeePresentDays.sort((a, b) => b.presentDays - a.presentDays);
    const maxPresentDays = employeePresentDays[0]?.presentDays || 1;
    const attendanceRate = totalPresent + totalAbsent > 0 
      ? Math.round((totalPresent / (totalPresent + totalAbsent)) * 100) 
      : 0;
    
    return {
      currentAttendance: {
        ...data,
        lines: lines
      },
      attendanceStats: { 
        totalEmployees, 
        totalPresent, 
        totalAbsent, 
        attendanceRate 
      },
      topEmployeesPresent: employeePresentDays.slice(0, 5),
      maxPresentDays: maxPresentDays
    };
  }

  private applyAttendanceData(data: any): void {
    if (data) {
      this.currentAttendance = data.currentAttendance;
      this.attendanceStats = data.attendanceStats || { 
        totalEmployees: 0, 
        totalPresent: 0, 
        totalAbsent: 0, 
        attendanceRate: 0 
      };
      this.topEmployeesPresent = data.topEmployeesPresent || [];
      this.maxPresentDays = data.maxPresentDays || 1;
      if (this.currentAttendance) {
        this.initAttendanceDays();
      }
    }
  }

  // ══════════════════════════════════════════════════════════
  // ALERTES
  // ══════════════════════════════════════════════════════════

  private async loadAlertsByDomain(forceRefresh: boolean = false): Promise<void> {
    const cacheKey = 'alerts-by-domain';
    
    try {
      if (forceRefresh) {
        await this.cacheService.invalidateCache(cacheKey);
      }
      
      const cachedData = await this.cacheService.getFromCache(cacheKey);
      
      if (cachedData && !forceRefresh && !this.isOnline) {
        console.log(' Alertes: Utilisation du cache offline');
        this.applyAlertsData(cachedData);
        return;
      }
      
      if (this.isOnline || forceRefresh) {
        console.log(' Chargement des alertes depuis l\'API...');
        const alerts = await firstValueFrom(
          this.alertsService.getAllAlertsByDomain(50).pipe(timeout(30000))
        );
        
        this.applyAlertsData(alerts);
        await this.cacheService.saveToCache(cacheKey, alerts);
        console.log(' Alertes mises en cache');
        
      } else if (cachedData) {
        console.log(' Alertes: Utilisation du cache (fallback)');
        this.applyAlertsData(cachedData);
      }
    } catch (error) {
      console.error(' Erreur chargement alertes:', error);
      const cachedData = await this.cacheService.getFromCache(cacheKey);
      if (cachedData) {
        this.applyAlertsData(cachedData);
      }
    }
  }

  private applyAlertsData(alerts: any): void {
    this.recentAlerts = {
      purchaseRequests: this.getLatestAlerts(alerts.purchaseRequests || [], 5),
      transfers: this.getLatestAlerts(alerts.transfers || [], 5),
      stock: this.getLatestAlerts(alerts.stock || [], 5),
      vehicules: this.getLatestAlerts(alerts.vehicules || [], 5),
      gasoil: this.getLatestAlerts(alerts.gasoil || [], 5),
      attendance: this.getLatestAlerts(alerts.attendance || [], 5),
    };
    
    let totalAll = 0;
    let criticalAll = 0;
    let warningAll = 0;
    
    const domains = ['purchaseRequests', 'transfers', 'stock', 'vehicules', 'gasoil', 'attendance'];
    for (const domain of domains) {
      const domainAlerts = alerts[domain] || [];
      totalAll += domainAlerts.length;
      criticalAll += domainAlerts.filter((a: Alert) => a.severity === 'Critical').length;
      warningAll += domainAlerts.filter((a: Alert) => a.severity === 'Warning').length;
    }
    
    this.totalAlertCount = totalAll;
    this.criticalAlertCount = criticalAll;
    this.warningAlertCount = warningAll;
    
    console.log(` Alertes totales KPI: ${this.totalAlertCount} (${this.criticalAlertCount} critiques, ${this.warningAlertCount} warnings)`);
    
    this.extractOverdueTasksFromAlerts(alerts);
    this.cdr.detectChanges();
  }

  private extractOverdueTasksFromAlerts(alerts: any): void {
    const allAlerts: Alert[] = [
      ...(alerts.purchaseRequests || []),
      ...(alerts.transfers || []),
      ...(alerts.stock || []),
      ...(alerts.vehicules || []),
      ...(alerts.gasoil || []),
      ...(alerts.attendance || [])
    ];
    
    const overdueTaskAlerts = allAlerts.filter(alert => {
      const title = alert.title?.toLowerCase() || '';
      const type = alert.type?.toLowerCase() || '';
      return title.includes('retard') || title.includes('tâche') || title.includes('task') ||
             type.includes('retard') || type.includes('tâche');
    });
    
    this.overdueTasks = overdueTaskAlerts.map(alert => ({
      jobNo: this.extractTaskNumber(alert.title),
      taskNo: alert.relatedEntityNo || alert.id,
      description: alert.title,
      dateFin: alert.detectedAt ? new Date(alert.detectedAt).toISOString() : '',
      progressPct: 0
    }));
  }

  private extractTaskNumber(title: string): string {
    let cleaned = title.replace(/^Retard[\s\-—]+/i, '');
    if (cleaned.toLowerCase().startsWith('tâche') || cleaned.toLowerCase().startsWith('tache')) {
      return cleaned;
    }
    return cleaned.length > 40 ? cleaned.substring(0, 40) + '...' : cleaned;
  }

  private getLatestAlerts(alerts: Alert[], limit: number): Alert[] {
    if (!alerts?.length) return [];
    return [...alerts]
      .sort((a, b) => new Date(b.detectedAt).getTime() - new Date(a.detectedAt).getTime())
      .slice(0, limit);
  }

  private getTotalDisplayAlerts(): number {
    let total = 0;
    for (const domain of ['purchaseRequests', 'transfers', 'stock', 'vehicules', 'gasoil', 'attendance']) {
      total += this.recentAlerts[domain].length;
    }
    return total;
  }

  // ══════════════════════════════════════════════════════════
  // NAVIGATION
  // ══════════════════════════════════════════════════════════

  navigateToCreateAttendance(): void {
    console.log(' Navigation vers création pointage employés');
    this.router.navigate(['/attendance/new']).then(success => {
      if (success) {
        console.log(' Navigation réussie');
      } else {
        console.error(' Échec navigation');
        this.toastr.error('Impossible d\'accéder à la page de création', 'Erreur');
      }
    }).catch(error => {
      console.error(' Erreur navigation:', error);
      this.toastr.error('Erreur lors de la navigation', 'Erreur');
    });
  }

  navigateToDomainAlerts(domain: string): void {
    this.router.navigate(['/alerts'], { queryParams: { filterDomain: domain } });
  }

  onAlertClick(alert: Alert): void {
    this.alertsService.markAsRead(alert.id);
    this.navigateToAlert(alert);
  }

  navigateToAlert(alert: Alert): void {
    const routes: Record<string, string> = {
      'PurchaseRequestRejected': '/purchases/requests',
      'PurchaseRequestPendingTooLong': '/purchases/requests',
      'PurchaseRequestEmpty': '/purchases/requests',
      'TransferStuckInTransit': '/transfers',
      'TransferNotShipped': '/transfers',
      'TransferPartialReceipt': '/transfers',
      'TransferNoVehicle': '/transfers',
      'StockNegatif': '/inventory',
      'StockCritique': '/inventory',
      'StockDormant': '/inventory',
      'PointageNonValide': '/equipment',
      'VehiculeSurutilise': '/equipment',
      'IndexIncoherent': '/equipment',
      'ConsommationAnormale': '/equipment',
      'GasoilFicheNonValidee': '/gasoil',
      'GasoilConsommationTotaleAnormale': '/gasoil',
      'GasoilLigneSansVehicule': '/gasoil',
      'GasoilQuantiteLigneAnormale': '/gasoil',
      'AttendanceFicheSansLignes': '/attendance',
      'AttendanceSalarieNonPointe': '/attendance'
    };
    
    const route = routes[alert.type] || '/dashboard';
    this.router.navigate([route], { queryParams: { highlight: alert.relatedEntityNo } });
  }

  // ══════════════════════════════════════════════════════════
  // POINTAGE EMPLOYÉS - HELPERS
  // ══════════════════════════════════════════════════════════

  private initAttendanceDays(): void {
    if (!this.currentAttendance) return;
    
    const monthMap: Record<string, number> = {
      'Janvier': 31, 'Février': 28, 'Mars': 31, 'Avril': 30,
      'Mai': 31, 'Juin': 30, 'Juillet': 31, 'Août': 31,
      'Septembre': 30, 'Octobre': 31, 'Novembre': 30, 'Décembre': 31
    };
    
    let days = monthMap[this.currentAttendance.month] || 30;
    if (this.currentAttendance.month === 'Février' && this.isLeapYear(this.currentAttendance.year)) {
      days = 29;
    }
    
    this.attendanceDays = Array.from({ length: days }, (_, i) => i + 1);
  }

  private isLeapYear(year: number): boolean {
    return (year % 4 === 0 && year % 100 !== 0) || (year % 400 === 0);
  }

  isAttendanceWeekend(day: number): boolean {
    if (!this.currentAttendance) return false;
    const monthIndex = this.getMonthIndex(this.currentAttendance.month);
    const date = new Date(this.currentAttendance.year, monthIndex, day);
    const dayOfWeek = date.getDay();
    return dayOfWeek === 0 || dayOfWeek === 6;
  }

  private getMonthIndex(monthName: string): number {
    const months = [
      'Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin',
      'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'
    ];
    return months.indexOf(monthName);
  }

  getDayAttendanceValue(line: AttendanceLine, day: number): string {
    const key = `day${day}` as keyof AttendanceLine;
    return (line[key] as string) || '';
  }

  getPresenceStatusClass(code: string): string {
    const statusMap: Record<string, string> = {
      'P': 'present', 'AU': 'present', 'P-R': 'present',
      'C': 'leave', 'C1/2': 'leave', 'CEXP': 'leave',
      'F': 'holiday',
      'A': 'absent',
      'M': 'mission',
      'FO': 'training'
    };
    return statusMap[code] || 'empty';
  }

  getPresenceTooltip(line: AttendanceLine, day: number): string {
    const code = this.getDayAttendanceValue(line, day);
    const statusMap: Record<string, string> = {
      'P': 'Présent', 'AU': 'Présent (Autorisation)', 'P-R': 'Présent (Récupération)',
      'C': 'Congé', 'C1/2': 'Demi-journée congé', 'CEXP': 'Congé exceptionnel',
      'F': 'Jour férié',
      'A': 'Absent',
      'M': 'Mission',
      'FO': 'Formation'
    };
    if (!this.currentAttendance) return '';
    const date = new Date(this.currentAttendance.year, this.getMonthIndex(this.currentAttendance.month), day);
    const dateStr = date.toLocaleDateString('fr-FR', { day: 'numeric', month: 'long' });
    return `${dateStr} : ${statusMap[code] || 'Non renseigné'}`;
  }

  getTotalPresentClass(total: number): string {
    if (total >= 20) return 'excellent';
    if (total >= 15) return 'good';
    if (total >= 10) return 'average';
    return 'low';
  }

  getRankClass(index: number): string {
    if (index === 0) return 'gold';
    if (index === 1) return 'silver';
    if (index === 2) return 'bronze';
    return '';
  }

  // ══════════════════════════════════════════════════════════
  // GRAPHIQUES
  // ══════════════════════════════════════════════════════════

  private initAllCharts(): void {
    if (this.chartsInitialized) return;
    
    if (this.vehiclePointageData.length > 0) {
      this.createVehiclePointageChart();
    }
    
    if (this.vehicleStatusData.length > 0) {
      this.createVehicleStatusChart();
    }
    
    if (this.stockByLocation.length > 0) {
      this.createStockEvolutionChart();
    }
    
    this.createStockDistributionChart();
    this.chartsInitialized = true;
  }

  private createVehiclePointageChart(): void {
    if (!this.vehiclePointageChart?.nativeElement || this.vehiclePointageData.length === 0) return;
    
    const ctx = this.vehiclePointageChart.nativeElement.getContext('2d');
    if (!ctx) return;
    
    if (this.charts['vehiclePointage']) {
      this.charts['vehiclePointage']?.destroy();
    }
    
    this.charts['vehiclePointage'] = new Chart(ctx, {
      type: 'line',
      data: {
        labels: this.vehiclePointageData.map(d => d.month),
        datasets: [
          {
            label: 'Total pointages',
            data: this.vehiclePointageData.map(d => d.total),
            borderColor: '#6366F1',
            backgroundColor: 'rgba(99,102,241,0.1)',
            borderWidth: 0,
            tension: 0,
            fill: false,
            pointBackgroundColor: '#6366F1',
            pointBorderColor: '#fff',
            pointRadius: 6,
            pointHoverRadius: 8,
            pointBorderWidth: 2,
            showLine: false,
            order: 1
          },
          {
            label: 'Validés',
            data: this.vehiclePointageData.map(d => d.validated),
            borderColor: '#10B981',
            backgroundColor: 'rgba(16,185,129,0.1)',
            borderWidth: 0,
            tension: 0,
            fill: false,
            pointBackgroundColor: '#10B981',
            pointBorderColor: '#fff',
            pointRadius: 6,
            pointHoverRadius: 8,
            pointBorderWidth: 2,
            showLine: false,
            order: 2
          }
        ]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: { legend: { position: 'bottom' }, tooltip: { callbacks: { label: (context) => `${context.dataset.label}: ${context.raw}` } } },
        scales: {
          y: { beginAtZero: true, title: { display: true, text: 'Nombre de pointages' }, grid: { color: 'rgba(0,0,0,0.05)' }, ticks: { stepSize: 1 } },
          x: { grid: { display: false }, title: { display: true, text: 'Mois' } }
        }
      }
    });
  }

  private createVehicleStatusChart(): void {
    if (!this.vehicleStatusChart?.nativeElement || this.vehicleStatusData.length === 0) return;
    
    const ctx = this.vehicleStatusChart.nativeElement.getContext('2d');
    if (!ctx) return;
    
    if (this.charts['vehicleStatus']) {
      this.charts['vehicleStatus']?.destroy();
    }
    
    const colors: Record<string, string> = {
      'Fonctionnel': '#10B981', 'Panne': '#EF4444',
      'Disponible': '#3B82F6', 'Réformé': '#6B7280',
      'Accident': '#F59E0B', 'Mauvais Temps': '#8B5CF6',
      'Non défini': '#9CA3AF'
    };
    
    this.charts['vehicleStatus'] = new Chart(ctx, {
      type: 'bar',
      data: {
        labels: this.vehicleStatusData.map(s => s.status),
        datasets: [{
          label: 'Nombre de lignes pointage',
          data: this.vehicleStatusData.map(s => s.count),
          backgroundColor: this.vehicleStatusData.map(s => colors[s.status] || '#9CA3AF'),
          borderRadius: 8
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: { legend: { display: false } },
        scales: {
          y: { beginAtZero: true, title: { display: true, text: 'Lignes' }, grid: { color: 'rgba(0,0,0,0.05)' } },
          x: { grid: { display: false } }
        }
      }
    });
  }

  private createStockEvolutionChart(): void {
    if (!this.stockEvolutionChart?.nativeElement || this.stockByLocation.length === 0) return;
    
    const ctx = this.stockEvolutionChart.nativeElement.getContext('2d');
    if (!ctx) return;
    
    if (this.charts['stockEvolution']) {
      this.charts['stockEvolution']?.destroy();
    }
    
    this.charts['stockEvolution'] = new Chart(ctx, {
      type: 'bar',
      data: {
        labels: this.stockByLocation.map(s => s.location),
        datasets: [{
          label: 'Quantité',
          data: this.stockByLocation.map(s => s.quantity),
          backgroundColor: 'rgba(99,102,241,0.7)',
          borderColor: '#6366F1',
          borderWidth: 1,
          borderRadius: 8
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: { legend: { display: false }, tooltip: { callbacks: { label: (ctx) => `Quantité: ${ctx.raw}` } } },
        scales: {
          y: { beginAtZero: true, title: { display: true, text: 'Quantité' }, grid: { color: 'rgba(0,0,0,0.05)' } },
          x: { grid: { display: false } }
        }
      }
    });
  }

  private createStockDistributionChart(): void {
    if (!this.stockDistributionChart?.nativeElement) return;
    
    const ctx = this.stockDistributionChart.nativeElement.getContext('2d');
    if (!ctx) return;
    
    if (this.charts['stockDistribution']) {
      this.charts['stockDistribution']?.destroy();
    }
    
    const normal = this.stockStats.totalItems - this.stockStats.lowStockCount - this.stockStats.outOfStockCount;
    
    this.charts['stockDistribution'] = new Chart(ctx, {
      type: 'doughnut',
      data: {
        labels: ['Normal', 'Stock faible (≤10)', 'Rupture (≤0)'],
        datasets: [{
          data: [normal, this.stockStats.lowStockCount, this.stockStats.outOfStockCount],
          backgroundColor: ['#10B981', '#F59E0B', '#EF4444'],
          borderWidth: 0
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: { legend: { position: 'bottom' } }
      }
    });
  }

  // ══════════════════════════════════════════════════════════
  // HELPERS TEMPLATE
  // ══════════════════════════════════════════════════════════

  getTaskStatusClass(t: TaskDetail): string {
    if (t.isBlocked) return 'status-blocked';
    if (t.progressPct >= 100) return 'status-done';
    if (this.isOverdue(t)) return 'status-overdue';
    if (t.progressPct === 0) return 'status-notstarted';
    return 'status-inprogress';
  }

  getTaskStatusLabel(t: TaskDetail): string {
    if (t.isBlocked) return 'Bloquée';
    if (t.progressPct >= 100) return 'Terminée';
    if (this.isOverdue(t)) return 'En retard';
    if (t.progressPct === 0) return 'Non démarrée';
    return 'En cours';
  }

  taskProgressColor(t: TaskDetail): string {
    if (t.isBlocked) return '#6B7280';
    if (t.progressPct >= 100) return '#10B981';
    if (this.isOverdue(t)) return '#EF4444';
    if (t.progressPct === 0) return '#9CA3AF';
    return '#3B82F6';
  }

  isOverdue(t: TaskDetail): boolean {
    if (t.isBlocked) return false;
    if (t.progressPct >= 100) return false;
    if (!t.dateFin) return false;
    
    let dueDate: Date;
    try {
      if (typeof t.dateFin === 'string') {
        let dateStr = t.dateFin;
        if (dateStr.includes('-') && dateStr.length === 10) {
          const parts = dateStr.split('-');
          dueDate = new Date(parseInt(parts[0]), parseInt(parts[1]) - 1, parseInt(parts[2]));
        } else {
          dueDate = new Date(dateStr);
        }
      } else {
        dueDate = new Date(t.dateFin);
      }
      
      if (isNaN(dueDate.getTime())) return false;
      const today = new Date();
      today.setHours(0, 0, 0, 0);
      dueDate.setHours(0, 0, 0, 0);
      return dueDate < today;
    } catch {
      return false;
    }
  }

  get totalTasksForDonut(): number {
    return (this.tasksByStatus ?? []).reduce((s, t) => s + t.value, 0) || 1;
  }

  donutArc(index: number): string {
    const total = this.totalTasksForDonut;
    const value = (this.tasksByStatus[index].value / total) * 100;
    return `${value} ${100 - value}`;
  }

  donutOffset(index: number): number {
    const total = this.totalTasksForDonut;
    let offset = 25;
    for (let i = 0; i < index; i++) {
      offset -= (this.tasksByStatus[i].value / total) * 100;
    }
    return offset;
  }

  pct(value: number): string {
    return Math.min(100, Math.max(0, Math.round(value || 0))) + '%';
  }

  progressColor(p: number): string {
    if (p >= 75) return '#10B981';
    if (p >= 40) return '#3B82F6';
    if (p >= 20) return '#F59E0B';
    return '#EF4444';
  }

  statusColor(status: string): string {
    const m: Record<string, string> = {
      'En cours': 'badge-blue',
      'Terminé': 'badge-green',
      'Suspendu': 'badge-orange'
    };
    return m[status] || 'badge-gray';
  }

  formatDate(date: string | null): string {
    if (!date) return '—';
    try {
      const d = new Date(date);
      if (isNaN(d.getTime()) || d.getFullYear() < 2000) return '—';
      return d.toLocaleDateString('fr-FR');
    } catch { 
      return '_'; 
    }
  }

  daysOverdue(date: string | null): number {
    if (!date) return 0;
    try {
      const diff = new Date().getTime() - new Date(date).getTime();
      return Math.max(0, Math.floor(diff / 86400000));
    } catch {
      return 0;
    }
  }

  getAlertTypeIcon(type: string): string {
  if (type?.toLowerCase().includes('stock')) return 'inventory';
  if (type?.toLowerCase().includes('gasoil')) return 'local_gas_station';
  if (type?.toLowerCase().includes('purchase')) return 'shopping_cart';
  if (type?.toLowerCase().includes('transfer')) return 'swap_horiz';
  if (type?.toLowerCase().includes('task')) return 'assignment';
  if (type?.toLowerCase().includes('vehicule')) return 'directions_car';
  return 'notifications';
}

  getAlertSeverityClass(severity: string): string {
    return severity === 'Critical' ? 'alert-critical-card' : severity === 'Warning' ? 'alert-warning-card' : 'alert-info-card';
  }

  checkDarkModePreference(): void {
    const saved = localStorage.getItem('darkMode');
    this.isDarkMode = saved !== null ? saved === 'true' : window.matchMedia('(prefers-color-scheme: dark)').matches;
    this.applyDarkMode();
  }

  toggleDarkMode(): void {
    this.isDarkMode = !this.isDarkMode;
    localStorage.setItem('darkMode', String(this.isDarkMode));
    this.applyDarkMode();
  }

  applyDarkMode(): void {
    document.body.classList.toggle('dark-mode', this.isDarkMode);
  }

  startAutoRefresh(): void {
    this.refreshInterval = setInterval(() => {
      if (!this.isLoading && this.isOnline) {
        this.loadDashboard(true);
      }
    }, 300000);
  }

  async refresh(): Promise<void> {
    if (!this.isOnline) {
      this.toastr.warning('Impossible d\'actualiser en mode hors ligne', 'Mode offline');
      return;
    }
    
    console.log(' Rafraîchissement complet du dashboard...');
    this.toastr.info('Synchronisation des données...', 'Actualisation');
    
    this.notificationShownToday = false;
    this.notificationDisplayedForSession = false;
    
    await this.cacheService.invalidateCache('stock-all');
    await this.cacheService.invalidateCache('stock-data');
    await this.cacheService.invalidateCache('dashboard-data');
    await this.cacheService.invalidateCache('alerts-by-domain');
    await this.cacheService.invalidateCache('vehicle-evolution-data');
    await this.cacheService.invalidateCache('vehicle-status-data');
    await this.cacheService.invalidateCache('vehicle-engines-data');
    await this.cacheService.invalidateCache('vehicle-pointage-data');
    
    await this.loadDashboard(true);
    
    this.toastr.success('Dashboard synchronisé avec succès', 'Actualisation');
  }

  private async checkAndShowAlertsNotification(): Promise<void> {
    console.log(' Vérification des alertes...');
    
    if (this.isCheckingNotifications) {
      console.log(' Vérification déjà en cours');
      return;
    }
    
    const today = new Date().toDateString();
    if (localStorage.getItem('lastAlertNotification') === today && this.notificationShownToday) {
      console.log(' Notification déjà affichée aujourd\'hui');
      return;
    }

    this.isCheckingNotifications = true;
    
    try {
      await new Promise(resolve => setTimeout(resolve, 1000));
      
      const totalAll = this.totalAlertCount;
      const criticalAll = this.criticalAlertCount;
      const warningAll = this.warningAlertCount;
      
      console.log(` Toast: ${totalAll} alertes totales (${criticalAll} critiques, ${warningAll} warnings)`);
      console.log(` Dashboard affiche: ${this.getTotalDisplayAlerts()} alertes (5 dernières par domaine)`);
      
      if (totalAll > 0) {
        this.showAlertNotification(totalAll, criticalAll, warningAll);
        localStorage.setItem('lastAlertNotification', today);
        this.notificationShownToday = true;
      }
      
    } catch (error) {
      console.error(' Erreur:', error);
    } finally {
      this.isCheckingNotifications = false;
    }
  }

  private showAlertNotification(total: number, critical: number, warning: number): void {
    this.soundService.playNotificationSound();
    
    let msg = '';
    if (critical > 0) msg += `<div> <strong>${critical}</strong> critique(s)</div>`;
    if (warning > 0) msg += `<div> <strong>${warning}</strong> avertissement(s)</div>`;
    
    this.ngZone.run(() => {
      const ref = this.toastr.warning(msg,
        ` ${total} alerte(s) totale(s)`,
        { 
          enableHtml: true, 
          positionClass: 'toast-top-right',
          timeOut: 10000, 
          closeButton: true, 
          progressBar: true, 
          tapToDismiss: false 
        }
      );
      ref.onTap.subscribe(() => this.ngZone.run(() => this.router.navigate(['/alerts'])));
    });
  }

  private async ensureOfflineData(): Promise<void> {
    console.log(' Vérification des caches pour mode offline...');
    
    let evolutionData = await this.cacheService.getFromCache('vehicle-evolution-data');
    if (!evolutionData && this.isOnline) {
      console.log(' Initialisation du cache évolution mensuelle...');
      try {
        const headers = await firstValueFrom(
          this.vehiculePointageService.getAllPointages(false).pipe(timeout(15000))
        );
        evolutionData = this.calculateMonthlyEvolution(headers);
        await this.cacheService.saveToCache('vehicle-evolution-data', evolutionData);
        console.log(' Cache évolution mensuelle initialisé');
      } catch (error) {
        console.warn(' Impossible d\'initialiser le cache évolution mensuelle:', error);
      }
    }
    
    let enginesData = await this.cacheService.getFromCache('vehicle-engines-data');
    if (!enginesData && this.isOnline) {
      console.log(' Initialisation du cache engins actifs...');
      try {
        const pointages = await firstValueFrom(
          this.vehiculePointageService.getAllPointages(true).pipe(timeout(30000))
        );
        
        if (pointages.length > 0) {
          let maxActiveEngines = 0;
          for (const pointage of pointages.slice(0, 10)) {
            if (pointage.id) {
              try {
                const detail = await firstValueFrom(
                  this.vehiculePointageService.getHeaderById(pointage.id).pipe(timeout(15000))
                );
                const lines = detail.vehiculePointageLines || [];
                const uniqueVehicles = new Set(lines.map((l: any) => l.vehiculeNo).filter((v: string) => v && v.trim()));
                if (uniqueVehicles.size > maxActiveEngines) {
                  maxActiveEngines = uniqueVehicles.size;
                }
              } catch (e) {
                console.warn('Erreur:', e);
              }
            }
          }
          await this.cacheService.saveToCache('vehicle-engines-data', maxActiveEngines);
          console.log(` Cache engins actifs initialisé: ${maxActiveEngines}`);
        }
      } catch (error) {
        console.warn(' Impossible d\'initialiser le cache engins actifs:', error);
      }
    }
  }
}