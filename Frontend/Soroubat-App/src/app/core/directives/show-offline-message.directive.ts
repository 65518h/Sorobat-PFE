
// src/app/core/directives/show-offline-message.directive.ts

import { Directive, TemplateRef, ViewContainerRef, OnInit, OnDestroy } from '@angular/core';
import { AppModeService } from '../services/app-mode.service';
import { Subject, takeUntil } from 'rxjs';

@Directive({
  selector: '[appShowOfflineMessage]',
  standalone: true
})
export class ShowOfflineMessageDirective implements OnInit, OnDestroy {
  private destroy$ = new Subject<void>();
  
  constructor(
    private templateRef: TemplateRef<any>,
    private viewContainer: ViewContainerRef,
    private appMode: AppModeService
  ) {}
  
  ngOnInit(): void {
    this.appMode.mode$
      .pipe(takeUntil(this.destroy$))
      .subscribe(mode => {
        // Afficher le message uniquement en mode offline-readonly
        if (mode === 'offline-readonly') {
          this.viewContainer.createEmbeddedView(this.templateRef);
        } else {
          this.viewContainer.clear();
        }
      });
  }
  
  ngOnDestroy(): void {
    this.destroy$.next();
    this.destroy$.complete();
  }
}