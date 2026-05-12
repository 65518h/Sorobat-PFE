report 50097 "Liste Facture Décharge Enreg."
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/ListeFactureDéchargeEnreg.rdlc';

    // dataset
    // {
    //     dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
    //     {
    //         DataItemTableView = SORTING("No.");
    //         CalcFields = "Amount Including VAT";
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
    //         column(NumDecharge; NumDecharge)
    //         {
    //         }
    //         column(Purch__Inv__Header__No__; "No.")
    //         {
    //         }
    //         column(Purch__Inv__Header__Pay_to_Vendor_No__; "Pay-to Vendor No.")
    //         {
    //         }
    //         column(Purch__Inv__Header__Pay_to_Name_; "Pay-to Name")
    //         {
    //         }
    //         column(Purch__Inv__Header__Posting_Date_; "Posting Date")
    //         {
    //         }
    //         column(Purch__Inv__Header__Vendor_Invoice_No__; "Vendor Invoice No.")
    //         {
    //         }
    //         // column(Purch__Inv__Header__Amount_Including_VAT_; "Amount Including VAT")
    //         // {
    //         // }
    //         column(Purch__Inv__Header__Amount_Including_VAT_; AmoountVat)
    //         {
    //         }
    //         column(NbreFacture; NbreFacture)
    //         {
    //         }
    //         column(TotalMontant; TotalMontant)
    //         {
    //         }
    //         column(Purchase_HeaderCaption; Purchase_HeaderCaptionLbl)
    //         {
    //         }
    //         column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
    //         {
    //         }
    //         column(Purch__Inv__Header__No__Caption; FIELDCAPTION("No."))
    //         {
    //         }
    //         column(Purch__Inv__Header__Pay_to_Vendor_No__Caption; FIELDCAPTION("Pay-to Vendor No."))
    //         {
    //         }
    //         column(FournisseurCaption; FournisseurCaptionLbl)
    //         {
    //         }
    //         column(Purch__Inv__Header__Vendor_Invoice_No__Caption; FIELDCAPTION("Vendor Invoice No."))
    //         {
    //         }
    //         column(Date_Caption; Date_CaptionLbl)
    //         {
    //         }
    //         column(Montant_TTCCaption; Montant_TTCCaptionLbl)
    //         {
    //         }
    //         column(EmargementCaption; EmargementCaptionLbl)
    //         {
    //         }
    //         column(Nbre_Facture__Caption; Nbre_Facture__CaptionLbl)
    //         {
    //         }
    //         column(Total_Montant__Caption; Total_Montant__CaptionLbl)
    //         {
    //         }

    //         trigger OnAfterGetRecord()
    //         begin

    //             CduPurchasePost.MiseAJourDecharge("No.", TRUE, TRUE, NumDecharge);

    //             NbreFacture := NbreFacture + 1;
    //             AmoountVat := "Purch. Inv. Header"."Amount Including VAT";
    //             TotalMontant := TotalMontant + "Purch. Inv. Header"."Amount Including VAT";


    //         end;

    //         trigger OnPreDataItem()
    //         begin
    //             IF PurchasesPayablesSetup.GET THEN;
    //             NumDecharge := NoSeriesManagement.GetNextNo(PurchasesPayablesSetup."Dechargement Srv Comptable", TODAY, TRUE);
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
    //     AmoountVat: Decimal;
    //     CduPurchasePost: Codeunit PurchPostEvent;
    //     PurchasesPayablesSetup: Record 312;
    //     NumDecharge: Code[20];
    //     NoSeriesManagement: Codeunit 396;
    //     NbreFacture: Integer;
    //     TotalMontant: Decimal;
    //     Purchase_HeaderCaptionLbl: Label 'En-tête achat';
    //     CurrReport_PAGENOCaptionLbl: Label 'Page';
    //     FournisseurCaptionLbl: Label 'Fournisseur';
    //     Date_CaptionLbl: Label 'Date ';
    //     Montant_TTCCaptionLbl: Label 'Montant TTC';
    //     EmargementCaptionLbl: Label 'Emargement';
    //     Nbre_Facture__CaptionLbl: Label 'Nbre Facture :';
    //     Total_Montant__CaptionLbl: Label 'Total Montant :';
}

