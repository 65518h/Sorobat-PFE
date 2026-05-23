// src/app/modules/attendance/services/face-recognition.service.ts

import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';

export interface RecognitionResult {
  success: boolean;
  message: string;
}

@Injectable({
  providedIn: 'root'
})
export class FaceRecognitionService {
  private apiUrl = 'http://localhost:5227/api';
  
  constructor(private http: HttpClient) {}
  
  /**
   * Vérification faciale simple (pour le pointage facial classique)
   */
  verifyFaceWithBackend(videoElement: HTMLVideoElement, matricule: string): Promise<RecognitionResult> {
    return new Promise((resolve) => {
      // Vérifier que l'élément vidéo est valide
      if (!videoElement || videoElement.videoWidth === 0 || videoElement.videoHeight === 0) {
        console.error('❌ Élément vidéo non valide');
        resolve({
          success: false,
          message: 'Caméra non prête, veuillez réessayer'
        });
        return;
      }
      
      // Capturer l'image depuis la vidéo
      const canvas = document.createElement('canvas');
      canvas.width = videoElement.videoWidth;
      canvas.height = videoElement.videoHeight;
      
      const context = canvas.getContext('2d');
      if (!context) {
        resolve({
          success: false,
          message: 'Erreur technique de capture'
        });
        return;
      }
      
      // Appliquer le miroir pour correspondre à l'affichage
      context.save();
      context.translate(canvas.width, 0);
      context.scale(-1, 1);
      context.drawImage(videoElement, 0, 0, canvas.width, canvas.height);
      context.restore();
      
      const imageBase64 = canvas.toDataURL('image/jpeg', 0.8);
      
      const payload = {
        matricule: matricule,
        capturedImageBase64: imageBase64
      };
      
      console.log('📸 Image capturée, taille:', imageBase64.length);
      
      this.http.post<any>(`${this.apiUrl}/Employee/scan`, payload)
        .subscribe({
          next: (response) => {
            console.log('📡 Réponse serveur:', response);
            resolve({
              success: true,
              message: response.message || 'Visage reconnu avec succès'
            });
          },
          error: (error) => {
            console.error('❌ Erreur reconnaissance:', error);
            resolve({
              success: false,
              message: error.error?.message || 'Reconnaissance faciale échouée'
            });
          }
        });
    });
  }
  
  /**
   * Vérification et marquage de présence (pour le formulaire de pointage)
   */
  verifyFaceAndMarkPresence(headerId: string, matricule: string, day: number, videoElement: HTMLVideoElement): Promise<RecognitionResult> {
    return new Promise((resolve) => {
      // Vérifier que l'élément vidéo est valide
      if (!videoElement || videoElement.videoWidth === 0 || videoElement.videoHeight === 0) {
        console.error('❌ Élément vidéo non valide');
        resolve({
          success: false,
          message: 'Caméra non prête, veuillez réessayer'
        });
        return;
      }
      
      // Capturer l'image depuis la vidéo
      const canvas = document.createElement('canvas');
      canvas.width = videoElement.videoWidth;
      canvas.height = videoElement.videoHeight;
      
      const context = canvas.getContext('2d');
      if (!context) {
        resolve({
          success: false,
          message: 'Erreur technique de capture'
        });
        return;
      }
      
      // Appliquer le miroir
      context.save();
      context.translate(canvas.width, 0);
      context.scale(-1, 1);
      context.drawImage(videoElement, 0, 0, canvas.width, canvas.height);
      context.restore();
      
      const imageBase64 = canvas.toDataURL('image/jpeg', 0.8);
      
      const payload = {
        headerId: headerId,
        matricule: matricule,
        day: day,
        capturedImageBase64: imageBase64
      };
      
      console.log('📸 Image capturée pour marquage, taille:', imageBase64.length);
      console.log('📤 Payload:', { headerId, matricule, day });
      
      this.http.post<any>(`${this.apiUrl}/Attendance/scan-presence`, payload)
        .subscribe({
          next: (response) => {
            console.log('📡 Réponse serveur marquage:', response);
            resolve({
              success: true,
              message: response.message || `Présence marquée pour le jour ${day}`
            });
          },
          error: (error) => {
            console.error('❌ Erreur marquage:', error);
            resolve({
              success: false,
              message: error.error?.message || 'Reconnaissance faciale échouée'
            });
          }
        });
    });
  }
}