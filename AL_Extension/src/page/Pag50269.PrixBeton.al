Page 50269 "Prix Beton"
{
    PageType = List;
    SourceTable = "Temp beton Prix";
    ApplicationArea = all;
    Caption = 'Prix Beton';
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
                }
                field("Prix Reelle"; REC."Prix Reelle")
                {
                    ApplicationArea = all;
                }
                field(Designation; REC.Designation)
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

