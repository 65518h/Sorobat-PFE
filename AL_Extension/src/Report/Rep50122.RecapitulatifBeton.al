report 50122 "Recapitulatif Beton"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/RecapitulatifBeton.rdlc';

    dataset
    {
        dataitem("Sales Line"; "Sales Line")
        {
            DataItemTableView = SORTING("Sell-to Customer No.", "No.")
                                WHERE("User ID" = FILTER('D.HANEN' | 'D.RIM' | 'H.NAWRES' | 'A.KHOULOUD' | 'B.SIWAR' | 'S.WAEL'),
                                      "Document Type" = FILTER(Order));
            RequestFilterFields = "Job No.", "Sell-to Customer No.", "Date Comptabilisation";
            column(PageConst_________FORMAT_CurrReport_PAGENO_; PageConst + ' ' + FORMAT(CurrReport.PAGENO))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(DataItem1000000015; 'Journée Du :   ' + FORMAT(GETRANGEMIN("Date Comptabilisation")) + '  Au :   ' + FORMAT(GETRANGEMAX("Date Comptabilisation")))
            {
            }
            column(NomClien; NomClien)
            {
            }
            column(Sales_Line__No__; "No.")
            {
            }
            column(Sales_Line__Job_No__; "Job No.")
            {
            }
            column(Sales_Line_Description; Description)
            {
            }
            column(Sales_Line_Quantity; Quantity)
            {
            }
            column(Sales_Line_Quantity_Control1000000027; Quantity)
            {
            }
            column(Sales_Line_Description_Control1000000000; Description)
            {
            }
            column(Sales_Line_Quantity_Control1000000029; Quantity)
            {
            }
            column(Total; Total)
            {
            }
            column("Récapitulatif_BetonCaption"; Récapitulatif_BetonCaptionLbl)
            {
            }
            column(ClientCaption; ClientCaptionLbl)
            {
            }
            column(ArticleCaption; ArticleCaptionLbl)
            {
            }
            column(Sales_Line_QuantityCaption; FIELDCAPTION(Quantity))
            {
            }
            column(Sales_Line__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(Sales_Line_Document_Type; "Document Type")
            {
            }
            column(Sales_Line_Document_No_; "Document No.")
            {
            }
            column(Sales_Line_Line_No_; "Line No.")
            {
            }
            column(Sales_Line_Sell_to_Customer_No_; "Sell-to Customer No.")
            {
            }
            trigger OnAfterGetRecord()
            var
            begin

                IF Customer.GET("Sales Line"."Sell-to Customer No.") THEN;
                NomClien := Customer.Name;
                Total := Total + "Sales Line".Quantity;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("No.");
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
        PageConst: Label 'Page';
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        TotalFor: Label 'Total ';
        Total: Decimal;
        Customer: Record 18;
        NomClien: Text[150];
        "Récapitulatif_BetonCaptionLbl": Label 'Récapitulatif Beton';
        ClientCaptionLbl: Label 'Client';
        ArticleCaptionLbl: Label 'Article';
}

