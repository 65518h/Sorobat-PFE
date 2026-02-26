report 50108 "Recap Beton Par Centrale"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/RecapBetonParCentrale.rdlc';

    dataset
    {
        dataitem("Sales Line"; "Sales Line")
        {
            DataItemTableView = SORTING("Job No.", "No.")
                                WHERE("User ID" = FILTER('D.HANEN|D.RIM|H.NAWRES|A.KHOULOUD|B.SIWAR|S.WAEL'),
                                      "Document Type" = FILTER(Order));
            RequestFilterFields = "Job No.", "No.", "Date Comptabilisation";
            column(PageConst_________FORMAT_CurrReport_PAGENO_; PageConst + ' ' + FORMAT(CurrReport.PAGENO))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(Sales_Line__Sales_Line___Date_Comptabilisation_; "Sales Line"."Date Comptabilisation")
            {
            }
            column(Sales_Line__Job_No__; "Job No.")
            {
            }
            column(Sales_Line__No__; "No.")
            {
            }
            column(Sales_Line__Job_No___Control1000000012; "Job No.")
            {
            }
            column(Sales_Line_Description; Description)
            {
            }
            column(Sales_Line_Quantity; Quantity)
            {
            }
            column(Sales_Line__Date_Comptabilisation_; "Date Comptabilisation")
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
            column(Etat_des_Bons_de_LivraisonCaption; Etat_des_Bons_de_LivraisonCaptionLbl)
            {
            }
            column("Journée_du__Caption"; Journée_du__CaptionLbl)
            {
            }
            column(CentraleCaption; CentraleCaptionLbl)
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

            trigger OnAfterGetRecord()
            begin
                IF SalesHeader.GET("Document Type", "Document No.") THEN;
                IF "Date Comptabilisation" <> SalesHeader."Posting Date" THEN BEGIN
                    "Date Comptabilisation" := SalesHeader."Posting Date";
                    MODIFY;
                END;
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
        SalesHeader: Record 36;
        Etat_des_Bons_de_LivraisonCaptionLbl: Label 'Etat des Bons de Livraison';
        "Journée_du__CaptionLbl": Label 'Journée du :';
        CentraleCaptionLbl: Label 'Centrale';
        ArticleCaptionLbl: Label 'Article';
}

