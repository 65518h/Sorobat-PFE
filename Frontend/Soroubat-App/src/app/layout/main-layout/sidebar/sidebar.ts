// sidebar.ts
import { Component, Input, OnInit, OnDestroy } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { Subject, takeUntil } from 'rxjs';

// Angular Material
import { MatListModule } from '@angular/material/list';
import { MatIconModule } from '@angular/material/icon';
import { MatDividerModule } from '@angular/material/divider';

// Service d'alertes
import { AlertService } from '../../../core/services/alert.service';

@Component({
  selector: 'app-sidebar',
  standalone: true,
  imports: [
    CommonModule,
    RouterModule,
    MatListModule,
    MatIconModule,
    MatDividerModule,
  ],
  templateUrl: './sidebar.html',
  styleUrls: ['./sidebar.css']
})
export class SidebarComponent implements OnInit, OnDestroy {
  @Input() class: string = '';
  
  criticalCount: number = 0;
  private destroy$ = new Subject<void>();
  
  menuItems = [
    { path: '/tasks', icon: 'assignment', label: 'Tâches', badge: 0 },
    { path: '/dashboard', icon: 'dashboard', label: 'Tableau de bord', badge: 0 },
    { path: '/projects', icon: 'folder', label: 'Projets', badge: 3 },
    { path: '/purchases', icon: 'shopping_cart', label: 'Demandes d\'achat', badge: 5 },
    { path: '/inventory', icon: 'inventory', label: 'Stock', badge: 2 },
    { path: '/equipment', icon: 'construction', label: 'Engins', badge: 0 },
    { path: '/settings', icon: 'settings', label: 'Paramètres', badge: 0 },
    { path: '/help', icon: 'help', label: 'Aide', badge: 0 }
  ];

  constructor(private alertService: AlertService) {}

  ngOnInit(): void {
    // S'abonner aux alertes pour afficher le compteur
    this.alertService.alerts$.pipe(takeUntil(this.destroy$)).subscribe(alerts => {
      const unreadCount = this.alertService.getUnreadCount();
      this.criticalCount = unreadCount.critical;
    });
    
    // Rafraîchir les alertes
    this.alertService.refreshAllAlerts();
  }

  ngOnDestroy(): void {
    this.destroy$.next();
    this.destroy$.complete();
  }
}