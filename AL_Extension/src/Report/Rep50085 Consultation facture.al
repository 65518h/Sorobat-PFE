report 50085 "CONSULTATION FACTURE"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/CONSULTATIONFACTURE.rdl';

    dataset
    {
        dataitem("Purchase Line"; "Purchase Line")
        {
            DataItemTableView = SORTING(Description, "Job No.")
                                WHERE("Document Type" = CONST(Invoice),
                                      Type = FILTER(<> "G/L Account"),
                                      Type = FILTER(<> ' '),
                                      Description = FILTER(<> 'FODEC'));
            RequestFilterFields = "Document No.", Description, "Job No.";
            column(TotalTTC; TotalTTC)
            {
                DecimalPlaces = 3 : 3;
            }
            column(DateFacture; DateFacture)
            {
            }
            column(Purchase_Line__Document_No__; "Document No.")
            {
            }
            column(NomFournisseur; NomFournisseur)
            {
            }
            column(PageConst_________FORMAT_CurrReport_PAGENO_; PageConst + ' ' + FORMAT(CurrReport.PAGENO))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(Purchase_Line_Description; Description)
            {
            }
            column(Purchase_Line__Unit_of_Measure_; "Unit of Measure")
            {
            }
            column(FORMAT_TotalQ_; FORMAT(TotalQ))
            {
            }
            column(FORMAT_Total_; FORMAT(Total))
            {
            }
            column(Purchase_Line__Amount_Including_VAT_; "Amount Including VAT")
            {
            }
            column(Purchase_Line_Quantity; Quantity)
            {
            }
            column(Purchase_Line__Job_No__; "DYSJob No.")
            {
            }
            column(Total_TTC__Caption; Total_TTC__CaptionLbl)
            {
            }
            column(Date__Caption; Date__CaptionLbl)
            {
            }
            column(Facture_N___Caption; Facture_N___CaptionLbl)
            {
            }
            column(Fournisseur__Caption; Fournisseur__CaptionLbl)
            {
            }
            column(Consultation_FactureCaption; Consultation_FactureCaptionLbl)
            {
            }
            column("Unité__Caption"; Unité__CaptionLbl)
            {
            }
            column(Cumul__Caption; Cumul__CaptionLbl)
            {
            }
            column(Montant__Caption; Montant__CaptionLbl)
            {
            }
            column("Qté__Caption"; Qté__CaptionLbl)
            {
            }
            column(Purchase_Line_Document_Type; "Document Type")
            {
            }
            column(Purchase_Line_Line_No_; "Line No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                TotalTTC := 0;
                Total := 0;
                TotalQ := 0;
                if "Purchase Line".Type = "Purchase Line".Type::"G/L Account" then
                    CurrReport.Skip();
                LastFieldNo := FIELDNO("Job No.");

                TotalTTC := 0;
                IF Fournisseur.GET("Purchase Line"."Buy-from Vendor No.") THEN;
                NomFournisseur := Fournisseur.Name;
                //*******
                PurchaseHeader.RESET;
                PurchaseHeader.SETRANGE(PurchaseHeader."No.", "Purchase Line"."Document No.");
                IF PurchaseHeader.FINDFIRST THEN
                    DateFacture := PurchaseHeader."Posting Date";

                RecLine.RESET;
                RecLine.SETRANGE(RecLine."Document No.", "Purchase Line"."Document No.");
                IF RecLine.FINDFIRST THEN
                    REPEAT
                        TotalTTC := TotalTTC + RecLine."Amount Including VAT";
                    UNTIL RecLine.NEXT = 0;
                ////////////////////////////////////

                // CurrReport.SHOWOUTPUT := CurrReport.TOTALSCAUSEDBY = "Purchase Line".FIELDNO(Description);
                //       IF "Purchase Line".Type = 1 THEN CurrReport.SHOWOUTPUT(FALSE);
                RecLine.RESET;
                RecLine.SETRANGE(RecLine."Document No.", "Purchase Line"."Document No.");
                RecLine.SETRANGE(RecLine.Description, "Purchase Line".Description);
                IF RecLine.FINDFIRST THEN
                    REPEAT
                        Total := Total + RecLine."Amount Including VAT";
                        TotalQ := TotalQ + RecLine.Quantity;
                    UNTIL RecLine.NEXT = 0;
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
        Fournisseur: Record 23;
        NomFournisseur: Text[150];
        PurchaseHeader: Record 38;
        DateFacture: Date;
        TotalTTC: Decimal;
        RecLine: Record 39;
        cumul: Decimal;
        Total: Decimal;
        TotalQ: Decimal;
        Total_TTC__CaptionLbl: Label 'Total TTC :';
        Date__CaptionLbl: Label 'Date :';
        Facture_N___CaptionLbl: Label 'Facture N° :';
        Fournisseur__CaptionLbl: Label 'Fournisseur :';
        Consultation_FactureCaptionLbl: Label 'Consultation Facture';
        "Unité__CaptionLbl": Label 'Unité :';
        Cumul__CaptionLbl: Label 'Cumul :';
        Montant__CaptionLbl: Label 'Montant :';
        "Qté__CaptionLbl": Label 'Qté :';
}

