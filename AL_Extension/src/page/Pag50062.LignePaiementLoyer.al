Page 50062 "Ligne Paiement Loyer"
{
    // //>>>MBK:05/02/2010: Référence chèque

    AutoSplitKey = true;
    Caption = 'Ligne Paiement Loyer';
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
                field(Chantier; rec.Chantier)
                {
                    ApplicationArea = all;
                }
                field(Proprietaire; rec.Proprietaire)
                {
                    ApplicationArea = all;

                    // trigger OnLookup(var Text: Text): Boolean
                    // begin
                    //     if RecPaymentHeader.Get(rec."No.") then;
                    //     Loyer.SetRange(Chantier, rec.Chantier);
                    //     Clear(FrmLoyer);
                    //     FrmLoyer.LookupMode := true;
                    //     FrmLoyer.SetTableview(Loyer);
                    //     FrmLoyer.GetNumPaiement(rec."No.", rec."Line No.");
                    //     FrmLoyer.RunModal;
                    //     CurrPage.Update;
                    // end;
                }
                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                    Caption = 'N° ligne';
                }
                field("Account Type"; rec."Account Type")
                {
                    ApplicationArea = all;
                    Caption = 'Type compte';
                    Visible = false;
                }
                field("Type de compte"; rec."Type de compte")
                {
                    ApplicationArea = all;
                    Caption = 'Type de compte';

                    // OptionCaption = 'General, Customer,Vendor, Bank and Cash, Fixed Assets, Item charge';

                }
                field("Code compte"; rec."Code compte")
                {
                    ApplicationArea = all;
                    Caption = 'Compte Tiers';
                }
                field("Account No."; rec."Account No.")
                {
                    ApplicationArea = all;
                    Caption = 'N° compte';
                    Visible = false;
                }
                // field("Code Opération"; rec."Code Opération")
                // {
                //     ApplicationArea = all;
                //     Caption = 'Code Opération';
                //     Visible = false;
                // }
                field("Currency Code"; rec."Currency Code")
                {
                    ApplicationArea = all;
                    Caption = 'Code devise';
                    Visible = false;
                }
                field("Libellé  "; rec.Libellé)
                {
                    ApplicationArea = all;
                    Caption = 'Libellé';
                }
                field("Due Date"; rec."Due Date")
                {
                    ApplicationArea = all;
                    Caption = 'Date d''échéance';
                }
                field("Date Loyer"; rec."Date Loyer")
                {
                    ApplicationArea = all;
                    Caption = 'Date Loyer';
                    Editable = false;
                }
                field("Mode Paiement"; rec."Mode Paiement")
                {
                    ApplicationArea = all;
                }
                field(Appartement; rec.Appartement)
                {
                    Caption = 'Appartement';
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = true;
                }
                field(Commentaires; rec.Commentaires)
                {
                    Caption = 'Commentaires';
                    ApplicationArea = all;
                }
                field(Deduction; rec.Deduction)
                {
                    ApplicationArea = all;
                    Caption = 'Deduction';
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                field("Debit Amount"; rec."Debit Amount")
                {
                    ApplicationArea = all;
                    DecimalPlaces = 3 : 3;
                    Caption = 'Montant débit';
                }
                field("Credit Amount"; rec."Credit Amount")
                {
                    ApplicationArea = all;
                    Caption = 'Montant crédit';
                    DecimalPlaces = 3 : 3;
                }
                field("External Document No."; rec."External Document No.")
                {
                    ApplicationArea = all;
                    Caption = 'N° Piece De Paiement';
                    Editable = false;
                }
                field("Drawee Reference Soroubat"; Rec."Drawee Reference Soroubat")
                {
                    ApplicationArea = all;
                }
                field("Code Retenue à la Source"; rec."Code Retenue à la Source")
                {
                    ApplicationArea = all;
                }
                field("Montant Retenue"; rec."Montant Retenue")
                {
                    ApplicationArea = all;
                    Caption = 'Montant Retenue';
                }
                field("Montant Initial"; rec."Montant Initial")
                {
                    ApplicationArea = all;
                    Caption = 'Montant Initial';
                    Editable = false;
                }
                field("Compte Bancaire"; rec."Compte Bancaire")
                {
                    ApplicationArea = all;
                    Caption = 'Compte Bancaire';
                }
            }
        }
    }

    actions
    {
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
        Text000: label 'Assign No. ?';
        Header: Record "Payment Header";
        Status: Record "Payment Status";
        Text001: label 'There is no line to modify';
        Text002: label 'A posted line cannot be modified.';
        PaymentClass: Record "Payment Class";
        Afficher: Code[20];
        PaymentHeader: Record "Payment Header";
        PurchaseHeader: Record "Purchase Header";
        RecPaymentHeader: Record "Payment Header";
        //   Loyer: Record Loyer;
        DateEch: Date;
        FrmLoyer: Page Loyer;


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


    procedure DisableFields()
    begin
        if Header.Get(rec."No.") then begin
            if (Header."Status No." = 0) and (rec."Copied To No." = '') then
                CurrPage.Editable(true)
            else
                CurrPage.Editable(false);
        end;
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
                    //GL2024 License    PostingStatement.IncrementNoText(No, 1);
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
        if Header.Get(rec."No.") then begin
            Status.Get(Header."Payment Class", Header."Status No.");
            DisableFields;
        end;
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


    procedure GetLineNumber() LineNumber: Integer
    begin
        exit(rec."Line No.");
    end;
}

