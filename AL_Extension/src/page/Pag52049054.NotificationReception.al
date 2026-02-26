// page 52049054 "Notification Reception"
// {//GL2024  ID dans Nav 2009 : "39001582"
//     DeleteAllowed = false;
//     InsertAllowed = false;
//     ModifyAllowed = true;
//     PageType = List;
//     SourceTable = "Notification Reception";
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     Caption = 'Notification Reception';
//     layout
//     {
//         area(content)
//         {
//             label(Control1000000023)
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'NOUVELLE RECEPTION ARRIVEE';
//                 Style = Strong;
//                 StyleExpr = true;
//             }
//             repeater(Control1000000000)
//             {
//                 ShowCaption = false;
//                 field("Document N°"; Rec."Document N°")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("BL N °"; Rec."BL N °")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field(Article; Rec.Article)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field(Description; Rec.Description)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                     Style = Unfavorable;
//                     StyleExpr = true;
//                 }
//                 field("Quantité Reçue"; Rec."Quantité Reçue")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Quantité Restante"; Rec."Quantité Restante")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                     Style = Unfavorable;
//                     StyleExpr = true;
//                 }
//                 field("Date Reception"; Rec."Date Reception")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Date DA"; Rec."Date DA")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Date Commande"; Rec."Date Commande")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field(Demandeur; Rec.Demandeur)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("N° DA"; Rec."N° DA")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field(Archiver; Rec.Archiver)
//                 {
//                     ApplicationArea = Basic;

//                     trigger OnValidate()
//                     begin
//                         ArchiverOnAfterValidate;
//                     end;
//                 }
//             }

//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             action("ARCHIVER TOUT")
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'ARCHIVER TOUT';
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 begin
//                     NotificationReception.SetRange(Archiver, false);
//                     NotificationReception.SetRange("Type Notification", NotificationReception."type notification"::Reception);
//                     NotificationReception.ModifyAll(Archiver, true);
//                 end;
//             }
//         }
//     }

//     trigger OnOpenPage()
//     begin
//         Rec.SetRange(Archiver, false);
//         Rec.SetRange("Type Notification", Rec."type notification"::Reception);
//         Rec.SetRange(Utilisateur, UpperCase(UserId));
//     end;

//     var
//         NotificationReception: Record "Notification Reception";
//         Tout: Boolean;
//         Text19034152: label 'NOUVELLE RECEPTION ARRIVEE';

//     local procedure ArchiverOnAfterValidate()
//     begin
//         CurrPage.Update;
//     end;
// }

