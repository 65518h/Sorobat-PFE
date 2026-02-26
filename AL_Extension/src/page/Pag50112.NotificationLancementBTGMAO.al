// Page 50112 "Notification Lancement BT GMAO"
// {
//     DeleteAllowed = false;
//     Editable = false;
//     InsertAllowed = false;
//     ModifyAllowed = true;
//     PageType = List;
//     SourceTable = "Notification Reception";
//     ApplicationArea = all;
//     Caption = 'Notification Lancement BT GMAO';
//     UsageCategory = Lists;

//     layout
//     {
//         area(content)
//         {
//             label(Control1000000023)
//             {
//                 ApplicationArea = all;
//                 Caption = 'NOUVELLE NOTIFICATION LANCEMENT BT PREVENTIF';
//                 Style = Strong;
//                 StyleExpr = true;
//             }
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field("Document N°"; REC."Document N°")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Code BT';
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field(Article; REC.Article)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Code Equipement';
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field(Description; REC.Description)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Désignation';
//                 }
//                 field(Chantier; REC.Chantier)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("N° Materiel"; REC."N° Materiel")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Code Gamme';
//                 }
//                 field("Quantité Alerte Min Max"; REC."Quantité Alerte Min Max")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Fréquence Gamme';
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field(Delai1; REC.Delai1)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Delai2; REC.Delai2)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Delai3; REC.Delai3)
//                 {
//                     ApplicationArea = all;
//                 }
//             }

//         }
//     }

//     actions
//     {
//     }

//     trigger OnOpenPage()
//     begin
//         REC.SetRange("Type Notification", REC."type notification"::GMAO);
//         REC.SetRange(Statut, REC.Statut::Lancé);
//     end;

//     var
//         NotificationMinMax: Record "Notification Reception";
//         Tout: Boolean;
//         Alerte: Text[1];
//         Text19078341: label 'NOUVELLE NOTIFICATION LANCEMENT BT PREVENTIF';
// }

