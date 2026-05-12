report 50183 "Update Materiaux"
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/UpdateMateriaux.rdlc';

    // dataset
    // {
    //     dataitem("Item Ledger Entry"; 32)
    //     {
    //         DataItemTableView = SORTING("Item No.")
    //                             WHERE("Code Nature" = FILTER('A300*'),
    //                                   "Item No." = FILTER(<> '3000010000001'));
    //         RequestFilterFields = Chantier;
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
    //         column(Item_Ledger_Entry__Item_No__; "Item No.")
    //         {
    //         }
    //         column(Item_Ledger_Entry_Description; Description)
    //         {
    //         }
    //         column(InventoryPostingGroup_Description; InventoryPostingGroup.Description)
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
    //         column(Item_Ledger_Entry_Entry_No_; "Entry No.")
    //         {
    //         }

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

    // trigger OnPreReport()
    // begin
    //     IF "Item Ledger Entry".GETFILTER(Chantier) = '' THEN ERROR(Text001);
    // end;

    // var
    //     LastFieldNo: Integer;
    //     FooterPrinted: Boolean;
    //     CorrespondanceRapportDG: Record 50058;
    //     GMarche: Code[20];
    //     Text001: Label 'Choisir Marché';
    //     RecItem: Record 27;
    //     InventoryPostingGroup: Record 94;
    //     Item_Ledger_EntryCaptionLbl: Label 'Écriture comptable article';
    //     CurrReport_PAGENOCaptionLbl: Label 'Page';
    //     ArticleCaptionLbl: Label 'Article';
}

