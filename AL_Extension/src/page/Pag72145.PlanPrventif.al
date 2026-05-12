//GL3900 
// page 72145 "Plan Préventif"
// {//GL2024  ID dans Nav 2009 : "39002145"
//     PageType = Card;
//     SourceTable = "Plan Préventif";
//     ApplicationArea = All;

//     layout
//     {
//         area(content)
//         {
//             field(Code; REC.Code)
//             {
//                 ApplicationArea = all;
//             }
//             field(Libellé; REC.Libellé)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Désignation';
//             }
//             field(Equipement; REC.Equipement)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Equipement';

//                 trigger OnValidate()
//                 begin
//                     EquipementOnAfterValidate;
//                 end;
//             }
//             part(liste; "Liste Déclencheur")
//             {
//                 ApplicationArea = all;
//                 SubPageLink = Equipement = FIELD(Equipement);
//             }
//             label(text)
//             {
//                 ApplicationArea = all;
//                 CaptionClass = Text19072095;
//             }
//         }
//     }

//     actions
//     {
//     }

//     var
//         Text19072095: Label 'Liste des déclencheurs';

//     local procedure EquipementOnAfterValidate()
//     begin
//         CurrPage.UPDATE
//     end;
// }

