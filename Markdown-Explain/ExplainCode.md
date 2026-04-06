# Configuration et API – Projet PFE

---

# 1. Configuration TypeScript

## Fichier : `tsconfig.json`

### `experimentalDecorators: true`

### 🔍 Qu'est-ce que c'est ?

Active la **prise en charge des décorateurs en TypeScript**.

### 💡 À quoi ça sert ?

Les décorateurs sont les symboles avec `@` utilisés dans Angular.

### Exemples de décorateurs Angular

```typescript
@Component({...})      // Décorateur de composant
@Injectable()          // Décorateur de service
@Input()               // Décorateur de propriété d'entrée
@Output()              // Décorateur d'événement
@Inject(PLATFORM_ID)   // Injection manuelle
```

Ces décorateurs permettent à Angular de **décrire et configurer les classes**.

### 🎯 Ce que cela permet

- Déclarer des composants Angular
- Utiliser l’injection de dépendances
- Ajouter des métadonnées aux classes
- Utiliser les décorateurs Angular

---

# 2. Option `emitDecoratorMetadata`

Cette option permet à Angular de **connaître automatiquement les types injectés dans le constructeur**.

### Exemple avec injection de dépendances

```typescript
constructor(
  private authService: AuthService,
  private router: Router
) {}
```

Angular comprend automatiquement :

- que `authService` est de type **AuthService**
- que `router` est de type **Router**

---

## Exemple concret

### ❌ Sans `emitDecoratorMetadata`

```typescript
export class LoginComponent {

  constructor(
    @Inject(AuthService) private authService: AuthService,
    @Inject(Router) private router: Router
  ) {}

}
```

➡️ On doit utiliser `@Inject()` pour préciser les types.

---

### ✅ Avec `emitDecoratorMetadata`

```typescript
export class LoginComponent {

  constructor(
    private authService: AuthService,
    private router: Router
  ) {}

}
```

➡️ Angular détecte automatiquement les types.

---

# 3. Explication de l’API `JobTaskAPI`

Cette API expose les **tâches de projet (Job Task)** vers une application externe comme :

- Angular
- Backend .NET

Elle permet de **suivre l’avancement des tâches sur les chantiers**.

---

# 4. Déclaration de la page API

```al
page 50120 "JobTaskAPI"
```

| Élément | Description |
|--------|-------------|
| 50120 | ID unique de la page |
| JobTaskAPI | Nom de la page |

Cette page permet d'exposer des données via **une API REST**.

---

# 5. Type de page

```al
PageType = API;
```

Cela signifie que la page :

- n'est **pas une interface graphique**
- sert uniquement à exposer des données via une **API REST**

Les données sont retournées au format **JSON**.

---

# 6. Configuration de l’URL API

```al
APIPublisher = 'soroubat';
APIGroup = 'siteManagement';
APIVersion = 'v1.0';
```

Ces paramètres permettent de construire l’URL de l’API.

### Exemple d’URL

```
https://businesscentral/api/soroubat/siteManagement/v1.0/jobTasks
```

| Paramètre | Description |
|----------|-------------|
| APIPublisher | Nom de l'éditeur |
| APIGroup | Groupe fonctionnel |
| APIVersion | Version de l'API |

---

# 7. Nom des entités API

```al
EntityName = 'jobTask';
EntitySetName = 'jobTasks';
```

| Paramètre | Rôle |
|----------|------|
| EntityName | Nom d’un objet |
| EntitySetName | Nom de la collection |

### Exemple

```
GET /jobTasks
```

➡️ Retourne toutes les tâches.

---

# 8. Table source

```al
SourceTable = "Job Task";
```

L’API lit les données depuis la table standard **Job Task**.

### Relation des tables

```
Job
 │
 └── Job Task
```

| Table | Signification |
|------|---------------|
| Job | Projet / Chantier |
| Job Task | Tâche du projet |

---

# 9. Insertion différée

```al
DelayedInsert = true;
```

Business Central attend de recevoir **tous les champs** avant d’insérer l’enregistrement.

### Avantage

- évite les erreurs si certains champs arrivent plus tard.

---

# 10. Permissions

```al
InsertAllowed = false;
ModifyAllowed = true;
DeleteAllowed = false;
```

| Action | Autorisé |
|------|----------|
| Créer tâche | ❌ Non |
| Modifier tâche | ✅ Oui |
| Supprimer tâche | ❌ Non |

### Pourquoi ?

Pour des raisons de sécurité :

- les tâches sont créées dans **Business Central**
- le site web peut **seulement modifier l’avancement**

---

# 11. Layout (Structure des données)

```al
layout
{
    area(Content)
```

Le **layout** définit les champs exposés dans l’API.

---

# 12. Repeater

```al
repeater(GroupName)
```

Le **repeater** répète les lignes de la table.

### Exemple

Si la table contient **50 tâches**, l’API retournera **50 objets JSON**.

---

# 13. Structure d’un champ API

Chaque champ suit cette structure :

```al
field(nomAPI; Rec."Nom BC")
```

| Élément | Description |
|--------|-------------|
| nomAPI | Nom visible dans Angular |
| Rec."Nom BC" | Champ réel dans Business Central |

### Exemple

```al
field(jobNo; Rec."Job No.")
```

➡️ `jobNo` sera le nom du champ dans l’API.

---

# 14. Données réalisées (FlowField)

```al
field(quantityShipped; Rec."Quantity Shipped")
```

Ce champ représente :

➡️ la **quantité réellement utilisée ou réalisée sur le chantier**.

### Type de champ

C’est un **FlowField** :

- calculé automatiquement
- non stocké directement dans la table

---

# 15. Données de vente (lecture seule)

```al
field(initialQuantity; Rec."Initial Quantity")
field(initialUoM; Rec."Initial Unit Of Measure")
field(initialAmount; Rec."Initial Amount")
```

Ces champs servent à comparer :

```
Prévu vs Réalisé
```

| Champ | Description |
|------|-------------|
| Initial Quantity | Quantité prévue |
| Initial UoM | Unité de mesure |
| Initial Amount | Montant prévu |

---

# 16. Statut de blocage

```al
field(isBlocked; Rec.Blocked)
```

Ce champ indique si la tâche est **bloquée**.

| Valeur | Signification |
|------|---------------|
| true | Tâche bloquée |
| false | Tâche active |

---

# 17. Trigger `OnAfterGetRecord`

```al
trigger OnAfterGetRecord()
begin
    Rec.CalcFields("Quantity Shipped");
end;
```

Ce trigger s’exécute **chaque fois que l’API récupère une ligne**.

### Rôle

Calculer les **FlowFields**.

Sans ce calcul, Angular ne recevrait pas la valeur.

---

# 18. Exemple de réponse JSON

Quand Angular appelle l’API :

```
GET /jobTasks
```

### Réponse

```json
{
  "jobNo": "JOB001",
  "taskNo": "TASK01",
  "description": "Fondations",
  "dateDebut": "2026-03-01",
  "dateFin": "2026-03-10",
  "progressPct": 40,
  "taskProgressPct": 60,
  "quantityShipped": 120,
  "initialQuantity": 200,
  "initialUoM": "M3",
  "initialAmount": 5000,
  "isBlocked": false
}
```

---

# 19. Explication du contrôleur `ProjectsController`

Ce contrôleur fait partie du **backend .NET API**.

Il permet au frontend Angular de communiquer avec  
**Microsoft Dynamics 365 Business Central** pour gérer :

- les projets (Jobs)
- les tâches (Job Tasks)

---

# 20. Déclaration du contrôleur

```csharp
[ApiController]
[Route("api/[controller]")]
public class ProjectsController : ControllerBase
```

### `[ApiController]`

Indique que la classe est un **contrôleur API REST**.

### `[Route("api/[controller]")]`

Définit l’URL de base de l’API.

`[controller]` est remplacé automatiquement par le nom du contrôleur.

Donc :

```
api/projects
```

---

# 21. Injection de dépendance

```csharp
private readonly ISiteManagementService _siteService;
```

Ce service contient la **logique métier**:
-récupérer les projets

-récupérer les tâches

-modifier le progrès

Il gère la communication avec :

- Business Central
- d'autres services backend

### Constructeur

```csharp
public ProjectsController(ISiteManagementService service)
{
    _siteService = service;
}
```

Le service est **injecté automatiquement par .NET**.

---

# 22. Endpoint : récupérer tous les projets

```csharp
[HttpGet]
public async Task<ActionResult<IEnumerable<JobDto>>> GetJobs()
```

### Route

```
GET /api/projects
```

### Fonctionnement

```csharp
var jobs = await _siteService.GetAllJobsAsync();
return Ok(jobs);
```

Retourne la **liste des projets**.

---

# 23. Endpoint : récupérer les tâches d’un projet

```csharp
[HttpGet("{jobNo}/tasks")]
public async Task<ActionResult<IEnumerable<JobTaskDto>>> GetTasks(string jobNo)
```

### Route

```
GET /api/projects/{jobNo}/tasks
```

### Fonctionnement

```csharp
var tasks = await _siteService.GetTasksByJobAsync(jobNo);
return Ok(tasks);
```

Retourne **les tâches d’un projet spécifique**.

---

# 24. Endpoint : mise à jour de l’avancement

```csharp
[HttpPatch("update-progress")]
public async Task<IActionResult> UpdateProgress([FromBody] UpdateProgressRequest request)
```

### Route

```
PATCH /api/projects/update-progress
```

### Fonctionnement

```csharp
var success = await _siteService.UpdateTaskProgressAsync(
    request.JobNo,
    request.TaskNo,
    request.Progress
);
```

Permet de **mettre à jour le pourcentage d’avancement d’une tâche**.

### Réponse en cas de succès

```json
{
  "message": "Mise à jour réussie"
}
```

---

# 25. Architecture globale

Le projet suit une **architecture en 3 couches** :

```
Angular (Frontend)
        │
        ▼
ProjectsController (.NET API)
        │
        ▼
ISiteManagementService
        │
        ▼
Business Central API
```