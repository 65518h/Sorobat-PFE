// src/app/modules/equipment/equipment-routing-module.ts

import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

// Composants de pointage des véhicules
import { VehiculePointageListComponent } from './pages/vehicule-pointage/list/vehicule-pointage-list';
import { VehiculePointageDetailComponent } from './pages/vehicule-pointage/detail/vehicule-pointage-detail';
import { VehiculePointageFormComponent } from './pages/vehicule-pointage/form/vehicule-pointage-form';
import { VehiculePointageLineEditComponent } from './pages/vehicule-pointage/line-edit/vehicule-pointage-line-edit'; // 

const routes: Routes = [
  {
    path: '',
    redirectTo: 'pointages',
    pathMatch: 'full'
  },
  {
    path: 'pointages',
    component: VehiculePointageListComponent,
    data: { title: 'Pointage des véhicules' }
  },
  //  Les routes spécifiques DOIVENT être avant les routes avec paramètres
  {
    path: 'pointage/new',
    component: VehiculePointageFormComponent,
    data: { title: 'Nouveau pointage', mode: 'create' }
  },
  {
    path: 'pointage/edit/:id',
    component: VehiculePointageFormComponent,
    data: { title: 'Modifier le pointage', mode: 'edit' }
  },
  //  AJOUTER LA ROUTE POUR L'ÉDITION DE LIGNE (AVANT la route avec paramètre simple)
  {
    path: 'pointage/edit-line/:pointageId/:lineId',
    component: VehiculePointageLineEditComponent,
    data: { title: 'Modifier le véhicule' }
  },
  //  La route avec paramètre DOIT être en dernier
  {
    path: 'pointage/:id',
    component: VehiculePointageDetailComponent,
    data: { title: 'Détail du pointage' }
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class EquipmentRoutingModule { }