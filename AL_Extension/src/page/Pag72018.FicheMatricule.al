//GL3900 
// page 72018 "Fiche Matricule"
// {
//     //GL2024  ID dans Nav 2009 : "39002018"
//     Caption = 'Register card';
//     PageType = Card;
//     SourceTable = Matricule;
//     ApplicationArea = all;
//     UsageCategory = Administration;
//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';
//                 field("code matricule"; rec."code matricule")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(designation; rec.designation)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_calender_constr; rec.cd_calender_constr)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(comment; rec.comment)
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field(cd_pattern; rec.cd_pattern)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(typ_criticality; rec.typ_criticality)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Immo No."; rec."Immo No.")
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//             group(Caracteristics)
//             {
//                 Caption = 'Caracteristics';
//                 part("Caractéristiques matricule"; "Caractéristiques matricule")
//                 {
//                     ApplicationArea = all;
//                     SubPageLink = cd_register = FIELD("code matricule");
//                 }
//             }
//             group(Preventive)
//             {
//                 Caption = 'Preventive';
//                 part("Liste OTP"; "Liste OTP")
//                 {
//                     ApplicationArea = all;
//                     SubPageLink = cd_matricule = FIELD("code matricule");
//                 }
//             }
//             group(Measure)
//             {
//                 Caption = 'Measure';
//                 part("Liste mesure équipement"; "Liste mesure équipement")
//                 {
//                     ApplicationArea = all;
//                     SubPageLink = cd_register = FIELD("code matricule");
//                 }
//             }
//             group("Follow-up")
//             {
//                 Caption = 'Follow-up';
//                 part("Liste bt_suivi"; "Liste bt_suivi")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Enabled = true;
//                     SubPageLink = cd_matricule = FIELD("code matricule");
//                 }
//             }
//             group(Mouvement)
//             {
//                 Caption = 'Mouvement';
//                 part("Liste shelter/matricule"; "Liste shelter/matricule")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     SubPageLink = cd_register_link = FIELD("code matricule");
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group(Register)
//             {
//                 Caption = 'Register';
//                 separator(separator300)
//                 {
//                 }
//                 action(Comment)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Comment';
//                     RunObject = Page "Comment Sheet gmao";
//                     RunPageLink = "Table Name" = CONST(matricule),
//                                   "No." = FIELD("code matricule");
//                 }
//                 action(Model)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Model';
//                     RunObject = Page "Fiche Modèle";
//                     RunPageLink = cd_pattern = FIELD(cd_pattern);
//                 }
//                 action("Fixed Asset")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Fixed Asset';
//                     RunObject = Page "Fixed Asset List";
//                     RunPageLink = "No." = FIELD("Immo No.");
//                 }
//                 separator(separator100)
//                 {
//                 }
//                 action(Picture)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Picture';
//                     RunObject = Page "Matricule Picture";
//                     RunPageLink = "code matricule" = FIELD("code matricule");
//                 }
//                 action("Print card")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Print card';

//                     trigger OnAction()
//                     begin
//                         t.RESET;
//                         t.SETFILTER(t."code matricule", rec."code matricule");
//                         IF t.FIND('-') THEN
//                             REPORT.RUNMODAL(90007, TRUE, TRUE, t);
//                     end;
//                 }
//             }
//         }
//     }

//     var
//         NoseriesMgt: Codeunit NoSeriesManagement;
//         gmaomgt: Record "Gmao Setup";
//         t: Record Matricule;
// }

