Page 50196 "Ecriture Comptable Modif"
{
    PageType = List;
    SourceTable = "Vendor Ledger Entry";
    ApplicationArea = all;
    Caption = 'Ecriture Comptable Modif';
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                // field(Boolean; REC.Boolean)
                // {
                //     ApplicationArea = all;
                //     Style = Strong;
                //     StyleExpr = true;
                // }
                field("Entry No."; REC."Entry No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Vendor No."; REC."Vendor No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Posting Date"; REC."Posting Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Document Type"; REC."Document Type")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Document No."; REC."Document No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Description; REC.Description)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Currency Code"; REC."Currency Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Amount; REC.Amount)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Remaining Amount"; REC."Remaining Amount")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Original Amt. (LCY)"; REC."Original Amt. (LCY)")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Remaining Amt. (LCY)"; REC."Remaining Amt. (LCY)")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Amount (LCY)"; REC."Amount (LCY)")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Purchase (LCY)"; REC."Purchase (LCY)")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Inv. Discount (LCY)"; REC."Inv. Discount (LCY)")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Buy-from Vendor No."; REC."Buy-from Vendor No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Vendor Posting Group"; REC."Vendor Posting Group")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Global Dimension 1 Code"; REC."Global Dimension 1 Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Global Dimension 2 Code"; REC."Global Dimension 2 Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Purchaser Code"; REC."Purchaser Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("User ID"; REC."User ID")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Source Code"; REC."Source Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("On Hold"; REC."On Hold")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Applies-to Doc. Type"; REC."Applies-to Doc. Type")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Applies-to Doc. No."; REC."Applies-to Doc. No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Open; REC.Open)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Due Date"; REC."Due Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Pmt. Discount Date"; REC."Pmt. Discount Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Original Pmt. Disc. Possible"; REC."Original Pmt. Disc. Possible")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Pmt. Disc. Rcd.(LCY)"; REC."Pmt. Disc. Rcd.(LCY)")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Positive; REC.Positive)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Closed by Entry No."; REC."Closed by Entry No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Closed at Date"; REC."Closed at Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Closed by Amount"; REC."Closed by Amount")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Applies-to ID"; REC."Applies-to ID")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Reason Code"; REC."Reason Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Bal. Account Type"; REC."Bal. Account Type")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Bal. Account No."; REC."Bal. Account No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Transaction No."; REC."Transaction No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Closed by Amount (LCY)"; REC."Closed by Amount (LCY)")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Debit Amount"; REC."Debit Amount")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Credit Amount"; REC."Credit Amount")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Debit Amount (LCY)"; REC."Debit Amount (LCY)")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Credit Amount (LCY)"; REC."Credit Amount (LCY)")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Document Date"; REC."Document Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("External Document No."; REC."External Document No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Accepted Pmt. Disc. Tolerance"; REC."Accepted Pmt. Disc. Tolerance")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Pmt. Tolerance (LCY)"; REC."Pmt. Tolerance (LCY)")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Amount to Apply"; REC."Amount to Apply")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                // field("Folio N° RS"; REC."Folio N° RS")
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                // }
            }
        }
    }

    actions
    {
    }
}

