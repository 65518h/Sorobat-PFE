// page 52049004 "Liste Fin Contrat"
// {
//     //GL2024  ID dans Nav 2009 : "39001532"
//     PageType = List;
//     SourceTable = Employee;
//     SourceTableView = sorting("No.")
//                       where(Blocked = filter(false));

//     ApplicationArea = all;
//     UsageCategory = Lists;
//     Caption = 'Liste Fin Contrat';
//     layout
//     {
//         area(content)
//         {
//             field(FilterDate; FilterDate)
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Filter Date';

//                 trigger OnValidate()
//                 begin
//                     FilterDateOnAfterValidate;
//                 end;
//             }
//             repeater(Control1000000000)
//             {
//                 Editable = false;
//                 field("No."; Rec."No.")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("First And Last Name"; Rec."First Name")
//                 {
//                     ApplicationArea = Basic;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Termination Date"; Rec."Termination Date")
//                 {
//                     ApplicationArea = Basic;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Employee's Type Contrat"; Rec."Employee's Type Contrat")
//                 {
//                     ApplicationArea = Basic;
//                     Caption ='Type Contrat Salariés';
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Social Security No."; Rec."Social Security No.")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Employment Date"; Rec."Employment Date")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Status; Rec.Status)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("N° CIN"; Rec."N° CIN")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Affectation; Rec.Affectation)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Deccription Affectation"; Rec."Deccription Affectation")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Qualification; Rec.Qualification)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Description Qualification"; Rec."Description Qualification")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Zone; Rec.Zone)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(RIB; Rec.RIB)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Mode de règlement"; Rec."Mode de règlement")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("date debut contrat"; Rec."date debut contrat")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Employee's type"; Rec."Employee's type")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Type salariés';
//                 }
//                 field("Payment Method Code"; Rec."Payment Method Code")
//                 {
//                     ApplicationArea = Basic;
//                     Caption ='Code Methode Paiement';
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     var
//         FilterDate: Date;

//     local procedure FilterDateOnAfterValidate()
//     begin
//         if FilterDate <> 0D then begin
//             Rec.SetFilter("Termination Date", '<= %1', FilterDate);
//             CurrPage.Update;
//         end;
//     end;
// }

