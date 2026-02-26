report 50034 "Bon Commande Format A4"
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/BonCommandeFormatA4.rdlc';
    // Caption = 'Order';

    // dataset
    // {
    //     dataitem("purchase header"; "purchase header")
    //     {
    //         DataItemTableView = SORTING("Document Type", "No.");
    //         RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
    //         RequestFilterHeading = 'Purchase Order';
    //         column(Picture; RecCompInf.Picture) { }

    //         column(XXXXXXXCaption; XXXXXXXCaptionLbl)
    //         {
    //         }
    //         column(XXXXXXXCaption_Control1000000091; XXXXXXXCaption_Control1000000091Lbl)
    //         {
    //         }
    //         column(XXXXXXXCaption_Control1000000094; XXXXXXXCaption_Control1000000094Lbl)
    //         {
    //         }
    //         column(XXXXXXXCaption_Control1000000108; XXXXXXXCaption_Control1000000108Lbl)
    //         {
    //         }
    //         column(XXXXXXXCaption_Control1000000110; XXXXXXXCaption_Control1000000110Lbl)
    //         {
    //         }
    //         column(XXXXXXXCaption_Control1000000092; XXXXXXXCaption_Control1000000092Lbl)
    //         {
    //         }
    //         column(XXXXXXXCaption_Control1000000105; XXXXXXXCaption_Control1000000105Lbl)
    //         {
    //         }
    //         column(XXXXXXXCaption_Control1000000109; XXXXXXXCaption_Control1000000109Lbl)
    //         {
    //         }
    //         column(Purchase_Header_Document_Type; "Document Type")
    //         {
    //         }
    //         column(Purchase_Header_No_; "No.")
    //         {
    //         }
    //         dataitem(CopyLoop; 2000000026)
    //         {
    //             DataItemTableView = SORTING(Number);

    //             dataitem(PageLoop; 2000000026)
    //             {
    //                 DataItemTableView = SORTING(Number)
    //                                     WHERE(Number = CONST(1));
    //                 column(DecTauxTva; DecTauxTva)
    //                 {
    //                 }
    //                 column(ROUND_DecMontantTVA_1_; ROUND(DecMontantTVA, 1))
    //                 {
    //                 }
    //                 column(comment1; comment1)
    //                 {

    //                 }
    //                 column(comment2; comment2)
    //                 {

    //                 }
    //                 column(MontantTimbre; RecLPurchLine."Direct Unit Cost") { }
    //                 column(comment3; comment3)
    //                 {

    //                 }
    //                 column(Observation_1; "Purchase Header"."Observation 1") { }
    //                 column(Observation_2; "Purchase Header"."Observation 2") { }
    //                 column(Observation_3; "Purchase Header"."Observation 3") { }
    //                 column(NDAChantier; "Purchase Header"."N° DA Chantier") { }
    //                 column(Purchase_Header___No__; "Purchase Header"."No.")
    //                 {
    //                 }
    //                 column(ROUND_DecLinAmount_1_; ROUND(DecLinAmount, 1))
    //                 {
    //                 }
    //                 column(DecDiscountAmount; DecDiscountAmount)
    //                 {
    //                     DecimalPlaces = 3 : 3;
    //                 }
    //                 column(DecLinAmount; DecLinAmount)
    //                 {
    //                     DecimalPlaces = 3 : 3;
    //                 }
    //                 column(TextGMnt; TextGMnt) { }
    //                 column(DecAmountIncludingVAt; DecAmountIncludingVAt + RecLPurchLine."Direct Unit Cost")
    //                 {
    //                     DecimalPlaces = 3 : 3;
    //                 }
    //                 column(DecTotalBrut; DecTotalBrut)
    //                 {
    //                     DecimalPlaces = 3 : 3;
    //                 }
    //                 column(PaymentTerms_Description; PaymentTerms.Description)
    //                 {
    //                 }
    //                 column(Purchase_Header___Pay_to_Address_2_; "Purchase Header"."Pay-to Address 2")
    //                 {
    //                 }
    //                 column(Purchase_Header___Shipment_Remark_; "Purchase Header"."Shipment Remark")
    //                 {
    //                 }
    //                 column(Purchase_Header___Requested_Receipt_Date_; "Purchase Header"."Requested Receipt Date")
    //                 {
    //                 }
    //                 column(Purchase_Header___N__Devis_Fournisseur_; "Purchase Header"."N° Devis Fournisseur")
    //                 {
    //                 }
    //                 column(Purchase_Header___N__Demande_d_achat_; "Purchase Header"."N° Demande d'achat")
    //                 {
    //                 }
    //                 column(Purchase_Header___Order_Date_; "Purchase Header"."Order Date")
    //                 {
    //                 }
    //                 column(Purchase_Header___Date_DA_; "Purchase Header"."Date DA")
    //                 {
    //                 }
    //                 column(Lieu; "purchase header"."Nom Lieu Liv")
    //                 {
    //                 }
    //                 column(Purchase_Header___Buy_from_Vendor_Name_; "Purchase Header"."Buy-from Vendor Name")
    //                 {
    //                 }
    //                 column(Purchase_Header___Buy_from_Address_; "Purchase Header"."Buy-from Address")
    //                 {
    //                 }
    //                 column(Affect; Affect)
    //                 {
    //                 }
    //                 column(PageConst_________FORMAT_CurrReport_PAGENO_; PageConst + ' ' + FORMAT(CurrReport.PAGENO))
    //                 {
    //                 }
    //                 column(Purchase_Header___Purchaser_Code_; "Purchase Header"."Purchaser Code")
    //                 {
    //                 }
    //                 // column(Purchase_Header___N__DA_Chantier_; "Purchase Header"."N° DA Chantier")
    //                 // {
    //                 // }
    //                 column(N__de_CommandeCaption; N__de_CommandeCaptionLbl)
    //                 {
    //                 }
    //                 column(DateCaption; DateCaptionLbl)
    //                 {
    //                 }
    //                 column(Date_DA__Caption; Date_DA__CaptionLbl)
    //                 {
    //                 }
    //                 column(D_A_N___Caption; D_A_N___CaptionLbl)
    //                 {
    //                 }
    //                 column("Référence__Caption"; Référence__CaptionLbl)
    //                 {
    //                 }
    //                 column(Date_de_livraison__Caption; Date_de_livraison__CaptionLbl)
    //                 {
    //                 }
    //                 column(AffectationCaption; AffectationCaptionLbl)
    //                 {
    //                 }
    //                 column(Lieu_de_livraisonCaption; Lieu_de_livraisonCaptionLbl)
    //                 {
    //                 }
    //                 column(Fournisseur__Caption; Fournisseur__CaptionLbl)
    //                 {
    //                 }
    //                 column(SOROUBATCaption; SOROUBATCaptionLbl)
    //                 {
    //                 }
    //                 column(Bon_de_commandeCaption; Bon_de_commandeCaptionLbl)
    //                 {
    //                 }
    //                 column(DataItem1000000121; Avenue_de_la_gare_Megrine_Riadh___2014_BEN_AROUS___Code_TVA_1864_Y_A_M_000_Site_www_groupesoroubat_com_TélSiège___Lbl)
    //                 {
    //                 }
    //                 column(PageLoop_Number; Number)
    //                 {
    //                 }
    //                 dataitem(DimensionLoop1; 2000000026)
    //                 {
    //                     DataItemLinkReference = "Purchase Header";
    //                     DataItemTableView = SORTING(Number)
    //                                         WHERE(Number = FILTER(1 ..));

    //                     trigger OnAfterGetRecord()
    //                     begin
    //                         IF Number = 1 THEN BEGIN
    //                             IF NOT DocDim1.FIND('-') THEN
    //                                 CurrReport.BREAK;
    //                         END ELSE
    //                             IF NOT Continue THEN
    //                                 CurrReport.BREAK;

    //                         CLEAR(DimText);
    //                         Continue := FALSE;
    //                         REPEAT
    //                             OldDimText := DimText;
    //                             IF DimText = '' THEN
    //                                 DimText := STRSUBSTNO(
    //                                   '%1 %2', DocDim1."Dimension Code", DocDim1."Dimension Code")
    //                             ELSE
    //                                 DimText :=
    //                                   STRSUBSTNO(
    //                                     '%1, %2 %3', DimText,
    //                                     DocDim1."Dimension Code", DocDim1."Dimension Code");
    //                             IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
    //                                 DimText := OldDimText;
    //                                 Continue := TRUE;
    //                                 EXIT;
    //                             END;
    //                         UNTIL (DocDim1.NEXT = 0);
    //                     end;

    //                     trigger OnPreDataItem()
    //                     begin
    //                         IF NOT ShowInternalInfo THEN
    //                             CurrReport.BREAK;
    //                     end;
    //                 }
    //                 dataitem("Purchase Line"; "Purchase Line")
    //                 {
    //                     DataItemLink = "Document Type" = FIELD("Document Type"),
    //                                    "Document No." = FIELD("No.");
    //                     DataItemLinkReference = "Purchase Header";
    //                     DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");
    //                     column(Purchase_Line_Description; Description)
    //                     {
    //                     }

    //                     column(Purchase_Line_Quantity; Quantity)
    //                     {
    //                     }
    //                     column(Purchase_Line__Line_Discount___; "Line Discount %")
    //                     {
    //                     }
    //                     column(Purchase_Line__Line_Amount_; "Line Amount")
    //                     {
    //                         AutoFormatType = 1;
    //                         DecimalPlaces = 3 : 3;
    //                     }
    //                     column(Purchase_Line__Purchase_Line___Direct_Unit_Cost_; "Purchase Line"."Direct Unit Cost")
    //                     {
    //                         AutoFormatType = 2;
    //                     }
    //                     column(Purchase_Line__VAT___; "VAT %")
    //                     {
    //                     }
    //                     column("DésignationCaption"; DésignationCaptionLbl)
    //                     {
    //                     }
    //                     column("QtéCaption"; QtéCaptionLbl)
    //                     {
    //                     }
    //                     column(RemiseCaption; RemiseCaptionLbl)
    //                     {
    //                     }
    //                     column(Montant_HTCaption; Montant_HTCaptionLbl)
    //                     {
    //                     }
    //                     column(P_U_H_TCaption; P_U_H_TCaptionLbl)
    //                     {
    //                     }
    //                     column(TVACaption; TVACaptionLbl)
    //                     {
    //                     }
    //                     column(Purchase_Line_Document_Type; "Document Type")
    //                     {
    //                     }
    //                     column(Purchase_Line_Document_No_; "Document No.")
    //                     {
    //                     }
    //                     column(Purchase_Line_Line_No_; "Line No.")
    //                     {
    //                     }
    //                     // column(TextGMnt; TextGMnt)
    //                     // {
    //                     // }

    //                     trigger OnAfterGetRecord()
    //                     begin
    //                         //DecLinAmount+="Line Amount";
    //                         DecLinAmount += Amount;
    //                         DecDiffTva += "VAT Difference";
    //                         DecAmountIncludingVAt += "Amount Including VAT"; // "Line Amount"*(1+"VAT %"/100);
    //                         DecMontant += Amount;
    //                         DecDiscountAmount += "Line Discount Amount";
    //                         DecAcompte += "Prepmt. Line Amount";
    //                         DecMontantTVA += "Amount Including VAT" - Amount;
    //                         //DecMontantTVA+=DecAmountIncludingVAt-DecLinAmount+DecDiffTva;
    //                         IF DecTauxTva = 0 THEN DecTauxTva := "VAT %";
    //                         //   Message(Format(ROUND(DecLinAmount, 1)));
    //                     end;

    //                     trigger OnPreDataItem()
    //                     var

    //                         RecPurchaseLine: Record "Purchase Line";
    //                         TotalVat: Decimal;
    //                     begin
    //                         TotalVat := 0;
    //                         RecPurchaseLine.Reset();
    //                         RecPurchaseLine.SetRange("Document No.", "purchase header"."No.");
    //                         RecPurchaseLine.SetRange("Document Type", "purchase header"."Document Type");
    //                         if RecPurchaseLine.FindSet() then
    //                             repeat
    //                                 TotalVat += RecPurchaseLine."Amount Including VAT";
    //                             until RecPurchaseLine.Next() = 0;
    //                         //CurrReport.BREAK;
    //                         IF "Purchase Header"."Currency Code" = '' THEN
    //                             CodeU."Montant en texte sans millimes"(TextGMnt, ROUND(TotalVat, 1))
    //                         ELSE
    //                             CodeU."Montant en texteDevise"(TextGMnt, ROUND(TotalVat, 1), "Purchase Header"."Currency Code");
    //                         CurrReport.SHOWOUTPUT(NOT BlnAfficher);
    //                         // Message(TextGMnt);

    //                     end;
    //                 }
    //                 /*     dataitem(Saut; 2000000026)
    //                      {
    //                          DataItemTableView = SORTING(Number);
    //                          column(Saut_Number; Number)
    //                          {
    //                          }
    //                      }*/
    //                 //HS
    //                 dataitem(Loop; Integer)
    //                 {
    //                     DataItemTableView = sorting(Number) where(Number = filter(1 .. 16));
    //                     column(Number;
    //                     Number)
    //                     { }
    //                     trigger OnPreDataItem()
    //                     var
    //                         rep: Report "Sales - Shipment";
    //                         inb: Integer;
    //                     begin
    //                         inb := Loop.Count - "Purchase Line".Count;
    //                         //   Message(Format("Purchase request Line".Count));
    //                         //  Message(Format(Loop.Count));
    //                         Reset();
    //                         SetRange(Number, 1, inb);
    //                         /*  if "Purchase request Line".Count > 30 then begin
    //                               inb := Loop.Count + "Purchase request Line".Count;
    //                               Reset();
    //                               SetRange(Number, 1, inb);
    //                           end;*/

    //                     end;
    //                 }
    //                 dataitem(DetailTva; 2000000026)
    //                 {
    //                     DataItemTableView = SORTING(Number)
    //                                         WHERE(Number = CONST(1));
    //                     // column(Purchase_Header___Shipment_Remark_; "Purchase Header"."Shipment Remark")
    //                     // {
    //                     // }
    //                     // column(ROUND_DecLinAmount_1_; ROUND(DecLinAmount, 1))
    //                     // {
    //                     // }
    //                     // column(DecTauxTva; DecTauxTva)
    //                     // {
    //                     // }
    //                     // column(ROUND_DecMontantTVA_1_; ROUND(DecMontantTVA, 1))
    //                     // {
    //                     // }
    //                     // column(DecTotalBrut; DecTotalBrut)
    //                     // {
    //                     //     DecimalPlaces = 3 : 3;
    //                     // }
    //                     // column(TextGMnt; TextGMnt)
    //                     // {
    //                     // }
    //                     // column(DecDiscountAmount; DecDiscountAmount)
    //                     // {
    //                     //     DecimalPlaces = 3 : 3;
    //                     // }
    //                     // column(PaymentTerms_Description; PaymentTerms.Description)
    //                     // {
    //                     // }
    //                     // column(Purchase_Header___Pay_to_Address_2_; "Purchase Header"."Pay-to Address 2")
    //                     // {
    //                     // }
    //                     // column(DecLinAmount; DecLinAmount)
    //                     // {
    //                     //     DecimalPlaces = 3 : 3;
    //                     // }
    //                     // column(DecAmountIncludingVAt; DecAmountIncludingVAt)
    //                     // {
    //                     //     DecimalPlaces = 3 : 3;
    //                     // }

    //                     column(TaxeCaption; TaxeCaptionLbl)
    //                     {
    //                     }
    //                     column(BaseCaption; BaseCaptionLbl)
    //                     {
    //                     }
    //                     column(TauxCaption; TauxCaptionLbl)
    //                     {
    //                     }
    //                     column(MontantCaption; MontantCaptionLbl)
    //                     {
    //                     }
    //                     column(Total_TTCCaption; Total_TTCCaptionLbl)
    //                     {
    //                     }
    //                     column(Montant_Brut_HTCaption; Montant_Brut_HTCaptionLbl)
    //                     {
    //                     }
    //                     column(Total_RemiseCaption; Total_RemiseCaptionLbl)
    //                     {
    //                     }
    //                     column(Montant_Total_HTCaption; Montant_Total_HTCaptionLbl)
    //                     {
    //                     }
    //                     column(TVDCaption; TVDCaptionLbl)
    //                     {
    //                     }
    //                     column("Arrêté_le_présent_bon_de_commande_à_la_somme_Caption"; Arrêté_le_présent_bon_de_commande_à_la_somme_CaptionLbl)
    //                     {
    //                     }
    //                     column(Moyen_de_paiement__Caption; Moyen_de_paiement__CaptionLbl)
    //                     {
    //                     }
    //                     column(Observation__Caption; Observation__CaptionLbl)
    //                     {
    //                     }
    //                     column(Service_AchatCaption; Service_AchatCaptionLbl)
    //                     {
    //                     }
    //                     column(DIRECTEUR_ACHATCaption; DIRECTEUR_ACHATCaptionLbl)
    //                     {
    //                     }
    //                     column("La_Direction_GénéraleCaption"; La_Direction_GénéraleCaptionLbl)
    //                     {
    //                     }
    //                     column(DetailTva_Number; Number)
    //                     {
    //                     }

    //                     trigger OnAfterGetRecord()
    //                     begin



    //                     end;
    //                 }
    //                 trigger OnPreDataItem()
    //                 var
    //                 begin

    //                 end;
    //             }

    //             trigger OnAfterGetRecord()
    //             var
    //                 PrepmtPurchLine: Record "Purchase Line" temporary;
    //                 DocDim: Record 357;
    //                 TempPurchLine: Record "Purchase Line" temporary;
    //             begin
    //                 EXIT;
    //                 CLEAR(PurchLine);
    //                 CLEAR(PurchPost);
    //                 PurchLine.DELETEALL;
    //                 VATAmountLine.DELETEALL;
    //                 PurchPost.GetPurchLines("Purchase Header", PurchLine, 0);
    //                 PurchLine.CalcVATAmountLines(0, "Purchase Header", PurchLine, VATAmountLine);
    //                 PurchLine.UpdateVATOnLines(0, "Purchase Header", PurchLine, VATAmountLine);
    //                 VATAmount := VATAmountLine.GetTotalVATAmount;
    //                 VATBaseAmount := VATAmountLine.GetTotalVATBase;
    //                 VATDiscountAmount :=
    //                   VATAmountLine.GetTotalVATDiscount("Purchase Header"."Currency Code", "Purchase Header"."Prices Including VAT");
    //                 TotalAmountInclVAT := VATAmountLine.GetTotalAmountInclVAT;

    //                 PrepmtInvBuf.DELETEALL;
    //                 PurchPostPrepmt.GetPurchLines("Purchase Header", 0, PrepmtPurchLine);
    //                 IF (NOT PrepmtPurchLine.ISEMPTY) THEN BEGIN
    //                     PurchPostPrepmt.GetPurchLinesToDeduct("Purchase Header", TempPurchLine);
    //                     IF NOT TempPurchLine.ISEMPTY THEN
    //                         PurchPostPrepmt.CalcVATAmountLines("Purchase Header", TempPurchLine, PrePmtVATAmountLineDeduct, 1);
    //                 END;
    //                 PurchPostPrepmt.CalcVATAmountLines("Purchase Header", PrepmtPurchLine, PrepmtVATAmountLine, 0);
    //                 IF PrepmtVATAmountLine.FINDSET THEN
    //                     REPEAT
    //                         PrePmtVATAmountLineDeduct := PrepmtVATAmountLine;
    //                         IF PrePmtVATAmountLineDeduct.FIND THEN BEGIN
    //                             PrepmtVATAmountLine."VAT Base" := PrepmtVATAmountLine."VAT Base" - PrePmtVATAmountLineDeduct."VAT Base";
    //                             PrepmtVATAmountLine."VAT Amount" := PrepmtVATAmountLine."VAT Amount" - PrePmtVATAmountLineDeduct."VAT Amount";
    //                             PrepmtVATAmountLine."Amount Including VAT" := PrepmtVATAmountLine."Amount Including VAT" -
    //                               PrePmtVATAmountLineDeduct."Amount Including VAT";
    //                             PrepmtVATAmountLine."Line Amount" := PrepmtVATAmountLine."Line Amount" - PrePmtVATAmountLineDeduct."Line Amount";
    //                             PrepmtVATAmountLine."Inv. Disc. Base Amount" := PrepmtVATAmountLine."Inv. Disc. Base Amount" -
    //                               PrePmtVATAmountLineDeduct."Inv. Disc. Base Amount";
    //                             PrepmtVATAmountLine."Invoice Discount Amount" := PrepmtVATAmountLine."Invoice Discount Amount" -
    //                               PrePmtVATAmountLineDeduct."Invoice Discount Amount";
    //                             PrepmtVATAmountLine."Calculated VAT Amount" := PrepmtVATAmountLine."Calculated VAT Amount" -
    //                               PrePmtVATAmountLineDeduct."Calculated VAT Amount";
    //                             PrepmtVATAmountLine.MODIFY;
    //                         END;
    //                     UNTIL PrepmtVATAmountLine.NEXT = 0;
    //                 PurchPostPrepmt.UpdateVATOnLines("Purchase Header", PrepmtPurchLine, PrepmtVATAmountLine, 0);
    //                 //GL2024 PurchPostPrepmt.BuildInvLineBuffer2("Purchase Header",PrepmtPurchLine,0,PrepmtInvBuf,DocDim);
    //                 //   PurchPostPrepmt.BuildInvLineBuffer2("Purchase Header", PrepmtPurchLine, 0, PrepmtInvBuf);
    //                 PrepmtVATAmount := PrepmtVATAmountLine.GetTotalVATAmount;
    //                 PrepmtVATBaseAmount := PrepmtVATAmountLine.GetTotalVATBase;
    //                 PrepmtTotalAmountInclVAT := PrepmtVATAmountLine.GetTotalAmountInclVAT;

    //                 IF Number > 1 THEN
    //                     CopyText := Text003;
    //                 CurrReport.PAGENO := 1;

    //                 IF ISSERVICETIER THEN
    //                     OutputNo := OutputNo + 1;
    //             end;

    //             trigger OnPostDataItem()
    //             begin

    //                 IF NOT CurrReport.PREVIEW THEN
    //                     PurchCountPrinted.RUN("Purchase Header");
    //             end;

    //             trigger OnPreDataItem()
    //             var
    //             begin


    //                 NoOfLoops := ABS(NoOfCopies) + 1;
    //                 CopyText := '';
    //                 SETRANGE(Number, 1, NoOfLoops);

    //                 IF ISSERVICETIER THEN
    //                     OutputNo := 0;
    //             end;


    //         }

    //         trigger OnAfterGetRecord()
    //         var
    //             RecPurCommentLine: Record "Purch. Comment Line";
    //             RecShiptoAddress: Record "Ship-to Address";

    //         begin
    //             "Purchase Header".CalcFields("Nom Lieu Liv");
    //             // Message(Format("Purchase Header"."Montant Timbre"));
    //             IF RecLVendorPostingGroup.GET("Purchase Header"."Vendor Posting Group") THEN;
    //             RecLPurchLine.RESET;
    //             RecLPurchLine.SETRANGE("Document Type", "Purchase Header"."Document Type");
    //             RecLPurchLine.SETRANGE("Document No.", "Purchase Header"."No.");
    //             RecLPurchLine.SETRANGE("Document No.", RecLVendorPostingGroup."Stamp Fiscal Law93/53");
    //             //* Test si d‚j… existe timbre fiscal


    //             IF G_RecVend.GET("Buy-from Vendor No.") THEN;
    //             //    CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");

    //             CompanyInfo.GET;

    //             IF RespCenter.GET("Responsibility Center") THEN BEGIN
    //                 FormatAddr.RespCenter(CompanyAddr, RespCenter);
    //                 CompanyInfo."Phone No." := RespCenter."Phone No.";
    //                 CompanyInfo."Fax No." := RespCenter."Fax No.";
    //             END ELSE
    //                 FormatAddr.Company(CompanyAddr, CompanyInfo);

    //             // DocDim1.SETRANGE("Table ID", DATABASE::"Purchase Header");
    //             // DocDim1.SETRANGE("Document Type", "Purchase Header"."Document Type");
    //             // DocDim1.SETRANGE("Document No.", "Purchase Header"."No.");

    //             IF "Purchaser Code" = '' THEN BEGIN
    //                 SalesPurchPerson.INIT;
    //                 PurchaserText := '';
    //             END ELSE BEGIN
    //                 SalesPurchPerson.GET("Purchaser Code");
    //                 PurchaserText := Text000
    //             END;
    //             IF "Your Reference" = '' THEN
    //                 ReferenceText := ''
    //             ELSE
    //                 ReferenceText := FIELDCAPTION("Your Reference");
    //             IF "VAT Registration No." = '' THEN
    //                 VATNoText := ''
    //             ELSE
    //                 VATNoText := FIELDCAPTION("VAT Registration No.");
    //             IF "Currency Code" = '' THEN BEGIN
    //                 GLSetup.TESTFIELD("LCY Code");
    //                 TotalText := STRSUBSTNO(Text001, GLSetup."LCY Code");
    //                 TotalInclVATText := STRSUBSTNO(Text002, GLSetup."LCY Code");
    //                 TotalExclVATText := STRSUBSTNO(Text006, GLSetup."LCY Code");
    //             END ELSE BEGIN
    //                 TotalText := STRSUBSTNO(Text001, "Currency Code");
    //                 TotalInclVATText := STRSUBSTNO(Text002, "Currency Code");
    //                 TotalExclVATText := STRSUBSTNO(Text006, "Currency Code");
    //             END;

    //             FormatAddr.PurchHeaderBuyFrom(BuyFromAddr, "Purchase Header");
    //             IF ("Purchase Header"."Buy-from Vendor No." <> "Purchase Header"."Pay-to Vendor No.") THEN
    //                 FormatAddr.PurchHeaderPayTo(VendAddr, "Purchase Header");
    //             IF "Payment Terms Code" = '' THEN
    //                 PaymentTerms.INIT
    //             ELSE BEGIN
    //                 PaymentTerms.GET("Payment Terms Code");
    //                 PaymentTerms.TranslateDescription(PaymentTerms, "Language Code");
    //             END;
    //             IF "Prepmt. Payment Terms Code" = '' THEN
    //                 PrepmtPaymentTerms.INIT
    //             ELSE BEGIN
    //                 PrepmtPaymentTerms.GET("Prepmt. Payment Terms Code");
    //                 PrepmtPaymentTerms.TranslateDescription(PrepmtPaymentTerms, "Language Code");
    //             END;
    //             IF "Shipment Method Code" = '' THEN
    //                 ShipmentMethod.INIT
    //             ELSE BEGIN
    //                 ShipmentMethod.GET("Shipment Method Code");
    //                 ShipmentMethod.TranslateDescription(ShipmentMethod, "Language Code");
    //             END;

    //             IF RecPaymentMethod.GET("Payment Method Code") THEN;
    //             FormatAddr.PurchHeaderShipTo(ShipToAddr, "Purchase Header");

    //             IF NOT CurrReport.PREVIEW THEN BEGIN
    //                 IF ArchiveDocument THEN
    //                     ArchiveManagement.StorePurchDocument("Purchase Header", LogInteraction);

    //                 IF LogInteraction THEN BEGIN
    //                     CALCFIELDS("No. of Archived Versions");
    //                     SegManagement.LogDocument(
    //                       13, "No.", "Doc. No. Occurrence", "No. of Archived Versions", DATABASE::Vendor, "Buy-from Vendor No.",
    //                       "Purchaser Code", '', "Posting Description", '');
    //                 END;
    //             END;

    //             IF ISSERVICETIER THEN
    //                 PricesInclVATtxt := FORMAT("Purchase Header"."Prices Including VAT");

    //             IF RecAffectation.GET("Purchase Header"."Purchaser Code") THEN;
    //             Affect := RecAffectation.Name;
    //             //Lieu := RecShiptoAddress."Nom Lieu Liv";
    //             // IF Reclieulivraison.GET("Purchase Header"."Entry Point") THEN;
    //             // Lieu := Reclieulivraison.Description;
    //             IF RecShiptoAddress.GET("Purchase Header"."Sell-to Customer No.", "Purchase Header"."Ship-to Code") THEN;
    //             // Lieu := RecShiptoAddress.Address;
    //             RecPurCommentLine.Reset();
    //             RecPurCommentLine.SetRange("Document Type", "purchase header"."Document Type");
    //             RecPurCommentLine.SetRange("No.", "purchase header"."No.");
    //             RecPurCommentLine.SetFilter("Line No.", '%1|%2|%3', 10000, 20000, 30000);
    //             RecPurCommentLine.SetRange("Document Line No.", 0);
    //             if RecPurCommentLine.FindSet() then begin
    //                 repeat
    //                     if RecPurCommentLine."Line No." = 10000 then
    //                         comment1 := RecPurCommentLine."Dys Comment";
    //                     if RecPurCommentLine."Line No." = 20000 then
    //                         comment2 := RecPurCommentLine."Dys Comment";
    //                     if RecPurCommentLine."Line No." = 30000 then
    //                         comment3 := RecPurCommentLine."Dys Comment";

    //                 until RecPurCommentLine.Next() = 0;
    //             end;
    //         end;

    //         trigger OnPreDataItem()
    //         var
    //         begin
    //             if RecCompInf.get() then
    //                 RecCompInf.CalcFields(Picture);
    //         end;
    //     }
    // }

    // requestpage
    // {
    //     SaveValues = true;

    //     layout
    //     {
    //         area(content)
    //         {
    //             group(Options)
    //             {
    //                 Caption = 'Options';
    //                 field(NoOfCopies; NoOfCopies)
    //                 {
    //                     Caption = 'Nombre de copies';
    //                 }
    //                 field(ShowInternalInfo; ShowInternalInfo)
    //                 {
    //                     Caption = 'Afficher info. internes';
    //                 }
    //                 field(ArchiveDocument; ArchiveDocument)
    //                 {
    //                     Caption = 'Archiver document';

    //                     trigger OnValidate()
    //                     begin
    //                         IF NOT ArchiveDocument THEN
    //                             LogInteraction := FALSE;
    //                     end;
    //                 }
    //                 field(LogInteraction; LogInteraction)
    //                 {
    //                     Caption = 'Journal interaction';
    //                     Enabled = LogInteractionEnable;

    //                     trigger OnValidate()
    //                     begin
    //                         IF LogInteraction THEN
    //                             ArchiveDocument := ArchiveDocumentEnable;
    //                     end;
    //                 }
    //             }
    //         }
    //     }

    //     actions
    //     {
    //     }

    //     trigger OnInit()
    //     begin
    //         LogInteractionEnable := TRUE;
    //     end;

    //     trigger OnOpenPage()
    //     begin
    //         //#8609
    //         //ArchiveDocument := PurchSetup."Archive Quotes and Orders";
    //         // ArchiveDocument := (PurchSetup."Archive Quotes and ") AND
    //         //                    ((PurchSetup."Archiving Method" = PurchSetup."Archiving Method"::Standard) OR
    //         //                     (PurchSetup."Archiving Method" = PurchSetup."Archiving Method"::Standard));
    //         //#8609//
    //         LogInteraction := SegManagement.FindInteractTmplCode(13) <> '';

    //         LogInteractionEnable := LogInteraction;
    //     end;
    // }

    // labels
    // {
    // }

    // trigger OnInitReport()
    // begin
    //     GLSetup.GET;
    //     PurchSetup.GET;
    // end;

    // var
    //     RecLPurchLine: Record "Purchase Line";
    //     RecLVendorPostingGroup: Record "Vendor Posting Group";
    //     Text000: Label 'Acheteur';
    //     Text001: Label 'Total %1';
    //     Text002: Label 'Total %1 TTC';
    //     Text003: Label 'COPIE';
    //     Text004: Label 'Commande %1';
    //     Text005: Label 'Page %1';
    //     Text006: Label 'Total %1 HT';
    //     GLSetup: Record 98;
    //     CompanyInfo: Record 79;
    //     ShipmentMethod: Record 10;
    //     PaymentTerms: Record 3;
    //     PrepmtPaymentTerms: Record 3;
    //     SalesPurchPerson: Record 13;
    //     VATAmountLine: Record 290 temporary;
    //     PrepmtVATAmountLine: Record 290 temporary;
    //     PrePmtVATAmountLineDeduct: Record 290 temporary;
    //     PurchLine: Record 39 temporary;
    //     DocDim1: Record 357;
    //     DocDim2: Record 357;
    //     PrepmtDocDim: Record 357 temporary;
    //     PrepmtInvBuf: Record 461 temporary;
    //     RespCenter: Record 5714;
    //     Language: Record 8;
    //     CurrExchRate: Record 330;
    //     RecCompInf: Record "Company Information";
    //     PurchSetup: Record 312;
    //     PurchCountPrinted: Codeunit 317;
    //     FormatAddr: Codeunit 365;
    //     PurchPost: Codeunit 90;
    //     ArchiveManagement: Codeunit 5063;
    //     SegManagement: Codeunit 5051;
    //     PurchPostPrepmt: Codeunit 444;
    //     VendAddr: array[8] of Text[50];
    //     ShipToAddr: array[8] of Text[50];
    //     CompanyAddr: array[8] of Text[50];
    //     BuyFromAddr: array[8] of Text[50];
    //     PurchaserText: Text[30];
    //     VATNoText: Text[80];
    //     comment1, comment2, comment3 : text[150];
    //     ReferenceText: Text[80];
    //     TotalText: Text[50];
    //     TotalInclVATText: Text[50];
    //     TotalExclVATText: Text[50];
    //     MoreLines: Boolean;
    //     NoOfCopies: Integer;
    //     NoOfLoops: Integer;
    //     CopyText: Text[30];
    //     OutputNo: Integer;
    //     DimText: Text[120];
    //     OldDimText: Text[75];
    //     ShowInternalInfo: Boolean;
    //     Continue: Boolean;
    //     ArchiveDocument: Boolean;
    //     LogInteraction: Boolean;
    //     VATAmount: Decimal;
    //     VATBaseAmount: Decimal;
    //     VATDiscountAmount: Decimal;
    //     TotalAmountInclVAT: Decimal;
    //     VALVATBaseLCY: Decimal;
    //     VALVATAmountLCY: Decimal;
    //     VALSpecLCYHeader: Text[80];
    //     VALExchRate: Text[50];
    //     Text007: Label 'Détail TVA dans ';
    //     Text008: Label 'Devise société';
    //     Text009: Label 'Taux de change : %1/%2';
    //     PrepmtVATAmount: Decimal;
    //     PrepmtVATBaseAmount: Decimal;
    //     PrepmtAmountInclVAT: Decimal;
    //     PrepmtTotalAmountInclVAT: Decimal;
    //     PrepmtLineAmount: Decimal;
    //     PricesInclVATtxt: Text[30];
    //     AllowInvDisctxt: Text[30];
    //     [InDataSet]
    //     ArchiveDocumentEnable: Boolean;
    //     [InDataSet]
    //     LogInteractionEnable: Boolean;
    //     G_RecVend: Record 23;
    //     MontantBrut: Decimal;
    //     CountLine: Integer;
    //     CodeU: Codeunit 50005;
    //     TextGMnt: Text[250];
    //     RecPaymentMethod: Record 289;
    //     BlnAfficher: Boolean;
    //     IntCompteur: Integer;
    //     DecLinAmount: Decimal;
    //     DecAmountIncludingVAt: Decimal;
    //     DecDiscountAmount: Decimal;
    //     DecAcompte: Decimal;
    //     DecMontantTVA: Decimal;
    //     IntCompteurAffichage: Integer;
    //     DecTauxTva: Decimal;
    //     DecDiffTva: Decimal;
    //     DecMontant: Decimal;
    //     DecTotalBrut: Decimal;
    //     PageConst: Label 'Page';
    //     RecAffectation: Record 13;
    //     Affect: Text[30];
    //     Reclieulivraison: Record 282;
    //     Lieu: Text[100];
    //     XXXXXXXCaptionLbl: Label 'XXXXXXX';
    //     XXXXXXXCaption_Control1000000091Lbl: Label 'XXXXXXX';
    //     XXXXXXXCaption_Control1000000094Lbl: Label 'XXXXXXX';
    //     XXXXXXXCaption_Control1000000108Lbl: Label 'XXXXXXX';
    //     XXXXXXXCaption_Control1000000110Lbl: Label 'XXXXXXX';
    //     XXXXXXXCaption_Control1000000092Lbl: Label 'XXXXXXX';
    //     XXXXXXXCaption_Control1000000105Lbl: Label 'XXXXXXX';
    //     XXXXXXXCaption_Control1000000109Lbl: Label 'XXXXXXX';
    //     N__de_CommandeCaptionLbl: Label 'N° de Commande';
    //     DateCaptionLbl: Label 'Date';
    //     Date_DA__CaptionLbl: Label 'Date DA :';
    //     D_A_N___CaptionLbl: Label 'D.A.N° :';
    //     "Référence__CaptionLbl": Label 'Référence :';
    //     Date_de_livraison__CaptionLbl: Label 'Date de livraison :';
    //     AffectationCaptionLbl: Label 'Affectation';
    //     Lieu_de_livraisonCaptionLbl: Label 'Lieu de livraison';
    //     Fournisseur__CaptionLbl: Label 'Fournisseur :';
    //     SOROUBATCaptionLbl: Label 'SOROUBAT';
    //     Bon_de_commandeCaptionLbl: Label 'Bon de commande';
    //     "Avenue_de_la_gare_Megrine_Riadh___2014_BEN_AROUS___Code_TVA_1864_Y_A_M_000_Site_www_groupesoroubat_com_TélSiège___Lbl": Label 'Avenue de la gare Megrine Riadh \ 2014 BEN AROUS \ Code TVA : 1864 Y/A/M/000 - Site : www.groupesoroubat.com \ Tél.: Siège : 71 433 120 - Tél.: Appro : 71 427 868 \ Télécopie Siège : 71 433 074 - Télécopie Appro : 71 429 508 \ CERTIFIEE ISO 9001 - VERSION 2008';
    //     "DésignationCaptionLbl": Label 'Désignation';
    //     "QtéCaptionLbl": Label 'Qté';
    //     RemiseCaptionLbl: Label 'Remise';
    //     Montant_HTCaptionLbl: Label 'Montant HT';
    //     P_U_H_TCaptionLbl: Label 'P.U.H.T';
    //     TVACaptionLbl: Label '%TVA';
    //     TaxeCaptionLbl: Label 'Taxe';
    //     BaseCaptionLbl: Label 'Base';
    //     TauxCaptionLbl: Label 'Taux';
    //     MontantCaptionLbl: Label 'Montant';
    //     Total_TTCCaptionLbl: Label 'Total TTC';
    //     Montant_Brut_HTCaptionLbl: Label 'Montant Brut HT';
    //     Total_RemiseCaptionLbl: Label 'Total Remise';
    //     Montant_Total_HTCaptionLbl: Label 'Montant Total HT';
    //     TVDCaptionLbl: Label ' TVD';
    //     "Arrêté_le_présent_bon_de_commande_à_la_somme_CaptionLbl": Label 'Arrêté le présent bon de commande à la somme:';
    //     Moyen_de_paiement__CaptionLbl: Label 'Moyen de paiement :';
    //     Observation__CaptionLbl: Label 'Observation :';
    //     Service_AchatCaptionLbl: Label 'Service Achat';
    //     DIRECTEUR_ACHATCaptionLbl: Label 'DIRECTEUR ACHAT';
    //     "La_Direction_GénéraleCaptionLbl": Label 'La Direction Générale';
}
