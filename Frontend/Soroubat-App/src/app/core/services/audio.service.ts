// src/app/core/services/audio.service.ts

import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class AudioService {
  private scanSuccessAudio: HTMLAudioElement | null = null;
  private scanErrorAudio: HTMLAudioElement | null = null;
  private successAudio: HTMLAudioElement | null = null;
  
  constructor() {
    this.initSounds();
  }
  
  private initSounds(): void {
    try {
      this.scanSuccessAudio = new Audio('/sounds/Scanner-Beep.mp3');
      this.scanErrorAudio = new Audio('/sounds/Error1.mp3');
      this.successAudio = new Audio('/sounds/success.mp3');
      
      if (this.scanSuccessAudio) this.scanSuccessAudio.volume = 0.9;
      if (this.scanErrorAudio) this.scanErrorAudio.volume = 0.9;
      if (this.successAudio) this.successAudio.volume = 0.9;
      
      this.scanSuccessAudio?.load();
      this.scanErrorAudio?.load();
      this.successAudio?.load();
      
      console.log('✅ Sons chargés depuis /sounds/');
    } catch (error) {
      console.warn('Erreur chargement sons:', error);
    }
  }
  
  playScanSuccess(): void {
    if (this.scanSuccessAudio) {
      this.scanSuccessAudio.currentTime = 0;
      this.scanSuccessAudio.play().catch(err => console.warn('Lecture son impossible:', err));
    } else {
      this.beepFallback(880, 150);
    }
  }
  
  playSuccess(): void {
    if (this.successAudio) {
      this.successAudio.currentTime = 0;
      this.successAudio.play().catch(err => console.warn('Lecture son impossible:', err));
    } else {
      this.beepFallback(880, 200);
    }
  }
  
  playError(): void {
    if (this.scanErrorAudio) {
      this.scanErrorAudio.currentTime = 0;
      this.scanErrorAudio.play().catch(err => console.warn('Lecture son impossible:', err));
    } else {
      this.beepFallback(440, 300);
    }
  }
  
  playScanStart(): void {
    this.beepFallback(660, 80);
  }
  
  private beepFallback(frequency: number, duration: number): void {
    try {
      const audioContext = new (window.AudioContext || (window as any).webkitAudioContext)();
      const oscillator = audioContext.createOscillator();
      const gainNode = audioContext.createGain();
      
      oscillator.connect(gainNode);
      gainNode.connect(audioContext.destination);
      
      oscillator.frequency.value = frequency;
      gainNode.gain.value = 0.5;
      
      oscillator.start();
      setTimeout(() => {
        oscillator.stop();
        audioContext.close();
      }, duration);
    } catch (error) {
      console.warn('Beep impossible:', error);
    }
  }
}