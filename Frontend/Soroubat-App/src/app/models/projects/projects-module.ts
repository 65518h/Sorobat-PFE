import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ProjectsRoutingModule } from './projects-routing-module';
import { ProjectListComponent } from './pages/project-list/project-list';

@NgModule({
  imports: [
    CommonModule,
    ProjectsRoutingModule,
    ProjectListComponent
  ]
})
export class ProjectsModule { }