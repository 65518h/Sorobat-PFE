report 52048926 "Engagement Fournisseurs"
//Nav 09 "10865"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/EngagementFournisseurs.rdlc';
    Caption = 'Engagement Fournisseurs 2';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Vendor; 23)
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
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
            column(No_________Vendor_Name; "No." + ' ' + Vendor.Name)
            {
            }
            column(MontantOuvert; MontantOuvert)
            {
            }
            column("MontantEngagé"; MontantEngagé)
            {
            }
            column("MontantOuvert_MontantEngagé"; MontantOuvert + MontantEngagé)
            {
            }
            column(Vendor_Ledger_EntryCaption; Vendor_Ledger_EntryCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Date_EchCaption; Date_EchCaptionLbl)
            {
            }
            column(N__DocCaption; N__DocCaptionLbl)
            {
            }
            column(MontantCaption; MontantCaptionLbl)
            {
            }
            column(ResteCaption; ResteCaptionLbl)
            {
            }
            column(FournisseurCaption; FournisseurCaptionLbl)
            {
            }
            column(Montant_OuvertCaption; Montant_OuvertCaptionLbl)
            {
            }
            column("Montant_EngagéCaption"; Montant_EngagéCaptionLbl)
            {
            }
            column(Montant_GlobalCaption; Montant_GlobalCaptionLbl)
            {
            }
            column(Vendor_No_; "No.")
            {
            }

            dataitem("Vendor Ledger Entry"; 25)
            {
                DataItemLink = "Vendor No." = FIELD("No.");
                DataItemTableView = SORTING("Entry No.");
                PrintOnlyIfDetail = false;
                column(Vendor_Ledger_Entry__VendorNo__; "Vendor No.")
                {
                }
                column(Vendor_Ledger_Entry__Document_No__; "Document No.")
                {

                }
                column(Vendor_Ledger_Entry_Amount; Amount)
                {
                }
                column(Vendor_Ledger_Entry__Remaining_Amount_; "Remaining Amount")
                {
                }
                column(Vendor_Ledger_Entry__Due_Date_; "Due Date")
                {
                }
                column(Vendor_Ledger_Entry_Amount_Control1000000047; Amount)
                {
                }
                column(Vendor_Ledger_Entry__Remaining_Amount__Control1000000048; "Remaining Amount")
                {
                }
                column(REA_Caption; REA_CaptionLbl)
                {
                }
                column(Vendor_Ledger_Entry_Entry_No_; "Entry No.")
                {
                }
                column(Vendor_Ledger_Entry_Vendor_No_; "Vendor No.")
                {
                }

                trigger OnPreDataItem()
                begin
                    LastFieldNo := FIELDNO("Due Date");
                end;

                trigger OnAfterGetRecord()
                var
                begin
                    MontantOuvert += "Remaining Amount";
                end;
            }
            dataitem("Purchase Header"; 38)
            {
                DataItemLink = "Buy-from Vendor No." = FIELD("No.");
                DataItemTableView = SORTING("Due Date") WHERE("Document Type" = CONST(Order), Status = CONST(Released));
                column(Purchase_Header__No__; "No.")
                {
                }
                column(MontantTTC; MontantTTC)
                {
                }
                column(Montant; Montant)
                {
                }
                column(Purchase_Header__Posting_Date_; "Posting Date")
                {
                }
                column(ENG_Caption; ENG_CaptionLbl)
                {
                }
                column(Purchase_Header_Document_Type; "Document Type")
                {
                }
                column(Purchase_Header_Buy_from_Vendor_No_; "Buy-from Vendor No.")
                {
                }
                column("PurchaseHeaderNo"; "Purchase HeaderNo.")
                {

                }

                column("PurchaseHeaderDate"; "Purchase HeaderDate")
                {

                }

                // column(MontantOuvert; MontantOuvert)
                // {
                // }
                // column("MontantEngagé"; MontantEngagé)
                // {
                // }
                // column("MontantOuvert_MontantEngagé"; MontantOuvert + MontantEngagé)
                // {
                // }
                trigger OnPreDataItem()
                begin

                    //       MontantTTC := 0;
                    MontantOuvert := 0;
                    MontantEngagé := 0;
                    MontantGlobal := 0;
                    //  Montant := 0;
                    docno := '';



                end;

                trigger OnAfterGetRecord()
                begin

                    // Message(Format("Purchase Header"."No."));

                    if "Purchase Header"."No." <> docno then
                        Montant := 0;

                    PurchaseLine.SETRANGE("Document Type", "Document Type");
                    PurchaseLine.SETRANGE("Document No.", "No.");
                    IF PurchaseLine.FINDFIRST THEN
                        REPEAT
                            Montant -= PurchaseLine."Amt. Rcd. Not Invoiced";
                            MontantTTC -= PurchaseLine."Amt. Rcd. Not Invoiced";
                            docno := PurchaseLine."Document No."


                        // if PurchaseLine."Amt. Rcd. Not Invoiced" <> 0 then begin
                        //     "Purchase HeaderNo." := "Purchase Header"."No.";
                        //     "Purchase HeaderDate" := "Purchase Header"."Posting Date";
                        // end;
                        UNTIL PurchaseLine.NEXT = 0;



                    MontantEngagé += MontantTTC;

                end;
            }
            trigger OnAfterGetRecord()
            var
            begin
                MontantTTC := 0;
                "Purchase HeaderNo." := '';
                "Purchase HeaderDate" := 0D;

            end;

            trigger OnPreDataItem()
            begin




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
        TotalFor: Label 'Total ';
        PurchaseLine: Record 39;
        MontantTTC: Decimal;
        Montant: Decimal;
        MontantOuvert: Decimal;
        MontantEngagé: Decimal;
        MontantGlobal: Decimal;
        Vendor_Ledger_EntryCaptionLbl: Label 'Écriture comptable fournisseur';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Date_EchCaptionLbl: Label 'Date Ech';
        N__DocCaptionLbl: Label 'N° Doc';
        MontantCaptionLbl: Label 'Montant';
        ResteCaptionLbl: Label 'Reste';
        FournisseurCaptionLbl: Label 'Fournisseur';
        Montant_OuvertCaptionLbl: Label 'Montant Ouvert';
        "Montant_EngagéCaptionLbl": Label 'Montant Engagé';
        Montant_GlobalCaptionLbl: Label 'Montant Global';
        REA_CaptionLbl: Label '*REA*';
        ENG_CaptionLbl: Label '*ENG*';
        "Purchase HeaderNo.": code[20];
        "Purchase HeaderDate": date;
        docno: code[20];
}

