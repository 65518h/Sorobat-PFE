page 52048901 "Loan & Advance Config."
{
    //GL2024  ID dans Nav 2009 : "39001422"
    Caption = 'Config. des Prêts & Avances';
    PageType = List;
    SourceTable = "Loan & Advance Type";
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Control1180250000)
            {
                ShowCaption = false;
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field("Type par déf"; Rec."Type par déf")
                {
                    ApplicationArea = Basic;
                }
                field("Source Code"; Rec."Source Code")
                {
                    ApplicationArea = Basic;
                }
                field("Avance sur congé"; Rec."Avance sur congé")
                {
                    ApplicationArea = Basic;
                }
                field("Avance sur Prime"; Rec."Avance sur Prime")
                {
                    ApplicationArea = Basic;
                }
                field("Interest %"; Rec."Interest %")
                {
                    ApplicationArea = Basic;
                }
                field("Repayment slices"; Rec."Repayment slices")
                {
                    ApplicationArea = Basic;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Account No."; Rec."Interest Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Bal. Account Type"; Rec."Bal. Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Bal. Account No."; Rec."Bal. Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Imputation Comptable"; Rec."Imputation Comptable")
                {
                    ApplicationArea = Basic;
                }
                field("type amortissement"; Rec."type amortissement")
                {
                    ApplicationArea = Basic;
                }
                field("Precision Arrondi Principale"; Rec."Precision Arrondi Principale")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

