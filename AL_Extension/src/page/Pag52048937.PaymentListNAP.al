page 52048937 "Payment List NAP"
{
    //GL2024  ID dans Nav 2009 : "39001458"
    Caption = 'Liste des Paies';
    Editable = false;
    PageType = List;
    SourceTable = "Salary Headers";
    //ABZApplicationArea = all;
    UsageCategory = Lists;
    CardPageId = "Calculation of salaries";
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
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Month; Rec.Month)
                {
                    ApplicationArea = Basic;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
    trigger OnOpenPage()
    var
        RecUserSetup: Record "User Setup";
    begin

        // Rec.FilterGroup(0);
        // Rec.SetRange(stc, false);
        // Rec.FilterGroup(2);
    end;

    trigger OnInit()
    begin
        CurrPage.LookupMode := true;
    end;
}

