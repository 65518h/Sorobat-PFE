// src/app/core/services/auth.ts

import { Injectable, inject, PLATFORM_ID } from '@angular/core';
import { isPlatformBrowser } from '@angular/common';
import { Router } from '@angular/router';
import { BehaviorSubject } from 'rxjs';

export interface User {
  username: string;
  role: string;
  name: string;
  id?: string;           // ✅ Ajouter id pour compatibilité
  isApprover?: boolean;  // ✅ Ajouter isApprover pour compatibilité
}

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  
  private platformId = inject(PLATFORM_ID);
  private router = inject(Router);

  private isAuthenticatedSubject = new BehaviorSubject<boolean>(false);
  isAuthenticated$ = this.isAuthenticatedSubject.asObservable();
  private isBrowser: boolean;
  
  private mockUsers = [
    { username: 'chef', password: 'chef123', role: 'CHEF_CHANTIER', name: 'Chef de chantier', id: 'user-001', isApprover: false },
    { username: 'resp', password: 'resp123', role: 'RESPONSABLE', name: 'Responsable projet', id: 'user-002', isApprover: true },
    { username: 'admin', password: 'admin123', role: 'ADMIN', name: 'Administrateur', id: 'user-003', isApprover: true }
  ];

  constructor() {
    this.isBrowser = isPlatformBrowser(this.platformId);
    
    if (this.isBrowser) {
      this.isAuthenticatedSubject.next(this.hasToken());
    }
  }

  // ✅ IMPLÉMENTER getCurrentUser
  getCurrentUser(): User | null {
    return this.getUser();
  }

  login(username: string, password: string): { success: boolean; message?: string } {
    const user = this.mockUsers.find(
      u => u.username === username && u.password === password
    );

    if (user) {
      if (this.isBrowser) {
        localStorage.setItem('auth_token', 'fake-token-' + Date.now());
        localStorage.setItem('user', JSON.stringify({ 
          id: user.id,
          username: user.username, 
          role: user.role,
          name: user.name,
          isApprover: user.isApprover
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
  
  // ✅ Méthode utilitaire pour vérifier si l'utilisateur est approbateur
  isApprover(): boolean {
    const user = this.getUser();
    return user?.isApprover === true || user?.role === 'ADMIN' || user?.role === 'RESPONSABLE';
  }
  
  // ✅ Récupérer l'ID de l'utilisateur
  getUserId(): string {
    const user = this.getUser();
    return user?.id || user?.username || 'unknown';
  }
}