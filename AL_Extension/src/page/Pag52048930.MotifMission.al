
page 52048930 "Motif Mission"
{
    //GL2024  ID dans Nav 2009 : "39001498"
    PageType = List;
    SourceTable = "Motif Mission";
    ApplicationArea = all;
    UsageCategory = Lists;
    Caption = 'Motif Mission';
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Code Motif"; Rec."Code Motif")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Type; Rec.Type)
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

