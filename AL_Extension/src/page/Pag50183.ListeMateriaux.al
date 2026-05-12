Page 50183 "Liste Materiaux"
{
    PageType = List;
    SourceTable = Item;
    SourceTableView = where("Code Etude" = filter(<> ' '));
    ApplicationArea = all;
    Caption = 'Liste Materiaux';
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("No."; REC."No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Description; REC.Description)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Base Unit of Measure"; REC."Base Unit of Measure")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Fourniture; REC.Fourniture)
                {
                    ApplicationArea = all;
                }
                field(Transport; REC.Transport)
                {
                    ApplicationArea = all;
                }
                field("% Perte"; REC."% Perte")
                {
                    ApplicationArea = all;
                }
                field(Perte; REC.Perte)
                {
                    ApplicationArea = all;
                }
                field("Cout Materiaux"; REC."Cout Materiaux")
                {
                    ApplicationArea = all;
                }
                field("Unit Cost"; REC."Unit Cost")
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

