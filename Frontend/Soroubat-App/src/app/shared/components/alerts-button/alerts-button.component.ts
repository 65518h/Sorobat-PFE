// src/app/shared/components/alerts-button/alerts-button.component.ts

import { Component, Input, OnInit, OnDestroy } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router } from '@angular/router';
import { Subject, takeUntil } from 'rxjs';
import { MatIconModule } from '@angular/material/icon';
import { MatTooltipModule } from '@angular/material/tooltip';
import { ToastrService } from 'ngx-toastr';

import { AlertsCounterService } from '../../../core/services/alerts-counter.service';
import { SoundService } from '../../../core/services/sound.service';  //  Importer SoundService

@Component({
  selector: 'app-alerts-button',
  standalone: true,
  imports: [CommonModule, MatIconModule, MatTooltipModule],
  template: `
    <button class="alerts-btn" 
            [class.has-alerts]="count > 0"
            (click)="navigateToAlerts()"
            [matTooltip]="getTooltipText()">
      <mat-icon>notifications_active</mat-icon>
      <span>{{ label }}</span>
      
      
    </button>
  `,
  styles: [`
    .alerts-btn {
      position: relative;
      display: inline-flex;
      align-items: center;
      gap: 10px;
      padding: 12px 24px;
      background: rgba(255, 255, 255, 0.15);
      backdrop-filter: blur(10px);
      border: 1px solid rgba(255, 255, 255, 0.3);
      border-radius: 60px;
      font-size: 14px;
      font-weight: 600;
      color: white;
      cursor: pointer;
      transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
      overflow: visible !important;
      white-space: nowrap;
    }

    

    .alerts-btn:hover::before {
      left: 100%;
    }

    .alerts-btn:hover {
      transform: translateY(-3px);
      background: rgba(255, 255, 255, 0.25);
      border-color: rgba(255, 255, 255, 0.5);
      box-shadow: 0 10px 25px -8px rgba(0, 0, 0, 0.2);
    }

    .alerts-btn:active {
      transform: translateY(0px);
    }

    .alerts-btn.has-alerts {
      background: rgba(247, 37, 133, 0.35);
      border-color: #f72585;
      box-shadow: 0 0 0 1px rgba(247, 37, 133, 0.5);
      animation: pulseBorderAlert 1.5s infinite;
    }

    @keyframes pulseBorderAlert {
      0%, 100% {
        border-color: rgba(247, 37, 133, 0.5);
        box-shadow: 0 0 0 0 rgba(247, 37, 133, 0.2);
      }
      50% {
        border-color: rgba(247, 37, 133, 1);
        box-shadow: 0 0 0 4px rgba(247, 37, 133, 0.4);
      }
    }

    .alerts-btn mat-icon {
      font-size: 20px;
      width: 20px;
      height: 20px;
      filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.1));
      transition: transform 0.3s ease;
    }

    .alerts-btn:hover mat-icon {
      transform: scale(1.1);
    }

    .alerts-btn span {
      font-size: 13px;
      font-weight: 600;
      letter-spacing: 0.5px;
    }

    .alert-badge {
      position: absolute;
      top: -10px;
      right: -10px;
      background: linear-gradient(135deg, #ef4444, #dc2626);
      color: white;
      font-size: 11px;
      font-weight: 800;
      min-width: 22px;
      height: 22px;
      border-radius: 22px;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 0 7px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
      animation: bounceBadge 0.5s ease-out;
      z-index: 10;
      pointer-events: none;
      font-family: monospace;
    }

    @keyframes bounceBadge {
      0% {
        transform: scale(0);
        opacity: 0;
      }
      60% {
        transform: scale(1.2);
      }
      100% {
        transform: scale(1);
        opacity: 1;
      }
    }

    @media (max-width: 768px) {
      .alerts-btn span:not(.alert-badge) {
        display: none;
      }
      
      .alerts-btn {
        padding: 10px 16px;
        gap: 0;
      }
      
      .alerts-btn mat-icon {
        margin: 0;
      }
      
      .alert-badge {
        top: -8px;
        right: -8px;
        min-width: 20px;
        height: 20px;
        font-size: 10px;
      }
    }

    @media (max-width: 480px) {
      .alerts-btn {
        padding: 8px 12px;
      }
      
      .alerts-btn mat-icon {
        font-size: 18px;
        width: 18px;
        height: 18px;
      }
    }
  `]
})
export class AlertsButtonComponent implements OnInit, OnDestroy {
  
  @Input() domain: string = '';
  @Input() label: string = 'Alertes';
  @Input() showToast: boolean = true;
  @Input() playSound: boolean = true;  //  Option pour activer/désactiver le son
  
  count: number = 0;
  private destroy$ = new Subject<void>();
  
  constructor(
    private alertsCounterService: AlertsCounterService,
    private toastr: ToastrService,
    private router: Router,
    private soundService: SoundService  //  Injecter SoundService
  ) {}
  
  ngOnInit(): void {
    this.alertsCounterService.counts$
      .pipe(takeUntil(this.destroy$))
      .subscribe(counts => {
        switch(this.domain) {
          case 'gasoil':
            this.count = counts.gasoil || 0;
            break;
          case 'purchaseRequests':
            this.count = counts.purchaseRequests || 0;
            break;
          case 'transfers':
            this.count = counts.transfers || 0;
            break;
          case 'stock':
            this.count = counts.stock || 0;
            break;
          case 'vehicules':
            this.count = counts.vehicules || 0;
            break;
          case 'attendance':
            this.count = counts.attendance || 0;
            break;
          default:
            this.count = 0;
        }
      });
  }
  
  ngOnDestroy(): void {
    this.destroy$.next();
    this.destroy$.complete();
  }
  
  getTooltipText(): string {
    if (this.count === 0) {
      return `Aucune alerte dans ${this.getDomainName()}`;
    }
    return `${this.count} alerte(s) dans ${this.getDomainName()}`;
  }
  
  private getDomainName(): string {
    const names: { [key: string]: string } = {
      gasoil: 'Gasoil',
      purchaseRequests: 'Demandes d\'achat',
      transfers: 'Ordres de transfert',
      stock: 'Stock',
      vehicules: 'Engins',
      attendance: 'Pointage employés'
    };
    return names[this.domain] || this.domain;
  }
  
  navigateToAlerts(): void {
    // ✅ Jouer le son si playSound est true ET s'il y a des alertes (ou toujours)
    if (this.playSound) {
      if (this.count > 0) {
        // Son pour notification (plus attentionné)
        this.soundService.playDefaultSound();
      } else {
        // Son simple pour action sans alerte
        this.soundService.playDefaultSound();
      }
    }
    
    // Afficher le toast
    if (this.showToast && this.count > 0) {
      this.toastr.info(
        ` Vous avez ${this.count} alerte(s) dans ${this.getDomainName()}`,
        'Alertes disponibles',
        {
          positionClass: 'toast-top-right',
          timeOut: 3000,
          closeButton: true,
          progressBar: true
        }
      );
    } else if (this.showToast && this.count === 0) {
      this.toastr.success(
        ` Aucune alerte dans ${this.getDomainName()}`,
        'Tout est sous contrôle',
        {
          positionClass: 'toast-top-right',
          timeOut: 2000,
          closeButton: true
        }
      );
    }
    
    // Navigation vers la page des alertes
    this.router.navigate(['/alerts'], {
      queryParams: { 
        filterDomain: this.domain,
        source: this.domain
      }
    });
  }
}