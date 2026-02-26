page 52048900 "Slices of imposition"
{
    //GL2024  ID dans Nav 2009 : "39001421"
    Caption = 'Slices of imposition';
    PageType = list;
    SourceTable = "Slices of imposition";
    ApplicationArea = all;
    UsageCategory = Lists;
    DelayedInsert = true;

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
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field("Lower limit"; Rec."Lower limit")
                {
                    ApplicationArea = Basic;
                }
                field("Superior limit"; Rec."Superior limit")
                {
                    ApplicationArea = Basic;
                }
                field("Slice amount"; Rec."Slice amount")
                {
                    ApplicationArea = Basic;
                }
                field(Rate; Rec.Rate)
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

