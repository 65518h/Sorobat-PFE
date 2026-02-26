report 50086 "Article Par Magasins"
{
    DefaultLayout = RDLC;
    RDLCLayout = './layouts/ArticleParMagasins.rdlc';

    dataset
    {
        dataitem(DataItem7209; "Item Ledger Entry")
        {

            DataItemTableView = SORTING("Location Code", "Item No.");
            RequestFilterFields = "Location Code", "Item No.", "Code Nature";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(USERID; USERID)
            {
            }
            column(Item_Ledger_Entry__Location_Code_; "Location Code")
            {
            }
            column(Item__No______________Item_Description; Item."No." + '  -  ' + Item.Description)
            {
            }
            column(Item_Ledger_Entry_Quantity; Quantity)
            {
            }
            column(Item__Last_Direct_Cost__Quantity; Item."Last Direct Cost" * Quantity)
            {
                DecimalPlaces = 3 : 3;
            }
            column(Item__Last_Direct_Cost_; Item."Last Direct Cost")
            {
                DecimalPlaces = 3 : 3;
            }
            column(Item_Ledger_EntryCaption; Item_Ledger_EntryCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column("QuantitéCaption"; QuantitéCaptionLbl)
            {
            }
            column(ArticleCaption; ArticleCaptionLbl)
            {
            }
            column(EmplacementCaption; EmplacementCaptionLbl)
            {
            }
            column(Val_StockCaption; Val_StockCaptionLbl)
            {
            }
            column(DPACaption; DPACaptionLbl)
            {
            }
            column(Item_Ledger_Entry__Location_Code_Caption; FIELDCAPTION("Location Code"))
            {
            }
            column(Item_Ledger_Entry_Entry_No_; "Entry No.")
            {
            }
            column(Item_Ledger_Entry_Item_No_; "Item No.")
            {
            }
            trigger OnAfterGetRecord();
            begin


                IF Item.GET("Item No.") THEN;
                CurrReport.SHOWOUTPUT(Quantity <> 0);
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("Item No.");
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
        Item: Record "item";
        ValStock: Decimal;
        Item_Ledger_EntryCaptionLbl: Label 'Item Ledger Entry';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        "QuantitéCaptionLbl": Label 'Quantité';
        ArticleCaptionLbl: Label 'Article';
        EmplacementCaptionLbl: Label 'Emplacement';
        Val_StockCaptionLbl: Label 'Val Stock';
        DPACaptionLbl: Label 'DPA';
}

