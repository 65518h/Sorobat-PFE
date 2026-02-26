
Page 52048958 "Ligne dégats"
{//GL2024  ID dans Nav 2009 : "39004694"
    PageType = List;
    SourceTable = "Dégats Accident";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("N° constat"; Rec."N° constat")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Type Dégat"; Rec."Type Dégat")
                {
                    ApplicationArea = Basic;
                }
                field("Désignation Dégat"; Rec."Désignation Dégat")
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

