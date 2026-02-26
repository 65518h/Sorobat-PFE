//GL3900 
// page 72147 "Lancement Plans Préventifs"
// {//GL2024  ID dans Nav 2009 : "39002147"
//     PageType = Card;
//     SourceTable = "Lancement Plan 2";
//     ApplicationArea = All;

//     layout
//     {
//         area(content)
//         {
//             group("Critères de recherche sur Lancement des plans préventifs")
//             {
//                 Caption = 'Critères de recherche sur Lancement des plans préventifs';
//                 field(Désignation; REC.Désignation)
//                 {
//                     ApplicationArea = all;

//                     trigger OnValidate()
//                     begin
//                         D233signationOnAfterValidate;
//                     end;
//                 }
//                 field(Equipement; REC.Equipement)
//                 {
//                     ApplicationArea = all;
//                     Editable = true;
//                 }
//                 field("Non prioritaire"; REC."Non prioritaire")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Déclencheurs Non prioritaires';
//                 }
//                 field(Automatique; REC.Automatique)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Simulation; REC.Simulation)
//                 {
//                     ApplicationArea = all;

//                     trigger OnValidate()
//                     begin
//                         SimulationOnPush;
//                     end;
//                 }
//                 field(Date; REC.Date)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Jusqu''au :';
//                     Editable = DateEditable;
//                 }
//             }
//             part(SubForm; "Liste Déclencheur")
//             {
//                 ApplicationArea = all;
//                 Editable = false;
//                 Enabled = true;
//                 SubPageLink = Equipement = FIELD(Equipement);
//             }
//             field(NPlan; REC.NPlan)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Plan ';
//             }
//         }
//     }

//     actions
//     {
//     }

//     trigger OnAfterGetRecord()
//     begin
//         OnAfterGetCurrRecord1;
//     end;

//     trigger OnInit()
//     begin
//         DateEditable := TRUE;
//     end;

//     trigger OnNewRecord(BelowxRec: Boolean)
//     begin
//         OnAfterGetCurrRecord1;
//     end;

//     var

//         DateEditable: Boolean;

//     local procedure D233signationOnAfterValidate()
//     begin
//         CurrPage.UPDATE
//     end;

//     local procedure OnAfterGetCurrRecord1()
//     begin
//         xRec := Rec;
//         IF REC.Simulation THEN
//             DateEditable := TRUE
//         ELSE
//             DateEditable := FALSE;
//     end;

//     local procedure EquipementOnInputChange(var Text: Text[1024])
//     begin
//         CurrPage.UPDATE;
//         //Currpage.Equipement.ENABLED:= FALSE
//     end;

//     local procedure SimulationOnPush()
//     begin
//         IF REC.Simulation THEN
//             DateEditable := TRUE
//         ELSE
//             DateEditable := FALSE;
//     end;
// }

