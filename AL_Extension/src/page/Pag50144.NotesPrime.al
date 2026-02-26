// Page 50144 "Notes Prime"
// {
//     DelayedInsert = true;
//     PageType = List;
//     SourceTable = Notes;
//     SourceTableView = where(Statut = const(Ouvert));
//     ApplicationArea = all;
//     Caption = 'Notes Prime';
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

//                     REC.SetFilter(Rec.Année, '=%1', AnnéePrime);
//                     //Rec.SETFILTER(Rec.Affectation,'=%1',Affectation);
//                     Ann233ePrimeOnAfterValidate;
//                 end;
//             }
//             field(CdeMatricule; CdeMatricule)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Matricule';

//                 trigger OnValidate()
//                 begin

//                     REC.SetFilter(Rec.Année, '=%1', AnnéePrime);
//                     //Rec.SETFILTER(Rec.Affectation,'=%1',Affectation);
//                     CdeMatriculeOnAfterValidate;
//                 end;
//             }
//             field(CdeAffectation; CdeAffectation)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Affectation';
//                 TableRelation = Section;

//                 trigger OnValidate()
//                 begin

//                     REC.SetFilter(Rec.Année, '=%1', AnnéePrime);
//                     //Rec.SETFILTER(Rec.Affectation,'=%1',Affectation);
//                     CdeAffectationOnAfterValidate;
//                 end;
//             }
//             repeater(Control1)
//             {
//                 Editable = false;
//                 ShowCaption = false;
//                 field("Payé"; REC.Payé)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Année"; REC.Année)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Matricule; REC.Matricule)
//                 {
//                     ApplicationArea = all;
//                     Editable = true;

//                     trigger OnValidate()
//                     begin
//                         if AnnéePrime = 0 then
//                             Error(Text001);
//                         NbreFiche := 0;
//                         IntAnnéeAncienneté := 0;
//                         Notesprime.SetRange(Année, AnnéePrime);
//                         Notesprime.SetRange(Matricule, REC.Matricule);
//                         if Notesprime.FindFirst then Error(Text006);
//                         if Salarie.Get(REC.Matricule) then
//                             if not Salarie.Blocked then begin
//                                 REC.Année := AnnéePrime;
//                                 REC."Nom Salariée" := Salarie."First Name";
//                                 REC.Affectation := Salarie.Affectation;
//                                 REC.Qualification := Salarie.Qualification;
//                                 REC.Zone := Salarie.Zone;
//                                 if Affectat.Get(Salarie.Affectation) then REC."Description Affectation" := Affectat.Decription;
//                                 if Qualifica.Get(Salarie.Qualification) then REC."Description Qualification" := Qualifica.Description;
//                                 DateRefAnciennete := Dmy2date(31, 12, AnnéePrime);
//                                 IntMoisAncienneté := Managementofsalary.CalculerMoisAncienneté(REC.Matricule, DateRefAnciennete);
//                                 NewDate := CalcDate(Format(((IntMoisAncienneté - IntAnnéeAncienneté * 12) - 1)) + 'M', Salarie."Employment Date");
//                                 NbrJour := DateRefAnciennete - Salarie."Employment Date";
//                                 IntAnnéeAncienneté := NbrJour DIV 365;
//                                 RecSalaryLines.SetRange(Month, 11);
//                                 RecSalaryLines.SetRange(Year, AnnéePrime);
//                                 RecSalaryLines.SetRange(Employee, REC.Matricule);
//                                 if RecSalaryLines.FindFirst then;
//                                 if Salarie.Zone = 'A' then begin

//                                     MantantPrime := ((RecSalaryLines."Salaire Net sur fiche" * REC.Note) / 20) + (5 * IntAnnéeAncienneté);
//                                     REC."Montant Prime" := MantantPrime;
//                                     REC."Montant Ancienneté" := 5 * IntAnnéeAncienneté;
//                                     REC."Base Calcul" := RecSalaryLines."Salaire Net sur fiche";
//                                     REC.Ancienté := IntAnnéeAncienneté;
//                                 end
//                                 else
//                                     if Salarie.Zone = 'C' then begin
//                                         if Salarie."Salaire De Base Horaire" = 0 then begin
//                                             MantantPrime := ((RecSalaryLines."Real basis salary" * REC.Note) / 20);
//                                             REC."Montant Prime" := MantantPrime;
//                                             REC."Base Calcul" := RecSalaryLines."Real basis salary";

//                                         end
//                                         else begin
//                                             if EmploymentContract.Get(Salarie."No.") then;
//                                             if RegimeOfWork.Get(EmploymentContract."Regimes of work") then;
//                                             MantantPrime := ((RecSalaryLines."salaire de base grille" * RegimeOfWork."Work Hours per month" * REC.Note) / 20);
//                                             REC."Montant Prime" := MantantPrime;
//                                             REC."Base Calcul" := RecSalaryLines."salaire de base grille" * RegimeOfWork."Work Hours per month";

//                                         end;
//                                         REC.Ancienté := IntAnnéeAncienneté;

//                                     end;

//                             end;
//                         RecSalaryLines2.Reset();
//                         RecSalaryLines2.SetRange(Employee, REC.Matricule);
//                         RecSalaryLines2.SetRange(Year, AnnéePrime);
//                         if RecSalaryLines2.FindFirst() then
//                             repeat
//                                 if RecSalaryLines2.Month <> RecSalaryLines2.Month::Rappel then
//                                     NbreFiche := NbreFiche + 1;
//                             until RecSalaryLines2.Next = 0;
//                         REC."Nbre Fiche" := NbreFiche;
//                     end;
//                 }
//                 field("Nom Salariée"; REC."Nom Salariée")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(JO; REC.JO)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Min"; REC.Min)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Zone; REC.Zone)
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field(Affectation; REC.Affectation)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Description Affectation"; REC."Description Affectation")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Description Qualification"; REC."Description Qualification")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Note; REC.Note)
//                 {
//                     ApplicationArea = all;

//                     trigger OnValidate()
//                     begin
//                         if Salarie.Get(REC.Matricule) then begin
//                             //IF (Affectation='JO') OR (Affectation='ADX') THEN
//                             if REC.JO = true then begin
//                                 REC."Montant Prime Base calcul" := ((REC.Note / 20) * 39) * (REC."Base Calcul" / 26) * (REC."Nbre Jours Réelle" / 312);
//                                 REC.Modify;

//                             end
//                             else
//                                 if REC.Min = true then begin
//                                     REC."Montant Prime Base calcul" := ((REC."Base Calcul" * 10) / 26) * (REC."Nbre Mois Réelle" / 12);
//                                     REC.Modify;

//                                 end
//                                 else begin
//                                     if Salarie.Zone = 'A' then begin
//                                         MantantPrime := (((REC."Base Calcul" * REC.Note) / 20)) * (REC."Nbre Fiche" / 12) + (5 * REC.Ancienté);
//                                         REC."Montant Prime Base calcul" := ((((REC."Base Calcul" * REC.Note) / 20) / 312) * REC."Nbre Jours Réelle") + (5 * REC.Ancienté);
//                                         REC."Montant Prime" := MantantPrime;
//                                         REC."Montant Ancienneté" := 5 * REC.Ancienté;
//                                         REC.Modify;

//                                     end
//                                     else
//                                         if Salarie.Zone = 'C' then begin
//                                             MantantPrime := ((REC."Base Calcul" * REC.Note) / 20) * (REC."Nbre Fiche" / 12);
//                                             REC."Montant Prime" := MantantPrime;
//                                             REC."Montant Prime Base calcul" := (((REC."Base Calcul" * REC.Note) / 20) / 312) * REC."Nbre Jours Réelle";
//                                             REC.Modify;

//                                         end;
//                                 end;
//                             // Nbr Fiche < 12
//                             /*
//                             IF "Nbre Fiche"<12 THEN
//                               BEGIN
//                                  "Montant Prime Base calcul":=("Base Calcul"*(10/26))*("Nbre Jours Réelle"/312);
//                                  MODIFY;
//                               END;
//                              */
//                             // Nbr Fiche < 12

//                         end;


//                         // MH SORO 14-07-2020
//                         REC."Montant Prime Final" := REC."Montant Prime" + REC."Montant Congé 2";
//                         // MH SORO 14-07-2020

//                     end;
//                 }
//                 field("Nbre Fiche"; REC."Nbre Fiche")
//                 {
//                     ApplicationArea = all;

//                     trigger OnValidate()
//                     begin
//                         if Salarie.Get(REC.Matricule) then begin
//                             if Salarie.Zone = 'A' then begin
//                                 MantantPrime := (((REC."Base Calcul" * REC.Note) / 20)) * (REC."Nbre Fiche" / 12) + (5 * REC.Ancienté);

//                                 REC."Montant Prime" := MantantPrime;
//                                 REC."Montant Ancienneté" := 5 * REC.Ancienté;
//                                 REC.Modify;

//                             end
//                             else
//                                 if Salarie.Zone = 'C' then begin
//                                     MantantPrime := ((REC."Base Calcul" * REC.Note) / 20) * (REC."Nbre Fiche" / 12);
//                                     REC."Montant Prime" := MantantPrime;
//                                     REC.Modify;

//                                 end;
//                         end;
//                     end;
//                 }
//                 field("Salaire Net Actuel"; REC."Salaire Net Actuel")
//                 {
//                     ApplicationArea = all;
//                     DecimalPlaces = 3 : 3;
//                     Editable = false;
//                     Style = Unfavorable;
//                     StyleExpr = true;
//                 }
//                 field("Solde Congé"; REC."Solde Congé")
//                 {
//                     ApplicationArea = all;
//                     DecimalPlaces = 3 : 3;
//                     Editable = false;
//                     Style = Unfavorable;
//                     StyleExpr = true;
//                 }
//                 field(Temp; REC.Temp)
//                 {
//                     ApplicationArea = all;
//                     DecimalPlaces = 3 : 3;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Solde Congé au 31-12"; REC."Solde Congé au 31-12")
//                 {
//                     ApplicationArea = all;
//                     DecimalPlaces = 3 : 3;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Nbre Jours à retenir"; REC."Nbre Jours à retenir")
//                 {
//                     ApplicationArea = all;
//                     DecimalPlaces = 3 : 3;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Montant Congé 1"; REC."Montant Congé 1")
//                 {
//                     ApplicationArea = all;
//                     DecimalPlaces = 3 : 3;
//                     Editable = false;
//                     Style = Unfavorable;
//                     StyleExpr = true;
//                 }
//                 field("Montant Congé 2"; REC."Montant Congé 2")
//                 {
//                     ApplicationArea = all;
//                     DecimalPlaces = 3 : 3;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("montant Congé au 31-12"; REC."montant Congé au 31-12")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Montant Congé au 31-12';
//                     DecimalPlaces = 3 : 3;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Nbre Jours Base calcul"; REC."Nbre Jours Base calcul")
//                 {
//                     ApplicationArea = all;
//                     DecimalPlaces = 3 : 3;
//                     Editable = true;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("nbr jours tempo"; REC."nbr jours tempo")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Nbre Mois Base calcul"; REC."Nbre Mois Base calcul")
//                 {
//                     ApplicationArea = all;
//                     DecimalPlaces = 3 : 3;
//                     Editable = true;
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
//                     //DecimalPlaces = 3 : 3;
//                 }
//                 field("Base Calcul"; REC."Base Calcul")
//                 {
//                     ApplicationArea = all;
//                     DecimalPlaces = 3 : 3;
//                     Editable = true;
//                 }
//                 field("Montant Ancienneté"; REC."Montant Ancienneté")
//                 {
//                     ApplicationArea = all;
//                     DecimalPlaces = 3 : 3;
//                     Editable = true;
//                 }
//                 field("Montant Prime"; REC."Montant Prime")
//                 {
//                     ApplicationArea = all;
//                     DecimalPlaces = 3 : 3;
//                     Editable = false;
//                 }
//                 field("Montant Prime Final"; REC."Montant Prime Final")
//                 {
//                     ApplicationArea = all;
//                     DecimalPlaces = 3 : 3;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Montant Prime Base calcul"; REC."Montant Prime Base calcul")
//                 {
//                     ApplicationArea = all;
//                     DecimalPlaces = 3 : 3;
//                     Editable = true;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Avance sur Prime"; REC."Avance sur Prime")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Avance sur Prime 50 %';
//                     DecimalPlaces = 0 : 3;
//                     Editable = true;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field(Net; REC.Net)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Net à Payer';
//                     Style = Strong;
//                     StyleExpr = true;
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
//                 actionref("Imprimer Emargement Prime Avec Note1"; "Imprimer Emargement Prime Avec Note") { }
//                 actionref("Recap Prime1"; "Recap Prime") { }
//                 actionref(Valider1; Valider) { }
//                 actionref(Update1; Update) { }
//                 actionref("Mise a jour Affectation1"; "Mise a jour Affectation") { }
//                 actionref("Update Avance sur Prime1"; "Update Avance sur Prime") { }
//                 actionref("Update Nbr Jours1"; "Update Nbr Jours") { }
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
//                     var
//                         Wind: Dialog;
//                     begin

//                         if AnnéePrime = 0 then
//                             Error(Text001);
//                         if not Confirm(Text004) then exit;
//                         //FormPrepLotSal.GetParametres(Code,"Code Banque");
//                         //FormPrepLotSal.RUN;
//                         Wind.Open('Remplissage Prime En Cours :  #1############### \');
//                         Clear(RecSalaryLines);
//                         Clear(RecSalaryLines2);
//                         Clear(RecSalaryLines3);
//                         RecSalaryLines.SetRange(RecSalaryLines.Month, 9);
//                         RecSalaryLines.SetRange(RecSalaryLines.Year, AnnéePrime);
//                         if CdeMatricule <> '' then RecSalaryLines.SetRange(Employee, CdeMatricule);
//                         if CdeAffectation <> '' then RecSalaryLines.SetRange(Affectation, CdeAffectation);
//                         if RecSalaryLines.FindFirst then
//                             repeat

//                                 Salarie.Reset();
//                                 Salarie.SetRange(Salarie."No.", RecSalaryLines.Employee);
//                                 if Salarie.FindFirst then begin
//                                     Compteur += 1;
//                                     Wind.Update(1, Format(ROUND((Compteur / RecSalaryLines.Count) * 100, 1)) + ' %');
//                                     NbreFiche := 0;


//                                     //*********************Nbre Fiche
//                                     RecSalaryLines2.Reset();
//                                     RecSalaryLines2.SetRange(RecSalaryLines2.Employee, RecSalaryLines.Employee);
//                                     RecSalaryLines2.SetRange(RecSalaryLines2.Year, AnnéePrime);
//                                     if RecSalaryLines2.FindFirst() then
//                                         repeat
//                                             if RecSalaryLines2.Month <> RecSalaryLines2.Month::Rappel then
//                                                 NbreFiche := NbreFiche + 1;

//                                         until RecSalaryLines2.Next = 0;
//                                     if (Salarie.Blocked = false) then // AND (NbreFiche >= 12)  THEN

//                                     begin
//                                         ZoneSalarié := Salarie.Zone;
//                                         IntAnnéeAncienneté := 0;
//                                         MantantPrime := 0;
//                                         Clear(Notesprime);
//                                         if Format(Salarie."Employment Date") <> '' then begin
//                                             RecSalaryLines3.Reset;
//                                             RecSalaryLines3.SetRange(Month, 9);
//                                             RecSalaryLines3.SetRange(Employee, Salarie."No.");
//                                             RecSalaryLines3.SetRange(Year, AnnéePrime);
//                                             if RecSalaryLines3.FindFirst then DateRefAnciennete := Dmy2date(31, 12, RecSalaryLines3.Year);
//                                             IntMoisAncienneté := Managementofsalary.CalculerMoisAncienneté(RecSalaryLines3."No.", DateRefAnciennete);
//                                             NewDate := CalcDate(Format(((IntMoisAncienneté - IntAnnéeAncienneté * 12) - 1)) + 'M', Salarie."Employment Date");
//                                             NbrJour := DateRefAnciennete - Salarie."Employment Date";
//                                             IntAnnéeAncienneté := NbrJour DIV 365;
//                                         end;
//                                         if Salarie.Zone = 'A' then begin

//                                             MantantPrime := ((RecSalaryLines."Salaire Net sur fiche" * REC.Note) / 20) + (5 * IntAnnéeAncienneté);
//                                             Notesprime."Montant Prime" := MantantPrime;
//                                             Notesprime."Montant Ancienneté" := 5 * IntAnnéeAncienneté;
//                                             Notesprime."Base Calcul" := RecSalaryLines."Salaire Net sur fiche";
//                                             Notesprime.Ancienté := IntAnnéeAncienneté;
//                                         end
//                                         else
//                                             if Salarie.Zone = 'C' then begin
//                                                 if Salarie."Salaire De Base Horaire" = 0 then begin
//                                                     MantantPrime := ((RecSalaryLines."salaire de base grille" * REC.Note) / 20);
//                                                     Notesprime."Montant Prime" := MantantPrime;
//                                                     Notesprime."Base Calcul" := RecSalaryLines."salaire de base grille";

//                                                 end
//                                                 else begin
//                                                     if EmploymentContract.Get(Salarie."No.") then;
//                                                     if RegimeOfWork.Get(EmploymentContract."Regimes of work") then;
//                                                     MantantPrime := ((RecSalaryLines."salaire de base grille" * RegimeOfWork."Work Hours per month" * REC.Note) / 20);
//                                                     Notesprime."Montant Prime" := MantantPrime;
//                                                     Notesprime."Base Calcul" := RecSalaryLines."salaire de base grille" * RegimeOfWork."Work Hours per month";

//                                                 end;
//                                                 Notesprime.Ancienté := IntAnnéeAncienneté;

//                                             end;

//                                         Notesprime.Année := AnnéePrime;
//                                         Notesprime.Matricule := RecSalaryLines2.Employee;
//                                         Notesprime.Affectation := RecSalaryLines2.Affectation;
//                                         Notesprime.Qualification := RecSalaryLines2.Qualification;
//                                         if Affectat.Get(RecSalaryLines2.Affectation) then Notesprime."Description Affectation" := Affectat.Decription;
//                                         if Qualifica.Get(RecSalaryLines2.Qualification) then Notesprime."Description Qualification" := Qualifica.Description;
//                                         Notesprime."Nom Salariée" := RecSalaryLines2.Name;
//                                         Notesprime."Nbre Fiche" := NbreFiche;

//                                         //**********MH SORO 13-07-2020

//                                         RecEmployee.Reset;
//                                         if RecEmployee.Get(Salarie."No.") then begin
//                                             Notesprime."Salaire Net Actuel" := RecEmployee."Salaire Net Simulé";
//                                         end;

//                                         SoldeCongé := 0;
//                                         RecCongé.Reset;
//                                         RecCongé.SetRange("Employee No.", Salarie."No.");
//                                         if RecCongé.FindFirst then
//                                             repeat
//                                                 SoldeCongé := SoldeCongé + RecCongé."Quantity (Days)";
//                                             until RecCongé.Next = 0;
//                                         Notesprime."Solde Congé" := ROUND(SoldeCongé, 0.01, '=');

//                                         //**********MH SORO 13-07-2020



//                                         if not Notesprime.Insert then Notesprime.Modify;

//                                         UpdateJours(RecSalaryLines2.Employee)
//                                     end;

//                                 end;


//                             until RecSalaryLines.Next = 0;

//                         RecNotes.Reset;
//                         RecNotes.SetRange(Année, 2019);
//                         if RecNotes.FindFirst then
//                             repeat
//                                 RecNotes."Montant Congé 1" := (ROUND(RecNotes."Salaire Net Actuel" / 26)) * (RecNotes."Solde Congé");
//                                 RecNotes.Modify;

//                             until RecNotes.Next = 0;


//                         Wind.Close;
//                         CurrPage.Update;
//                         //MESSAGE(Text003);
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
//                 action("Imprimer Emargement Prime Avec Note")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Imprimer Emargement Prime Avec Note';

//                     trigger OnAction()
//                     begin
//                         if AnnéePrime = 0 then
//                             Error(Text001);

//                         Notesprime.SetRange(Notesprime.Année, AnnéePrime);
//                         Report.RunModal(50261, true, false, Notesprime);
//                     end;
//                 }
//                 action("Recap Prime")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Recap Prime';
//                     Visible = false;

//                     trigger OnAction()
//                     begin
//                         if AnnéePrime = 0 then
//                             Error(Text001);

//                         Notesprime.SetRange(Notesprime.Année, AnnéePrime);
//                         Report.RunModal(50262, true, false, Notesprime);
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
//                 action(Update)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Update';
//                     Visible = false;

//                     trigger OnAction()
//                     begin
//                         if AnnéePrime = 0 then Error(Text001);
//                         if not Confirm(Text007) then exit;
//                         Notesprime2.SetRange(Année, AnnéePrime);
//                         Notesprime2.SetRange(Statut, Notesprime2.Statut::Ouvert);
//                         if Notesprime2.FindFirst then
//                             repeat
//                                 if Salarie.Get(Notesprime2.Matricule) then begin
//                                     Notesprime2.Affectation := Salarie.Affectation;
//                                     Notesprime2.Modify;
//                                 end;
//                             until Notesprime2.Next = 0;
//                         Message(Text008);
//                     end;
//                 }
//                 action("Mise a jour Affectation")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Mise a jour Affectation';
//                     Visible = false;

//                     trigger OnAction()
//                     begin
//                         if not Confirm(Text007) then exit;
//                         Notesprime3.Copy(Rec);
//                         if Notesprime3.FindFirst then
//                             repeat
//                                 if Salarie.Get(Notesprime3.Matricule) then begin
//                                     Salarie.CalcFields("Deccription Affectation");
//                                     Notesprime3.Affectation := Salarie.Affectation;
//                                     Notesprime3."Description Affectation" := Salarie."Deccription Affectation";
//                                     Notesprime3.Modify;
//                                 end;
//                             until Notesprime3.Next = 0;
//                         Message(Text008);
//                     end;
//                 }
//                 action("Update Avance sur Prime")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Update Avance sur Prime';
//                     Visible = false;

//                     trigger OnAction()
//                     begin
//                         if AnnéePrime = 0 then
//                             Error(Text001);

//                         Notesprime4.Reset;
//                         Notesprime4.SetRange(Notesprime4.Année, AnnéePrime);
//                         if Notesprime4.FindFirst then
//                             repeat
//                                 Notesprime4."Avance sur Prime" := Notesprime4."Montant Prime Base calcul" / 2;
//                                 Notesprime4.Modify;
//                             until Notesprime4.Next = 0;
//                         Message(Text009);
//                     end;
//                 }
//                 action("Update Nbr Jours")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Update Nbr Jours';
//                     Visible = false;

//                     trigger OnAction()
//                     var
//                         Wind: Dialog;
//                     begin
//                         if AnnéePrime = 0 then
//                             Error(Text001);
//                         if not Confirm(Text004) then exit;
//                         //FormPrepLotSal.GetParametres(Code,"Code Banque");
//                         //FormPrepLotSal.RUN;
//                         Wind.Open('Remplissage Prime En Cours :  #1############### \');
//                         Clear(RecSalaryLines);
//                         Clear(RecSalaryLines2);
//                         Clear(RecSalaryLines3);
//                         RecSalaryLines.SetRange(RecSalaryLines.Month, 11);
//                         RecSalaryLines.SetRange(RecSalaryLines.Year, AnnéePrime);
//                         if CdeMatricule <> '' then RecSalaryLines.SetRange(Employee, CdeMatricule);
//                         if CdeAffectation <> '' then RecSalaryLines.SetRange(Affectation, CdeAffectation);
//                         if RecSalaryLines.FindFirst then
//                             repeat

//                                 Salarie.Reset();
//                                 Salarie.SetRange(Salarie."No.", RecSalaryLines.Employee);
//                                 if Salarie.FindFirst then begin
//                                     Compteur += 1;
//                                     Wind.Update(1, Format(ROUND((Compteur / RecSalaryLines.Count) * 100, 1)) + ' %');
//                                     NbreFiche := 0;
//                                     //*********************Nbre Fiche
//                                     RecSalaryLines2.Reset();
//                                     RecSalaryLines2.SetRange(RecSalaryLines2.Employee, RecSalaryLines.Employee);
//                                     RecSalaryLines2.SetRange(RecSalaryLines2.Year, AnnéePrime);
//                                     if RecSalaryLines2.FindFirst() then
//                                         repeat
//                                             if RecSalaryLines2.Month <> RecSalaryLines2.Month::Rappel then
//                                                 NbreFiche := NbreFiche + 1;

//                                         until RecSalaryLines2.Next = 0;
//                                     if (Salarie.Blocked = false) then // AND (NbreFiche >= 12)  THEN

//                                     begin
//                                         ZoneSalarié := Salarie.Zone;
//                                         IntAnnéeAncienneté := 0;
//                                         MantantPrime := 0;
//                                         Clear(Notesprime);
//                                         if Format(Salarie."Employment Date") <> '' then begin
//                                             RecSalaryLines3.Reset;
//                                             RecSalaryLines3.SetRange(Month, 11);
//                                             RecSalaryLines3.SetRange(Employee, Salarie."No.");
//                                             RecSalaryLines3.SetRange(Year, AnnéePrime);
//                                             if RecSalaryLines3.FindFirst then DateRefAnciennete := Dmy2date(31, 12, RecSalaryLines3.Year);
//                                             IntMoisAncienneté := Managementofsalary.CalculerMoisAncienneté(RecSalaryLines3."No.", DateRefAnciennete);
//                                             NewDate := CalcDate(Format(((IntMoisAncienneté - IntAnnéeAncienneté * 12) - 1)) + 'M', Salarie."Employment Date");
//                                             NbrJour := DateRefAnciennete - Salarie."Employment Date";
//                                             IntAnnéeAncienneté := NbrJour DIV 365;
//                                         end;
//                                         if Salarie.Zone = 'A' then begin

//                                             MantantPrime := ((RecSalaryLines."Salaire Net sur fiche" * REC.Note) / 20) + (5 * IntAnnéeAncienneté);
//                                             Notesprime."Montant Prime" := MantantPrime;
//                                             Notesprime."Montant Ancienneté" := 5 * IntAnnéeAncienneté;
//                                             Notesprime."Base Calcul" := RecSalaryLines."Salaire Net sur fiche";
//                                             Notesprime.Ancienté := IntAnnéeAncienneté;
//                                         end
//                                         else
//                                             if Salarie.Zone = 'C' then begin
//                                                 if Salarie."Salaire De Base Horaire" = 0 then begin
//                                                     MantantPrime := ((RecSalaryLines."salaire de base grille" * REC.Note) / 20);
//                                                     Notesprime."Montant Prime" := MantantPrime;
//                                                     Notesprime."Base Calcul" := RecSalaryLines."salaire de base grille";

//                                                 end
//                                                 else begin
//                                                     if EmploymentContract.Get(Salarie."No.") then;
//                                                     if RegimeOfWork.Get(EmploymentContract."Regimes of work") then;
//                                                     MantantPrime := ((RecSalaryLines."salaire de base grille" * RegimeOfWork."Work Hours per month" * REC.Note) / 20);
//                                                     Notesprime."Montant Prime" := MantantPrime;
//                                                     Notesprime."Base Calcul" := RecSalaryLines."salaire de base grille" * RegimeOfWork."Work Hours per month";

//                                                 end;
//                                                 Notesprime.Ancienté := IntAnnéeAncienneté;

//                                             end;

//                                         UpdateJours2(RecSalaryLines2.Employee)
//                                     end;

//                                 end;


//                             until RecSalaryLines.Next = 0;
//                         Wind.Close;
//                         CurrPage.Update;
//                         //MESSAGE(Text003);
//                     end;
//                 }
//             }
//         }
//     }

//     var
//         //FormPrepLotSal: page 52048995;
//         Text001: label 'Erreur, Vous devez saisir une Année !!!';
//         RecLigneLotPaie: Record "Ligne Lot Paie";
//         Text002: label 'il n a rien à validé';
//         RecSalaryLines: Record "Rec. Salary Lines";
//         Text003: label 'Insertion Terminée';
//         "AnnéePrime": Integer;
//         Notesprime: Record Notes;
//         Notesprime2: Record Notes;
//         Notesprime3: Record Notes;
//         Salarie: Record Employee;
//         NbreFiche: Integer;
//         RecSalaryLines2: Record "Rec. Salary Lines";
//         Text004: label 'Confirmer L''insertion ?';
//         Affectat: Record Section;
//         Qualifica: Record Qualification;
//         SubFormNotePrime: Page "SubForm Note Prime";
//         Text005: label 'Confimer la validation ?';
//         "IntMoisAncienneté": Integer;
//         "IntAnnéeAncienneté": Integer;
//         "Ancienneté": Text[50];
//         IntAncienneteJour: Integer;
//         DateRefAnciennete: Date;
//         RecSalaryLines3: Record "Rec. Salary Lines";
//         Managementofsalary: Codeunit "Management of salary";
//         NewDate: Date;
//         NbrJour: Integer;
//         MantantPrime: Decimal;
//         "ZoneSalarié": Text[30];
//         totalmantant: Decimal;
//         "NbreSalarié": Integer;
//         Compteur: Integer;
//         EmploymentContract: Record "Employment Contract";
//         RegimeOfWork: record "Regimes of work";
//         Text006: label 'Deja saisie !!!!!';
//         Text007: label 'Confirmer la mise a jour ?';
//         Text008: label 'Traitement Terminé Avec Succée';
//         Notesprime4: Record Notes;
//         Text009: label 'Mise a jour Terminé';
//         CdeMatricule: Code[5];
//         CdeAffectation: Code[20];
//         RecEmployee: Record Employee;
//         "RecCongé": Record "Employee's days off Entry";
//         "SoldeCongé": Decimal;
//         RecNotes: Record Notes;


//     procedure UpdateJours(ParaMatricule: Code[20])
//     var
//         solde: Decimal;
//         "Soldereporté": Decimal;
//         Reliquat: Decimal;
//         RecSalaryLines: Record "Rec. Salary Lines";
//         NbreJoursTravail: Decimal;
//         EmployeesdaysoffEntry: Record "Employee's days off Entry";
//         Congep: Decimal;
//         congeconsomme: Decimal;
//         congeconsommepaye: Decimal;
//         droitcongee: Decimal;
//         RecEmployeesdaysoffEntry: Record "Employee's days off Entry";
//         RecEmployeesdaysoffEntry2: Record "Employee's days off Entry";
//         "Heuressuperegistréesm": Record "Heures sup. eregistrées m";
//         "JoursFeriée": Decimal;
//         JourFiche: Decimal;
//         Annee: Integer;
//         JoursFicheTotal: Decimal;
//         MoisFiltre: Integer;
//         JoursFicheTotalRelle: Decimal;
//         i: Decimal;
//         j: Decimal;
//         k: Decimal;
//         l: Decimal;
//     begin
//         if Notesprime3.Get(AnnéePrime, ParaMatricule) then begin
//             NbreJoursTravail := 0;
//             JoursFicheTotalRelle := 0;
//             congeconsomme := 0;
//             droitcongee := 0;
//             Reliquat := 0;
//             Congep := 0;
//             JoursFeriée := 0;
//             JourFiche := 0;
//             JoursFicheTotal := 0;
//             MoisFiltre := 0;
//             repeat
//                 NbreJoursTravail := 0;
//                 congeconsomme := 0;
//                 JoursFeriée := 0;
//                 JourFiche := 0;
//                 RecSalaryLines.Reset;
//                 RecSalaryLines.SetRange(RecSalaryLines.Employee, Notesprime3.Matricule);
//                 RecSalaryLines.SetRange(RecSalaryLines.Year, AnnéePrime);
//                 RecSalaryLines.SetRange(RecSalaryLines.Month, MoisFiltre);
//                 if RecSalaryLines.FindFirst then begin
//                     NbreJoursTravail := RecSalaryLines."Paied days";
//                 end;
//                 i += NbreJoursTravail;
//                 RecEmployeesdaysoffEntry.Reset;
//                 RecEmployeesdaysoffEntry.SetRange(RecEmployeesdaysoffEntry."Employee No.", Notesprime3.Matricule);
//                 RecEmployeesdaysoffEntry.SetRange(RecEmployeesdaysoffEntry."Posting year", AnnéePrime);
//                 RecEmployeesdaysoffEntry.SetRange(RecEmployeesdaysoffEntry."Posting month", MoisFiltre);
//                 RecEmployeesdaysoffEntry.SetRange(RecEmployeesdaysoffEntry."Line type", 2);
//                 RecEmployeesdaysoffEntry.SetRange(RecEmployeesdaysoffEntry."Cause of Absence Code", 'CONG');
//                 if RecEmployeesdaysoffEntry.FindFirst then
//                     repeat
//                         congeconsomme := congeconsomme + RecEmployeesdaysoffEntry.Quantity;
//                     until RecEmployeesdaysoffEntry.Next = 0;

//                 RecEmployeesdaysoffEntry2.Reset;
//                 RecEmployeesdaysoffEntry2.SetRange(RecEmployeesdaysoffEntry2."Employee No.", Notesprime3.Matricule);
//                 RecEmployeesdaysoffEntry2.SetRange(RecEmployeesdaysoffEntry2."Posting year", AnnéePrime);
//                 RecEmployeesdaysoffEntry2.SetRange(RecEmployeesdaysoffEntry2."Posting month", MoisFiltre);
//                 RecEmployeesdaysoffEntry2.SetRange(RecEmployeesdaysoffEntry2."Line type", 1);
//                 if RecEmployeesdaysoffEntry2.FindFirst then droitcongee := RecEmployeesdaysoffEntry2.Quantity;

//                 Heuressuperegistréesm.Reset;
//                 Heuressuperegistréesm.SetRange(Heuressuperegistréesm."N° Salarié", Notesprime3.Matricule);
//                 Heuressuperegistréesm.SetRange(Heuressuperegistréesm."Année de paiement", AnnéePrime);
//                 Heuressuperegistréesm.SetRange(Heuressuperegistréesm."Mois de paiement", MoisFiltre);
//                 Heuressuperegistréesm.SetFilter("Type Jours", '%1|%2', 12, 14);
//                 if Heuressuperegistréesm.FindFirst then
//                     repeat
//                         JoursFeriée += Heuressuperegistréesm."Nombre Heures Supp";
//                     until Heuressuperegistréesm.Next = 0;
//                 if (NbreJoursTravail + JoursFeriée + congeconsomme) <= 26 then
//                     JourFiche := NbreJoursTravail + JoursFeriée + congeconsomme
//                 else
//                     if (NbreJoursTravail + JoursFeriée + congeconsomme) > 26 then JourFiche := 26;
//                 //message(' mois %1  Jours Fiche %2',MoisFiltre,JourFiche);
//                 JoursFicheTotalRelle += JourFiche;
//                 JoursFicheTotal += NbreJoursTravail;
//                 MoisFiltre := MoisFiltre + 1;
//             until MoisFiltre = 12;
//             Notesprime3."Nbre Jours Base calcul" := JoursFicheTotal;
//             Notesprime3."Nbre Mois Base calcul" := JoursFicheTotal / 26;
//             Notesprime3."Nbre Jours Réelle" := JoursFicheTotalRelle;
//             Notesprime3."Nbre Mois Réelle" := JoursFicheTotalRelle / 26;
//             Notesprime3.Modify;


//         end;
//     end;


//     procedure UpdateJours2(ParaMatricule: Code[20])
//     var
//         solde: Decimal;
//         "Soldereporté": Decimal;
//         Reliquat: Decimal;
//         RecSalaryLines: Record "Rec. Salary Lines";
//         NbreJoursTravail: Decimal;
//         EmployeesdaysoffEntry: Record "Employee's days off Entry";
//         Congep: Decimal;
//         congeconsomme: Decimal;
//         congeconsommepaye: Decimal;
//         droitcongee: Decimal;
//         RecEmployeesdaysoffEntry: Record "Employee's days off Entry";
//         RecEmployeesdaysoffEntry2: Record "Employee's days off Entry";
//         "Heuressuperegistréesm": Record "Heures sup. eregistrées m";
//         "JoursFeriée": Decimal;
//         JourFiche: Decimal;
//         Annee: Integer;
//         JoursFicheTotal: Decimal;
//         MoisFiltre: Integer;
//         JoursFicheTotalRelle: Decimal;
//         i: Decimal;
//         j: Decimal;
//         k: Decimal;
//         l: Decimal;
//     begin
//         if Notesprime3.Get(AnnéePrime, ParaMatricule) then begin
//             NbreJoursTravail := 0;
//             JoursFicheTotalRelle := 0;
//             congeconsomme := 0;
//             droitcongee := 0;
//             Reliquat := 0;
//             Congep := 0;
//             JoursFeriée := 0;
//             JourFiche := 0;
//             JoursFicheTotal := 0;
//             MoisFiltre := 0;
//             repeat
//                 NbreJoursTravail := 0;
//                 congeconsomme := 0;
//                 JoursFeriée := 0;
//                 JourFiche := 0;
//                 RecSalaryLines.Reset;
//                 RecSalaryLines.SetRange(RecSalaryLines.Employee, Notesprime3.Matricule);
//                 RecSalaryLines.SetRange(RecSalaryLines.Year, AnnéePrime);
//                 RecSalaryLines.SetRange(RecSalaryLines.Month, MoisFiltre);
//                 if RecSalaryLines.FindFirst then begin
//                     NbreJoursTravail := RecSalaryLines."Paied days";
//                 end;
//                 i += NbreJoursTravail;
//                 RecEmployeesdaysoffEntry.Reset;
//                 RecEmployeesdaysoffEntry.SetRange(RecEmployeesdaysoffEntry."Employee No.", Notesprime3.Matricule);
//                 RecEmployeesdaysoffEntry.SetRange(RecEmployeesdaysoffEntry."Posting year", AnnéePrime);
//                 RecEmployeesdaysoffEntry.SetRange(RecEmployeesdaysoffEntry."Posting month", MoisFiltre);
//                 RecEmployeesdaysoffEntry.SetRange(RecEmployeesdaysoffEntry."Line type", 2);
//                 RecEmployeesdaysoffEntry.SetRange(RecEmployeesdaysoffEntry."Cause of Absence Code", 'CONG');
//                 if RecEmployeesdaysoffEntry.FindFirst then
//                     repeat
//                         congeconsomme := congeconsomme + RecEmployeesdaysoffEntry.Quantity;
//                     until RecEmployeesdaysoffEntry.Next = 0;

//                 RecEmployeesdaysoffEntry2.Reset;
//                 RecEmployeesdaysoffEntry2.SetRange(RecEmployeesdaysoffEntry2."Employee No.", Notesprime3.Matricule);
//                 RecEmployeesdaysoffEntry2.SetRange(RecEmployeesdaysoffEntry2."Posting year", AnnéePrime);
//                 RecEmployeesdaysoffEntry2.SetRange(RecEmployeesdaysoffEntry2."Posting month", MoisFiltre);
//                 RecEmployeesdaysoffEntry2.SetRange(RecEmployeesdaysoffEntry2."Line type", 1);
//                 if RecEmployeesdaysoffEntry2.FindFirst then droitcongee := RecEmployeesdaysoffEntry2.Quantity;

//                 Heuressuperegistréesm.Reset;
//                 Heuressuperegistréesm.SetRange(Heuressuperegistréesm."N° Salarié", Notesprime3.Matricule);
//                 Heuressuperegistréesm.SetRange(Heuressuperegistréesm."Année de paiement", AnnéePrime);
//                 Heuressuperegistréesm.SetRange(Heuressuperegistréesm."Mois de paiement", MoisFiltre);
//                 Heuressuperegistréesm.SetFilter("Type Jours", '%1|%2', 12, 14);
//                 if Heuressuperegistréesm.FindFirst then
//                     repeat
//                         JoursFeriée += Heuressuperegistréesm."Nombre Heures Supp";
//                     until Heuressuperegistréesm.Next = 0;
//                 if (NbreJoursTravail + JoursFeriée + congeconsomme) <= 26 then
//                     JourFiche := NbreJoursTravail + JoursFeriée + congeconsomme
//                 else
//                     if (NbreJoursTravail + JoursFeriée + congeconsomme) > 26 then JourFiche := 26;
//                 //message(' mois %1  Jours Fiche %2',MoisFiltre,JourFiche);
//                 JoursFicheTotalRelle += JourFiche;
//                 JoursFicheTotal += NbreJoursTravail;
//                 MoisFiltre := MoisFiltre + 1;
//             until MoisFiltre = 12;
//             Notesprime3."nbr jours tempo" := JoursFicheTotalRelle;
//             Notesprime3.Modify;
//         end;
//     end;

//     local procedure Ann233ePrimeOnAfterValidate()
//     begin
//         CurrPage.Update;
//     end;

//     local procedure CdeMatriculeOnAfterValidate()
//     begin
//         CurrPage.Update;
//     end;

//     local procedure CdeAffectationOnAfterValidate()
//     begin
//         CurrPage.Update;
//     end;
// }

