page 50748 "CueFacturation"
{
    caption = 'Factures Achat';
    PageType = CardPart;
    SourceTable = "Table cue";

    layout
    {
        area(Content)
        {
            cuegroup("Factures Achat")
            {
                // CueGroupLayout = Wide;
                // ShowCaption = false;
                Caption = 'Factures Achat';
                field("Nbr Factures achat"; REC."Nbr Factures achat")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Nbr Factures achat';
                    ToolTip = 'Nbr Factures achat', Comment = '%';
                    DrillDownPageId = "Purchase Invoices";
                    Image = None;
                    StyleExpr = true;
                    style = Favorable;
                }
                field("Nbr Facture achat enregistrée"; REC."Nbr Facture achat enregistrée")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Nbr Facture achat enregistrée';
                    ToolTip = 'Nbr Facture achat enregistrée', Comment = '%';
                    DrillDownPageId = "Posted Purchase Invoices";
                    Image = None;
                    StyleExpr = true;
                    style = Favorable;
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        rec.RESET();
        IF NOT rec.GET THEN BEGIN
            rec.INIT();
            rec.INSERT();
        END;
    end;

    var
        myInt: Integer;
}
