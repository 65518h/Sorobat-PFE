// src/app/auth/login/login.ts
import { Component, OnInit, Inject, PLATFORM_ID, ChangeDetectorRef } from '@angular/core';
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
  loginForm!: FormGroup;
  hidePassword = true;
  isLoading = false;
  errorMessage = '';
  private isBrowser: boolean;

  // ✅ CONSTRUCTEUR SIMPLIFIÉ - SUR UNE SEULE LIGNE
  constructor(
    private fb: FormBuilder,
    private authService: AuthService,
    private router: Router,
    private cdr: ChangeDetectorRef,
    @Inject(PLATFORM_ID) private platformId: Object
  ) {
    this.isBrowser = isPlatformBrowser(this.platformId);
  }

  ngOnInit(): void {
    if (this.isBrowser && this.authService.isAuthenticated()) {
      this.router.navigate(['/dashboard']);
    }

    this.loginForm = this.fb.group({
      username: ['', [Validators.required, Validators.minLength(3)]],
      password: ['', [Validators.required, Validators.minLength(4)]],
      rememberMe: [false]
    });

    if (this.isBrowser) {
      const savedCredentials = localStorage.getItem('remembered_credentials');
      if (savedCredentials) {
        try {
          const { username, password } = JSON.parse(savedCredentials);
          this.loginForm.patchValue({ username, password, rememberMe: true });
        } catch (e) {
          console.error('Erreur de parsing localStorage', e);
        }
      }
    }
  }

  onSubmit(): void {
    if (this.loginForm.invalid) {
      this.markFormGroupTouched(this.loginForm);
      return;
    }

    this.isLoading = true;
    this.errorMessage = '';
    this.cdr.detectChanges();

    const { username, password, rememberMe } = this.loginForm.value;

    setTimeout(() => {
      const result = this.authService.login(username, password);
      
      if (result.success) {
        if (this.isBrowser && rememberMe) {
          localStorage.setItem('remembered_credentials', JSON.stringify({ username, password }));
        } else if (this.isBrowser) {
          localStorage.removeItem('remembered_credentials');
        }
        this.router.navigate(['/dashboard']);
      } else {
        this.isLoading = false;
        this.errorMessage = result.message || 'Nom d\'utilisateur ou mot de passe incorrect';
        this.cdr.detectChanges();
        this.shakeForm();
      }
    }, 1000);
  }

  private markFormGroupTouched(formGroup: FormGroup) {
    Object.values(formGroup.controls).forEach(control => {
      control.markAsTouched();
    });
  }

  private shakeForm(): void {
    const form = document.querySelector('form');
    form?.classList.add('shake');
    setTimeout(() => {
      form?.classList.remove('shake');
    }, 500);
  }

  setDemoCredentials(username: string, password: string): void {
    this.loginForm.patchValue({ username, password });
  }
}