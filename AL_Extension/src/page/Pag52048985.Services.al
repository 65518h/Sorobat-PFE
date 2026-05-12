page 52048985 Services
{//GL2024  ID dans Nav 2009 : "39001512"
    Editable = true;
    PageType = List;
    SourceTable = Service;
    ApplicationArea = all;
    UsageCategory = Lists;
    Caption = 'Services';
    layout
    {
        area(content)
        {
            repeater(Control1120000)
            {
                ShowCaption = false;
                field(Service; Rec.Service)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Direction; Rec.Direction)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

