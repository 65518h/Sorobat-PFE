
import { Component, Output, EventEmitter, Input } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { AuthService } from '../../../core/services/auth';

// Angular Material
import { MatToolbarModule } from '@angular/material/toolbar';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatMenuModule } from '@angular/material/menu';
import { MatBadgeModule } from '@angular/material/badge';
import { MatTooltipModule } from '@angular/material/tooltip';
import { MatDividerModule } from '@angular/material/divider';


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
    MatTooltipModule
  ],
  templateUrl: './navbar.html',
  styleUrls: ['./navbar.css']
})
export class NavbarComponent {

  @Input() isSidebarOpen: boolean = true;  
  
  @Output() menuToggle = new EventEmitter<void>();
  
  // Propriétés pour les animations
  isRotating = false;
  isSpinning = false;

  constructor(public authService: AuthService) {}

  get userName(): string {
    return this.authService.getUserName();
  }

  toggleMenu(): void {
    // Déclencher les animations
    this.isRotating = true;
    this.isSpinning = true;
    
    // Arrêter l'animation de rotation après 1 seconde
    setTimeout(() => {
      this.isSpinning = false;
    }, 1000);
    
    this.menuToggle.emit();
  }

  logout(): void {
    this.authService.logout();
  }
}


