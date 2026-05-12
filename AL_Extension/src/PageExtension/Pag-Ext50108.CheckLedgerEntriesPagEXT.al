PageExtension 50108 "Check Ledger Entries_PagEXT" extends "Check Ledger Entries"
{

    layout
    {
        addafter("Bal. Account No.")
        {
            field("Bal. Bank Account No."; REC."Bal. Bank Account No.")
            {
                ApplicationArea = all;
                Visible = false;
            }
        }
    }
    actions
    {
        modify("Void Check")
        {
            Visible = false;
        }
        addafter("Void Check_Promoted")
        {
            actionref("Void Check21"; "Void Check2")
            {

            }
            actionref("Avis de virement1"; "Avis de virement")
            {

            }
        }
        addafter("Void Check")
        {
            action("Void Check2")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Void Check';
                Image = VoidCheck;
                ToolTip = 'Void the check if, for example, the check is not cashed by the bank.';

                trigger OnAction()
                var
                    CheckManagement: Codeunit CheckManagement;
                begin
                    //PMT
                    IF CONFIRM(Text000, FALSE, rec."Check No.", rec."Bal. Account Type", rec."Bal. Account No.")
                    THEN
                        //PMT//
                        CheckManagement.FinancialVoidCheck(Rec);
                end;
            }

            action("Avis de virement")
            {
                ApplicationArea = all;
                Caption = 'Transfer Detail';

                trigger OnAction()
                var
                    //DYS report addon non migrer;
                    //  lAvis: Report 8004109;
                    lVendor: Record Vendor;
                begin

                    //DYS
                    //lAvis.InitRequest(rec."Bank Account Ledger Entry No.", 0);
                    if rec."Bal. Account Type" = rec."bal. account type"::Vendor then
                        lVendor.SetRange("No.", rec."Bal. Account No.");
                    //DYS
                    // lAvis.SetTableview(lVendor);
                    // lAvis.RunModal;
                end;
            }
        }
    }

    var
        Text000: label 'Financially void check %1 to %2 %3';
}

