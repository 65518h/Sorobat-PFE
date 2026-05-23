// src/app/modules/dashboard/dashboard.module.ts

import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';

import { DashboardRoutingModule } from './dashboard-routing-module';
import { DashboardHomeComponent } from './pages/dashboard-home/dashboard-home';

// Importer les composants standalone ou les déclarer
import { MatCardModule } from '@angular/material/card';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatProgressBarModule } from '@angular/material/progress-bar';

@NgModule({
  declarations: [
    // Si DashboardHomeComponent n'est pas standalone, le déclarer ici
    // DashboardHomeComponent
  ],
  imports: [
    CommonModule,
    RouterModule,
    DashboardRoutingModule,
    // Importer les composants standalone ici
    DashboardHomeComponent,
    MatCardModule,
    MatButtonModule,
    MatIconModule,
    MatProgressBarModule
  ]
})
export class DashboardModule { }