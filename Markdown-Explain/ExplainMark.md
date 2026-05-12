# 🏗️ Architecture — Business Central Extension

> Documentation technique de l'extension AL, du backend .NET et de l'architecture globale du projet.

---

## 📁 Dossiers Système

### `.alpackages`

Contient les **symboles des applications standard** de Microsoft Dynamics 365 Business Central.

Généré automatiquement via la commande :

```
AL: Download Symbols
```

Ces symboles exposent les tables standard telles que `Job`, `Customer`, `Item`, etc.

> ⚠️ **Ne jamais modifier ce dossier manuellement.**

---

### `.snapshots`

Utilisé pour le **debugging** et la gestion interne des symboles Business Central.

> ⚠️ **Ne jamais modifier ce dossier manuellement.**

---

### `Profil`

Définit les **profils utilisateurs** dans Business Central. Un profil personnalise l'interface selon le rôle de l'utilisateur.

**Exemples de profils :**
- Chef de chantier
- Comptable
- Manager

**Un profil peut définir :**
- Les pages visibles
- L'interface personnalisée
- Certaines configurations d'affichage

---

## 📂 Structure du dossier `SRC`

Tous les dossiers de l'extension AL se trouvent dans `AL_Extension/SRC`.

| Dossier | Rôle |
|---|---|
| `/API` | Web Services REST |
| `/Codeunit` | Logique métier |
| `/EnumExtension` | Extension d'énumérations |
| `/Page` | Nouvelles pages UI |
| `/PageExtension` | Modification de pages existantes |
| `/PR` | Permissions et rôles |
| `/Report` | Rapports personnalisés |
| `/ReportExtension` | Extension de rapports |
| `/Table` | Nouvelles tables |
| `/TableExtension` | Extension de tables existantes |
| `/XmlPort` | Import / Export de données |

---

### 1️⃣ `/API` — Web Services

Expose des **endpoints API REST** pour communiquer avec des systèmes externes (ex. backend .NET).

**Utilisation :** Le backend .NET appelle ces API pour récupérer ou envoyer des données.

---

### 2️⃣ `/Codeunit` — Unités de Code

Contient la **logique métier** et les fonctions réutilisables.

**Exemples :**
- Gestion des véhicules / engins de chantier
- Gestion des articles / pièces détachées
- Mise à jour du numéro de tâche projet après validation d'une ligne achat
- Calcul du coût d'un chantier
- Validation d'une tâche

---

### 3️⃣ `/EnumExtension` — Extensions d'Énumérations

Permet d'**ajouter des valeurs** à un enum standard existant.

**Exemple :**

```al
// Enum standard
Status = Open, Closed

// Après extension
Status = Open, Closed, In Progress
```

---

### 4️⃣ `/Page` — Pages

Contient les **nouvelles pages UI** de l'extension : listes, fiches, dialogues.

---

### 5️⃣ `/PageExtension` — Extensions de Pages

Permet de **modifier une page existante**.

**Exemple :** Ajouter un champ dans la page `Job Card`.

---

### 6️⃣ `/PR` — Permissions et Rôles

Contient les **Permission Sets** qui contrôlent l'accès aux données.

| Action | Contrôle |
|---|---|
| Lecture | ✅ |
| Modification | ✅ |
| Suppression | ✅ |

---

### 7️⃣ `/Report` — Rapports

Contient les **rapports personnalisés**.

**Exemples :**
- Rapport des coûts de chantier
- Rapport d'avancement

---

### 8️⃣ `/ReportExtension` — Extensions de Rapports

Permet de **modifier ou enrichir** un rapport existant (ajout de champs, de données, etc.).

---

### 9️⃣ `/Table` — Tables

Contient les **nouvelles tables** créées dans l'extension.

**Exemples pour ce projet :**
- `Chantier`
- `Equipe`
- `Matériel`

---

### 🔟 `/TableExtension` — Extensions de Tables

Permet d'**ajouter des champs** à une table standard.

**Exemple — Extension de la table `Job` :**
- `Budget Chantier`
- `Localisation GPS`
- `Responsable Chantier`

---

### 1️⃣1️⃣ `/XmlPort` — Ports XML

Utilisé pour **importer ou exporter** des données.

**Formats supportés :** XML, CSV

**Exemple :** Importer une liste de matériaux.

---

## ⚙️ Backend .NET

### Couche Controllers

La couche `Controllers` expose des **endpoints REST** permettant au frontend Angular (ou d'autres services) de communiquer avec l'application.

---

### `JobTasksController`

Contrôleur ASP.NET Core pour la gestion des **projets (Jobs)** et de leurs **tâches (Tasks)**.

---

#### `GET /api/projects`

```
GET http://localhost:5000/api/projects
```

**Fonctionnement :**
1. Appelle `GetAllJobsAsync()`
2. Récupère la liste des projets
3. Retourne `200 OK` avec les données

---

#### `GET /api/projects/{jobNo}/tasks`

```
GET http://localhost:5000/api/projects/JOB001/tasks
```

**Paramètre :** `{jobNo}` — Numéro du projet (ex. `JOB001`)

**Fonctionnement :**
1. Reçoit le numéro du projet
2. Appelle `GetTasksByJobAsync(jobNo)`
3. Retourne les tâches du projet

---

#### `PATCH /api/projects/update-progress`

```
PATCH http://localhost:5000/api/projects/update-progress
```

> `PATCH` est utilisé pour une **mise à jour partielle** — ici, uniquement le champ `progress`.

**Body JSON :**

```json
{
  "jobNo": "JOB001",
  "taskNo": "T001",
  "progress": 60
}
```

**Logique :**

```csharp
var success = await _siteService.UpdateTaskProgressAsync(
    request.JobNo,
    request.TaskNo,
    request.Progress
);
```

**Réponses :**

| Statut | HTTP | Body |
|---|---|---|
| Succès | `200 OK` | `{ "message": "Mise à jour réussie" }` |
| Échec | `400 Bad Request` | `"Échec de la mise à jour"` |

---

## 🌐 Architecture Globale

```
Business Central
       ↓
    API AL
       ↓
  Backend .NET
       ↓
    Angular
       ↓
Chef de chantier
```