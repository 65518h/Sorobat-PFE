@startuml
left to right direction
skinparam actorStyle awesome
skinparam backgroundColor white

skinparam usecase {
  BackgroundColor #EBF3FB
  BorderColor #2E74B5
  FontName Arial
}
skinparam actor {
  BackgroundColor #2E74B5
  FontColor #2E74B5
  FontName Arial
}

actor "Chef de chantier" as CC

rectangle "Système d'Authentification" {
  usecase "S'authentifier" as UC_AUTH
  usecase "Se connecter en mode hors ligne" as UC_OFFLINE
}

CC --> UC_AUTH



' Scénario alternatif E5 (Connexion hors ligne si serveur inaccessible)
UC_OFFLINE .> UC_AUTH : <<extend>>


@enduml