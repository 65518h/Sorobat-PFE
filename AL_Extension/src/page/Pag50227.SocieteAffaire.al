Page 50227 "Societe Affaire"
{
    PageType = List;
    SourceTable = "Entete rapport DG";
    ApplicationArea = all;
    Caption = 'Societe Affaire';
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                Editable = false;
                ShowCaption = false;
                field("N° Rapport"; REC."N° Rapport")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field(Description; REC.Description)
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

