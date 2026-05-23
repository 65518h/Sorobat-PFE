// src/app/modules/attendance/services/attendance.service.ts

import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, of, from } from 'rxjs';
import { map, catchError, switchMap, tap } from 'rxjs/operators';
import { AttendanceHeader, AttendanceLine, CreateAttendanceHeader } from '../models/attendance.model';
import { CacheService } from '../../../core/services/cache.service';
import { AppModeService } from '../../../core/services/app-mode.service';
import { ToastrService } from 'ngx-toastr';

@Injectable({ providedIn: 'root' })
export class AttendanceService {
  private apiUrl = 'http://localhost:5227/api/Attendance';
  
  // Clés de cache
  private readonly CACHE_KEY_HEADERS = 'attendance-headers';
  private readonly CACHE_KEY_DETAIL_PREFIX = 'attendance-detail-';
  
  // Clé pour les pointages offline
  private readonly OFFLINE_HEADERS_KEY = 'offline_attendance_headers';
  private readonly OFFLINE_PREFIX = 'offline_';

  constructor(
    private http: HttpClient,
    private cacheService: CacheService,
    private appMode: AppModeService,
    private toastr: ToastrService
  ) {
    console.log('AttendanceService API URL:', this.apiUrl);
  }

  // ==================== MÉTHODES OFFLINE ====================
  
  private saveOfflineHeader(header: AttendanceHeader): void {
    const offlineHeaders = this.getOfflineHeaders();
    offlineHeaders.push(header);
    localStorage.setItem(this.OFFLINE_HEADERS_KEY, JSON.stringify(offlineHeaders));
  }

  private getOfflineHeaders(): AttendanceHeader[] {
    const stored = localStorage.getItem(this.OFFLINE_HEADERS_KEY);
    return stored ? JSON.parse(stored) : [];
  }

  private removeOfflineHeader(id: string): void {
    const offlineHeaders = this.getOfflineHeaders();
    const filtered = offlineHeaders.filter(h => h.id !== id);
    localStorage.setItem(this.OFFLINE_HEADERS_KEY, JSON.stringify(filtered));
  }

  private generateTempId(): string {
    return `${this.OFFLINE_PREFIX}${Date.now()}_${Math.random().toString(36).substr(2, 9)}`;
  }

  private generateTempNo(month: string, year: number): string {
    const monthAbbr = month.substring(0, 3).toUpperCase();
    return `TEMP-${year}${monthAbbr}${Math.floor(Math.random() * 1000)}`;
  }

  // ==================== HEADER METHODS ====================
  
  getAllHeaders(): Observable<AttendanceHeader[]> {
    console.log('📡 Appel API GET /api/Attendance');
    
    const isOffline = this.appMode.isOffline;
    
    return from(this.cacheService.getFromCache(this.CACHE_KEY_HEADERS)).pipe(
      switchMap(cachedData => {
        const offlineHeaders = this.getOfflineHeaders();
        
        if (isOffline) {
          const allHeaders = [...offlineHeaders, ...(cachedData || [])];
          console.log(`📦 Mode offline: ${offlineHeaders.length} offline, ${cachedData?.length || 0} en cache`);
          return of(allHeaders);
        }
        
        return this.http.get<AttendanceHeader[]>(this.apiUrl).pipe(
          map(headers => headers || []),
          tap(headers => {
            const allHeaders = [...offlineHeaders, ...headers];
            this.cacheService.saveToCache(this.CACHE_KEY_HEADERS, allHeaders);
            console.log(`✅ ${headers.length} pointages chargés, ${offlineHeaders.length} offline`);
          }),
          catchError(error => {
            console.error('❌ Erreur getAllHeaders:', error);
            const fallback = [...offlineHeaders, ...(cachedData || [])];
            if (fallback.length > 0) {
             
              return of(fallback);
            }
            return of([]);
          })
        );
      })
    );
  }

  getFullAttendance(id: string): Observable<AttendanceHeader> {
    console.log(`📡 Appel API GET /api/Attendance/${id}`);
    
    const isOffline = this.appMode.isOffline;
    const cacheKey = this.CACHE_KEY_DETAIL_PREFIX + id;
    
    if (id.startsWith(this.OFFLINE_PREFIX)) {
      const offlineHeaders = this.getOfflineHeaders();
      const offlineHeader = offlineHeaders.find(h => h.id === id);
      if (offlineHeader) {
        console.log('📦 Pointage offline trouvé:', offlineHeader);
        return of(offlineHeader);
      }
    }
    
    return from(this.cacheService.getFromCache(cacheKey)).pipe(
      switchMap(cachedData => {
        if (cachedData && isOffline) {
          console.log(`📦 Attendance détail ${id}: Utilisation du cache offline`);
          return of(cachedData);
        }
        
        return this.http.get<AttendanceHeader>(`${this.apiUrl}/${id}`).pipe(
          tap(header => {
            this.cacheService.saveToCache(cacheKey, header);
            console.log(`💾 Pointage ${id} mis en cache`);
          }),
          catchError(error => {
            console.error(`❌ Erreur getFullAttendance ${id}:`, error);
            if (cachedData) {
           
              return of(cachedData);
            }
            throw error;
          })
        );
      })
    );
  }

  /**
   * ✅ Crée un nouvel en-tête de pointage (DISPONIBLE OFFLINE)
   */
  createHeader(dto: CreateAttendanceHeader): Observable<AttendanceHeader> {
    if (this.appMode.isOffline) {
      const tempId = this.generateTempId();
      const tempNo = this.generateTempNo(dto.month, dto.year);
      
      const tempHeader: AttendanceHeader = {
        id: tempId,
        no: tempNo,
        month: dto.month,
        year: dto.year,
        jobNo: dto.jobNo,
        totalStaff: 0,
        attendanceRate: 0,
        isOffline: true  // ✅ Marquer comme offline
      };
      
      this.saveOfflineHeader(tempHeader);
      console.log('📱 Mode offline - Pointage créé localement', tempHeader);
      
      this.toastr.success(`Pointage "${tempNo}" créé localement`, '📱 Mode hors ligne', {
        timeOut: 3000
      });
      
      return of(tempHeader);
    }
    
    return this.http.post<AttendanceHeader>(this.apiUrl, dto).pipe(
      tap(header => {
        this.invalidateHeadersCache();
        console.log('✅ Pointage créé:', header);
        this.toastr.success(`Pointage ${header.no} créé avec succès`, 'Succès');
      }),
      catchError(error => {
        console.error('❌ Erreur createHeader:', error);
        this.toastr.error('Erreur lors de la création', 'Erreur');
        throw error;
      })
    );
  }

  updateHeader(id: string, dto: Partial<AttendanceHeader>): Observable<void> {
    if (this.appMode.isOffline) {
      console.log('📱 Mode offline - Modification impossible');
      this.toastr.warning('Modification indisponible en mode hors ligne', 'Action indisponible');
      throw new Error('Modification indisponible en mode hors ligne');
    }
    
    return this.http.patch<void>(`${this.apiUrl}/${id}`, dto).pipe(
      tap(() => {
        this.invalidateCache(id);
        this.invalidateHeadersCache();
        this.toastr.success('Pointage mis à jour avec succès', 'Succès');
      }),
      catchError(error => {
        console.error('❌ Erreur updateHeader:', error);
      
        throw error;
      })
    );
  }

  deleteHeader(id: string): Observable<void> {
    if (this.appMode.isOffline) {
      console.log('📱 Mode offline - Suppression impossible');
      this.toastr.warning('Suppression indisponible en mode hors ligne', 'Action indisponible');
      throw new Error('Suppression indisponible en mode hors ligne');
    }
    
    if (id.startsWith(this.OFFLINE_PREFIX)) {
      this.removeOfflineHeader(id);
      this.toastr.success('Pointage offline supprimé', 'Succès');
      return of(void 0);
    }
    
    return this.http.delete<void>(`${this.apiUrl}/${id}`).pipe(
      tap(() => {
        this.invalidateCache(id);
        this.invalidateHeadersCache();
        this.toastr.success('Pointage supprimé avec succès', 'Succès');
      }),
      catchError(error => {
        console.error('❌ Erreur deleteHeader:', error);
        this.toastr.error('Erreur lors de la suppression', 'Erreur');
        throw error;
      })
    );
  }

  // ==================== LINE METHODS ====================
  
  createLines(lines: AttendanceLine[]): Observable<any> {
    if (this.appMode.isOffline) {
      // Récupérer le headerId depuis la première ligne (si disponible)
      const firstLine = lines[0];
      const headerId = (firstLine as any).headerId || (firstLine as any).documentNo;
      
      if (headerId) {
        const existingLines = localStorage.getItem(`offline_lines_${headerId}`);
        const parsedLines = existingLines ? JSON.parse(existingLines) : [];
        const updatedLines = [...parsedLines, ...lines];
        localStorage.setItem(`offline_lines_${headerId}`, JSON.stringify(updatedLines));
        console.log('📱 Mode offline - Lignes sauvegardées localement');
        this.toastr.success(`${lines.length} employé(s) ajouté(s) localement`, '📱 Mode hors ligne');
      }
      return of({ success: true, offline: true });
    }
    
    return this.http.post(`${this.apiUrl}/lines`, lines).pipe(
      tap(() => {
        this.invalidateHeadersCache();
       
      }),
      catchError(error => {
        console.error('❌ Erreur createLines:', error);
        this.toastr.error('Erreur lors de l\'ajout des employés', 'Erreur');
        throw error;
      })
    );
  }

  updateLine(id: string, line: Partial<AttendanceLine>): Observable<void> {
    if (this.appMode.isOffline) {
      console.log('📱 Mode offline - Modification de ligne sauvegardée localement');
      // Sauvegarder localement (optionnel)
      return of(void 0);
    }
    
    return this.http.patch<void>(`${this.apiUrl}/lines/${id}`, line).pipe(
      tap(() => {
        this.invalidateHeadersCache();
      }),
      catchError(error => {
        console.error('❌ Erreur updateLine:', error);
        throw error;
      })
    );
  }

  deleteLine(id: string): Observable<void> {
    if (this.appMode.isOffline) {
      console.log('📱 Mode offline - Suppression impossible');
      this.toastr.warning('Suppression indisponible en mode hors ligne', 'Action indisponible');
      throw new Error('Suppression indisponible en mode hors ligne');
    }
    
    return this.http.delete<void>(`${this.apiUrl}/lines/${id}`).pipe(
      tap(() => {
        this.invalidateHeadersCache();
        this.toastr.success('Employé supprimé avec succès', 'Succès');
      }),
      catchError(error => {
        console.error('❌ Erreur deleteLine:', error);
        this.toastr.error('Erreur lors de la suppression', 'Erreur');
        throw error;
      })
    );
  }

  verifyFaceAndMarkPresence(headerId: string, matricule: string, day: number, imageBase64: string): Observable<any> {
    if (this.appMode.isOffline) {
      console.log('📱 Mode offline - Reconnaissance faciale indisponible');
      this.toastr.warning('Reconnaissance faciale indisponible en mode hors ligne', 'Action indisponible');
      throw new Error('Reconnaissance faciale indisponible en mode hors ligne');
    }
    
    const url = `${this.apiUrl}/scan-presence`;
    const body = {
      headerId: headerId,
      matricule: matricule,
      day: day,
      capturedImageBase64: imageBase64
    };
    console.log('📤 Envoi requête scan - URL:', url);
    return this.http.post(url, body);
  }

  // ==================== MÉTHODES CACHE ====================
  
  private invalidateHeadersCache(): void {
    this.cacheService.invalidateCache(this.CACHE_KEY_HEADERS);
  }
  
  private invalidateCache(id: string): void {
    this.cacheService.invalidateCache(this.CACHE_KEY_DETAIL_PREFIX + id);
  }
  
  async preloadForOffline(): Promise<boolean> {
    console.log('📦 Préchargement des pointages employés...');
    
    try {
      const headers = await this.getAllHeaders().toPromise();
      if (headers && headers.length > 0) {
        for (const header of headers) {
          if (header.id && !header.id.startsWith(this.OFFLINE_PREFIX)) {
            await this.getFullAttendance(header.id).toPromise();
          }
        }
      }
      console.log('✅ Pointages employés préchargés');
      return true;
    } catch (error) {
      console.error('❌ Erreur préchargement attendance:', error);
      return false;
    }
  }
}