Page 50143 "Fiche Salarié Contrat"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = Employee;
    ApplicationArea = all;
    UsageCategory = Lists;
    Caption = 'Fiche Salarié Contrat';

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
                field("First And Last Name"; REC."First Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Employment Date"; REC."Employment Date")
                {
                    ApplicationArea = all;
                }
                field("Termination Date"; REC."Termination Date")
                {
                    ApplicationArea = all;
                }
                field("date debut contrat"; REC."date debut contrat")
                {
                    ApplicationArea = all;
                }
                field("Social Security No."; REC."Social Security No.")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("N° CIN"; REC."N° Pièce D'identité")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

