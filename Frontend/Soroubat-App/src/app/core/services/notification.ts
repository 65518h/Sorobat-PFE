// src/app/core/services/notification.service.ts

import { Injectable } from '@angular/core';
import { MatSnackBar, MatSnackBarConfig, MatSnackBarRef, SimpleSnackBar } from '@angular/material/snack-bar';
import { MatDialog } from '@angular/material/dialog';
import { Observable, map } from 'rxjs';

import { ConfirmationDialogComponent, ConfirmationDialogData } from '../components/confirmation-dialog/confirmation-dialog.component';

export interface NotificationOptions {
  duration?: number;
  action?: string;
  horizontalPosition?: 'start' | 'center' | 'end' | 'left' | 'right';
  verticalPosition?: 'top' | 'bottom';
  panelClass?: string | string[];
}

export interface ConfirmationOptions {
  title?: string;
  message: string;
  confirmText?: string;
  cancelText?: string;
  confirmColor?: 'primary' | 'accent' | 'warn';
  cancelColor?: 'primary' | 'accent' | 'warn' | 'basic';
  width?: string;
}

@Injectable({
  providedIn: 'root',
})
export class NotificationService {
  
  private defaultConfig: MatSnackBarConfig = {
    duration: 3000,
    horizontalPosition: 'end',
    verticalPosition: 'top',
    panelClass: ['notification-snackbar']
  };

  constructor(
    private snackBar: MatSnackBar,
    private dialog: MatDialog
  ) {}

  /**
   * Affiche une notification de succès
   */
  showSuccess(message: string, options?: NotificationOptions): MatSnackBarRef<SimpleSnackBar> {
    const config = this.getConfig(options, 'success');
    return this.snackBar.open(message, options?.action || 'Fermer', config);
  }

  /**
   * Affiche une notification d'erreur
   */
  showError(message: string, options?: NotificationOptions): MatSnackBarRef<SimpleSnackBar> {
    const config = this.getConfig(options, 'error');
    if (!options?.duration) {
      config.duration = 5000;
    }
    return this.snackBar.open(message, options?.action || 'Fermer', config);
  }

  /**
   * Affiche une notification d'avertissement
   */
  showWarning(message: string, options?: NotificationOptions): MatSnackBarRef<SimpleSnackBar> {
    const config = this.getConfig(options, 'warning');
    return this.snackBar.open(message, options?.action || 'Fermer', config);
  }

  /**
   * Affiche une notification d'information
   */
  showInfo(message: string, options?: NotificationOptions): MatSnackBarRef<SimpleSnackBar> {
    const config = this.getConfig(options, 'info');
    return this.snackBar.open(message, options?.action || 'Fermer', config);
  }

  /**
   *  CORRECTION: Affiche une boîte de dialogue de confirmation
   * Retourne un Observable<boolean> (false par défaut si undefined)
   */
  showConfirmation(options: ConfirmationOptions): Observable<boolean> {
    const dialogRef = this.dialog.open<ConfirmationDialogComponent, ConfirmationDialogData, boolean>(
      ConfirmationDialogComponent,
      {
        width: options.width || '400px',
        data: {
          title: options.title || 'Confirmation',
          message: options.message,
          confirmText: options.confirmText || 'Confirmer',
          cancelText: options.cancelText || 'Annuler',
          confirmColor: options.confirmColor || 'primary',
          cancelColor: options.cancelColor || 'basic'
        },
        disableClose: true
      }
    );

    //  Map undefined à false pour garantir un boolean
    return dialogRef.afterClosed().pipe(
      map(result => result === true)  // true si confirmé, false sinon
    );
  }

  /**
   * Alias pour showConfirmation
   */
  confirm(options: ConfirmationOptions): Observable<boolean> {
    return this.showConfirmation(options);
  }

  /**
   * Affiche une notification avec une action personnalisée
   */
  showWithAction(message: string, action: string, onAction: () => void, options?: NotificationOptions): void {
    const config = this.getConfig(options);
    const snackBarRef = this.snackBar.open(message, action, config);
    
    snackBarRef.onAction().subscribe(() => {
      onAction();
    });
  }

  /**
   * Affiche une notification avec une durée infinie
   */
  showPersistent(message: string, action: string = 'Fermer', options?: NotificationOptions): MatSnackBarRef<SimpleSnackBar> {
    const config = this.getConfig(options);
    config.duration = undefined;
    return this.snackBar.open(message, action, config);
  }

  /**
   * Ferme la notification actuelle
   */
  dismiss(): void {
    this.snackBar.dismiss();
  }

  // ==================== MÉTHODES PRIVÉES ====================

  private getConfig(options?: NotificationOptions, type?: 'success' | 'error' | 'warning' | 'info'): MatSnackBarConfig {
    const config: MatSnackBarConfig = {
      ...this.defaultConfig,
      ...options
    };
    
    if (type) {
      const typeClass = `notification-${type}`;
      if (config.panelClass) {
        if (Array.isArray(config.panelClass)) {
          config.panelClass = [...config.panelClass, typeClass];
        } else {
          config.panelClass = [config.panelClass, typeClass];
        }
      } else {
        config.panelClass = [typeClass];
      }
    }
    
    return config;
  }

  // ==================== ALIAS ====================

  success(message: string, options?: NotificationOptions): void {
    this.showSuccess(message, options);
  }

  error(message: string, options?: NotificationOptions): void {
    this.showError(message, options);
  }

  warning(message: string, options?: NotificationOptions): void {
    this.showWarning(message, options);
  }

  info(message: string, options?: NotificationOptions): void {
    this.showInfo(message, options);
  }
}