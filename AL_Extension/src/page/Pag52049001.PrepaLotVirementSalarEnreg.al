// page 52049001 "Prepa Lot Virement Salar Enreg"
// {
//     //GL2024  ID dans Nav 2009 : "39001529"
//     PageType = List;
//     SourceTable = "Rec. Salary Lines";
//     SourceTableView = sorting(Employee, "year of Calculate", Month, "Type Prime")
//                       where(RIB = filter(<> ''),
//                             "Code Mode Réglement" = filter(Virement),
//                             "Lot Virement Salaire" = filter(''));
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     Caption = 'Prepa Lot Virement Salar Enreg';
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1000000000)
//             {
//                 ShowCaption = false;
//                 field("No."; Rec."No.")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Inserer Lot Virement"; Rec."Inserer Lot Virement")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Employee; Rec.Employee)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field(Name; Rec.Name)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Code Mode Réglement"; Rec."Code Mode Réglement")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field(Month; Rec.Month)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field(Year; Rec.Year)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Net salary cashed"; Rec."Net salary cashed")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field(RIB; Rec.RIB)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field(Affectation; Rec.Affectation)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field(Qualification; Rec.Qualification)
//                 {
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
//                             //GL2024  
//                             RecLigneLotPaie.Validate("Montant Net", Rec."Net salary cashed");
//                             //GL2024  
//                             //GL2024   RecLigneLotPaie."Montant Net" := Rec."Net salary cashed";
//                             RecLigneLotPaie.Status := RecLigneLotPaie.Status::"En Cours";
//                             RecLigneLotPaie."Num Paie" := Rec."No.";
//                             RecLigneLotPaie."Code Affectation" := Rec.Affectation;
//                             RecLigneLotPaie.Type := RecLigneLotPaie.Type::Bordereau;
//                             RecLigneLotPaie.Insert;
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


//     procedure GetParametres(ParmCodeLot: Code[20]; ParmCodeAffectation: Code[20])
//     begin
//         CodeLotVirmSalaire := ParmCodeLot;
//         //CodeBqVirmSalaire := ParmCodeBq;
//         CodeAffectation := ParmCodeAffectation;
//     end;
// }

