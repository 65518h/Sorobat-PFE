page 50049 Provisoire
{
    //GL2024 NEW PAGE
    Caption = 'Provisoire';

    PageType = list;

    RefreshOnActivate = true;
    SourceTable = "Payment Header";
    SourceTableView = WHERE("Payment Class" = CONST('ESPECES EXTERIEURE EMIS'), "Caisse Chantier" = CONST(false), Provisoire = const(true));
    ModifyAllowed = false;
    ApplicationArea = all;
    UsageCategory = lists;
    CardPageId = "Fiche Provisoire";
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;

                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                    Caption = 'N° Document';
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = all;
                }
                field("Type paiement"; Rec."Type paiement")
                {
                    ApplicationArea = all;
                    Caption = 'Type paiement';

                }
                field(Utilisateur; Rec.Utilisateur)
                {
                    ApplicationArea = all;

                }
                field("Validé Par"; rec."Validé Par")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                /*  
                   field("Solde Caisse"; rec."Solde Caisse")
                   {
                       ApplicationArea = all;
                       Style = Unfavorable;
                       StyleExpr = TRUE;
                   }*/
                field("Document Date"; rec."Document Date")
                {
                    ApplicationArea = all;

                }
                field(Approuver; Rec.Approuver)
                {
                    ApplicationArea = all;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = all;
                }
                field("Account No."; rec."Account No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                }


                /*  field(Valider1; rec.Valider)
                  {
                      ApplicationArea = all;
                      Editable = false;
                      Style = Strong;
                      StyleExpr = TRUE;
                  }
                  field("Validé Par"; rec."Validé Par")
                  {
                      ApplicationArea = all;
                      Editable = false;
                  }
                  field("N° Affaire"; rec."N° Affaire")
                  {
                      ApplicationArea = all;
                      Editable = false;
                      Style = Strong;
                      StyleExpr = TRUE;
                  }*/

                field("Amount (LCY)"; rec."Amount (LCY)")
                {
                    ApplicationArea = all;
                    Caption = 'Montant DS';
                    Enabled = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(Agence; Rec.Agence)
                {
                    ApplicationArea = all;
                }
                field("Payment Class"; rec."Payment Class")
                {
                    ApplicationArea = all;
                    //  Editable = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Status Name"; Rec."Status Name")
                {
                    ApplicationArea = all;
                }
                field("Bénéficiaire"; Rec."Bénéficiaire")
                {
                    ApplicationArea = all;
                }
                /* field("Account No.";Rec."Account No.")
                 {
                      ApplicationArea = all;
                 }*/
            }
        }

    }
    trigger OnDeleteRecord(): Boolean
    var
        UserSetup: record "User Setup";
    begin
        if UserSetup.Get(UserId) then begin
            if not UserSetup."Autoriser modif caisse extra" then
                Error(
                'Vous n''êtes pas autorisé à supprimer la caisse extra.'
                );
        end;
    end;

    trigger OnOpenPage()
    var
        RecUser: Record "User Setup";
        Text0011: Label 'You are not authorized for the Cash Receipt - Disbursement module.';
    begin
        // << HJ DSFT 21-01-2009
        RecUser.GET(UPPERCASE(USERID));
        IF RecUser.Niveau = 0 THEN ERROR(Text0011);
        IF RecUser.Niveau = 1 THEN rec.SETRANGE(Utilisateur, UPPERCASE(USERID));
        IF (RecUser.Niveau = 2) AND (RecUser.Agence <> '') THEN
            rec.SETRANGE(Agence, RecUser.Agence)
        ELSE
            rec.SETRANGE(Agence);
        rec.SETRANGE("Account Type", rec."Account Type"::"Bank Account");


        //IF Valider=TRUE   THEN
        //  BEGIN
        //  Currpage.EDITABLE(FALSE);
        //  // Currpage.Lines.FORM.EDITABLE(FALSE);
        // END
        //ELSE Currpage.EDITABLE(TRUE);

        //<< HJ DSFT 21-01-2009IF (Valider)   THEN
    end;

    trigger OnAfterGetRecord()
    var
        RecUser: Record "User Setup";
        Text011: Label 'Check Number %1 used more than once';
    begin
        RecUser.GET(UPPERCASE(USERID));
        // << HJ DSFT 08-11-2009
        IF RecUser.Niveau = 0 THEN ERROR(Text011);
        IF RecUser.Niveau = 1 THEN rec.SETRANGE(Utilisateur, USERID);
        IF (RecUser.Niveau = 2) AND (RecUser.Agence <> '') THEN
            rec.SETRANGE(Agence, RecUser.Agence)
        ELSE
            rec.SETRANGE(Agence);
        // >> HJ DSFT 08 11 2010
    END;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        rec.Provisoire := true;
    end;
}



//abz commente
// {
//     // //>>>MBK:05/02/2010: Référence chèque

//     AutoSplitKey = true;
//     Caption = 'Provisoire';
//     DelayedInsert = true;
//     PageType = List;
//     SourceTable = 10866;
//     SourceTableView = WHERE(Provisoire = CONST(TRUE));
//     ApplicationArea = all;


//     layout
//     {
//         area(content)
//         {
//             repeater("")
//             {
//                 ShowCaption = false;
//                 field("No."; rec."No.")
//                 {
//                     Editable = false;
//                 }
//                 field("Numero Seq"; rec."Numero Seq")
//                 {
//                     Editable = false;
//                 }
//                 field("Due Date"; rec."Due Date")
//                 {
//                     Caption = 'Date';
//                     Editable = false;

//                     trigger OnValidate()
//                     begin
//                         IF rec."Due Date" > TODAY THEN ERROR(Text003);
//                     end;
//                 }
//                 field("Motif Depense Ex"; rec."Motif Depense Ex")
//                 {
//                     Editable = false;
//                 }
//                 field(Benificiaire; rec.Benificiaire)
//                 {
//                     Editable = false;
//                 }
//                 field(Commentaires; rec.Commentaires)
//                 {
//                     Editable = false;
//                 }
//                 field("Libellé  "; rec.Libellé)
//                 {
//                     Description = '<AGA>';
//                     Editable = false;
//                 }
//                 field("Debit Amount"; rec."Debit Amount")
//                 {
//                     Caption = 'Montant';
//                     DecimalPlaces = 3 : 3;
//                     Editable = true;
//                     Style = Unfavorable;
//                     StyleExpr = TRUE;

//                     trigger OnValidate()
//                     begin
//                         //PaymentLine.SETCURRENTKEY("Numero Seq");
//                         //PaymentLine.SETFILTER("Numero Seq",'<>%1',0);
//                         //IF PaymentLine.FINDLAST THEN IF "Numero Seq"=0 THEN "Numero Seq":=PaymentLine."Numero Seq"+1;
//                         rec.TESTFIELD("Code compte");
//                         IF rec."Numero Seq" = 0 THEN EVALUATE(rec."Numero Seq", NoSeriesManagment.GetNextNo('SEQEXT', TODAY, TRUE));
//                     end;
//                 }
//                 field(Provisoire; rec.Provisoire)
//                 {

//                     trigger OnValidate()
//                     begin
//                         IF NOT CONFIRM(Text004) THEN ERROR(Text005);
//                     end;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(Promoted)
//         {
//             group("&Payment Slip2")
//             {
//                 Caption = 'Bordereau &paiement';
//                 actionref(Card1; card) { }
//             }
//         }
//         area(navigation)
//         {
//             group("&Payment Slip")
//             {
//                 Caption = 'Bordereau &paiement';
//                 action(Card)
//                 {
//                     Caption = 'Fiche';
//                     Image = EditLines;
//                     RunPageLink = "No." = FIELD("No.");
//                     RunObject = Page 10868;
//                     ShortCutKey = 'Maj+F5';
//                 }
//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     begin
//         ActivateControls;
//     end;

//     trigger OnNewRecord(BelowxRec: Boolean)
//     begin
//         rec.SetUpNewLine(xRec, BelowxRec);
//     end;

//     var
//         Text000: Label 'Assign No. ?';
//         Header: Record 10865;
//         Status: Record 10861;
//         Text001: Label 'There is no line to modify';
//         Text002: Label 'A posted line cannot be modified.';
//         PaymentClass: Record 10860;
//         PaymentLine: Record 10866;
//         NoSeriesManagment: Codeunit 396;
//         Text003: Label 'Date Ne Peut pas Ettre > Date Jour';
//         Text004: Label 'Confirmer Cette Action ?';
//         Text005: Label 'Action Annulée';


//     procedure Application()
//     begin
//         CODEUNIT.RUN(CODEUNIT::"Payment-Apply", Rec);
//     end;


//     procedure ShowDimensions()
//     begin
//         ShowDimensions;
//     end;


//     procedure DisableFields()
//     begin
//         IF Header.GET(rec."No.") THEN BEGIN
//             IF ((Header."Status No." = 0) AND (rec."Copied To No." = '')) OR (Header.Reouvrir) THEN
//                 CurrPage.EDITABLE(TRUE)
//             ELSE
//                 CurrPage.EDITABLE(FALSE);
//         END;
//     end;


//     procedure Modify()
//     var
//         PaymentLine: Record 10866;
//         PaymentModification: page 10871;
//     begin
//         IF rec."Line No." = 0 THEN
//             MESSAGE(Text001)
//         ELSE IF NOT rec.Posted THEN BEGIN
//             PaymentLine.COPY(Rec);
//             PaymentLine.SETRANGE("No.", rec."No.");
//             PaymentLine.SETRANGE("Line No.", rec."Line No.");
//             PaymentModification.SETTABLEVIEW(PaymentLine);
//             PaymentModification.RUNMODAL;
//         END ELSE
//             MESSAGE(Text002);
//     end;


//     procedure Delete()
//     var
//         PostingStatement: Codeunit "Payment Management copy";
//         StatementLine: Record 10866;
//     begin
//         StatementLine.COPY(Rec);
//         CurrPage.SETSELECTIONFILTER(StatementLine);
//         PostingStatement.DeleteLigBorCopy(StatementLine);
//     end;


//     procedure SetDocumentID()
//     var
//         StatementLine: Record 10866;
//         PostingStatement: Codeunit "Payment Management copy";
//         No: Code[20];
//     begin
//         IF CONFIRM(Text000) THEN BEGIN
//             CurrPage.SETSELECTIONFILTER(StatementLine);
//             StatementLine.MARKEDONLY(TRUE);
//             IF NOT StatementLine.FIND('-') THEN
//                 StatementLine.MARKEDONLY(FALSE);
//             IF StatementLine.FIND('-') THEN BEGIN
//                 No := StatementLine."Document No.";
//                 WHILE StatementLine.NEXT <> 0 DO BEGIN
//                     PostingStatement.IncrementNoText(No, 1);
//                     StatementLine."Document No." := No;
//                     StatementLine.MODIFY;
//                 END;
//             END;
//         END;
//     end;


//     procedure ShowAccount()
//     var
//         GenJnlLine: Record 81;
//     begin
//         GenJnlLine."Account Type" := rec."Account Type";
//         GenJnlLine."Account No." := rec."Account No.";
//         CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Show Card", GenJnlLine);
//     end;


//     procedure ShowEntries()
//     var
//         GenJnlLine: Record 81;
//     begin
//         GenJnlLine."Account Type" := rec."Account Type";
//         GenJnlLine."Account No." := rec."Account No.";
//         CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Show Entries", GenJnlLine);
//     end;


//     procedure MarkLines(ToMark: Boolean)
//     var
//         LineCopy: Record 10866;
//         PaymtManagt: Codeunit 10860;
//         NumLines: Integer;
//     begin
//         IF ToMark THEN BEGIN
//             CurrPage.SETSELECTIONFILTER(LineCopy);
//             LineCopy.MARKEDONLY(TRUE);
//             NumLines := LineCopy.COUNT;
//             IF NumLines > 0 THEN BEGIN
//                 LineCopy.FIND('-');
//                 REPEAT
//                     IF LineCopy.MARK THEN BEGIN
//                         LineCopy.Marked := TRUE;
//                         LineCopy.MODIFY;
//                     END;
//                 UNTIL LineCopy.NEXT = 0;
//             END ELSE
//                 LineCopy.RESET;
//             LineCopy.SETRANGE("No.", rec."No.");
//             LineCopy.MODIFYALL(Marked, TRUE);
//         END ELSE BEGIN
//             rec.CLEARMARKS;
//             LineCopy.SETRANGE("No.", rec."No.");
//             LineCopy.MODIFYALL(Marked, FALSE);
//         END;
//         COMMIT;
//     end;


//     procedure ActivateControls()
//     begin
//     end;


//     procedure CalculerRetenu()
//     begin
//         rec.CalcRetenu;
//     end;


//     procedure Actualiser()
//     begin
//         rec.CalcAmount;
//     end;


//     procedure Affichelib() Lib: Text[100]
//     var
//         banq: Record 270;
//         Frs: Record 23;
//         cust: Record 18;
//         Cmpt: Record 15;
//         Sal: Record 5200;
//     begin
//         Frs.RESET;
//         cust.RESET;
//         Cmpt.RESET;
//         Sal.RESET;
//         banq.RESET;
//         Lib := '';
//         IF rec."Account No." <> '' THEN
//             CASE rec."Account Type" OF
//                 rec."Account Type"::Vendor:
//                     BEGIN
//                         IF Frs.GET(rec."Account No.") THEN
//                             Lib := Frs.Name;
//                     END;
//                 rec."Account Type"::"G/L Account":
//                     BEGIN
//                         IF Cmpt.GET(rec."Account No.") THEN
//                             Lib := Cmpt.Name;
//                     END;

//                 rec."Account Type"::Customer:
//                     BEGIN
//                         IF cust.GET(rec."Account No.") THEN
//                             Lib := cust.Name;
//                     END;
//                 /*"Account Type"::Salary : BEGIN
//                    IF Sal.GET("Account No.") THEN
//                       Lib:=Sal."Last Name"+' '+Sal."First Name";
//                    END;*/
//                 rec."Account Type"::"Bank Account":
//                     BEGIN
//                         IF banq.GET(rec."Account No.") THEN
//                             Lib := banq.Name;
//                     END;
//             END;

//     end;


//     procedure fractLine()
//     begin
//         rec.FractionnerLine;
//     end;


//     procedure "---MBK---"()
//     begin
//     end;


//     procedure REFCHEQUE(): Code[20]
//     begin
//         //>>>MBK:05/02/2010: Référence chèque
//         EXIT(rec."Référence chèque");
//     end;
// }

