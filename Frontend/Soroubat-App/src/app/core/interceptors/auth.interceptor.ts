// src/app/core/interceptors/auth.interceptor.ts

import { Injectable } from '@angular/core';
import { HttpInterceptor, HttpRequest, HttpHandler, HttpEvent, HttpErrorResponse } from '@angular/common/http';
import { Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { AuthService } from '../services/auth';
import { Router } from '@angular/router';

@Injectable()
export class AuthInterceptor implements HttpInterceptor { 
  
  constructor(
    private authService: AuthService, 
    private router: Router
  ) {}
  
  intercept(req: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
    // Récupérer le token
    const token = this.authService.getToken();
    
  
    
    // Cloner la requête et ajouter le header Authorization
    let authReq = req;
    if (token) {
      authReq = req.clone({
        setHeaders: {
          'Authorization': `Bearer ${token}`,
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        }
      });
      console.log('✅ [Interceptor] Token ajouté à la requête');
    } else {
      console.warn('⚠️ [Interceptor] Aucun token trouvé');
    }
    
    // Gérer les erreurs 401 (non autorisé)
    return next.handle(authReq).pipe(
      catchError((error: HttpErrorResponse) => {
        console.error('❌ [Interceptor] Erreur HTTP:', error.status, error.statusText);
        
        // ✅ NE PAS déconnecter pour les erreurs 401 des endpoints de reconnaissance faciale
        const isFaceScanUrl = req.url.includes('/Attendance/scan-presence') || 
                              req.url.includes('/Employee/scan');
        
        if (error.status === 401 && isFaceScanUrl) {
          console.log(' [Interceptor] Échec de reconnaissance faciale - Pas de déconnexion');
          return throwError(() => error);
        }
        
        // ✅ Pour les autres erreurs 401, déconnecter
        if (error.status === 401) {
          console.warn(' [Interceptor] Token expiré ou invalide - Déconnexion');
          this.authService.logout();
          this.router.navigate(['/login']);
        }
        
        return throwError(() => error);
      })
    );
  }
}