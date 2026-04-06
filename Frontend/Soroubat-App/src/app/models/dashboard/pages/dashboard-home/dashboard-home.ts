// src/app/modules/dashboard/pages/dashboard-home/dashboard-home.ts

import { Component, OnInit, OnDestroy, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { Subject } from 'rxjs';
import { takeUntil, finalize, timeout } from 'rxjs/operators';
import {
  DashboardService,
  DashboardKpi,
  ProjectProgress,
  TaskStatusCount,
  BudgetData,       // ← IMPORT AJOUTÉ
  OverdueTask,
  Alert
} from '../../services/dashboard.service';

@Component({
  selector: 'app-dashboard-home',
  standalone: true,
  imports: [CommonModule, RouterModule],
  templateUrl: './dashboard-home.html',
  styleUrls: ['./dashboard-home.css']
})
export class DashboardHomeComponent implements OnInit, OnDestroy {

  private destroy$ = new Subject<void>();
  private loadingTimeout: any;

  isLoading = true;
  hasError  = false;

  kpi: DashboardKpi = {
    activeProjects: 0, totalProjects: 0,
    tasksInProgress: 0, tasksOverdue: 0,
    tasksCompleted: 0, tasksTotal: 0,
    criticalStockCount: 0, activeEngines: 0
  };

  projectsProgress : ProjectProgress[]  = [];
  tasksByStatus    : TaskStatusCount[]   = [];
  overdueTasks     : OverdueTask[]       = [];
  alerts           : Alert[]             = [];
  budgetData       : BudgetData[]        = [];  // ✅ CORRECTION : typé + initialisé à []

  donutColors = ['#3B82F6', '#10B981', '#F59E0B', '#EF4444'];

  constructor(
    private dashboardService: DashboardService,
    private cdr: ChangeDetectorRef
  ) {}

  ngOnInit(): void { this.loadDashboard(); }

  ngOnDestroy(): void {
    this.destroy$.next();
    this.destroy$.complete();
    if (this.loadingTimeout) clearTimeout(this.loadingTimeout);
  }

  // ─────────────────────────────────────────────────────────────
  loadDashboard(): void {
    if (this.loadingTimeout) clearTimeout(this.loadingTimeout);

    this.isLoading = true;
    this.hasError  = false;
    this.cdr.detectChanges();

    this.dashboardService.getDashboardData()
      .pipe(
        timeout(10000),
        takeUntil(this.destroy$)
      )
      .subscribe({
        next: (data) => {
          this.kpi              = data.kpi;
          this.projectsProgress = data.projectsProgress  ?? [];
          this.tasksByStatus    = data.tasksByStatus      ?? [];
          this.overdueTasks     = (data.overdueTasks      ?? []).slice(0, 5);
          this.alerts           = data.alerts             ?? [];
          this.budgetData       = data.budgetData         ?? [];  // ✅ jamais undefined
          this.isLoading        = false;
          this.hasError         = false;
          this.cdr.detectChanges();
          if (this.loadingTimeout) clearTimeout(this.loadingTimeout);
        },
        error: (err) => {
          console.error('DASHBOARD ERROR', err);
          this.isLoading = false;
          this.hasError  = true;
          this.cdr.detectChanges();
        }
      });

    // Sécurité anti-blocage
    this.loadingTimeout = setTimeout(() => {
      if (this.isLoading) {
        console.warn('TIMEOUT atteint — forçage arrêt loading');
        this.isLoading = false;
        this.hasError  = true;
        this.cdr.detectChanges();
      }
    }, 10000);
  }

  // ─────────────────────────────────────────────────────────────
  // Helpers template
  // ─────────────────────────────────────────────────────────────

  pct(value: number): string {
    return Math.min(100, Math.max(0, Math.round(value || 0))) + '%';
  }

  progressColor(progress: number): string {
    if (progress >= 75) return '#10B981';
    if (progress >= 40) return '#3B82F6';
    if (progress >= 20) return '#F59E0B';
    return '#EF4444';
  }

  statusColor(status: string): string {
    switch (status) {
      case 'En cours':  return 'badge-blue';
      case 'Terminé':   return 'badge-green';
      case 'Suspendu':  return 'badge-orange';
      default:          return 'badge-gray';
    }
  }

  alertIcon(type: string): string {
    switch (type) {
      case 'retard': return '⏰';
      case 'budget': return '💰';
      case 'stock':  return '📦';
      default:       return '🔔';
    }
  }

  alertClass(severity: string): string {
    return severity === 'danger' ? 'alert-danger' : 'alert-warning';
  }

  get totalTasksForDonut(): number {
    return (this.tasksByStatus ?? []).reduce((s, t) => s + t.value, 0) || 1;
  }

  donutArc(index: number): string {
    const total = this.totalTasksForDonut;
    let offset  = 0;
    for (let i = 0; i < index; i++) {
      offset += (this.tasksByStatus[i].value / total) * 100;
    }
    const value = (this.tasksByStatus[index].value / total) * 100;
    return `${value} ${100 - value}`;
  }

  donutOffset(index: number): number {
    const total = this.totalTasksForDonut;
    let offset  = 25;
    for (let i = 0; i < index; i++) {
      offset -= (this.tasksByStatus[i].value / total) * 100;
    }
    return offset;
  }

  // ✅ Détecte les dates invalides BC (0001-01-01)
  isValidDate(date: string | null): boolean {
    if (!date) return false;
    const d = new Date(date);
    return d.getFullYear() >= 2000;
  }

  formatDate(date: string | null): string {
    if (!this.isValidDate(date)) return '—';
    try { return new Date(date!).toLocaleDateString('fr-FR'); }
    catch { return '—'; }
  }

  daysOverdue(dateFin: string | null): number {
    if (!this.isValidDate(dateFin)) return 0;
    const diff = new Date().getTime() - new Date(dateFin!).getTime();
    return Math.max(0, Math.floor(diff / (1000 * 60 * 60 * 24)));
  }
}