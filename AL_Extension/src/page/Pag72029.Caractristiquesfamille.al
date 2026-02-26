//GL3900 
// page 72029 "Caractéristiques famille"
// {
//     //GL2024  ID dans Nav 2009 : "39002029"
//     PageType = ListPart;
//     SourceTable = "Caractéristiques famille";
//     SourceTableView = sorting("code famille", Carctéristique, dt_caract_value, theme)
//                       order(ascending);

//     Caption = 'Caractéristiques famille';
//     ApplicationArea = All;
//     layout
//     {
//         area(content)
//         {
//             field(tem; tem)
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Thème';
//                 //GL2024 TableRelation = Table50612.Field1;

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
//         tem := All;
//     end;

//     var
//         tem: Text[50];
//         car: Record "Caractéristiques équipement";
//         t: Record Organe;
//         All: label 'All themes';
// }

