// src/app/core/services/auth.ts

import { Injectable, inject, PLATFORM_ID } from '@angular/core';
import { isPlatformBrowser } from '@angular/common';
import { Router } from '@angular/router';
import { BehaviorSubject, Observable, throwError, of } from 'rxjs';
import { catchError, map, tap, switchMap, timeout } from 'rxjs/operators';
import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { LookupService } from '../../models/inventory/services/lookup.service';
import { ToastrService } from 'ngx-toastr';

// Importer les services offline
import { OfflineSyncService } from './offline-sync.service';
import { CacheService } from './cache.service';
import { ProjectService } from '../../models/projects/services/project';
import { JobTaskService } from '../../models/tasks/services/job-task';
import { AttendanceService } from '../../models/attendance/services/attendance.service';

export interface User {
  id?: string;
  username: string;
  email?: string;
  role: string;
  name: string;
  isApprover?: boolean;
  token?: string;
  projet?: string;
  projetDescription?: string;
  magasin?: string;
  lastLogin?: string;
  offlineSessionValid?: boolean;
}

export interface LoginResponse {
  token: string;
}

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  
  private platformId = inject(PLATFORM_ID);
  private router = inject(Router);
  private http = inject(HttpClient);
  private lookupService = inject(LookupService);
  private offlineSync = inject(OfflineSyncService);
  private cacheService = inject(CacheService);
  private toastr = inject(ToastrService);
  private projectService = inject(ProjectService);
  private jobTaskService = inject(JobTaskService);
  private attendanceService = inject(AttendanceService);
  
  private apiUrl = 'http://localhost:5227/api';
  
  private isAuthenticatedSubject = new BehaviorSubject<boolean>(false);
  isAuthenticated$ = this.isAuthenticatedSubject.asObservable();
  
  private currentUserSubject = new BehaviorSubject<User | null>(null);
  currentUser$ = this.currentUserSubject.asObservable();
  
  private isBrowser: boolean;
  private readonly OFFLINE_SESSION_VALIDITY_DAYS = 7;

  constructor() {
    this.isBrowser = isPlatformBrowser(this.platformId);
  }

  private saveOfflineSession(user: User): void {
    if (!this.isBrowser) return;
    
    const sessionData = {
      ...user,
      offlineSessionValid: true,
      lastLogin: new Date().toISOString()
    };
    
    localStorage.setItem('user', JSON.stringify(sessionData));
    localStorage.setItem('offline_session_valid', 'true');
    localStorage.setItem('last_login', new Date().toISOString());
    
    if (user.token) {
      localStorage.setItem('auth_token', user.token);
    }
    
    console.log(' Session offline sauvegardée');
  }
  
  private clearOfflineSession(): void {
    if (!this.isBrowser) return;
    localStorage.removeItem('offline_session_valid');
    localStorage.removeItem('last_login');
    console.log(' Session offline effacée');
  }

  hasValidOfflineSession(): boolean {
    if (!this.isBrowser) return false;
    
    let token = this.getToken();
    const user = this.getUser();
    
    if (!token && user && user.token) {
      console.log(' Restauration automatique du token');
      localStorage.setItem('auth_token', user.token);
      token = user.token;
      localStorage.setItem('offline_session_valid', 'true');
    }
    
    const offlineSessionValid = localStorage.getItem('offline_session_valid') === 'true';
    const lastLogin = localStorage.getItem('last_login');
    
    if (!token || !user || !offlineSessionValid) {
      return false;
    }
    
    if (lastLogin) {
      const lastLoginDate = new Date(lastLogin);
      const now = new Date();
      const daysDiff = (now.getTime() - lastLoginDate.getTime()) / (1000 * 3600 * 24);
      if (daysDiff > this.OFFLINE_SESSION_VALIDITY_DAYS) {
        console.log(` Session offline expirée (${daysDiff.toFixed(0)} jours)`);
        return false;
      }
    }
    
    return true;
  }

  hasOfflineSession(): boolean {
    return this.hasValidOfflineSession();
  }

  canLogout(): boolean {
    return true;
  }

  async preloadDataForOffline(): Promise<void> {
    if (!this.isBrowser) return;
    
    console.log(' Préchargement des données pour mode offline...');
    
    try {
      await this.cacheService.getOrFetch('my-stock', `${this.apiUrl}/Stock/my-stock`, true).toPromise();
      console.log(' Stock préchargé');
    } catch (error) {
      console.warn(' Échec préchargement stock:', error);
    }
    
    try {
      await this.cacheService.getOrFetch('my-pointages', `${this.apiUrl}/VehiculePointage`, true).toPromise();
      console.log(' Pointages préchargés');
    } catch (error) {
      console.warn(' Échec préchargement pointages:', error);
    }
    
    try {
      await this.attendanceService.preloadForOffline();
      console.log(' Pointages employés préchargés');
    } catch (error) {
      console.warn(' Échec préchargement attendance:', error);
    }
    
    try {
      await this.jobTaskService.preloadForOffline();
      console.log(' Tâches préchargées');
    } catch (error) {
      console.warn(' Échec préchargement tâches:', error);
    }
    
    try {
      await this.projectService.preloadForOffline();
      console.log(' Projet préchargé');
    } catch (error) {
      console.warn(' Échec préchargement projet:', error);
    }
    
    console.log(' Préchargement terminé');
  }

  /**
   * Connexion - Retourne l'erreur originale HttpErrorResponse
   */
  login(email: string, password: string): Observable<LoginResponse> {
    const loginData = { email, password };
    
    console.log('1. Tentative de connexion avec:', email);
    
    // MODE OFFLINE : Connexion avec session sauvegardée
    if (!this.offlineSync.isOnline && this.hasValidOfflineSession()) {
      console.log(' Mode offline - Connexion avec session sauvegardée');
      
      const savedUser = this.getUser();
      if (savedUser && savedUser.email === email) {
        this.isAuthenticatedSubject.next(true);
        this.currentUserSubject.next(savedUser);
        return of({ token: this.getToken() || '' }).pipe(
          tap(() => console.log(' Connexion offline réussie'))
        );
      } else if (savedUser && savedUser.email !== email) {
        const error = new HttpErrorResponse({
          status: 401,
          statusText: 'Unauthorized',
          error: { message: 'Email non trouvé dans la session offline' }
        });
        return throwError(() => error);
      }
    }
    
    // MODE ONLINE
    return this.http.post<LoginResponse>(`${this.apiUrl}/auth/login`, loginData)
      .pipe(
        timeout(10000),
        tap(response => console.log('2. Réponse login:', response)),
        switchMap(response => {
          if (response && response.token) {
            console.log('3. Token reçu');
            
            if (this.isBrowser) {
              localStorage.setItem('auth_token', response.token);
              console.log(' Token sauvegardé');
            }
            
            const decodedToken = this.decodeToken(response.token);
            console.log('4. Token décodé:', decodedToken);
            
            const projetNo = decodedToken?.projectNo || '';
            
            return this.lookupService.getChefChantierByEmail(email).pipe(
              map(chefInfo => {
                console.log('5. ChefInfo reçu du Lookup:', chefInfo);
                
                const userName = chefInfo?.nomEtPrenom || email.split('@')[0];
                const user = this.buildUser(decodedToken, email, response.token, projetNo, userName);
                console.log('6. Utilisateur construit:', user);
                
                if (this.isBrowser) {
                  this.saveOfflineSession(user);
                  localStorage.setItem('auth_token', response.token);
                  console.log('7. Session offline sauvegardée');
                }
                
                this.isAuthenticatedSubject.next(true);
                this.currentUserSubject.next(user);
                this.preloadDataForOffline();
                
                return response;
              }),
              catchError(error => {
                console.error(' Erreur Lookup, construction utilisateur sans nom:', error);
                const userName = email.split('@')[0];
                const user = this.buildUser(decodedToken, email, response.token, projetNo, userName);
                
                if (this.isBrowser) {
                  this.saveOfflineSession(user);
                  localStorage.setItem('auth_token', response.token);
                }
                
                this.isAuthenticatedSubject.next(true);
                this.currentUserSubject.next(user);
                this.preloadDataForOffline();
                
                return of(response);
              })
            );
          }
          return of(response);
        }),
        catchError(error => {
          console.error(' Erreur de connexion:', error);
          
          // Vérifier si on peut utiliser la session offline
          if ((error.status === 0 || error.status === 504) && this.hasValidOfflineSession()) {
            console.log(' API inaccessible - Utilisation de la session offline');
            const savedUser = this.getUser();
            if (savedUser) {
              this.isAuthenticatedSubject.next(true);
              this.currentUserSubject.next(savedUser);
              return of({ token: this.getToken() || '' });
            }
          }
          
          // Nettoyer les données en cas d'erreur
          if (this.isBrowser) {
            localStorage.removeItem('auth_token');
            localStorage.removeItem('user');
            localStorage.removeItem('remembered_credentials');
            this.clearOfflineSession();
          }
          
          //  Retourner l'erreur ORIGINALE pour garder le status HTTP
          if (error instanceof HttpErrorResponse) {
            return throwError(() => error);
          }
          
          // Si ce n'est pas une HttpErrorResponse, créer une erreur standard
          const errorMessage = error.error?.message || error.message || 'Email ou mot de passe incorrect.';
          return throwError(() => new Error(errorMessage));
        })
      );
  }

  private buildUser(
    decodedToken: any,
    email: string,
    token: string,
    projetNo: string,
    userName: string
  ): User {
    let role = 'USER';
    let isApprover = false;
    
    if (email.includes('responsable')) {
      role = 'RESPONSABLE';
      isApprover = true;
    } else if (email.includes('admin')) {
      role = 'ADMIN';
      isApprover = true;
    } else {
      role = 'CHEF_CHANTIER';
      isApprover = false;
    }
    
    return {
      id: decodedToken?.sub || decodedToken?.jti || email,
      username: email,
      email: email,
      role: role,
      name: userName,
      isApprover: isApprover,
      token: token,
      projet: projetNo,
      magasin: '',
      lastLogin: new Date().toISOString(),
      offlineSessionValid: true
    };
  }

  private decodeToken(token: string): any {
    try {
      const payload = token.split('.')[1];
      return JSON.parse(atob(payload));
    } catch (e) {
      console.error('Erreur de décodage du token', e);
      return null;
    }
  }

  public isTokenExpired(token: string): boolean {
    try {
      const decoded = this.decodeToken(token);
      if (!decoded || !decoded.exp) return true;
      const expirationDate = new Date(decoded.exp * 1000);
      return expirationDate < new Date();
    } catch (e) {
      return true;
    }
  }

  logout(): void {
    console.log(' Déconnexion');
    console.log(' État connectivité:', this.offlineSync.isOnline ? 'En ligne' : 'Hors ligne');
    
    if (this.isBrowser) {
      localStorage.removeItem('auth_token');
      localStorage.removeItem('remembered_credentials');
    }
    
    this.isAuthenticatedSubject.next(false);
    this.currentUserSubject.next(null);
    this.router.navigate(['/auth/login']);
  }

  fullLogout(): void {
    console.log(' Déconnexion complète - Suppression de la session offline');
    
    if (this.isBrowser) {
      localStorage.removeItem('auth_token');
      localStorage.removeItem('user');
      localStorage.removeItem('remembered_credentials');
      this.clearOfflineSession();
    }
    
    this.isAuthenticatedSubject.next(false);
    this.currentUserSubject.next(null);
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

  getCurrentUser(): User | null {
    return this.getUser();
  }

  getUserName(): string {
    const user = this.getUser();
    return user?.name || user?.username || 'Utilisateur';
  }

  isAuthenticated(): boolean {
    if (!this.isBrowser) return false;
    const token = this.getToken();
    
    if (!this.offlineSync.isOnline && this.hasValidOfflineSession()) {
      return true;
    }
    
    return !!token && !this.isTokenExpired(token);
  }

  hasRole(role: string): boolean {
    const user = this.getUser();
    return user?.role === role;
  }

  isApprover(): boolean {
    const user = this.getUser();
    return user?.isApprover === true;
  }

  getUserId(): string {
    const user = this.getUser();
    return user?.id || user?.username || 'unknown';
  }
  
  getEmail(): string {
    const user = this.getUser();
    return user?.email || user?.username || '';
  }

  getProjet(): string {
    const user = this.getUser();
    return user?.projet || '';
  }

  getMagasin(): string {
    const user = this.getUser();
    return user?.magasin || '';
  }
}