report 50284 "Stock Mort 6 Mois"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/StockMort6Mois.rdlc';

    dataset
    {
        dataitem(DataItem8129; 27)
        {
            column(Item__No__; "No.")
            {
            }
            column(Item_Description; Description)
            {
            }
            column(ItemLedgerEntry__Posting_Date_; ItemLedgerEntry."Posting Date")
            {
            }
            column(LISTE_STOCK_MORT_A_SIX_MOISCaption; LISTE_STOCK_MORT_A_SIX_MOISCaptionLbl)
            {
            }
            column(Item__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(Item_DescriptionCaption; FIELDCAPTION(Description))
            {
            }
            column(Dernier_Date_MouvementCaption; Dernier_Date_MouvementCaptionLbl)
            {
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        ItemLedgerEntry: Record 32;
        LISTE_STOCK_MORT_A_SIX_MOISCaptionLbl: Label 'LISTE STOCK MORT A SIX MOIS';
        Dernier_Date_MouvementCaptionLbl: Label 'Dernier Date Mouvement';
}

