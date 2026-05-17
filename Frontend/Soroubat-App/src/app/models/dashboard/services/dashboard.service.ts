// src/app/modules/dashboard/services/dashboard.service.ts

import { Injectable } from '@angular/core';
import { Observable, of, forkJoin } from 'rxjs';
import { map, catchError, timeout, switchMap } from 'rxjs/operators';
import { ProjectService } from '../../projects/services/project';
import { JobTask } from '../../projects/models/job-task.model';
import { StockService } from '../../inventory/services/stock';
import { VehiculePointageService } from '../../equipment/services/vehicule-pointage.service';

// ─── Interfaces exportées ────────────────────────────────────────────────────

export interface DashboardKpi {
  activeProjects:    number;
  totalProjects:     number;
  tasksInProgress:   number;
  tasksOverdue:      number;
  tasksCompleted:    number;
  tasksTotal:        number;
  criticalStockCount:number;
  activeEngines:     number;
  tasksBlocked:      number;
}

export interface ProjectProgress {
  name:     string;
  progress: number;
  status:   string;
}

export interface TaskStatusCount {
  name:  string;
  value: number;
}

export interface TaskDetail {
  taskNo:      string;
  description: string;
  progressPct: number;
  dateFin:     string | null;
  dateDebut:   string | null;
  isBlocked:   boolean;
}

export interface OverdueTask {
  jobNo:       string;
  taskNo:      string;
  description: string;
  dateFin:     string | null;
  progressPct: number;
}

export interface Alert {
  type:     'retard' | 'stock' | 'vehicle';
  message:  string;
  severity: 'warning' | 'danger' | 'info';
}

export interface DashboardData {
  kpi:              DashboardKpi;
  projectsProgress: ProjectProgress[];
  tasksByStatus:    TaskStatusCount[];
  tasksDetail:      TaskDetail[];
  overdueTasks:     OverdueTask[];
  alerts:           Alert[];
}

@Injectable({ providedIn: 'root' })
export class DashboardService {

  constructor(
    private projectService:          ProjectService,
    private stockService:            StockService,
    private vehiculePointageService: VehiculePointageService
  ) {}

  // ── Utilitaires ────────────────────────────────────────────

  private normalizeStatus(status: string): string {
    const s = (status || '').toLowerCase().trim();
    if (s === 'en cours' || s === 'open')                                           return 'En cours';
    if (s === 'terminé'  || s === 'completed' || s === 'totallement pris en charge') return 'Terminé';
    if (s === 'suspendu' || s === 'suspended')                                       return 'Suspendu';
    return status || 'Open';
  }

  private isValidDate(date: string | null | undefined): boolean {
    if (!date) return false;
    const d = new Date(date);
    return !isNaN(d.getTime()) && d.getFullYear() >= 2000;
  }

 private isTaskOverdue(task: JobTask): boolean {
  //  Vérification plus stricte
  if (task.isBlocked) return false;
  if ((task.progressPct || 0) >= 100) return false;
  
  //  Vérifier que la date de fin existe
  if (!task.dateFin) return false;
  
  //  Convertir la date correctement
  const dueDate = new Date(task.dateFin);
  if (isNaN(dueDate.getTime())) return false;
  
  const today = new Date();
  today.setHours(0, 0, 0, 0);
  
  return dueDate < today;
}

  private calculateProjectProgress(tasks: JobTask[]): number {
    if (!tasks?.length) return 0;
    const total = tasks.reduce((sum, t) => sum + (t.progressPct || 0), 0);
    return Math.round(total / tasks.length);
  }

  private getEmptyData(): DashboardData {
    return {
      kpi: {
        activeProjects: 0, totalProjects: 0,
        tasksInProgress: 0, tasksOverdue: 0,
        tasksCompleted: 0, tasksTotal: 0,
        criticalStockCount: 0, activeEngines: 0,
        tasksBlocked: 0
      },
      projectsProgress: [],
      tasksByStatus: [],
      tasksDetail: [],
      overdueTasks: [],
      alerts: []
    };
  }

  // ── Point d'entrée principal ────────────────────────────────

  getDashboardData(): Observable<DashboardData> {

    return forkJoin({
      projectData: this.projectService.getMyProjectWithTasks().pipe(
        timeout(30000),
        catchError(err => { console.error('❌ Erreur projet:', err); return of({ project: null, tasks: [] }); })
      ),
      stockData: this.loadStockData().pipe(
        timeout(30000),
        catchError(() => of({ criticalStockCount: 0, totalItems: 0 }))
      ),
      vehicleData: this.loadVehicleData().pipe(
        timeout(30000),
        catchError(() => of({ activeEngines: 0, totalPointages: 0 }))
      )
    }).pipe(
      map(({ projectData, stockData, vehicleData }) => {
        const { project, tasks } = projectData;

        if (!project) {
          console.warn('⚠️ Aucun projet trouvé');
          return this.getEmptyData();
        }

        const allTasks = tasks || [];
        const today    = new Date();

        // ── Métriques de base ──────────────────────────────
        const tasksCompleted  = allTasks.filter(t => (t.progressPct || 0) >= 100).length;
        const tasksBlocked    = allTasks.filter(t => t.isBlocked).length;
        const tasksOverdue    = allTasks.filter(t => this.isTaskOverdue(t)).length;
        const tasksNotStarted = allTasks.filter(t =>
          !t.isBlocked && (t.progressPct || 0) === 0
        ).length;
        const tasksInProgress = allTasks.filter(t => {
          const p = t.progressPct || 0;
          return !t.isBlocked && p > 0 && p < 100 && !this.isTaskOverdue(t);
        }).length;

        const isProjectActive = project.status === 'En cours' || project.status === 'Open';
        const projectProgress = this.calculateProjectProgress(allTasks);

        // ── KPI ───────────────────────────────────────────
        const kpi: DashboardKpi = {
          activeProjects:     isProjectActive ? 1 : 0,
          totalProjects:      1,
          tasksInProgress,
          tasksOverdue,
          tasksCompleted,
          tasksTotal:         allTasks.length,
          criticalStockCount: stockData.criticalStockCount || 0,
          activeEngines:      vehicleData.activeEngines    || 0,
          tasksBlocked,
        };

        // ── Avancement projet ────────────────────────────
        const projectsProgress: ProjectProgress[] = [{
          name:     project.no,
          progress: projectProgress,
          status:   this.normalizeStatus(project.status)
        }];

        // ── Donut par statut ──────────────────────────────
        const tasksByStatus: TaskStatusCount[] = [
          { name: 'En cours',      value: tasksInProgress },
          { name: 'Terminées',     value: tasksCompleted  },
          { name: 'Bloquées',      value: tasksBlocked    },
          { name: 'En retard',     value: tasksOverdue    },
          { name: 'Non démarrées', value: tasksNotStarted },
        ].filter(s => s.value > 0);

        // ── Détail complet des tâches ─────────────────────
        const tasksDetail: TaskDetail[] = allTasks.map(t => ({
          taskNo:      t.taskNo,
          description: t.description || t.taskNo,
          progressPct: t.progressPct || 0,
          dateFin:     this.isValidDate(t.dateFin)    ? t.dateFin!  : null,
          dateDebut:   this.isValidDate(t.dateDebut)  ? t.dateDebut!: null,
          isBlocked:   t.isBlocked || false
        }));

        // ── Tâches en retard ─────────────────────────────
        const overdueTasks: OverdueTask[] = allTasks
          .filter(t => this.isTaskOverdue(t))
          .slice(0, 10)
          .map(t => ({
            jobNo:       t.jobNo,
            taskNo:      t.taskNo,
            description: t.description || t.taskNo,
            dateFin:     this.isValidDate(t.dateFin) ? t.dateFin || null : null,
            progressPct: t.progressPct || 0
          }));

        // ── Alertes légères ──────────────────────────────
        const alerts: Alert[] = [];

        if (isProjectActive && projectProgress < 20 && allTasks.length > 0) {
          alerts.push({
            type:     'retard',
            message:  `Avancement très faible (${projectProgress}%) — Projet ${project.no}`,
            severity: 'danger'
          });
        }

        if (stockData.criticalStockCount > 0) {
          alerts.push({
            type:     'stock',
            message:  `${stockData.criticalStockCount} article(s) en stock critique`,
            severity: 'warning'
          });
        }

        if (vehicleData.totalPointages === 0) {
          alerts.push({
            type:     'vehicle',
            message:  `Aucun pointage de véhicule enregistré`,
            severity: 'info'
          });
        }

        console.log('✅ Dashboard OK:', {
          projet:         project.no,
          tâches:         allTasks.length,
          enCours:        tasksInProgress,
          terminées:      tasksCompleted,
          bloquées:       tasksBlocked,
          enRetard:       tasksOverdue,
          nonDémarrées:   tasksNotStarted,
          avancement:     projectProgress + '%',
          stockCritique:  stockData.criticalStockCount,
          enginsActifs:   vehicleData.activeEngines,
          pointagesTotal: vehicleData.totalPointages
        });

        return {
          kpi, projectsProgress, tasksByStatus,
          tasksDetail, overdueTasks, alerts
        };
      }),
      catchError(err => {
        console.error('🔥 Dashboard error:', err);
        return of(this.getEmptyData());
      })
    );
  }

  // ── Stock ────────────────────────────────────────────────────
  private loadStockData(): Observable<{ criticalStockCount: number; totalItems: number }> {
    return this.stockService.getAllStock().pipe(
      timeout(30000),
      map(stock => {
        const items          = stock || [];
        const lowStockCount  = items.filter(i => i.quantity > 0  && i.quantity <= 5).length;
        const outOfStockCount= items.filter(i => i.quantity <= 0).length;
        return { criticalStockCount: lowStockCount + outOfStockCount, totalItems: items.length };
      }),
      catchError(() => of({ criticalStockCount: 0, totalItems: 0 }))
    );
  }

  // ── Véhicules (CORRIGÉ) ─────────────────────────────────────
  // dashboard.service.ts - Modifiez la méthode loadVehicleData()

// ── Véhicules (CORRIGÉ avec chargement des lignes) ─────────────────────────
private loadVehicleData(): Observable<{ activeEngines: number; totalPointages: number }> {
  // 1. Récupérer d'abord la liste des pointages (sans lignes)
  return this.vehiculePointageService.getAllPointages().pipe(
    timeout(30000),
    switchMap(pointages => {
      const data = pointages || [];
      
      if (data.length === 0) {
        console.log('📊 Aucun pointage trouvé');
        return of({ activeEngines: 0, totalPointages: 0 });
      }
      
      console.log(`📊 ${data.length} pointages trouvés, chargement des détails...`);
      
      // 2. Pour chaque pointage, charger les détails complets (avec lignes)
      const detailRequests = data.map(pointage => 
        this.vehiculePointageService.getHeaderById(pointage.id!).pipe(
          timeout(10000),
          catchError(error => {
            console.warn(`⚠️ Erreur chargement pointage ${pointage.documentNo}:`, error);
            return of(null);
          })
        )
      );
      
      return forkJoin(detailRequests).pipe(
        map(details => {
          const allVehicles = new Set<string>();
          
          details.forEach(detail => {
            if (detail) {
              // Les lignes sont dans vehiculePointageLines
              const lines = detail.vehiculePointageLines || [];
              console.log(`  Pointage ${detail.documentNo}: ${lines.length} lignes`);
              
              lines.forEach((line: any) => {
                const vehiculeNo = line.vehiculeNo;
                if (vehiculeNo && vehiculeNo.trim() !== '') {
                  allVehicles.add(vehiculeNo);
                }
              });
            }
          });
          
          const result = {
            activeEngines: allVehicles.size,
            totalPointages: data.length
          };
          
          console.log(`📊 Résultat final: ${result.activeEngines} engins actifs sur ${result.totalPointages} pointages`);
          
          return result;
        })
      );
    }),
    catchError(error => {
      console.error('❌ Erreur chargement véhicules:', error);
      return of({ activeEngines: 0, totalPointages: 0 });
    })
  );
}

  refreshDashboard(): Observable<DashboardData> {
    return this.getDashboardData();
  }
}