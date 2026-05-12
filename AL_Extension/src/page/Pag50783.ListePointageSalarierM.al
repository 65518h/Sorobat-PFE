Page 50783 "Liste Pointage Salarier M"
{//GL2024 NEW PAGE
    PageType = List;
    SourceTable = "Entete Pointage Salarier Man";

    ApplicationArea = all;
    UsageCategory = Lists;
    Caption = 'Liste Pointage Salarier Manuelle';
    CardPageId = "Entete Pointage Salarier MAN";
    Editable = false;
    DeleteAllowed = false;
    ModifyAllowed = False;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;

                field("N°"; Rec."N°")
                {
                    ToolTip = 'Specifies the value of the N° field.', Comment = '%';
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(Mois; Rec.Mois)
                {
                    ToolTip = 'Specifies the value of the Mois field.', Comment = '%';
                }
                field("Année"; Rec."Année")
                {
                    ToolTip = 'Specifies the value of the Année field.', Comment = '%';
                }
                field(Chantier; Rec.Chantier)
                {
                    ToolTip = 'Specifies the value of the Chantier field.', Comment = '%';
                }


            }
        }
    }

}

