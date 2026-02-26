//GL3900 
// page 71484 "Autorisation D'absence"
// {//GL2024  ID dans Nav 2009 : "39001484"
//     PageType = Card;
//     SourceTable = "Ligne Pointage Journ. Validé";
//     SourceTableView = SORTING(Matricule, "Tot Heurs") ORDER(Ascending);
//     UsageCategory = Administration;
//     ApplicationArea = all;
//     Caption = 'Autorisation D''absence';
//     layout
//     {
//         area(content)
//         {

//             label(Txt)
//             {
//                 ApplicationArea = all;
//                 CaptionClass = FORMAT(Txt);
//                 Style = Strong;
//                 StyleExpr = TRUE;
//             }
//             field(Nom; rec.Nom)
//             {
//                 ApplicationArea = all;
//             }
//             field("Heure 35"; rec."Heure 35")
//             {
//                 ApplicationArea = all;
//             }
//             field("Jour repos"; rec."Jour repos")
//             {
//                 ApplicationArea = all;
//             }
//             field("Nom 1"; rec."Nom 1")
//             {
//                 ApplicationArea = all;
//             }
//             field("D.Hr sup"; rec."D.Hr sup")
//             {
//                 ApplicationArea = all;
//             }
//             field(Présence; rec.Présence)
//             {
//                 ApplicationArea = all;
//             }
//             field(Férier; rec.Férier)
//             {
//                 ApplicationArea = all;
//             }
//             field(Congé; rec.Congé)
//             {
//                 ApplicationArea = all;
//             }

//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group(Autorisation)
//             {
//                 Caption = 'Autorisation';
//                 action(Liste)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Liste';
//                     RunObject = Page "Decharge Facture";
//                     ShortCutKey = 'Ctrl+F5';
//                 }
//                 action("Conflit Avec Absence")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Conflit Avec Absence';
//                     RunObject = page "Employee's days off Entry";
//                     //GL2024   RunPageLink = "Entry No." = FIELD(Field100), "Employee No." = FIELD(Nom);
//                     RunPageView = SORTING("Transaction No.", "Entry No.", "Employee No.");
//                 }
//             }
//         }
//         area(processing)
//         {
//             group(ButtomValidation)
//             {
//                 Caption = 'P&osting';
//                 action("P&ost")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'P&ost';
//                     Image = Post;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedIsBig = true;
//                     ShortCutKey = 'F9';

//                     trigger OnAction()
//                     begin
//                         T1.RESET;
//                         T1.COPY(Rec);
//                         CurrPage.SETSELECTIONFILTER(T1);
//                         Val.ValiderAutorisation();
//                         CurrPage.UPDATE;
//                     end;
//                 }
//                 action("Post and &Print")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Post and &Print';
//                     Image = PostPrint;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedIsBig = true;
//                     ShortCutKey = 'Ctrl+F7';

//                     trigger OnAction()
//                     begin
//                         T1.RESET;
//                         T1.COPY(Rec);
//                         CurrPage.SETSELECTIONFILTER(T1);
//                         Val.ValiderAutorisation();
//                         CurrPage.UPDATE;
//                     end;
//                 }
//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     begin
//         REC.SETRANGE(Matricule, Format(T));
//         OnAfterGetCurrRecord;
//     end;

//     trigger OnInit()
//     begin
//         "Type Vehicule MissionVisible" := TRUE;
//     end;

//     trigger OnNewRecord(BelowxRec: Boolean)
//     begin
//         REC.Matricule := Format(T);
//         OnAfterGetCurrRecord;
//     end;

//     trigger OnOpenPage()
//     begin
//         //GL2024
//         T := REC.GETRANGEMIN(rec."Séquence");
//         IF REC.GETRANGEMIN(Matricule) = '0' THEN
//             Txt := 'Autorisation D''absence'
//         ELSE
//             Txt := 'Autorisation De Mission';
//         IF T = 1 THEN
//             "Type Vehicule MissionVisible" := TRUE
//         ELSE
//             "Type Vehicule MissionVisible" := FALSE;

//     end;

//     var
//         T1: Record "Ligne Pointage Journ. Validé";
//         Val: Codeunit "Management of absences";
//         Txt: Text[30];
//         T: Integer;

//         "Lieu départVisible": Boolean;

//         "Lieu ArrivéVisible": Boolean;

//         "Type Vehicule MissionVisible": Boolean;

//     // local procedure TypeVehiculeMissionOnAfterVali()
//     // begin
//     //     //GL2024
//     //     IF REC."Type Vehicule Mission" <> 0 THEN BEGIN
//     //         "Lieu départVisible" := TRUE;
//     //         "Lieu ArrivéVisible" := TRUE;
//     //     END ELSE BEGIN
//     //         "Lieu départVisible" := FALSE;
//     //         "Lieu ArrivéVisible" := FALSE;
//     //     END;

//     // end;

//     local procedure OnAfterGetCurrRecord()
//     begin
//         xRec := Rec;
//         //GL2024
//         REC.SETRANGE(Matricule, format(T));
//         // IF REC."Type Vehicule Mission" <> 0 THEN BEGIN
//         //     "Lieu départVisible" := TRUE;
//         //     "Lieu ArrivéVisible" := TRUE;
//         // END ELSE BEGIN
//         //     "Lieu départVisible" := FALSE;
//         //     "Lieu ArrivéVisible" := FALSE;
//         // END;

//     end;
// }

