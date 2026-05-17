// src/app/models/attendance/attendance.routes.ts

import { Routes } from '@angular/router';
import { AttendanceListComponent } from './pages/attendance-list/attendance-list';
import { AttendanceDetailComponent } from './pages/attendance-detail/attendance-detail';
import { AttendanceFormComponent } from './pages/attendance-form/attendance-form';
import { FaceAttendanceComponent } from './pages/face-attendance/face-attendance.component';

console.log('🔥 ATTENDANCE_ROUTES chargé !');
console.log('AttendanceFormComponent:', AttendanceFormComponent);

export const ATTENDANCE_ROUTES: Routes = [
  { path: '', component: AttendanceListComponent },
  { path: 'new', component: AttendanceFormComponent },
  { path: 'edit/:id', component: AttendanceFormComponent },
  { path: 'face', component: FaceAttendanceComponent },
  { path: ':id', component: AttendanceDetailComponent }
];