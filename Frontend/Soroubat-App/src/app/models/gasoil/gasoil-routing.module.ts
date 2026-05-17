// src/app/modules/gasoil/gasoil-routing.module.ts

import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { GasoilListComponent } from './pages/gasoil-list/gasoil-list';
import { GasoilFormComponent } from './pages/gasoil-form/gasoil-form';
import { GasoilDetailComponent } from './pages/gasoil-detail/gasoil-detail';

const routes: Routes = [
  {
    path: '',
    redirectTo: 'list',
    pathMatch: 'full'
  },
  {
    path: 'list',
    component: GasoilListComponent,
    data: { title: 'Fiches gasoil' }
  },
  {
    path: 'new',
    component: GasoilFormComponent,
    data: { title: 'Nouvelle fiche gasoil', mode: 'create' }
  },
  {
    path: 'edit/:id',
    component: GasoilFormComponent,
    data: { title: 'Modifier fiche gasoil', mode: 'edit' }
  },
  {
    path: ':id',
    component: GasoilDetailComponent,
    data: { title: 'Détail fiche gasoil' }
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class GasoilRoutingModule { }