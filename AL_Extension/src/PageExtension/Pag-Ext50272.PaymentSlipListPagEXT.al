PageExtension 50272 "Payment Slip List_PagEXT" extends "Payment Slip List"
{
    layout
    {
        addafter("No.")
        {
            field("N° Brouillard"; Rec."N° Brouillard")
            {
                ApplicationArea = all;
            }
            field("N° Contrat"; Rec."N° Contrat")
            {
                ApplicationArea = all;
            }
            field("Document Date"; Rec."Document Date")
            {
                ApplicationArea = all;
            }
        }
        addafter("Currency Code")
        {
            field("Type paiement"; Rec."Type paiement")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field(Utilisateur; Rec.Utilisateur)
            {
                ApplicationArea = all;
            }
            field("Validé Par"; Rec."Validé Par")
            {
                ApplicationArea = all;
                Visible = false;
            }
        }

        addafter("Posting Date")
        {
            field("Account No."; Rec."Account No.")
            {
                ApplicationArea = all;
            }
            field("Amount (LCY)"; Rec."Amount (LCY)")
            {
                ApplicationArea = all;
            }
            // field(Affectation; Rec.Affectation)
            // {
            //     ApplicationArea = all;
            // }
            field(Amount; Rec.Amount)
            {
                ApplicationArea = all;
            }
            field(Agence; Rec.Agence)
            {
                ApplicationArea = all;
            }
            field("Account Type"; Rec."Account Type")
            {
                ApplicationArea = all;
            }
        }
        addafter("Status Name")
        {
            field("Bénéficiaire"; Rec."Bénéficiaire")
            {
                ApplicationArea = all;
            }
        }
        // addafter(Control1)
        // {
        //     part("Payment Slip Subform 3"; "Payment Slip Subform 3")
        //     {//Page 50068
        //         Caption = 'Sous-formulaire bordereau paiement';

        //         SubPageLink = "No." = FIELD("No.");
        //         ApplicationArea = all;

        //     }
        // }
    }

    actions
    {
        /*GL2024 addafter("Create Payment Slip")
         {
             action("Create Payment Slip2")
             {
                 ApplicationArea = Basic, Suite;
                 Caption = 'Create Payment Slip';
                 Image = NewDocument;
                 RunObject = Codeunit "Payment Management Copy";
                 ToolTip = 'Manage information about customer and vendor payments.';
             }
         }*/
    }
    trigger OnOpenPage()
    begin
        // >> HJ DSFT 04-10-2012
        //GetABK;
        // >> HJ DSFT 04-10-2012
    end;

    trigger OnAfterGetRecord()
    begin
        // >> HJ DSFT 04-10-2012
        //GetABK;
        // >> HJ DSFT 04-10-2012

    end;

    PROCEDURE GetABK();
    VAR
        RecLUserSetup: Record "User Setup";
    BEGIN
        // >> HJ DSFT 04-10-2012
        IF RecLUserSetup.GET(UPPERCASE(USERID)) THEN;
        rec.CALCFIELDS(Valider);
        IF NOT RecLUserSetup."Compte EX" THEN rec.SETRANGE(Valider, FALSE);
        // >> HJ DSFT 04-10-2012
    END;
}