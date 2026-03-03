// app.routes.ts
import { Routes } from '@angular/router';
import { AuthLayoutComponent } from './layout/auth-layout/auth-layout';
import { MainLayoutComponent } from './layout/main-layout/main-layout';
import { AuthGuard } from './core/guards/auth-guard';

export const routes: Routes = [
  {
    path: 'auth',
    component: AuthLayoutComponent,
    loadChildren: () => import('./auth/auth.routes').then(m => m.AUTH_ROUTES)
  },
  {
    path: '',
    component: MainLayoutComponent,
    canActivate: [AuthGuard],
    children: [

      {
        path: 'tasks',  // ← Nouvelle route pour les tâches
        canActivate: [AuthGuard],
        loadChildren: () => import('./models/tasks/tasks.module').then(m => m.TasksModule)
    },
      { 
        path: 'dashboard', 
        loadChildren: () => import('./models/dashboard/dashboard-module').then(m => m.DashboardModule) 
      },
      { 
        path: 'projects', 
        // use the dashed file name like the other feature modules
        loadChildren: () => import('./models/projects/projects-module').then(m => m.ProjectsModule) 
      },
      { 
        path: 'purchases', 
        loadChildren: () => import('./models/purchases/purchases-module').then(m => m.PurchasesModule) 
      },
      { 
        path: 'inventory', 
        loadChildren: () => import('./models/inventory/inventory-module').then(m => m.InventoryModule) 
      },
      { 
        path: 'equipment', 
        loadChildren: () => import('./models/equipment/equipment-module').then(m => m.EquipmentModule) 
      },
      { path: '', redirectTo: 'dashboard', pathMatch: 'full' }
    ]
  }
];