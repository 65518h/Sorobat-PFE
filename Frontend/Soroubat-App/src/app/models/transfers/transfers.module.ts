// src/app/models/transfers/transfers.module.ts

import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule, Routes } from '@angular/router';
import { AuthGuard } from '../../core/guards/auth-guard';

// Composants
import { TransferListComponent } from './pages/transfer-list/transfer-list';
import { TransferDetailComponent } from './pages/transfer-detail/transfer-detail';
import { TransferReception } from './pages/transfer-form/transfer-form';

const routes: Routes = [
  {
    path: '',
    component: TransferListComponent,
    canActivate: [AuthGuard],
    data: { title: 'Ordres de transfert' }
  },
  {
    path: 'new',
    component: TransferReception,
    canActivate: [AuthGuard],
    data: { title: 'Nouveau transfert' }
  },
  {
    path: ':id',
    component: TransferDetailComponent,
    canActivate: [AuthGuard],
    data: { title: 'Détail du transfert' }
  },
  {
    path: ':id/edit',
    component: TransferReception,
    canActivate: [AuthGuard],
    data: { title: 'Modifier le transfert' }
  }
];

@NgModule({
  imports: [
    CommonModule,
    RouterModule.forChild(routes),
    TransferListComponent,
    TransferDetailComponent,
    TransferReception
  ]
})
export class TransfersModule { }