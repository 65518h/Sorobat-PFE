Page 50138 "Parametrage Declaration"
{
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Parametre declaration emp";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Parametrage Declaration';

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field(Annexe; REC.Annexe)
                {
                    ApplicationArea = all;
                }
                field(Compte; REC.Compte)
                {
                    ApplicationArea = all;
                }
                field(Taux; REC.Taux)
                {
                    ApplicationArea = all;
                }
                field(Position; REC.Position)
                {
                    ApplicationArea = all;
                }
                field("Compte CGC"; REC."Compte CGC")
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

