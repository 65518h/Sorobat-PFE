page 52048895 "Regime of work"
{
    //GL2024  ID dans Nav 2009 : "39001416"
    Caption = 'Regime of work';
    Editable = false;
    PageType = Card;
    SourceTable = "Regimes of work";
    ApplicationArea = all;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Code; rec.Code)
                {
                    ApplicationArea = all;
                }
                field(Désignation; rec.Désignation)
                {
                    ApplicationArea = all;
                }
                field("Work Hours per week"; rec."Work Hours per week")
                {
                    ApplicationArea = all;
                }
                field("Work Hours per month"; rec."Work Hours per month")
                {
                    ApplicationArea = all;
                }
                field("Default Regime"; rec."Default Regime")
                {
                    ApplicationArea = all;
                }
            }
            group("Supp. Hours")
            {
                Caption = 'Supp. Hours';
                field("Max. Supp. Hours per month"; rec."Max. Supp. Hours per month")
                {
                    ApplicationArea = all;
                }
                part("Sub Overcharge Hour cost"; "Sub Overcharge Hour cost")
                {
                    ApplicationArea = all;
                    SubPageLink = "N° Bon" = FIELD(Code);
                }
            }
            group("Days off")
            {
                Caption = 'Days off';
                field("Days off per month"; rec."Days off per month")
                {
                    ApplicationArea = all;
                }
                field("Assignement mode"; rec."Assignement mode")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    var
        RegimeTravail: record "Bon Reglement";
        RegimeTravailTmp: record "Bon Reglement";
}

