import { Injectable, inject, PLATFORM_ID } from '@angular/core'; // 1. On importe inject
import { isPlatformBrowser } from '@angular/common';
import { Router } from '@angular/router';
import { BehaviorSubject } from 'rxjs';

export interface User {
  username: string;
  role: string;
  name: string;
}

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  // 2. On utilise inject() pour récupérer PLATFORM_ID et Router
  private platformId = inject(PLATFORM_ID);
  private router = inject(Router);

  private isAuthenticatedSubject = new BehaviorSubject<boolean>(false);
  isAuthenticated$ = this.isAuthenticatedSubject.asObservable();
  private isBrowser: boolean;
  
  private mockUsers = [
    { username: 'chef', password: 'chef123', role: 'CHEF_CHANTIER', name: 'Chef de chantier' },
    { username: 'resp', password: 'resp123', role: 'RESPONSABLE', name: 'Responsable projet' },
    { username: 'admin', password: 'admin123', role: 'ADMIN', name: 'Administrateur' }
  ];

  constructor() {
    // 3. Le constructeur est maintenant vide de paramètres, ce qui élimine l'erreur TS1206
    this.isBrowser = isPlatformBrowser(this.platformId);
    
    if (this.isBrowser) {
      this.isAuthenticatedSubject.next(this.hasToken());
    }
  }

  // ... le reste de vos méthodes (login, logout, etc.) reste identique
  login(username: string, password: string): { success: boolean; message?: string } {
    const user = this.mockUsers.find(
      u => u.username === username && u.password === password
    );

    if (user) {
      if (this.isBrowser) {
        localStorage.setItem('auth_token', 'fake-token-' + Date.now());
        localStorage.setItem('user', JSON.stringify({ 
          username: user.username, 
          role: user.role,
          name: user.name
        }));
      }
      
      this.isAuthenticatedSubject.next(true);
      return { success: true };
    }
    
    return { success: false, message: 'Nom d\'utilisateur ou mot de passe incorrect' };
  }

  logout(): void {
    if (this.isBrowser) {
      localStorage.removeItem('auth_token');
      localStorage.removeItem('user');
    }
    this.isAuthenticatedSubject.next(false);
    this.router.navigate(['/auth/login']);
  }

  getToken(): string | null {
    return this.isBrowser ? localStorage.getItem('auth_token') : null;
  }

  getUser(): User | null {
    if (this.isBrowser) {
      const userStr = localStorage.getItem('user');
      return userStr ? JSON.parse(userStr) : null;
    }
    return null;
  }

  getUserName(): string {
    const user = this.getUser();
    return user?.name || user?.username || 'Utilisateur';
  }

  private hasToken(): boolean {
    return !!this.getToken();
  }

  isAuthenticated(): boolean {
    return this.hasToken();
  }

  hasRole(role: string): boolean {
    const user = this.getUser();
    return user?.role === role;
  }
}