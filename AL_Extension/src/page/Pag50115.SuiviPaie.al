// Page 50115 "Suivi Paie"
// {
//     PageType = Card;
//     SourceTable = "Chiffre Affaire";
//     ApplicationArea = all;
//     Caption = 'Suivi Paie';
//     UsageCategory = Administration;
//     layout
//     {
//         area(content)
//         {
//             field(FilterAnnee; FilterAnnee)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Filter Année';
//             }
//             field(DecBrut; DecBrut)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Brut';
//                 DecimalPlaces = 3 : 3;
//                 Editable = true;
//             }
//             field(DecBrutNormal; DecBrutNormal)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Brut (Normal)';
//                 DecimalPlaces = 3 : 3;
//             }
//             field(DecBrutSIVP; DecBrutSIVP)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Brut SIVP';
//                 DecimalPlaces = 3 : 3;
//             }
//             field(DecCNSS; DecCNSS)
//             {
//                 ApplicationArea = all;
//                 Caption = 'CNSS';
//                 DecimalPlaces = 3 : 3;
//                 Editable = true;
//             }
//             field(DecImpot; DecImpot)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Impot';
//                 DecimalPlaces = 3 : 3;
//                 Editable = true;
//             }
//             field(DecNet; DecNet)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Salaire Net';
//                 DecimalPlaces = 3 : 3;
//                 Editable = true;
//             }
//             field(DecRedevance; DecRedevance)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Redevance';
//                 DecimalPlaces = 3 : 3;
//                 Editable = true;
//             }
//             field(DecAvance; DecAvance)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Avance';
//                 DecimalPlaces = 3 : 3;
//                 Editable = true;
//             }
//             field(FilterMois; FilterMois)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Filter Mois';
//             }
//             field(DecCessionSalaire; DecCessionSalaire)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Cession / Salaire';
//                 DecimalPlaces = 3 : 3;
//                 Editable = true;
//             }
//             field(DecPretCNSSLog; DecPretCNSSLog)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Pret CNSS Logement';
//                 DecimalPlaces = 3 : 3;
//                 Editable = true;
//             }
//             field(DecPretCNSSVoit; DecPretCNSSVoit)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Pret CNSS Voiture';
//                 DecimalPlaces = 3 : 3;
//                 Editable = true;
//             }
//             field(DecPretSociete; DecPretSociete)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Pret Societé';
//                 DecimalPlaces = 3 : 3;
//                 Editable = true;
//             }
//             field(DecArrdPlus; DecArrdPlus)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Arrondissement Positif';
//                 DecimalPlaces = 3 : 3;
//                 Editable = true;
//             }
//             field(DecArrdMoins; DecArrdMoins)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Arrondissement Negatif';
//                 DecimalPlaces = 3 : 3;
//                 Editable = true;
//             }
//         }
//     }

//     actions
//     {
//         area(Promoted)
//         {
//             group(Fonction1)
//             {
//                 Caption = 'Fonction';
//                 actionref("Acualiser Base NAV1"; "Acualiser Base NAV") { }
//                 actionref(Actualiser1; Actualiser) { }


//                 actionref("Integrer en Comptabilité1"; "Integrer en Comptabilité") { }
//                 actionref("Ecritures Prêt Société1"; "Ecritures Prêt Société") { }
//                 actionref("Ecritures Avance1"; "Ecritures Avance") { }
//                 actionref("Ecritures Net1"; "Ecritures Net") { }
//                 actionref("LIBERER LES ECRITURES EN COMPTABILITE1"; "LIBERER LES ECRITURES EN COMPTABILITE") { }


//             }
//         }
//         area(navigation)
//         {
//             group(Fonction)
//             {
//                 Caption = 'Fonction';
//                 action("Acualiser Base NAV")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Acualiser Base NAV';

//                     trigger OnAction()
//                     begin
//                         if FilterAnnee = 0 then
//                             Error(Text001);
//                         if FilterMois = 0 then
//                             Error(Text002);
//                         DecBrut := 0;
//                         DecCNSS := 0;
//                         DecImpot := 0;
//                         DecNet := 0;
//                         DecRedevance := 0;
//                         DecAvance := 0;
//                         DecCessionSalaire := 0;
//                         DecPretCNSSLog := 0;
//                         DecPretCNSSVoit := 0;
//                         DecPretSociete := 0;
//                         DecArrdPlus := 0;
//                         DecArrdMoins := 0;
//                         RecRecSalaryLines.Reset;
//                         RecRecSalaryLines.SetRange(Year, FilterAnnee);
//                         RecRecSalaryLines.SetRange(Month, FilterMois);
//                         if RecRecSalaryLines.FindFirst then
//                             repeat
//                                 DecBrut += RecRecSalaryLines."Gross Salary";
//                                 RecRecSalaryLines.CalcFields("Type Contrat Employee");
//                                 if (RecRecSalaryLines."Type Contrat Employee" = RecRecSalaryLines."type contrat employee"::"SIVP I 1iere Année")
//                                 or (RecRecSalaryLines."Type Contrat Employee" = RecRecSalaryLines."type contrat employee"::"SIVP I 2ieme Année")
//                                 or (RecRecSalaryLines."Type Contrat Employee" = RecRecSalaryLines."type contrat employee"::"SIVP II")
//                                 or (RecRecSalaryLines."Type Contrat Employee" = RecRecSalaryLines."type contrat employee"::Stagiaire)
//                                 or (RecRecSalaryLines."Type Contrat Employee" = RecRecSalaryLines."type contrat employee"::Particulier) then
//                                     DecBrutSIVP += RecRecSalaryLines."Gross Salary"
//                                 else
//                                     DecBrutNormal += RecRecSalaryLines."Gross Salary";
//                                 DecCNSS += RecRecSalaryLines.CNSS;
//                                 DecImpot += RecRecSalaryLines."Taxe (Month)";
//                                 DecNet += RecRecSalaryLines."Net salary cashed";
//                                 //DecRedevance+=;
//                                 DecAvance += RecRecSalaryLines.Advances;
//                                 // A DISCUTER AVEC MR HOSNI DecCessionSalaire+=;
//                                 DecArrdPlus += RecRecSalaryLines."Ajout  en +";
//                                 DecArrdMoins += RecRecSalaryLines."Report en -";
//                             until RecRecSalaryLines.Next = 0;

//                         RecLignePret.Reset;
//                         RecLignePret.SetRange(Year, FilterAnnee);
//                         RecLignePret.SetRange(Month, FilterMois);
//                         if RecLignePret.FindFirst then
//                             repeat
//                                 RecEntetPret.Reset;
//                                 RecEntetPret.Get(RecLignePret."No.");
//                                 if RecEntetPret."Pret CNSS" = RecEntetPret."pret cnss"::Logement then
//                                     DecPretCNSSLog += RecLignePret."Line Amount"
//                                 else
//                                     if RecEntetPret."Pret CNSS" = RecEntetPret."pret cnss"::Voiture then
//                                         DecPretCNSSVoit += RecLignePret."Line Amount"
//                                     else
//                                         DecPretSociete += RecLignePret."Line Amount";
//                             until RecLignePret.Next = 0;
//                     end;
//                 }
//                 separator(Action1000000041)
//                 {
//                 }
//                 action(Actualiser)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Actualiser';

//                     trigger OnAction()
//                     begin

//                         IF FilterAnnee = 0 THEN
//                             ERROR(Text001);
//                         IF FilterMois = 0 THEN
//                             ERROR(Text002);
//                         DecBrut := 0;
//                         DecCNSS := 0;
//                         DecImpot := 0;
//                         DecNet := 0;
//                         DecRedevance := 0;
//                         DecAvance := 0;
//                         DecCessionSalaire := 0;
//                         DecPretCNSSLog := 0;
//                         DecPretCNSSVoit := 0;
//                         DecPretSociete := 0;
//                         DecArrdPlus := 0;
//                         DecArrdMoins := 0;
//                         RecValeurPaie.RESET;
//                         RecValeurPaie.SETRANGE("Dec.", FilterAnnee);
//                         RecValeurPaie.SETRANGE(HT, FilterMois);
//                         IF RecValeurPaie.FINDFIRST THEN BEGIN
//                             RecValeurPaie.CALCFIELDS(FP, "Date encais. FP", HB, "Date encais. HB");
//                             DecBrut := RecValeurPaie.FP;
//                             // GL2024   DecCNSS := RecValeurPaie."Date encais. FP";
//                             DecImpot := RecValeurPaie.HB;
//                             // GL2024     DecNet := RecValeurPaie."Date encais. HB";
//                             RecValeurPaie.CALCFIELDS(TTC, "Avance TTC", "Travaux TTC", "Mois Décl décompte", "RS TVA",
//                             "RS Marché", "Certif RS", Net);
//                             DecRedevance := RecValeurPaie.TTC;
//                             DecAvance := RecValeurPaie."Avance TTC";
//                             DecCessionSalaire := RecValeurPaie."Travaux TTC";
//                             // GL2024    DecPretCNSSLog := RecValeurPaie."Mois Décl décompte";
//                             DecPretCNSSVoit := RecValeurPaie."RS TVA";
//                             DecPretSociete := RecValeurPaie."RS Marché";
//                             // GL2024     DecArrdPlus := RecValeurPaie."Certif RS";
//                             DecArrdMoins := RecValeurPaie.Net;
//                         END;

//                     end;
//                 }
//                 action("Integrer en Comptabilité")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Integrer en Comptabilité';

//                     trigger OnAction()
//                     begin
//                         //GL2024
//                         IF (DecBrutNormal = 0) AND (DecBrutSIVP = 0) THEN
//                             ERROR(Text003);

//                         // Vérification Montant Pret Societe, Montant Avance, Montant Net
//                         IF DecPretSociete <> RecValeurPaie."RS Marché" THEN
//                             ERROR(Text004);
//                         IF DecAvance <> RecValeurPaie."Avance TTC" THEN
//                             ERROR(Text005);
//                         /*GL2024 IF DecNet <> RecValeurPaie."Date encais. HB" THEN
//                              ERROR(Text006);*/

//                         // VERIFIER SI LES ECRITURES SONT DEJA INTEGRER EN COMPTABILITE
//                         RecValeurPaieCompt.RESET;
//                         RecValeurPaieCompt.SETRANGE("Dec.", FilterAnnee);
//                         RecValeurPaieCompt.SETRANGE(HT, FilterMois);
//                         IF RecValeurPaieCompt.FINDFIRST THEN BEGIN
//                             /*GL2024 IF RecValeurPaieCompt."Solde D/F" THEN
//                                  ERROR(Text008);*/
//                         END;

//                         // CALCUL DE DATE COMPTABILISATION
//                         DateCpt := DMY2DATE(1, FilterMois, FilterAnnee);
//                         DateCpt := CALCDATE('FM', DateCpt);

//                         // MAJ N° DOCUMENT
//                         IF RecHumanResourcesSetup.GET THEN;
//                         NumPaie := NoSeriesMgt.GetNextNo(RecHumanResourcesSetup."Recap Paie", TODAY, TRUE);

//                         // INSERTION DANS LA TABLE "Gen. Journal Line"
//                         RecGenJournalLine.RESET;
//                         RecGenJournalLine."Journal Template Name" := 'PAIE';
//                         RecGenJournalLine."Journal Batch Name" := 'PAIE';

//                         // Montant Brut (Normal)
//                         RecGenJournalLine."Line No." := 10000;
//                         RecGenJournalLine.VALIDATE("Account No.", '64000000');
//                         RecGenJournalLine."Posting Date" := DateCpt;
//                         RecGenJournalLine."Document No." := NumPaie;
//                         RecGenJournalLine.VALIDATE("Debit Amount", DecBrutNormal);
//                         RecGenJournalLine.Description := 'RECAP PAIE' + ' ' + FORMAT(FilterMois) + ' ' + FORMAT(FilterAnnee);
//                         RecGenJournalLine."Source Code" := '10';
//                         RecGenJournalLine.INSERT;

//                         // Montant Brut (SIVP)
//                         RecGenJournalLine."Line No." := 20000;
//                         RecGenJournalLine.VALIDATE("Account No.", '64100000');
//                         RecGenJournalLine."Posting Date" := DateCpt;
//                         RecGenJournalLine."Document No." := NumPaie;
//                         RecGenJournalLine.VALIDATE("Debit Amount", DecBrutSIVP);
//                         RecGenJournalLine.Description := 'RECAP PAIE' + ' ' + FORMAT(FilterMois) + ' ' + FORMAT(FilterAnnee);
//                         RecGenJournalLine."Source Code" := '10';
//                         RecGenJournalLine.INSERT;

//                         // Montant CNSS
//                         RecGenJournalLine."Line No." := 30000;
//                         RecGenJournalLine.VALIDATE("Account No.", '45311000');
//                         RecGenJournalLine."Posting Date" := DateCpt;
//                         RecGenJournalLine."Document No." := NumPaie;
//                         RecGenJournalLine.VALIDATE("Credit Amount", DecCNSS);
//                         RecGenJournalLine.Description := 'RECAP PAIE' + ' ' + FORMAT(FilterMois) + ' ' + FORMAT(FilterAnnee);
//                         RecGenJournalLine."Source Code" := '10';
//                         RecGenJournalLine.INSERT;

//                         // Montant Impot
//                         RecGenJournalLine."Line No." := 40000;
//                         RecGenJournalLine.VALIDATE("Account No.", '43200000');
//                         RecGenJournalLine."Posting Date" := DateCpt;
//                         RecGenJournalLine."Document No." := NumPaie;
//                         RecGenJournalLine.VALIDATE("Credit Amount", DecImpot);
//                         RecGenJournalLine.Description := 'RECAP PAIE' + ' ' + FORMAT(FilterMois) + ' ' + FORMAT(FilterAnnee);
//                         RecGenJournalLine."Source Code" := '10';
//                         RecGenJournalLine.INSERT;

//                         // Montant Redevance
//                         RecGenJournalLine."Line No." := 50000;
//                         RecGenJournalLine.VALIDATE("Account No.", '43245000');
//                         RecGenJournalLine."Posting Date" := DateCpt;
//                         RecGenJournalLine."Document No." := NumPaie;
//                         RecGenJournalLine.VALIDATE("Credit Amount", DecRedevance);
//                         RecGenJournalLine.Description := 'RECAP PAIE' + ' ' + FORMAT(FilterMois) + ' ' + FORMAT(FilterAnnee);
//                         RecGenJournalLine."Source Code" := '10';
//                         RecGenJournalLine.INSERT;

//                         // Montant Avance
//                         IF DecAvance <> 0 THEN BEGIN
//                             RecGenJournalLine."Line No." := 60000;
//                             IF FilterMois = 1 THEN
//                                 RecGenJournalLine.VALIDATE("Account No.", '42100001')
//                             ELSE
//                                 IF FilterMois = 2 THEN
//                                     RecGenJournalLine.VALIDATE("Account No.", '42100002')
//                                 ELSE
//                                     IF FilterMois = 3 THEN
//                                         RecGenJournalLine.VALIDATE("Account No.", '42100003')
//                                     ELSE
//                                         IF FilterMois = 4 THEN
//                                             RecGenJournalLine.VALIDATE("Account No.", '42100004')
//                                         ELSE
//                                             IF FilterMois = 5 THEN
//                                                 RecGenJournalLine.VALIDATE("Account No.", '42100005')
//                                             ELSE
//                                                 IF FilterMois = 6 THEN
//                                                     RecGenJournalLine.VALIDATE("Account No.", '42100006')
//                                                 ELSE
//                                                     IF FilterMois = 7 THEN
//                                                         RecGenJournalLine.VALIDATE("Account No.", '42100007')
//                                                     ELSE
//                                                         IF FilterMois = 8 THEN
//                                                             RecGenJournalLine.VALIDATE("Account No.", '42100008')
//                                                         ELSE
//                                                             IF FilterMois = 9 THEN
//                                                                 RecGenJournalLine.VALIDATE("Account No.", '42100009')
//                                                             ELSE
//                                                                 IF FilterMois = 10 THEN
//                                                                     RecGenJournalLine.VALIDATE("Account No.", '42100010')
//                                                                 ELSE
//                                                                     IF FilterMois = 11 THEN
//                                                                         RecGenJournalLine.VALIDATE("Account No.", '42100011')
//                                                                     ELSE
//                                                                         RecGenJournalLine.VALIDATE("Account No.", '42100012');
//                             RecGenJournalLine."Posting Date" := DateCpt;
//                             RecGenJournalLine."Document No." := NumPaie;
//                             RecGenJournalLine.VALIDATE("Credit Amount", DecAvance);
//                             RecGenJournalLine.Description := 'RECAP PAIE' + ' ' + FORMAT(FilterMois) + ' ' + FORMAT(FilterAnnee);
//                             RecGenJournalLine."Source Code" := '10';
//                             RecGenJournalLine.INSERT;
//                         END;

//                         // Montant Cession Sur Salaire
//                         RecGenJournalLine."Line No." := 70000;
//                         RecGenJournalLine.VALIDATE("Account No.", '42860010');
//                         RecGenJournalLine."Posting Date" := DateCpt;
//                         RecGenJournalLine."Document No." := NumPaie;
//                         RecGenJournalLine.VALIDATE("Credit Amount", DecCessionSalaire);
//                         RecGenJournalLine.Description := 'RECAP PAIE' + ' ' + FORMAT(FilterMois) + ' ' + FORMAT(FilterAnnee);
//                         RecGenJournalLine."Source Code" := '10';
//                         RecGenJournalLine.INSERT;

//                         // Montant Pret CNSS Logement
//                         RecGenJournalLine."Line No." := 80000;
//                         RecGenJournalLine.VALIDATE("Account No.", '45313000');
//                         RecGenJournalLine."Posting Date" := DateCpt;
//                         RecGenJournalLine."Document No." := NumPaie;
//                         RecGenJournalLine.VALIDATE("Credit Amount", DecPretCNSSLog);
//                         RecGenJournalLine.Description := 'RECAP PAIE' + ' ' + FORMAT(FilterMois) + ' ' + FORMAT(FilterAnnee);
//                         RecGenJournalLine."Source Code" := '10';
//                         RecGenJournalLine.INSERT;

//                         // Montant Pret CNSS Voiture
//                         RecGenJournalLine."Line No." := 90000;
//                         RecGenJournalLine.VALIDATE("Account No.", '45313000');
//                         RecGenJournalLine."Posting Date" := DateCpt;
//                         RecGenJournalLine."Document No." := NumPaie;
//                         RecGenJournalLine.VALIDATE("Credit Amount", DecPretCNSSVoit);
//                         RecGenJournalLine.Description := 'RECAP PAIE' + ' ' + FORMAT(FilterMois) + ' ' + FORMAT(FilterAnnee);
//                         RecGenJournalLine."Source Code" := '10';
//                         RecGenJournalLine.INSERT;

//                         // Montant Arrondissement +
//                         RecGenJournalLine."Line No." := 100000;
//                         RecGenJournalLine.VALIDATE("Account No.", '42500000');
//                         RecGenJournalLine."Posting Date" := DateCpt;
//                         RecGenJournalLine."Document No." := NumPaie;
//                         RecGenJournalLine.VALIDATE("Debit Amount", DecArrdPlus);
//                         RecGenJournalLine.Description := 'RECAP PAIE' + ' ' + FORMAT(FilterMois) + ' ' + FORMAT(FilterAnnee);
//                         RecGenJournalLine."Source Code" := '10';
//                         RecGenJournalLine.INSERT;

//                         // Montant Arrondissement -
//                         RecGenJournalLine."Line No." := 110000;
//                         RecGenJournalLine.VALIDATE("Account No.", '42500000');
//                         RecGenJournalLine."Posting Date" := DateCpt;
//                         RecGenJournalLine."Document No." := NumPaie;
//                         RecGenJournalLine.VALIDATE("Credit Amount", DecArrdMoins);
//                         RecGenJournalLine.Description := 'RECAP PAIE' + ' ' + FORMAT(FilterMois) + ' ' + FORMAT(FilterAnnee);
//                         RecGenJournalLine."Source Code" := '10';
//                         RecGenJournalLine.INSERT;

//                         // Montant Net
//                         RecGenJournalLine."Line No." := 120000;
//                         IF FilterMois = 1 THEN
//                             RecGenJournalLine.VALIDATE("Account No.", '42500001')
//                         ELSE
//                             IF FilterMois = 2 THEN
//                                 RecGenJournalLine.VALIDATE("Account No.", '42500002')
//                             ELSE
//                                 IF FilterMois = 3 THEN
//                                     RecGenJournalLine.VALIDATE("Account No.", '42500003')
//                                 ELSE
//                                     IF FilterMois = 4 THEN
//                                         RecGenJournalLine.VALIDATE("Account No.", '42500004')
//                                     ELSE
//                                         IF FilterMois = 5 THEN
//                                             RecGenJournalLine.VALIDATE("Account No.", '42500005')
//                                         ELSE
//                                             IF FilterMois = 6 THEN
//                                                 RecGenJournalLine.VALIDATE("Account No.", '42500006')
//                                             ELSE
//                                                 IF FilterMois = 7 THEN
//                                                     RecGenJournalLine.VALIDATE("Account No.", '42500007')
//                                                 ELSE
//                                                     IF FilterMois = 8 THEN
//                                                         RecGenJournalLine.VALIDATE("Account No.", '42500008')
//                                                     ELSE
//                                                         IF FilterMois = 9 THEN
//                                                             RecGenJournalLine.VALIDATE("Account No.", '42500009')
//                                                         ELSE
//                                                             IF FilterMois = 10 THEN
//                                                                 RecGenJournalLine.VALIDATE("Account No.", '42500010')
//                                                             ELSE
//                                                                 IF FilterMois = 11 THEN
//                                                                     RecGenJournalLine.VALIDATE("Account No.", '42500011')
//                                                                 ELSE
//                                                                     RecGenJournalLine.VALIDATE("Account No.", '42500012');
//                         RecGenJournalLine."Posting Date" := DateCpt;
//                         RecGenJournalLine."Document No." := NumPaie;
//                         RecGenJournalLine.VALIDATE("Credit Amount", DecNet);
//                         RecGenJournalLine.Description := 'RECAP PAIE' + ' ' + FORMAT(FilterMois) + ' ' + FORMAT(FilterAnnee);
//                         RecGenJournalLine."Source Code" := '10';
//                         RecGenJournalLine.INSERT;

//                         // Montant Pret Société
//                         NbLigne := 120000;
//                         FilterCode := 'Pret01|Pret02|Pret03|Pret04|Pret05|Pret06|Pret07|Pret08|Pret09|Pret10|Pret11|Pret12';
//                         RecMontatPaie.RESET;
//                         RecMontatPaie.SETRANGE("Nouveau Echelon", format(FilterAnnee));
//                         RecMontatPaie.SETRANGE(Ancienté, FilterMois);
//                         RecMontatPaie.SETFILTER("Nom et Prénom", FilterCode);
//                         IF RecMontatPaie.FINDFIRST THEN
//                             REPEAT
//                                 NbLigne := NbLigne + 10000;
//                                 RecGenJournalLine."Line No." := NbLigne;
//                                 RecGenJournalLine.VALIDATE("Account No.", '51600000');
//                                 RecGenJournalLine."Posting Date" := DateCpt;
//                                 RecGenJournalLine."Document No." := NumPaie;
//                                 //GL2024    RecGenJournalLine.VALIDATE("Credit Amount", RecMontatPaie."Ancien Echelon");
//                                 RecGenJournalLine.Description := 'RECAP PAIE' + ' ' + FORMAT(FilterMois) + ' ' + FORMAT(FilterAnnee);
//                                 RecGenJournalLine.Salarie := RecMontatPaie.Matricule;
//                                 RecGenJournalLine."Source Code" := '10';
//                                 RecGenJournalLine.INSERT;
//                             UNTIL RecMontatPaie.NEXT = 0;

//                         //
//                         MESSAGE(Text007);
//                         // INITIALISER LES ECRITURES A INSERER EN COMPTABILITE
//                         RecValeurPaieCompt.RESET;
//                         RecValeurPaieCompt.SETRANGE("Dec.", FilterAnnee);
//                         RecValeurPaieCompt.SETRANGE(HT, FilterMois);
//                         IF RecValeurPaieCompt.FINDFIRST THEN BEGIN
//                             //GL2024RecValeurPaieCompt."Solde D/F" := TRUE;
//                             RecValeurPaieCompt.MODIFY;
//                         END;


//                     end;
//                 }
//                 action("Ecritures Prêt Société")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Ecritures Prêt Société';

//                     trigger OnAction()
//                     begin
//                         //GL2024
//                         IF FilterAnnee = 0 THEN
//                             ERROR(Text001);
//                         IF FilterMois = 0 THEN
//                             ERROR(Text002);
//                         FilterCode := 'Pret01|Pret02|Pret03|Pret04|Pret05|Pret06|Pret07|Pret08|Pret09|Pret10|Pret11|Pret12';
//                         RecMontatPaie.RESET;

//                         RecMontatPaie.SETRANGE("Nouveau Echelon", format(FilterAnnee));
//                         RecMontatPaie.SETRANGE(Ancienté, FilterMois);
//                         RecMontatPaie.SETFILTER("Nom et Prénom", FilterCode);
//                         page.RUNMODAL(Page::"Ecritures Pret Societe", RecMontatPaie);

//                     end;
//                 }
//                 action("Ecritures Avance")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Ecritures Avance';

//                     trigger OnAction()
//                     begin
//                         //GL2024
//                         IF FilterAnnee = 0 THEN
//                             ERROR(Text001);
//                         IF FilterMois = 0 THEN
//                             ERROR(Text002);
//                         FilterCode := 'Avance';
//                         RecMontatPaie.RESET;

//                         RecMontatPaie.SETRANGE("Nouveau Echelon", Format(FilterAnnee));
//                         RecMontatPaie.SETRANGE(Ancienté, FilterMois);
//                         RecMontatPaie.SETFILTER("Nom et Prénom", FilterCode);
//                         page.RUNMODAL(Page::"Ecritures Pret Societe", RecMontatPaie);

//                     end;
//                 }
//                 action("Ecritures Net")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Ecritures Net';

//                     trigger OnAction()
//                     begin
//                         //GL2024
//                         IF FilterAnnee = 0 THEN
//                             ERROR(Text001);
//                         IF FilterMois = 0 THEN
//                             ERROR(Text002);
//                         FilterCode := 'Avance';
//                         RecEcritValeurPaie.RESET;
//                         RecEcritValeurPaie.SETRANGE("Dec.", FilterAnnee);
//                         RecEcritValeurPaie.SETRANGE(HT, FilterMois);
//                         //GL2024  RecEcritValeurPaie.SETFILTER(Code,FilterCode);
//                         page.RUNMODAL(Page::"Ecritures Salarie", RecEcritValeurPaie);

//                     end;
//                 }
//                 action("LIBERER LES ECRITURES EN COMPTABILITE")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'LIBERER LES ECRITURES EN COMPTABILITE';
//                     Visible = false;

//                     trigger OnAction()
//                     begin
//                         //GL2024
//                         RecValeurPaieCompt.RESET;
//                         RecValeurPaieCompt.SETRANGE("Dec.", FilterAnnee);
//                         RecValeurPaieCompt.SETRANGE(HT, FilterMois);
//                         //RecValeurPaieCompt.SETFILTER("Integrer en Comptabilité",'OUI');
//                         IF RecValeurPaieCompt.FINDFIRST THEN
//                             REPEAT
//                                 //GL2024    RecValeurPaieCompt."Solde D/F" := FALSE;
//                                 RecValeurPaieCompt.MODIFY;
//                             UNTIL RecValeurPaieCompt.NEXT = 0;

//                         MESSAGE('LIBERATION REUISSITE');

//                     end;
//                 }
//             }
//         }
//     }

//     var
//         RecValeurPaie: Record "Chiffre Affaire";
//         FilterAnnee: Integer;
//         FilterMois: Integer;
//         DecBrut: Decimal;
//         DecBrutNormal: Decimal;
//         DecBrutSIVP: Decimal;
//         DecCNSS: Decimal;
//         DecImpot: Decimal;
//         DecNet: Decimal;
//         DecRedevance: Decimal;
//         DecAvance: Decimal;
//         DecCessionSalaire: Decimal;
//         DecPretCNSSLog: Decimal;
//         DecPretCNSSVoit: Decimal;
//         DecPretSociete: Decimal;
//         DecArrdPlus: Decimal;
//         DecArrdMoins: Decimal;
//         Text001: label 'Erreur, vous devez inserer l''Année';
//         Text002: label 'Erreur, vous devez inserer le Mois';
//         Text003: label 'Erreur, Vous devez vérifier le montant Brut et le montant Brut SIVP ';
//         RecGenJournalLine: Record "Gen. Journal Line";
//         RecHumanResourcesSetup: Record "Human Resources Setup";
//         NoSeriesMgt: Codeunit NoSeriesManagement;
//         NumPaie: Code[20];
//         DateCpt: Date;
//         RecMontatPaie: Record "Echelon Temporaire";
//         RecEcritValeurPaie: Record "Chiffre Affaire";
//         FilterCode: Text[100];
//         Text004: label 'Erreur, Vous devez vérifier le montant Prêt Société';
//         Text005: label 'Erreur, Vous devez vérifier le montant Avance';
//         Text006: label 'Erreur, Vous devez vérifier le montant Net';
//         NbLigne: Integer;
//         Text007: label 'INTEGRATION REUISSITE, VERIFIER LE FEUILLE COMPTABILITE PAIE';
//         RecValeurPaieCompt: Record "Chiffre Affaire";
//         Text008: label 'Erreur, Ces écritures sont déja Integrer en Comptabilité';
//         RecRecSalaryLines: Record "Rec. Salary Lines";
//         RecEntetPret: Record "Loan & Advance Header";
//         RecLignePret: Record "Loan & Advance Lines";
// }

