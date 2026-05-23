// src/app/core/services/app-mode.service.ts

import { Injectable, inject, PLATFORM_ID } from '@angular/core';
import { isPlatformBrowser } from '@angular/common';
import { BehaviorSubject } from 'rxjs';
import { OfflineSyncService } from './offline-sync.service';

export type AppMode = 'online' | 'offline-readonly';

@Injectable({ providedIn: 'root' })
export class AppModeService {
  private platformId = inject(PLATFORM_ID);
  private offlineSync = inject(OfflineSyncService);
  
  private modeSubject = new BehaviorSubject<AppMode>('online');
  mode$ = this.modeSubject.asObservable();
  
  constructor() {
    // ✅ S'abonner aux changements de connectivité du service existant
    this.offlineSync.isOnline$.subscribe(isOnline => {
      this.detectMode(isOnline);
    });
    
    // Détection initiale
    if (isPlatformBrowser(this.platformId)) {
      setTimeout(() => {
        this.detectMode(this.offlineSync.isOnline);
      }, 1000);
    }
  }
  
  private detectMode(isOnline: boolean): void {
    if (!isPlatformBrowser(this.platformId)) return;
    
    // Détection PWA (Application installée)
    const isPWA = window.matchMedia('(display-mode: standalone)').matches ||
                  (window.navigator as any).standalone === true ||
                  document.referrer.includes('android-app://') ||
                  window.location.href.includes('127.0.0.1:4201'); // URL de votre PWA
    
    const hasSW = 'serviceWorker' in navigator && 
                  navigator.serviceWorker.controller !== null;
    
    // Mode offline = (PWA OU Service Worker) ET pas de réseau
    const isOfflineMode = (isPWA || hasSW) && !isOnline;
    
    const mode: AppMode = isOfflineMode ? 'offline-readonly' : 'online';
    
    if (this.modeSubject.value !== mode) {
      this.modeSubject.next(mode);
      
      // Appliquer classe CSS au body
      if (mode === 'offline-readonly') {
        document.body.classList.add('offline-readonly');
        document.body.classList.remove('online-mode');
      } else {
        document.body.classList.add('online-mode');
        document.body.classList.remove('offline-readonly');
      }
      
      console.log(`📱 Mode détecté: ${mode}`, { isPWA, hasSW, isOnline });
    }
  }
  
  /**
   * ✅ Retourne le mode actuel
   */
  get currentMode(): AppMode {
    return this.modeSubject.value;
  }
  
  /**
   * ✅ Vérifie si l'application est en lecture seule (offline)
   */
  get isReadOnly(): boolean {
    return this.currentMode === 'offline-readonly';
  }
  
  /**
   * ✅ Vérifie si l'application est en ligne
   */
  get isOnline(): boolean {
    return this.currentMode === 'online';
  }
  
  /**
   * ✅ Vérifie si l'application est hors ligne (alias pour isReadOnly)
   * Propriété ajoutée pour la compatibilité avec ProjectService
   */
  get isOffline(): boolean {
    return this.currentMode === 'offline-readonly';
  }
  
  /**
   * ✅ Force le passage en mode online (utile après reconnexion)
   */
  forceOnlineMode(): void {
    if (this.modeSubject.value !== 'online') {
      console.log('🔄 Force passage en mode online');
      this.modeSubject.next('online');
      document.body.classList.add('online-mode');
      document.body.classList.remove('offline-readonly');
    }
  }
  
  /**
   * ✅ Force le passage en mode offline (utile pour les tests)
   */
  forceOfflineMode(): void {
    if (this.modeSubject.value !== 'offline-readonly') {
      console.log('🔄 Force passage en mode offline-readonly');
      this.modeSubject.next('offline-readonly');
      document.body.classList.add('offline-readonly');
      document.body.classList.remove('online-mode');
    }
  }
  
  /**
   * ✅ Vérifie si l'application est en mode PWA (installée)
   */
  isPWA(): boolean {
    if (!isPlatformBrowser(this.platformId)) return false;
    return window.matchMedia('(display-mode: standalone)').matches ||
           (window.navigator as any).standalone === true ||
           window.location.href.includes('127.0.0.1:4201');
  }
  
  /**
   * ✅ Vérifie si le service worker est actif
   */
  hasActiveServiceWorker(): boolean {
    if (!isPlatformBrowser(this.platformId)) return false;
    return 'serviceWorker' in navigator && 
           navigator.serviceWorker.controller !== null;
  }
  
  /**
   * ✅ Retourne des informations détaillées sur le mode actuel
   */
  getModeInfo(): {
    mode: AppMode;
    isPWA: boolean;
    hasServiceWorker: boolean;
    isOnline: boolean;
  } {
    return {
      mode: this.currentMode,
      isPWA: this.isPWA(),
      hasServiceWorker: this.hasActiveServiceWorker(),
      isOnline: this.isOnline
    };
  }
}