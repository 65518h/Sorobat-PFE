Page 50016 "Liste Article Filtré"
{
    PageType = List;
    SourceTable = Item;
    Caption = 'Liste Article Filtré';
    ApplicationArea = all;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                Editable = false;
                ShowCaption = false;
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = true;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Base Unit of Measure"; rec."Base Unit of Measure")
                {
                    ApplicationArea = all;
                }
                field(Inventory; rec.Inventory)
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = true;
                }
                // field("Emplacement DEPOT Z4"; rec."Emplacement DEPOT Z4")
                // {
                //     ApplicationArea = all;
                // }
                field("Tree Code"; rec."Tree Code")
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

