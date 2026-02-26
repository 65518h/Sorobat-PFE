Page 50079 "Frais Validés"
{
    PageType = listPart;
    SourceTable = "Value Entry";
    SourceTableView = where("Item Charge No." = filter(<> ''));
    Caption = 'Frais Validés';
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                Editable = false;
                field("Item Charge No."; rec."Item Charge No.")
                {
                    ApplicationArea = all;
                }
                field("Cost per Unit"; rec."Cost per Unit")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

