
page 50325 "Liste de Règlement"
{//GL2024 New page
    ApplicationArea = all;
    Caption = 'Liste de Règlement';
    // CardPageID = "Payment Slip 2";
    Editable = false;
    PageType = List;
    SourceTable = "Payment Header";
    UsageCategory = Lists;


    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the payment header.';
                }
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
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the currency code to be used on the payment lines.';
                }
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
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the date when the payment slip should be posted.';
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = all;
                }
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

                field("Payment Class"; Rec."Payment Class")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the payment class used when creating this payment slip.';
                }
                field("Status Name"; Rec."Status Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the status the payment is in.';
                }
                field("Bénéficiaire"; Rec."Bénéficiaire")
                {
                    ApplicationArea = all;
                }
            }
        }
    }


    /*GL2024
        trigger OnOpenPage()
        var
            FeatureTelemetry: Codeunit "Feature Telemetry";
            FRPaymentSlipTok: Label 'FR Create Payment Slips', Locked = true;
        begin
            FeatureTelemetry.LogUptake('1000HP0', FRPaymentSlipTok, Enum::"Feature Uptake Status"::Discovered);
        end;*/
}

