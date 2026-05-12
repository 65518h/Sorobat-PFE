Page 52049032 pannes
{//GL2024  ID dans Nav 2009 : "39004696"
    DelayedInsert = true;
    PageType = List;
    SourceTable = Pannes;
    ApplicationArea = All;
    Caption = 'pannes';
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Code reparation"; Rec."Code reparation")
                {
                    ApplicationArea = Basic;
                    Caption = 'Code Réparation';
                }
                field("Désignation"; Rec.Désignation)
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

