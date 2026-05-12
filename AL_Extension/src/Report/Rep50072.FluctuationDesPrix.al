report 50072 "Fluctuation Des Prix"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/FluctuationDesPrix.rdlc';

    dataset
    {
        dataitem("Purch. Inv. Line"; 123)
        {
            DataItemTableView = SORTING("No.", "Posting Date")
                                WHERE("Direct Unit Cost" = FILTER(<> 0),
                                      Quantity = FILTER(<> 0),
                                      Type = CONST(Item));
            RequestFilterFields = "No.", Description, "Posting Date";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }

            column(USERID; USERID)
            {
            }
            column(No_____________Description; "No." + ' - : ' + Description)
            {
            }
            column(Purch__Inv__Line__Direct_Unit_Cost_; "Direct Unit Cost")
            {
            }
            column(Purch__Inv__Line__Posting_Date_; "Posting Date")
            {
            }
            column(Purch__Inv__Line__Document_No__; "Document No.")
            {
            }
            column(Vendor_Name; Vendor.Name)
            {
            }
            column(Purch__Inv__Line_Quantity; Quantity)
            {
            }
            column(Purch__Rcpt__LineCaption; Purch__Rcpt__LineCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(ArticleCaption; ArticleCaptionLbl)
            {
            }
            column(PrixCaption; PrixCaptionLbl)
            {
            }
            column(DateCaption; DateCaptionLbl)
            {
            }
            column(N__DocumentCaption; N__DocumentCaptionLbl)
            {
            }
            column(FournisseurCaption; FournisseurCaptionLbl)
            {
            }
            column("QuantitéCaption"; QuantitéCaptionLbl)
            {
            }
            column(Purch__Inv__Line_Line_No_; "Line No.")
            {
            }
            column(Purch__Inv__Line_No_; "No.")
            {
            }
            trigger OnAfterGetRecord()
            var
                VarShowOutPut: Boolean;
            begin




                IF NewPrix = 0 THEN BEGIN
                    NewPrix := "Direct Unit Cost";
                    OLdPrix := NewPrix;
                END
                ELSE
                    NewPrix := "Direct Unit Cost";
                if NewPrix = OLdPrix then
                    CurrReport.Skip();

                OLdPrix := NewPrix;
                IF Vendor.GET("Purch. Inv. Line"."Buy-from Vendor No.") THEN;
            end;

            trigger OnPreDataItem()
            begin

                // IF NOT FooterPrinted THEN
                //     LastFieldNo := CurrReport.TOTALSCAUSEDBY;
                // CurrReport.SHOWOUTPUT := NOT FooterPrinted;
                // FooterPrinted := TRUE;
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
        Prix: Decimal;
        OLdPrix: Decimal;
        NewPrix: Decimal;
        Vendor: Record 23;
        Purch__Rcpt__LineCaptionLbl: Label 'SUIVI FLUCTUATION DES PRIX';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        ArticleCaptionLbl: Label 'Article';
        PrixCaptionLbl: Label 'Prix';
        DateCaptionLbl: Label 'Date';
        N__DocumentCaptionLbl: Label 'N° Document';
        FournisseurCaptionLbl: Label 'Fournisseur';
        "QuantitéCaptionLbl": Label 'Quantité';
}

