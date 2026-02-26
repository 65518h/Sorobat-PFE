page 50110 "Ligne Paiement2"
{
    // //>>>MBK:05/02/2010: Référence chèque

    AutoSplitKey = true;
    Caption = 'Ligne Paiement';
    DelayedInsert = true;
    PageType = List;
    SourceTable = 10866;
    ApplicationArea = all;
    UsageCategory = Lists;


    layout
    {
        area(content)
        {
            repeater("Control1")
            {
                field("Numero Seq"; rec."Numero Seq")
                {
                    Editable = false;
                }
                field("Due Date"; rec."Due Date")
                {
                    Caption = 'Date';


                    //test//GHAITH
                    trigger OnValidate()
                    begin
                        IF rec."Due Date" > TODAY THEN ERROR(Text003);
                    end;
                }
                field("External Document No."; rec."External Document No.")
                {

                    Caption = 'N° Piece De Paiement';
                    Editable = false;

                }
                field("Type de compte"; rec."Type de compte")
                {
                    Caption = 'Type de Compte';


                    OptionCaption = 'Général,Client,Fournisseur,Banque Où Caisse,Immobilisation,Frais annexe,Salarier';
                }
                field("Code compte"; rec."Code compte")
                {
                    Caption = 'N° Compte';


                }
                field("Motif Depense Ex"; rec."Motif Depense Ex")
                {

                }
                field(Benificiaire; rec.Benificiaire)
                {


                }
                field(Commentaires; rec.Commentaires)
                {


                }
                field("Payment Class"; rec."Payment Class")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Status Name"; rec."Status Name")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Libellé  "; rec.Libellé)
                {
                    Editable = false;
                    Description = '<AGA>';

                }
                field("Debit Amount"; rec."Debit Amount")
                {

                    Caption = 'Montant';
                    DecimalPlaces = 3 : 3;

                    Style = Unfavorable;
                    StyleExpr = TRUE;

                    trigger OnValidate()
                    begin
                        //PaymentLine.SETCURRENTKEY("Numero Seq");
                        //PaymentLine.SETFILTER("Numero Seq",'<>%1',0);
                        //IF PaymentLine.FINDLAST THEN IF "Numero Seq"=0 THEN "Numero Seq":=PaymentLine."Numero Seq"+1;
                        rec.TESTFIELD("Code compte");
                        IF rec."Numero Seq" = 0 THEN EVALUATE(rec."Numero Seq", NoSeriesManagment.GetNextNo('SEQEXT', TODAY, TRUE));
                        CurrPage.Update();
                    end;
                }
            }
        }
    }

    actions
    {

        area(Processing)
        {

            action(Card)
            {
                Caption = 'Fiche';
                Image = EditLines;
                RunpageLink = "No." = FIELD("No.");
                RunObject = Page "Payment Slip";
                ShortCutKey = 'Maj+F5';
            }



        }
        area(Promoted)
        {
            actionref(Card1; Card)
            {

            }
        }



    }

    trigger OnAfterGetRecord()
    begin
        ActivateControls;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        rec.SetUpNewLine(xRec, BelowxRec);
    end;

    var
        Text000: Label 'Assign No. ?';
        Header: Record 10865;
        Status: Record 10861;
        Text001: Label 'There is no line to modify';
        Text002: Label 'A posted line cannot be modified.';
        PaymentClass: Record 10860;
        PaymentLine: Record 10866;
        NoSeriesManagment: Codeunit 396;
        Text003: Label 'Date Ne Peut pas Ettre > Date Jour';
        IsEditable: Boolean;


    procedure Application()
    begin
        CODEUNIT.RUN(CODEUNIT::"Payment-Apply", Rec);
    end;


    procedure ShowDimensions()
    begin
        ShowDimensions;
    end;


    procedure DisableFields(DocumentNo: Code[20])
    begin
        IF Header.GET(DocumentNo) THEN BEGIN
            IF ((Header."Status No." = 0) AND (rec."Copied To No." = '')) OR (Header.Reouvrir) THEN
                IsEditable := true
            ELSE
                IsEditable := false;
        END
        else if DocumentNo = '' then begin
            IsEditable := true
        end;
        CurrPage.Update(false);
    end;


    procedure Modify()
    var
        PaymentLine: Record 10866;
        PaymentModification: page 10871;
    begin
        IF rec."Line No." = 0 THEN
            MESSAGE(Text001)
        ELSE IF NOT rec.Posted THEN BEGIN
            PaymentLine.COPY(Rec);
            PaymentLine.SETRANGE("No.", rec."No.");
            PaymentLine.SETRANGE("Line No.", rec."Line No.");
            PaymentModification.SETTABLEVIEW(PaymentLine);
            PaymentModification.RUNMODAL;
        END ELSE
            MESSAGE(Text002);
    end;


    procedure Delete()
    var
        PostingStatement: Codeunit 10860;
        StatementLine: Record 10866;
    begin
        StatementLine.COPY(Rec);
        CurrPage.SETSELECTIONFILTER(StatementLine);
        //  PostingStatement.DeleteLigBorCopy(StatementLine);
    end;


    procedure SetDocumentID()
    var
        StatementLine: Record 10866;
        PostingStatement: Codeunit 10860;
        No: Code[20];
    begin
        IF CONFIRM(Text000) THEN BEGIN
            CurrPage.SETSELECTIONFILTER(StatementLine);
            StatementLine.MARKEDONLY(TRUE);
            IF NOT StatementLine.FIND('-') THEN
                StatementLine.MARKEDONLY(FALSE);
            IF StatementLine.FIND('-') THEN BEGIN
                No := StatementLine."Document No.";
                WHILE StatementLine.NEXT <> 0 DO BEGIN
                    // PostingStatement.IncrementNoText(No,1);
                    StatementLine."Document No." := No;
                    StatementLine.MODIFY;
                END;
            END;
        END;
    end;


    procedure ShowAccount()
    var
        GenJnlLine: Record 81;
    begin
        GenJnlLine."Account Type" := rec."Account Type";
        GenJnlLine."Account No." := rec."Account No.";
        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Show Card", GenJnlLine);
    end;


    procedure ShowEntries()
    var
        GenJnlLine: Record 81;
    begin
        GenJnlLine."Account Type" := rec."Account Type";
        GenJnlLine."Account No." := rec."Account No.";
        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Show Entries", GenJnlLine);
    end;


    procedure MarkLines(ToMark: Boolean)
    var
        LineCopy: Record 10866;
        PaymtManagt: Codeunit 10860;
        NumLines: Integer;
    begin
        IF ToMark THEN BEGIN
            CurrPage.SETSELECTIONFILTER(LineCopy);
            LineCopy.MARKEDONLY(TRUE);
            NumLines := LineCopy.COUNT;
            IF NumLines > 0 THEN BEGIN
                LineCopy.FIND('-');
                REPEAT
                    IF LineCopy.MARK THEN BEGIN
                        LineCopy.Marked := TRUE;
                        LineCopy.MODIFY;
                    END;
                UNTIL LineCopy.NEXT = 0;
            END ELSE
                LineCopy.RESET;
            LineCopy.SETRANGE("No.", rec."No.");
            LineCopy.MODIFYALL(Marked, TRUE);
        END ELSE BEGIN
            rec.CLEARMARKS;
            LineCopy.SETRANGE("No.", rec."No.");
            LineCopy.MODIFYALL(Marked, FALSE);
        END;
        COMMIT;
    end;


    procedure ActivateControls()
    begin
    end;


    procedure CalculerRetenu()
    begin
        rec.CalcRetenu;
    end;


    procedure Actualiser()
    begin
        rec.CalcAmount;
    end;


    procedure Affichelib() Lib: Text[100]
    var
        banq: Record 270;
        Frs: Record 23;
        cust: Record 18;
        Cmpt: Record 15;
        Sal: Record 5200;
    begin
        Frs.RESET;
        cust.RESET;
        Cmpt.RESET;
        Sal.RESET;
        banq.RESET;
        Lib := '';
        IF rec."Account No." <> '' THEN
            CASE rec."Account Type" OF
                rec."Account Type"::Vendor:
                    BEGIN
                        IF Frs.GET(rec."Account No.") THEN
                            Lib := Frs.Name;
                    END;
                rec."Account Type"::"G/L Account":
                    BEGIN
                        IF Cmpt.GET(rec."Account No.") THEN
                            Lib := Cmpt.Name;
                    END;

                rec."Account Type"::Customer:
                    BEGIN
                        IF cust.GET(rec."Account No.") THEN
                            Lib := cust.Name;
                    END;
                /*"Account Type"::Salary : BEGIN
                   IF Sal.GET("Account No.") THEN
                      Lib:=Sal."Last Name"+' '+Sal."First Name";
                   END;*/
                rec."Account Type"::"Bank Account":
                    BEGIN
                        IF banq.GET(rec."Account No.") THEN
                            Lib := banq.Name;
                    END;
            END;

    end;


    procedure fractLine()
    begin
        rec.FractionnerLine;
    end;


    procedure "---MBK---"()
    begin
    end;


    procedure REFCHEQUE(): Code[20]
    begin
        //>>>MBK:05/02/2010: Référence chèque
        EXIT(rec."Référence chèque");
    end;
}

