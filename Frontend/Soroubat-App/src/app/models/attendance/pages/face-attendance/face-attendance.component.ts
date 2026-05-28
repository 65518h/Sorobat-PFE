// src/app/modules/attendance/pages/face-attendance/face-attendance.component.ts

import { Component, OnInit, OnDestroy, ViewChild, ElementRef, ChangeDetectorRef, NgZone, AfterViewInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router, ActivatedRoute } from '@angular/router';
import { FormsModule } from '@angular/forms';

// Angular Material
import { MatCardModule } from '@angular/material/card';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { MatSnackBar, MatSnackBarModule } from '@angular/material/snack-bar';
import { MatInputModule } from '@angular/material/input';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatTooltipModule } from '@angular/material/tooltip';

// Services
import { FaceRecognitionService, RecognitionResult } from '../../services/face-recognition.service';
import { AttendanceService } from '../../services/attendance.service';
import { AuthService } from '../../../../core/services/auth';
import { SoundService } from '../../../../core/services/sound.service';
import { EmployeeService, Employee } from '../../services/employee.service';
import { ToastrService } from 'ngx-toastr';

@Component({
  selector: 'app-face-attendance',
  standalone: true,
  imports: [
    CommonModule,
    FormsModule,
    MatCardModule,
    MatButtonModule,
    MatIconModule,
    MatProgressSpinnerModule,
    MatSnackBarModule,
    MatInputModule,
    MatFormFieldModule,
    MatTooltipModule
  ],
  templateUrl: './face-attendance.component.html',
  styleUrls: ['./face-attendance.component.css']
})
export class FaceAttendanceComponent implements OnInit, OnDestroy, AfterViewInit {
  
  @ViewChild('videoElement') videoElement!: ElementRef<HTMLVideoElement>;
  
  // États
  isCameraActive = false;
  isLoading = true;
  isRecognizing = false;
  isVerifyingMatricule = false;
  showGuide = true;
  cameraErrorMessage = '';
  loadingMessage = 'Initialisation de la caméra...';
  cameraStarted = false;
  
  // Matricule
  matriculeVerified = false;
  matriculeError = false;
  matriculeErrorMessage = '';
  employeeMatricule = '';
  verifiedEmployee: Employee | null = null;
  
  // Résultat
  recognitionResult: RecognitionResult | null = null;
  retryCount = 0;
  maxRetries = 3;
  
  // Mode marquage direct (depuis le formulaire de pointage)
  markAttendanceMode: boolean = false;
  targetHeaderId: string = '';
  targetDay: number = 0;
  
  private stream: MediaStream | null = null;
  private cameraInitialized = false;
  
  constructor(
    private faceService: FaceRecognitionService,
    private attendanceService: AttendanceService,
    private employeeService: EmployeeService,
    private snackBar: MatSnackBar,
    private router: Router,
    private route: ActivatedRoute,
    private authService: AuthService,
    private cdr: ChangeDetectorRef,
    private ngZone: NgZone,
    private soundService: SoundService,
    private toastr: ToastrService
  ) {}
  
  ngOnInit(): void {
    console.log('FaceAttendanceComponent initialisé');
    
    // Vérifier les paramètres de query pour le marquage direct
    this.route.queryParams.subscribe(params => {
      console.log(' Query params reçus:', params);
      
      if (params['mode'] === 'mark-attendance' && params['headerId'] && params['employeeMatricule'] && params['day']) {
        this.markAttendanceMode = true;
        this.targetHeaderId = params['headerId'];
        this.targetDay = parseInt(params['day']);
        
        // Auto-remplir le matricule
        this.employeeMatricule = params['employeeMatricule'];
        
        console.log(' Mode marquage activé:', {
          headerId: this.targetHeaderId,
          employeeMatricule: this.employeeMatricule,
          day: this.targetDay
        });
        
        // Vérifier automatiquement le matricule
        setTimeout(() => {
          this.verifyMatricule();
        }, 100);
      }
    });
  }
  
  ngAfterViewInit(): void {
    console.log('ngAfterViewInit - videoElement existe?', !!this.videoElement);
    if (this.matriculeVerified && this.cameraStarted && !this.cameraInitialized) {
      this.startCamera();
    }
  }
  
  ngOnDestroy(): void {
    this.stopCamera();
  }
  
  // ==================== VÉRIFICATION MATRICULE ====================
  
  async verifyMatricule(): Promise<void> {
    if (!this.employeeMatricule || this.employeeMatricule.trim() === '') {
      this.matriculeErrorMessage = 'Veuillez saisir un matricule';
      this.matriculeError = true;
      this.cdr.detectChanges();
      return;
    }
    
    this.isVerifyingMatricule = true;
    this.matriculeError = false;
    this.cdr.detectChanges();
    
    try {
      console.log(' Vérification du matricule:', this.employeeMatricule);
      const employee = await this.employeeService.getEmployeeByMatricule(this.employeeMatricule).toPromise();
      
      if (employee && employee.matricule === this.employeeMatricule) {
        console.log(' Employé trouvé:', employee);
        this.verifiedEmployee = employee;
        this.matriculeVerified = true;
        this.cameraStarted = true;
        
        this.toastr.success(`${employee.firstName} ${employee.lastName}`, ' Employé trouvé', {
          positionClass: 'toast-top-right',
          timeOut: 2000,
          progressBar: true,
          closeButton: true
        });
        
        this.cdr.detectChanges();
        
        setTimeout(() => {
          console.log(' Vérification après setTimeout - videoElement existe?', !!this.videoElement);
          if (this.videoElement) {
            this.startCamera();
          } else {
            console.error(' videoElement toujours pas disponible');
            this.cameraErrorMessage = 'Erreur technique: caméra non disponible';
            this.isLoading = false;
            this.cdr.detectChanges();
          }
        }, 500);
      } else {
        console.log(' Matricule non trouvé');
        this.matriculeError = true;
        this.matriculeErrorMessage = `Le matricule "${this.employeeMatricule}" n'existe pas.`;
        this.soundService.playFaceErrorSound();
        this.toastr.error(`Matricule "${this.employeeMatricule}" non trouvé`, '❌ Erreur', {
          positionClass: 'toast-top-right',
          timeOut: 3000,
          progressBar: true,
          closeButton: true
        });
      }
    } catch (error) {
      console.error(' Erreur lors de la vérification:', error);
      this.matriculeError = true;
      this.matriculeErrorMessage = 'Erreur de vérification. Veuillez réessayer.';
      this.soundService.playFaceErrorSound();
      this.toastr.error('Erreur de vérification', ' Erreur', {
        positionClass: 'toast-top-right',
        timeOut: 3000,
        progressBar: true,
        closeButton: true
      });
    } finally {
      this.isVerifyingMatricule = false;
      this.cdr.detectChanges();
    }
  }
  
  resetMatricule(): void {
    console.log(' Reset du matricule');
    this.matriculeVerified = false;
    this.matriculeError = false;
    this.cameraStarted = false;
    this.cameraInitialized = false;
    this.employeeMatricule = '';
    this.verifiedEmployee = null;
    this.recognitionResult = null;
    this.retryCount = 0;
    this.cameraErrorMessage = '';
    this.isLoading = true;
    this.isCameraActive = false;
    this.markAttendanceMode = false;
    this.targetHeaderId = '';
    this.targetDay = 0;
    this.stopCamera();
    this.cdr.detectChanges();
  }
  
  // ==================== CAMÉRA ====================
  
  async startCamera(): Promise<void> {
    console.log(' startCamera appelée');
    console.log('matriculeVerified:', this.matriculeVerified);
    console.log('videoElement existe?', !!this.videoElement);
    
    if (this.cameraInitialized) {
      console.log(' Caméra déjà initialisée');
      return;
    }
    
    if (!this.videoElement || !this.videoElement.nativeElement) {
      console.error(' videoElement non disponible');
      this.cameraErrorMessage = 'Composant vidéo non disponible. Veuillez réessayer.';
      this.isLoading = false;
      this.cdr.detectChanges();
      return;
    }
    
    this.isLoading = true;
    this.loadingMessage = 'Demande d\'accès à la caméra...';
    this.cameraErrorMessage = '';
    this.isCameraActive = false;
    this.cdr.detectChanges();
    
    try {
      console.log(' Demande d\'accès à la caméra...');
      this.stream = await navigator.mediaDevices.getUserMedia({ 
        video: { 
          width: { ideal: 640 }, 
          height: { ideal: 480 }, 
          facingMode: 'user' 
        } 
      });
      
      console.log(' Caméra accédée avec succès');
      this.videoElement.nativeElement.srcObject = this.stream;
      
      await new Promise((resolve) => {
        this.videoElement.nativeElement.onloadedmetadata = () => {
          console.log(' Video metadata chargée');
          resolve(null);
        };
      });
      
      await this.videoElement.nativeElement.play();
      console.log('▶ Video en cours de lecture');
      
      this.isCameraActive = true;
      this.isLoading = false;
      this.cameraInitialized = true;
      this.cdr.detectChanges();
      
    } catch (error: any) {
      console.error(' Erreur lors de l\'accès à la caméra:', error);
      if (error.name === 'NotAllowedError') {
        this.cameraErrorMessage = 'Accès à la caméra refusé. Veuillez autoriser l\'accès.';
      } else if (error.name === 'NotFoundError') {
        this.cameraErrorMessage = 'Aucune caméra trouvée sur cet appareil.';
      } else if (error.name === 'NotReadableError') {
        this.cameraErrorMessage = 'La caméra est déjà utilisée par une autre application.';
      } else {
        this.cameraErrorMessage = error.message || 'Impossible d\'accéder à la caméra';
      }
      this.isLoading = false;
      this.cameraInitialized = false;
      this.cdr.detectChanges();
    }
  }
  
  retryCamera(): void {
    console.log(' Réessai de la caméra');
    this.cameraErrorMessage = '';
    this.cameraInitialized = false;
    this.isLoading = true;
    this.isCameraActive = false;
    this.cdr.detectChanges();
    
    setTimeout(() => {
      this.startCamera();
    }, 500);
  }
  
  stopCamera(): void {
    console.log(' Arrêt de la caméra');
    if (this.stream) {
      this.stream.getTracks().forEach(track => {
        track.stop();
        console.log('   Track arrêté:', track.kind);
      });
      this.stream = null;
    }
    if (this.videoElement?.nativeElement) {
      this.videoElement.nativeElement.srcObject = null;
    }
    this.isCameraActive = false;
    this.cameraInitialized = false;
  }
  
  // ==================== RECONNAISSANCE ====================
  
  async verifyFace(): Promise<void> {
    if (!this.isCameraActive || !this.videoElement?.nativeElement) {
      this.toastr.warning('Caméra non disponible', '⚠️ Attention');
      return;
    }
    
    this.isRecognizing = true;
    this.retryCount++;
    this.showGuide = false;
    this.cdr.detectChanges();
    
    try {
      console.log(' Vérification faciale pour matricule:', this.employeeMatricule);
      
      let result: RecognitionResult;
      
      if (this.markAttendanceMode && this.targetHeaderId && this.targetDay) {
        console.log(' Mode marquage - utilisation de scan-presence');
        result = await this.faceService.verifyFaceAndMarkPresence(
          this.targetHeaderId,
          this.employeeMatricule,
          this.targetDay,
          this.videoElement.nativeElement
        );
      } else {
        console.log(' Mode simple - utilisation de Employee/scan');
        result = await this.faceService.verifyFaceWithBackend(
          this.videoElement.nativeElement,
          this.employeeMatricule
        );
      }
      
      console.log(' Résultat de la vérification:', result);
      
      //  Afficher le résultat dans la carte
      this.recognitionResult = result;
      
      //  Arrêter la caméra pour afficher le résultat
      this.stopCamera();
      this.isCameraActive = false;
      
      if (result.success) {
        this.soundService.playFaceSuccessSound();
        
        //  EN MODE SIMPLE : NE PAS CRÉER D'EN-TÊTE
        // Au lieu de créer un en-tête, informer l'utilisateur qu'il doit se rendre dans le formulaire
        if (!this.markAttendanceMode) {
          //  Ne pas créer d'en-tête ! Juste informer l'utilisateur
          this.recognitionResult.message = `${this.verifiedEmployee?.firstName} ${this.verifiedEmployee?.lastName} reconnu(e). Veuillez ouvrir un formulaire de pointage pour marquer la présence.`;
        }
      } else {
        this.soundService.playFaceErrorSound();
        this.showGuide = true;
      }
      
    } catch (error) {
      console.error(' Erreur lors de la vérification faciale:', error);
      this.soundService.playFaceErrorSound();
      this.recognitionResult = {
        success: false,
        message: 'Erreur technique lors de la vérification'
      };
      this.stopCamera();
      this.isCameraActive = false;
    } finally {
      this.isRecognizing = false;
      this.cdr.detectChanges();
    }
  }
  
  //  SUPPRIMER la méthode markAttendance() - elle n'est plus nécessaire
  
  retryFace(): void {
    console.log(' Nouvel essai de vérification faciale');
    this.recognitionResult = null;
    this.showGuide = true;
    this.retryCount = 0;
    
    // Redémarrer la caméra
    setTimeout(() => {
      this.startCamera();
    }, 500);
    
    this.cdr.detectChanges();
  }
  
  close(): void {
    console.log(' Fermeture du composant');
    this.stopCamera();
    
    // Redirection selon le mode
    if (this.markAttendanceMode && this.targetHeaderId) {
      this.router.navigate(['/attendance', 'edit', this.targetHeaderId]);
    } else {
      this.router.navigate(['/attendance']);
    }
  }
}