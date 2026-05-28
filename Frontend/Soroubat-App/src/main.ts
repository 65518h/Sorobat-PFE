// main.ts
import { bootstrapApplication } from '@angular/platform-browser';
import { appConfig } from './app/app.config';
import { AppComponent } from './app/app';

// Ignorer les avertissements Angular Material (non bloquants)
const originalConsoleError = console.error;
console.error = (...args) => {
  const msg = args[0]?.toString() || '';
  
  // Liste des avertissements Angular Material à ignorer
  const ignoredPatterns = [
    'NG0912',
    'Component ID generation collision',
    'mat-form-field must contain a MatFormFieldControl',
    'Cannot read properties of undefined (reading \'disabled\')',
    'Cannot read properties of undefined (reading \'onContainerClick\')',
    '_MatFormField',
    '_MatOptgroup',
    '_MatOption',
    '_TooltipComponent',
    '_MatIcon'
  ];
  
  if (ignoredPatterns.some(pattern => msg.includes(pattern))) {
    // Optionnel: afficher un log discret
    // console.debug(' Erreur Angular Material ignorée');
    return;
  }
  
  originalConsoleError.apply(console, args);
};

// Ignorer aussi les warnings
const originalConsoleWarn = console.warn;
console.warn = (...args) => {
  const msg = args[0]?.toString() || '';
  if (msg.includes('Component ID generation collision')) {
    return;
  }
  originalConsoleWarn.apply(console, args);
};

bootstrapApplication(AppComponent, appConfig)
  .catch((err) => console.error(err));




