//GL3900 
// page 72156 Lancement
// {//GL2024  ID dans Nav 2009 : "39002156"
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

//     local procedure D233signationOnAfterValidate()
//     begin
//         CurrPage.UPDATE
//     end;

//     local procedure EquipementOnInputChange(var Text: Text[1024])
//     begin
//         CurrPage.UPDATE;
//         //Currpage.Equipement.ENABLED:= FALSE
//     end;
// }

