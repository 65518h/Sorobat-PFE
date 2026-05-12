//GL3900 
// page 74729 "Fiche Frais de mission"
// {//GL2024  ID dans Nav 2009 : "39004729"
//     PageType = Card;
//     SourceTable = "Entête Frais de mission";
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
//             part("Frais de mission"; "Frais de Mission")
//             {
//                 ApplicationArea = all;
//                 SubPageLink = "N° Document" = FIELD("N° Frais"),
//                               "Code Mission" = FIELD("Code Mission");
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group(Validation)
//             {
//                 Caption = 'Validation';
//                 action(Valider)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Valider';
//                     ShortCutKey = 'F9';

//                     trigger OnAction()
//                     begin


//                         //Comptabilisation des Lignes Frais
//                         LigFrais.SETRANGE("N° Document", REC."N° Frais");
//                         IF LigFrais.FIND('-') THEN BEGIN
//                             LigFeuilleCpta.SETRANGE("Journal Template Name", 'GENERAL');
//                             LigFeuilleCpta.SETRANGE("Journal Batch Name", 'MISSFRAIS');
//                             IF LigFeuilleCpta.FIND('+') THEN
//                                 Nligne := LigFeuilleCpta."Line No." + 10000
//                             ELSE
//                                 Nligne := 10000;
//                             REPEAT
//                                 LigFeuilleCpta.RESET;
//                                 LigFeuilleCpta."Journal Template Name" := 'GENERAL';
//                                 LigFeuilleCpta."Journal Batch Name" := 'MISSFRAIS';
//                                 LigFeuilleCpta."Source Code" := 'JOD';
//                                 LigFeuilleCpta."Line No." := Nligne;
//                                 LigFeuilleCpta."Account Type" := LigFeuilleCpta."Account Type"::"G/L Account";
//                                 IF PGCPdt.GET('', LigFrais."Gen. Prod. Posting Group") THEN
//                                     LigFeuilleCpta.VALIDATE("Account No.", PGCPdt."Purch. Account");
//                                 LigFeuilleCpta."Posting Date" := REC."Date Comptabilisation";
//                                 LigFeuilleCpta."Document No." := REC."N° Frais";
//                                 LigFeuilleCpta."External Document No." := REC."Code Mission";
//                                 LigFeuilleCpta."VAT Prod. Posting Group" := LigFrais."VAT Prod. Posting Group";
//                                 LigFeuilleCpta."Bal. Account Type" := LigFrais."Type Compte contre partie";
//                                 LigFeuilleCpta.VALIDATE("Bal. Account No.", LigFrais."N° Compte contre partie");
//                                 LigFeuilleCpta.VALIDATE("Debit Amount", LigFrais."Montant TTC");
//                                 LigFeuilleCpta.VALIDATE("Shortcut Dimension 1 Code", REC."Global dimension 1");
//                                 LigFeuilleCpta.VALIDATE("Shortcut Dimension 2 Code", REC."Global dimension 2");
//                                 LigFeuilleCpta."Source Type" := 5;
//                                 LigFeuilleCpta."Source No." := REC."N° Salarié";
//                                 LigFeuilleCpta.INSERT;
//                                 //LigFeuilleCpta.CONSISTENT(TRUE);
//                                 Nligne := Nligne + 10000;
//                                 FraisMissEnreg.TRANSFERFIELDS(LigFrais);
//                                 FraisMissEnreg.INSERT;
//                             UNTIL LigFrais.NEXT = 0;

//                             TmpLigFeuill.RESET;
//                             TmpLigFeuill.SETRANGE("Document No.", REC."N° Frais");
//                             IF TmpLigFeuill.FIND('-') THEN
//                                 GenJnlPostLine.RUN(TmpLigFeuill);
//                             CurrPage.UPDATE(FALSE);
//                         END;
//                         LigFrais.DELETEALL;

//                         /*IF Miss.GET("Code Mission") THEN BEGIN
//                            Miss."Nbre Heure Prepara marchandise" := TRUE;
//                            Miss.MODIFY;
//                         END;  */

//                         FFraisMissEnreg.TRANSFERFIELDS(Rec);
//                         FFraisMissEnreg.INSERT;
//                         REC.DELETE;

//                     end;
//                 }
//             }
//         }
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

