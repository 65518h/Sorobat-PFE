page 50095 "Ligne Paiement Chantier C"
{
    // //>>>MBK:05/02/2010: Référence chèque

    AutoSplitKey = true;
    Caption = 'Payment Slip Subform';
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = 10866;


    layout
    {
        area(content)
        {
            repeater("Control1")
            {
                field(Caisse; rec.Caisse)
                {
                    ApplicationArea = all;

                    Visible = false;
                }
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Numero Seq"; rec."Numero Seq")
                {
                    ApplicationArea = all;
                    Editable = false;

                }
                field("Due Date"; rec."Due Date")
                {
                    ApplicationArea = all;
                    Caption = 'Date';
                    Editable = IsEditable;


                    trigger OnValidate()
                    begin
                        IF rec."Due Date" > TODAY THEN ERROR(Text003);
                    end;
                }
                field("External Document No."; rec."External Document No.")
                {
                    ApplicationArea = all;

                    Caption = 'N° Piece De Paiement';
                    Editable = false;
                }
                field("Type de compte"; rec."Type de compte")
                {
                    ApplicationArea = all;
                    Caption = 'Type de Compte';
                    Editable = IsEditable;

                    OptionCaption = 'Général,Client,Fournisseur,Banque Où Caisse,Immobilisation,Frais annexe,Salarier';
                }
                field("Code compte"; rec."Code compte")
                {
                    ApplicationArea = all;
                    Editable = IsEditable;
                    Caption = 'N° Compte';

                }
                field("Motif Depense Ex"; rec."Motif Depense Ex")
                {

                    ApplicationArea = all;
                    Editable = IsEditable;
                    trigger OnValidate()
                    begin
                        rec.Caisse := FALSE;
                    end;
                }
                field(Benificiaire; rec.Benificiaire)
                {
                    ApplicationArea = all;
                    Editable = IsEditable;

                }
                field(Commentaires; rec.Commentaires)
                {
                    // Editable = false;    Editable = IsEditable;
                }
                field("Payment Class"; rec."Payment Class")
                {
                    ApplicationArea = all;
                    Editable = IsEditable;

                    Visible = false;
                }
                field("Status Name"; rec."Status Name")
                {
                    ApplicationArea = all;
                    Editable = IsEditable;

                    Visible = false;
                }
                field("Libellé  "; rec.Libellé)
                {
                    ApplicationArea = all;
                    Editable = IsEditable;
                    Description = '<AGA>';

                }
                field("Debit Amount"; rec."Debit Amount")
                {
                    ApplicationArea = all;
                    Editable = IsEditable;
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
                        rec.TESTFIELD("Motif Depense Ex");
                        rec.TESTFIELD(Benificiaire);

                        IF rec."Numero Seq" = 0 THEN EVALUATE(rec."Numero Seq", NoSeriesManagment.GetNextNo('SEQCPT', TODAY, TRUE));
                        CurrPage.Update();
                    end;
                }
                field("Envoyé Vers"; rec."Envoyé Vers")
                {

                    Editable = IsEditable;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        IF GeneralLedgerSetup.GET THEN;
                        Header.SETRANGE(Header."Payment Class", GeneralLedgerSetup."Type Reg. Caisse Ext");
                        IF page.RUNMODAL(10870, Header) = ACTION::LookupOK THEN BEGIN
                            rec."Envoyé Vers" := Header."No.";
                        END;
                    end;
                }
            }
        }
    }

    actions
    {
        area(Prompting)
        {
            group("&Payment Slip")
            {
                Caption = '&Payment Slip';
                Visible = false;
                action(Card)
                {
                    Caption = 'Card';
                    //   Image = EditLines;
                    RunpageLink = "No." = FIELD("No.");
                    RunObject = Page "Payment Slip";
                    ShortCutKey = 'Maj+F5';
                }
            }
        }
        area(processing)
        {
            group("P&osting")
            {
                Caption = 'P&osting';
                Visible = false;
                action(Envoyer)
                {
                    Caption = 'Envoyer';
                    ShortCutKey = 'F7';
                    Visible = false;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50093. Unsupported part was commented. Please check it.
                        /*CurrPage.Lines.FORM.*/
                        Envoye(FALSE);

                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        ActivateControls;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        HeaderRec: Record "Payment Header";
    begin
        rec."Caisse Chantier" := TRUE;
        //UpdateLinesAffaire();

        // Récupère le header si possible
        if HeaderRec.Get(Rec."No.") then begin
            Rec."N° Affaire" := HeaderRec."N° Affaire";
            // NE PAS appeler Rec.Modify() ici !
        end;
        exit(true); // autorise l'insertion
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
        GeneralLedgerSetup: Record 98;
        PaymentLine2: Record 10866;
        Text004: Label 'Envoyé Cette Ligne Au Document %1 ?';
        PaymentLine3: Record 10866;
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
            IF ((Header."Status No." = 0)) OR (Header.Reouvrir) THEN
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
        //   PostingStatement.DeleteLigBorCopy(StatementLine);
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


    procedure Envoye(ParaCPT: Boolean)
    begin
        IF NOT CONFIRM(Text004, FALSE) THEN EXIT;
        IF GeneralLedgerSetup.GET THEN;
        CLEAR(PaymentLine);
        CLEAR(PaymentLine2);
        PaymentLine3.RESET;
        PaymentLine2.RESET;
        PaymentLine2.SETRANGE("No.", rec."No.");
        PaymentLine2.SETFILTER("Envoyé Vers", '<>%1', '');
        IF PaymentLine2.FINDFIRST THEN
            REPEAT
                PaymentLine.TRANSFERFIELDS(PaymentLine2);
                PaymentLine."No." := PaymentLine2."Envoyé Vers";
                PaymentLine3.SETRANGE("No.", PaymentLine2."Envoyé Vers");
                IF PaymentLine3.FINDLAST THEN;
                PaymentLine."Line No." := PaymentLine3."Line No." + 1;
                PaymentLine."Payment Class" := GeneralLedgerSetup."Type Reg. Caisse Ext";
                PaymentLine."Envoyé Vers" := '';
                PaymentLine."N° Origine" := PaymentLine2."No.";
                PaymentLine."Ligne Origine" := PaymentLine2."Line No.";

                PaymentLine.INSERT;
                PaymentLine2.DELETE;
            UNTIL PaymentLine2.NEXT = 0;
        COMMIT;
    end;
}

