//GL3900 
// Page 72032 "Caractéristiques matricule"
// {
//     //GL2024  ID dans Nav 2009 : "39002032"
//     PageType = ListPart;
//     SourceTable = "Caracteristiques matricule";

//     Caption = 'Caractéristiques matricule';
//     ApplicationArea = All;
//     layout
//     {
//         area(content)
//         {
//             field(tem; tem)
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Thème';

//                 //GL2024   TableRelation = Table50612.Field1;

//                 trigger OnLookup(var Text: Text): Boolean
//                 begin

//                     t.Reset;
//                     if PAGE.RunModal(90011, t) = Action::LookupOK then begin
//                         tem := t.Organe;
//                         Rec.SetRange(theme, t.cd_theme);
//                         Rec.Find('-');
//                     end;
//                 end;
//             }
//             repeater(Control1000000000)
//             {
//                 ShowCaption = false;
//                 field("Carctéristique"; Rec.Carctéristique)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(parametre; Rec.parametre)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(txt_caract_value; Rec.txt_caract_value)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(dt_caract_value; Rec.dt_caract_value)
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     trigger OnOpenPage()
//     begin
//         tem := all;
//     end;

//     var
//         tem: Text[30];
//         t: Record Organe;
//         all: label 'All themes';
// }

