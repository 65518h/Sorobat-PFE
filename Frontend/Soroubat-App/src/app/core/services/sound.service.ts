// src/app/core/services/sound.service.ts

import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class SoundService {
  private soundEnabled: boolean = true;
  private soundCache: Map<string, HTMLAudioElement> = new Map();
  
  // Définition des différents sons
  private readonly SOUNDS = {
    notification: '/sounds/notification-tone.mp3',  // Pour le dashboard
    default: '/sounds/universfield.mp3',            // Pour les autres
    faceSuccess: '/sounds/face-success.mp3',        // ✅ Succès du pointage facial
    faceError: '/sounds/face-error.mp3'             // ✅ Échec du pointage facial
  };
  
  constructor() {
    // Récupérer la préférence utilisateur
    const saved = localStorage.getItem('soundEnabled');
    this.soundEnabled = saved !== null ? saved !== 'false' : true;
    this.preloadSounds();
  }
  
  private preloadSounds(): void {
    // Précharger tous les sons
    Object.values(this.SOUNDS).forEach(soundPath => {
      try {
        const audio = new Audio(soundPath);
        audio.load();
        audio.volume = 0.9;
        this.soundCache.set(soundPath, audio);
        console.log(`✅ Son préchargé: ${soundPath}`);
      } catch (error) {
        console.log(`🔇 Erreur préchargement ${soundPath}:`, error);
      }
    });
  }
  
  /**
   * Joue le son de notification du dashboard
   */
  playNotificationSound(): void {
    this.playSound(this.SOUNDS.notification);
  }
  
  /**
   * Joue le son par défaut (universfield)
   */
  playDefaultSound(): void {
    this.playSound(this.SOUNDS.default);
  }
  
  /**
   * ✅ Joue le son de succès pour la reconnaissance faciale
   */
  playFaceSuccessSound(): void {
    this.playSound(this.SOUNDS.faceSuccess);
  }
  
  /**
   * ✅ Joue le son d'erreur pour la reconnaissance faciale
   */
  playFaceErrorSound(): void {
    this.playSound(this.SOUNDS.faceError);
  }
  
  /**
   * Joue un son spécifique
   * @param soundPath Chemin du fichier son
   */
  private playSound(soundPath: string): void {
    if (!this.soundEnabled) {
      console.log('🔇 Sons désactivés');
      return;
    }
    
    // Essayer d'utiliser le son en cache
    const cachedAudio = this.soundCache.get(soundPath);
    if (cachedAudio) {
      cachedAudio.currentTime = 0;
      cachedAudio.play()
        .then(() => {
          console.log(`✅ Son joué avec succès: ${soundPath}`);
        })
        .catch(err => {
          console.log(`🔇 Erreur lecture son ${soundPath}:`, err);
          this.fallbackPlay(soundPath);
        });
    } else {
      this.fallbackPlay(soundPath);
    }
  }
  
  private fallbackPlay(soundPath: string): void {
    const audio = new Audio(soundPath);
    audio.volume = 0.9;
    audio.play()
      .then(() => {
        console.log(`✅ Son (fallback) joué: ${soundPath}`);
      })
      .catch(err => {
        console.log(`🔇 Impossible de jouer le son ${soundPath}:`, err);
      });
  }
  
  /**
   * Active ou désactive les sons
   */
  toggleSound(): void {
    this.soundEnabled = !this.soundEnabled;
    localStorage.setItem('soundEnabled', String(this.soundEnabled));
    console.log(`🔊 Sons ${this.soundEnabled ? 'activés' : 'désactivés'}`);
  }
  
  /**
   * Définit l'état du son
   */
  setSoundEnabled(enabled: boolean): void {
    this.soundEnabled = enabled;
    localStorage.setItem('soundEnabled', String(enabled));
  }
  
  /**
   * Retourne l'état du son
   */
  isSoundEnabled(): boolean {
    return this.soundEnabled;
  }
}