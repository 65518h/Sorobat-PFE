report 50045 "Stock Article"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Stock Article.rdlc';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Item Ledger Entry"; 32)
        {
            DataItemTableView = SORTING("Item No.", "Location Code");
            RequestFilterFields = "Item No.", "Location Code", "Posting Date", "Code Nature", "Affectation Marche";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo())
            {
            }
            column(USERID; USERID)
            {
            }
            column(Item_Ledger_Entry_Quantity; Quantity)
            {
            }
            column(Item__No___________Item_Description; ItemDescription)
            {
            }
            column(Item_Ledger_Entry__Location_Code_; "Location Code")
            {
            }
            column(Item__Unit_Cost_; Item."Unit Cost")
            {
            }
            column(Item_Ledger_Entry__Code_Nature_; "Code Nature")
            {
            }
            column(Item_Ledger_Entry__Affectation_Marche_; "Groupe Stock")
            {
            }
            column(Quantity_Item__Unit_Cost_; Quantity * Item."Unit Cost")
            {
            }
            column(Item_Ledger_EntryCaption; Item_Ledger_EntryCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(ArticleCaption; ArticleCaptionLbl)
            {
            }
            column("QuantitéCaption"; QuantitéCaptionLbl)
            {
            }
            column(FamilleCaption; FamilleCaptionLbl)
            {
            }
            column(Grp_StockCaption; Grp_StockCaptionLbl)
            {
            }
            column(MagasinCaption; MagasinCaptionLbl)
            {
            }
            column(Cout_UnitaireCaption; Cout_UnitaireCaptionLbl)
            {
            }
            column(Cout_TotalCaption; Cout_TotalCaptionLbl)
            {
            }
            column(PageLbl; PageLbl)
            {
            }
            column(Item_Ledger_Entry_Entry_No_; "Entry No.")
            {
            }
            column(Item_Ledger_Entry_Item_No_; "Item No.")
            {
            }

            trigger OnPreDataItem()
            var
            begin
                LastFieldNo := FIELDNO("Location Code");
            end;

            trigger OnAfterGetRecord()
            var
            begin
                if Item.Get("Item Ledger Entry"."Item No.") then;
                ItemDescription := Item."No." + ' : ' + Item.Description;

            end;
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
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        TotalFor: Label 'Total ';
        Item: Record 27;
        ItemDescription: Text[1024];
        Item_Ledger_EntryCaptionLbl: Label 'STOCK ARTICLE';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        ArticleCaptionLbl: Label 'Article';
        "QuantitéCaptionLbl": Label 'Quantité';
        FamilleCaptionLbl: Label 'Famille';
        Grp_StockCaptionLbl: Label 'Grp Stock';
        MagasinCaptionLbl: Label 'Magasin';
        Cout_UnitaireCaptionLbl: Label 'Cout Unitaire';
        Cout_TotalCaptionLbl: Label 'Cout Total';
        PageLbl: Label 'Page';
}

