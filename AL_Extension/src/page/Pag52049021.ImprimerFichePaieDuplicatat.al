// page 52049021 "Imprimer Fiche Paie Duplicatat"
// {
//     //GL2024  ID dans Nav 2009 : "39001549"
//     Caption = 'Calculation lines';
//     Editable = false;
//     InsertAllowed = false;
//     PageType = List;
//     SourceTable = "Rec. Salary Lines";
//     SourceTableView = sorting(Chantier, Employee);
//     ApplicationArea = all;
//     UsageCategory = Lists;

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1180250000)
//             {
//                 ShowCaption = false;
//                 Editable = false;
//                 field("No."; Rec."No.")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Year; Rec.Year)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Month; Rec.Month)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Employee; Rec.Employee)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Name; Rec.Name)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Qualification; Rec.Qualification)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Affectation; Rec.Affectation)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Catégorie"; Rec.Catégorie)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Congé Pris"; Rec."Congé Pris")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Paied days"; Rec."Paied days")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Jours Deplacements"; Rec."Jours Deplacements")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("droit de congé du mois"; Rec."droit de congé du mois")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Droit de congé ancienneté"; Rec."Droit de congé ancienneté")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Worked hours"; Rec."Worked hours")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Global dimension 1"; Rec."Global dimension 1")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//                 field("Global dimension 2"; Rec."Global dimension 2")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//                 field(Note; Rec.Note)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Pourcentage; Rec.Pourcentage)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Mois travaillés"; Rec."Mois travaillés")
//                 {
//                     ApplicationArea = Basic;
//                     Enabled = true;
//                     Visible = false;
//                 }
//                 field("Employee Posting Group"; Rec."Employee Posting Group")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//                 field("Regime of work"; Rec."Regime of work")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//                 field("Emplymt. Contract Code"; Rec."Emplymt. Contract Code")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//                 field("Bank Account Code"; Rec."Bank Account Code")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//                 field(Absences; Rec.Absences)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Adjustment of absences"; Rec."Adjustment of absences")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Days off"; Rec."Days off")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Days off remaining"; Rec."Days off remaining")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//                 field("Days off balacement"; Rec."Days off balacement")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Assiduity (Paid days)"; Rec."Assiduity (Paid days)")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Assiduity (Worked days)"; Rec."Assiduity (Worked days)")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Control1180250013; Rec."Worked hours")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Basis hours"; Rec."Basis hours")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Basis salary"; Rec."Basis salary")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Real basis salary"; Rec."Real basis salary")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Taxable indemnities"; Rec."Taxable indemnities")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Supp. hours"; Rec."Supp. hours")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Gross Salary"; Rec."Gross Salary")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(CNSS; Rec.CNSS)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Taxable salary"; Rec."Taxable salary")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Deduction Family chief"; Rec."Deduction Family chief")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//                 field("Deduction Loaded child"; Rec."Deduction Loaded child")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//                 field("Deduction Prof. expenses"; Rec."Deduction Prof. expenses")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//                 field("Real taxable"; Rec."Real taxable")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//                 field("Total taxable rec."; Rec."Total taxable rec.")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//                 field("Rec. payments"; Rec."Rec. payments")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//                 field("Real taxable (Year)"; Rec."Real taxable (Year)")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//                 field("Taxe (Year)"; Rec."Taxe (Year)")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Total taxes rec."; Rec."Total taxes rec.")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Taxe (Month)"; Rec."Taxe (Month)")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Non Taxable indemnities"; Rec."Non Taxable indemnities")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Taxable Soc. Contrib."; Rec."Taxable Soc. Contrib.")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Net salary"; Rec."Net salary")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Loans; Rec.Loans)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Advances; Rec.Advances)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Net salary cashed"; Rec."Net salary cashed")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Chantier; Rec.Chantier)
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//             group("Rec. Salary line")
//             {
//                 Caption = 'Rec. Salary line';
//                 Editable = false;
//                 field("Employee + ' - ' + Name"; Rec.Employee + ' - ' + Rec.Name)
//                 {
//                     ApplicationArea = Basic;
//                     ShowCaption = false;
//                     Style = StandardAccent;
//                 }
//                 field(Control1180250082; Rec."Gross Salary")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Control1000000002; Rec.CNSS)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Control1180250084; Rec."Taxable salary")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Control1180250086; Rec."Taxe (Month)")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Control1180250088; Rec."Net salary")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Control1180250090; Rec."Net salary cashed")
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             action(Imprimer)
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Imprimer';
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 begin
//                     if Rec."Duplicata Imprimer" then Error(Text001);
//                     SalaryRecLine.SetRange("No.", Rec."No.");
//                     SalaryRecLine.SetRange(Employee, Rec.Employee);
//                     Report.Run(50087, true, true, SalaryRecLine);
//                     Rec."Duplicata Imprimer" := true;
//                     Rec.Modify;
//                 end;
//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     begin
//         if UserSetup.Get(UpperCase(UserId)) then;
//         if UserSetup."Affaire Par Defaut" <> '' then Filtre := UserSetup."Affaire Par Defaut";
//         if Filtre <> '' then Rec.SetFilter(Chantier, 'AEROP-JERBA-MATMATA');
//         //SETRANGE(Year,DATE2DMY(WORKDATE,3));
//         //SETRANGE(Month,DATE2DMY(WORKDATE,2)-2);
//     end;

//     trigger OnOpenPage()
//     begin
//         //IF SalaryRecLine.FINDLAST THEN Mois:=SalaryRecLine.Month;
//         if UserSetup.Get(UpperCase(UserId)) then;
//         if UserSetup."Affaire Par Defaut" <> '' then Filtre := UserSetup."Affaire Par Defaut";
//         if Filtre <> '' then Rec.SetFilter(Chantier, 'AEROP-JERBA-MATMATA');
//         //SETRANGE(Year,DATE2DMY(WORKDATE,3));
//         //SETRANGE(Month,DATE2DMY(WORKDATE,2)-2);
//     end;

//     var
//         SalaryRecLine: Record "Rec. Salary Lines";
//         UserSetup: Record "User Setup";
//         Filtre: Text[100];
//         Mois: Integer;
//         Text001: label 'Duplicata Déja Imprimer Pour Cet Employer';


//     procedure ChangerModePaiement(var Mode: Option Virement,"Espèse")
//     var
//         compteclt: Record "Employee Bank Account";
//         clt: Record Employee;
//         T1: Record "Rec. Salary Lines";
//     begin
//         T1.Reset;
//         T1.SetFilter("No.", Rec."No.");
//         CurrPage.SetSelectionFilter(T1);
//         if T1.Find('-') then
//             repeat
//                 Clear(clt);
//                 clt.Get(T1.Employee);
//                 case Mode of
//                     0:
//                         begin
//                             Clear(compteclt);
//                             if compteclt.Get(T1.Employee, clt."Default Bank Account Code") then begin
//                                 T1."Bank Account Code" := clt."Default Bank Account Code";
//                                 T1."Num Compte" := compteclt."Bank Account No.";
//                                 T1.Modify;
//                             end;
//                         end;
//                     1:
//                         begin
//                             T1."Bank Account Code" := '';
//                             T1."Num Compte" := '';
//                             T1.Modify;
//                         end;
//                 end;
//             until T1.Next = 0;
//     end;
// }

