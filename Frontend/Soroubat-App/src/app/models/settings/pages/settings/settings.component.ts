// src/app/modules/settings/pages/settings/settings.component.ts

import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { MatCardModule } from '@angular/material/card';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatSlideToggleModule } from '@angular/material/slide-toggle';
import { ToastrService } from 'ngx-toastr';
import { SoundService } from '../../../../core/services/sound.service';
import { AuthService, User } from '../../../../core/services/auth';

@Component({
  selector: 'app-settings',
  standalone: true,
  imports: [
    CommonModule,
    FormsModule,
    RouterModule,
    MatCardModule,
    MatButtonModule,
    MatIconModule,
    MatSlideToggleModule
  ],
  templateUrl: './settings.component.html',
  styleUrls: ['./settings.component.css']
})
export class SettingsComponent implements OnInit {
  
  isSoundEnabled: boolean = true;
  currentUser: User | null = null;

  constructor(
    private toastr: ToastrService,
    private soundService: SoundService,
    private authService: AuthService
  ) {}

  ngOnInit(): void {
    this.isSoundEnabled = this.soundService.isSoundEnabled();
    this.loadUserData();
  }

  /**
   * Charge les données de l'utilisateur connecté
   */
  loadUserData(): void {
    this.currentUser = this.authService.getCurrentUser();
    console.log('👤 Utilisateur chargé:', this.currentUser);
  }

  /**
   * Gère le changement du son
   */
  onSoundToggleChange(): void {
    this.soundService.setSoundEnabled(this.isSoundEnabled);
    
    if (this.isSoundEnabled) {
      setTimeout(() => {
        this.soundService.playNotificationSound();
      }, 100);
    }
    
    this.toastr.info(
      this.isSoundEnabled ? 'Sons activés' : 'Sons désactivés',
      'Notifications sonores',
      {
        positionClass: 'toast-top-right',
        timeOut: 2000,
        closeButton: true,
        progressBar: true
      }
    );
  }

  playTestSound(): void {
    this.soundService.playNotificationSound();
  }

  clearCache(): void {
    localStorage.removeItem('readAlerts');
    localStorage.removeItem('lastAlertNotification');
    this.toastr.success('Cache vidé avec succès', 'Cache vidé', {
      positionClass: 'toast-top-right',
      timeOut: 2000,
      closeButton: true,
      progressBar: true
    });
  }

  exportData(): void {
    const data = {
      user: {
        name: this.currentUser?.name,
        email: this.currentUser?.email,
        role: this.currentUser?.role,
        projet: this.currentUser?.projet,
        magasin: this.currentUser?.magasin
      },
      preferences: {
        soundEnabled: localStorage.getItem('soundEnabled'),
        itemsPerPage: localStorage.getItem('itemsPerPage')
      },
      exportDate: new Date().toISOString(),
      version: '2.0'
    };
    
    const blob = new Blob([JSON.stringify(data, null, 2)], { type: 'application/json' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = `soroubat_export_${new Date().toISOString().slice(0, 10)}.json`;
    a.click();
    URL.revokeObjectURL(url);
    
    this.toastr.success('Export terminé', 'Données exportées', {
      positionClass: 'toast-top-right',
      timeOut: 2000,
      closeButton: true,
      progressBar: true
    });
  }

  /**
   * Obtenir les initiales pour l'avatar
   */
  getUserInitials(): string {
    if (!this.currentUser?.name) return 'U';
    const names = this.currentUser.name.split(' ');
    if (names.length >= 2) {
      return (names[0][0] + names[1][0]).toUpperCase();
    }
    return this.currentUser.name.substring(0, 2).toUpperCase();
  }

  /**
   * Obtenir la couleur du rôle
   */
  getRoleColor(): string {
    switch (this.currentUser?.role) {
      case 'ADMIN': return '#ef4444';
      case 'RESPONSABLE': return '#f59e0b';
      case 'CHEF_CHANTIER': return '#10b981';
      default: return '#6366f1';
    }
  }
}