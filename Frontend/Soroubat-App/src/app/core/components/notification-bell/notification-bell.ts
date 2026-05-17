// src/app/core/components/notification-bell/notification-bell.component.ts

import { Component, OnInit, OnDestroy, ChangeDetectionStrategy, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MatIconModule } from '@angular/material/icon';
import { MatButtonModule } from '@angular/material/button';
import { MatTooltipModule } from '@angular/material/tooltip';
import { MatBadgeModule } from '@angular/material/badge';
import { MatDialog } from '@angular/material/dialog';
import { Subject, takeUntil } from 'rxjs';
import { AlertService } from '../../services/alert.service';
import { NotificationDialogComponent } from '../notification-dialog/notification-dialog.component';

@Component({
  selector: 'app-notification-bell',
  standalone: true,
  imports: [
    CommonModule,
    MatIconModule,
    MatButtonModule,
    MatTooltipModule,
    MatBadgeModule
  ],
  templateUrl: './notification-bell.html',
  styleUrls: ['./notification-bell.css'],
  changeDetection: ChangeDetectionStrategy.OnPush  // ✅ Ajouter ceci
})
export class NotificationBellComponent implements OnInit, OnDestroy {
  
  unreadCount = { critical: 0, warning: 0, info: 0, total: 0 };
  private destroy$ = new Subject<void>();

  constructor(
    private alertService: AlertService,
    private dialog: MatDialog,
    private cdr: ChangeDetectorRef  // ✅ Ajouter ChangeDetectorRef
  ) {}

  ngOnInit(): void {
    // ✅ Utiliser setTimeout pour éviter ExpressionChangedError
    setTimeout(() => {
      const initialCounts = this.alertService.getUnreadCount();
      this.unreadCount = {
        critical: initialCounts.critical || 0,
        warning: initialCounts.warning || 0,
        info: initialCounts.info || 0,
        total: (initialCounts.critical || 0) + (initialCounts.warning || 0) + (initialCounts.info || 0)
      };
      this.cdr.detectChanges();
    });
    
    this.alertService.alerts$
      .pipe(takeUntil(this.destroy$))
      .subscribe(() => {
        // ✅ Exécuter dans setTimeout pour éviter ExpressionChangedError
        setTimeout(() => {
          const counts = this.alertService.getUnreadCount();
          this.unreadCount = {
            critical: counts.critical || 0,
            warning: counts.warning || 0,
            info: counts.info || 0,
            total: (counts.critical || 0) + (counts.warning || 0) + (counts.info || 0)
          };
          this.cdr.detectChanges();
        });
      });
  }

  ngOnDestroy(): void {
    this.destroy$.next();
    this.destroy$.complete();
  }

  openNotificationDialog(): void {
    this.dialog.open(NotificationDialogComponent, {
      width: '700px',
      maxWidth: '90vw',
      panelClass: 'notification-dialog-panel',
      backdropClass: 'cdk-overlay-dark-backdrop',
      autoFocus: false
    });
  }
}