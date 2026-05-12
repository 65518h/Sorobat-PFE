# 📄 Demande d'Achat (Purchase Request)

Une **Demande d'Achat** est un document interne permettant à un employé (ex : chef de chantier) ou à un service de demander l'achat de biens ou de services.

👉 Elle **initie le processus d'approvisionnement** et doit être **approuvée** avant d’être transformée en commande fournisseur.

---

# 🧩 Structure Fonctionnelle

Le système est basé sur deux éléments principaux :

- **Purchase Request (En-tête)**
- **Purchase Request Line (Lignes)**

---

# 📌 Purchase Request (En-tête)

La table **Purchase Request** est une table personnalisée dans *Microsoft Dynamics 365 Business Central*.

### 🎯 Objectif
Gérer les demandes d'achat internes **avant leur transformation en commande fournisseur**.

---

# 📌 Purchase Request Line (Lignes)

La page **Purchase Request Line** est une page de type `ListPart`.

### 🎯 Objectif
Permet de :
- Saisir les articles ou services demandés  
- Gérer les détails de chaque demande  

👉 Chaque ligne représente :
- Un produit  
- Un matériau  
- Ou une prestation  

🔗 Elle est **liée directement à l’en-tête (Purchase Request)**.

---

# 🔄 Cycle de vie d'une demande d'achat

```
1. Saisie de la demande
   ↓
2. Validation / Approbation des lignes
   ↓
3. Sélection des lignes à traiter (Transférer)
   ↓
4. Génération des commandes fournisseur
   ↓
5. Suivi via "Associated Purchase Order"
```

### 📝 Détails importants

- **Transférer** ✅  
  → Case à cocher pour sélectionner les lignes à convertir en commande fournisseur  

- **Associated Purchase Order** 🔗  
  → Lien automatique vers la commande fournisseur générée  

---

# 🌐 API - Purchase Request

### 🔗 URL
```
https://[serveur]:[port]/soroubat/siteManagement/v1.0/purchaseRequests
```

---

## 📊 Champs API - PurchaseRequest

| Champ API | Champ Table | Description | Utilisation |
|----------|------------|------------|------------|
| id | SystemId | Identifiant unique (GUID) | Clé primaire API |
| no | No. | Numéro de la demande | Identifiant métier |
| jobNo | Job No. | Numéro du projet | Lien chantier |
| jobDescription | Job Description | Description du projet | Info utilisateur |
| requesterId | Requester ID | Demandeur | Traçabilité |
| requestType | Request Type | Type de demande | Catégorisation |
| service | Service | Service demandeur | Organisation |
| engin | Engin | Code engin/véhicule | Référence matériel |
| descriptionEngin | Description Engin | Désignation engin | Lisibilité |
| orderDate | Order Date | Date de création | Suivi |
| dueDate | Due Date | Date souhaitée | Planification |
| status | Status | Statut | Workflow |
| amount | Amount | Montant total | Calcul automatique |

---

# 🌐 API - Purchase Request Line

---

## 📊 Champs API - PurchaseRequestLine

| Champ API | Champ Table | Description |
|----------|------------|------------|
| id | SystemId | Identifiant unique (GUID) |
| documentNo | Document No. | Lien vers la demande |
| lineNo | Line No. | Numéro de ligne |
| transferer | Transférer | Ligne à traiter |
| type | Type | Type de ligne |
| no | No. | Référence (article/GL/immobilisation) |
| description | Description | Description principale |
| description2 | Description 2 | Observation |
| quantity | Quantity | Quantité |
| unitOfMeasureCode | Unit of Measure Code | Unité |
| locationCode | Location Code | Magasin |
| variantCode | Variant Code | Variante |
| jobNo | Job No. | Projet |
| jobTaskNo | Job Task No. | Tâche |
| engin | Engin | Engin associé |
| lineAmount | Line Amount | Montant (Qté × Prix) |

---



# ✅ Résumé

- **Purchase Request** → En-tête de la demande  
- **Purchase Request Line** → Détails des articles  
- **Transférer** → Sélection des lignes à convertir  
- **Associated Purchase Order** → Suivi des commandes générées  







src/app/models/purchases/
├── purchases-module.ts           # Module Angular
├── purchases-routing-module.ts   # Routes du module
├── components/                    # Composants réutilisables
│   ├── approval-history/         # Historique des validations
│   ├── request-header/           # En-tête de la demande
│   ├── request-lines/            # Lignes de la demande
│   └── stock-control/            # Contrôle de stock
├── pages/                        # Pages principales
│   ├── request-list/             # Liste des demandes
│   ├── request-form/             # Création/édition d'une demande
│   └── request-detail/           # Détail d'une demande
└── services/                     # Services
    ├── purchase-request.ts       # Service principal
    └── approval.ts               # Service d'approbation








┌─────────────────────────────────────────────────────────────────┐
│                    REQUEST-FORM (Page principale)                │
├─────────────────────────────────────────────────────────────────┤
│  ┌─────────────────────────────────────────────────────────┐   │
│  │              REQUEST-HEADER (Composant)                  │   │
│  │  - No. (autogénéré)                                     │   │
│  │  - Job No. / Job Description (sélection projet)         │   │
│  │  - Requester ID (utilisateur connecté)                  │   │
│  │  - Request Type (dropdown)                              │   │
│  │  - Service (dropdown)                                   │   │
│  │  - Engin (optionnel)                                    │   │
│  │  - Order Date / Due Date                                │   │
│  └─────────────────────────────────────────────────────────┘   │
│                              ↓                                   │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │              REQUEST-LINES (Composant)                   │   │
│  │  Liste des articles demandés :                          │   │
│  │  - Type (Item/Fixed Asset)                              │   │
│  │  - No. (recherche article)                              │   │
│  │  - Description                                          │   │
│  │  - Quantity                                             │   │
│  │  - Unit of Measure                                       │   │
│  │  - Location Code                                        │   │
│  │  - Job Task No.                                         │   │
│  │  - Engin                                                │   │
│  │  - Line Amount (calculé)                                │   │
│  └─────────────────────────────────────────────────────────┘   │
│                              ↓                                   │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │              STOCK-CONTROL (Composant)                   │   │
│  │  Affichage pour chaque article :                        │   │
│  │  - Stock disponible                                     │   │
│  │  - Stock en cours                                       │   │
│  │  - Quantité commandée non livrée                        │   │
│  │  - Alerte si stock insuffisant                          │   │
│  └─────────────────────────────────────────────────────────┘   │
│                              ↓                                   │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │            APPROVAL-HISTORY (Composant)                  │   │
│  │  - Historique des validations                           │   │
│  │  - Statut par approbateur                               │   │
│  │  - Dates d'approbation                                  │   │
│  │  - Motifs de refus                                      │   │
│  └─────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────┘