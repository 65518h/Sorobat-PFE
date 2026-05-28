// src/app/models/chef-chantier.model.ts

export interface ChefChantier {
  id: string;
  nomEtPrenom: string;
  email: string;
  actif: boolean;
  numProjet: string;
}

export interface ChefChantierResponse {
  '@odata.context': string;
  value: ChefChantier[];
}