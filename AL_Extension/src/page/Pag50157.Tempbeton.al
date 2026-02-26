Page 50157 "Temp beton"
{
    PageType = List;
    SourceTable = "Temp Beton";
    ApplicationArea = all;
    Caption = 'Temp beton';
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field(CodeBeton; REC.CodeBeton)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Designation; REC.Designation)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Prix; REC.Prix)
                {
                    ApplicationArea = all;
                }
                field("Prix Reelle"; REC."Prix Reelle")
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

