Page 90000 "Update Payment Journal"
{
    // #9064 XPE 31/08/2011

    AutoSplitKey = true;
    Caption = 'Update Payment Journal';
    DataCaptionFields = "Journal Batch Name";
    DelayedInsert = true;
    PageType = List;
    UsageCategory = Lists;
    SaveValues = true;
    SourceTable = 81;

    layout
    {
        area(content)
        {
            field(CurrentJnlBatchName; CurrentJnlBatchName)
            {
                ApplicationArea = Basic;
                Caption = 'Batch Name';
                Lookup = true;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    CurrPage.SaveRecord;
                    GenJnlManagement.LookupName(CurrentJnlBatchName, Rec);
                    CurrPage.Update(false);
                end;

                trigger OnValidate()
                begin
                    GenJnlManagement.CheckName(CurrentJnlBatchName, Rec);
                    CurrentJnlBatchNameOnAfterValidate;
                end;
            }
            repeater(Control1)
            {
                Editable = false;
                ShowCaption = false;
                field("Subscription Starting Date"; rec."Subscription Starting Date")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Subscription End Date"; rec."Subscription End Date")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field("Document Date"; rec."Document Date")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Document Type"; rec."Document Type")
                {
                    ApplicationArea = Basic;
                }
                field("Document No."; rec."Document No.")
                {
                    ApplicationArea = Basic;
                }
                field("External Document No."; rec."External Document No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Account Type"; rec."Account Type")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        GenJnlManagement.GetAccounts(Rec, AccName, BalAccName);
                    end;
                }
                field("Account No."; rec."Account No.")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        GenJnlManagement.GetAccounts(Rec, AccName, BalAccName);
                        rec.ShowShortcutDimCode(ShortcutDimCode);
                    end;
                }
                field("Payment Bank Account"; rec."Payment Bank Account")
                {
                    ApplicationArea = Basic;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Job No."; rec."Job No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Job Task No."; rec."Job Task No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Salespers./Purch. Code"; rec."Salespers./Purch. Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Campaign No."; rec."Campaign No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Currency Code"; rec."Currency Code")
                {
                    ApplicationArea = Basic;
                    AssistEdit = true;

                    trigger OnAssistEdit()
                    begin
                        ChangeExchangeRate.SetParameter(rec."Currency Code", rec."Currency Factor", rec."Posting Date");
                        if ChangeExchangeRate.RunModal = Action::OK then begin
                            rec.Validate("Currency Factor", ChangeExchangeRate.GetParameter);
                        end;
                        Clear(ChangeExchangeRate);
                    end;
                }
                field("Due Date"; rec."Due Date")
                {
                    ApplicationArea = Basic;
                }
                field("Gen. Posting Type"; rec."Gen. Posting Type")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Gen. Bus. Posting Group"; rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Gen. Prod. Posting Group"; rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("VAT Bus. Posting Group"; rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("VAT Prod. Posting Group"; rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Amount; rec.Amount)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Debit Amount"; rec."Debit Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Credit Amount"; rec."Credit Amount")
                {
                    ApplicationArea = Basic;
                }
                field("VAT Amount"; rec."VAT Amount")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("VAT Difference"; rec."VAT Difference")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Bal. VAT Amount"; rec."Bal. VAT Amount")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Bal. VAT Difference"; rec."Bal. VAT Difference")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Bal. Account Type"; rec."Bal. Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Bal. Account No."; rec."Bal. Account No.")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        GenJnlManagement.GetAccounts(Rec, AccName, BalAccName);
                        rec.ShowShortcutDimCode(ShortcutDimCode);
                    end;
                }
                field("Bal. Gen. Posting Type"; rec."Bal. Gen. Posting Type")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Bal. Gen. Bus. Posting Group"; rec."Bal. Gen. Bus. Posting Group")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Bal. Gen. Prod. Posting Group"; rec."Bal. Gen. Prod. Posting Group")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Bal. VAT Bus. Posting Group"; rec."Bal. VAT Bus. Posting Group")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Bal. VAT Prod. Posting Group"; rec."Bal. VAT Prod. Posting Group")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("ShortcutDimCode[3]"; ShortcutDimCode[3])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '1,2,3';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        rec.LookupShortcutDimCode(3, ShortcutDimCode[3]);
                    end;

                    trigger OnValidate()
                    begin
                        rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                }
                field("ShortcutDimCode[4]"; ShortcutDimCode[4])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '1,2,4';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        rec.LookupShortcutDimCode(4, ShortcutDimCode[4]);
                    end;

                    trigger OnValidate()
                    begin
                        rec.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }
                field("ShortcutDimCode[5]"; ShortcutDimCode[5])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '1,2,5';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        rec.LookupShortcutDimCode(5, ShortcutDimCode[5]);
                    end;

                    trigger OnValidate()
                    begin
                        rec.ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                    end;
                }
                field("ShortcutDimCode[6]"; ShortcutDimCode[6])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '1,2,6';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        rec.LookupShortcutDimCode(6, ShortcutDimCode[6]);
                    end;

                    trigger OnValidate()
                    begin
                        rec.ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                    end;
                }
                field("ShortcutDimCode[7]"; ShortcutDimCode[7])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '1,2,7';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        rec.LookupShortcutDimCode(7, ShortcutDimCode[7]);
                    end;

                    trigger OnValidate()
                    begin
                        rec.ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                }
                field("ShortcutDimCode[8]"; ShortcutDimCode[8])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '1,2,8';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        rec.LookupShortcutDimCode(8, ShortcutDimCode[8]);
                    end;

                    trigger OnValidate()
                    begin
                        rec.ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
                field("Applies-to Doc. Type"; rec."Applies-to Doc. Type")
                {
                    ApplicationArea = Basic;
                }
                field("Applies-to Doc. No."; rec."Applies-to Doc. No.")
                {
                    ApplicationArea = Basic;
                }
                field("Applies-to ID"; rec."Applies-to ID")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(GetAppliesToDocDueDate; rec.GetAppliesToDocDueDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Applies-to Doc. Due Date';
                    Editable = false;
                }
                field("Bank Payment Type"; rec."Bank Payment Type")
                {
                    ApplicationArea = Basic;
                }
                field("Payment Type"; rec."Payment Type")
                {
                    ApplicationArea = Basic;
                }
                field("Check Printed"; rec."Check Printed")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Bill Type"; rec."Bill Type")
                {
                    ApplicationArea = Basic;
                }
                field("Reason Code"; rec."Reason Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
            }
            group(Control24)
            {
                ShowCaption = false;
                field(AccName; AccName)
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Name';
                    Editable = false;
                }
                field(BalAccName; BalAccName)
                {
                    ApplicationArea = Basic;
                    Caption = 'Bal. Account Name';
                    Editable = false;
                }
                field(Balance; Balance + rec."Balance (LCY)" - xRec."Balance (LCY)")
                {
                    ApplicationArea = Basic;
                    AutoFormatType = 1;
                    Caption = 'Balance';
                    Editable = false;
                    Visible = BalanceVisible;
                }
                field(TotalBalance; TotalBalance + rec."Balance (LCY)" - xRec."Balance (LCY)")
                {
                    ApplicationArea = Basic;
                    AutoFormatType = 1;
                    Caption = 'Total Balance';
                    Editable = false;
                    Visible = TotalBalanceVisible;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Update)
            {
                ApplicationArea = Basic;
                Caption = 'Update';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec."Check Printed" := true;
                    Rec."Bank Payment Type" := Rec."bank payment type"::"Computer Check";
                    Rec.Modify();
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        rec.ShowShortcutDimCode(ShortcutDimCode);
        OnAfterGetCurrRecord;
    end;

    trigger OnInit()
    begin
        TotalBalanceVisible := true;
        BalanceVisible := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage()
    var
        JnlSelected: Boolean;
        lGLsetup: Record 98;
    begin
        BalAccName := '';
        GenJnlManagement.TemplateSelection(page::"Payment Journal", 4, false, Rec, JnlSelected);
        if not JnlSelected then
            Error('');
        GenJnlManagement.OpenJnl(CurrentJnlBatchName, Rec);
    end;

    var
        Text000: label 'Void Check %1?';
        Text001: label 'Void all printed checks?';
        ChangeExchangeRate: page 511;
        GenJnlLine: Record 81;
        GenJnlLine2: Record 81;
        GLReconcile: page 345;
        CreateVendorPmtSuggestion: Report 393;
        GenJnlManagement: Codeunit 230;
        ReportPrint: Codeunit 228;
        DocPrint: Codeunit 229;
        CheckManagement: Codeunit 367;
        CurrentJnlBatchName: Code[10];
        AccName: Text[50];
        BalAccName: Text[50];
        Balance: Decimal;
        TotalBalance: Decimal;
        ShowBalance: Boolean;
        ShowTotalBalance: Boolean;
        ShortcutDimCode: array[8] of Code[20];
        tInvalidPaymentType: label 'Invalide Payment Type';
        //GL2024   DtaSuggestVendPmt: Report 3010546;
        //GL2024   DtaMgt: Codeunit 3010541;
        //GL2024   VendPmtAdvice: Report 11561;
        //GL2024   [InDataSet]
        BalanceVisible: Boolean;
        [InDataSet]
        TotalBalanceVisible: Boolean;

    local procedure UpdateBalance()
    begin
        GenJnlManagement.CalcBalance(
          Rec, xRec, Balance, TotalBalance, ShowBalance, ShowTotalBalance);
        BalanceVisible := ShowBalance;
        TotalBalanceVisible := ShowTotalBalance;
    end;


    procedure wCheckTransfer()
    var
        lBankPayment: Record 8004101;
        Text8004102: label 'You must add up transfer to a bank account.';
    begin
        if rec."Payment Type" = rec."payment type"::Transfer then begin
            if (rec."Bal. Account Type" = rec."bal. account type"::"Bank Account") and (rec."Bal. Account No." <> '') then begin
                lBankPayment.Get(rec."Bal. Account No.", rec."Payment Type");
                if lBankPayment."Bal. Summarize" then
                    Error(Text8004102);
            end;
        end;
    end;

    local procedure CurrentJnlBatchNameOnAfterValidate()
    begin
        CurrPage.SaveRecord;
        GenJnlManagement.SetName(CurrentJnlBatchName, Rec);
        CurrPage.Update(false);
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        GenJnlManagement.GetAccounts(Rec, AccName, BalAccName);
        UpdateBalance;
    end;
}

