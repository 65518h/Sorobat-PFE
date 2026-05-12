page 50356 "Liste des Paies STC"
{
    //GL2024 NEW PAGE
    Caption = 'Liste des Paies STC';
    Editable = false;
    PageType = List;
    SourceTable = "Salary Headers";
    //ABZ ApplicationArea = all;
    UsageCategory = Lists;
    // SourceTableView = WHERE(STC = CONST(true));
    // CardPageId = "Calculation of  STC";
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

    trigger OnInit()
    begin
        CurrPage.LookupMode := true;
    end;
}

