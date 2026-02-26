page 52048936 "Social Contribution"
{
    //GL2024  ID dans Nav 2009 : "39001457"
    Caption = 'Social Contribution';
    PageType = List;
    SourceTable = "Social Contributions";
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Control1180250000)
            {
                ShowCaption = false;
                field("Social Contribution"; Rec."Social Contribution")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Real Amount : Employee"; Rec."Real Amount : Employee")
                {
                    ApplicationArea = Basic;
                    DecimalPlaces = 3 : 3;
                }
                field("Real Amount : Employer"; Rec."Real Amount : Employer")
                {
                    ApplicationArea = Basic;
                    DecimalPlaces = 3 : 3;
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

