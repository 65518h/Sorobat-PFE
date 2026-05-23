// src/app/models/purchases/purchases-module.ts

import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ReactiveFormsModule, FormsModule } from '@angular/forms';
import { RouterModule } from '@angular/router';

import { PurchasesRoutingModule } from './purchases-routing-module';
import { SharedModule } from '../../shared/shared-module';

// ✅ Importer les bons noms (avec Component)
import { RequestHeader } from './components/request-header/request-header';
import { RequestLines } from './components/request-lines/request-lines';
import { StockControl} from './components/stock-control/stock-control';
import { ApprovalHistory } from './components/approval-history/approval-history';
import { RequestListComponent } from './pages/request-list/request-list';  // ✅ Bon nom
import { RequestForm } from './pages/request-form/request-form';
import { RequestDetail} from './pages/request-detail/request-detail';

@NgModule({
  declarations: [
    // Composants NON-standalone (si ils ne sont pas standalone)
    // Si vos composants sont standalone, ne les mettez PAS ici
  ],
  imports: [
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    RouterModule,
    PurchasesRoutingModule,
    SharedModule,
    // ✅ Importer les composants standalone ici
    RequestHeader,
    RequestLines,
    RequestListComponent,
    StockControl,
    ApprovalHistory,
    RequestForm,
    RequestDetail
  ],
  exports: [
    RequestHeader,
    RequestLines
  ]
})
export class PurchasesModule { }