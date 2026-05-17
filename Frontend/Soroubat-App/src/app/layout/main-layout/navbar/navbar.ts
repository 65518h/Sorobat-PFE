// src/app/layout/main-layout/navbar/navbar.ts

import { Component, Output, EventEmitter, Input, ViewEncapsulation, OnInit, OnDestroy, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule, Router } from '@angular/router';
import { AuthService } from '../../../core/services/auth';
import { Subject, takeUntil } from 'rxjs';

// Angular Material
import { MatToolbarModule } from '@angular/material/toolbar';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatMenuModule } from '@angular/material/menu';
import { MatBadgeModule } from '@angular/material/badge';
import { MatTooltipModule } from '@angular/material/tooltip';
import { MatDividerModule } from '@angular/material/divider';
import { MatDialogModule, MatDialog } from '@angular/material/dialog';

// Notification Bell Component
import { NotificationBellComponent } from '../../../core/components/notification-bell/notification-bell';

// Service de synchronisation offline
import { OfflineSyncService } from '../../../core/services/offline-sync.service';

@Component({
  selector: 'app-navbar',
  standalone: true,
  imports: [
    CommonModule,
    MatDividerModule,
    RouterModule,
    MatToolbarModule,
    MatButtonModule,
    MatIconModule,
    MatMenuModule,
    MatBadgeModule,
    MatTooltipModule,
    MatDialogModule,
    NotificationBellComponent
  ],
  templateUrl: './navbar.html',
  styleUrls: ['./navbar.css'],
  encapsulation: ViewEncapsulation.None
})
export class NavbarComponent implements OnInit, OnDestroy {

  @Input() isSidebarOpen: boolean = true;
  @Output() menuToggle = new EventEmitter<void>();

  isRotating = false;
  isSpinning = false;
  
  userName: string = 'Chargement...';
  userEmail: string = '';
  userRole: string = '';
  userInitials: string = 'U';
  userFullName: string = '';
  
  // ✅ Utilisation de navigator.onLine directement (plus fiable)
  isOnlineDirect: boolean = navigator.onLine;
  pendingCount: number = 0;
  
  private destroy$ = new Subject<void>();
  private intervalId: any;

  constructor(
    public authService: AuthService,
    private offlineSyncService: OfflineSyncService,
    private router: Router,
    private dialog: MatDialog,
    private cdr: ChangeDetectorRef
  ) {}

  ngOnInit(): void {
    this.loadUserInfo();
    
    // ✅ MÉTHODE 1: Écouter les événements du navigateur
    window.addEventListener('online', () => {
      console.log('🟢 Événement online - Navigation');
      this.isOnlineDirect = true;
      this.cdr.detectChanges();
    });
    
    window.addEventListener('offline', () => {
      console.log('🔴 Événement offline - Navigation');
      this.isOnlineDirect = false;
      this.cdr.detectChanges();
    });
    
    // ✅ MÉTHODE 2: Intervalle de secours (toutes les 2 secondes)
    this.intervalId = setInterval(() => {
      const currentState = navigator.onLine;
      if (this.isOnlineDirect !== currentState) {
        console.log('📡 Intervalle détecte changement:', currentState ? 'En ligne' : 'Hors ligne');
        this.isOnlineDirect = currentState;
        this.cdr.detectChanges();
      }
    }, 2000);
    
    // S'abonner au compteur de documents en attente
    this.offlineSyncService.pendingCount$
      .pipe(takeUntil(this.destroy$))
      .subscribe(count => {
        this.pendingCount = count;
        this.cdr.detectChanges();
      });
    
    // S'abonner aux changements de l'utilisateur courant
    this.authService.currentUser$
      .pipe(takeUntil(this.destroy$))
      .subscribe(user => {
        if (user) {
          this.updateUserInfo(user);
          this.cdr.detectChanges();
        }
      });
  }
  
  ngOnDestroy(): void {
    if (this.intervalId) {
      clearInterval(this.intervalId);
    }
    this.destroy$.next();
    this.destroy$.complete();
  }

  openSyncModal(): void {
    if (this.pendingCount === 0) {
      alert('✅ Aucun document en attente de synchronisation.');
    } else {
      alert(`📱 ${this.pendingCount} document(s) en attente de synchronisation.\n\nLa synchronisation se fera automatiquement au retour du réseau.`);
    }
  }

  private loadUserInfo(): void {
    const user = this.authService.getUser();
    if (user) {
      this.updateUserInfo(user);
    } else {
      const email = this.authService.getEmail();
      if (email) {
        this.userName = email.split('@')[0];
        this.userEmail = email;
        this.userInitials = this.getInitials(this.userName);
      }
    }
  }

  private updateUserInfo(user: any): void {
    if (user.chefInfo?.nomEtPrenom) {
      this.userName = user.chefInfo.nomEtPrenom;
      this.userFullName = user.chefInfo.nomEtPrenom;
    } else if (user.name) {
      this.userName = user.name;
      this.userFullName = user.name;
    } else if (user.username) {
      this.userName = user.username.split('@')[0];
      this.userFullName = user.username;
    } else {
      this.userName = 'Utilisateur';
      this.userFullName = 'Utilisateur';
    }
    
    if (user.email) {
      this.userEmail = user.email;
    } else if (user.username) {
      this.userEmail = user.username;
    }
    
    if (user.role === 'CHEF_CHANTIER') {
      this.userRole = 'Chef de chantier';
    } else if (user.role === 'RESPONSABLE') {
      this.userRole = 'Responsable projet';
    } else if (user.role === 'ADMIN') {
      this.userRole = 'Administrateur';
    } else {
      this.userRole = 'Utilisateur';
    }
    
    this.userInitials = this.getInitials(this.userName);
    console.log('👤 User info mise à jour:', this.userName, this.userRole);
  }

  private getInitials(name: string): string {
    if (!name || name === 'Chargement...') return 'U';
    
    const parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return (parts[0].charAt(0) + parts[1].charAt(0)).toUpperCase();
    }
    if (parts[0].length >= 2) {
      return parts[0].substring(0, 2).toUpperCase();
    }
    return parts[0].charAt(0).toUpperCase();
  }

  toggleMenu(): void {
    this.isRotating = true;
    this.isSpinning = true;
    setTimeout(() => { this.isSpinning = false; }, 1000);
    this.menuToggle.emit();
  }

  goToAttendance(): void {
    console.log('👥 Navigation vers le pointage des employés');
    this.router.navigate(['/attendance']);
  }

  goToCalendar(): void {
    console.log('📅 Navigation vers le calendrier');
    this.router.navigate(['/calendar']);
  }

  logout(): void {
    console.log('🚪 Déconnexion demandée depuis la navbar');
    // ✅ Vérification supplémentaire avant déconnexion
    if (!this.isOnlineDirect) {
      console.log('⚠️ Déconnexion bloquée - mode hors ligne');
      alert('Impossible de se déconnecter en mode hors ligne');
      return;
    }
    this.authService.logout();
  }
}