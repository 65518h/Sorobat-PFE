report 50024 "Facture Vente enregistré"
{
    // //
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/FactureVenteenregistré2.rdl';

    Caption = 'Facture Vente enregistré';

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            RequestFilterHeading = 'Commande achat';
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(LE_DIRECTEUR_GENERALCaption; LE_DIRECTEUR_GENERALCaptionLbl)
            {
            }
            // column(Sales_Header_Document_Type; "Document Type")
            // {
            // }
            column(Sales_Header_No_; "No.")
            {
            }
            dataitem(CopyLoop; 2000000026)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; 2000000026)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(TextGMnt; TextGMnt)
                    {
                    }
                    column(DecLinAmount; DecLinAmount)
                    {
                        DecimalPlaces = 0 : 0;
                    }
                    column(DecAmountIncludingVAt_MontantBic; DecAmountIncludingVAt + MontantBic)
                    {
                        DecimalPlaces = 0 : 0;
                    }
                    column(DecMontantTVA; DecMontantTVA)
                    {
                        DecimalPlaces = 0 : 0;
                    }
                    column(MontantBic; MontantBic)
                    {
                        DecimalPlaces = 0 : 0;
                    }
                    column(DecAmountIncludingVAt; DecAmountIncludingVAt)
                    {
                        DecimalPlaces = 0 : 0;
                    }
                    column(FACTURE_______Sales_Header___No__; 'FACTURE  ' + "Sales Invoice Header"."No.")
                    {
                    }
                    column(Sales_Header___Posting_Date_; "Sales Invoice Header"."Posting Date")
                    {
                    }
                    column(G_RecCustomer_Address; G_RecCustomer.Address)
                    {
                    }
                    column(G_RecCustomer_RCCM; G_RecCustomer.RCCM)
                    {
                    }
                    column(G_RecCustomer_IFU; G_RecCustomer.IFU)
                    {
                    }
                    column(Sales_Header___Bill_to_Name_; "Sales Invoice Header"."Bill-to Name")
                    {
                    }
                    column(DateCaption; DateCaptionLbl)
                    {
                    }
                    column(Adresse__Caption; Adresse__CaptionLbl)
                    {
                    }
                    column(RCCM__Caption; RCCM__CaptionLbl)
                    {
                    }
                    column(N__IFU_Caption; N__IFU_CaptionLbl)
                    {
                    }
                    column("Nom_de_la_société__Caption"; Nom_de_la_société__CaptionLbl)
                    {
                    }
                    column(PageLoop_Number; Number)
                    {
                    }
                    column("Arrêté_la_présente_facture_à_la_somme_Caption"; Arrêté_la_présente_facture_à_la_somme_CaptionLbl)
                    {
                    }
                    column(MONTANT_HTCaption; MONTANT_HTCaptionLbl)
                    {
                    }
                    column(TVA_18_Caption; TVA_18_CaptionLbl)
                    {
                    }
                    column(MONTANT_TTCCaption; MONTANT_TTCCaptionLbl)
                    {
                    }
                    column(ACOMPTE_BICCaption; ACOMPTE_BICCaptionLbl)
                    {
                    }
                    column(NET_A_PAYERCaption; NET_A_PAYERCaptionLbl)
                    {
                    }
                    /*GL2024   dataitem(DimensionLoop1; 2000000026)
                       {
                           DataItemLinkReference = "Sales Header";
                           DataItemTableView = SORTING(Number)
                                               WHERE(Number = FILTER(1 ..));

                           trigger OnAfterGetRecord()
                           begin
                               IF Number = 1 THEN BEGIN
                                   IF NOT DocDim1.FIND('-') THEN
                                       CurrReport.BREAK;
                               END ELSE
                                   IF NOT Continue THEN
                                       CurrReport.BREAK;

                               CLEAR(DimText);
                               Continue := FALSE;
                               REPEAT
                                   OldDimText := DimText;
                                   /*GL2024 IF DimText = '' THEN
                                        DimText := STRSUBSTNO(
                                          '%1 %2', DocDim1."Dimension Code", DocDim1."Dimension Value Code")
                                    ELSE
                                        DimText :=
                                          STRSUBSTNO(
                                            '%1, %2 %3', DimText,
                                            DocDim1."Dimension Code", DocDim1."Dimension Value Code");*/
                    /*   IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                           DimText := OldDimText;
                           Continue := TRUE;
                           EXIT;
                       END;
                   UNTIL (DocDim1.NEXT = 0);
               end;

               trigger OnPreDataItem()
               begin
                   IF NOT ShowInternalInfo THEN
                       CurrReport.BREAK;
               end;
           }*/
                    dataitem("Sales Invoice Line"; "Sales Invoice Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = SORTING("Document No.", "Line No.");
                        column(Sales_Line_Description; Description)
                        {
                        }
                        column(Sales_Line_Quantity; Quantity)
                        {
                        }
                        column(Sales_Line__Sales_Line___Unit_Cost__LCY__; "Sales Invoice Line"."Unit Price")
                        {
                            AutoFormatType = 2;
                        }
                        column(Sales_Line__Unit_of_Measure_; "Unit of Measure")
                        {
                        }
                        column(Sales_Line_Amount; Amount)
                        {
                        }
                        column(AmountCaption; AmountCaptionLbl)
                        {
                        }
                        column(Direct_Unit_CostCaption; Direct_Unit_CostCaptionLbl)
                        {
                        }
                        column(QTECaption; QTECaptionLbl)
                        {
                        }
                        column("DésignationCaption"; DésignationCaptionLbl)
                        {
                        }
                        column(UNITECaption; UNITECaptionLbl)
                        {
                        }
                        // column(Sales_Line_Document_Type; "Document Type")
                        // {
                        // }
                        column(Sales_Line_Document_No_; "Document No.")
                        {
                        }
                        column(Sales_Line_Line_No_; "Line No.")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            //DecLinAmount+="Line Amount";
                            // IF SalesReceivablesSetup.GET THEN;
                            // IF "No." <> SalesReceivablesSetup."Frais BIC" THEN BEGIN
                            //     DecLinAmount += Amount;
                            //     DecDiffTva += "VAT Difference";
                            //     DecAmountIncludingVAt += "Amount Including VAT"; // "Line Amount"*(1+"VAT %"/100);
                            //     DecMontant += Amount;
                            //     DecDiscountAmount += "Line Discount Amount";
                            //     DecAcompte += "Prepmt. Line Amount";
                            //     DecMontantTVA += "Amount Including VAT" - Amount;
                            //     IF "VAT %" = 0 THEN DecBaseNonTaxable += Amount;
                            //     //DecMontantTVA+=DecAmountIncludingVAt-DecLinAmount+DecDiffTva;
                            //     IF DecTauxTva = 0 THEN DecTauxTva := PurchLine."VAT %";
                            // END;
                            /*   ELSE
                                   MontantBic += ROUND("Line Amount", 1);
                               Message(format(MontantBic));*/




                            IntCompteur += 1;
                            IF IntCompteur = 15 THEN BEGIN
                                BlnAfficher := TRUE;
                                CurrReport.NEWPAGE;
                                IntCompteur := 0;
                            END
                            ELSE
                                BlnAfficher := FALSE;
                            IF SalesReceivablesSetup.GET THEN;
                            //GL2024 CurrReport.SHOWOUTPUT("No." <> SalesReceivablesSetup."Frais BIC");
                            // if "No." = SalesReceivablesSetup."Frais BIC" then
                            //     CurrReport.Skip();


                            IF "Sales Invoice Header"."Currency Code" = '' THEN
                                CodeU."Montant en texte sans millimes"(TextGMnt, ROUND(DecAmountIncludingVAt + MontantBic, 1))
                            ELSE
                                CodeU."Montant en texteDevise"(TextGMnt, ROUND(DecAmountIncludingVAt + MontantBic, 1),
                               "Sales Invoice Header"."Currency Code");
                            CurrReport.SHOWOUTPUT(NOT BlnAfficher);

                            // Message('1: %1', format(DecAmountIncludingVAt));
                            // Message('2: %1', format(MontantBic));
                            // Message('3: %1', TextGMnt);

                        end;

                        trigger OnPostDataItem()
                        begin
                            //CurrReport.BREAK;
                        end;
                    }
                    /*GL2024  dataitem(Saut; 2000000026)
                      {
                          DataItemTableView = SORTING(Number);
                          column(Saut_Number; Number)
                          {
                          }
                          trigger OnAfterGetRecord()
                          begin

                              SETRANGE(Number, 1, 15 - IntCompteur);
                          end;
                      }*/

                    dataitem(Loop; Integer)
                    {
                        DataItemTableView = sorting(Number) where(Number = filter(1 .. 8));
                        column(Number;
                        Number)
                        { }
                        trigger OnPreDataItem()
                        var
                            rep: Report "Sales - Shipment";
                            inb: Integer;
                        begin
                            inb := Loop.Count - "Sales Invoice Line".Count;
                            //   Message(Format("Purchase request Line".Count));
                            //  Message(Format(Loop.Count));
                            Reset();
                            SetRange(Number, 1, inb);
                            /*  if "Purchase request Line".Count > 30 then begin
                                  inb := Loop.Count + "Purchase request Line".Count;
                                  Reset();
                                  SetRange(Number, 1, inb);
                              end;*/

                        end;
                    }
                    dataitem(DetailTva; 2000000026)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                        // column(TextGMnt; TextGMnt)
                        // {
                        // }
                        // column(DecLinAmount; DecLinAmount)
                        // {
                        //     DecimalPlaces = 0 : 0;
                        // }
                        // column(DecAmountIncludingVAt_MontantBic; DecAmountIncludingVAt + MontantBic)
                        // {
                        //     DecimalPlaces = 0 : 0;
                        // }
                        // column(DecMontantTVA; DecMontantTVA)
                        // {
                        //     DecimalPlaces = 0 : 0;
                        // }
                        // column(MontantBic; MontantBic)
                        // {
                        //     DecimalPlaces = 0 : 0;
                        // }
                        // column(DecAmountIncludingVAt; DecAmountIncludingVAt)
                        // {
                        //     DecimalPlaces = 0 : 0;
                        // }
                        // column("Arrêté_la_présente_facture_à_la_somme_Caption"; Arrêté_la_présente_facture_à_la_somme_CaptionLbl)
                        // {
                        // }
                        // column(MONTANT_HTCaption; MONTANT_HTCaptionLbl)
                        // {
                        // }
                        // column(TVA_18_Caption; TVA_18_CaptionLbl)
                        // {
                        // }
                        // column(MONTANT_TTCCaption; MONTANT_TTCCaptionLbl)
                        // {
                        // }
                        // column(ACOMPTE_BICCaption; ACOMPTE_BICCaptionLbl)
                        // {
                        // }
                        // column(NET_A_PAYERCaption; NET_A_PAYERCaptionLbl)
                        // {
                        // }
                        column(DetailTva_Number; Number)
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin

                            // IF "Sales Header"."Currency Code" = '' THEN
                            //     CodeU."Montant en texte sans millimes"(TextGMnt, ROUND(DecAmountIncludingVAt + MontantBic, 1))
                            // ELSE
                            //     CodeU."Montant en texteDevise"(TextGMnt, ROUND(DecAmountIncludingVAt + MontantBic, 1),
                            //     "Sales Header"."Currency Code");
                            // CurrReport.SHOWOUTPUT(NOT BlnAfficher);

                            // Message('4: %1', format(DecAmountIncludingVAt));
                            // Message('5: %1', format(MontantBic));
                            // Message('6: %1', TextGMnt);
                        end;
                    }
                    trigger OnAfterGetRecord()
                    begin

                        // IF "Sales Header"."Currency Code" = '' THEN
                        //     CodeU."Montant en texte sans millimes"(TextGMnt, ROUND(DecAmountIncludingVAt + MontantBic, 1))
                        // ELSE
                        //     CodeU."Montant en texteDevise"(TextGMnt, ROUND(DecAmountIncludingVAt + MontantBic, 1),
                        //     "Sales Header"."Currency Code");
                        // CurrReport.SHOWOUTPUT(NOT BlnAfficher);
                    end;
                }

                trigger OnAfterGetRecord()
                var
                    PrepmtPurchLine: Record 39 temporary;
                    DocDim: Record 357;
                    TempPurchLine: Record 39 temporary;
                begin

                end;

                trigger OnPostDataItem()
                begin
                    //   IF NOT CurrReport.PREVIEW THEN
                    // PurchCountPrinted.RUN("SALES Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := ABS(NoOfCopies) + 1;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);

                    IF ISSERVICETIER THEN
                        OutputNo := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF G_RecCustomer.GET("Sell-to Customer No.") THEN;
                //GL2024   CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");

                CompanyInfo.GET;
                IF SalesReceivablesSetup.GET THEN;


                RecSalesLine.RESET;
                RecSalesLine.SETRANGE(RecSalesLine."Document No.", "Sales Invoice Header"."No.");
                IF RecSalesLine.FINDFIRST THEN
                    REPEAT
                        IF SalesReceivablesSetup.GET THEN;
                        IF RecSalesLine."No." <> SalesReceivablesSetup."Frais BIC" THEN BEGIN
                            DecLinAmount += RecSalesLine.Amount;
                            DecDiffTva += RecSalesLine."VAT Difference";
                            DecAmountIncludingVAt += RecSalesLine."Amount Including VAT"; // "Line Amount"*(1+"VAT %"/100);
                            DecMontant += RecSalesLine.Amount;
                            DecDiscountAmount += RecSalesLine."Line Discount Amount";

                            IF RecSalesLine."VAT %" = 0 THEN DecBaseNonTaxable += RecSalesLine.Amount;
                            //DecMontantTVA+=DecAmountIncludingVAt-DecLinAmount+DecDiffTva;
                            IF DecTauxTva = 0 THEN DecTauxTva := PurchLine."VAT %";
                        END;

                    UNTIL RecSalesLine.NEXT = 0;






                RecSalesLine.RESET;
                RecSalesLine.SETRANGE(RecSalesLine."Document No.", "Sales Invoice Header"."No.");
                IF RecSalesLine.FINDFIRST THEN
                    REPEAT
                        IF RecSalesLine."No." = SalesReceivablesSetup."Frais BIC" THEN
                            MontantBic := MontantBic + RecSalesLine."Line Amount";
                    //TotalFodec+=RecSalesLine."Line Amount" *(1+RecSalesLine."VAT %"/100);
                    // RB SORO 06/08/2015
                    UNTIL RecSalesLine.NEXT = 0;

            end;
        }

    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(NoOfCopies; NoOfCopies)
                    {
                        Caption = 'Nombre de copies';
                    }
                    field(ShowInternalInfo; ShowInternalInfo)
                    {
                        Caption = 'Afficher info. internes';
                    }
                    field(ArchiveDocument; ArchiveDocument)
                    {
                        Caption = 'Archiver document';

                        trigger OnValidate()
                        begin
                            IF NOT ArchiveDocument THEN
                                LogInteraction := FALSE;
                        end;
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        Caption = 'Journal interaction';
                        Enabled = LogInteractionEnable;

                        trigger OnValidate()
                        begin

                            //GL2024 IF LogInteraction THEN
                            //GL2024 ArchiveDocument := RequestOptionspage.ArchiveDocument.ENABLED;
                        end;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            LogInteractionEnable := TRUE;
        end;

        trigger OnOpenPage()
        begin
            //#8609
            //ArchiveDocument := PurchSetup."Archive Quotes and Orders";

            ArchiveDocument :=  //GL2024 (PurchSetup."Archive Quotes and Orders") AND

                                   ((PurchSetup."Archiving Method" = PurchSetup."Archiving Method"::Standard) OR
                                    (PurchSetup."Archiving Method" = PurchSetup."Archiving Method"::Standard));
            //#8609//
            LogInteraction := SegManagement.FindInteractTmplCode(13) <> '';

            LogInteractionEnable := LogInteraction;
            //GL2024   RequestOptionspage.LogInteraction.ENABLED(LogInteraction);
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        GLSetup.GET;
        PurchSetup.GET;
    end;

    var
        RecSalesLine: Record 113;
        Text000: Label 'Acheteur';
        Text001: Label 'Total %1';
        Text002: Label 'Total %1 TTC';
        Text003: Label 'COPIE';
        Text004: Label 'Commande %1';
        Text005: Label 'Page %1';
        Text006: Label 'Total %1 HT';
        GLSetup: Record 98;
        CompanyInfo: Record 79;
        ShipmentMethod: Record 10;
        PaymentTerms: Record 3;
        PrepmtPaymentTerms: Record 3;
        SalesPurchPerson: Record 13;
        VATAmountLine: Record 290 temporary;
        PrepmtVATAmountLine: Record 290 temporary;
        PrePmtVATAmountLineDeduct: Record 290 temporary;
        PurchLine: Record 39 temporary;
        DocDim1: Record 357;
        DocDim2: Record 357;
        PrepmtDocDim: Record 357 temporary;
        PrepmtInvBuf: Record 461 temporary;
        RespCenter: Record 5714;
        Language: Record 8;
        CurrExchRate: Record 330;
        PurchSetup: Record 312;
        PurchCountPrinted: Codeunit 317;
        FormatAddr: Codeunit 365;
        PurchPost: Codeunit 90;
        ArchiveManagement: Codeunit 5063;
        SegManagement: Codeunit 5051;
        PurchPostPrepmt: Codeunit 444;
        VendAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        BuyFromAddr: array[8] of Text[50];
        PurchaserText: Text[30];
        VATNoText: Text[80];
        ReferenceText: Text[80];
        TotalText: Text[50];
        TotalInclVATText: Text[50];
        TotalExclVATText: Text[50];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        OutputNo: Integer;
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        ArchiveDocument: Boolean;
        LogInteraction: Boolean;
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        VATDiscountAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        VALVATBaseLCY: Decimal;
        VALVATAmountLCY: Decimal;
        VALSpecLCYHeader: Text[80];
        VALExchRate: Text[50];
        Text007: Label 'Détail TVA dans  ';
        Text008: Label 'Devise société';
        Text009: Label 'Taux de change : %1/%2';
        PrepmtVATAmount: Decimal;
        PrepmtVATBaseAmount: Decimal;
        PrepmtAmountInclVAT: Decimal;
        PrepmtTotalAmountInclVAT: Decimal;
        PrepmtLineAmount: Decimal;
        PricesInclVATtxt: Text[30];
        AllowInvDisctxt: Text[30];
        [InDataSet]
        ArchiveDocumentEnable: Boolean;
        [InDataSet]
        LogInteractionEnable: Boolean;
        G_RecCustomer: Record 18;
        MontantBrut: Decimal;
        CountLine: Integer;
        CodeU: Codeunit 50005;
        TextGMnt: Text[250];
        RecPaymentMethod: Record 289;
        BlnAfficher: Boolean;
        IntCompteur: Integer;
        DecLinAmount: Decimal;
        DecAmountIncludingVAt: Decimal;
        DecDiscountAmount: Decimal;
        DecAcompte: Decimal;
        DecMontantTVA: Decimal;
        IntCompteurAffichage: Integer;
        DecTauxTva: Decimal;
        DecDiffTva: Decimal;
        DecMontant: Decimal;
        DecBaseNonTaxable: Decimal;
        Adresse: Record 18;
        SalesReceivablesSetup: Record 311;
        MontantBic: Decimal;
        LE_DIRECTEUR_GENERALCaptionLbl: Label 'LE DIRECTEUR GENERAL';
        DateCaptionLbl: Label 'Date';
        Adresse__CaptionLbl: Label 'Adresse :';
        RCCM__CaptionLbl: Label 'RCCM :';
        N__IFU_CaptionLbl: Label 'N° IFU:';
        "Nom_de_la_société__CaptionLbl": Label 'Nom de la société :';
        AmountCaptionLbl: Label 'Montant';
        Direct_Unit_CostCaptionLbl: Label 'Direct Unit Cost';
        QTECaptionLbl: Label 'QTE';
        "DésignationCaptionLbl": Label 'Désignation';
        UNITECaptionLbl: Label 'UNITE';
        "Arrêté_la_présente_facture_à_la_somme_CaptionLbl": Label 'Arrêté la présente facture à la somme:';
        MONTANT_HTCaptionLbl: Label 'MONTANT HT';
        TVA_18_CaptionLbl: Label 'TVA 18%';
        MONTANT_TTCCaptionLbl: Label 'MONTANT TTC';
        ACOMPTE_BICCaptionLbl: Label 'ACOMPTE BIC';
        NET_A_PAYERCaptionLbl: Label 'NET A PAYER';
}

