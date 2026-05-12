Page 52049074 "Liste taxe"
{//GL2024  ID dans Nav 2009 : "39004714"
    Editable = false;
    PageType = List;
    SourceTable = Taxe;
    ApplicationArea = All;
    Caption = 'Liste taxe';
    UsageCategory = Lists;
    CardPageId = Taxe;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("N° Véhicule"; Rec."N° Véhicule")
                {
                    ApplicationArea = Basic;
                }
                field("Date Document"; Rec."Date Document")
                {
                    ApplicationArea = Basic;
                }
                field("Date fin Validité"; Rec."Date fin Validité")
                {
                    ApplicationArea = Basic;
                }
                field(Montant; Rec.Montant)
                {
                    ApplicationArea = Basic;
                }
                field(Valider; Rec.Valider)
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

