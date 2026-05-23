// src/app/models/transfers/pages/transfer-reception/transfer-reception.ts

import { Component, OnInit, OnDestroy, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router, ActivatedRoute, RouterModule } from '@angular/router';
import { ReactiveFormsModule, FormBuilder, FormGroup, FormArray, Validators } from '@angular/forms';
import { Subject, takeUntil, finalize, catchError, of } from 'rxjs';

// Angular Material Modules
import { MatCardModule } from '@angular/material/card';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatTableModule } from '@angular/material/table';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { MatTooltipModule } from '@angular/material/tooltip';
import { MatInputModule } from '@angular/material/input';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatDividerModule } from '@angular/material/divider';

// Services
import { TransferService } from '../../services/transfer.service';
import { NotificationService } from '../../../../core/services/notification';
import { AuthService } from '../../../../core/services/auth';
import { TransferHeader, TransferLine, getTransferStatusClass, getTransferStatusLabel, getTransferStatusIcon } from '../../models/transfer.model';

@Component({
  selector: 'app-transfer-reception',
  templateUrl: './transfer-form.html',
  styleUrls: ['./transfer-form.css'],
  standalone: true,
  imports: [
    CommonModule,
    ReactiveFormsModule,
    RouterModule,
    MatCardModule,
    MatButtonModule,
    MatIconModule,
    MatTableModule,
    MatProgressSpinnerModule,
    MatTooltipModule,
    MatInputModule,
    MatFormFieldModule,
    MatDividerModule
  ]
})
export class TransferReceptionComponent implements OnInit, OnDestroy {
  
  transfer: TransferHeader | null = null;
  loading: boolean = true;
  error: string | null = null;
  transferId: string | null = null;
  submitting: boolean = false;
  allReceived: boolean = false;
  
  receptionForm!: FormGroup;
  
  displayedColumns: string[] = ['itemNo', 'description', 'quantity', 'quantityReceived', 'remaining', 'unitOfMeasure', 'actions'];
  
  private destroy$ = new Subject<void>();
  
  constructor(
    private router: Router,
    private route: ActivatedRoute,
    private transferService: TransferService,
    private notificationService: NotificationService,
    private authService: AuthService,
    private fb: FormBuilder,
    private cdr: ChangeDetectorRef
  ) {}
  
  ngOnInit(): void {
    this.transferId = this.route.snapshot.paramMap.get('id');
    
    if (this.transferId) {
      this.loadTransfer();
    } else {
      this.error = 'ID de transfert non trouvé';
      this.loading = false;
    }
  }
  
  ngOnDestroy(): void {
    this.destroy$.next();
    this.destroy$.complete();
  }
  
  loadTransfer(): void {
    if (!this.transferId) return;
    
    this.loading = true;
    this.error = null;
    
    this.transferService.getById(this.transferId).pipe(
      takeUntil(this.destroy$),
      finalize(() => {
        this.loading = false;
        this.cdr.detectChanges();
      }),
      catchError((error) => {
        console.error('❌ Erreur:', error);
        this.error = 'Impossible de charger le transfert';
        return of(null);
      })
    ).subscribe({
      next: (transfer) => {
        if (transfer) {
          this.transfer = transfer;
          this.initForm();
          this.checkAllReceived();
        } else {
          this.error = 'Transfert non trouvé';
        }
      }
    });
  }
  
  initForm(): void {
    this.receptionForm = this.fb.group({
      lines: this.fb.array([])
    });
    
    if (this.transfer?.transferLines) {
      this.transfer.transferLines.forEach((line, index) => {
        const remaining = this.getRemainingQuantity(line);
        this.addLineForm(line, remaining);
      });
    }
  }
  
  get linesArray(): FormArray {
    return this.receptionForm.get('lines') as FormArray;
  }
  
  addLineForm(line: TransferLine, remaining: number): void {
    const lineForm = this.fb.group({
      id: [line.id],
      itemNo: [line.itemNo],
      description: [line.description],
      quantity: [line.quantity],
      quantityReceived: [line.quantityReceived || 0],
      quantityToReceive: [remaining, [Validators.required, Validators.min(0), Validators.max(remaining)]],
      unitOfMeasure: [line.unitOfMeasure],
      isComplete: [remaining === 0]
    });
    
    this.linesArray.push(lineForm);
  }
  
  updateQuantity(index: number): void {
    const lineForm = this.linesArray.at(index);
    const quantityToReceive = lineForm.get('quantityToReceive')?.value || 0;
    const remaining = this.getRemainingQuantity(this.transfer!.transferLines![index]);
    
    if (quantityToReceive < 0) {
      this.notificationService.showError('La quantité ne peut pas être négative');
      lineForm.patchValue({ quantityToReceive: 0 });
      return;
    }
    
    if (quantityToReceive > remaining) {
      this.notificationService.showError(`La quantité ne peut pas dépasser ${remaining}`);
      lineForm.patchValue({ quantityToReceive: remaining });
      return;
    }
    
    // Marquer comme complet si quantité = remaining
    const isComplete = quantityToReceive === remaining;
    lineForm.patchValue({ isComplete: isComplete });
    
    this.checkAllReceived();
  }
  
  getRemainingQuantity(line: TransferLine): number {
    return (line.quantity || 0) - (line.quantityReceived || 0);
  }
  
  getRemainingForLine(index: number): number {
    if (!this.transfer?.transferLines) return 0;
    return this.getRemainingQuantity(this.transfer.transferLines[index]);
  }
  
  checkAllReceived(): void {
    if (!this.transfer?.transferLines) return;
    
    let allCompleted = true;
    for (let i = 0; i < this.transfer.transferLines.length; i++) {
      const lineForm = this.linesArray.at(i);
      const isComplete = lineForm.get('isComplete')?.value;
      if (!isComplete) {
        allCompleted = false;
        break;
      }
    }
    this.allReceived = allCompleted;
  }
  
  receiveLine(index: number): void {
    const lineForm = this.linesArray.at(index);
    const lineId = lineForm.get('id')?.value;
    const quantityToReceive = lineForm.get('quantityToReceive')?.value;
    
    if (!lineId) return;
    
    if (quantityToReceive <= 0) {
      this.notificationService.showWarning('Veuillez saisir une quantité valide');
      return;
    }
    
    this.submitting = true;
    
    this.transferService.updateLineQuantity(lineId, quantityToReceive).pipe(
      takeUntil(this.destroy$),
      finalize(() => {
        this.submitting = false;
        this.cdr.detectChanges();
      })
    ).subscribe({
      next: () => {
        this.notificationService.showSuccess('Quantité réceptionnée avec succès');
        this.loadTransfer();
      },
      error: (error) => {
        console.error('❌ Erreur:', error);
        this.notificationService.showError('Erreur lors de la réception');
      }
    });
  }
  
  receiveAll(): void {
    if (!this.transfer?.id) return;
    
    const totalToReceive = this.getTotalToReceive();
    
    if (totalToReceive === 0) {
      this.notificationService.showWarning('Aucune quantité à réceptionner');
      return;
    }
    
    this.notificationService.showConfirmation({
      title: 'Réception complète',
      message: `Confirmer la réception de ${totalToReceive} article(s) ?`,
      confirmText: 'Valider',
      cancelText: 'Annuler'
    }).subscribe(confirmed => {
      if (confirmed) {
        this.submitting = true;
        
        this.transferService.receiveTransfer(this.transfer!.id!).pipe(
          takeUntil(this.destroy$),
          finalize(() => {
            this.submitting = false;
            this.cdr.detectChanges();
          })
        ).subscribe({
          next: () => {
            this.notificationService.showSuccess('Transfert réceptionné avec succès');
            this.router.navigate(['/transfers']);
          },
          error: (error) => {
            console.error('❌ Erreur:', error);
            this.notificationService.showError('Erreur lors de la réception');
          }
        });
      }
    });
  }
  
  getTotalToReceive(): number {
    let total = 0;
    for (let i = 0; i < this.linesArray.length; i++) {
      const lineForm = this.linesArray.at(i);
      total += lineForm.get('quantityToReceive')?.value || 0;
    }
    return total;
  }
  
  goBack(): void {
    this.router.navigate(['/transfers']);
  }
  
  getStatusClass(status: string | undefined): string {
    return getTransferStatusClass(status || '');
  }
  
  getStatusLabel(status: string | undefined): string {
    return getTransferStatusLabel(status || '');
  }
  
  getStatusIcon(status: string | undefined): string {
    return getTransferStatusIcon(status || '');
  }
  
  formatDate(date: string | Date | undefined): string {
    if (!date) return '';
    const d = new Date(date);
    return d.toLocaleDateString('fr-FR');
  }
  
  canReceive(): boolean {
    return this.transfer?.status === 'Released';
  }
}

export { TransferReceptionComponent as TransferReception };