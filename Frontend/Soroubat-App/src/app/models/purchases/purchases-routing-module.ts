// src/app/models/purchases/purchases-routing-module.ts

import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AuthGuard } from '../../core/guards/auth-guard';
import { roleGuard } from '../../core/guards/role-guard';

// ✅ Importer avec les bons noms
import { RequestListComponent } from './pages/request-list/request-list';
import { RequestForm } from './pages/request-form/request-form';
import { RequestDetail } from './pages/request-detail/request-detail';

const routes: Routes = [
  {
    path: 'requests',
    component: RequestListComponent,
    canActivate: [AuthGuard],
    data: { title: 'Demandes d\'achat' }
  },
  {
    path: 'request/new',
    component: RequestForm,
    canActivate: [AuthGuard],
    data: { title: 'Nouvelle demande' }
  },
  {
    path: 'request/:id',
    component: RequestDetail,
    canActivate: [AuthGuard],
    data: { title: 'Détail demande' }
  },
  {
    path: 'request/:id/edit',
    component: RequestForm,
    canActivate: [AuthGuard, roleGuard],
    data: { 
      title: 'Modifier demande',
      roles: ['requester', 'approver']
    }
  },
  {
    path: '',
    redirectTo: 'requests',
    pathMatch: 'full'
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class PurchasesRoutingModule { }