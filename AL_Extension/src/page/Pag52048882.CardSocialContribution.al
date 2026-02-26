page 52048882 "Card : Social Contribution"
{
    //GL2024  ID dans Nav 2009 : "39001403"
    Caption = 'Fiche Cotisation Sociale';
    PageType = Card;
    SourceTable = "Social Contribution";
    ApplicationArea = all;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Code"; rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Employer's part"; rec."Employer's part")
                {
                    ApplicationArea = Basic;
                }
                field("Employee's part"; rec."Employee's part")
                {
                    ApplicationArea = Basic;
                }
                field("Basis of calculation"; rec."Basis of calculation")
                {
                    ApplicationArea = Basic;
                }
                field("Apply to all Employees"; rec."Apply to all Employees")
                {
                    ApplicationArea = Basic;
                }
                field("Deductible of taxable basis"; rec."Deductible of taxable basis")
                {
                    ApplicationArea = Basic;
                }
            }
            group("G/AL Config.")
            {
                Caption = 'G/AL Config.';
                field("Employee : G/L Account"; rec."Employee : G/L Account")
                {
                    ApplicationArea = Basic;
                }
                field("Employer : G/L Account"; rec."Employer : G/L Account")
                {
                    ApplicationArea = Basic;
                }
                field("Employer : Bal. Account No."; rec."Employer : Bal. Account No.")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Totals)
            {
                Caption = 'Totals';
                field("Payment No. filter"; rec."Payment No. filter")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Posting Grp. filter"; rec."Employee Posting Grp. filter")
                {
                    ApplicationArea = Basic;
                }
                field("Total employee's part"; rec."Total employee's part")
                {
                    ApplicationArea = Basic;
                }
                field("Total employer's part"; rec."Total employer's part")
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

