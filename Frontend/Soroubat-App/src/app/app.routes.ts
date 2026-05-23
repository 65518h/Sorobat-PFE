// app.routes.ts

import { Routes } from '@angular/router';
import { AuthLayoutComponent } from './layout/auth-layout/auth-layout';
import { MainLayoutComponent } from './layout/main-layout/main-layout';
import { AuthGuard } from './core/guards/auth-guard';

export const routes: Routes = [
  // ✅ Redirection pour /login vers /auth/login
  { path: 'login', redirectTo: 'auth/login', pathMatch: 'full' },
  
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
        path: 'dashboard', 
        loadChildren: () => import('./models/dashboard/dashboard-module').then(m => m.DashboardModule) 
      },
      {
        path: 'tasks',
        loadChildren: () => import('./models/tasks/tasks.module').then(m => m.TasksModule)
      },
      { 
        path: 'projects', 
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
        path: 'gasoil',
        loadChildren: () => import('./models/gasoil/gasoil-routing.module').then(m => m.GasoilRoutingModule)
      },
      { 
        path: 'equipment', 
        loadChildren: () => import('./models/equipment/equipment-module').then(m => m.EquipmentModule) 
      },
      {
        path: 'attendance',
        loadChildren: () => import('./models/attendance/attendance.routes').then(m => m.ATTENDANCE_ROUTES)
      },
      { 
        path: 'transfers', 
        loadChildren: () => import('./models/transfers/transfers.module').then(m => m.TransfersModule) 
      },
      {
        path: 'settings',
        loadComponent: () => import('./models/settings/pages/settings/settings.component').then(m => m.SettingsComponent)
      },
      {
        path: 'calendar',
        loadComponent: () => import('./models/calendar/pages/calendar-page/calendar-page')
          .then(m => m.CalendarPageComponent)
      },
      {
        path: 'help',
        loadComponent: () => import('./models/help/pages/help/help.component').then(m => m.HelpComponent)
      },
      {
        path: 'alerts',
        loadComponent: () => import('./models/alerts/pages/alerts-page/alerts-page').then(m => m.AlertsPageComponent)
      },
      { path: '', redirectTo: 'dashboard', pathMatch: 'full' }
    ]
  }
];