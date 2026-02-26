report 50096 "Liste Facture Décharge"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ListeFactureDécharge.rdlc';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING("Document Type", "No.");
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
            column(Purchase_Header__No__; "No.")
            {
            }
            column(Purchase_Header__Pay_to_Vendor_No__; "Pay-to Vendor No.")
            {
            }
            column(Purchase_Header__Pay_to_Name_; "Pay-to Name")
            {
            }
            column(Purchase_Header__Posting_Date_; "Posting Date")
            {
            }
            column(Purchase_Header__Vendor_Invoice_No__; "Vendor Invoice No.")
            {
            }
            column(Purchase_Header__Purchase_Header___Amount_Including_VAT_; "Purchase Header"."Amount Including VAT")
            {
            }
            column(NbreFacture; NbreFacture)
            {
            }
            column(NbreAvoir; NbreAvoir)
            {
            }
            column(Purchase_HeaderCaption; Purchase_HeaderCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Purchase_Header__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(Purchase_Header__Pay_to_Vendor_No__Caption; FIELDCAPTION("Pay-to Vendor No."))
            {
            }
            column(FournisseurCaption; FournisseurCaptionLbl)
            {
            }
            column(Purchase_Header__Vendor_Invoice_No__Caption; FIELDCAPTION("Vendor Invoice No."))
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
            column(Nbre_Avoir__Caption; Nbre_Avoir__CaptionLbl)
            {
            }
            column(Purchase_Header_Document_Type; "Document Type")
            {
            }

            trigger OnAfterGetRecord()
            begin
                "N° Decharge" := NumDecharge;
                "Purchase Header"."Date Decharge" := TODAY;
                Imprimer := TRUE;
                MODIFY;

                IF "Purchase Header"."Document Type" = 2 THEN
                    NbreFacture := NbreFacture + 1
                ELSE IF "Purchase Header"."Document Type" = 5 THEN NbreAvoir := NbreAvoir + 1
                /*
                //>> MH SORO 05-06-2020
                RecLigneBureauOrdre.RESET;
                RecLigneBureauOrdre.SETRANGE("Numero Fature Achat Associé","No.");
                IF RecLigneBureauOrdre.FINDFIRST THEN
                  REPEAT
                    RecLigneBureauOrdre."Date Vérification Facture":=TODAY;
                    RecLigneBureauOrdre."User Facture":="Purchase Header"."User ID";
                    RecLigneBureauOrdre.MODIFY;
                  UNTIL RecLigneBureauOrdre.NEXT=0;
                //<< MH SORO 05-06-2020
                */

            end;

            trigger OnPreDataItem()
            begin
                IF PurchasesPayablesSetup.GET THEN;
                NumDecharge := NoSeriesManagement.GetNextNo(PurchasesPayablesSetup."Dechargement Srv Controle", TODAY, TRUE);
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
        NbreFacture: Integer;
        NbreAvoir: Integer;
        RecLigneBureauOrdre: Record 50009;
        Purchase_HeaderCaptionLbl: Label 'En-tête achat';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        FournisseurCaptionLbl: Label 'Fournisseur';
        Date_CaptionLbl: Label 'Date ';
        Montant_TTCCaptionLbl: Label 'Montant TTC';
        EmargementCaptionLbl: Label 'Emargement';
        Nbre_Facture__CaptionLbl: Label 'Nbre Facture :';
        Nbre_Avoir__CaptionLbl: Label 'Nbre Avoir :';
}

