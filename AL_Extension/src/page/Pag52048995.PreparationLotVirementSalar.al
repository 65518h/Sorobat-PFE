// page 52048995 "Preparation Lot Virement Salar"
// {
//     //GL2024  ID dans Nav 2009 : "39001523"
//     PageType = List;
//     SourceTable = "Salary Lines";
//     SourceTableView = sorting(Employee, "year of Calculate", Month, "Type Prime")
//                       where("No." = filter(<> 'SIMULATION'),
//                             RIB = filter(<> ''),
//                             "Code Mode Réglement" = filter(Virement),
//                             "Lot Virement Salaire" = filter(''));

//     ApplicationArea = all;
//     UsageCategory = Lists;
//     Caption = 'Preparation Lot Virement Salar';

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1000000000)
//             {
//                 ShowCaption = false;
//                 field("No."; Rec."No.")
//                 {
//                     Caption = 'No.';
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Inserer Lot Virement"; Rec."Inserer Lot Virement")
//                 {
//                     Caption = 'Inserer Lot Virement';
//                     ApplicationArea = Basic;
//                 }
//                 field(Employee; Rec.Employee)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                     Caption = 'Salarié';
//                 }
//                 field(Name; Rec.Name)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                     Caption = 'Nom';
//                 }
//                 field("Code Mode Réglement"; Rec."Code Mode Réglement")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Code Mode Réglement';
//                     Editable = false;
//                 }
//                 field(Month; Rec.Month)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                     Caption = 'Mois';
//                 }
//                 field(Year; Rec.Year)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                     Caption = 'Année';
//                 }
//                 field("Net salary cashed"; Rec."Net salary cashed")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                     Caption = 'Salaire net Perçu';
//                 }
//                 field(RIB; Rec.RIB)
//                 {
//                     Caption = 'RIB';
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field(Affectation; Rec.Affectation)
//                 {
//                     Caption = 'Salaire net Perçu';
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field(Qualification; Rec.Qualification)
//                 {
//                     Caption = 'Qualification';
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             action("Coucher la Selection")
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Coucher la Selection';
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 begin
//                     RecSalaryLinesSelect.Reset;
//                     CurrPage.SetSelectionFilter(RecSalaryLinesSelect);
//                     if RecSalaryLinesSelect.FindFirst then
//                         repeat
//                             RecSalaryLinesSelect."Inserer Lot Virement" := true;
//                             RecSalaryLinesSelect.Modify;
//                         until RecSalaryLinesSelect.Next = 0;
//                 end;
//             }
//             action(Valider)
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Valider';
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 begin
//                     if not Confirm(Text001) then exit;
//                     RecLigneLotPaie.Reset;
//                     RecLigneLotPaie.SetRange(Code, CodeLotVirmSalaire);
//                     //RecLigneLotPaie.SETRANGE("Code Banque",CodeBqVirmSalaire);
//                     Rec.SetRange("Inserer Lot Virement", true);
//                     if Rec.FindFirst then
//                         repeat
//                             RecLigneLotPaie.Code := CodeLotVirmSalaire;
//                             //RecLigneLotPaie."Code Banque" := CodeBqVirmSalaire;
//                             RecLigneLotPaie.Validate("Matricule Salarié", Rec.Employee);
//                             RecLigneLotPaie."Montant Net" := Rec."Net salary cashed";
//                             RecLigneLotPaie.Status := RecLigneLotPaie.Status::"En Cours";
//                             RecLigneLotPaie."Num Paie" := Rec."No.";
//                             RecLigneLotPaie."Code Affectation" := Rec.Affectation;
//                             RecLigneLotPaie.Type := RecLigneLotPaie.Type::Bordereau;
//                             if not RecLigneLotPaie.Modify then RecLigneLotPaie.Insert;
//                             Rec."Lot Virement Salaire" := CodeLotVirmSalaire;
//                             //"Code Banque Virement" := CodeBqVirmSalaire;
//                             Rec."Inserer Lot Virement" := false;
//                             Rec.Modify;
//                         until Rec.Next = 0;
//                     CurrPage.Close;
//                 end;
//             }
//         }
//     }

//     trigger OnClosePage()
//     begin
//         RecSalaryLines.SetRange("No.", Rec."No.");
//         RecSalaryLines.SetRange("Inserer Lot Virement", true);
//         if RecSalaryLines.FindFirst then
//             repeat
//                 RecSalaryLines."Lot Virement Salaire" := CodeLotVirmSalaire;
//                 //RecSalaryLines."Code Banque Virement" := CodeBqVirmSalaire;
//                 RecSalaryLines."Inserer Lot Virement" := false;
//                 RecSalaryLines.Modify;
//             until RecSalaryLines.Next = 0;
//     end;

//     trigger OnOpenPage()
//     begin
//         GetParametres(CodeLotVirmSalaire, CodeAffectation);
//         Rec.FilterGroup(2);
//         Rec.SetRange(Affectation, CodeAffectation);
//         Rec.SetFilter("Lot Virement Salaire", '%1', ' ');
//         Rec.FilterGroup(0);
//     end;

//     var
//         CodeLotVirmSalaire: Code[20];
//         CodeAffectation: Code[20];
//         RecLigneLotPaie: Record "Ligne Lot Paie";
//         RecSalaryLines: Record "Salary Lines";
//         Text001: label 'Confirmer Le Virement ?';
//         RecSalaryLinesSelect: Record "Salary Lines";


//     procedure GetParametres(ParmCodeLot: Code[20]; ParmCodeAffectation: Code[20])
//     begin
//         CodeLotVirmSalaire := ParmCodeLot;
//         //CodeBqVirmSalaire := ParmCodeBq;
//         CodeAffectation := ParmCodeAffectation;
//     end;
// }

