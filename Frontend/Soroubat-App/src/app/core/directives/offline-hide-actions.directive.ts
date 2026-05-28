// src/app/core/directives/offline-hide-actions.directive.ts

import { Directive, TemplateRef, ViewContainerRef, OnInit, OnDestroy } from '@angular/core';
import { Subject, takeUntil } from 'rxjs';
import { AppModeService } from '../services/app-mode.service';

@Directive({
  selector: '[appOfflineHideActions]',
  standalone: true
})
export class OfflineHideActionsDirective implements OnInit, OnDestroy {
  private hasView = false;
  private destroy$ = new Subject<void>();

  constructor(
    private templateRef: TemplateRef<any>,
    private viewContainer: ViewContainerRef,
    private appModeService: AppModeService
  ) {}
ngOnInit(): void {
  console.log(' [Directive] Initialisée');
  
  this.appModeService.mode$
    .pipe(takeUntil(this.destroy$))
    .subscribe(mode => {
      const isReadOnly = mode === 'offline-readonly';
      console.log(' [Directive] Mode:', mode, '| isReadOnly:', isReadOnly);
      console.log(' [Directive] TemplateRef existe:', !!this.templateRef);
      
      if (isReadOnly && this.hasView) {
        console.log(' MASQUAGE');
        this.viewContainer.clear();
        this.hasView = false;
      } else if (!isReadOnly && !this.hasView) {
        console.log(' AFFICHAGE');
        this.viewContainer.createEmbeddedView(this.templateRef);
        this.hasView = true;
      }
    });
}

 

  ngOnDestroy(): void {
    this.destroy$.next();
    this.destroy$.complete();
  }
}