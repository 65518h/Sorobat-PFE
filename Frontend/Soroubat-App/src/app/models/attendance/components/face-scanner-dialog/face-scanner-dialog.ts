// src/app/modules/attendance/components/face-scanner-dialog/face-scanner-dialog.ts

import { Component, Inject, ViewChild, ElementRef, AfterViewInit, OnDestroy, ChangeDetectorRef, NgZone } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MAT_DIALOG_DATA, MatDialogRef, MatDialogModule } from '@angular/material/dialog';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { AttendanceService } from '../../services/attendance.service';
import { ToastrService } from 'ngx-toastr';
import { SoundService } from '../../../../core/services/sound.service';

export interface FaceScannerData {
  headerId: string;
  employeeMatricule: string;
  day: number;
  employeeName: string;
}

export interface ScanResult {
  success: boolean;
  message: string;
}

@Component({
  selector: 'app-face-scanner-dialog',
  standalone: true,
  imports: [
    CommonModule,
    MatDialogModule,
    MatButtonModule,
    MatIconModule,
    MatProgressSpinnerModule
  ],
  templateUrl: './face-scanner-dialog.html',
  styleUrls: ['./face-scanner-dialog.css']
})
export class FaceScannerDialogComponent implements AfterViewInit, OnDestroy {
  
  @ViewChild('videoElement') videoElement!: ElementRef<HTMLVideoElement>;
  
  isCameraReady = false;
  isProcessing = false;
  showGuide = true;
  processingMessage = 'Analyse du visage...';
  result: ScanResult | null = null;
  isSuccess = false;
  isError = false;
  cameraError = false;
  faceAttempts: number = 0;
  
  private stream: MediaStream | null = null;
  private canvas: HTMLCanvasElement | null = null;
  private retryCount = 0;
  
  constructor(
    @Inject(MAT_DIALOG_DATA) public data: FaceScannerData,
    private dialogRef: MatDialogRef<FaceScannerDialogComponent>,
    private attendanceService: AttendanceService,
    private toastr: ToastrService,
    private soundService: SoundService,
    private cdr: ChangeDetectorRef,
    private ngZone: NgZone
  ) {
    this.canvas = document.createElement('canvas');
    console.log('FaceScannerDialogComponent initialisé');
  }
  
  ngAfterViewInit(): void {
    console.log('ngAfterViewInit - Démarrage caméra');
    console.log('Video element:', this.videoElement);
    
    setTimeout(() => {
      this.startCamera();
    }, 500);
  }
  
  ngOnDestroy(): void {
    this.stopCamera();
  }
  
  async startCamera(): Promise<void> {
    this.stopCamera();
    this.isCameraReady = false;
    this.cameraError = false;
    this.cdr.detectChanges();
    
    if (!this.videoElement || !this.videoElement.nativeElement) {
      console.error('Video element non trouvé, nouvel essai dans 200ms');
      setTimeout(() => {
        this.startCamera();
      }, 200);
      return;
    }
    
    try {
      console.log('Demande d\'accès à la caméra...');
      
      //  Utiliser la caméra ARRIÈRE (environment) pour une meilleure détection
      this.stream = await navigator.mediaDevices.getUserMedia({
        video: { 
          width: { ideal: 1280, max: 1920 },
          height: { ideal: 720, max: 1080 },
          facingMode: 'environment',  //  Caméra arrière pour plus de netteté
          frameRate: { ideal: 30 }
        }
      });
      
      console.log('Stream obtenu:', this.stream);
      
      if (this.videoElement && this.videoElement.nativeElement) {
        if (this.videoElement.nativeElement.srcObject) {
          const oldStream = this.videoElement.nativeElement.srcObject as MediaStream;
          oldStream.getTracks().forEach(track => track.stop());
        }
        
        this.videoElement.nativeElement.srcObject = this.stream;
        this.videoElement.nativeElement.onloadedmetadata = () => {
          console.log('Video metadata chargées');
          this.videoElement.nativeElement.play()
            .then(() => {
              console.log('Video en cours de lecture');
              this.isCameraReady = true;
              this.cdr.detectChanges();
            })
            .catch((err) => {
              console.error('Erreur play():', err);
              this.cameraError = true;
              this.toastr.error('Erreur lors du démarrage de la caméra');
              this.cdr.detectChanges();
            });
        };
      }
    } catch (error: any) {
      console.error('Erreur getUserMedia:', error);
      this.cameraError = true;
      this.cdr.detectChanges();
      
      if (error.name === 'NotAllowedError') {
        this.toastr.error('Accès à la caméra refusé. Veuillez autoriser l\'accès.');
      } else if (error.name === 'NotFoundError') {
        this.toastr.error('Aucune caméra trouvée sur cet appareil.');
      } else if (error.name === 'NotReadableError') {
        this.toastr.error('La caméra est déjà utilisée par une autre application.');
      } else {
        this.toastr.error('Impossible d\'accéder à la caméra');
      }
    }
  }
  
  stopCamera(): void {
    console.log('Arrêt de la caméra');
    if (this.stream) {
      this.stream.getTracks().forEach(track => {
        track.stop();
        console.log('Track arrêté:', track.kind);
      });
      this.stream = null;
    }
    if (this.videoElement?.nativeElement) {
      if (this.videoElement.nativeElement.srcObject) {
        const oldStream = this.videoElement.nativeElement.srcObject as MediaStream;
        oldStream.getTracks().forEach(track => track.stop());
        this.videoElement.nativeElement.srcObject = null;
      }
    }
    this.isCameraReady = false;
  }
  
  captureAndVerify(): void {
    console.log('captureAndVerify appelé');
    console.log('isCameraReady:', this.isCameraReady);
    
    if (!this.isCameraReady) {
      this.toastr.warning('Caméra non prête, veuillez patienter');
      this.startCamera();
      return;
    }
    
    if (!this.videoElement || !this.videoElement.nativeElement) {
      console.error('Video element non trouvé');
      this.toastr.error('Erreur technique');
      return;
    }
    
    const video = this.videoElement.nativeElement;
    
    if (video.videoWidth === 0 || video.videoHeight === 0) {
      console.error('Vidéo non prête, dimensions invalides');
      this.toastr.warning('Veuillez patienter, la caméra s\'initialise');
      return;
    }
    
    this.isProcessing = true;
    this.processingMessage = 'Capture en cours...';
    this.showGuide = false;
    this.cdr.detectChanges();
    
    //  Attendre 500ms pour stabiliser l'image
    setTimeout(() => {
      try {
        if (!this.canvas) {
          this.canvas = document.createElement('canvas');
        }
        
        //  Augmenter la résolution pour une meilleure détection
        const targetWidth = 800;
        const targetHeight = 600;
        
        this.canvas.width = targetWidth;
        this.canvas.height = targetHeight;
        
        console.log(`Canvas dimensions: ${this.canvas.width}x${this.canvas.height}`);
        
        const context = this.canvas.getContext('2d');
        
        if (!context) {
          console.error('Impossible d\'obtenir le contexte 2D');
          this.toastr.error('Erreur lors de la capture');
          this.isProcessing = false;
          this.cdr.detectChanges();
          return;
        }
        
        //  NE PAS appliquer le miroir pour la caméra arrière
        context.drawImage(video, 0, 0, this.canvas.width, this.canvas.height);
        
        //  Meilleure qualité JPEG
        const imageBase64 = this.canvas.toDataURL('image/jpeg', 0.95);
        
        if (!imageBase64 || imageBase64 === 'data:,') {
          console.error('Image capture invalide');
          this.toastr.error('Erreur lors de la capture');
          this.isProcessing = false;
          this.cdr.detectChanges();
          return;
        }
        
        console.log('Image capturée, taille:', imageBase64.length);
        
        this.processingMessage = 'Vérification faciale...';
        this.cdr.detectChanges();
        
        this.attendanceService.verifyFaceAndMarkPresence(
          this.data.headerId,
          this.data.employeeMatricule,
          this.data.day,
          imageBase64
        ).subscribe({
          next: (response) => {
            this.ngZone.run(() => {
              console.log('Réponse API succès:', response);
              this.isProcessing = false;
              this.isSuccess = true;
              this.soundService.playFaceSuccessSound();
              
              this.result = {
                success: true,
                message: response.message || `✓ Présence marquée pour le jour ${this.data.day}`
              };
              this.cdr.detectChanges();
              
              setTimeout(() => {
                this.close(true);
              }, 2000);
            });
          },
          error: (error) => {
            this.ngZone.run(() => {
              console.error('Erreur API:', error);
              this.isProcessing = false;
              this.isError = true;
              this.soundService.playFaceErrorSound();
              
              this.faceAttempts++;
              
              let errorMessage = error.error?.message || '✗ Reconnaissance faciale échouée';
              
              if (this.faceAttempts >= 3) {
                errorMessage += '\n\n💡 Conseils :\n• Assurez-vous d\'être bien éclairé(e)\n• Regardez directement la caméra\n• Placez votre visage bien dans le cadre';
              }
              
              this.result = {
                success: false,
                message: errorMessage
              };
              this.cdr.detectChanges();
            });
          }
        });
        
      } catch (error) {
        console.error('Erreur lors de la capture:', error);
        this.ngZone.run(() => {
          this.isProcessing = false;
          this.isError = true;
          this.soundService.playFaceErrorSound();
          this.toastr.error('Erreur lors de la capture');
          this.cdr.detectChanges();
        });
      }
    }, 500);
  }
  
  retry(): void {
    console.log('Retry - Réinitialisation de la caméra');
    
    this.result = null;
    this.showGuide = true;
    this.isProcessing = false;
    this.isSuccess = false;
    this.isError = false;
    this.isCameraReady = false;
    this.cameraError = false;
    
    this.cdr.detectChanges();
    
    setTimeout(() => {
      this.startCamera();
    }, 200);
  }
  
  close(success: boolean): void {
    this.stopCamera();
    this.dialogRef.close({ success, day: this.data.day, matricule: this.data.employeeMatricule });
  }
  
  cancel(): void {
    this.stopCamera();
    this.dialogRef.close(null);
  }
}