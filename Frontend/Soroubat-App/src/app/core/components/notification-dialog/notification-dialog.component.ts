// src/app/core/components/notification-dialog/notification-dialog.component.ts

import { Component, Inject, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MAT_DIALOG_DATA, MatDialogRef, MatDialogModule } from '@angular/material/dialog';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatDividerModule } from '@angular/material/divider';
import { MatTooltipModule } from '@angular/material/tooltip';
import { AlertService, Alert } from '../../services/alert.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-notification-dialog',
  standalone: true,
  imports: [
    CommonModule,
    MatDialogModule,
    MatButtonModule,
    MatIconModule,
    MatDividerModule,
    MatTooltipModule
  ],
  templateUrl: './notification-dialog.component.html',
  styleUrls: ['./notification-dialog.component.css']
})
export class NotificationDialogComponent implements OnInit {
  criticalAlerts: Alert[] = [];
  warningAlerts: Alert[] = [];
  infoAlerts: Alert[] = [];
  criticalCount = 0;
  warningCount = 0;
  infoCount = 0;

  constructor(
    private alertService: AlertService,
    private dialogRef: MatDialogRef<NotificationDialogComponent>,
    private router: Router
  ) {}

  ngOnInit(): void {
    this.alertService.alerts$.subscribe(alerts => {
      this.criticalAlerts = alerts.filter(a => a.severity === 'Critical');
      this.warningAlerts = alerts.filter(a => a.severity === 'Warning');
      this.infoAlerts = alerts.filter(a => a.severity === 'Info');
      
      const counts = this.alertService.getUnreadCount();
      this.criticalCount = counts.critical;
      this.warningCount = counts.warning;
      this.infoCount = counts.info;
    });
  }

  getTimeAgo(date: Date): string {
    const now = new Date();
    const past = new Date(date);
    const diffMins = Math.floor((now.getTime() - past.getTime()) / 60000);
    
    if (diffMins < 1) return 'À l\'instant';
    if (diffMins < 60) return `Il y a ${diffMins} min`;
    if (diffMins < 1440) return `Il y a ${Math.floor(diffMins / 60)} h`;
    return `Il y a ${Math.floor(diffMins / 1440)} j`;
  }

  markAsRead(event: Event, alertId: string): void {
    event.stopPropagation();
    this.alertService.markAsRead(alertId);
  }

  markAllAsRead(): void {
    this.alertService.markAllAsRead();
  }

  onAlertClick(alert: Alert): void {
    this.alertService.markAsRead(alert.id);
    this.dialogRef.close();
    this.alertService.navigateToAlert(alert);
  }

  viewAllAlerts(): void {
    this.dialogRef.close();
    this.alertService.navigateToAllAlerts();
  }

  onClose(): void {
    this.dialogRef.close();
  }
}