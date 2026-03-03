import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { TasksRoutingModule } from './tasks-routing.module';
import { TaskListComponent } from './pages/task-list/task-list.component';

@NgModule({
  imports: [
    CommonModule,
    TasksRoutingModule,
    TaskListComponent
  ]
})
export class TasksModule { }