// Page 50100 "Contrat Leasing"
// {
//     DelayedInsert = true;
//     PageType = Card;
//     SourceTable = Contrat;
//     Caption = 'Contrat Leasing';

//     layout
//     {
//         area(content)
//         {
//             group(Contrat)
//             {
//                 Caption = 'Contrat';
//                 field("N°"; rec."N°")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Date Contrat"; rec."Date Contrat")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Fournisseur; rec.Fournisseur)
//                 {
//                     ApplicationArea = Basic;

//                     trigger OnValidate()
//                     begin
//                         FournisseurOnAfterValidate;
//                     end;
//                 }
//                 field("Nom Fournisseur"; rec."Nom Fournisseur")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Banque; rec.Banque)
//                 {
//                     ApplicationArea = Basic;

//                     trigger OnValidate()
//                     begin
//                         rec.CalcFields("Nom Banque");
//                     end;
//                 }
//                 field("Nom Banque"; rec."Nom Banque")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Duree; rec.Duree)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Periodicite; rec.Periodicite)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Date Depart"; rec."Date Depart")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Observation; rec.Observation)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Total TTC"; rec."Total TTC")
//                 {
//                     ApplicationArea = Basic;
//                     Style = Unfavorable;
//                     StyleExpr = true;
//                 }
//                 field("Montant Loyer TTC"; rec."Montant Loyer TTC")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Montant Loyer HT"; rec."Montant Loyer HT")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Statut; rec.Statut)
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//             part(Control1000000017; "Detail Contrat Leasing")
//             {
//                 SubpageLink = "N° Contrat" = field("N°");
//             }
//             group(Echeancier)
//             {
//                 Caption = 'Echeancier';
//                 part(Control1000000025; "Echeancier Contrat")
//                 {
//                     SubpageLink = Contrat = field("N°");
//                 }
//             }
//             group(Bordereau)
//             {
//                 Caption = 'Bordereau';
//                 part(Control1000000031; "Liste Bordereau Contrat")
//                 {
//                     SubpageLink = "N° Contrat" = field("N°");
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             action("Génèrer Bordereau")
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Génèrer Bordereau';
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 begin
//                     CreerBOR;
//                 end;
//             }
//             action("Génèrer Echeancier")
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Génèrer Echeancier';
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 begin
//                     rec.TestField(Banque);
//                     rec.TestField(Duree);
//                     rec.TestField(Fournisseur);
//                     rec.TestField("Date Contrat");
//                     rec.TestField("Date Depart");
//                     rec.TestField("Montant Loyer TTC");

//                     if not Confirm(Text001) then exit;
//                     EcheancierContrat.SetRange(Contrat, rec."N°");
//                     EcheancierContrat.DeleteAll;
//                     for Compteur := 1 to rec.Duree do begin
//                         EcheancierContrat.Init;
//                         EcheancierContrat."N°" := Compteur;
//                         EcheancierContrat.Contrat := rec."N°";
//                         if Compteur = 1 then begin
//                             EcheancierContrat."Date Echeance" := rec."Date Depart";
//                             DateEcheance := rec."Date Depart";
//                         end
//                         else begin
//                             EcheancierContrat."Date Echeance" := CalcDate('1M', DateEcheance);
//                             DateEcheance := EcheancierContrat."Date Echeance";
//                         end;
//                         EcheancierContrat."Loyer TTC" := rec."Montant Loyer TTC";
//                         EcheancierContrat.Annee := Date2dmy(DateEcheance, 3);
//                         EcheancierContrat.Insert;
//                     end;
//                 end;
//             }
//         }
//     }

//     var
//         EcheancierContrat: Record "Echeancier Contrat";
//         Text001: label 'Génèrer Echeancier Du Contrat ?';
//         Compteur: Integer;
//         DateEcheance: Date;
//         RecPaymentHeader: Record 10865;
//         RecPaymentHeader2: Record 10865;
//         RecPaymentLine: Record 10866;
//         Text002: label 'Génèrer Bordereau Du Contrat ?';
//         Text003: label 'Traitement Achevé Avec Succé';
//         Text004: label 'Bordereau Deja Génèré';


//     procedure CreerBOR()
//     begin

//         rec.TestField(Banque);
//         rec.TestField(Fournisseur);

//         if not Confirm(Text002) then exit;
//         RecPaymentHeader2.SetRange("N° Contrat", rec."N°");
//         if RecPaymentHeader2.FindFirst then Error(Text004);
//         EcheancierContrat.SetRange(Contrat, rec."N°");
//         if EcheancierContrat.FindFirst then
//             repeat
//                 // ENTETE
//                 RecPaymentHeader.Init;
//                 RecPaymentHeader."No." := '';
//                 if EcheancierContrat."Mode Paiement" = EcheancierContrat."mode paiement"::Cheque then begin
//                     RecPaymentHeader.GetNoSeries('DECAISS-CHEQUE');
//                     RecPaymentHeader.Validate("Payment Class", 'DECAISS-CHEQUE');

//                 end;
//                 if EcheancierContrat."Mode Paiement" = EcheancierContrat."mode paiement"::Traite then begin
//                     RecPaymentHeader.GetNoSeries('DECAISS-TRAITE');
//                     RecPaymentHeader.Validate("Payment Class", 'DECAISS-TRAITE');
//                 end;
//                 RecPaymentHeader."Account Type" := RecPaymentHeader."account type"::"Bank Account";
//                 RecPaymentHeader.Validate("Account No.", rec.Banque);
//                 RecPaymentHeader."N° Contrat" := rec."N°";
//                 if EcheancierContrat."Mode Paiement" = EcheancierContrat."mode paiement"::Cheque then
//                     RecPaymentHeader."Mode Paiement" := RecPaymentHeader."mode paiement"::Cheque;
//                 if EcheancierContrat."Mode Paiement" = EcheancierContrat."mode paiement"::Traite then
//                     RecPaymentHeader."Mode Paiement" := RecPaymentHeader."mode paiement"::Traite;
//                 // RB SORO 31/01/2017 RecPaymentHeader.VALIDATE("Posting Date",EcheancierContrat."Date Echeance");
//                 RecPaymentHeader.Validate("Posting Date", Today);
//                 RecPaymentHeader.Insert;

//                 // LIGNE

//                 RecPaymentLine.Init;

//                 RecPaymentLine."No." := RecPaymentHeader."No.";
//                 RecPaymentLine.Validate("Type de compte", RecPaymentLine."account type"::Vendor);
//                 RecPaymentLine.Validate("Code compte", rec.Fournisseur);
//                 RecPaymentLine."Payment Class" := RecPaymentHeader."Payment Class";
//                 RecPaymentLine."Status No." := RecPaymentHeader."Status No.";
//                 RecPaymentLine."Line No." := 10000;
//                 RecPaymentLine.Validate("Debit Amount", EcheancierContrat."Loyer TTC");
//                 RecPaymentLine."N° Contrat" := rec."N°";
//                 RecPaymentLine."Due Date" := EcheancierContrat."Date Echeance";
//                 RecPaymentLine."N° Ligen Contrat" := EcheancierContrat."N°";
//                 RecPaymentLine."Mode Paiement" := RecPaymentLine."mode paiement"::Traite;
//                 RecPaymentLine.Insert(true);
//             //ValidatePayment2(RecPaymentHeader);
//             until EcheancierContrat.Next = 0;

//         Message(Text003);
//     end;

//     local procedure FournisseurOnAfterValidate()
//     begin
//         rec.CalcFields("Nom Fournisseur");
//     end;
// }

