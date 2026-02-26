Page 99994 "UEI - Source Field List"
{
    Caption = 'UEI - Source Field List';
    Editable = false;
    PageType = List;
    SourceTable = "Excel Buffer";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Column No."; rec."Column No.")
                {
                    ApplicationArea = Basic;
                }
                field(xlColID; rec.xlColID)
                {
                    ApplicationArea = Basic;
                }
                field("Cell Value as Text"; rec."Cell Value as Text")
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

