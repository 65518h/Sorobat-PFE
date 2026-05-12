report 50069 "BL enregistré A4"
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/BLenregistréA4.rdl';
    // Caption = 'Order';

    // dataset
    // {
    //     dataitem(DataItem3595; 110)
    //     {
    //         DataItemTableView = SORTING("No.");
    //         RequestFilterFields = "No.";
    //         RequestFilterHeading = 'Purchase Order';
    //         column(CurrReport_PAGENO; CurrReport.PAGENO)
    //         {
    //         }
    //         column(SignatureCaption; SignatureCaptionLbl)
    //         {
    //         }
    //         column(Sales_Shipment_Header_No_; "No.")
    //         {
    //         }
    //         dataitem(CopyLoop; 2000000026)
    //         {
    //             DataItemTableView = SORTING(Number);
    //             dataitem(PageLoop; 2000000026)
    //             {
    //                 DataItemTableView = SORTING(Number)
    //                                     WHERE(Number = CONST(1));
    //                 column(Sales_Shipment_Header___No__; "DataItem3595"."No.")
    //                 {
    //                 }
    //                 column(Sales_Shipment_Header___Posting_Date_; "DataItem3595"."Posting Date")
    //                 {
    //                 }
    //                 column(Sales_Shipment_Header___Bill_to_Name_; "DataItem3595"."Bill-to Name")
    //                 {
    //                 }
    //                 column(CodeTVAClient; CodeTVAClient)
    //                 {
    //                 }
    //                 column(AddresseClient; AddresseClient)
    //                 {
    //                 }
    //                 column(Sales_Shipment_Header___Order_No__; "DataItem3595"."Order No.")
    //                 {
    //                 }
    //                 column(Date_Caption; Date_CaptionLbl)
    //                 {
    //                 }
    //                 column(Code_TVA__Caption; Code_TVA__CaptionLbl)
    //                 {
    //                 }
    //                 column(Adresse__Caption; Adresse__CaptionLbl)
    //                 {
    //                 }
    //                 column(Client__Caption; Client__CaptionLbl)
    //                 {
    //                 }
    //                 column("NuméroCaption"; NuméroCaptionLbl)
    //                 {
    //                 }
    //                 column("RéférenceCaption"; RéférenceCaptionLbl)
    //                 {
    //                 }
    //                 column(Bon_de_LivraisonCaption; Bon_de_LivraisonCaptionLbl)
    //                 {
    //                 }
    //                 column(PageLoop_Number; Number)
    //                 {
    //                 }
    //                 /* dataitem(DimensionLoop1; 2000000026)
    //                  {
    //                      DataItemLinkReference = "DataItem3595";
    //                      DataItemTableView = SORTING(Number)
    //                                          WHERE(Number = FILTER(1 ..));

    //                      trigger OnAfterGetRecord()
    //                      begin
    //                          IF Number = 1 THEN BEGIN
    //                              IF NOT DocDim1.FIND('-') THEN
    //                                  CurrReport.BREAK;
    //                          END ELSE
    //                              IF NOT Continue THEN
    //                                  CurrReport.BREAK;

    //                          CLEAR(DimText);
    //                          Continue := FALSE;
    //                          REPEAT
    //                              OldDimText := DimText;
    //                              IF DimText = '' THEN
    //                                  DimText := STRSUBSTNO(
    //                                    '%1 %2', DocDim1."Dimension Code", DocDim1."Dimension Code")
    //                              ELSE
    //                                  DimText :=
    //                                    STRSUBSTNO(
    //                                      '%1, %2 %3', DimText,
    //                                      DocDim1."Dimension Code", DocDim1."Dimension Code");
    //                              IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
    //                                  DimText := OldDimText;
    //                                  Continue := TRUE;
    //                                  EXIT;
    //                              END;
    //                          UNTIL (DocDim1.NEXT = 0);
    //                      end;

    //                      trigger OnPreDataItem()
    //                      begin
    //                          IF NOT ShowInternalInfo THEN
    //                              CurrReport.BREAK;
    //                      end;
    //                  }*/
    //                 dataitem(DataItem2502; 111)
    //                 {
    //                     DataItemLink = "Document No." = FIELD("No.");
    //                     DataItemLinkReference = "DataItem3595";
    //                     DataItemTableView = SORTING("Document No.", "Line No.");
    //                     column(Sales_Shipment_Line_Description; Description)
    //                     {
    //                     }
    //                     column(Sales_Shipment_Line_Quantity; Quantity)
    //                     {
    //                     }
    //                     column(Sales_Shipment_Line__Sales_Shipment_Line___Unit_of_Measure_Code_; "DataItem2502"."Unit of Measure Code")
    //                     {
    //                     }
    //                     column(AmountCaption; AmountCaptionLbl)
    //                     {
    //                     }
    //                     column(Direct_Unit_CostCaption; Direct_Unit_CostCaptionLbl)
    //                     {
    //                     }
    //                     column(QTECaption; QTECaptionLbl)
    //                     {
    //                     }
    //                     column("DésignationCaption"; DésignationCaptionLbl)
    //                     {
    //                     }
    //                     column(UNITECaption; UNITECaptionLbl)
    //                     {
    //                     }
    //                     column(AmountCaption_Control1000000020; AmountCaption_Control1000000020Lbl)
    //                     {
    //                     }
    //                     column(Sales_Shipment_Line_Document_No_; "Document No.")
    //                     {
    //                     }
    //                     column(Sales_Shipment_Line_Line_No_; "Line No.")
    //                     {
    //                     }

    //                     trigger OnAfterGetRecord()
    //                     begin
    //                         //DecLinAmount+="Line Amount";
    //                         //DecLinAmount+="Sales Shipment Line".Amount;
    //                         //DecDiffTva+="VAT Difference";
    //                         //DecAmountIncludingVAt+= "Amount Including VAT" ; // "Line Amount"*(1+"VAT %"/100);
    //                         //DecMontant+=Amount;
    //                         //DecDiscountAmount+="Line Discount Amount";
    //                         //DecMontantTVA+="Amount Including VAT"-Amount;
    //                         //MontantRemise+="Sales Invoice Line"."Line Discount Amount";
    //                         //IF "VAT %"= 0 THEN DecBaseNonTaxable+=Amount;
    //                         //DecMontantTVA+=DecAmountIncludingVAt-DecLinAmount+DecDiffTva;
    //                         //IF DecTauxTva=0 THEN DecTauxTva:=PurchLine."VAT %";
    //                         if DataItem2502.Type = DataItem2502.Type::"G/L Account" then
    //                             CurrReport.Skip();
    //                     end;

    //                     trigger OnPreDataItem()
    //                     begin
    //                         //CurrReport.BREAK;
    //                     end;
    //                 }
    //                 dataitem(Loop; Integer)
    //                 {
    //                     DataItemTableView = sorting(Number) where(Number = filter(1 .. 13));
    //                     column(Number;
    //                     Number)
    //                     { }
    //                     trigger OnPreDataItem()
    //                     var
    //                         rep: Report "Sales - Shipment";
    //                         inb: Integer;
    //                     begin
    //                         inb := Loop.Count - DataItem2502.Count;
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
    //                 /* dataitem(Saut; 2000000026)
    //                  {
    //                      DataItemTableView = SORTING(Number);
    //                      column(Saut_Number; Number)
    //                      {
    //                      }
    //                  }*/
    //                 dataitem(DetailTva; 2000000026)
    //                 {
    //                     DataItemTableView = SORTING(Number)
    //                                         WHERE(Number = CONST(1));
    //                     column("Arrêté_la_présente_Facture_à_La_somme_de__Caption"; Arrêté_la_présente_Facture_à_La_somme_de__CaptionLbl)
    //                     {
    //                     }
    //                     column(MONTANT_HTCaption; MONTANT_HTCaptionLbl)
    //                     {
    //                     }
    //                     column(MONTANT_TVACaption; MONTANT_TVACaptionLbl)
    //                     {
    //                     }
    //                     column(NET_A_PAYERCaption; NET_A_PAYERCaptionLbl)
    //                     {
    //                     }
    //                     column(MONTANT_REMISECaption; MONTANT_REMISECaptionLbl)
    //                     {
    //                     }
    //                     column(TimbreCaption; TimbreCaptionLbl)
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
    //             end;

    //             trigger OnPostDataItem()
    //             begin
    //                 IF NOT CurrReport.PREVIEW THEN;
    //                 // PurchCountPrinted.RUN("SALES Header");
    //             end;

    //             trigger OnPreDataItem()
    //             begin
    //                 NoOfLoops := ABS(NoOfCopies) + 1;
    //                 CopyText := '';
    //                 SETRANGE(Number, 1, NoOfLoops);

    //                 IF ISSERVICETIER THEN
    //                     OutputNo := 0;
    //             end;
    //         }

    //         trigger OnAfterGetRecord()
    //         begin
    //             IF G_RecCustomer.GET("Sell-to Customer No.") THEN;
    //             // JBS // CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");

    //             CompanyInfo.GET;
    //             IF ClientFacture.GET("DataItem3595"."Sell-to Customer No.") THEN;
    //             AddresseClient := ClientFacture.Address;
    //             CodeTVAClient := ClientFacture."Matricule fiscal";
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
    //         // JBS
    //         // ArchiveDocument := (PurchSetup."Archive Quotes and Orders") AND
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
    //     PurchSetup: Record 312;
    //     PurchCountPrinted: Codeunit 317;
    //     ClientFacture: Record 18;
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
    //     TextGMnt: Text[500];
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
    //     MontantRemise: Decimal;
    //     AddresseClient: Text[150];
    //     CodeTVAClient: Text[150];
    //     Timbre: Decimal;
    //     SignatureCaptionLbl: Label 'Signature';
    //     Date_CaptionLbl: Label 'Date ';
    //     Code_TVA__CaptionLbl: Label 'Code TVA :';
    //     Adresse__CaptionLbl: Label 'Adresse :';
    //     Client__CaptionLbl: Label 'Client :';
    //     "NuméroCaptionLbl": Label 'Numéro';
    //     "RéférenceCaptionLbl": Label 'Référence';
    //     Bon_de_LivraisonCaptionLbl: Label 'Bon de Livraison';
    //     AmountCaptionLbl: Label 'Amount';
    //     Direct_Unit_CostCaptionLbl: Label 'Direct Unit Cost';
    //     QTECaptionLbl: Label 'QTE';
    //     "DésignationCaptionLbl": Label 'Désignation';
    //     UNITECaptionLbl: Label 'UNITE';
    //     AmountCaption_Control1000000020Lbl: Label 'Amount';
    //     "Arrêté_la_présente_Facture_à_La_somme_de__CaptionLbl": Label 'Arrêté la présente Facture à La somme de :';
    //     MONTANT_HTCaptionLbl: Label 'MONTANT HT';
    //     MONTANT_TVACaptionLbl: Label 'MONTANT TVA';
    //     NET_A_PAYERCaptionLbl: Label 'NET A PAYER';
    //     MONTANT_REMISECaptionLbl: Label 'MONTANT REMISE';
    //     TimbreCaptionLbl: Label 'Timbre';
}

