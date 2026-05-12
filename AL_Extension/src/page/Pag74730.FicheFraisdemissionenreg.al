//GL3900 
// page 74730 "Fiche Frais de mission enreg."
// {//GL2024  ID dans Nav 2009 : "39004730"
//     Editable = false;
//     PageType = Card;
//     SourceTable = "Fiche Frais mission enregistré";
//     ApplicationArea = All;

//     layout
//     {
//         area(content)
//         {
//             group("Général")
//             {
//                 Caption = 'Général';
//                 field("N° Frais"; REC."N° Frais")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Code Mission"; REC."Code Mission")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("N° Salarié"; REC."N° Salarié")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Date Comptabilisation"; REC."Date Comptabilisation")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("First name"; REC."First name")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Prénom';
//                     Editable = false;
//                 }
//                 field("Last Name"; REC."Last Name")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Nom Usuel';
//                     Editable = false;
//                 }
//                 field("Global dimension 1"; REC."Global dimension 1")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Global dimension 2"; REC."Global dimension 2")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//             }
//             part("Frais de mission"; "Frais de Mission enregistrées")
//             {
//                 ApplicationArea = all;
//                 SubPageLink = "N° Document" = FIELD("N° Frais"),
//                               "Code Mission" = FIELD("Code Mission");
//             }
//         }
//     }

//     actions
//     {
//     }

//     var
//         LigFeuilleCpta: Record "Gen. Journal Line";
//         Nligne: Integer;
//         PGCPdt: Record "General Posting Setup";
//         TmpLigFeuill: Record "Gen. Journal Line";
//         GenJnlPostLine: Codeunit "Gen. Jnl.-Post";
//         TempJnlLineDim: Record "Dim. Value per Account";
//         LigFrais: Record "Frais de mission";
//         FraisMissEnreg: Record "Frais de mission Enregistrées";
//         Miss: Record "Mission Enregistré";
//         FFraisMissEnreg: Record "Fiche Frais mission enregistré";
// }

