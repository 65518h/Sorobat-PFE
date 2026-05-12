report 50040 "Suivi Factures Fournisseurs"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/SuiviFacturesFournisseurs.rdlc';
    Caption = 'Suivi Factures Fournisseurs';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Vendor; 23)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(Vendor__No__; "No.")
            {
            }
            column(Vendor_Name; Name)
            {
            }
            column(Vendor__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(Vendor_NameCaption; FIELDCAPTION(Name))
            {
            }
            column(Purch__Inv__Header__Amount_Including_VAT_Caption; "Purch. Inv. Header".FIELDCAPTION("Amount Including VAT"))
            {
            }
            column(Purch__Inv__Header__Statut_Facture_Caption; "Purch. Inv. Header".FIELDCAPTION("Statut Facture"))
            {
            }
            column(ETAT_DE_SUIVI_DES_FACTURES_FOURNISSEURSCaption; ETAT_DE_SUIVI_DES_FACTURES_FOURNISSEURSCaptionLbl)
            {
            }
            column(Cause_RejetCaption; Cause_RejetCaptionLbl)
            {
            }
            dataitem("Purch. Inv. Header"; 122)
            {
                DataItemLink = "Buy-from Vendor No." = FIELD("No.");
                DataItemTableView = SORTING("No.");
                RequestFilterFields = "Statut Facture";
                column(Purch__Inv__Header__No__; "No.")
                {
                }
                column(Purch__Inv__Header__Amount_Including_VAT_; "Amount Including VAT")
                {
                }
                column(Purch__Inv__Header__Statut_Facture_; "Statut Facture")
                {
                }
                column(Purch__Inv__Header__Vendor_Invoice_No__; "Vendor Invoice No.")
                {
                }
                column(Purch__Inv__Header__Posting_Date_; "Posting Date")
                {
                }
                column(Purch__Inv__Header_Buy_from_Vendor_No_; "Buy-from Vendor No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF NOT SeulementFactEnInstane THEN
                        DecTotalFourniss += "Amount Including VAT";
                end;

                trigger OnPreDataItem()
                begin
                    IF (DateDEbut <> 0D) AND (DateFin <> 0D) THEN SETRANGE("Posting Date", DateDEbut, DateFin);
                end;
            }
            dataitem("Purch. Cr. Memo Hdr."; 124)
            {
                DataItemLink = "Buy-from Vendor No." = FIELD("No.");
                DataItemTableView = SORTING("No.");
                column(Purch__Cr__Memo_Hdr___No__; "No.")
                {
                }
                column(Purch__Cr__Memo_Hdr___Amount_Including_VAT_; "Amount Including VAT")
                {
                }
                column(Purch__Cr__Memo_Hdr___Vendor_Cr__Memo_No__; "Vendor Cr. Memo No.")
                {
                }
                column(Purch__Cr__Memo_Hdr___Applies_to_Doc__No__; "Applies-to Doc. No.")
                {
                }
                column(Purch__Cr__Memo_Hdr___Posting_Date_; "Posting Date")
                {
                }
                column(Purch__Cr__Memo_Hdr__Buy_from_Vendor_No_; "Buy-from Vendor No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    DecTotalFourniss := DecTotalFourniss - "Amount Including VAT";
                end;
            }
            dataitem("Purchase Header"; 38)
            {
                CalcFields = Amount;
                DataItemLink = "Buy-from Vendor No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "No.")
                                    WHERE(Amount = FILTER(<> 0),
                                          "Document Type" = CONST(Invoice),
                                          Status = CONST(Released));
                column(Purchase_Header__Your_Reference_; "Your Reference")
                {
                }
                column(Purchase_Header__Amount_Including_VAT_; "Amount Including VAT")
                {
                }
                column(Purchase_Header__No__; "No.")
                {
                }
                column(EnInstance; EnInstance)
                {
                }
                column(Purchase_Header__Posting_Date_; "Posting Date")
                {
                }
                column(Purchase_Header_Document_Type; "Document Type")
                {
                }
                column(Purchase_Header_Buy_from_Vendor_No_; "Buy-from Vendor No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    DecTotalFourniss += "Amount Including VAT";
                    IF "Facture En Instance" THEN EnInstance := 'Facture En Instance' ELSE EnInstance := '';

                end;

                trigger OnPreDataItem()
                begin
                    IF (DateDEbut <> 0D) AND (DateFin <> 0D) THEN SETRANGE("Posting Date", DateDEbut, DateFin);
                    CALCFIELDS(Amount, "Amount Including VAT");
                    IF SeulementFactEnInstane THEN SETRANGE("Facture En Instance", TRUE);


                end;
            }
            dataitem(Integer; 2000000026)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = CONST(1));
                PrintOnlyIfDetail = false;
                column(DecTotalFourniss; DecTotalFourniss)
                {
                    DecimalPlaces = 3 : 3;
                }
                column(Vendor_Name_Control1000000033; Vendor.Name)
                {
                }
                column(Total__Caption; Total__CaptionLbl)
                {
                }
                column(Integer_Number; Number)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                DecTotalFourniss := 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field("Date Entre"; DateDEbut)
                    {
                        Caption = 'Date Entre';
                    }
                    field("Et"; DateFin)
                    {
                        Caption = 'Et';
                    }


                }

            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        DateDEbut: Date;
        DateFin: Date;
        EnInstance: Text[30];
        DecTotalFourniss: Decimal;
        SeulementFactEnInstane: Boolean;
        ETAT_DE_SUIVI_DES_FACTURES_FOURNISSEURSCaptionLbl: Label 'ETAT DE SUIVI DES FACTURES FOURNISSEURS';
        Cause_RejetCaptionLbl: Label 'Cause Rejet';
        Total__CaptionLbl: Label 'Total :';
}

