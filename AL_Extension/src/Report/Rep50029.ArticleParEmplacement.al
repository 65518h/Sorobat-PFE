report 50029 "Article Par Emplacement"
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/ArticleParEmplacement.rdlc';

    // dataset
    // {
    //     dataitem(DataItem7209; 32)
    //     {
    //         DataItemTableView = SORTING(Emplacement, "Item No.");
    //         RequestFilterFields = Emplacement, "Item No.", "Location Code";
    //         column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
    //         {
    //         }
    //         column(COMPANYNAME; COMPANYNAME)
    //         {
    //         }
    //         column(CurrReport_PAGENO; CurrReport.PAGENO)
    //         {
    //         }
    //         column(USERID; USERID)
    //         {
    //         }
    //         column(Item_Ledger_Entry_Emplacement; Emplacement)
    //         {
    //         }
    //         column(Item_Ledger_Entry_Quantity; Quantity)
    //         {
    //         }
    //         column(Item___No_____________Item_Description; Item."No." + '    ' + Item.Description)
    //         {
    //         }
    //         column(Item_Ledger_EntryCaption; Item_Ledger_EntryCaptionLbl)
    //         {
    //         }
    //         column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
    //         {
    //         }
    //         column(ArticleCaption; ArticleCaptionLbl)
    //         {
    //         }
    //         column("QuantitéCaption"; QuantitéCaptionLbl)
    //         {
    //         }
    //         column(Item_Ledger_Entry_EmplacementCaption; FIELDCAPTION(Emplacement))
    //         {
    //         }
    //         column(Item_Ledger_Entry_Entry_No_; "Entry No.")
    //         {
    //         }
    //         column(Item_Ledger_Entry_Item_No_; "Item No.")
    //         {
    //         }
    //         trigger OnAfterGetRecord()
    //         begin

    //             //  CurrReport.SHOWOUTPUT :=CurrReport.TOTALSCAUSEDBY = "Item Ledger Entry".FIELDNO("Item No.");
    //             IF Item.GET("Item No.") THEN;

    //         end;

    //         trigger OnPreDataItem()
    //         begin
    //             LastFieldNo := FIELDNO("Item No.");
    //         end;
    //     }
    // }

    // requestpage
    // {

    //     layout
    //     {
    //     }

    //     actions
    //     {
    //     }
    // }

    // labels
    // {
    // }

    // var
    //     LastFieldNo: Integer;
    //     FooterPrinted: Boolean;
    //     TotalFor: Label 'Total ';
    //     Item: Record 27;
    //     ItemLedgerEntry: Record 32;
    //     Item_Ledger_EntryCaptionLbl: Label 'Écriture comptable article';
    //     CurrReport_PAGENOCaptionLbl: Label 'Page';
    //     ArticleCaptionLbl: Label 'Article';
    //     "QuantitéCaptionLbl": Label 'Quantité';
}

