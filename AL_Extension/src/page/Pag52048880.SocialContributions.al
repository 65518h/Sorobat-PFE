page 52048880 "Social Contributions"
{
    //GL2024  ID dans Nav 2009 : "39001401"
    Caption = 'Retenues sociales';
    Editable = true;
    PageType = list;
    SourceTable = "Social Contribution";
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Code"; rec."Code")
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
                field("Plafond SBase*8%"; rec."Plafond SBase*8%")
                {
                    ApplicationArea = Basic;
                }
                field(CNSS; rec.CNSS)
                {
                    ApplicationArea = Basic;
                }
                field("Deductible of taxable basis"; rec."Deductible of taxable basis")
                {
                    ApplicationArea = Basic;
                }
                field("Basis of calculation"; rec."Basis of calculation")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        CurrPage.LookupMode := true;
    end;
}

