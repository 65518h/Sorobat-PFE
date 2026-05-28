// src/app/core/services/offline-sync.service.ts

import { Injectable, NgZone, Inject, PLATFORM_ID } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { BehaviorSubject, firstValueFrom } from 'rxjs';
import { ToastrService } from 'ngx-toastr';
import { db, OfflineGasoil, OfflinePointage, OfflinePurchaseRequest, OfflineAttendance } from '../database/offline-db';
import { isPlatformBrowser } from '@angular/common';

@Injectable({ providedIn: 'root' })
export class OfflineSyncService {
  private isOnlineSubject = new BehaviorSubject<boolean>(navigator.onLine);
  isOnline$ = this.isOnlineSubject.asObservable();
  
  private pendingCountSubject = new BehaviorSubject<number>(0);
  pendingCount$ = this.pendingCountSubject.asObservable();
  
  private isSyncing = false;
  private pingInterval: any;

  constructor(
    private http: HttpClient,
    private toastr: ToastrService,
    private ngZone: NgZone,
    @Inject(PLATFORM_ID) private platformId: Object
  ) {
    //  Écouter les événements réseau natifs
    window.addEventListener('online', () => {
      console.log(' Événement online détecté (navigator)');
      this.ngZone.run(() => {
        this.isOnlineSubject.next(true);
        this.syncAll();
      });
    });
    
    window.addEventListener('offline', () => {
      console.log(' Événement offline détecté (navigator)');
      this.ngZone.run(() => {
        this.isOnlineSubject.next(false);
      });
    });
    
    //  Vérification périodique avec ping (plus fiable en PWA)
    this.startPingCheck();
    
    // Mettre à jour le compteur périodiquement
    setInterval(() => this.updatePendingCount(), 5000);
    this.updatePendingCount();
    
    // Vérifier au démarrage
    setTimeout(() => {
      this.checkConnectivity();
      if (this.isOnline) {
        this.syncAll();
      }
    }, 3000);
  }

  private startPingCheck(): void {
    // Vérifier moins fréquemment en mode hors ligne
    const intervalTime = this.isOnlineSubject.value ? 15000 : 60000; // 15s en ligne, 60s en offline
    
    if (this.pingInterval) {
      clearInterval(this.pingInterval);
    }
    
    this.pingInterval = setInterval(() => {
      this.checkConnectivity();
    }, intervalTime);
  }

  private async checkConnectivity(): Promise<void> {
    try {
      // Timeout de 5 secondes
      const controller = new AbortController();
      const timeoutId = setTimeout(() => controller.abort(), 5000);
      
      //  CORRECTION: Utiliser GET au lieu de HEAD
      const response = await fetch('http://localhost:5227/api/auth/ping', {
        method: 'GET',
        signal: controller.signal,
        cache: 'no-cache'
      });
      
      clearTimeout(timeoutId);
      
      const isOnline = response.ok;
      const currentState = this.isOnlineSubject.value;
      
      if (currentState !== isOnline) {
        console.log(`📡 Ping: ${isOnline ? '🟢 En ligne' : '🔴 Hors ligne'}`);
        this.ngZone.run(() => {
          this.isOnlineSubject.next(isOnline);
          if (isOnline) {
            this.syncAll();
          }
        });
        // Redémarrer l'intervalle avec la nouvelle fréquence
        this.startPingCheck();
      }
    } catch (error) {
      // Erreur = offline
      if (this.isOnlineSubject.value !== false) {
        console.log('📡 Ping échoué -> Mode offline');
        this.ngZone.run(() => {
          this.isOnlineSubject.next(false);
        });
        this.startPingCheck();
      }
    }
  }

  get isOnline(): boolean {
    return this.isOnlineSubject.value;
  }

  private async updatePendingCount(): Promise<void> {
    try {
      if (!db || !db.pointages) {
        console.warn('Base de données non disponible');
        return;
      }
      
      const pointages = await db.pointages.where('syncStatus').anyOf(['pending', 'error']).count();
      const gasoil = await db.gasoil.where('syncStatus').anyOf(['pending', 'error']).count();
      const purchases = await db.purchases.where('syncStatus').anyOf(['pending', 'error']).count();
      const attendances = await db.attendances.where('syncStatus').anyOf(['pending', 'error']).count();
      
      const total = pointages + gasoil + purchases + attendances;
      this.pendingCountSubject.next(total);
      
      if (total > 0) {
        console.log(` ${total} document(s) en attente de synchronisation (pointages:${pointages}, gasoil:${gasoil}, purchases:${purchases}, attendances:${attendances})`);
      }
    } catch (error) {
      console.error('Erreur mise à jour compteur:', error);
    }
  }

  //  Méthode pour forcer la synchronisation manuelle
  async forceSync(): Promise<void> {
    if (!this.isOnline) {
      this.toastr.warning('Impossible de synchroniser : vous êtes hors ligne');
      return;
    }
    
    if (this.isSyncing) {
      this.toastr.info('Synchronisation déjà en cours...');
      return;
    }
    
    await this.syncAll();
  }

  // ── Sauvegarde offline ─────────────────────────────────────
  
  async savePointageOffline(data: any): Promise<string> {
    const id = crypto.randomUUID();
    await db.pointages.add({
      id,
      type: 'pointage',
      data,
      syncStatus: 'pending',
      createdAt: new Date()
    });
    await this.updatePendingCount();
    
    this.toastr.warning(
      ' Pointage enregistré localement. Synchronisation automatique au retour du réseau.',
      'Mode hors ligne',
      { timeOut: 5000 }
    );
    return id;
  }

  async saveAttendanceOffline(data: any): Promise<string> {
    const id = crypto.randomUUID();
    await db.attendances.add({
      id,
      type: 'attendance',
      data,
      syncStatus: 'pending',
      createdAt: new Date()
    });
    await this.updatePendingCount();
    
    this.toastr.warning(
      ' Feuille de présence enregistrée localement. Synchronisation automatique au retour du réseau.',
      'Mode hors ligne',
      { timeOut: 5000 }
    );
    return id;
  }

  async saveGasoilOffline(data: any): Promise<string> {
    const id = crypto.randomUUID();
    await db.gasoil.add({
      id,
      type: 'gasoil',
      data,
      syncStatus: 'pending',
      createdAt: new Date()
    });
    await this.updatePendingCount();
    
    this.toastr.warning(
      ' Fiche gasoil enregistrée localement. Synchronisation au retour du réseau.',
      'Mode hors ligne',
      { timeOut: 5000 }
    );
    return id;
  }

  async savePurchaseOffline(data: any): Promise<string> {
    const id = crypto.randomUUID();
    await db.purchases.add({
      id,
      type: 'purchase',
      data,
      syncStatus: 'pending',
      createdAt: new Date()
    });
    await this.updatePendingCount();
    
    this.toastr.warning(
      ' Demande d\'achat enregistrée localement. Synchronisation au retour du réseau.',
      'Mode hors ligne',
      { timeOut: 5000 }
    );
    return id;
  }

  // ── Synchronisation ────────────────────────────────────────
  
  async syncAll(): Promise<{ success: number; errors: number }> {
    if (!this.isOnline) {
      console.log(' Hors ligne - Synchronisation impossible');
      return { success: 0, errors: 0 };
    }
    
    if (this.isSyncing) {
      console.log(' Synchronisation déjà en cours...');
      return { success: 0, errors: 0 };
    }
    
    this.isSyncing = true;
    console.log(' Début de la synchronisation offline...');
    
    let success = 0;
    let errors = 0;
    
    try {
      //  Synchronisation des attendances (feuilles de présence)
      const attendancesResult = await this.syncAttendances();
      success += attendancesResult.success;
      errors += attendancesResult.errors;
      
      const pointagesResult = await this.syncPointages();
      success += pointagesResult.success;
      errors += pointagesResult.errors;
      
      const gasoilResult = await this.syncGasoil();
      success += gasoilResult.success;
      errors += gasoilResult.errors;
      
      const purchasesResult = await this.syncPurchases();
      success += purchasesResult.success;
      errors += purchasesResult.errors;
      
      await this.updatePendingCount();
      
      if (success > 0) {
        this.toastr.success(
          `${success} document(s) synchronisé(s) avec succès.`,
          ' Synchronisation terminée',
          { timeOut: 4000 }
        );
      }
      
      if (errors > 0) {
        this.toastr.warning(
          `${errors} document(s) n'ont pas pu être synchronisés.`,
          ' Synchronisation partielle',
          { timeOut: 5000 }
        );
      }
      
      console.log(` Synchronisation terminée: ${success} succès, ${errors} erreurs`);
    } finally {
      this.isSyncing = false;
    }
    
    return { success, errors };
  }

  //  Synchronisation des feuilles de présence (attendances)
  private async syncAttendances(): Promise<{ success: number; errors: number }> {
    const pending = await db.attendances.where('syncStatus').anyOf(['pending', 'error']).toArray();
    
    console.log(` ${pending.length} feuille(s) de présence à synchroniser`);
    
    let success = 0;
    let errors = 0;
    
    for (const item of pending) {
      await db.attendances.update(item.id!, { syncStatus: 'syncing' });
      
      try {
        const response = await firstValueFrom(
          this.http.post('/api/Attendance', item.data)
        );
        
        await db.attendances.update(item.id!, {
          syncStatus: 'synced',
          documentNo: (response as any).documentNo || item.documentNo,
          updatedAt: new Date()
        });
        
        console.log(` Feuille de présence synchronisée: ${item.documentNo || item.id}`);
        success++;
      } catch (error: any) {
        await db.attendances.update(item.id!, {
          syncStatus: 'error',
          errorMessage: error.message || error.error?.message || 'Erreur inconnue',
          updatedAt: new Date()
        });
        console.error(` Erreur synchronisation présence:`, error);
        errors++;
      }
      
      await this.delay(500);
    }
    
    return { success, errors };
  }

  private async syncPointages(): Promise<{ success: number; errors: number }> {
    const pending = await db.pointages.where('syncStatus').anyOf(['pending', 'error']).toArray();
    
    console.log(` ${pending.length} pointage(s) véhicule à synchroniser`);
    
    let success = 0;
    let errors = 0;
    
    for (const item of pending) {
      await db.pointages.update(item.id!, { syncStatus: 'syncing' });
      
      try {
        const response = await firstValueFrom(
          this.http.post('/api/VehiculePointage', item.data)
        );
        
        await db.pointages.update(item.id!, {
          syncStatus: 'synced',
          documentNo: (response as any).documentNo,
          updatedAt: new Date()
        });
        
        console.log(` Pointage véhicule synchronisé: ${item.id}`);
        success++;
      } catch (error: any) {
        await db.pointages.update(item.id!, {
          syncStatus: 'error',
          errorMessage: error.message || error.error?.message || 'Erreur inconnue'
        });
        console.error(` Erreur synchronisation pointage véhicule:`, error);
        errors++;
      }
      
      await this.delay(500);
    }
    
    return { success, errors };
  }

  private async syncGasoil(): Promise<{ success: number; errors: number }> {
    const pending = await db.gasoil.where('syncStatus').anyOf(['pending', 'error']).toArray();
    
    console.log(` ${pending.length} fiche(s) gasoil à synchroniser`);
    
    let success = 0;
    let errors = 0;
    
    for (const item of pending) {
      await db.gasoil.update(item.id!, { syncStatus: 'syncing' });
      
      try {
        const response = await firstValueFrom(
          this.http.post('/api/Gasoil', item.data)
        );
        
        await db.gasoil.update(item.id!, {
          syncStatus: 'synced',
          documentNo: (response as any).documentNo,
          updatedAt: new Date()
        });
        
        console.log(` Fiche gasoil synchronisée: ${item.id}`);
        success++;
      } catch (error: any) {
        await db.gasoil.update(item.id!, {
          syncStatus: 'error',
          errorMessage: error.message || error.error?.message || 'Erreur inconnue'
        });
        console.error(` Erreur synchronisation gasoil:`, error);
        errors++;
      }
      
      await this.delay(500);
    }
    
    return { success, errors };
  }

  private async syncPurchases(): Promise<{ success: number; errors: number }> {
    const pending = await db.purchases.where('syncStatus').anyOf(['pending', 'error']).toArray();
    
    console.log(` ${pending.length} demande(s) d'achat à synchroniser`);
    
    let success = 0;
    let errors = 0;
    
    for (const item of pending) {
      await db.purchases.update(item.id!, { syncStatus: 'syncing' });
      
      try {
        const response = await firstValueFrom(
          this.http.post('/api/PurchaseRequest', item.data)
        );
        
        await db.purchases.update(item.id!, {
          syncStatus: 'synced',
          documentNo: (response as any).documentNo,
          updatedAt: new Date()
        });
        
        console.log(` Demande d'achat synchronisée: ${item.id}`);
        success++;
      } catch (error: any) {
        await db.purchases.update(item.id!, {
          syncStatus: 'error',
          errorMessage: error.message || error.error?.message || 'Erreur inconnue'
        });
        console.error(` Erreur synchronisation achat:`, error);
        errors++;
      }
      
      await this.delay(500);
    }
    
    return { success, errors };
  }

  private delay(ms: number): Promise<void> {
    return new Promise(resolve => setTimeout(resolve, ms));
  }

  // ── Gestion ────────────────────────────────────────────────
  
  async getPendingItems(): Promise<{
    pointages: OfflinePointage[];
    gasoil: OfflineGasoil[];
    purchases: OfflinePurchaseRequest[];
    attendances: OfflineAttendance[];
  }> {
    return {
      pointages: await db.pointages.where('syncStatus').anyOf(['pending', 'error']).toArray(),
      gasoil: await db.gasoil.where('syncStatus').anyOf(['pending', 'error']).toArray(),
      purchases: await db.purchases.where('syncStatus').anyOf(['pending', 'error']).toArray(),
      attendances: await db.attendances.where('syncStatus').anyOf(['pending', 'error']).toArray()
    };
  }

  async getSyncedItems(): Promise<{
    pointages: OfflinePointage[];
    gasoil: OfflineGasoil[];
    purchases: OfflinePurchaseRequest[];
    attendances: OfflineAttendance[];
  }> {
    return {
      pointages: await db.pointages.where('syncStatus').equals('synced').toArray(),
      gasoil: await db.gasoil.where('syncStatus').equals('synced').toArray(),
      purchases: await db.purchases.where('syncStatus').equals('synced').toArray(),
      attendances: await db.attendances.where('syncStatus').equals('synced').toArray()
    };
  }

  async deleteItem(type: string, id: string): Promise<void> {
    const table = this.getTable(type);
    if (table) {
      await table.delete(id);
      await this.updatePendingCount();
      this.toastr.info('Document supprimé localement');
    }
  }

  async retrySync(type: string, id: string): Promise<void> {
    const table = this.getTable(type);
    if (table) {
      await table.update(id, { syncStatus: 'pending', errorMessage: undefined });
      await this.updatePendingCount();
      
      if (this.isOnline) {
        this.toastr.info('Tentative de synchronisation...');
        await this.syncAll();
      } else {
        this.toastr.warning('En attente du réseau pour synchroniser');
      }
    }
  }

  private getTable(type: string): any {
    switch(type) {
      case 'pointage': return db.pointages;
      case 'gasoil': return db.gasoil;
      case 'purchase': return db.purchases;
      case 'attendance': return db.attendances;
      default: return null;
    }
  }
  
  async clearSyncedItems(): Promise<void> {
    await db.pointages.where('syncStatus').equals('synced').delete();
    await db.gasoil.where('syncStatus').equals('synced').delete();
    await db.purchases.where('syncStatus').equals('synced').delete();
    await db.attendances.where('syncStatus').equals('synced').delete();
    await this.updatePendingCount();
    console.log(' Documents synchronisés supprimés');
  }

  //  Vérifier si on est en mode PWA
  isPWA(): boolean {
    if (!isPlatformBrowser(this.platformId)) return false;
    return window.matchMedia('(display-mode: standalone)').matches ||
           (window.navigator as any).standalone === true ||
           window.location.href.includes('127.0.0.1:4201');
  }
}