// src/app/models/equipment/equipment-module.ts

import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

// Angular Material Modules
import { MatCardModule } from '@angular/material/card';
import { MatTableModule } from '@angular/material/table';
import { MatInputModule } from '@angular/material/input';
import { MatSelectModule } from '@angular/material/select';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { MatPaginatorModule } from '@angular/material/paginator';
import { MatTooltipModule } from '@angular/material/tooltip';
import { MatChipsModule } from '@angular/material/chips';
import { MatBadgeModule } from '@angular/material/badge';
import { MatTabsModule } from '@angular/material/tabs';
import { MatDialogModule } from '@angular/material/dialog';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatNativeDateModule } from '@angular/material/core';
import { MatDividerModule } from '@angular/material/divider';

// Routing
import { EquipmentRoutingModule } from './equipment-routing-module';

// Services
import { VehiculePointageService } from './services/vehicule-pointage.service';

// Composants (standalone - importés, pas déclarés)
import { VehiculePointageListComponent } from './pages/vehicule-pointage/list/vehicule-pointage-list';
import { VehiculePointageDetailComponent } from './pages/vehicule-pointage/detail/vehicule-pointage-detail';
import { VehiculePointageFormComponent } from './pages/vehicule-pointage/form/vehicule-pointage-form';

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    EquipmentRoutingModule,
    // Angular Material
    MatCardModule,
    MatTableModule,
    MatInputModule,
    MatSelectModule,
    MatButtonModule,
    MatIconModule,
    MatProgressSpinnerModule,
    MatPaginatorModule,
    MatTooltipModule,
    MatChipsModule,
    MatBadgeModule,
    MatTabsModule,
    MatDialogModule,
    MatDatepickerModule,
    MatNativeDateModule,
    MatDividerModule,
    // Composants standalone
    VehiculePointageListComponent,
    VehiculePointageDetailComponent,
    VehiculePointageFormComponent
  ],
  providers: [
    VehiculePointageService
  ],
  exports: [
    EquipmentRoutingModule
  ]
})
export class EquipmentModule { }