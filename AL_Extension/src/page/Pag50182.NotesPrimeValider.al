// Page 50182 "Notes Prime Valider"
// {
//     DelayedInsert = true;
//     Editable = true;
//     PageType = List;
//     SourceTable = Notes;
//     SourceTableView = where(Statut = const(Validé));
//     ApplicationArea = all;
//     Caption = 'Notes Prime Valider';
//     UsageCategory = Lists;
//     layout
//     {
//         area(content)
//         {
//             field("AnnéePrime"; AnnéePrime)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Année';

//                 trigger OnValidate()
//                 begin
//                     REC.Reset;
//                     REC.SetFilter(Rec.Année, '=%1', AnnéePrime);
//                     REC.SetRange(Statut, REC.Statut::Validé);
//                     //Rec.SETFILTER(Rec.Affectation,'=%1',Affectation);
//                     Ann233ePrimeOnAfterValidate;
//                 end;
//             }
//             repeater(Control1)
//             {
//                 Editable = false;
//                 ShowCaption = false;
//                 field("Année"; REC.Année)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Matricule; REC.Matricule)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Nom Salariée"; REC."Nom Salariée")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Description Affectation"; REC."Description Affectation")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(JO; REC.JO)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Description Qualification"; REC."Description Qualification")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Note; REC.Note)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Net; REC.Net)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Nbre Fiche"; REC."Nbre Fiche")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Nbre Jours Base calcul"; REC."Nbre Jours Base calcul")
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Nbre Mois Base calcul"; REC."Nbre Mois Base calcul")
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Nbre Jours Réelle"; REC."Nbre Jours Réelle")
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Nbre Mois Réelle"; REC."Nbre Mois Réelle")
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Ancienté"; REC.Ancienté)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Ancienté';
//                 }
//                 field("Base Calcul"; REC."Base Calcul")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Montant Ancienneté"; REC."Montant Ancienneté")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Montant Prime Base calcul"; REC."Montant Prime Base calcul")
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Montant Prime"; REC."Montant Prime")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Imposable; REC.Imposable)
//                 {
//                     ApplicationArea = all;
//                 }
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
//                 actionref("Remplir Ligne prime1"; "Remplir Ligne prime") { }
//                 actionref("Imprimer Etat Prime1"; "Imprimer Etat Prime") { }
//                 actionref("Imprimer Emargement Prime1"; "Imprimer Emargement Prime") { }
//                 actionref(Valider1; Valider) { }

//             }
//         }
//         area(navigation)
//         {
//             group(Fonction)
//             {
//                 Caption = 'Fonction';
//                 action("Remplir Ligne prime")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Remplir Ligne prime';

//                     trigger OnAction()
//                     begin

//                         if AnnéePrime = 0 then
//                             Error(Text001);
//                         if not Confirm(Text004) then exit;
//                         //FormPrepLotSal.GetParametres(Code,"Code Banque");
//                         //FormPrepLotSal.RUN;
//                         RecSalaryLines.SetRange(RecSalaryLines.Month, 11);
//                         RecSalaryLines.SetRange(RecSalaryLines.Year, AnnéePrime);
//                         if RecSalaryLines.FindFirst then
//                             repeat

//                                 Salarie.Reset();
//                                 Salarie.SetRange(Salarie."No.", RecSalaryLines.Employee);
//                                 if Salarie.FindFirst then begin
//                                     NbreFiche := 0;
//                                     //*********************Nbre Fiche
//                                     RecSalaryLines2.Reset();
//                                     RecSalaryLines2.SetRange(RecSalaryLines2.Employee, RecSalaryLines.Employee);
//                                     RecSalaryLines2.SetRange(RecSalaryLines2.Year, AnnéePrime);
//                                     if RecSalaryLines2.FindFirst() then
//                                         repeat
//                                             NbreFiche := NbreFiche + 1;

//                                         until RecSalaryLines2.Next = 0;
//                                     if (Salarie.Blocked = false) and (NbreFiche >= 12) then begin
//                                         Notesprime.Année := 2015;
//                                         Notesprime.Matricule := RecSalaryLines2.Employee;
//                                         Notesprime.Affectation := RecSalaryLines2.Affectation;
//                                         Notesprime.Qualification := RecSalaryLines2.Qualification;
//                                         if Affectat.Get(RecSalaryLines2.Affectation) then Notesprime."Description Affectation" := Affectat.Decription;
//                                         if Qualifica.Get(RecSalaryLines2.Qualification) then Notesprime."Description Qualification" := Qualifica.Description;
//                                         Notesprime."Nom Salariée" := RecSalaryLines2.Name;
//                                         Notesprime.Insert;

//                                     end;

//                                 end;


//                             until RecSalaryLines.Next = 0;
//                         CurrPage.Update;
//                         Message(Text003);
//                     end;
//                 }
//                 separator(Action1000000014)
//                 {
//                 }
//                 action("Imprimer Etat Prime")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Imprimer Etat Prime';

//                     trigger OnAction()
//                     begin
//                         if AnnéePrime = 0 then
//                             Error(Text001);

//                         Notesprime.SetRange(Notesprime.Année, AnnéePrime);
//                         Report.RunModal(50169, true, false, Notesprime);
//                     end;
//                 }
//                 action("Imprimer Emargement Prime")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Imprimer Emargement Prime';

//                     trigger OnAction()
//                     begin
//                         if AnnéePrime = 0 then
//                             Error(Text001);

//                         Notesprime.SetRange(Notesprime.Année, AnnéePrime);
//                         Report.RunModal(50178, true, false, Notesprime);
//                     end;
//                 }
//                 action(Valider)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Valider';

//                     trigger OnAction()
//                     begin
//                         if AnnéePrime = 0 then Error(Text001);
//                         if not Confirm(Text005) then exit;
//                         Notesprime.SetRange(Année, AnnéePrime);
//                         if Notesprime.FindFirst then
//                             repeat
//                                 Notesprime.Statut := Notesprime.Statut::Validé;
//                                 Notesprime.Modify;
//                             until Notesprime.Next = 0;
//                     end;
//                 }
//             }
//         }
//     }

//     var
//         //GL2024   FormPrepLotSal: page 52048995;
//         Text001: label 'Erreur, Vous devez saisir une Année !!!';
//         RecLigneLotPaie: Record "Ligne Lot Paie";
//         Text002: label 'il n a rien à validé';
//         RecSalaryLines: Record "Rec. Salary Lines";
//         Text003: label 'Insertion Terminée';
//         "AnnéePrime": Integer;
//         Notesprime: Record Notes;
//         Salarie: Record Employee;
//         NbreFiche: Integer;
//         RecSalaryLines2: Record "Rec. Salary Lines";
//         Text004: label 'Confirmer L''insertion ?';
//         Affectat: Record Section;
//         Qualifica: Record Qualification;
//         SubFormNotePrime: Page "SubForm Note Prime";
//         Text005: label 'Confimer la validation ?';

//     local procedure Ann233ePrimeOnAfterValidate()
//     begin
//         CurrPage.Update;
//     end;
// }

