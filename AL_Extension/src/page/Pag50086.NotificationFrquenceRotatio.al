// Page 50086 "Notification Fréquence Rotatio"
// {
//     DeleteAllowed = false;
//     Editable = false;
//     InsertAllowed = false;
//     ModifyAllowed = true;
//     PageType = List;
//     SourceTable = "Notification Reception";
//     ApplicationArea = all;
//     UsageCategory = Administration;
//     Caption = 'Notification Fréquence Rotatio';

//     layout
//     {
//         area(content)
//         {
//             label("NOUVELLE NOTIFICATION FREQUENCE ROTATION  ARTICLE")
//             {
//                 ApplicationArea = all;
//                 Style = Strong;
//                 StyleExpr = true;
//                 Caption = 'NOUVELLE NOTIFICATION FREQUENCE ROTATION  ARTICLE';
//             }
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field("Document N°"; rec."Document N°")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'N° Document';
//                     Editable = false;
//                 }
//                 field(Article; rec.Article)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Style = Attention;
//                     StyleExpr = true;
//                 }
//                 field(Description; rec.Description)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Style = Unfavorable;
//                     StyleExpr = true;
//                 }
//                 field("Quantité Reçue"; rec."Quantité Reçue")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Requested Quantity';
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Date Reception"; rec."Date Reception")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Request Date';
//                     Editable = false;
//                 }
//                 field("Date DA"; rec."Date DA")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'DLast Change Date';
//                 }
//                 field(Demandeur; rec.Demandeur)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("N° Materiel"; rec."N° Materiel")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Période d'utilisation"; rec."Période d'utilisation")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Période Restante à Utiliser"; rec."Période Restante à Utiliser")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Parametre Frequence Rotation"; rec."Parametre Frequence Rotation")
//                 {
//                     ApplicationArea = all;
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
//                 ApplicationArea = all;
//                 Caption = 'ARCHIVE ALL';
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 begin
//                     NotificationRotation.SetRange(Archiver, false);
//                     NotificationRotation.SetRange("Type Notification", NotificationRotation."type notification"::Rotation);
//                     NotificationRotation.ModifyAll(Archiver, true);
//                 end;
//             }
//         }
//     }

//     trigger OnOpenPage()
//     begin
//         rec.SetRange(Archiver, false);
//         rec.SetRange("Type Notification", rec."type notification"::Rotation);
//         rec.SetRange(Utilisateur, UpperCase(UserId));
//     end;

//     var
//         NotificationRotation: Record "Notification Reception";
//         Tout: Boolean;

// }

