Page 50037 "Ligne Paiement CPT"
{
    // //>>>MBK:05/02/2010: Référence chèque

    AutoSplitKey = true;
    Caption = 'Ligne Paiement CPT';
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "Payment Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Numero Seq"; rec."Numero Seq")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Due Date"; rec."Due Date")
                {
                    ApplicationArea = all;
                    Editable = IsEditable;
                    Caption = 'Date';
                    trigger OnValidate()
                    begin
                        IF Rec."Due Date" > TODAY THEN ERROR(Text004);
                    end;
                }

                // field("Code Opération"; rec."Code Opération")
                // {
                //     ApplicationArea = all;
                //     Caption = 'Operation Code.';

                //     trigger OnLookup(var Text: Text): Boolean
                //     begin
                //         MotifDepense.SetRange(Sens, 'C');
                //         if page.RunModal(page::"Code Opération Caisse", MotifDepense) = Action::LookupOK then begin
                //             rec."Code Opération" := MotifDepense.Code;
                //             rec.Validate("Type de compte", rec."type de compte"::"Frais annexe");
                //             rec.Validate("Code compte", 'CC-DIVERS');
                //             rec.Libellé := MotifDepense.Description;
                //             rec.Caisse := true;
                //             rec."Type Caisse" := 3;    // 3: Depense Caisse C

                //         end;
                //     end;
                // }

                field("Type de compte"; rec."Type de compte")
                {
                    Caption = 'Type de Compte';
                    Editable = IsEditable;

                    OptionCaption = 'Général,Client,Fournisseur,Banque Où Caisse,Immobilisation,Frais annexe,Salarier';
                }
                field("Code compte"; rec."Code compte")
                {
                    Caption = 'N° Compte';
                    Editable = IsEditable;
                }
                field("Motif Depense Ex"; rec."Motif Depense Ex")
                {
                    Editable = IsEditable;
                    ApplicationArea = all;
                    Caption = 'Expense Reason Ex';
                }
                field(Benificiaire; rec.Benificiaire)
                {
                    Editable = IsEditable;
                    ApplicationArea = all;
                }
                field(Commentaires; rec.Commentaires)
                {
                    Editable = IsEditable;
                    ApplicationArea = all;
                }
                field("Libellé  "; rec.Libellé)
                {
                    ApplicationArea = all;
                    Description = '<AGA>';
                    Editable = IsEditable;
                }

                field("Credit Amount"; rec."Credit Amount")
                {
                    Visible = false;
                    ApplicationArea = all;
                    Caption = 'Montant';
                    DecimalPlaces = 3 : 3;
                    Editable = IsEditable;
                    Style = Unfavorable;
                    StyleExpr = true;

                    trigger OnValidate()
                    begin
                        //PaymentLine.SETCURRENTKEY("Numero Seq");
                        //PaymentLine.SETFILTER("Numero Seq",'<>%1',0);
                        //IF PaymentLine.FINDLAST THEN IF "Numero Seq"=0 THEN "Numero Seq":=PaymentLine."Numero Seq"+1;
                        if rec."Numero Seq" = 0 then EVALUATE(rec."Numero Seq", NoSeriesManagment.GetNextNo('SEQCPT', Today, true));
                    end;
                }

                field(Provisoire; rec.Provisoire)
                {
                    Visible = false;
                    Editable = IsEditable;
                    ApplicationArea = all;
                }
                field("Montant Retour"; rec."Montant Retour")
                {
                    Visible = false;
                    Editable = IsEditable;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        if rec."Montant Retour" > rec."Credit Amount" then Error(Text003);
                        rec.Validate("Credit Amount", rec."Credit Amount" - rec."Montant Retour");
                    end;
                }

                field("Debit Amount"; rec."Debit Amount")
                {
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
                        IF rec."Numero Seq" = 0 THEN EVALUATE(rec."Numero Seq", NoSeriesManagment.GetNextNo('SEQCPT', TODAY, TRUE));
                        CurrPage.Update();
                    end;

                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    var
        UserSetup: record "User Setup";
    begin
        ActivateControls;

        // GL2027
        if UserSetup.Get(UserId) then begin
            if UserSetup."Autoriser modif caisse extra" then begin
                if rec."Status No." = 0 then
                    IsEditable := true;
            end;

        end;

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        rec.SetUpNewLine(xRec, BelowxRec);
    end;

    var
        Text000: label 'Assign No. ?';
        Header: Record "Payment Header";
        Status: Record "Payment Status";
        Text001: label 'There is no line to modify';
        Text002: label 'A posted line cannot be modified.';
        PaymentClass: Record "Payment Class";
        PaymentLine: Record "Payment Line";
        NoSeriesManagment: Codeunit NoSeriesManagement;
        // MotifDepense: Record "Code Opération Caisse";
        Text003: label 'Return Amount Exceeds Principal Amount';
        Text004: label 'Date Ne Peut pas Ettre > Date Jour';
        IsEditable: Boolean;


    procedure Application()
    begin
        Codeunit.Run(Codeunit::"Payment-Apply", Rec);
    end;




    procedure ShowDimensions()
    var
        DimMgt: Codeunit DimensionManagement;
    begin
        //GL2024 License   Rec.ShowDimensions;
        //GL2024 License 
        rec."Dimension Set ID" :=
       DimMgt.EditDimensionSet(rec."Dimension Set ID", StrSubstNo('%1 %2 %3', rec.TableCaption(), rec."No.", rec."Line No."));
        //GL2024 License 
    end;


    procedure DisableFields(DocumentNo: Code[20])
    begin
        if Header.Get(DocumentNo) then begin
            if ((Header."Status No." = 0) and (rec."Copied To No." = '')) or (Header.Reouvrir) then
                IsEditable := true
            else
                IsEditable := false
        end
        else if DocumentNo = '' then begin
            IsEditable := true
        end;
        CurrPage.Update(false);
    end;


    procedure Modify()
    var
        PaymentLine: Record "Payment Line";
        PaymentModification: Page "Payment Line Modification";
    begin
        if rec."Line No." = 0 then
            Message(Text001)
        else
            if not rec.Posted then begin
                PaymentLine.Copy(Rec);
                PaymentLine.SetRange("No.", rec."No.");
                PaymentLine.SetRange("Line No.", rec."Line No.");
                PaymentModification.SetTableview(PaymentLine);
                PaymentModification.RunModal;
            end else
                Message(Text002);
    end;


    procedure Delete()
    var
        PostingStatement: Codeunit "Payment Management";
        StatementLine: Record "Payment Line";
    begin
        StatementLine.Copy(Rec);
        CurrPage.SetSelectionFilter(StatementLine);

        //GL2024 License  PostingStatement.DeleteLigBorCopy(StatementLine);
        DeleteLigBorCopy2(StatementLine);
    end;
    //GL2024 License 
    procedure DeleteLigBorCopy2(var FromPaymentLine: Record "Payment Line")
    var
        ToPaymentLine: Record "Payment Line";
        Text016: Label 'A posted line cannot be deleted.';
    begin
        ToPaymentLine.SetCurrentKey("Copied To No.", "Copied To Line");

        if FromPaymentLine.Find('-') then
            if FromPaymentLine.Posted then
                Message(Text016)
            else
                repeat
                    ToPaymentLine.SetRange("Copied To No.", FromPaymentLine."No.");
                    ToPaymentLine.SetRange("Copied To Line", FromPaymentLine."Line No.");
                    ToPaymentLine.FindFirst();
                    ToPaymentLine."Copied To No." := '';
                    ToPaymentLine."Copied To Line" := 0;
                    ToPaymentLine.Modify();
                    FromPaymentLine.Delete(true);
                until FromPaymentLine.Next() = 0;
    end;
    //GL2024 License 

    procedure SetDocumentID()
    var
        StatementLine: Record "Payment Line";
        PostingStatement: Codeunit "Payment Management";
        No: Code[20];
    begin
        if Confirm(Text000) then begin
            CurrPage.SetSelectionFilter(StatementLine);
            StatementLine.MarkedOnly(true);
            if not StatementLine.Find('-') then
                StatementLine.MarkedOnly(false);
            if StatementLine.Find('-') then begin
                No := StatementLine."Document No.";
                while StatementLine.Next <> 0 do begin
                    //GL2024 License   PostingStatement.IncrementNoText(No, 1);
                    StatementLine."Document No." := No;
                    StatementLine.Modify;
                end;
            end;
        end;
    end;


    procedure ShowAccount()
    var
        GenJnlLine: Record "Gen. Journal Line";
    begin
        GenJnlLine."Account Type" := rec."Account Type";
        GenJnlLine."Account No." := rec."Account No.";
        Codeunit.Run(Codeunit::"Gen. Jnl.-Show Card", GenJnlLine);
    end;


    procedure ShowEntries()
    var
        GenJnlLine: Record "Gen. Journal Line";
    begin
        GenJnlLine."Account Type" := rec."Account Type";
        GenJnlLine."Account No." := rec."Account No.";
        Codeunit.Run(Codeunit::"Gen. Jnl.-Show Entries", GenJnlLine);
    end;


    procedure MarkLines(ToMark: Boolean)
    var
        LineCopy: Record "Payment Line";
        PaymtManagt: Codeunit "Payment Management";
        NumLines: Integer;
    begin
        if ToMark then begin
            CurrPage.SetSelectionFilter(LineCopy);
            LineCopy.MarkedOnly(true);
            NumLines := LineCopy.Count;
            if NumLines > 0 then begin
                LineCopy.Find('-');
                repeat
                    if LineCopy.Mark then begin
                        LineCopy.Marked := true;
                        LineCopy.Modify;
                    end;
                until LineCopy.Next = 0;
            end else
                LineCopy.Reset;
            LineCopy.SetRange("No.", rec."No.");
            LineCopy.ModifyAll(Marked, true);
        end else begin
            rec.ClearMarks;
            LineCopy.SetRange("No.", rec."No.");
            LineCopy.ModifyAll(Marked, false);
        end;
        Commit;
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
        banq: Record "Bank Account";
        Frs: Record Vendor;
        cust: Record Customer;
        Cmpt: Record "G/L Account";
        Sal: Record Employee;
    begin
        Frs.Reset;
        cust.Reset;
        Cmpt.Reset;
        Sal.Reset;
        banq.Reset;
        Lib := '';
        if rec."Account No." <> '' then
            case rec."Account Type" of
                rec."account type"::Vendor:
                    begin
                        if Frs.Get(rec."Account No.") then
                            Lib := Frs.Name;
                    end;
                rec."account type"::"G/L Account":
                    begin
                        if Cmpt.Get(rec."Account No.") then
                            Lib := Cmpt.Name;
                    end;

                rec."account type"::Customer:
                    begin
                        if cust.Get(rec."Account No.") then
                            Lib := cust.Name;
                    end;
                /*"Account Type"::Salary : BEGIN
                   IF Sal.GET("Account No.") THEN
                      Lib:=Sal."Last Name"+' '+Sal."First Name";
                   END;*/
                rec."account type"::"Bank Account":
                    begin
                        if banq.Get(rec."Account No.") then
                            Lib := banq.Name;
                    end;
            end;

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
        exit(rec."Référence chèque");
    end;

    trigger OnOpenPage()
    var
        UserSetup: record "User Setup";
    begin

        // GL2027
        if UserSetup.Get(UserId) then begin
            if UserSetup."Autoriser modif caisse extra" then begin
                if rec."Status No." = 0 then
                    IsEditable := true;
            end;

        end;


    end;
}

