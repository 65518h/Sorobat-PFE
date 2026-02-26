Page 50256 "Indémnité Enregistré"
{
    Editable = false;
    PageType = List;
    SourceTable = "Rec. Indemnities";
    ApplicationArea = all;
    Caption = 'Indémnité Enregistré';
    UsageCategory = Lists;
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
                }
                field("Employee No."; REC."Employee No.")
                {
                    ApplicationArea = all;
                }
                field("Année"; REC.Année)
                {
                    ApplicationArea = all;
                }
                field(Indemnity; REC.Indemnity)
                {
                    ApplicationArea = all;
                }
                field(Description; REC.Description)
                {
                    ApplicationArea = all;
                }
                field(Type; REC.Type)
                {
                    ApplicationArea = all;
                }
                field("Base Amount"; REC."Base Amount")
                {
                    ApplicationArea = all;
                }
                field("Real Amount"; REC."Real Amount")
                {
                    ApplicationArea = all;
                }
                field("Real Amount PR"; REC."Real Amount PR")
                {
                    ApplicationArea = all;
                }
                field(direction; REC.direction)
                {
                    ApplicationArea = all;
                }
                field(service; REC.service)
                {
                    ApplicationArea = all;
                }
                field(section; REC.section)
                {
                    ApplicationArea = all;
                }
                field("Nombre de jours"; REC."Nombre de jours")
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

