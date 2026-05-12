page 52048941 "Recorded Social Contribution"
{//GL2024  ID dans Nav 2009 : "39001462"
    Caption = 'Cotisations Sociales Enreg.';
    Editable = false;
    PageType = List;
    SourceTable = "Rec. Social Contributions";
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Control1180250000)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Employee; Rec.Employee)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Employee Posting Group"; Rec."Employee Posting Group")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Indemnity; Rec.Indemnity)
                {
                    ApplicationArea = Basic;
                }
                field("Social Contribution"; Rec."Social Contribution")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
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
                field("Base Amount"; Rec."Base Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Real Amount : Employee"; Rec."Real Amount : Employee")
                {
                    ApplicationArea = Basic;
                }
                field("Real Amount : Employer"; Rec."Real Amount : Employer")
                {
                    ApplicationArea = Basic;
                }
                field("Deductible of taxable basis"; Rec."Deductible of taxable basis")
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

