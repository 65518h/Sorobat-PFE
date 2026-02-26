// page 74812 "Liste des Employee F"
// {//GL2024  ID dans Nav 2009 : "39004812"
//     Caption = 'Liste des Employee F';
//     Editable = true;
//     PageType = List;
//     SourceTable = Employee;
//     SourceTableView = SORTING("No.") WHERE(BR = FILTER('No'));
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 Editable = false;
//                 field("No."; REC."No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("First And Last Name"; REC."First Name")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Employment Date"; REC."Employment Date")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("date debut contrat"; REC."date debut contrat")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("Termination Date"; REC."Termination Date")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("Birth Date"; REC."Birth Date")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Blocked; REC.Blocked)
//                 {
//                 }
//                 field(Address; REC.Address)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Gender; Rec.Gender)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("N° CIN"; REC."N° Pièce D'identité")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Employee's Type Contrat"; REC."Employee's Type Contrat")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Mode de règlement"; REC."Mode de règlement")
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 // field(Chantier; REC.Chantier)
//                 // {
//                 //     ApplicationArea = all;
//                 // }
//                 // field(Affectation; REC.Affectation)
//                 // {
//                 //     ApplicationArea = all;
//                 // }
//                 // field("Deccription Affectation"; REC."Deccription Affectation")
//                 // {
//                 //     ApplicationArea = all;
//                 // }
//                 // field(Zone; REC.Zone)
//                 // {
//                 //     ApplicationArea = all;
//                 // }
//                 field(Catégorie; REC."Catégorie")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Catégorie';
//                     Visible = false;
//                 }
//                 // field(Qualification; REC.Qualification)
//                 // {
//                 //     ApplicationArea = all;
//                 // }
//                 // field("Description Qualification"; REC."Description Qualification")
//                 // {
//                 //     ApplicationArea = all;
//                 // }
//                 field("Domiciliation bancaire"; REC."Domiciliation bancaire")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Employee's type"; REC."Employee's type")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Status; REC.Status)
//                 {
//                     ApplicationArea = all;
//                 }
//                 // field("Date Creation"; REC."Date Creation")
//                 // {
//                 //     ApplicationArea = all;
//                 // }
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group("E&mployee")
//             {
//                 Caption = 'E&mployee';
//                 Visible = false;
//                 action("&Card")
//                 {
//                     ApplicationArea = all;
//                     Caption = '&Card';
//                     Image = EditLines;
//                     RunObject = Page "Employee List";
//                     RunPageLink = "No." = FIELD("No.");
//                     ShortCutKey = 'Ctrl+F7';
//                 }



//                 action("Co&mments")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Co&mments';
//                     Image = ViewComments;
//                     RunObject = Page "Human Resource Comment Sheet";
//                     RunPageLink = "Table Name" = CONST(Employee), "No." = FIELD("No.");
//                 }

//                 group(Dimensions)
//                 {
//                     Caption = 'Dimensions';
//                     action("Dimensions-Single")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Dimensions-Single';
//                         RunObject = Page "Default Dimensions";
//                         RunPageLink = "Table ID" = CONST(5200), "No." = FIELD("No.");
//                         ShortCutKey = 'Ctrl+F7';
//                     }

//                     action("Dimensions-&Multiple")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Dimensions-&Multiple';

//                         trigger OnAction()
//                         var
//                             Employee: Record Employee;
//                             DefaultDimMultiple: Page "Default Dimensions-Multiple";
//                         begin
//                             CurrPage.SETSELECTIONFILTER(Employee);
//                             DefaultDimMultiple.SetMultiEmployee(Employee);
//                             DefaultDimMultiple.RUNMODAL;
//                         end;
//                     }

//                 }

//                 action("&Picture")
//                 {
//                     ApplicationArea = all;
//                     Caption = '&Picture';
//                     RunObject = Page "Employee Picture";
//                     RunPageLink = "No." = FIELD("No.");
//                 }
//                 action("&Alternative Addresses")
//                 {
//                     ApplicationArea = all;
//                     Caption = '&Alternative Addresses';
//                     RunObject = Page "Alternative Address List";
//                     RunPageLink = "Employee No." = FIELD("No.");
//                 }
//                 action("&Relatives")
//                 {
//                     ApplicationArea = all;
//                     Caption = '&Relatives';
//                     RunObject = Page "Employee Relatives";
//                     RunPageLink = "Employee No." = FIELD("No.");
//                 }
//                 action("Mi&sc. Article Information")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Mi&sc. Article Information';
//                     RunObject = Page "Misc. Article Information";
//                     RunPageLink = "Employee No." = FIELD("No.");
//                 }
//                 action("Co&nfidential Information")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Co&nfidential Information';
//                     RunObject = Page "Confidential Information";
//                     RunPageLink = "Employee No." = FIELD("No.");
//                 }
//                 action("Q&ualifications")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Q&ualifications';
//                     RunObject = Page "Employee Qualifications";
//                     RunPageLink = "Employee No." = FIELD("No.");
//                 }
//                 action("A&bsences")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'A&bsences';
//                     RunObject = Page "Employee Absences";
//                     RunPageLink = "Employee No." = FIELD("No.");
//                 }


//                 action("Absences by Ca&tegories")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Absences by Ca&tegories';
//                     RunObject = Page "Empl. Absences by Categories";
//                     RunPageLink = "No." = FIELD("No."), "Employee No. Filter" = FIELD("No.");
//                 }
//                 action("Misc. Articles &Overview")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Misc. Articles &Overview';
//                     RunObject = Page "Misc. Articles Overview";
//                 }
//                 action("Con&fidential Info. Overview")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Con&fidential Info. Overview';
//                     RunObject = Page "Confidential Info. Overview";
//                 }
//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     begin
//         SalaireBrut := 0;
//         REC.CALCFIELDS("Total Indemnité Par Defaut");
//         IF REC."Salaire De Base Horaire" = 0 THEN
//             SalaireBrut := REC."Total Indemnité Par Defaut" + REC."Basis salary"
//         ELSE
//             SalaireBrut := REC."Total Indemnité Par Defaut" + REC."Salaire De Base Horaire";
//     end;

//     var
//         // GL2024 MemberOf: Record 2000000003;
//         Sal: Record Employee;
//         DecSBRUT: Decimal;
//         SalaireBrut: Decimal;
// }

