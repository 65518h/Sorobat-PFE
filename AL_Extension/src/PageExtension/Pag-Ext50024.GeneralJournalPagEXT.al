PageExtension 50024 "General Journal_PagEXT" extends "General Journal"
{
    layout
    {
        modify("Debit Amount")
        {
            Visible = true;
        }
        modify(Amount)
        {
            Editable = false;
            Visible = false;
        }
        modify("Bal. Gen. Bus. Posting Group")
        {
            Visible = false;
        }
        modify("Credit Amount")
        {
            Visible = true;
        }
        addafter(Description)
        {


            field("External Document No.1"; Rec."External Document No.")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Job No."; Rec."Job No.")
            {
                ApplicationArea = all;

            }
            field("Job Task No."; Rec."Job Task No.")
            {
                ApplicationArea = all;
            }
        }
        modify("VAT Reporting Date")
        {
            Visible = false;
        }
        /*GL2024 addafter("Account No.")
        {

        }*/
        modify("Document Type")
        {
            Visible = false;
        }
        modify("Document No.")
        {
            Editable = true;
        }
        modify("Account Type")
        {
            Visible = true;
        }
        modify("Account No.")
        {
            Visible = true;
        }
        modify("Bal. Account Type")
        {
            Visible = false;
        }
        modify("EU 3-Party Trade")
        {
            Visible = false;
        }
        modify("Gen. Posting Type")
        {
            Visible = false;
        }
        modify("Gen. Bus. Posting Group")
        {
            Visible = false;
        }
        modify("Gen. Prod. Posting Group")
        {
            Visible = false;
        }
        modify("VAT Bus. Posting Group")
        {
            Visible = false;
        }
        modify("VAT Prod. Posting Group")
        {
            Visible = false;
        }
        modify(AccountName)
        {
            Visible = false;

        }
        modify("Bal. Gen. Prod. Posting Group")
        {
            Visible = false;
        }
        modify(Correction)
        {
            Visible = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }
        modify(Comment)
        {
            Visible = false;
        }
        modify("Deferral Code")
        {
            Visible = false;
        }
        modify("Job Queue Status")
        {
            Visible = false;
        }
        modify("Allocation Account No.")
        {
            Visible = false;
        }

        modify("Bal. Gen. Posting Type")
        {
            visible = false;
        }
        modify(GenJnlLineApprovalStatus)
        {
            Visible = false;
        }
        modify("Currency Code")
        {
            Visible = false;
        }
        modify("Amount (LCY)")
        {
            Visible = false;
        }
        modify(ShortcutDimCode3)
        {
            Visible = false;
        }
        modify(ShortcutDimCode4)
        {
            Visible = false;
        }
        modify(ShortcutDimCode5)
        {
            Visible = false;
        }
        modify(ShortcutDimCode6)
        {
            Visible = false;
        }
        modify(ShortcutDimCode7)
        {
            Visible = false;
        }
        modify(ShortcutDimCode8)
        {
            Visible = false;
        }

        addafter("Posting Date")
        {
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = all;
                Visible = FALSE;
                Editable = false;
            }
        }
        addafter("Account Type")
        {
            field("FA Posting Type"; Rec."FA Posting Type")
            {
                Visible = FALSE;
                ApplicationArea = all;
            }
            field(Lettre; Rec.Lettre)
            {
                Visible = FALSE;
                ApplicationArea = all;
            }
            field("Date Echeance"; Rec."Date Echeance")
            {
                Visible = FALSE;
                ApplicationArea = all;
            }
        }

        addafter("Reason Code")
        {
            field("Source Type"; Rec."Source Type")
            {
                ApplicationArea = all;


            }
            field("Source No."; Rec."Source No.")
            {
                ApplicationArea = all;


            }
            field(Salarie; Rec.Salarie)
            {
                ApplicationArea = all;
                Visible = FALSE;
            }
        }

    }
    actions
    {
        addafter(Dimensions)
        {
            action("Ecritures abonnement")
            {
                Caption = 'Ecritures abonnement';
                ApplicationArea = all;
                trigger OnAction()
                VAR
                    lGLEntry: Record "G/L Entry";
                BEGIN
                    rec.TESTFIELD("Subscription Entry No.");
                    lGLEntry.SETCURRENTKEY("Subscription Entry No.");
                    lGLEntry.SETRANGE("Subscription Entry No.", rec."Subscription Entry No.");
                    lGLEntry.SETRANGE("G/L Account No.", rec."Account No.");
                    PAGE.RUN(PAGE::"General Ledger Entries", lGLEntry);

                end;
            }
        }
        addafter("-")
        {
            action("Import")
            {
                Caption = 'Importer';
                ApplicationArea = all;
                Visible = false;
                trigger OnAction()
                VAR
                    lImport: Record Import;
                BEGIN
                    lImport.ImportJournal(DATABASE::"Gen. Journal Line", 1, rec."Journal Template Name", 51, rec."Journal Batch Name");
                END;
            }

        }
        addafter("Renumber Document Numbers_Promoted")
        {
            actionref("Import1"; "Import")
            {

            }
        }
        addafter(Dimensions_Promoted)
        {
            actionref("Ecritures abonnement1"; "Ecritures abonnement")
            {

            }
        }


        //DYS addafter("SaveAsStandardJournal")
        //DYS{
        //DYS action("Propose Subscription")
        //DYS {
        //DYS Caption = 'Propose Subscription';
        //DYSApplicationArea = all;
        //DYS trigger OnAction()
        //DYS VAR
        //DYS REPORT addon non migrer
        //ProposeAccountSub: Report 8001908;
        //DYS BEGIN
        //DYS
        // ProposeAccountSub.InitializeReport(rec."Journal Template Name", rec."Journal Batch Name");
        // ProposeAccountSub.RUNMODAL;
        // CLEAR(ProposeAccountSub);

        //DYS end;
        //DYS}
        //DYS}

    }
}



