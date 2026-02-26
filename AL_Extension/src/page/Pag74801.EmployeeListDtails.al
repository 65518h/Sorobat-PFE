// page 74801 "Employee List Détails"
// {//GL2024  ID dans Nav 2009 : "39004801"
//     Caption = 'Employee List Détails';
//     Editable = true;
//     PageType = List;
//     SourceTable = Employee;
//     ApplicationArea = All;
//     UsageCategory = Lists;
//     DeleteAllowed = false;
//     InsertAllowed = false;
//     ModifyAllowed = false;

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 Editable = false;
//                 field("No."; REC."No.")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("First And Last Name"; REC."First Name")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Diplôme Sal"; REC."Diplôme Sal")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Employment Date"; REC."Employment Date")
//                 {
//                     ApplicationArea = All;
//                     Visible = false;
//                 }
//                 field("date debut contrat"; REC."date debut contrat")
//                 {
//                     ApplicationArea = All;
//                     Visible = false;
//                 }
//                 field("Termination Date"; REC."Termination Date")
//                 {
//                     ApplicationArea = All;
//                     Visible = false;
//                 }
//                 field("Salaire Net Simulé"; REC."Salaire Net Simulé")
//                 {
//                     ApplicationArea = All;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                     Visible = false;
//                 }
//                 field("Birth Date"; REC."Birth Date")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Exclu De Dec Trim CNSS"; REC."Exclu De Dec Trim CNSS")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(Blocked; REC.Blocked)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(BR; REC.BR)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(Address; REC.Address)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(Sex; REC.Gender)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("N° CIN"; REC."N° CIN")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Social Security No."; REC."Social Security No.")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Employee's Type Contrat"; REC."Employee's Type Contrat")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Mode de règlement"; REC."Mode de règlement")
//                 {
//                     ApplicationArea = All;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 field(RIB; REC.RIB)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Banque Salarié"; REC."Banque Salarié")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(Chantier; REC.Chantier)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(Affectation; REC.Affectation)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Deccription Affectation"; REC."Deccription Affectation")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(Zone; REC.Zone)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(Collège; REC.Collège)
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Catégorie';
//                     Visible = false;
//                 }
//                 field(Qualification; REC.Qualification)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Description Qualification"; REC."Description Qualification")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Familly chief"; REC."Familly chief")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Deduction Loaded child"; REC."Deduction Loaded child")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Domiciliation bancaire"; REC."Domiciliation bancaire")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Employee's type"; REC."Employee's type")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Basis salary"; REC."Basis salary")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Salaire de base/ Taux Horaire';
//                     DecimalPlaces = 3 : 3;
//                     Style = Unfavorable;
//                     StyleExpr = TRUE;
//                     Visible = false;
//                 }
//                 field("Salaire De Base Horaire"; REC."Salaire De Base Horaire")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Base Horaire';
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                     Visible = false;
//                 }
//                 field("Total Indemnité Par Defaut"; REC."Total Indemnité Par Defaut")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Indemnités';
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                     Visible = false;
//                 }
//                 field(SalaireBrut; SalaireBrut)
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Salaire Brut';
//                     // DecimalPlaces = 3 : 3;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                     Visible = false;
//                 }
//                 field("Nombre Enfant"; REC."Nombre Enfant")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Impot Simule"; REC."Impot Simule")
//                 {
//                     ApplicationArea = All;
//                     Style = Unfavorable;
//                     StyleExpr = TRUE;
//                     Visible = false;
//                 }
//                 field("Impot + 5000"; REC."Impot + 5000")
//                 {
//                     ApplicationArea = All;
//                     Visible = false;
//                 }
//                 field("Advances balance"; REC."Advances balance")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Loans balance"; REC."Loans balance")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(Status; REC.Status)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Days off -"; REC."Days off -")
//                 {
//                     ApplicationArea = All;
//                     Visible = false;
//                 }
//                 field("Days off +"; REC."Days off +")
//                 {
//                     ApplicationArea = All;
//                     Visible = false;
//                 }
//                 field("Days off ="; REC."Days off =")
//                 {
//                     ApplicationArea = All;
//                     Visible = false;
//                 }
//                 field("Date Creation"; REC."Date Creation")
//                 {
//                     ApplicationArea = All;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group("E&mployee")
//             {
//                 Visible = false;
//                 Caption = 'Salarié';

//                 action("&Card")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Fiche';
//                     Image = EditLines;
//                     RunObject = Page "Employee List";
//                     RunPageLink = "No." = FIELD("No.");
//                     ShortCutKey = 'Ctrl+F7';
//                 }

//                 action("Co&mments")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Commentaires';
//                     Image = ViewComments;
//                     RunObject = Page "Human Resource Comment Sheet";
//                     RunPageLink = "Table Name" = CONST(Employee), "No." = FIELD("No.");
//                 }

//                 group(Dimensions)
//                 {
//                     Caption = 'Axes Analytiques';
//                     action("Dimensions-Single")
//                     {
//                         ApplicationArea = All;
//                         Caption = 'Affectations-Simple';
//                         RunObject = Page "Default Dimensions";
//                         //    RunPageLink = "Table ID" = CONST('5200'), "No." = FIELD("No.");
//                         ShortCutKey = 'Ctrl+F7';
//                     }
//                     action("Dimensions-&Multiple")
//                     {
//                         ApplicationArea = All;
//                         Caption = 'Affectations-Multiple';

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
//                     ApplicationArea = All;
//                     Caption = 'Image';
//                     RunObject = Page "Employee Picture";
//                     RunPageLink = "No." = FIELD("No.");
//                 }
//                 action("&Alternative Addresses")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Adresses secondaires';
//                     RunObject = Page "Alternative Address List";
//                     RunPageLink = "Employee No." = FIELD("No.");
//                 }
//                 action("&Relatives")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Liens de parenté';
//                     RunObject = Page "Employee Relatives";
//                     RunPageLink = "Employee No." = FIELD("No.");
//                 }
//                 action("Mi&sc. Article Information")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Informations &objets confiés';
//                     RunObject = Page "Misc. Article Information";
//                     RunPageLink = "Employee No." = FIELD("No.");
//                 }
//                 action("Co&nfidential Information")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Informations &confidentielles';
//                     RunObject = Page "Confidential Information";
//                     RunPageLink = "Employee No." = FIELD("No.");
//                 }
//                 action("Q&ualifications")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Qualifications';
//                     RunObject = Page "Employee Qualifications";
//                     RunPageLink = "Employee No." = FIELD("No.");
//                 }
//                 action("A&bsences")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'A&bsences';
//                     RunObject = Page "Employee Absences";
//                     RunPageLink = "Employee No." = FIELD("No.");
//                 }

//                 action("Absences by Ca&tegories")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Abs&ences par catégorie';
//                     RunObject = Page "Empl. Absences by Categories";
//                     RunPageLink = "No." = FIELD("No."), "Employee No. Filter" = FIELD("No.");
//                 }
//                 action("Misc. Articles &Overview")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Détail objets confiés';
//                     RunObject = Page "Misc. Articles Overview";
//                 }
//                 action("Con&fidential Info. Overview")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Détail i&nfo. confidentielles';
//                     RunObject = Page "Confidential Info. Overview";
//                 }
//             }

//         }
//         area(Promoted)
//         {
//             group("E&mployee1")
//             {
//                 Visible = false;
//                 Caption = 'Salarié';
//                 actionref("&Card1"; "&Card") { }
//                 actionref("Co&mments1"; "Co&mments") { }
//                 group(Dimensions1)
//                 {
//                     Caption = 'Axes Analytiques';
//                     actionref("Dimensions-Single1"; "Dimensions-Single") { }
//                     actionref("Dimensions-&Multiple1"; "Dimensions-&Multiple") { }
//                 }
//                 actionref("&Picture1"; "&Picture") { }
//                 actionref("&Alternative Addresses1"; "&Alternative Addresses") { }
//                 actionref("&Relatives1"; "&Relatives") { }
//                 actionref("Co&nfidential Information1"; "Co&nfidential Information") { }
//                 actionref("Q&ualifications1"; "Q&ualifications") { }

//                 actionref("A&bsences1"; "A&bsences") { }
//                 actionref("Absences by Ca&tegories1"; "Absences by Ca&tegories") { }
//                 actionref("Misc. Articles &Overview1"; "Misc. Articles &Overview") { }
//                 actionref("Con&fidential Info. Overview1"; "Con&fidential Info. Overview") { }

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
//         //MemberOf: Record 2000000003;
//         Sal: Record Employee;
//         DecSBRUT: Decimal;
//         SalaireBrut: Decimal;
// }

