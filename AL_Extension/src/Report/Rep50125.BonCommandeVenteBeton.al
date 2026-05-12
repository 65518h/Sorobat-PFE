Report 50125 "Bon Commande Vente Beton"
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/Bon Commande Vente Beton.rdl';
    // Caption = 'Commande';

    // dataset
    // {
    //     dataitem("Sales Header"; "Sales Header")
    //     {
    //         DataItemTableView = sorting("Document Type", "No.");
    //         RequestFilterFields = "No.";
    //         RequestFilterHeading = 'Purchase Order';
    //         column(ReportForNavId_6640; 6640)
    //         {
    //         }
    //         column(Sales_Header_Document_Type; "Document Type")
    //         {
    //         }
    //         column(Sales_Header_No_; "No.")
    //         {
    //         }
    //         dataitem(CopyLoop; "Integer")
    //         {
    //             DataItemTableView = sorting(Number);
    //             column(ReportForNavId_5701; 5701)
    //             {
    //             }
    //             dataitem(PageLoop; "Integer")
    //             {
    //                 DataItemTableView = sorting(Number) where(Number = const(1));
    //                 // column(DecLinAmount; DecLinAmount)
    //                 // //GL{
    //                 //     DecimalPlaces = 3 : 3;
    //                 // }
    //                 column(DecLinAmount; DecLinAmount)
    //                 {
    //                     DecimalPlaces = 3 : 3;
    //                 }

    //                 column(DecAmountIncludingVAt_TotalFodec; DecAmountIncludingVAt + TotalFodec)
    //                 {
    //                     DecimalPlaces = 3 : 3;
    //                 }
    //                 column(TotalFodec; TotalFodec)
    //                 {
    //                     DecimalPlaces = 3 : 3;
    //                 }

    //                 column(Base18; Base18)
    //                 {
    //                     DecimalPlaces = 3 : 3;
    //                 }
    //                 column(Base12; Base12)
    //                 {
    //                     DecimalPlaces = 3 : 3;
    //                 }
    //                 column(Montant18; Montant18)
    //                 {
    //                     DecimalPlaces = 3 : 3;
    //                 }
    //                 column(Montant12; Montant12)
    //                 {
    //                     DecimalPlaces = 3 : 3;
    //                 }

    //                 column(ROUND_DecAmountIncludingVAt_TotalFodec_Timbre_; ROUND(DecAmountIncludingVAt + TotalFodec + Timbre))
    //                 {
    //                     DecimalPlaces = 3 : 3;
    //                 }
    //                 column(ReportForNavId_6455; 6455)
    //                 {
    //                 }
    //                 column("Numéro__________Sales_Header___No__"; 'Numéro :' + '  ' + "Sales Header"."No.")
    //                 {
    //                 }
    //                 column(Sales_Header___Posting_Date_; "Sales Header"."Posting Date")
    //                 {
    //                 }
    //                 column(Doit_________Sales_Header___Bill_to_Name_; 'Doit :' + ' ' + "Sales Header"."Bill-to Name")
    //                 {
    //                 }
    //                 column(M_F_________MF; 'M.F. :' + ' ' + MF)
    //                 {
    //                 }
    //                 column(Date__Caption; Date__CaptionLbl)
    //                 {
    //                 }
    //                 column(FACTURECaption; FACTURECaptionLbl)
    //                 {
    //                 }
    //                 column(PageLoop_Number; Number)
    //                 {
    //                 }
    //                 /*   dataitem(DimensionLoop1; "Integer")
    //                    {
    //                        DataItemLinkReference = "Sales Header";
    //                        DataItemTableView = sorting(Number) where(Number = filter(1 ..));
    //                        column(ReportForNavId_7574; 7574)
    //                        {
    //                        }

    //                        trigger OnAfterGetRecord()
    //                        begin
    //                            if Number = 1 then begin
    //                                if not DocDim1.Find('-') then
    //                                    CurrReport.Break;
    //                            end else
    //                                if not Continue then
    //                                    CurrReport.Break;

    //                            Clear(DimText);
    //                            Continue := false;
    //                            repeat
    //                                OldDimText := DimText;
    //                                if DimText = '' then
    //                                    DimText := StrSubstNo(
    //                                      '%1 %2', DocDim1."Dimension Code", DocDim1."Dimension Code")
    //                                else
    //                                    DimText :=
    //                                      StrSubstNo(
    //                                        '%1, %2 %3', DimText,
    //                                        DocDim1."Dimension Code", DocDim1."Dimension Code");
    //                                if StrLen(DimText) > MaxStrLen(OldDimText) then begin
    //                                    DimText := OldDimText;
    //                                    Continue := true;
    //                                    exit;
    //                                end;
    //                            until (DocDim1.Next = 0);
    //                        end;

    //                        trigger OnPreDataItem()
    //                        begin
    //                            if not ShowInternalInfo then
    //                                CurrReport.Break;
    //                        end;
    //                    }*/
    //                 dataitem("Sales Line"; "Sales Line")
    //                 {
    //                     DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
    //                     DataItemLinkReference = "Sales Header";
    //                     DataItemTableView = sorting(Type, "No.", "Variant Code", "Drop Shipment", "Location Code", "Document Type", "Shipment Date") where(Type = filter(<> " " & <> "G/L Account"));
    //                     column(ReportForNavId_2844; 2844)
    //                     {
    //                     }


    //                     column(Sales_Line__Line_Amount_; "Line Amount")
    //                     {
    //                         AutoFormatType = 1;
    //                         DecimalPlaces = 3 : 3;
    //                     }
    //                     column(Sales_Line__Sales_Line___Unit_Price_; "Sales Line"."Unit Price")
    //                     {
    //                         AutoFormatType = 2;
    //                     }
    //                     column(Sales_Line_Quantity; Quantity)
    //                     {
    //                     }
    //                     column(Sales_Line__Unit_of_Measure_; "Unit of Measure")
    //                     {
    //                     }
    //                     column(Sales_Line_Description; Description)
    //                     {
    //                     }
    //                     column(Sales_Line__Line_Amount__Control1000000089; "Line Amount")
    //                     {
    //                         AutoFormatType = 1;
    //                         DecimalPlaces = 3 : 3;
    //                     }
    //                     column(Sales_Line__Sales_Line___Unit_Price__Control1000000087; "Sales Line"."Unit Price")
    //                     {
    //                         AutoFormatType = 2;
    //                     }
    //                     column(Sales_Line_Quantity_Control1000000086; Quantity)
    //                     {
    //                     }
    //                     column(Sales_Line_Description_Control1000000085; Description)
    //                     {
    //                     }
    //                     column(Sales_Line__VAT___; "VAT %")
    //                     {
    //                     }
    //                     column(FODEC; FODEC)
    //                     {
    //                     }
    //                     column(Direct_Unit_CostCaption; Direct_Unit_CostCaptionLbl)
    //                     {
    //                     }
    //                     column(QTECaption; QTECaptionLbl)
    //                     {
    //                     }
    //                     column(TVA____Caption; TVA____CaptionLbl)
    //                     {
    //                     }
    //                     column(FODEC____Caption; FODEC____CaptionLbl)
    //                     {
    //                     }
    //                     column(AmountCaption; AmountCaptionLbl)
    //                     {
    //                     }
    //                     column("DésignationCaption"; DésignationCaptionLbl)
    //                     {
    //                     }
    //                     column(Sales_Line_Document_Type; "Document Type")
    //                     {
    //                     }
    //                     column(Sales_Line_Document_No_; "Document No.")
    //                     {
    //                     }
    //                     column(Sales_Line_Line_No_; "Line No.")
    //                     {
    //                     }
    //                     column(Sales_Line_No_; "No.")
    //                     {
    //                     }

    //                     trigger OnAfterGetRecord()
    //                     begin
    //                         //DecLinAmount+="Line Amount";
    //                         //DecLinAmount+=Amount;
    //                         // RB SORO 05/08/2015
    //                         DecLinAmount += Amount; //Amount Including VAT";

    //                         DecDiffTva += "VAT Difference";
    //                         // RB SORO 05/08/2015
    //                         //DecAmountIncludingVAt+= "Amount Including VAT" ; // "Line Amount"*(1+"VAT %"/100);
    //                         DecAmountIncludingVAt += ("Amount Including VAT" * (1 + "VAT %" / 100));
    //                         DecMontant += Amount;
    //                         DecDiscountAmount += "Line Discount Amount";
    //                         DecAcompte += "Prepmt. Line Amount";
    //                         //DecMontantTVA+=DecAmountIncludingVAt-DecMontant;
    //                         if "VAT %" = 0 then DecBaseNonTaxable += Amount;
    //                         //DecMontantTVA+=DecAmountIncludingVAt-DecLinAmount+DecDiffTva;
    //                         if DecTauxTva = 0 then DecTauxTva := PurchLine."VAT %";

    //                         IF "Sales Line".Type = "Sales Line".Type::Item THEN
    //                             FODEC := 1
    //                         ELSE
    //                             FODEC := 0;

    //                         IntCompteur += 1;
    //                         IF IntCompteur = 11 THEN BEGIN
    //                             BlnAfficher := TRUE;
    //                             CurrReport.NEWPAGE;
    //                             IntCompteur := 0;
    //                         END
    //                         ELSE
    //                             BlnAfficher := FALSE;

    //                         IF "Sales Line"."VAT %" = 19 THEN Base18 += "Sales Line"."Line Amount";
    //                         IF "Sales Line"."VAT %" = 13 THEN Base12 += "Sales Line"."Line Amount";
    //                     end;

    //                     trigger OnPreDataItem()
    //                     begin
    //                         //CurrReport.BREAK;
    //                     end;
    //                 }
    //                 // dataitem(Saut; "Integer")
    //                 // {
    //                 //     DataItemTableView = sorting(Number);
    //                 //     column(ReportForNavId_6084; 6084)
    //                 //     {
    //                 //     }
    //                 //     column(Saut_Number; Number)
    //                 //     {
    //                 //     }
    //                 // }
    //                 dataitem(Loop; Integer)
    //                 {
    //                     DataItemTableView = sorting(Number) where(Number = filter(1 .. 8));
    //                     column(Number;
    //                     Number)
    //                     { }
    //                     trigger OnPreDataItem()
    //                     var
    //                         rep: Report "Sales - Shipment";
    //                         inb: Integer;
    //                     begin
    //                         inb := Loop.Count - "sales Line".Count;
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
    //                 dataitem(DetailTva; "Integer")
    //                 {
    //                     DataItemTableView = sorting(Number) where(Number = const(1));
    //                     column(ReportForNavId_6423; 6423)
    //                     {
    //                     }
    //                     column(Timbre; Timbre)
    //                     {
    //                         DecimalPlaces = 3 : 3;
    //                     }
    //                     column(TextGMnt; TextGMnt)
    //                     {
    //                     }
    //                     // column(DecLinAmount; DecLinAmount)
    //                     // {
    //                     //     DecimalPlaces = 3 : 3;
    //                     // }
    //                     // column(DecAmountIncludingVAt_TotalFodec; DecAmountIncludingVAt + TotalFodec)
    //                     // {
    //                     //     DecimalPlaces = 3 : 3;
    //                     // }
    //                     // column(DecMontantTVA; DecMontantTVA)
    //                     // {
    //                     //     DecimalPlaces = 3 : 3;
    //                     // }
    //                     // column(TextGMnt; TextGMnt)
    //                     // {
    //                     // }
    //                     // column(TotalFodec; TotalFodec)
    //                     // {
    //                     //     DecimalPlaces = 3 : 3;
    //                     // }
    //                     // column(Base18; Base18)
    //                     // {
    //                     //     DecimalPlaces = 3 : 3;
    //                     // }
    //                     // column(Base12; Base12)
    //                     // {
    //                     //     DecimalPlaces = 3 : 3;
    //                     // }
    //                     // column(Montant18; Montant18)
    //                     // {
    //                     //     DecimalPlaces = 3 : 3;
    //                     // }
    //                     // column(Montant12; Montant12)
    //                     // {
    //                     //     DecimalPlaces = 3 : 3;
    //                     // }
    //                     // column(Timbre; Timbre)
    //                     // {
    //                     //     DecimalPlaces = 3 : 3;
    //                     // }
    //                     // column(ROUND_DecAmountIncludingVAt_TotalFodec_Timbre_; ROUND(DecAmountIncludingVAt + TotalFodec + Timbre))
    //                     // {
    //                     //     DecimalPlaces = 3 : 3;
    //                     // }
    //                     column("Arrêtée_la_présente_Facture__à_la_somme_de_Caption"; Arrêtée_la_présente_Facture__à_la_somme_de_CaptionLbl)
    //                     {
    //                     }
    //                     column(Total_HTCaption; Total_HTCaptionLbl)
    //                     {
    //                     }
    //                     column(BASECaption; BASECaptionLbl)
    //                     {
    //                     }
    //                     column(MONTANTCaption; MONTANTCaptionLbl)
    //                     {
    //                     }
    //                     column(V13_Caption; V13_CaptionLbl)
    //                     {
    //                     }
    //                     column(V19_Caption; V19_CaptionLbl)
    //                     {
    //                     }
    //                     column(Total_FODECCaption; Total_FODECCaptionLbl)
    //                     {
    //                     }
    //                     column(Total_TVACaption; Total_TVACaptionLbl)
    //                     {
    //                     }
    //                     column(Total_TTCCaption; Total_TTCCaptionLbl)
    //                     {
    //                     }
    //                     column("Timbre_étatCaption"; Timbre_étatCaptionLbl)
    //                     {
    //                     }
    //                     column("Net_à_payerCaption"; Net_à_payerCaptionLbl)
    //                     {
    //                     }
    //                     column("Département_Béton_Caption"; Département_Béton_CaptionLbl)
    //                     {
    //                     }
    //                     column(DetailTva_Number; Number)
    //                     {
    //                     }
    //                     column(DecMontantTVA; DecMontantTVA)
    //                     {
    //                         DecimalPlaces = 3 : 3;
    //                     }
    //                     trigger OnPreDataItem()
    //                     var
    //                     begin

    //                         // RB SORO 20/08/2015

    //                         //Montant18:=(Base18*18)/100;
    //                         //Montant18:=((Base18 + TotalFodec)*18)/100;
    //                         //Montant12:=(Base12*12)/100;

    //                         IF RecCustomer.GET("Sales Header"."Bill-to Customer No.") THEN;
    //                         MF := RecCustomer."Matricule fiscal";
    //                         IF "Sales Header"."Apply Stamp fiscal" = TRUE THEN Timbre := 1;
    //                         IF "Sales Header"."Gen. Bus. Posting Group" = 'SUSPENSION' THEN BEGIN
    //                             Montant18 := ((Base18) * 19) / 100;
    //                             Montant12 := (Base12 * 13) / 100;
    //                         END
    //                         ELSE BEGIN
    //                             IF "Sales Header"."VAT Bus. Posting Group" = 'EXONORER' THEN
    //                                 Montant18 := ((Base18) * 19) / 100
    //                             ELSE
    //                                 Montant18 := ((Base18 + TotalFodec) * 19) / 100;

    //                             Montant12 := (Base12 * 13) / 100;
    //                         END;

    //                         IF "Sales Header"."VAT Bus. Posting Group" = 'EXONORER' THEN
    //                             Base18 := Base18
    //                         ELSE
    //                             Base18 := Base18 + TotalFodec;

    //                         //DecMontantTVA:=DecAmountIncludingVAt-DecMontant;
    //                         DecMontantTVA := Montant18 + Montant12;
    //                         DecAmountIncludingVAt := DecLinAmount + DecMontantTVA;


    //                         IF "Sales Header"."Currency Code" = '' THEN
    //                             CodeU."Montant en texte sans millimes"(TextGMnt, ROUND(DecAmountIncludingVAt + TotalFodec + Timbre))
    //                         ELSE
    //                             CodeU."Montant en texteDevise"(TextGMnt, DecAmountIncludingVAt + TotalFodec + Timbre, "Sales Header"."Currency Code");
    //                         CurrReport.SHOWOUTPUT(NOT BlnAfficher);
    //                     end;
    //                 }
    //                 /*   trigger OnPreDataItem()
    //                    var
    //                    begin

    //                        // RB SORO 20/08/2015

    //                        //Montant18:=(Base18*18)/100;
    //                        //Montant18:=((Base18 + TotalFodec)*18)/100;
    //                        //Montant12:=(Base12*12)/100;

    //                        IF RecCustomer.GET("Sales Header"."Bill-to Customer No.") THEN;
    //                        MF := RecCustomer."Matricule fiscal";
    //                        IF "Sales Header"."Apply Stamp fiscal" = TRUE THEN Timbre := 1;
    //                        IF "Sales Header"."Gen. Bus. Posting Group" = 'SUSPENSION' THEN BEGIN
    //                            Montant18 := ((Base18) * 19) / 100;
    //                            Montant12 := (Base12 * 13) / 100;
    //                        END
    //                        ELSE BEGIN
    //                            IF "Sales Header"."VAT Bus. Posting Group" = 'EXONORER' THEN
    //                                Montant18 := ((Base18) * 19) / 100
    //                            ELSE
    //                                Montant18 := ((Base18 + TotalFodec) * 19) / 100;

    //                            Montant12 := (Base12 * 13) / 100;
    //                        END;

    //                        IF "Sales Header"."VAT Bus. Posting Group" = 'EXONORER' THEN
    //                            Base18 := Base18
    //                        ELSE
    //                            Base18 := Base18 + TotalFodec;

    //                        //DecMontantTVA:=DecAmountIncludingVAt-DecMontant;
    //                        DecMontantTVA := Montant18 + Montant12;
    //                        DecAmountIncludingVAt := DecLinAmount + DecMontantTVA;


    //                        IF "Sales Header"."Currency Code" = '' THEN
    //                            CodeU."Montant en texte sans millimes"(TextGMnt, ROUND(DecAmountIncludingVAt + TotalFodec + Timbre))
    //                        ELSE
    //                            CodeU."Montant en texteDevise"(TextGMnt, DecAmountIncludingVAt + TotalFodec + Timbre, "Sales Header"."Currency Code");
    //                        CurrReport.SHOWOUTPUT(NOT BlnAfficher);
    //                    end;*/
    //             }

    //             trigger OnAfterGetRecord()
    //             var
    //                 PrepmtPurchLine: Record 39 temporary;
    //                 DocDim: Record 357;
    //                 TempPurchLine: Record 39 temporary;
    //             begin
    //             end;

    //             trigger OnPostDataItem()
    //             begin
    //                 if not CurrReport.Preview then;
    //             end;

    //             trigger OnPreDataItem()
    //             begin
    //                 NoOfLoops := Abs(NoOfCopies) + 1;
    //                 CopyText := '';
    //                 SetRange(Number, 1, NoOfLoops);

    //                 if ISSERVICETIER then
    //                     OutputNo := 0;
    //             end;
    //         }

    //         trigger OnAfterGetRecord()
    //         begin
    //             if G_RecCustomer.Get("Sell-to Customer No.") then;
    //             // CurrReport.Language := Language.GetLanguageID("Language Code");

    //             CompanyInfo.Get;

    //             RecSalesLine.Reset;
    //             RecSalesLine.SetRange(RecSalesLine."Document No.", "Sales Header"."No.");
    //             RecSalesLine.SetRange(RecSalesLine.Description, 'FODEC');
    //             if RecSalesLine.FindFirst then
    //                 repeat
    //                     TotalFodec := TotalFodec + RecSalesLine."Line Amount";
    //                 //TotalFodec+=RecSalesLine."Line Amount" *(1+RecSalesLine."VAT %"/100);
    //                 // RB SORO 06/08/2015
    //                 until RecSalesLine.Next = 0;
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
    //                     ApplicationArea = Basic;
    //                     Caption = 'Nombre de copies';
    //                 }
    //                 field(ShowInternalInfo; ShowInternalInfo)
    //                 {
    //                     ApplicationArea = Basic;
    //                     Caption = 'Afficher info. internes';
    //                 }
    //                 field(ArchiveDocument; ArchiveDocument)
    //                 {
    //                     ApplicationArea = Basic;
    //                     Caption = 'Archiver document';

    //                     trigger OnValidate()
    //                     begin
    //                         if not ArchiveDocument then
    //                             LogInteraction := false;
    //                     end;
    //                 }
    //                 field(LogInteraction; LogInteraction)
    //                 {
    //                     ApplicationArea = Basic;
    //                     Caption = 'Journal interaction';
    //                     Enabled = LogInteractionEnable;

    //                     trigger OnValidate()
    //                     begin
    //                         if LogInteraction then
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
    //         LogInteractionEnable := true;
    //     end;

    //     trigger OnOpenPage()
    //     begin
    //         //#8609
    //         //ArchiveDocument := PurchSetup."Archive Quotes and Orders";
    //         // ArchiveDocument := (PurchSetup."Archive Quotes and Orders") and
    //         //                    ((PurchSetup."Archiving Method" = PurchSetup."archiving method"::Standard) or
    //         //                     (PurchSetup."Archiving Method" = PurchSetup."archiving method"::Standard));
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
    //     GLSetup.Get;
    //     PurchSetup.Get;
    // end;

    // var
    //     Text000: Label 'Acheteur';
    //     Text001: label 'Total %1';
    //     Text002: Label 'Total %1 TTC';
    //     Text003: label 'COPIE';
    //     Text004: Label 'Commande %1';
    //     Text005: label 'Page %1';
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
    //     Text007: Label 'Détail TVA dans';
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
    //     G_RecCustomer: Record 23;
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
    //     DecBaseNonTaxable: Decimal;
    //     FODEC: Decimal;
    //     RecSalesLine: Record 37;
    //     TotalFodec: Decimal;
    //     RecCustomer: Record 18;
    //     MF: Text[30];
    //     Base18: Decimal;
    //     Base12: Decimal;
    //     Montant18: Decimal;
    //     Montant12: Decimal;
    //     Timbre: Decimal;
    //     Date__CaptionLbl: label 'Date :';
    //     FACTURECaptionLbl: label 'FACTURE';
    //     Direct_Unit_CostCaptionLbl: label 'Direct Unit Cost';
    //     QTECaptionLbl: label 'QTE';
    //     TVA____CaptionLbl: label 'TVA (%)';
    //     FODEC____CaptionLbl: label 'FODEC (%)';
    //     AmountCaptionLbl: label 'Amount';
    //     "DésignationCaptionLbl": label 'Désignation';
    //     "Arrêtée_la_présente_Facture__à_la_somme_de_CaptionLbl": label 'Arrêtée la présente Facture  à la somme de:';
    //     Total_HTCaptionLbl: label 'Total HT';
    //     BASECaptionLbl: label 'BASE';
    //     MONTANTCaptionLbl: label 'MONTANT';
    //     V13_CaptionLbl: label '13%';
    //     V19_CaptionLbl: label '19%';
    //     Total_FODECCaptionLbl: label 'Total FODEC';
    //     Total_TVACaptionLbl: label 'Total TVA';
    //     Total_TTCCaptionLbl: label 'Total TTC';
    //     "Timbre_étatCaptionLbl": label 'Timbre/état';
    //     "Net_à_payerCaptionLbl": label 'Net à payer';
    //     "Département_Béton_CaptionLbl": label 'Département Béton ';
}

