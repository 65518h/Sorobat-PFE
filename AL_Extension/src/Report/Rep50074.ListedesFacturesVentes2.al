report 50074 "Liste des Factures Ventes 2"
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/ListedesFacturesVentes2.rdlc';

    // dataset
    // {
    //     dataitem(Customer; Customer)
    //     {
    //         RequestFilterFields = "No.";
    //         column(Du________FORMAT_DateDEbut_______Au________FORMAT_DateFin_; 'Du :   ' + FORMAT(DateDEbut) + '  Au :   ' + FORMAT(DateFin))
    //         {
    //         }
    //         column(CurrReport_PAGENO; CurrReport.PAGENO)
    //         {
    //         }
    //         column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
    //         {
    //         }
    //         column(COMPANYNAME; COMPANYNAME)
    //         {
    //         }
    //         column(Customer__No__; "No.")
    //         {
    //         }
    //         column(Customer_Name; Name)
    //         {
    //         }
    //         column(TotalFactures; TotalFactures)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(TOtalReglement; TOtalReglement)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(solde_MontantAvoir; solde - MontantAvoir)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(MontantAvoir; MontantAvoir)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Client__Caption; Client__CaptionLbl)
    //         {
    //         }
    //         column(Suivi_Factures_ClientCaption; Suivi_Factures_ClientCaptionLbl)
    //         {
    //         }
    //         column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
    //         {
    //         }
    //         column(Total_Factures__Caption; Total_Factures__CaptionLbl)
    //         {
    //         }
    //         column("Total_Règlement__Caption"; Total_Règlement__CaptionLbl)
    //         {
    //         }
    //         column(Solde__Caption; Solde__CaptionLbl)
    //         {
    //         }
    //         column(Total_Avoir__Caption; Total_Avoir__CaptionLbl)
    //         {
    //         }
    //         dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
    //         {
    //             DataItemLink = "Customer No." = FIELD("No.");
    //             DataItemTableView = SORTING("Entry No.")
    //                                 WHERE("Document Type" = CONST(Invoice));
    //             RequestFilterFields = "Job No.";
    //             column(Cust__Ledger_Entry__Posting_Date_; "Posting Date")
    //             {
    //                 //   DecimalPlaces = 3 : 3;
    //             }
    //             column(ABS_Amount_; ABS(Amount))
    //             {
    //                 DecimalPlaces = 3 : 3;
    //             }
    //             column(Cust__Ledger_Entry__Document_No__; "Document No.")
    //             {
    //             }
    //             column(Cust__Ledger_Entry_Amount; Amount)
    //             {
    //             }
    //             column(date_EcheanceCaption; date_EcheanceCaptionLbl)
    //             {
    //             }
    //             column(Numero_PieceCaption; Numero_PieceCaptionLbl)
    //             {
    //             }
    //             column(Montant_RetenuCaption; Montant_RetenuCaptionLbl)
    //             {
    //             }
    //             column(Montant_ReglementCaption; Montant_ReglementCaptionLbl)
    //             {
    //             }
    //             column(Montant_FactureCaption; Montant_FactureCaptionLbl)
    //             {
    //             }
    //             column(DateCaption; DateCaptionLbl)
    //             {
    //             }
    //             column(Mode_PaiementCaption; Mode_PaiementCaptionLbl)
    //             {
    //             }
    //             column(N__FactureCaption; N__FactureCaptionLbl)
    //             {
    //             }
    //             column(N__ReglementCaption; N__ReglementCaptionLbl)
    //             {
    //             }
    //             column(Cust__Ledger_Entry_Entry_No_; "Entry No.")
    //             {
    //             }
    //             column(Cust__Ledger_Entry_Customer_No_; "Customer No.")
    //             {
    //             }
    //             dataitem("Tmp Ecritures Lettrage Clt"; "Tmp Ecritures Lettrage Clt")
    //             {
    //                 DataItemLink = "Sequence Lié" = FIELD("Entry No.");
    //                 DataItemTableView = SORTING("Entry No.")
    //                                     WHERE("Document Type" = FILTER(('<>Credit Memo)&(<>Invoice')),
    //                                           "Document No." = FILTER('<>*GDH*'));
    //                 column(MontantReglement; MontantReglement)
    //                 {
    //                     DecimalPlaces = 3 : 3;
    //                 }
    //                 column(MontantRetenue; MontantRetenue)
    //                 {
    //                     DecimalPlaces = 3 : 3;
    //                 }
    //                 column(NumPiece; NumPiece)
    //                 {
    //                 }
    //                 column(DateReglement; DateReglement)
    //                 {
    //                 }
    //                 column(ModePaiement; ModePaiement)
    //                 {
    //                 }
    //                 column(Tmp_Ecritures_Lettrage_Clt__Tmp_Ecritures_Lettrage_Clt___Document_No__; "Tmp Ecritures Lettrage Clt"."Document No.")
    //                 {
    //                     //   DecimalPlaces = 3 : 3;
    //                 }
    //                 column(Tmp_Ecritures_Lettrage_Clt_Entry_No_; "Entry No.")
    //                 {
    //                 }
    //                 column("Tmp_Ecritures_Lettrage_Clt_Sequence_Lié"; "Sequence Lié")
    //                 {
    //                 }
    //                 trigger OnAfterGetRecord()
    //                 begin

    //                     BQ := '';
    //                     MontantReglement := 0;
    //                     NumPiece := '';
    //                     MontantRetenue := 0;
    //                     ModePaiement := '';

    //                     paymentLine.SETRANGE("No.", "Document No.");
    //                     paymentLine.SETRANGE(paymentLine."External Document No.", "External Document No.");

    //                     IF paymentLine.FINDFIRST THEN BEGIN
    //                         MontantReglement := paymentLine."Credit Amount";
    //                         DateReglement := paymentLine."Due Date";
    //                         NumPiece := paymentLine."External Document No.";
    //                         CodeRetenue := paymentLine."Code Retenue à la Source";
    //                         MontantRetenue := ABS(paymentLine."Montant Retenue Validé");
    //                         ModePaiement := FORMAT(paymentLine."Mode Paiement");
    //                         TOtalReglement := TOtalReglement + paymentLine."Credit Amount" + ABS(paymentLine."Montant Retenue Validé");
    //                     END
    //                     ELSE BEGIN
    //                         MontantReglement := ABS("Tmp Ecritures Lettrage Clt"."Closed by Amount");
    //                         DateReglement := paymentLine."Due Date";
    //                         NumPiece := paymentLine."External Document No.";
    //                         CodeRetenue := paymentLine."Code Retenue à la Source";
    //                         MontantRetenue := ABS(paymentLine."Montant Retenue Validé");
    //                         ModePaiement := FORMAT(paymentLine."Mode Paiement");
    //                         TOtalReglement := TOtalReglement +
    //                                ABS("Tmp Ecritures Lettrage Clt"."Closed by Amount") + ABS(paymentLine."Montant Retenue Validé");

    //                     END;
    //                 end;
    //             }

    //             trigger OnAfterGetRecord()
    //             begin
    //                 /*MontantAvoir:=0;
    //                 LigneAVOIR.RESET;
    //                 LigneAVOIR.SETRANGE(LigneAVOIR."Buy-from Vendor No.",Vendor."No.");
    //                 IF LigneAVOIR.FINDFIRST THEN
    //                 REPEAT
    //                    IF EntetAVOIR.GET(LigneAVOIR."Document No.") THEN;
    //                    IF EntetAVOIR."Applies-to Doc. No."="Vendor Ledger Entry"."Document No." THEN
    //                 BEGIN

    //                 MontantAvoir:=MontantAvoir+LigneAVOIR."Amount Including VAT";
    //                 END
    //                 UNTIL LigneAVOIR.NEXT=0;*/

    //                 FindApplnEntriesDtldtLedgEntry("Cust. Ledger Entry");

    //                 TotalFactures := TotalFactures + ABS("Cust. Ledger Entry".Amount);
    //                 MontantReglement := 0;
    //                 MontantRetenue := 0;
    //                 CodeRetenue := '';
    //                 NumPiece := '';
    //                 BQ := '';

    //                 RecEcritureComptable.RESET;
    //                 PaymentHeader.RESET;
    //                 paymentLine.RESET;

    //             end;

    //             trigger OnPreDataItem()
    //             begin
    //                 IF (DateDEbut <> 0D) AND (DateFin <> 0D) THEN SETRANGE("Posting Date", DateDEbut, DateFin);
    //             end;
    //         }
    //         dataitem(Avoir; "Cust. Ledger Entry")
    //         {
    //             DataItemLink = "Customer No." = FIELD("No.");
    //             DataItemTableView = SORTING("Entry No.")
    //                                 WHERE("Document Type" = CONST("Credit Memo"));
    //             column(Avoir__Posting_Date_; "Posting Date")
    //             {
    //                 //    DecimalPlaces = 3 : 3;
    //             }
    //             column(ABS_Amount__Control1000000020; ABS(Amount))
    //             {
    //                 DecimalPlaces = 3 : 3;
    //             }
    //             column(Avoir__Document_No__; "Document No.")
    //             {
    //             }
    //             column(Avoir_Amount; Amount)
    //             {
    //             }
    //             column(Montant_AvoirCaption; Montant_AvoirCaptionLbl)
    //             {
    //             }
    //             column(DateCaption_Control1000000036; DateCaption_Control1000000036Lbl)
    //             {
    //             }
    //             column(N__AvoirCaption; N__AvoirCaptionLbl)
    //             {
    //             }
    //             column(Avoir_Entry_No_; "Entry No.")
    //             {
    //             }
    //             column(Avoir_Customer_No_; "Customer No.")
    //             {
    //             }

    //             trigger OnAfterGetRecord()
    //             begin

    //                 MontantAvoir := MontantAvoir + ABS(Avoir.Amount);
    //                 //   message("Document No.");
    //             end;

    //             trigger OnPreDataItem()
    //             begin
    //                 IF (DateDEbut <> 0D) AND (DateFin <> 0D) THEN SETRANGE("Posting Date", DateDEbut, DateFin);
    //                 MontantAvoir := 0;
    //             end;

    //         }
    //         trigger OnAfterGetRecord()
    //         var
    //             RecCusLedgerEntry: Record "Cust. Ledger Entry";
    //         begin
    //             // RecCusLedgerEntry.RESET;
    //             // RecCusLedgerEntry.SETRANGE("Customer No.", "No.");
    //             // RecCusLedgerEntry.SetRange("Posting Date", DateDEbut, DateFin);
    //             // if not RecCusLedgerEntry.FindFirst() then
    //             //     CurrReport.Skip();
    //             Codetmp := '';
    //             solde := TotalFactures - TOtalReglement;
    //         end;

    //         trigger OnPreDataItem()
    //         begin
    //             //DateDEbut:=DMY2DATE(1,1,DATE2DMY(TODAY,3));
    //             TmpCustomerLedgerEntry.DELETEALL;
    //         end;
    //     }
    // }

    // requestpage
    // {

    //     layout
    //     {
    //         area(Content)
    //         {


    //             field(DateDEbut; DateDEbut)
    //             {
    //                 ApplicationArea = All;
    //                 ToolTip = 'Date de début';
    //                 Caption = 'Date de début';
    //             }
    //             field(DateFin; DateFin)
    //             {
    //                 ApplicationArea = All;
    //                 ToolTip = 'Date de fin';
    //                 Caption = 'Date de fin';
    //             }
    //         }
    //     }

    //     actions
    //     {
    //     }
    // }

    // labels
    // {
    // }

    // trigger OnInitReport()
    // begin
    //     DateDEbut := DMY2DATE(1, 1, DATE2DMY(TODAY, 3));
    //     DateFin := DMY2DATE(31, 12, DATE2DMY(TODAY, 3));
    // end;

    // var
    //     VendorLedgerEntry2: Record "Tmp Ecritures Lettrage Clt";
    //     paymentLine: Record 10866;
    //     TotalFactures: Decimal;
    //     TOtalReglement: Decimal;
    //     TotalAvance: Decimal;
    //     TotalAvanceUtilisee: Decimal;
    //     solde: Decimal;
    //     SoldeAvance: Decimal;
    //     EntetAVOIR: Record 124;
    //     LigneAVOIR: Record 125;
    //     MontantAvoir: Decimal;
    //     CustLedgerEntry: Record 21;
    //     DatePhase: Date;
    //     LettreComptable: Text[30];
    //     RecEcritureComptable: Record 21;
    //     Banque: Code[10];
    //     BQ: Code[10];
    //     PaymentHeader: Record 10865;
    //     NumReglement: Text[30];
    //     MontantReglement: Decimal;
    //     MontantRetenue: Decimal;
    //     DateReglement: Date;
    //     CodeRetenue: Code[10];
    //     ModePaiement: Text[30];
    //     NumPiece: Text[30];
    //     BankAccount: Record 270;
    //     DateDEbut: Date;
    //     DateFin: Date;
    //     MontantVerifie: Decimal;
    //     MontantPaye: Decimal;
    //     MontantSigne: Decimal;
    //     MontantEncourSignature: Decimal;
    //     MontantEncourPaiement: Decimal;
    //     PurchInvHeader: Record 122;
    //     ListeFacturesLettrage: Record 50023;
    //     PhaseFactureInstance: Text[30];
    //     Afficher: Boolean;
    //     "// Partie New": Integer;
    //     CreateVendLedgEntry: Record 21;
    //     Navigate: Page 344;
    //     Heading: Text[50];
    //     TmpCustomerLedgerEntry: Record "Tmp Ecritures Lettrage Clt";
    //     Compteur: Integer;
    //     PurchaseLine: Record 39;
    //     MontanTFacture: Decimal;
    //     Codetmp: Text[100];
    //     Client__CaptionLbl: Label 'Client :';
    //     Suivi_Factures_ClientCaptionLbl: Label 'Suivi Factures Client';
    //     CurrReport_PAGENOCaptionLbl: Label 'Page';
    //     Total_Factures__CaptionLbl: Label 'Total Factures :';
    //     "Total_Règlement__CaptionLbl": Label 'Total Règlement :';
    //     Solde__CaptionLbl: Label 'Solde :';
    //     Total_Avoir__CaptionLbl: Label 'Total Avoir :';
    //     date_EcheanceCaptionLbl: Label 'date Echeance';
    //     Numero_PieceCaptionLbl: Label 'Numero Piece';
    //     Montant_RetenuCaptionLbl: Label 'Montant Retenu';
    //     Montant_ReglementCaptionLbl: Label 'Montant Reglement';
    //     Montant_FactureCaptionLbl: Label 'Montant Facture';
    //     DateCaptionLbl: Label 'Date';
    //     Mode_PaiementCaptionLbl: Label 'Mode Paiement';
    //     N__FactureCaptionLbl: Label 'N° Facture';
    //     N__ReglementCaptionLbl: Label 'N° Reglement';
    //     Montant_AvoirCaptionLbl: Label 'Montant Avoir';
    //     DateCaption_Control1000000036Lbl: Label 'Date';
    //     N__AvoirCaptionLbl: Label 'N° Avoir';


    // procedure FindApplnEntriesDtldtLedgEntry(var CreateVendLedgEntry: Record 21)
    // var
    //     DtldVendLedgEntry1: Record 379;
    //     DtldVendLedgEntry2: Record 379;
    // begin
    //     DtldVendLedgEntry1.SETCURRENTKEY("Cust. Ledger Entry No.");
    //     DtldVendLedgEntry1.SETRANGE("Cust. Ledger Entry No.", CreateVendLedgEntry."Entry No.");
    //     DtldVendLedgEntry1.SETRANGE(Unapplied, FALSE);
    //     IF DtldVendLedgEntry1.FIND('-') THEN BEGIN
    //         REPEAT
    //             IF DtldVendLedgEntry1."Cust. Ledger Entry No." =
    //               DtldVendLedgEntry1."Applied Cust. Ledger Entry No."
    //             THEN BEGIN
    //                 DtldVendLedgEntry2.INIT;
    //                 DtldVendLedgEntry2.SETCURRENTKEY("Applied Cust. Ledger Entry No.", "Entry Type");
    //                 DtldVendLedgEntry2.SETRANGE(
    //                   "Applied Cust. Ledger Entry No.", DtldVendLedgEntry1."Applied Cust. Ledger Entry No.");
    //                 DtldVendLedgEntry2.SETRANGE("Entry Type", DtldVendLedgEntry2."Entry Type"::Application);
    //                 DtldVendLedgEntry2.SETRANGE(Unapplied, FALSE);
    //                 IF DtldVendLedgEntry2.FIND('-') THEN BEGIN
    //                     REPEAT
    //                         IF DtldVendLedgEntry2."Cust. Ledger Entry No." <>
    //                           DtldVendLedgEntry2."Applied Cust. Ledger Entry No."
    //                         THEN BEGIN
    //                             CustLedgerEntry.SETCURRENTKEY("Entry No.");
    //                             CustLedgerEntry.SETRANGE("Entry No.", DtldVendLedgEntry2."Cust. Ledger Entry No.");
    //                             IF CustLedgerEntry.FIND('-') THEN BEGIN
    //                                 Compteur += 10000;
    //                                 TmpCustomerLedgerEntry.TRANSFERFIELDS(CustLedgerEntry);
    //                                 //TmpVendorLedgerEntry."Closed by Entry No.":=Compteur;
    //                                 TmpCustomerLedgerEntry."Fature Associé" := CreateVendLedgEntry."Document No.";
    //                                 TmpCustomerLedgerEntry."Sequence Lié" := CreateVendLedgEntry."Entry No.";
    //                                 IF TmpCustomerLedgerEntry.INSERT THEN;
    //                             END;
    //                         END;
    //                     UNTIL DtldVendLedgEntry2.NEXT = 0;
    //                 END;
    //             END ELSE BEGIN
    //                 CustLedgerEntry.SETCURRENTKEY("Entry No.");
    //                 CustLedgerEntry.SETRANGE("Entry No.", DtldVendLedgEntry1."Applied Cust. Ledger Entry No.");
    //                 IF CustLedgerEntry.FIND('-') THEN BEGIN
    //                     Compteur += 10000;
    //                     TmpCustomerLedgerEntry.TRANSFERFIELDS(CustLedgerEntry);
    //                     //TmpVendorLedgerEntry."Closed by Entry No.":=Compteur;
    //                     TmpCustomerLedgerEntry."Fature Associé" := CreateVendLedgEntry."Document No.";
    //                     TmpCustomerLedgerEntry."Sequence Lié" := CreateVendLedgEntry."Entry No.";
    //                     IF TmpCustomerLedgerEntry.INSERT THEN;
    //                 END;

    //             END;
    //         UNTIL DtldVendLedgEntry1.NEXT = 0;
    //     END;
    // end;
}

