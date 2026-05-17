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

import {
  DashboardService, DashboardKpi, ProjectProgress,
  TaskStatusCount, OverdueTask, Alert as DashboardAlert
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

// ─── Config domaines d'alertes ────────────────────────────
const ALERT_DOMAINS = [
  { key: 'siteManagement',  label: 'Gestion chantier',   icon: 'business_center',  gradient: 'linear-gradient(135deg,#ef4444,#dc2626)' },
  { key: 'purchaseRequests',label: 'Demandes d\'achat',   icon: 'shopping_cart',    gradient: 'linear-gradient(135deg,#8b5cf6,#7c3aed)' },
  { key: 'transfers',       label: 'Ordres de transfert', icon: 'local_shipping',   gradient: 'linear-gradient(135deg,#06b6d4,#0891b2)' },
  { key: 'stock',           label: 'Stock',               icon: 'inventory_2',      gradient: 'linear-gradient(135deg,#3b82f6,#2563eb)' },
  { key: 'vehicules',       label: 'Engins',              icon: 'construction',     gradient: 'linear-gradient(135deg,#f59e0b,#d97706)' },
  { key: 'gasoil',          label: 'Gasoil',              icon: 'local_gas_station',gradient: 'linear-gradient(135deg,#10b981,#059669)' },
] as const;

@Component({
  selector: 'app-dashboard-home',
  standalone: true,
  imports: [CommonModule, RouterModule, MatIcon],
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
  private isCheckingNotifications = false; // ✅ Éviter les appels multiples

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

  // ── Alertes ───────────────────────────────────────────────
  alertDomains = ALERT_DOMAINS;
  recentAlerts: Record<string, Alert[]> = {
    siteManagement: [], purchaseRequests: [], transfers: [],
    stock: [], vehicules: [], gasoil: []
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
    
    // S'abonner aux changements de connectivité
    this.offlineSync.isOnline$
      .pipe(takeUntil(this.destroy$))
      .subscribe(online => {
        this.isOnline = online;
        console.log('📡 Dashboard - Connectivité:', online ? 'En ligne' : 'Hors ligne');
        if (online) {
          this.loadDashboard(true);
        }
      });
    
    // Charger le dashboard
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
        console.log('📊 Compteurs d\'alertes:', counts);
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
      await this.loadDashboardDataWithCache(forceRefresh);
      await this.loadVehiclePointageDataWithCache(forceRefresh);
      await this.loadStockDataWithCache(forceRefresh);
      await this.loadAttendanceDataWithCache(forceRefresh);
      
      this.isLoading = false;
      this.cdr.detectChanges();
      
      setTimeout(() => {
        this.initAllCharts();
        this.loadAlertsByDomain();
      }, 300);
      
    } catch (error) {
      console.error('❌ Erreur chargement dashboard:', error);
      this.isLoading = false;
      this.hasError = true;
      this.cdr.detectChanges();
    }

    this.loadingTimeout = setTimeout(() => {
      if (this.isLoading) {
        this.isLoading = false;
        this.hasError = true;
        this.cdr.detectChanges();
      }
    }, 15000);
  }

  private async loadDashboardDataWithCache(forceRefresh: boolean = false): Promise<void> {
    const cacheKey = 'dashboard-data';
    
    try {
      const cachedData = await this.cacheService.getFromCache(cacheKey);
      
      if (cachedData && !forceRefresh && !this.isOnline) {
        console.log('📦 Dashboard: Utilisation du cache offline');
        this.applyDashboardData(cachedData);
        return;
      }
      
      if (this.isOnline || forceRefresh) {
        const data = await firstValueFrom(this.dashboardService.getDashboardData().pipe(timeout(10000)));
        this.applyDashboardData(data);
        await this.cacheService.saveToCache(cacheKey, data);
        console.log('💾 Dashboard: Données mises en cache');
      } else if (cachedData) {
        console.log('📦 Dashboard: Utilisation du cache (expiré)');
        this.applyDashboardData(cachedData);
      } else {
        console.warn('⚠️ Dashboard: Aucune donnée disponible offline');
      }
    } catch (error) {
      console.error('❌ Erreur chargement dashboard data:', error);
      const cachedData = await this.cacheService.getFromCache(cacheKey);
      if (cachedData) {
        console.log('📦 Dashboard: Fallback vers cache après erreur');
        this.applyDashboardData(cachedData);
      }
    }
  }

  private applyDashboardData(data: any): void {
    if (data) {
      this.kpi = { ...data.kpi, tasksBlocked: data.kpi.tasksBlocked ?? 0 };
      this.projectsProgress = data.projectsProgress ?? [];
      this.tasksByStatus = data.tasksByStatus ?? [];
      this.overdueTasks = (data.overdueTasks ?? []).slice(0, 10);
      this.tasksDetail = data.tasksDetail ?? [];
      this.lastUpdate = new Date();
      this.hasError = false;
      
      // ✅ Forcer la mise à jour des tâches en retard
      setTimeout(() => {
        this.forceRefreshOverdueTasks();
        this.cdr.detectChanges();
      }, 500);
    }
  }

  /**
   * Force la mise à jour des tâches en retard
   */
  private forceRefreshOverdueTasks(): void {
    if (!this.tasksDetail || this.tasksDetail.length === 0) {
      console.log('⚠️ Aucune tâche à vérifier');
      return;
    }
    
    console.log(`🔍 Force refresh des tâches en retard sur ${this.tasksDetail.length} tâches...`);
    
    this.tasksDetail.forEach(task => {
      console.log(`  Tâche ${task.taskNo}: dateFin=${task.dateFin}, progress=${task.progressPct}%, isBlocked=${task.isBlocked}`);
    });
    
    const overdue = this.tasksDetail.filter(task => this.isOverdue(task));
    console.log(`🔍 Tâches en retard détectées: ${overdue.length}`);
    
    if (overdue.length > 0 && this.overdueTasks.length === 0) {
      this.overdueTasks = overdue.map(task => ({
        jobNo: task.taskNo.split('-')[0] || 'PROJET',
        taskNo: task.taskNo,
        description: task.description,
        dateFin: task.dateFin,
        progressPct: task.progressPct
      }));
      console.log('✅ Tâches en retard mises à jour manuellement:', this.overdueTasks);
      this.cdr.detectChanges();
    } else if (overdue.length === 0 && this.tasksDetail.length > 0) {
      console.log('ℹ️ Aucune tâche en retard détectée');
    }
  }

  private async loadVehiclePointageDataWithCache(forceRefresh: boolean = false): Promise<void> {
    const cacheKey = 'vehicle-pointage-data';
    
    try {
      const cachedData = await this.cacheService.getFromCache(cacheKey);
      
      if (cachedData && cachedData.vehiclePointageData && cachedData.vehiclePointageData.length > 0 && !forceRefresh && !this.isOnline) {
        console.log('📦 Pointage véhicules: Utilisation du cache existant');
        this.applyVehiclePointageData(cachedData);
        return;
      }
      
      if (this.isOnline || forceRefresh) {
        console.log('📡 Chargement des pointages véhicules depuis l\'API...');
        
        const pointages = await firstValueFrom(
          this.vehiculePointageService.getAllPointages(forceRefresh).pipe(timeout(15000))
        );
        
        console.log(`📦 ${pointages.length} pointages trouvés, chargement des détails...`);
        
        if (pointages.length === 0) {
          const emptyData = {
            vehiclePointageData: [], validationRate: 0,
            pendingPointages: [], vehiclePannes: [],
            vehicleStatusData: [], activeEngines: 0
          };
          await this.cacheService.saveToCache(cacheKey, emptyData);
          this.applyVehiclePointageData(emptyData);
          return;
        }
        
        const pointagesWithLines: any[] = [];
        
        for (const pointage of pointages) {
          if (pointage.id) {
            try {
              const detail = await firstValueFrom(
                this.vehiculePointageService.getHeaderById(pointage.id).pipe(timeout(10000))
              );
              pointagesWithLines.push(detail);
            } catch (e) {
              console.warn(`⚠️ Erreur chargement ${pointage.documentNo}:`, e);
              pointagesWithLines.push(pointage);
            }
          }
        }
        
        const processedData = this.processVehiclePointageData(pointagesWithLines);
        this.applyVehiclePointageData(processedData);
        await this.cacheService.saveToCache(cacheKey, processedData);
        console.log('💾 Données pointage véhicules mises en cache');
        
      } else if (cachedData) {
        this.applyVehiclePointageData(cachedData);
      } else {
        this.applyVehiclePointageData({
          vehiclePointageData: [], validationRate: 0,
          pendingPointages: [], vehiclePannes: [],
          vehicleStatusData: [], activeEngines: 0
        });
      }
    } catch (error) {
      console.error('❌ Erreur chargement pointage véhicules:', error);
      const cachedData = await this.cacheService.getFromCache(cacheKey);
      if (cachedData) {
        this.applyVehiclePointageData(cachedData);
      }
    }
  }

  private processVehiclePointageData(pointages: any[]): any {
    const monthlyMap = new Map<string, { total: number; validated: number }>();
    const statusMap = new Map<string, number>();
    let activeEnginesCount = 0;
    let totalLines = 0;
    
    console.log('📊 Traitement des pointages véhicules:', pointages?.length);
    
    pointages.forEach(p => {
      if (p.date) {
        const d = new Date(p.date);
        const key = d.toLocaleString('fr-FR', { month: 'short' }) + ' ' + d.getFullYear();
        if (!monthlyMap.has(key)) monthlyMap.set(key, { total: 0, validated: 0 });
        const s = monthlyMap.get(key)!;
        s.total++;
        if (p.status === 'Validé') s.validated++;
      }
      
      const lines = p.vehiculePointageLines || p.lines || [];
      totalLines += lines.length;
      
      lines.forEach((line: any) => {
        const status = line.status || 'Non défini';
        statusMap.set(status, (statusMap.get(status) || 0) + 1);
        
        if (status === 'Fonctionnel' || status === 'Disponible') {
          activeEnginesCount++;
        }
      });
    });
    
    const vehicleStatusData = Array.from(statusMap.entries())
      .map(([status, count]) => ({ status, count }))
      .sort((a, b) => b.count - a.count);
    
    const totalPointages = pointages.length;
    const validatedCount = pointages.filter(p => p.status === 'Validé').length;
    const validationRate = totalPointages > 0 ? Math.round((validatedCount / totalPointages) * 100) : 0;
    
    console.log(`📊 Résultats finaux: ${totalPointages} pointages, ${validatedCount} validés (${validationRate}%), ${activeEnginesCount} engins actifs`);
    
    return {
      vehiclePointageData: Array.from(monthlyMap.entries())
        .map(([month, s]) => ({ month, total: s.total, validated: s.validated }))
        .slice(-6),
      validationRate: validationRate,
      pendingPointages: pointages
        .filter(p => p.status !== 'Validé')
        .slice(0, 10)
        .map(p => ({ documentNo: p.documentNo || p.no || '—', date: p.date?.toString() || '' })),
      vehiclePannes: [],
      vehicleStatusData: vehicleStatusData,
      activeEngines: activeEnginesCount
    };
  }

  private applyVehiclePointageData(data: any): void {
    if (data) {
      this.vehiclePointageData = data.vehiclePointageData || [];
      this.validationRate = data.validationRate || 0;
      this.pendingPointages = data.pendingPointages || [];
      this.vehiclePannes = data.vehiclePannes || [];
      this.vehicleStatusData = data.vehicleStatusData || [];
      this.kpi.activeEngines = data.activeEngines || 0;
      
      setTimeout(() => {
        if (this.vehiclePointageData.length > 0) {
          this.createVehiclePointageChart();
        }
        if (this.vehicleStatusData.length > 0) {
          this.createVehicleStatusChart();
        }
      }, 100);
      
      this.cdr.detectChanges();
    }
  }

  private async loadStockDataWithCache(forceRefresh: boolean = false): Promise<void> {
    const cacheKey = 'stock-data';
    
    try {
      const cachedData = await this.cacheService.getFromCache(cacheKey);
      
      if (cachedData && !forceRefresh && !this.isOnline) {
        console.log('📦 Stock: Utilisation du cache offline');
        this.applyStockData(cachedData);
        return;
      }
      
      if (this.isOnline || forceRefresh) {
        const stock = await firstValueFrom(this.stockService.getAllStock().pipe(timeout(10000)));
        const processedData = this.processStockData(stock);
        this.applyStockData(processedData);
        await this.cacheService.saveToCache(cacheKey, processedData);
      } else if (cachedData) {
        this.applyStockData(cachedData);
      }
    } catch (error) {
      console.error('❌ Erreur chargement stock:', error);
      const cachedData = await this.cacheService.getFromCache(cacheKey);
      if (cachedData) this.applyStockData(cachedData);
    }
  }

  private processStockData(stock: any[]): any {
    const items = stock || [];
    const totalQuantity = items.reduce((s, i) => s + (i.quantity || 0), 0);
    const lowStockCount = items.filter(i => i.quantity > 0 && i.quantity <= 10).length;
    const outOfStockCount = items.filter(i => i.quantity <= 0).length;
    
    const locMap = new Map<string, number>();
    items.forEach(i => {
      const loc = i.locationCode || 'Sans magasin';
      locMap.set(loc, (locMap.get(loc) || 0) + (i.quantity || 0));
    });
    
    return {
      stockStats: {
        totalItems: items.length,
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
      this.stockStats = data.stockStats || { totalItems: 0, totalQuantity: 0, lowStockCount: 0, outOfStockCount: 0 };
      this.stockByLocation = data.stockByLocation || [];
      this.stockCritical = data.stockCritical || { outOfStock: [], lowStock: [], dormant: [] };
      this.kpi.criticalStockCount = data.kpiCriticalStockCount || 0;
      
      setTimeout(() => {
        this.createStockEvolutionChart();
        this.createStockDistributionChart();
        this.cdr.detectChanges();
      }, 100);
    }
  }

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
        console.log('📦 Pointage employés: Utilisation du cache offline');
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
        }
      } else if (cachedData) {
        this.applyAttendanceData(cachedData);
      }
    } catch (error) {
      console.error('❌ Erreur chargement pointage employés:', error);
      const cachedData = await this.cacheService.getFromCache(cacheKey);
      if (cachedData) this.applyAttendanceData(cachedData);
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

  private async loadAlertsByDomain(): Promise<void> {
    const cacheKey = 'alerts-by-domain';
    
    try {
      const cachedData = await this.cacheService.getFromCache(cacheKey);
      
      if (cachedData && !this.isOnline) {
        console.log('📦 Alertes: Utilisation du cache offline');
        this.applyAlertsData(cachedData);
        return;
      }
      
      if (this.isOnline) {
        const alerts = await firstValueFrom(
          this.alertsService.getAllAlertsByDomain(50).pipe(timeout(8000))
        );
        
        this.applyAlertsData(alerts);
        await this.cacheService.saveToCache(cacheKey, alerts);
        console.log('💾 Alertes mises en cache');
        
        this.checkAndShowAlertsNotification();
        
      } else if (cachedData) {
        this.applyAlertsData(cachedData);
      }
    } catch (error) {
      console.error('❌ Erreur chargement alertes:', error);
      const cachedData = await this.cacheService.getFromCache(cacheKey);
      if (cachedData) {
        this.applyAlertsData(cachedData);
      }
    }
  }

  private applyAlertsData(alerts: any): void {
    this.recentAlerts = {
      siteManagement: this.getLatestAlerts(alerts.siteManagement, 5),
      purchaseRequests: this.getLatestAlerts(alerts.purchaseRequests, 5),
      transfers: this.getLatestAlerts(alerts.transfers, 5),
      stock: this.getLatestAlerts(alerts.stock, 5),
      vehicules: this.getLatestAlerts(alerts.vehicules, 5),
      gasoil: this.getLatestAlerts(alerts.gasoil, 5),
    };
    this.cdr.detectChanges();
  }

  private getLatestAlerts(alerts: Alert[], limit: number): Alert[] {
    if (!alerts?.length) return [];
    return [...alerts]
      .sort((a, b) => new Date(b.detectedAt).getTime() - new Date(a.detectedAt).getTime())
      .slice(0, limit);
  }

  // ══════════════════════════════════════════════════════════
  // POINTAGE EMPLOYÉS
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
    const date = new Date(this.currentAttendance!.year, this.getMonthIndex(this.currentAttendance!.month), day);
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
            borderWidth: 3,
            tension: 0.4,
            fill: true,
            pointBackgroundColor: '#6366F1',
            pointBorderColor: '#fff',
            pointRadius: 4,
            pointHoverRadius: 6
          },
          {
            label: 'Validés',
            data: this.vehiclePointageData.map(d => d.validated),
            borderColor: '#10B981',
            backgroundColor: 'rgba(16,185,129,0.1)',
            borderWidth: 3,
            tension: 0.4,
            fill: true,
            pointBackgroundColor: '#10B981',
            pointBorderColor: '#fff',
            pointRadius: 4,
            pointHoverRadius: 6
          }
        ]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: { legend: { position: 'bottom' } },
        scales: {
          y: { beginAtZero: true, title: { display: true, text: 'Nombre' }, grid: { color: 'rgba(0,0,0,0.05)' } },
          x: { grid: { display: false } }
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
    // Conditions d'exclusion
    if (t.isBlocked) return false;
    if (t.progressPct >= 100) return false;
    if (!t.dateFin) return false;
    
    // Conversion robuste de la date
    let dueDate: Date;
    
    if (typeof t.dateFin === 'string') {
      if (t.dateFin.includes('-')) {
        const parts = t.dateFin.split('-');
        if (parts.length === 3) {
          dueDate = new Date(parseInt(parts[0]), parseInt(parts[1]) - 1, parseInt(parts[2]));
        } else {
          dueDate = new Date(t.dateFin);
        }
      } else if (t.dateFin.includes('/')) {
        const parts = t.dateFin.split('/');
        if (parts.length === 3) {
          dueDate = new Date(parseInt(parts[2]), parseInt(parts[1]) - 1, parseInt(parts[0]));
        } else {
          dueDate = new Date(t.dateFin);
        }
      } else {
        dueDate = new Date(t.dateFin);
      }
    } else {
      dueDate = new Date(t.dateFin);
    }
    
    if (isNaN(dueDate.getTime())) return false;
    
    const today = new Date();
    today.setHours(0, 0, 0, 0);
    dueDate.setHours(0, 0, 0, 0);
    
    return dueDate < today;
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
      return '—'; 
    }
  }

  daysOverdue(date: string | null): number {
    if (!date) return 0;
    const diff = new Date().getTime() - new Date(date).getTime();
    return Math.max(0, Math.floor(diff / 86400000));
  }

  getAlertTypeIcon(type: string): string {
    if (type?.toLowerCase().includes('stock')) return '📦';
    if (type?.toLowerCase().includes('gasoil')) return '⛽';
    if (type?.toLowerCase().includes('purchase')) return '🛒';
    if (type?.toLowerCase().includes('transfer')) return '🚚';
    if (type?.toLowerCase().includes('task')) return '📋';
    if (type?.toLowerCase().includes('vehicule')) return '🚗';
    return '🔔';
  }

  getAlertSeverityClass(severity: string): string {
    return severity === 'Critical' ? 'alert-critical-card' :
           severity === 'Warning' ? 'alert-warning-card' : 'alert-info-card';
  }

  navigateToDomainAlerts(domain: string): void {
    this.router.navigate(['/alerts'], { queryParams: { filterDomain: domain } });
  }

  onAlertClick(alert: Alert): void {
    this.alertsService.markAsRead(alert.id);
    this.alertsService.navigateToAlert(alert);
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

  refresh(): void {
    if (!this.isOnline) {
      this.toastr.warning('Impossible d\'actualiser en mode hors ligne', 'Mode offline');
      return;
    }
    this.loadDashboard(true);
  }

  private checkAndShowAlertsNotification(): void {
    if (this.isCheckingNotifications) {
      console.log('🔇 Vérification des alertes déjà en cours');
      return;
    }
    
    const today = new Date().toDateString();
    if (localStorage.getItem('lastAlertNotification') === today && this.notificationShownToday) {
      console.log('🔇 Notification déjà affichée aujourd\'hui');
      return;
    }

    this.isCheckingNotifications = true;
    
    this.alertsService.getAllAlertsByDomain(50)
      .pipe(takeUntil(this.destroy$))
      .subscribe({
        next: alerts => {
          const all = Object.values(alerts).flat();
          const unread = all.filter(a => !this.alertsService.isRead(a.id));
          const critical = unread.filter(a => a.severity === 'Critical').length;
          const warning = unread.filter(a => a.severity === 'Warning').length;
          
          if (unread.length > 0) {
            this.showAlertNotification(unread.length, critical, warning);
            localStorage.setItem('lastAlertNotification', today);
            this.notificationShownToday = true;
          }
          
          this.isCheckingNotifications = false;
        },
        error: () => {
          this.isCheckingNotifications = false;
        }
      });
  }

  private showAlertNotification(total: number, critical: number, warning: number): void {
    this.soundService.playNotificationSound();
    
    if (total === 0) {
      this.ngZone.run(() => this.toastr.success(
        '✅ Aucune alerte à signaler.', 'Tout est sous contrôle',
        { positionClass: 'toast-top-right', timeOut: 4000, progressBar: true }
      ));
      return;
    }
    
    let msg = '';
    if (critical) msg += `<div>🔴 <strong>${critical}</strong> critique(s)</div>`;
    if (warning) msg += `<div>🟠 <strong>${warning}</strong> avertissement(s)</div>`;
    
    this.ngZone.run(() => {
      const ref = this.toastr.warning(msg,
        `⚠️ ${total} alerte(s) non traitée(s)`,
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
}