page 50070 "Alerte  Frequence Changement"
{
    Editable = false;
    PageType = List;
    SourceTable = 32;
    SourceTableView = SORTING("N° Véhicule", "Item No.", "Posting Date") WHERE("Alerte Frequence Changement" = CONST(true));
    UsageCategory = Lists;
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            // group("  ")
            // {
            //     ShowCaption = false;
            //     label("")
            //     {
            //         CaptionClass = '******************************************* ALERTE FREQUENCE CHANGEMENT **************************************************';
            //         Style = Unfavorable;
            //         StyleExpr = TRUE;
            //         ApplicationArea = all;
            //     }
            // }

            repeater("Control1")
            {
                ShowCaption = false;
                field(Materiel; rec.Materiel)
                {
                    Style = Unfavorable;
                    ApplicationArea = all;
                    StyleExpr = TRUE;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    Style = Strong;
                    ApplicationArea = all;
                    StyleExpr = TRUE;
                }
                field("Item No."; rec."Item No.")
                {
                    ApplicationArea = all;
                }
                field("Designation Article"; rec."Designation Article")
                {
                    ApplicationArea = all;
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = all;
                }
                field("Derniere Date Changement"; rec."Derniere Date Changement")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Date Min Changement"; rec."Date Min Changement")
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
            }

        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        rec.SETRANGE("Posting Date", WORKDATE - 7, WORKDATE + 7);
        IF rec.COUNT = 0 THEN CurrPage.CLOSE;
    end;

    var
        Vehicule: Record "Véhicule";
        Text001: Label 'Vidange Effectué ?';
        Text19074609: Label '********************** ALERTE FREQUENCE CHANGEMENT *****************************';
}

