report 52048881 "Payroll : Post Payment @"
{
    // //GL2024  ID dans Nav 2009 : "39001403"
    // //   "Heures sup. eregistrées".

    // Caption = 'Integration Paie en comptabilité';
    // ProcessingOnly = true;
    // ApplicationArea = all;
    // UsageCategory = ReportsAndAnalysis;

    // dataset
    // {
    //     dataitem("Rec. Salary Headers"; "Rec. Salary Headers")
    //     {
    //         RequestFilterFields = "No.";
    //         RequestFilterHeading = 'Paie à intégrer';

    //         trigger OnAfterGetRecord()
    //         begin

    //             Window.OPEN('############################################1####\' +
    //                          'Traitement En Cours                       \' +
    //                          'Soroubat Tunisie© - NE                      \' +
    //                          FORMAT(WORKDATE) + ' - ' + COMPANYNAME);


    //             /*IF "Rec. Salary Headers"."Intégré en comptabilité" THEN
    //               BEGIN
    //                 ERROR ('Erreur : La paie N° %1 a été intégrée en comptabilité !',FORMAT ("Rec. Salary Headers"."No.") + ' - ' +
    //                        "Rec. Salary Headers".Description);
    //                 Window.CLOSE;
    //               END;*/
    //             FilterAnnee := "Rec. Salary Headers".Year;
    //             FilterMois := "Rec. Salary Headers".Month;
    //             //
    //             MMois := "Rec. Salary Headers".Month;
    //             IF MMois > 11 THEN BEGIN
    //                 MMois := DATE2DMY("Rec. Salary Headers"."Posting Date", 2);
    //             END;
    //             //
    //             DecBrut := 0;
    //             DecCNSS := 0;
    //             DecImpot := 0;
    //             DecNet := 0;
    //             DecRedevance := 0;
    //             DecAvance := 0;
    //             DecCessionSalaire := 0;
    //             DecPretCNSSLog := 0;
    //             DecPretCNSSVoit := 0;
    //             DecPretSociete := 0;
    //             DecArrdPlus := 0;
    //             DecContributionSociale := 0;
    //             DecArrdMoins := 0;
    //             CessionSurSalaire := 0;
    //             RecRecSalaryLines.RESET;
    //             RecRecSalaryLines.SETRANGE(Year, FilterAnnee);
    //             RecRecSalaryLines.SETRANGE(Month, FilterMois);
    //             RecRecSalaryLines.SETFILTER("No.", "Rec. Salary Headers".GETFILTER("No."));
    //             IF RecRecSalaryLines.FINDFIRST THEN
    //                 REPEAT
    //                     DecBrut += RecRecSalaryLines."Gross Salary";
    //                     RecRecSalaryLines.CALCFIELDS("Type Contrat Employee");
    //                     IF (COPYSTR(RecRecSalaryLines.Catégorie, 1, 2) = 'SV') OR (COPYSTR(RecRecSalaryLines.Catégorie, 1, 2) = 'KR') THEN
    //                         //IF (RecRecSalaryLines."Type Contrat Employee" = RecRecSalaryLines."Type Contrat Employee"::"SIVP I 1iere Année")
    //                         //OR (RecRecSalaryLines."Type Contrat Employee" = RecRecSalaryLines."Type Contrat Employee"::"SIVP I 2ieme Année")
    //                         //OR (RecRecSalaryLines."Type Contrat Employee" = RecRecSalaryLines."Type Contrat Employee"::"SIVP II")
    //                         //OR (RecRecSalaryLines."Type Contrat Employee" = RecRecSalaryLines."Type Contrat Employee"::Stagiaire)
    //                         //OR (RecRecSalaryLines."Type Contrat Employee" = RecRecSalaryLines."Type Contrat Employee"::Particulier) THEN
    //                         DecBrutSIVP += RecRecSalaryLines."Gross Salary"
    //                     ELSE
    //                         IF RecRecSalaryLines.CNSS <> 0 THEN DecBrutNormal += RecRecSalaryLines."Gross Salary";
    //                     DecCNSS += RecRecSalaryLines.CNSS;
    //                     DecImpot += RecRecSalaryLines."Taxe (Month)";
    //                     DecNet += RecRecSalaryLines."Net salary cashed";
    //                     DecCessionSalaire += RecRecSalaryLines.Retenu + RecRecSalaryLines.Cession;
    //                     DecAvance += RecRecSalaryLines.Advances;
    //                     DecArrdPlus += RecRecSalaryLines."Ajout  en +";
    //                     IF RecRecSalaryLines."Ajout  en +" = 0 THEN DecArrdMoins += RecRecSalaryLines."Report en -";
    //                     DecContributionSociale += RecRecSalaryLines."Contribution Social";
    //                 UNTIL RecRecSalaryLines.NEXT = 0;

    //             RecLignePret.RESET;
    //             RecLignePret.SETRANGE(Year, FilterAnnee);
    //             RecLignePret.SETRANGE(Month, FilterMois);
    //             RecLignePret.SETFILTER("Payment No.", "Rec. Salary Headers".GETFILTER("No."));
    //             IF RecLignePret.FINDFIRST THEN
    //                 REPEAT
    //                     RecEntetPret.RESET;
    //                     RecEntetPret.GET(RecLignePret."No.");
    //                     IF RecEntetPret."Pret CNSS" = RecEntetPret."Pret CNSS"::Logement THEN DecPretCNSSLog += RecLignePret."Line Amount";
    //                     IF RecEntetPret."Pret CNSS" = RecEntetPret."Pret CNSS"::Voiture THEN DecPretCNSSVoit += RecLignePret."Line Amount";
    //                     IF RecEntetPret."Pret CNSS" = RecEntetPret."Pret CNSS"::Cession THEN DecPretCession += RecLignePret."Line Amount";
    //                     IF RecEntetPret."Pret CNSS" = 0 THEN DecPretSociete += RecLignePret."Line Amount";

    //                 UNTIL RecLignePret.NEXT = 0;

    //         end;

    //         trigger OnPostDataItem()
    //         begin
    //             "Rec. Salary Headers"."Intégré en comptabilité" := TRUE;
    //             "Rec. Salary Headers".MODIFY
    //         end;

    //         trigger OnPreDataItem()
    //         begin
    //             RecGenJournalLine.SETRANGE("Journal Template Name", 'PAIE');
    //             RecGenJournalLine.SETRANGE("Journal Batch Name", 'PAIE');
    //             RecGenJournalLine.DELETEALL;
    //         end;
    //     }
    //     dataitem(PostPaie; Integer)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));

    //         trigger OnAfterGetRecord()
    //         begin
    //             IF (DecBrutNormal = 0) AND (DecBrutSIVP = 0) THEN
    //                 ERROR(Text003);

    //             DateCpt := DMY2DATE(1, MMois + 1, FilterAnnee);
    //             DateCpt := CALCDATE('FM', DateCpt);
    //             MMois += 1;
    //             // MAJ N° DOCUMENT
    //             IF RecHumanResourcesSetup.GET THEN;
    //             NumPaie := NoSeriesMgt.GetNextNo(RecHumanResourcesSetup."Recap Paie", WORKDATE, TRUE);

    //             // INSERTION DANS LA TABLE "Gen. Journal Line"
    //             RecGenJournalLine.RESET;
    //             RecGenJournalLine."Journal Template Name" := 'PAIE';
    //             RecGenJournalLine."Journal Batch Name" := 'PAIE';

    //             // Montant Brut (Normal)
    //             RecGenJournalLine."Line No." := 10000;
    //             RecGenJournalLine.VALIDATE("Account No.", '64000000');
    //             RecGenJournalLine."Posting Date" := DateCpt;
    //             RecGenJournalLine."Document No." := NumPaie;
    //             RecGenJournalLine.VALIDATE("Debit Amount", DecBrutNormal);
    //             RecGenJournalLine.Description := 'SALAIRE BRUT' + ' ' + FORMAT(MMois) + ' ' + FORMAT(FilterAnnee);
    //             RecGenJournalLine."Source Code" := '10';
    //             RecGenJournalLine.INSERT;

    //             // Montant Brut (SIVP)
    //             RecGenJournalLine."Line No." := 20000;
    //             RecGenJournalLine.VALIDATE("Account No.", '64100000');
    //             RecGenJournalLine."Posting Date" := DateCpt;
    //             RecGenJournalLine."Document No." := NumPaie;
    //             RecGenJournalLine.VALIDATE("Debit Amount", DecBrutSIVP);
    //             RecGenJournalLine.Description := 'SIVP' + ' ' + FORMAT(MMois) + ' ' + FORMAT(FilterAnnee);
    //             RecGenJournalLine."Source Code" := '10';
    //             RecGenJournalLine.INSERT;

    //             // Montant CNSS
    //             RecGenJournalLine."Line No." := 30000;
    //             RecGenJournalLine.VALIDATE("Account No.", '45311000');
    //             RecGenJournalLine."Posting Date" := DateCpt;
    //             RecGenJournalLine."Document No." := NumPaie;
    //             RecGenJournalLine.VALIDATE("Credit Amount", DecCNSS);
    //             RecGenJournalLine.Description := 'CNSS' + ' ' + FORMAT(MMois) + ' ' + FORMAT(FilterAnnee);
    //             RecGenJournalLine."Source Code" := '10';
    //             RecGenJournalLine.INSERT;

    //             // Montant Impot
    //             RecGenJournalLine."Line No." := 40000;
    //             RecGenJournalLine.VALIDATE("Account No.", '43200000');
    //             RecGenJournalLine."Posting Date" := DateCpt;
    //             RecGenJournalLine."Document No." := NumPaie;
    //             RecGenJournalLine.VALIDATE("Credit Amount", DecImpot);
    //             RecGenJournalLine.Description := 'RS/SALAIRE' + ' ' + FORMAT(MMois) + ' ' + FORMAT(FilterAnnee);
    //             RecGenJournalLine."Source Code" := '10';
    //             RecGenJournalLine.INSERT;

    //             // Contribution Social
    //             RecGenJournalLine."Line No." := 41000;
    //             RecGenJournalLine.VALIDATE("Account No.", '43200100');
    //             RecGenJournalLine."Posting Date" := DateCpt;
    //             RecGenJournalLine."Document No." := NumPaie;
    //             RecGenJournalLine.VALIDATE("Credit Amount", DecContributionSociale);
    //             RecGenJournalLine.Description := 'CONTRIBUTION SOCIALE' + ' ' + FORMAT(MMois) + ' ' + FORMAT(FilterAnnee);
    //             RecGenJournalLine."Source Code" := '10';
    //             RecGenJournalLine.INSERT;

    //             // Montant Redevance
    //             RecGenJournalLine."Line No." := 50000;
    //             RecGenJournalLine.VALIDATE("Account No.", '43245000');
    //             RecGenJournalLine."Posting Date" := DateCpt;
    //             RecGenJournalLine."Document No." := NumPaie;
    //             RecGenJournalLine.VALIDATE("Credit Amount", DecRedevance);
    //             RecGenJournalLine.Description := 'REDEVANCES' + ' ' + FORMAT(MMois) + ' ' + FORMAT(FilterAnnee);
    //             RecGenJournalLine."Source Code" := '10';
    //             RecGenJournalLine.INSERT;

    //             // Montant Avance
    //             IF DecAvance <> 0 THEN BEGIN
    //                 RecGenJournalLine."Line No." := 60000;
    //                 // MH SORO 03-03-2021 à éléminer
    //                 /* IF MMois = 1 THEN RecGenJournalLine.VALIDATE("Account No.",'42100001')
    //                  ELSE IF MMois = 2 THEN RecGenJournalLine.VALIDATE("Account No.",'42100002')
    //                  ELSE IF MMois = 3 THEN RecGenJournalLine.VALIDATE("Account No.",'42100003')
    //                  ELSE IF MMois = 4 THEN RecGenJournalLine.VALIDATE("Account No.",'42100004')
    //                  ELSE IF MMois = 5 THEN RecGenJournalLine.VALIDATE("Account No.",'42100005')
    //                  ELSE IF MMois = 6 THEN RecGenJournalLine.VALIDATE("Account No.",'42100006')
    //                  ELSE IF MMois = 7 THEN RecGenJournalLine.VALIDATE("Account No.",'42100007')
    //                  ELSE IF MMois = 8 THEN RecGenJournalLine.VALIDATE("Account No.",'42100008')
    //                  ELSE IF MMois = 9 THEN RecGenJournalLine.VALIDATE("Account No.",'42100009')
    //                  ELSE IF MMois = 10 THEN RecGenJournalLine.VALIDATE("Account No.",'42100010')
    //                  ELSE IF MMois = 11 THEN RecGenJournalLine.VALIDATE("Account No.",'42100011')
    //                  ELSE RecGenJournalLine.VALIDATE("Account No.",'42100012'); */
    //                 // MH SORO 03-03-2021 à éléminer
    //                 RecGenJournalLine.VALIDATE("Account No.", '42100000');
    //                 RecGenJournalLine."Posting Date" := DateCpt;
    //                 RecGenJournalLine."Document No." := NumPaie;
    //                 RecGenJournalLine.VALIDATE("Credit Amount", DecAvance);
    //                 RecGenJournalLine.Description := 'AVANCE/SALAIRE' + ' ' + FORMAT(MMois) + ' ' + FORMAT(FilterAnnee);
    //                 RecGenJournalLine."Source Code" := '10';
    //                 RecGenJournalLine.INSERT;
    //             END;

    //             // Montant Cession Sur Salaire
    //             RecGenJournalLine."Line No." := 70000;
    //             RecGenJournalLine.VALIDATE("Account No.", '42860010');
    //             RecGenJournalLine."Posting Date" := DateCpt;
    //             RecGenJournalLine."Document No." := NumPaie;
    //             RecGenJournalLine.VALIDATE("Credit Amount", DecCessionSalaire);
    //             RecGenJournalLine.Description := 'CESSION' + ' ' + FORMAT(MMois) + ' ' + FORMAT(FilterAnnee);
    //             RecGenJournalLine."Source Code" := '10';
    //             RecGenJournalLine.INSERT;

    //             // Montant Pret Cession Sur Salaire
    //             RecGenJournalLine."Line No." := 70500;
    //             RecGenJournalLine.VALIDATE("Account No.", '42860010');
    //             RecGenJournalLine."Posting Date" := DateCpt;
    //             RecGenJournalLine."Document No." := NumPaie;
    //             RecGenJournalLine.VALIDATE("Credit Amount", DecPretCession);
    //             RecGenJournalLine.Description := 'PRET CESSION' + ' ' + FORMAT(MMois) + ' ' + FORMAT(FilterAnnee);
    //             RecGenJournalLine."Source Code" := '10';
    //             RecGenJournalLine.INSERT;
    //             //
    //             // Montant Pret CNSS Logement
    //             RecGenJournalLine."Line No." := 80000;
    //             RecGenJournalLine.VALIDATE("Account No.", '45313000');
    //             RecGenJournalLine."Posting Date" := DateCpt;
    //             RecGenJournalLine."Document No." := NumPaie;
    //             RecGenJournalLine.VALIDATE("Credit Amount", DecPretCNSSLog);
    //             RecGenJournalLine.Description := 'PRET CNSS LOGEMENT' + ' ' + FORMAT(MMois) + ' ' + FORMAT(FilterAnnee);
    //             RecGenJournalLine."Source Code" := '10';
    //             RecGenJournalLine.INSERT;

    //             // Montant Pret CNSS Voiture
    //             RecGenJournalLine."Line No." := 90000;
    //             RecGenJournalLine.VALIDATE("Account No.", '45313000');
    //             RecGenJournalLine."Posting Date" := DateCpt;
    //             RecGenJournalLine."Document No." := NumPaie;
    //             RecGenJournalLine.VALIDATE("Credit Amount", DecPretCNSSVoit);
    //             RecGenJournalLine.Description := 'PRET CNSS VOITURE ' + ' ' + FORMAT(MMois) + ' ' + FORMAT(FilterAnnee);
    //             RecGenJournalLine."Source Code" := '10';
    //             RecGenJournalLine.INSERT;

    //             // Montant Arrondissement +
    //             RecGenJournalLine."Line No." := 100000;
    //             RecGenJournalLine.VALIDATE("Account No.", '42500000');
    //             RecGenJournalLine."Posting Date" := DateCpt;
    //             RecGenJournalLine."Document No." := NumPaie;
    //             RecGenJournalLine.VALIDATE("Debit Amount", DecArrdPlus);
    //             RecGenJournalLine.Description := 'ARRONDISSEMENT +' + ' ' + FORMAT(MMois) + ' ' + FORMAT(FilterAnnee);
    //             RecGenJournalLine."Source Code" := '10';
    //             RecGenJournalLine.INSERT;

    //             // Montant Arrondissement -
    //             RecGenJournalLine."Line No." := 110000;
    //             RecGenJournalLine.VALIDATE("Account No.", '42500000');
    //             RecGenJournalLine."Posting Date" := DateCpt;
    //             RecGenJournalLine."Document No." := NumPaie;
    //             RecGenJournalLine.VALIDATE("Credit Amount", DecArrdMoins);
    //             RecGenJournalLine.Description := 'ARRONDISSEMENT -' + ' ' + FORMAT(MMois) + ' ' + FORMAT(FilterAnnee);
    //             RecGenJournalLine."Source Code" := '10';
    //             RecGenJournalLine.INSERT;

    //             // Montant Net
    //             RecGenJournalLine."Line No." := 120000;

    //             // MH SORO 03-03-2021 à éléminer
    //             /*IF MMois = 1 THEN RecGenJournalLine.VALIDATE("Account No.",'42500001')
    //             ELSE IF MMois = 2 THEN RecGenJournalLine.VALIDATE("Account No.",'42500002')
    //             ELSE IF MMois = 3 THEN RecGenJournalLine.VALIDATE("Account No.",'42500003')
    //             ELSE IF MMois = 4 THEN RecGenJournalLine.VALIDATE("Account No.",'42500004')
    //             ELSE IF MMois = 5 THEN RecGenJournalLine.VALIDATE("Account No.",'42500005')
    //             ELSE IF MMois = 6 THEN RecGenJournalLine.VALIDATE("Account No.",'42500006')
    //             ELSE IF MMois = 7 THEN RecGenJournalLine.VALIDATE("Account No.",'42500007')
    //             ELSE IF MMois = 8 THEN RecGenJournalLine.VALIDATE("Account No.",'42500008')
    //             ELSE IF MMois = 9 THEN RecGenJournalLine.VALIDATE("Account No.",'42500009')
    //             ELSE IF MMois = 10 THEN RecGenJournalLine.VALIDATE("Account No.",'42500010')
    //             ELSE IF MMois = 11 THEN RecGenJournalLine.VALIDATE("Account No.",'42500011')
    //             ELSE RecGenJournalLine.VALIDATE("Account No.",'42500012');*/
    //             // MH SORO 03-03-2021 à éléminer
    //             RecGenJournalLine.VALIDATE("Account No.", '42500000');
    //             RecGenJournalLine."Posting Date" := DateCpt;
    //             RecGenJournalLine."Document No." := NumPaie;
    //             RecGenJournalLine.VALIDATE("Credit Amount", DecNet);
    //             RecGenJournalLine.Description := 'NET' + ' ' + FORMAT(MMois) + ' ' + FORMAT(FilterAnnee);
    //             RecGenJournalLine."Source Code" := '10';
    //             RecGenJournalLine.INSERT;

    //             // Montant Pret Société
    //             NbLigne := 120000;
    //             FilterAnnee := "Rec. Salary Headers".Year;
    //             MMois := "Rec. Salary Headers".Month;
    //             RecRecSalaryLines.RESET;
    //             RecRecSalaryLines.SETRANGE(Year, FilterAnnee);
    //             RecRecSalaryLines.SETRANGE(Month, MMois);
    //             RecRecSalaryLines.SETFILTER(Loans, '<>%1', 0);

    //             RecLignePret.RESET;
    //             RecLignePret.SETRANGE(Year, FilterAnnee);
    //             RecLignePret.SETRANGE(Month, MMois);
    //             RecLignePret.SETRANGE(Type, RecLignePret.Type::Loan);
    //             RecLignePret.SETFILTER("Payment No.", "Rec. Salary Headers".GETFILTER("No."));
    //             IF RecLignePret.FINDFIRST THEN
    //                 REPEAT
    //                     RecEntetPret.RESET;
    //                     RecEntetPret.GET(RecLignePret."No.");
    //                     IF RecEntetPret."Pret CNSS" = 0 THEN BEGIN
    //                         NbLigne := NbLigne + 10000;
    //                         RecGenJournalLine."Line No." := NbLigne;
    //                         RecGenJournalLine.VALIDATE("Account No.", '51600000');
    //                         RecGenJournalLine."Posting Date" := DateCpt;
    //                         RecGenJournalLine."Document No." := NumPaie;
    //                         RecGenJournalLine.VALIDATE("Credit Amount", RecLignePret."Line Amount");
    //                         RecGenJournalLine.Description := 'PRET SOCIETE' + ' ' + FORMAT(MMois + 1) + ' ' + FORMAT(FilterAnnee);
    //                         RecGenJournalLine.Salarie := RecLignePret.Employee;
    //                         RecGenJournalLine."Source Code" := '10';
    //                         RecGenJournalLine.INSERT;

    //                     END;
    //                 UNTIL RecLignePret.NEXT = 0;


    //             //
    //             MESSAGE(Text007);
    //             // INITIALISER LES ECRITURES A INSERER EN COMPTABILITE
    //             //RecValeurPaieCompt.RESET;
    //             //RecValeurPaieCompt.SETRANGE("Dec.",FilterAnnee);
    //             //RecValeurPaieCompt.SETRANGE(HT,MMois);
    //             //IF RecValeurPaieCompt.FINDFIRST THEN
    //             //BEGIN
    //             //  RecValeurPaieCompt."Solde D/F" := TRUE;
    //             //  RecValeurPaieCompt.MODIFY;
    //             //END;

    //         end;
    //     }
    // }

    // requestpage
    // {

    //     layout
    //     {
    //     }

    //     actions
    //     {
    //     }
    // }

    // labels
    // {
    // }

    // trigger OnPostReport()
    // begin

    //     Window.CLOSE;
    // end;

    // var


    //     Window: Dialog;
    //     RecValeurPaie: Record "Chiffre Affaire";
    //     FilterAnnee: Integer;
    //     FilterMois: Integer;
    //     DecBrut: Decimal;
    //     DecBrutNormal: Decimal;
    //     DecBrutSIVP: Decimal;
    //     DecCNSS: Decimal;
    //     DecImpot: Decimal;
    //     DecNet: Decimal;
    //     DecRedevance: Decimal;
    //     DecAvance: Decimal;
    //     DecCessionSalaire: Decimal;
    //     DecPretCNSSLog: Decimal;
    //     DecPretCNSSVoit: Decimal;
    //     DecPretSociete: Decimal;
    //     DecPretCession: Decimal;
    //     DecArrdPlus: Decimal;
    //     DecArrdMoins: Decimal;
    //     RecGenJournalLine: Record 81;
    //     DecContributionSociale: Decimal;
    //     RecHumanResourcesSetup: Record 5218;
    //     NoSeriesMgt: Codeunit 396;
    //     NumPaie: Code[20];
    //     DateCpt: Date;
    //     RecMontatPaie: Record "Echelon Temporaire";
    //     RecEcritValeurPaie: Record "Chiffre Affaire";
    //     FilterCode: Text[100];
    //     NbLigne: Integer;
    //     RecValeurPaieCompt: Record "Chiffre Affaire";
    //     RecRecSalaryLines: Record "Rec. Salary Lines";
    //     RecEntetPret: Record "Loan & Advance Header";
    //     RecLignePret: Record "Loan & Advance Lines";
    //     Text001: Label 'Erreur, vous devez inserer l''Année';
    //     Text002: Label 'Erreur, vous devez inserer le Mois';
    //     Text003: Label 'Erreur, Vous devez vérifier le montant Brut et le montant Brut SIVP ';
    //     Text004: Label 'Erreur, Vous devez vérifier le montant Prêt Société';
    //     Text005: Label 'Erreur, Vous devez vérifier le montant Avance';
    //     Text006: Label 'Erreur, Vous devez vérifier le montant Net';
    //     Text007: Label 'INTEGRATION REUISSITE, VERIFIER LE FEUILLE COMPTABILITE PAIE';
    //     Text008: Label 'Erreur, Ces écritures sont déja Integrer en Comptabilité';
    //     SalaryHeadersEnregister: Record "Rec. Salary Headers";
    //     CessionSurSalaire: Decimal;
    //     MMois: Integer;
}

