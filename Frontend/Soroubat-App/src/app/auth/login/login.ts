// src/app/auth/login/login.component.ts

import { Component, OnInit, OnDestroy, Inject, PLATFORM_ID, ChangeDetectorRef } from '@angular/core';
import { CommonModule, isPlatformBrowser } from '@angular/common';
import { FormBuilder, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { AuthService } from '../../core/services/auth';
import { OfflineSyncService } from '../../core/services/offline-sync.service';
import { ToastrService } from 'ngx-toastr';
import { HttpErrorResponse } from '@angular/common/http';
import { Subject, takeUntil } from 'rxjs';

// Angular Material
import { MatCardModule } from '@angular/material/card';
import { MatInputModule } from '@angular/material/input';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { MatCheckboxModule } from '@angular/material/checkbox';

@Component({
  selector: 'app-login',
  standalone: true,
  imports: [
    CommonModule,
    ReactiveFormsModule,
    MatCardModule,
    MatInputModule,
    MatButtonModule,
    MatIconModule,
    MatProgressSpinnerModule,
    MatCheckboxModule
  ],
  templateUrl: './login.html',
  styleUrls: ['./login.css']
})
export class LoginComponent implements OnInit, OnDestroy {

  loginForm!: FormGroup;
  hidePassword = true;
  isLoading = false;
  errorMessage = '';
  errorTitle = '';
  
  isOffline = false;
  hasOfflineSession = false;
  offlineAttempt = false;
  lastLoginDate: Date | null = null;
  hasSavedCredentials = false;
  rememberMe = false;

  private isBrowser: boolean;
  private destroy$ = new Subject<void>();

  constructor(
    private fb: FormBuilder,
    private authService: AuthService,
    private offlineSync: OfflineSyncService,
    private router: Router,
    private cdr: ChangeDetectorRef,
    private toastr: ToastrService,
    @Inject(PLATFORM_ID) private platformId: Object
  ) {
    this.isBrowser = isPlatformBrowser(this.platformId);
  }

  ngOnInit(): void {
    this.loginForm = this.fb.group({
      email: ['', [Validators.required, Validators.email]],
      password: ['', [Validators.required, Validators.minLength(4)]]
    });
    
    this.isOffline = !this.offlineSync.isOnline;
    this.hasOfflineSession = this.authService.hasValidOfflineSession();
    
    console.log(' État initial:', {
      isOffline: this.isOffline,
      hasOfflineSession: this.hasOfflineSession
    });
    
    this.loadLastLoginDate();
    this.loadSavedCredentials();
    
    this.offlineSync.isOnline$
      .pipe(takeUntil(this.destroy$))
      .subscribe(online => {
        this.isOffline = !online;
        this.hasOfflineSession = this.authService.hasValidOfflineSession();
        console.log(' Connectivité changée:', { online, hasOfflineSession: this.hasOfflineSession });
        this.cdr.detectChanges();
      });
    
    if (this.hasSavedCredentials) {
      const savedEmail = localStorage.getItem('remembered_email');
      if (savedEmail) {
        this.loginForm.patchValue({ email: savedEmail });
      }
    }
    
    if (this.hasOfflineSession) {
      const savedUser = this.authService.getUser();
      if (savedUser && savedUser.email) {
        this.loginForm.patchValue({ email: savedUser.email });
      }
    }
  }

  ngOnDestroy(): void {
    this.destroy$.next();
    this.destroy$.complete();
  }

  private loadLastLoginDate(): void {
    if (!this.isBrowser) return;
    const lastLogin = localStorage.getItem('last_login');
    if (lastLogin) {
      this.lastLoginDate = new Date(lastLogin);
    }
  }

  private loadSavedCredentials(): void {
    if (!this.isBrowser) return;
    const savedEmail = localStorage.getItem('remembered_email');
    const savedRemember = localStorage.getItem('remember_me');
    this.hasSavedCredentials = !!savedEmail;
    this.rememberMe = savedRemember === 'true';
  }

  private showMessage(type: 'success' | 'error' | 'warning' | 'info', message: string, title: string, duration: number = 5000): void {
    setTimeout(() => {
      this.toastr.clear();
      const options = {
        positionClass: 'toast-top-right',
        timeOut: duration,
        progressBar: true,
        closeButton: true,
        enableHtml: true
      };
      
      switch (type) {
        case 'success': this.toastr.success(message, title, options); break;
        case 'error': this.toastr.error(message, title, options); break;
        case 'warning': this.toastr.warning(message, title, options); break;
        case 'info': this.toastr.info(message, title, options); break;
      }
      this.cdr.detectChanges();
    }, 10);
  }

  onSubmit(): void {
    this.errorMessage = '';
    this.errorTitle = '';
    this.offlineAttempt = false;
    
    if (this.loginForm.invalid) {
      this.markAllAsTouched();
      
      if (!this.loginForm.get('email')?.value) {
        this.showMessage('warning', 'Veuillez saisir votre adresse email', 'Champ requis', 3000);
      } else if (!this.loginForm.get('password')?.value) {
        this.showMessage('warning', 'Veuillez saisir votre mot de passe', 'Champ requis', 3000);
      }
      return;
    }

    const { email, password } = this.loginForm.value;

    // Mode offline avec session
    if (this.isOffline && this.hasOfflineSession) {
      const savedUser = this.authService.getUser();
      if (savedUser && savedUser.email === email) {
        this.isLoading = true;
        this.cdr.detectChanges();
        
        setTimeout(() => {
          this.isLoading = false;
          (this.authService as any).isAuthenticatedSubject.next(true);
          (this.authService as any).currentUserSubject.next(savedUser);
          this.showMessage('success', ` Bienvenue ${savedUser.name} !<br>Connecté en mode hors ligne.`, 'Connexion réussie', 5000);
          this.router.navigate(['/dashboard']);
        }, 500);
        return;
      } else {
        this.errorMessage = 'Email non reconnu pour la connexion hors ligne';
        this.showMessage('error', ' Cet email ne correspond à aucune session sauvegardée.<br>Veuillez vous connecter en ligne.', 'Connexion hors ligne impossible', 6000);
        this.cdr.detectChanges();
        return;
      }
    }
    
    // Mode offline sans session
    if (this.isOffline && !this.hasOfflineSession) {
      this.offlineAttempt = true;
      this.errorMessage = 'Mode hors ligne - Aucune session sauvegardée';
      this.showMessage('warning', ' Aucune session hors ligne disponible.<br><br>Connectez-vous en ligne une première fois pour créer une session hors ligne.', 'Mode hors ligne', 7000);
      this.cdr.detectChanges();
      return;
    }

    // Mode en ligne
    this.isLoading = true;
    this.cdr.detectChanges();

    this.authService.login(email, password).subscribe({
      next: (response) => {
        this.isLoading = false;
        this.hasOfflineSession = this.authService.hasValidOfflineSession();
        const savedUser = this.authService.getUser();
        const userName = savedUser?.name || email.split('@')[0];
        this.showMessage('success', ` Connexion réussie !<br>Bienvenue ${userName}.`, 'Bienvenue', 4000);
        this.router.navigate(['/dashboard']);
        this.cdr.detectChanges();
      },
      error: (err: HttpErrorResponse) => {
        this.isLoading = false;
        this.cdr.detectChanges();
        
        let backendMessage = '';
        let errorTitle = 'Erreur de connexion';
        let errorType: 'error' | 'warning' = 'error';
        
        // Extraire le message du backend
        let errorBody = err.error;
        if (typeof errorBody === 'string') {
          try {
            errorBody = JSON.parse(errorBody);
          } catch {
            errorBody = { message: errorBody };
          }
        }
        
        const errorMessage = errorBody?.message || '';
        
        console.log(' Statut:', err.status);
        console.log(' Message backend:', errorMessage);
        
        if (err.status === 401) {
          backendMessage = errorMessage || 'Email ou mot de passe incorrect.';
          errorTitle = 'Identifiants incorrects';
          errorType = 'error';
        } 
        else if (err.status === 403) {
          backendMessage = errorMessage || 'Accès refusé. Contactez votre administrateur.';
          if (backendMessage.includes('désactivé')) {
            errorTitle = 'Compte désactivé';
          } else if (backendMessage.includes('aucun projet')) {
            errorTitle = 'Aucun projet assigné';
          } else {
            errorTitle = 'Accès refusé';
          }
          errorType = 'warning';
        }
        else if (err.status === 0 || err.message?.includes('Network')) {
          backendMessage = 'Le serveur est inaccessible. Veuillez vérifier votre connexion.';
          errorTitle = 'Serveur indisponible';
          errorType = 'warning';
        }
        else {
          backendMessage = errorMessage || 'Une erreur est survenue. Veuillez réessayer.';
          errorTitle = 'Erreur';
          errorType = 'error';
        }
        
        this.errorMessage = backendMessage;
        this.errorTitle = errorTitle;
        this.showMessage(errorType, backendMessage, errorTitle, 6000);
        this.cdr.detectChanges();
      }
    });
  }

  private markAllAsTouched(): void {
    Object.values(this.loginForm.controls).forEach(c => c.markAsTouched());
  }

  getFormattedLastLogin(): string {
    if (!this.lastLoginDate) return '';
    return this.lastLoginDate.toLocaleDateString('fr-FR', {
      day: '2-digit',
      month: '2-digit',
      year: 'numeric',
      hour: '2-digit',
      minute: '2-digit'
    });
  }
}