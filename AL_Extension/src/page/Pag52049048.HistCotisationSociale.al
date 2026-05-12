page 52049048 "Hist. Cotisation Sociale"
{//GL2024  ID dans Nav 2009 : "39001576"
    PageType = ListPart;
    SourceTable = "Hist. Soc. Contribution";
    Caption = 'Hist. Cotisation Sociale';
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            repeater(Control1102752000)
            {
                ShowCaption = false;
                field("Employment Contract Code"; Rec."Employment Contract Code")
                {
                    ApplicationArea = Basic;
                }
                field("Social Contribution Code"; Rec."Social Contribution Code")
                {
                    ApplicationArea = Basic;
                }
                field("Indemnity Code"; Rec."Indemnity Code")
                {
                    ApplicationArea = Basic;
                }
                field("Employer's part"; Rec."Employer's part")
                {
                    ApplicationArea = Basic;
                }
                field("Employee's part"; Rec."Employee's part")
                {
                    ApplicationArea = Basic;
                }
                field("Basis of calculation"; Rec."Basis of calculation")
                {
                    ApplicationArea = Basic;
                }
                field("Deductible of taxable basis"; Rec."Deductible of taxable basis")
                {
                    ApplicationArea = Basic;
                }
                field("Maximum value - Employee"; Rec."Maximum value - Employee")
                {
                    ApplicationArea = Basic;
                }
                field("Maximum value - Employer"; Rec."Maximum value - Employer")
                {
                    ApplicationArea = Basic;
                }
                field("Mode dévaluation"; Rec."Mode dévaluation")
                {
                    ApplicationArea = Basic;
                }
                field("Forfait salarial"; Rec."Forfait salarial")
                {
                    ApplicationArea = Basic;
                }
                field("Forfait patronal"; Rec."Forfait patronal")
                {
                    ApplicationArea = Basic;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = Basic;
                }
                field("Non inclus en compta"; Rec."Non inclus en compta")
                {
                    ApplicationArea = Basic;
                }
                field("Non Inclus en Prime"; Rec."Non Inclus en Prime")
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

