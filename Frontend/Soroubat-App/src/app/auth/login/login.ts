// auth/login/login.component.ts
import { Component, OnInit, Inject, PLATFORM_ID, inject } from '@angular/core';
import { CommonModule, isPlatformBrowser } from '@angular/common';
import { FormBuilder, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { AuthService } from '../../core/services/auth';

// Angular Material
import { MatCardModule } from '@angular/material/card';
import { MatInputModule } from '@angular/material/input';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { MatDividerModule } from '@angular/material/divider';
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
    MatDividerModule,
    MatCheckboxModule
  ],
  templateUrl: './login.html',
  styleUrls: ['./login.css']
})


export class LoginComponent implements OnInit {
  // Remplacez les injections du constructeur par ceci :
  private platformId = inject(PLATFORM_ID);
  private fb = inject(FormBuilder);
  private authService = inject(AuthService);
  private router = inject(Router);

  private isBrowser: boolean;
  loginForm!: FormGroup;
  hidePassword = true;
  isLoading = false;
  errorMessage = '';

  constructor() {
    // Le constructeur devient beaucoup plus propre
    this.isBrowser = isPlatformBrowser(this.platformId);
  }
  // ... reste du code

  ngOnInit(): void {
    // Vérifier l'authentification UNIQUEMENT côté navigateur
    if (this.isBrowser && this.authService.isAuthenticated()) {
      this.router.navigate(['/dashboard']);
    }

    this.loginForm = this.fb.group({
      username: ['', [Validators.required, Validators.minLength(3)]],
      password: ['', [Validators.required, Validators.minLength(4)]],
      rememberMe: [false]
    });

    // Charger les identifiants sauvegardés UNIQUEMENT côté navigateur
    if (this.isBrowser) {
      const savedCredentials = localStorage.getItem('remembered_credentials');
      if (savedCredentials) {
        const { username, password } = JSON.parse(savedCredentials);
        this.loginForm.patchValue({ username, password, rememberMe: true });
      }
    }
  }

  onSubmit(): void {
    if (this.loginForm.invalid) return;

    this.isLoading = true;
    this.errorMessage = '';

    const { username, password, rememberMe } = this.loginForm.value;

    // Gérer "Se souvenir de moi" UNIQUEMENT côté navigateur
    if (this.isBrowser && rememberMe) {
      localStorage.setItem('remembered_credentials', JSON.stringify({ username, password }));
    } else if (this.isBrowser) {
      localStorage.removeItem('remembered_credentials');
    }

    setTimeout(() => {
      const result = this.authService.login(username, password);
      this.isLoading = false;

      if (result.success) {
        this.router.navigate(['/dashboard']);
      } else {
        this.errorMessage = result.message || 'Erreur de connexion';
      }
    }, 1000);
  }

  setDemoCredentials(username: string, password: string): void {
    this.loginForm.patchValue({ username, password });
  }
}