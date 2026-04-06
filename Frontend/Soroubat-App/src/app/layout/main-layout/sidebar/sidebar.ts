import { Component, Input } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';

// Angular Material
import { MatListModule } from '@angular/material/list';
import { MatIconModule } from '@angular/material/icon';
import { MatDividerModule } from '@angular/material/divider';

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
export class SidebarComponent {
  @Input() class: string = '';
  
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
}