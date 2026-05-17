// src/app/auth/login/login.component.ts

import {
  Component,
  OnInit,
  OnDestroy,
  Inject,
  PLATFORM_ID,
  ChangeDetectorRef
} from '@angular/core';
import { CommonModule, isPlatformBrowser } from '@angular/common';
import {
  FormBuilder,
  FormGroup,
  ReactiveFormsModule,
  Validators
} from '@angular/forms';
import { Router } from '@angular/router';
import { AuthService } from '../../core/services/auth';
import { OfflineSyncService } from '../../core/services/offline-sync.service';
import { ToastrService } from 'ngx-toastr';
import { HttpErrorResponse } from '@angular/common/http';

// Angular Material
import { MatCardModule } from '@angular/material/card';
import { MatInputModule } from '@angular/material/input';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';

import { Subject, takeUntil } from 'rxjs';

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
    MatProgressSpinnerModule
  ],
  templateUrl: './login.html',
  styleUrls: ['./login.css']
})
export class LoginComponent implements OnInit, OnDestroy {

  loginForm!: FormGroup;
  hidePassword = true;
  isLoading = false;
  errorMessage = '';
  loadingMessage = '';
  
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
    this.isOffline = !this.offlineSync.isOnline;
    this.hasOfflineSession = this.authService.hasValidOfflineSession();
    
    console.log('🔍 État initial:', {
      isOffline: this.isOffline,
      hasOfflineSession: this.hasOfflineSession,
      token: !!this.authService.getToken(),
      user: !!this.authService.getUser()
    });
    
    this.loadLastLoginDate();
    this.loadSavedCredentials();
    
    this.offlineSync.isOnline$
      .pipe(takeUntil(this.destroy$))
      .subscribe(online => {
        this.isOffline = !online;
        this.hasOfflineSession = this.authService.hasValidOfflineSession();
        console.log('📡 Connectivité changée:', { online, hasOfflineSession: this.hasOfflineSession });
        this.cdr.detectChanges();
        
        if (online && !this.isLoading) {
          this.toastr.info('📡 Connexion internet rétablie', 'Mode en ligne', {
            positionClass: 'toast-top-right',
            timeOut: 3000
          });
        }
      });
    
    // ✅ SUPPRIMER LA REDIRECTION AUTOMATIQUE
    // La redirection est maintenant gérée par le AuthGuard
    // L'utilisateur doit cliquer sur "Se connecter" même s'il a un token

    this.loginForm = this.fb.group({
      email: ['', [Validators.required, Validators.email]],
      password: ['', [Validators.required, Validators.minLength(4)]]
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
        console.log('📱 Email pré-rempli avec la session offline:', savedUser.email);
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
      console.log('📅 Dernière connexion:', this.lastLoginDate);
    }
  }

  private loadSavedCredentials(): void {
    if (!this.isBrowser) return;
    
    const savedEmail = localStorage.getItem('remembered_email');
    const savedRemember = localStorage.getItem('remember_me');
    
    this.hasSavedCredentials = !!savedEmail;
    this.rememberMe = savedRemember === 'true';
  }

  onSubmit(): void {
    this.errorMessage = '';
    this.offlineAttempt = false;
    
    if (this.loginForm.invalid) {
      this.markAllAsTouched();
      return;
    }

    const { email, password } = this.loginForm.value;

    // ✅ MODE OFFLINE - Connexion avec session sauvegardée
    if (this.isOffline && this.hasOfflineSession) {
      console.log('📱 Mode offline - Connexion hors ligne');
      
      const savedUser = this.authService.getUser();
      if (savedUser && savedUser.email === email) {
        this.isLoading = true;
        this.loadingMessage = 'Connexion hors ligne en cours...';
        this.cdr.detectChanges();
        
        setTimeout(() => {
          this.isLoading = false;
          (this.authService as any).isAuthenticatedSubject.next(true);
          (this.authService as any).currentUserSubject.next(savedUser);
          
          this.toastr.success('Connecté en mode hors ligne avec les données en cache', 'Connexion réussie', {
            positionClass: 'toast-top-right',
            timeOut: 4000,
            progressBar: true
          });
          
          this.router.navigate(['/dashboard']);
        }, 500);
        return;
      } else {
        this.errorMessage = 'Email non reconnu pour la connexion hors ligne';
        this.cdr.detectChanges();
        return;
      }
    }
    
    // ✅ Vérification mode offline sans session
    if (this.isOffline && !this.hasOfflineSession) {
      this.offlineAttempt = true;
      this.errorMessage = 'Mode hors ligne - Aucune session sauvegardée. Veuillez vous connecter en ligne une première fois.';
      this.cdr.detectChanges();
      return;
    }

    // ✅ MODE EN LIGNE
    this.loadingMessage = 'Connexion en cours...';
    this.isLoading = true;
    this.cdr.detectChanges();

    this.authService.login(email, password).subscribe({
      next: () => {
        this.isLoading = false;
        this.hasOfflineSession = this.authService.hasValidOfflineSession();
        this.toastr.success('Bienvenue sur votre tableau de bord', 'Connexion réussie');
        this.router.navigate(['/dashboard']);
      },
      error: (err: any) => {
        this.isLoading = false;
        this.loadingMessage = '';
        
        const errorMessage = err?.error?.message || err?.message || '';
        const status = err instanceof HttpErrorResponse ? err.status : 0;
        
        if (errorMessage?.includes('offline') || errorMessage?.includes('hors ligne')) {
          this.errorMessage = 'Mode hors ligne - Session non disponible. Connectez-vous en ligne.';
          this.offlineAttempt = true;
        } else if (status === 0 || errorMessage?.includes('Network') || errorMessage?.includes('net::ERR')) {
          this.errorMessage = 'Serveur inaccessible. Vérifiez votre connexion internet.';
        } else {
          this.errorMessage = errorMessage || 'Email ou mot de passe incorrect';
        }
        
        this.cdr.detectChanges();
        this.toastr.error(this.errorMessage, 'Erreur de connexion', {
          positionClass: 'toast-top-right',
          timeOut: 5000,
          closeButton: true
        });
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