report 50103 "Liste Avoir Décharge Enreg."
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ListeAvoirDéchargeEnreg.rdlc';

    dataset
    {
        dataitem("Purch. Cr. Memo Hdr."; 124)
        {
            DataItemTableView = SORTING("No.");
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
            column(NumDecharge; NumDecharge)
            {
            }
            column(Purch__Cr__Memo_Hdr___No__; "No.")
            {
            }
            column(Purch__Cr__Memo_Hdr___Pay_to_Vendor_No__; "Pay-to Vendor No.")
            {
            }
            column(Purch__Cr__Memo_Hdr___Pay_to_Name_; "Pay-to Name")
            {
            }
            column(Purch__Cr__Memo_Hdr___Posting_Date_; "Posting Date")
            {
            }
            column(Purch__Cr__Memo_Hdr___Purch__Cr__Memo_Hdr____Buy_from_Vendor_No__; "Purch. Cr. Memo Hdr."."Buy-from Vendor No.")
            {
            }
            column(Purch__Cr__Memo_Hdr___Amount_Including_VAT_; "Amount Including VAT")
            {
            }
            column(NbreFacture; NbreFacture)
            {
            }
            column(TotalMontant; TotalMontant)
            {
            }
            column(Purchase_HeaderCaption; Purchase_HeaderCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Purch__Cr__Memo_Hdr___No__Caption; FIELDCAPTION("No."))
            {
            }
            column(Purch__Cr__Memo_Hdr___Pay_to_Vendor_No__Caption; FIELDCAPTION("Pay-to Vendor No."))
            {
            }
            column(FournisseurCaption; FournisseurCaptionLbl)
            {
            }
            column(Purch__Cr__Memo_Hdr___Purch__Cr__Memo_Hdr____Buy_from_Vendor_No__Caption; FIELDCAPTION("Buy-from Vendor No."))
            {
            }
            column(Date_Caption; Date_CaptionLbl)
            {
            }
            column(Montant_TTCCaption; Montant_TTCCaptionLbl)
            {
            }
            column(EmargementCaption; EmargementCaptionLbl)
            {
            }
            column(Nbre_Facture__Caption; Nbre_Facture__CaptionLbl)
            {
            }
            column(Total_Montant__Caption; Total_Montant__CaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin

                //GL2024 proceudre n'existe pas dans CDU 90  CduPurchasePost.MiseAJourAvoir("No.",TRUE,TRUE,NumDecharge);
                NbreFacture := NbreFacture + 1;
                TotalMontant := TotalMontant + "Purch. Cr. Memo Hdr."."Amount Including VAT";
            end;

            trigger OnPreDataItem()
            begin
                IF PurchasesPayablesSetup.GET THEN;
                NumDecharge := NoSeriesManagement.GetNextNo(PurchasesPayablesSetup."Dechargement Avoir Srv Compta", TODAY, TRUE);

                NbreFacture := NbreFacture + 1;
                TotalMontant := TotalMontant + "Purch. Cr. Memo Hdr."."Amount Including VAT";
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
        PurchasesPayablesSetup: Record 312;
        NumDecharge: Code[20];
        NoSeriesManagement: Codeunit 396;
        CduPurchasePost: Codeunit 90;
        NbreFacture: Integer;
        TotalMontant: Decimal;
        Purchase_HeaderCaptionLbl: Label 'Liste des Avoirs Décharge';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        FournisseurCaptionLbl: Label 'Fournisseur';
        Date_CaptionLbl: Label 'Date ';
        Montant_TTCCaptionLbl: Label 'Montant TTC';
        EmargementCaptionLbl: Label 'Emargement';
        Nbre_Facture__CaptionLbl: Label 'Nbre Facture :';
        Total_Montant__CaptionLbl: Label 'Total Montant :';
}
