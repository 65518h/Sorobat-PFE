// src/app/core/directives/offline-hide.directive.ts
import { Directive, Input, TemplateRef, ViewContainerRef, OnInit, OnDestroy } from '@angular/core';
import { OfflineSyncService } from '../services/offline-sync.service';
import { Subject, takeUntil } from 'rxjs';

@Directive({
  selector: '[appOfflineHide]',
  standalone: true
})
export class OfflineHideDirective implements OnInit, OnDestroy {
  private destroy$ = new Subject<void>();
  
  constructor(
    private templateRef: TemplateRef<any>,
    private viewContainer: ViewContainerRef,
    private offlineSync: OfflineSyncService
  ) {}
  
  ngOnInit(): void {
    this.offlineSync.isOnline$
      .pipe(takeUntil(this.destroy$))
      .subscribe(isOnline => {
        // Cacher en mode offline (quand isOnline = false)
        if (isOnline) {
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