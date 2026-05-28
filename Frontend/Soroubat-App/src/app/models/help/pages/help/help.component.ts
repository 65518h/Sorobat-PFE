// src/app/modules/help/pages/help/help.component.ts

import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { MatCardModule } from '@angular/material/card';
import { MatIconModule } from '@angular/material/icon';
import { MatButtonModule } from '@angular/material/button';

@Component({
  selector: 'app-help',
  standalone: true,
  imports: [
    CommonModule,
    RouterModule,
    MatCardModule,
    MatIconModule,
    MatButtonModule
  ],
  templateUrl: './help.component.html',
  styleUrls: ['./help.component.css']
})
export class HelpComponent {
  expandedFaq: number | null = null;

  // Étapes du guide rapide
  quickStartSteps = [
    { num: 1, title: 'Consulter le tableau de bord', desc: 'Accédez à la vue d\'ensemble de vos chantiers', completed: false },
    { num: 2, title: 'Gérer vos demandes d\'achat', desc: 'Créez et suivez vos demandes d\'approvisionnement', completed: false },
    { num: 3, title: 'Suivre les alertes', desc: 'Restez informé des actions prioritaires', completed: false },
    { num: 4, title: 'Pointage des présences', desc: 'Enregistrez les présences des employés', completed: false }
  ];

  // FAQ
  faqs = [
    { 
      question: 'Comment créer une demande d\'achat ?', 
      answer: 'Rendez-vous dans la section "Demandes d\'achat" et cliquez sur "Nouvelle demande". Remplissez le formulaire avec les informations du produit, la quantité souhaitée et la date de livraison prévue. Une fois le formulaire validé, votre demande sera soumise à validation.' 
    },
    { 
      question: 'Comment voir mes alertes ?', 
      answer: 'Cliquez sur l\'icône de cloche  dans la barre de navigation pour voir toutes vos alertes non lues. Les alertes critiques apparaissent en rouge, les avertissements en orange et les informations en bleu.' 
    },
    { 
      question: 'Comment exporter des données ?', 
      answer: 'Dans chaque liste (projets, demandes, stock), utilisez le bouton "Exporter"  pour obtenir un fichier CSV ou Excel. Vous pouvez choisir le format et le périmètre des données à exporter.' 
    },
    { 
      question: 'Comment fonctionne le pointage des présences ?', 
      answer: 'Rendez-vous dans la section "Pointage", sélectionnez l\'employé et enregistrez sa présence pour chaque jour. Le système permet également le scan facial pour un pointage plus rapide.' 
    },
    { 
      question: 'Comment gérer les stocks ?', 
      answer: 'Accédez à la section "Stock" pour voir l\'inventaire. Vous pouvez scanner votre code a barre .' 
    }
  ];

 

  toggleFaq(index: number): void {
    this.expandedFaq = this.expandedFaq === index ? null : index;
  }

  openResource(link: string): void {
    window.open(link, '_blank');
  }
}