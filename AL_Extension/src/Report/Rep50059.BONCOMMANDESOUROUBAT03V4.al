report 50059 "BON COMMANDE SOUROUBAT 03 V4"
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/BONCOMMANDESOUROUBAT03V4.rdl';
    // Caption = 'Order';

    // dataset

    // {
    //     dataitem("Purchase Header"; "Purchase Header")
    //     {
    //         DataItemTableView = SORTING("Document Type", "No.");
    //         RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
    //         RequestFilterHeading = 'Purchase Order';
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
    //                 column(OBS1; OBS1)
    //                 {
    //                 }
    //                 column(OBS2; OBS2)
    //                 {
    //                 }
    //                 column(OBS3; OBS3)
    //                 {
    //                 }
    //                 column(MontantTimbre; RecLPurchLine."Direct Unit Cost") { }
    //                 column(PaymentTerms_Description; PaymentTerms.Description)
    //                 {
    //                 }
    //                 column(Observation_1; "Purchase Header"."Observation 1") { }
    //                 column(Observation_2; "Purchase Header"."Observation 2") { }
    //                 column(Observation_3; "Purchase Header"."Observation 3") { }
    //                 column(Purchase_Header___No__; "Purchase Header"."No.")
    //                 {
    //                 }
    //                 column(NDAChantier; "Purchase Header"."N° DA Chantier") { }
    //                 column(Purchase_header_Finance; "Purchase Header".Finance) { }
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
    //                 // column(Lieu; Lieu)
    //                 // {
    //                 // }
    //                 column(Lieu; "Purchase Header"."Nom Lieu Liv")
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
    //                 column(Purchase_Header___Purchaser_Code_; "Purchase Header"."Purchaser Code")
    //                 {
    //                 }
    //                 /*  column(Purchase_Header___N__DA_Chantier_; "Purchase Header"."N° DA Chantier")
    //                   {
    //                   }*/
    //                 column(PageLoop_Number; Number)
    //                 {
    //                 }
    //                 /*   dataitem(DimensionLoop1; 2000000026)
    //                    {
    //                        DataItemLinkReference = "Purchase Header";
    //                        DataItemTableView = SORTING(Number)
    //                                            WHERE(Number = FILTER(1 ..));

    //                        trigger OnAfterGetRecord()
    //                        begin
    //                            IF Number = 1 THEN BEGIN
    //                                IF NOT DocDim1.FIND('-') THEN
    //                                    CurrReport.BREAK;
    //                            END ELSE
    //                                IF NOT Continue THEN
    //                                    CurrReport.BREAK;

    //                            CLEAR(DimText);
    //                            Continue := FALSE;
    //                            REPEAT
    //                                OldDimText := DimText;
    //                                IF DimText = '' THEN
    //                                    DimText := STRSUBSTNO(
    //                                      '%1 %2', DocDim1."Dimension Code", DocDim1."Dimension Code")
    //                                ELSE
    //                                    DimText :=
    //                                      STRSUBSTNO(
    //                                        '%1, %2 %3', DimText,
    //                                        DocDim1."Dimension Code", DocDim1."Dimension Code");
    //                                IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
    //                                    DimText := OldDimText;
    //                                    Continue := TRUE;
    //                                    EXIT;
    //                                END;
    //                            UNTIL (DocDim1.NEXT = 0);
    //                        end;

    //                        trigger OnPreDataItem()
    //                        begin
    //                            IF NOT ShowInternalInfo THEN
    //                                CurrReport.BREAK;
    //                        end;
    //                    }*/
    //                 /*    dataitem(Saut; 2000000026)
    //                     {
    //                         DataItemTableView = SORTING(Number);
    //                     }*/

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
    //                     column(PurchaseLineNo; "Line No.") { }
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
    //                     column(COPYSTR_FORMAT_Type__1_1_; COPYSTR(FORMAT(Type), 1, 1))
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
    //                     column(Purch__Comment_Line_Comment; Commenttext)
    //                     {
    //                     }
    //                     column(Purch__Comment_Line_Line_No_; ComentLineNo)
    //                     {
    //                     }
    //                     column(PageBreak; PageBreak) { }
    //                     /*    dataitem("Purchase Line 2"; "Purchase Line")
    //                         {
    //                             DataItemLink = "Document Type" = FIELD("Document Type"),
    //                                            "Document No." = FIELD("Document No."),
    //                                            "Line No." = FIELD("Line No.");
    //                             DataItemLinkReference = "Purchase Line";
    //                             DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");
    //                                column("Non_Disponible_Délai_Livraison_____FORMAT__Délai_Livraison__"; '*** Non Disponible Délai Livraison : ' + FORMAT("Délai Livraison"))
    //                                {
    //                                }
    //                             column(Purchase_Line_2_Document_Type; "Document Type")
    //                             {
    //                             }
    //                             column(Purchase_Line_2_Document_No_; "Document No.")
    //                             {
    //                             }
    //                             column(Purchase_Line_2_Line_No_; "Line No.")
    //                             {
    //                             }
    //                         }*/
    //                     /*  dataitem("Purch. Comment Line"; "Purch. Comment Line")
    //                       {
    //                           DataItemLink = "Document Type" = FIELD("Document Type"),
    //                                          "No." = FIELD("Document No."),
    //                                          "Document Line No." = FIELD("Line No.");
    //                           column(Purch__Comment_Line_Comment; Comment)
    //                           {
    //                           }
    //                           column(Purch__Comment_Line_Document_Type; "Document Type")
    //                           {
    //                           }
    //                           column(Purch__Comment_Line_No_; "No.")
    //                           {
    //                           }
    //                           column(Purch__Comment_Line_Document_Line_No_; "Document Line No.")
    //                           {
    //                           }
    //                           column(Purch__Comment_Line_Line_No_; "Line No.")
    //                           {
    //                           }
    //                           trigger OnAfterGetRecord()
    //                           begin


    //                           end;
    //                       }*/

    //                     trigger OnAfterGetRecord()
    //                     var
    //                         LineNo: Integer;
    //                         RecPurcCommentLine: Record "Purch. Comment Line";
    //                         typehelper: Codeunit "Type Helper";
    //                         Crlf: Text[2];

    //                     begin
    //                         CommentText := '';
    //                         Crlf := typehelper.CRLFSeparator();
    //                         ComentLineNo := 0;
    //                         // PageBreak += 1;
    //                         // IF PageBreak = 3 THEN BEGIN
    //                         //     BlnAfficher := TRUE;
    //                         //     CurrReport.NEWPAGE;
    //                         //     PageBreak := 1;
    //                         // END;
    //                         //DecLinAmount+="Line Amount";
    //                         RecPurcCommentLine.Reset();
    //                         RecPurcCommentLine.SetRange("Document Type", "Purchase Line"."Document Type");
    //                         RecPurcCommentLine.SetRange("No.", "Purchase Line"."Document No.");
    //                         RecPurcCommentLine.SetRange("Document Line No.", "Purchase Line"."Line No.");
    //                         if RecPurcCommentLine.FindSet() then begin
    //                             repeat
    //                                 CommentText += RecPurcCommentLine.Comment + Crlf;
    //                                 ComentLineNo := RecPurcCommentLine."Line No.";
    //                             until RecPurcCommentLine.Next() = 0;
    //                         end;
    //                         DecLinAmount += Amount;
    //                         DecDiffTva += "VAT Difference";
    //                         DecAmountIncludingVAt += "Amount Including VAT"; // "Line Amount"*(1+"VAT %"/100);
    //                         DecMontant += Amount;
    //                         DecDiscountAmount += "Line Discount Amount";
    //                         DecAcompte += "Prepmt. Line Amount";
    //                         IF "Purchase Line"."No." <> 'FODEC' THEN
    //                             DecTotalBrut += "Direct Unit Cost" * Quantity;


    //                         /*  CurrReport.SHOWOUTPUT(NOT "Ligne Fodec");
    //                           IF NOT "Ligne Fodec" THEN IntCompteur += 1;
    //                           IF IntCompteur = 15 THEN BEGIN
    //                               BlnAfficher := TRUE;
    //                               CurrReport.NEWPAGE;
    //                               IntCompteur := 1;
    //                           END
    //                           ELSE
    //                               BlnAfficher := FALSE;*/
    //                         IF "Purchase Line".Description = 'FODEC' THEN MontantFODEC += "Purchase Line".Amount;//"Purchase Line"."Amount Including VAT";
    //                     end;

    //                     trigger OnPreDataItem()
    //                     var
    //                         RecPurchaseLine: Record "Purchase Line";
    //                         TotalVat: Decimal;
    //                         RecPurcCommentLine: Record "Purch. Comment Line";
    //                     begin
    //                         //CurrReport.BREAK;
    //                         // ComentLineNo := 0;
    //                         // PurchaseLineCount := 0;
    //                         // RecPurchaseLine.Reset();
    //                         // RecPurchaseLine.SetRange("Document No.", "purchase header"."No.");
    //                         // RecPurchaseLine.SetRange("Document Type", "purchase header"."Document Type");
    //                         // if RecPurchaseLine.FindSet() then
    //                         //     PurchaseLineCount := RecPurchaseLine.Count();
    //                         // RecPurcCommentLine.Reset();
    //                         // RecPurcCommentLine.SetRange("Document Type", "Purchase header"."Document Type");
    //                         // RecPurcCommentLine.SetRange("No.", "Purchase header"."No.");
    //                         // if RecPurcCommentLine.FindSet() then begin
    //                         //     ComentLineNo := RecPurcCommentLine.Count();
    //                         // end;
    //                         // if ComentLineNo = 0 then
    //                         //     PageBreak := 10;
    //                         // if (ComentLineNo > 0) and (PurchaseLineCount >= 10) then begin
    //                         //     PageBreak := Abs(ComentLineNo - PurchaseLineCount);
    //                         // end;
    //                         TotalVat := 0;
    //                         RecPurchaseLine.Reset();
    //                         RecPurchaseLine.SetRange("Document No.", "purchase header"."No.");
    //                         RecPurchaseLine.SetRange("Document Type", "purchase header"."Document Type");
    //                         if RecPurchaseLine.FindSet() then
    //                             repeat
    //                                 TotalVat += RecPurchaseLine."Amount Including VAT";
    //                             until RecPurchaseLine.Next() = 0;
    //                         IF "Purchase Header"."Currency Code" = '' THEN
    //                             CodeU."Montant en texte sans millimes"(TextGMnt, TotalVat)
    //                         ELSE
    //                             CodeU."Montant en texteDevise"(TextGMnt, TotalVat, "Purchase Header"."Currency Code");
    //                         CurrReport.SHOWOUTPUT(NOT BlnAfficher);



    //                     end;
    //                 }
    //                 // dataitem(Saut; 2000000026)
    //                 // {
    //                 //     DataItemTableView = SORTING(Number);
    //                 // }
    //                 // dataitem(Loop; Integer)
    //                 // {
    //                 //     DataItemTableView = sorting(Number) where(Number = filter(1 .. 8));
    //                 //     column(Number;
    //                 //     Number)
    //                 //     { }
    //                 //     trigger OnPreDataItem()
    //                 //     var
    //                 //         rep: Report "Sales - Shipment";
    //                 //         inb: Integer;
    //                 //     begin
    //                 //         inb := Loop.Count - "Purchase Line".Count;
    //                 //         //   Message(Format("Purchase request Line".Count));
    //                 //         //  Message(Format(Loop.Count));
    //                 //         Reset();
    //                 //         SetRange(Number, 1, inb);
    //                 //         /*  if "Purchase request Line".Count > 30 then begin
    //                 //               inb := Loop.Count + "Purchase request Line".Count;
    //                 //               Reset();
    //                 //               SetRange(Number, 1, inb);
    //                 //           end;*/

    //                 //     end;
    //                 // }
    //                 dataitem(DetailTva; 2000000026)
    //                 {
    //                     DataItemTableView = SORTING(Number)
    //                                         WHERE(Number = CONST(1));
    //                     /*   column(OBS1; OBS1)
    //                        {
    //                        }*/
    //                     column(DecBaseTVA; DecBaseTVA)
    //                     {
    //                         DecimalPlaces = 3 : 0;
    //                     }
    //                     column(DecTauxTva; DecTauxTva)
    //                     {
    //                         DecimalPlaces = 3 : 3;
    //                     }
    //                     column(DecMontantTVA; DecMontantTVA)
    //                     {
    //                         DecimalPlaces = 3 : 3;
    //                     }
    //                     column(DecTotalBrut; DecTotalBrut)
    //                     {
    //                         DecimalPlaces = 3 : 3;
    //                     }
    //                     column(TextGMnt; TextGMnt)
    //                     {
    //                     }
    //                     column(DecDiscountAmount; DecDiscountAmount)
    //                     {
    //                         DecimalPlaces = 3 : 3;
    //                     }
    //                     // column(PaymentTerms_Description; PaymentTerms.Description)
    //                     // {
    //                     // }
    //                     column(DecLinAmount; DecLinAmount)
    //                     {
    //                         DecimalPlaces = 3 : 3;
    //                     }
    //                     column(DecAmountIncludingVAt; DecAmountIncludingVAt + RecLPurchLine."Direct Unit Cost")
    //                     {
    //                         //   DecimalPlaces = 3 : 3;
    //                     }
    //                     // column(OBS2; OBS2)
    //                     // {
    //                     // }
    //                     // column(OBS3; OBS3)
    //                     // {
    //                     // }
    //                     column(DecTauxTva2; DecTauxTva2)
    //                     {
    //                         DecimalPlaces = 3 : 3;
    //                     }
    //                     column(DecMontantTVA2; DecMontantTVA2)
    //                     {
    //                         DecimalPlaces = 3 : 3;
    //                     }
    //                     column(DecBaseTVA2; DecBaseTVA2)
    //                     {
    //                         DecimalPlaces = 3 : 0;
    //                     }
    //                     column(DecTauxTva3; DecTauxTva3)
    //                     {
    //                         DecimalPlaces = 3 : 3;
    //                     }
    //                     column(DecMontantTVA3; DecMontantTVA3)
    //                     {
    //                         DecimalPlaces = 3 : 3;
    //                     }
    //                     column(DecBaseTVA3; DecBaseTVA3)
    //                     {
    //                         DecimalPlaces = 3 : 0;
    //                     }
    //                     column(Tva2; Tva2)
    //                     {
    //                     }
    //                     column(Tva3; Tva3)
    //                     {
    //                     }
    //                     column(Tva; Tva)
    //                     {
    //                     }
    //                     column(FORMAT_MontantFODEC_____DT_; FORMAT(MontantFODEC) + '  DT')
    //                     {

    //                         // DecimalPlaces = 3 : 3;
    //                     }
    //                     column("Arrêté_le_présent_bon_de_commande_à_la_somme_Caption"; Arrêté_le_présent_bon_de_commande_à_la_somme_CaptionLbl)
    //                     {
    //                     }
    //                     column(Montant_FODEC__Caption; Montant_FODEC__CaptionLbl)
    //                     {
    //                     }
    //                     column(DetailTva_Number; Number)
    //                     {
    //                     }
    //                 }
    //             }

    //             trigger OnAfterGetRecord()
    //             var
    //                 PrepmtPurchLine: Record 39 temporary;
    //                 DocDim: Record 357;
    //                 TempPurchLine: Record 39 temporary;
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
    //             begin
    //                 NoOfLoops := ABS(NoOfCopies) + 1;
    //                 CopyText := '';
    //                 SETRANGE(Number, 1, NoOfLoops);

    //                 IF ISSERVICETIER THEN
    //                     OutputNo := 0;

    //                 PurchCommentLine.RESET;
    //                 PurchCommentLine.SETRANGE(PurchCommentLine."No.", "Purchase Header"."No.");
    //                 PurchCommentLine.SETRANGE(PurchCommentLine."Line No.", 10000);
    //                 PurchCommentLine.SETRANGE(PurchCommentLine."Document Line No.", 0);
    //                 IF PurchCommentLine.FINDFIRST THEN
    //                     OBS1 := PurchCommentLine."Dys Comment";

    //                 PurchCommentLine.RESET;
    //                 PurchCommentLine.SETRANGE(PurchCommentLine."No.", "Purchase Header"."No.");
    //                 PurchCommentLine.SETRANGE(PurchCommentLine."Line No.", 20000);
    //                 PurchCommentLine.SETRANGE(PurchCommentLine."Document Line No.", 0);
    //                 IF PurchCommentLine.FINDFIRST THEN
    //                     OBS2 := PurchCommentLine."Dys Comment";

    //                 PurchCommentLine.RESET;
    //                 PurchCommentLine.SETRANGE(PurchCommentLine."No.", "Purchase Header"."No.");
    //                 PurchCommentLine.SETRANGE(PurchCommentLine."Line No.", 30000);
    //                 PurchCommentLine.SETRANGE(PurchCommentLine."Document Line No.", 0);
    //                 IF PurchCommentLine.FINDFIRST THEN
    //                     OBS3 := PurchCommentLine."Dys Comment";
    //             end;
    //         }

    //         trigger OnAfterGetRecord()
    //         begin
    //             "Purchase Header".CalcFields("Nom Lieu Liv");
    //             IF RecLVendorPostingGroup.GET("Purchase Header"."Vendor Posting Group") THEN;
    //             RecLPurchLine.RESET;
    //             RecLPurchLine.SETRANGE("Document Type", "Purchase Header"."Document Type");
    //             RecLPurchLine.SETRANGE("Document No.", "Purchase Header"."No.");
    //             RecLPurchLine.SETRANGE("Document No.", RecLVendorPostingGroup."Stamp Fiscal Law93/53");
    //             PurchLine2.SETCURRENTKEY("VAT %");
    //             PurchLine2.SETRANGE("Document Type", "Document Type");
    //             PurchLine2.SETRANGE("Document No.", "No.");
    //             TxtTVA := '';
    //             CompteurTVA := 0;
    //             IF PurchLine2.FINDFIRST THEN
    //                 REPEAT
    //                     IF PurchLine2."VAT %" <> 0 THEN BEGIN
    //                         IF TxtTVA <> PurchLine2."VAT Prod. Posting Group" THEN BEGIN
    //                             CompteurTVA += 1;
    //                             TxtTVA := PurchLine2."VAT Prod. Posting Group";
    //                         END;
    //                         IF CompteurTVA = 1 THEN BEGIN
    //                             Tva := TxtTVA;
    //                             DecTauxTva := PurchLine2."VAT %";
    //                             DecBaseTVA += PurchLine2.Amount;
    //                             DecMontantTVA += PurchLine2."Amount Including VAT" - PurchLine2.Amount;
    //                         END;
    //                         IF CompteurTVA = 2 THEN BEGIN
    //                             Tva2 := TxtTVA;
    //                             DecTauxTva2 := PurchLine2."VAT %";
    //                             DecBaseTVA2 += PurchLine2.Amount;
    //                             DecMontantTVA2 += PurchLine2."Amount Including VAT" - PurchLine2.Amount;

    //                         END;
    //                         IF CompteurTVA = 3 THEN BEGIN
    //                             Tva3 := TxtTVA;
    //                             DecTauxTva3 := PurchLine2."VAT %";
    //                             DecBaseTVA3 += PurchLine2.Amount;
    //                             DecMontantTVA3 += PurchLine2."Amount Including VAT" - PurchLine2.Amount;

    //                         END;

    //                     END;
    //                 UNTIL PurchLine2.NEXT = 0;

    //             IF G_RecVend.GET("Buy-from Vendor No.") THEN;
    //             //     CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");

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

    //             // IF ReclieuLivraison.GET("Purchase Header"."Entry Point") THEN;
    //             // Lieu := ReclieuLivraison.Description;
    //             IF RecShiptoAddress.GET("Purchase Header"."Sell-to Customer No.", "Purchase Header"."Ship-to Code") THEN;
    //             Lieu := RecShiptoAddress.Address;
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
    //         /*    ArchiveDocument := (PurchSetup."Archive Quotes and Orders") AND
    //                                ((PurchSetup."Archiving Method" = PurchSetup."Archiving Method"::Standard) OR
    //                                 (PurchSetup."Archiving Method" = PurchSetup."Archiving Method"::Standard));*/
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
    //     CompteurBreak, PageBreak : Integer;
    //     Text000: Label 'Acheteur';
    //     Text001: Label 'Total %1';
    //     Text002: Label 'Total %1 TTC';
    //     Text003: Label 'COPIE';
    //     Text004: Label 'Commande %1';
    //     Text005: Label 'Page %1';
    //     Text006: Label 'Total %1 HT';
    //     GLSetup: Record 98;
    //     RecShiptoAddress: Record "Ship-to Address";
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
    //     CommentText: Text[1048];
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
    //     DecBaseTVA: Decimal;
    //     DecBaseTVA2: Decimal;
    //     DecBaseTVA3: Decimal;
    //     DecAmountIncludingVAt: Decimal;
    //     DecDiscountAmount: Decimal;
    //     DecAcompte: Decimal;
    //     DecMontantTVA: Decimal;
    //     DecMontantTVA2: Decimal;
    //     DecMontantTVA3: Decimal;
    //     IntCompteurAffichage: Integer;
    //     DecTauxTva: Decimal;
    //     DecTauxTva2: Decimal;
    //     DecTauxTva3: Decimal;
    //     DecDiffTva: Decimal;
    //     DecMontant: Decimal;
    //     DecTotalBrut: Decimal;
    //     RecAffectation: Record 13;
    //     Affect: Text[30];
    //     ReclieuLivraison: Record 282;
    //     Lieu: Text[100];
    //     Tva2: Text[30];
    //     Tva3: Text[30];
    //     Tva: Text[30];
    //     TxtTVA: Text[30];
    //     CompteurTVA: Integer;
    //     PurchLine2: Record 39;
    //     NumPage: Integer;
    //     MontantFODEC: Decimal;
    //     PurchCommentLine: Record 43;
    //     OBS1: Text[250];
    //     OBS2: Text[250];
    //     OBS3: Text[250];
    //     XXXXXXXCaptionLbl: Label 'XXXXXXX';
    //     ComentLineNo, PurchaseLineCount : Integer;
    //     XXXXXXXCaption_Control1000000091Lbl: Label 'XXXXXXX';
    //     XXXXXXXCaption_Control1000000094Lbl: Label 'XXXXXXX';
    //     XXXXXXXCaption_Control1000000108Lbl: Label 'XXXXXXX';
    //     XXXXXXXCaption_Control1000000110Lbl: Label 'XXXXXXX';
    //     XXXXXXXCaption_Control1000000092Lbl: Label 'XXXXXXX';
    //     XXXXXXXCaption_Control1000000105Lbl: Label 'XXXXXXX';
    //     XXXXXXXCaption_Control1000000109Lbl: Label 'XXXXXXX';
    //     "Arrêté_le_présent_bon_de_commande_à_la_somme_CaptionLbl": Label 'Arrêté le présent bon de commande à la somme:';
    //     Montant_FODEC__CaptionLbl: Label 'Montant FODEC =';
}

