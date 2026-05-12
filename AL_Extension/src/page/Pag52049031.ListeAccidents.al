Page 52049031 "Liste Accidents"
{//GL2024  ID dans Nav 2009 : "39004693"
    Editable = false;
    PageType = List;
    SourceTable = Accidents;
    ApplicationArea = All;
    Caption = 'Liste Accidents';
    CardPageId = "Fiche Accident";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("N° Accident"; Rec."N° Accident")
                {
                    ApplicationArea = Basic;
                }
                field("Date Accident"; Rec."Date Accident")
                {
                    ApplicationArea = Basic;
                }
                field("N° Mission"; Rec."N° Mission")
                {
                    ApplicationArea = Basic;
                }
                field("N° Véhicule"; Rec."N° Véhicule")
                {
                    ApplicationArea = Basic;
                }
                field("N° Constat"; Rec."N° Constat")
                {
                    ApplicationArea = Basic;
                }
                field("N° Conducteur"; Rec."N° Conducteur")
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

