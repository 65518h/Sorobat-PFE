// page 50064 Contrat
// {
//     // //+ABO+ GESWAY 15/07/02 Ajout "Subscription Starting Date","Subscription End Date" -> Onglet Facturation
//     // //PROJET GESWAY 01/11/01 Ajout Job No.
//     //                 10/12/01 NextControl : Date document > N° projet > Lignes
//     // //OUVRAGE GESWAY 12/03/03 Ajout "Description" sur bouton Ligne
//     // //ACHATS CLA 13/06/03 Ajout fonction Clôturer commande (= supprimer)
//     //          GESWAY 15/03/04 Ajout en visualisation du champ N° téléphone
//     //          GESWAY 07/03/05 Ajout groupe compta marché TVA dans l'en-tête
//     //          GESWAY 03/05/05 Ajout Description sur bouton Commande
//     //          AC     14/09/06 Geswation du look up sur le champ "Buy-From Contact No."
//     // //MULTI_ADDR GESWAY 12/03/04 Ajout N° chantier destinataire
//     // //MASK IMA 04/01/06 MaskFilter
//     // //+WKF+ CW 04/08/02 +Workflow Button
//     // //+REF+POST_DESC GESWAY 10/02/03 Ajout du champ "Posting Description" -> Onglet Facturation
//     // //+REF+SOLDE_CDE CLA 22/01/03 Ajout Solder la commande dans le bouton fonctions
//     // //+REF+ACHAT_SUIVI GD 21/04/06 Ajout chp date de prochaine relance dans l'onglet livraison
//     // //+REF+ACHAT_FACT GESWAY 11/06/03 Appel d'un formulaire sur validation
//     // //+REF+REPORT_LIST MB 29/06/06 Ajout du menu Etats dans le bouton commande
//     // //+REF+CRM GESWAY 09/03/04 Ajout Interactions sur bouton Devis
//     //           AC 03/11/06 Ajout boutton menu Créer interaction

//     //DYS problème declaration page 511

//     Caption = 'Contrat';
//     PageType = Card;
//     RefreshOnActivate = true;
//     SourceTable = "Purchase Header";
//     SourceTableView = WHERE("Document Type" = FILTER(Order), Status = FILTER(<> Archived), Contrat = CONST(true));
//     ApplicationArea = all;
//     UsageCategory = Administration;
//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';
//                 field("No."; rec."No.")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Buy-from Vendor No."; rec."Buy-from Vendor No.")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Code Fournisseur';

//                     trigger OnValidate()
//                     begin
//                         BuyfromVendorNoOnAfterValidate;
//                     end;
//                 }
//                 field("Buy-from Vendor Name"; rec."Buy-from Vendor Name")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Buy-from Address"; rec."Buy-from Address")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Buy-from Address 2"; rec."Buy-from Address 2")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Buy-from Post Code"; rec."Buy-from Post Code")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'CP/Ville Fournisseur';
//                 }
//                 field("N° Demande d'achat"; rec."N° Demande d'achat")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Job No."; rec."Job No.")
//                 {
//                     ApplicationArea = all;

//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 field(Engin; rec.Engin)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Purchaser Code1"; rec."Purchaser Code")
//                 {
//                     ApplicationArea = all;


//                     trigger OnValidate()
//                     begin
//                         PurchaserCodeC1000000022OnAfte;
//                     end;
//                 }
//                 field("Buy-from City"; rec."Buy-from City")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Description Engin"; rec."Description Engin")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Nom Affectation"; rec."Nom Affectation")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Entry Point1"; rec."Entry Point")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Delivery Location';

//                     trigger OnValidate()
//                     begin
//                         EntryPointC1000000018OnAfterVa;
//                     end;
//                 }
//                 field("Nom Lieu Liv"; rec."Nom Lieu Liv")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Location Code1"; rec."Location Code")
//                 {
//                     ApplicationArea = all;
//                     Style = Unfavorable;
//                     StyleExpr = TRUE;
//                 }
//                 field("Shipment Remark1"; rec."Shipment Remark")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Observation 1';
//                 }
//                 field("Pay-to Address 20"; rec."Pay-to Address 2")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Observation 2';
//                 }
//                 field("Pay-to Name 2"; rec."Pay-to Name 2")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Observation 3';
//                 }
//                 field("Posting Date"; rec."Posting Date")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Order Date"; rec."Order Date")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Document Date"; rec."Document Date")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Quote No.1"; rec."Quote No.")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Vendor Order No."; rec."Vendor Order No.")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Sage Order No.';
//                 }
//                 field("Date DA"; rec."Date DA")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Vendor Shipment No."; rec."Vendor Shipment No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Vendor Invoice No."; rec."Vendor Invoice No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Payment Terms Code"; rec."Payment Terms Code")
//                 {
//                     ApplicationArea = all;


//                     trigger OnValidate()
//                     begin
//                         PaymentTermsCodeOnAfterValidat;
//                     end;
//                 }
//                 field("Etat Commande"; rec."Etat Commande")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Nom Condition Paiement"; rec."Nom Condition Paiement")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Status1; rec.Status)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Demarcheur; rec.Demarcheur)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Contrat; rec.Contrat)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("N° Devis Fournisseur"; rec."N° Devis Fournisseur")
//                 {
//                     ApplicationArea = all;
//                     MultiLine = true;
//                 }
//             }
//             part(PurchLines; "Purchase Order Subform")
//             {
//                 ApplicationArea = all;
//                 Caption = 'Purchase Order Subform';
//                 SubPageLink = "Document No." = FIELD("No.");
//             }

//             group(Invoicing)
//             {
//                 Caption = 'Facturation';
//                 field("Pay-to Vendor No."; rec."Pay-to Vendor No.")
//                 {
//                     ApplicationArea = all;

//                     trigger OnValidate()
//                     begin
//                         PaytoVendorNoOnAfterValidate;
//                     end;
//                 }
//                 field("Pay-to Contact No."; rec."Pay-to Contact No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Pay-to Name"; rec."Pay-to Name")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Pay-to Address1"; rec."Pay-to Address")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Pay-to Address 2"; rec."Pay-to Address 2")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Pay-to Post Code"; rec."Pay-to Post Code")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Pay-to Post Code/City';
//                 }
//                 field("Pay-to Contact"; rec."Pay-to Contact")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(wDescr; wDescr)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Posting Description';

//                     trigger OnValidate()
//                     begin
//                         //POSTING_DESC
//                         IF wDescr = '' THEN BEGIN
//                             rec."Posting Description" := rec.wPostingDescription;
//                             wDescr := rec.wShowPostingDescription(rec."Posting Description");
//                         END ELSE
//                             rec."Posting Description" := wDescr;
//                         //POSTING_DESC//
//                     end;
//                 }
//                 field("Subscription Starting Date"; rec."Subscription Starting Date")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Subscription End Date"; rec."Subscription End Date")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Pay-to City"; rec."Pay-to City")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Purchaser Code"; rec."Purchaser Code")
//                 {
//                     ApplicationArea = all;

//                     trigger OnValidate()
//                     begin
//                         PurchaserCodeC10OnAfterValidat;
//                     end;
//                 }
//                 field("No. of Archived Versions"; rec."No. of Archived Versions")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Assigned User ID"; rec."Assigned User ID")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Status; rec.Status)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("N° Dossier"; rec."N° Dossier")
//                 {
//                     ApplicationArea = all;
//                     Style = Attention;
//                     StyleExpr = TRUE;
//                 }
//                 field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
//                 {
//                     ApplicationArea = all;

//                     trigger OnValidate()
//                     begin
//                         ShortcutDimension1CodeOnAfterV;
//                     end;
//                 }
//                 field("Shortcut Dimension 2 Code"; rec."Shortcut Dimension 2 Code")
//                 {
//                     ApplicationArea = all;

//                     trigger OnValidate()
//                     begin
//                         ShortcutDimension2CodeOnAfterV;
//                     end;
//                 }
//                 field("Due Date"; rec."Due Date")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Payment Discount %"; rec."Payment Discount %")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Pmt. Discount Date"; rec."Pmt. Discount Date")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Payment Method Code"; rec."Payment Method Code")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("On Hold"; rec."On Hold")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Prices Including VAT"; rec."Prices Including VAT")
//                 {
//                     ApplicationArea = all;

//                     trigger OnValidate()
//                     begin
//                         PricesIncludingVATOnAfterValid;
//                     end;
//                 }
//                 field("VAT Bus. Posting Group"; rec."VAT Bus. Posting Group")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Apply-to Sales Order No."; rec."Apply-to Sales Order No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Your Reference"; rec."Your Reference")
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//             group(Shipping)
//             {
//                 Caption = 'Livraison';
//                 field("Ship-to Name"; rec."Ship-to Name")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Ship-to Address"; rec."Ship-to Address")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Ship-to Address 2"; rec."Ship-to Address 2")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Ship-to Post Code"; rec."Ship-to Post Code")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'CP/Ville Fournisseur';
//                 }
//                 field("Ship-to City"; rec."Ship-to City")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Ship-to Contact"; rec."Ship-to Contact")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Ship-to Contact No."; rec."Ship-to Contact No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Ship-to Job No."; rec."Ship-to Job No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Quote No."; rec."Quote No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Pay-to Address"; rec."Pay-to Address")
//                 {
//                     ApplicationArea = all;

//                 }
//                 field("Shipment Remark"; rec."Shipment Remark")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Location Code"; rec."Location Code")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Inbound Whse. Handling Time"; rec."Inbound Whse. Handling Time")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Shipment Method Code"; rec."Shipment Method Code")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Lead Time Calculation"; rec."Lead Time Calculation")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Requested Receipt Date"; rec."Requested Receipt Date")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Shipment Method to"; rec."Shipment Method to")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Promised Receipt Date"; rec."Promised Receipt Date")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Expected Receipt Date"; rec."Expected Receipt Date")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Sell-to Customer No."; rec."Sell-to Customer No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Date Next Follow-Up"; rec."Date Next Follow-Up")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Ship-to Code"; rec."Ship-to Code")
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//             group("Foreign Trade")
//             {
//                 Caption = 'International';
//                 field("Currency Code"; rec."Currency Code")
//                 {
//                     ApplicationArea = all;

//                     trigger OnAssistEdit()
//                     begin
//                         //DYS problème declaration page 511
//                         /* CLEAR(ChangeExchangeRate);
//                          ChangeExchangeRate.SetParameter(rec."Currency Code", rec."Currency Factor", rec."Posting Date");
//                          IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
//                              rec.VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter);
//                              CurrPage.UPDATE;
//                          END;
//                          CLEAR(ChangeExchangeRate);*/
//                     end;

//                     trigger OnValidate()
//                     begin
//                         CurrencyCodeOnAfterValidate;
//                     end;
//                 }
//                 field("Transaction Type"; rec."Transaction Type")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Transaction Specification"; rec."Transaction Specification")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Transport Method"; rec."Transport Method")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Entry Point"; rec."Entry Point")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Area1; rec.Area)
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//             /*  GL2024  group("E-Commerce")
//                 {
//                     Caption = 'E-Commerce';
//                     field("BizTalk Purchase Order"; rec."BizTalk Purchase Order")
//                     {ApplicationArea = all;
//                         Editable = false;
//                     }
//                     field("Date Sent"; rec."Date Sent")
//                     {ApplicationArea = all;
//                         Editable = false;
//                     }
//                     field("Time Sent"; rec."Time Sent")
//                     {ApplicationArea = all;
//                         Editable = false;
//                     }
//                     field("Vendor Quote No."; rec."Vendor Quote No.")
//                     {ApplicationArea = all;
//                     }
//                     field("BizTalk Purch. Order Cnfmn."; rec."BizTalk Purch. Order Cnfmn.")
//                     {ApplicationArea = all;
//                         Editable = false;
//                     }
//                     field("Date Received"; rec."Date Received")
//                     {ApplicationArea = all;
//                         Editable = false;
//                     }
//                     field("Time Received"; rec."Time Received")
//                     {ApplicationArea = all;
//                         Editable = false;
//                     }
//                     field("BizTalk Purchase Receipt"; rec."BizTalk Purchase Receipt")
//                     {ApplicationArea = all;
//                         Editable = false;
//                     }
//                     field("BizTalk Purchase Invoice"; rec."BizTalk Purchase Invoice")
//                     {ApplicationArea = all;
//                         Editable = false;
//                     }
//                 }*/
//             group(Prepayment)
//             {
//                 Caption = 'Acompte';
//                 field("Prepayment %"; rec."Prepayment %")
//                 {
//                     ApplicationArea = all;

//                     trigger OnValidate()
//                     begin
//                         Prepayment37OnAfterValidate;
//                     end;
//                 }
//                 field("Compress Prepayment"; rec."Compress Prepayment")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Prepmt. Payment Terms Code"; rec."Prepmt. Payment Terms Code")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Prepayment Due Date"; rec."Prepayment Due Date")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Prepmt. Payment Discount %"; rec."Prepmt. Payment Discount %")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Prepmt. Pmt. Discount Date"; rec."Prepmt. Pmt. Discount Date")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Vendor Cr. Memo No."; rec."Vendor Cr. Memo No.")
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//             /*GL2024  group(VendInfoPanel)
//               {
//                   Caption = 'Vendor Information';
//                   label("Buy-from Vendor")
//                   {

//                       //CaptionClass = Text19023272;
//                   }
//                   field(STRSUBSTNO('(%1)',PurchInfoPaneMgmt.CalcNoOfOrderAddr("Buy-from Vendor No."));STRSUBSTNO('(%1)',PurchInfoPaneMgmt.CalcNoOfOrderAddr("Buy-from Vendor No.")))
//                      {ApplicationArea = all;
//                          Editable = false;
//                      }
//                      field(STRSUBSTNO('(%1)',PurchInfoPaneMgmt.CalcNoOfContacts(Rec));STRSUBSTNO('(%1)',PurchInfoPaneMgmt.CalcNoOfContacts(Rec)))
//                      {ApplicationArea = all;
//                          Editable = false;
//                      }
//                      label("Pay-to Vendor")
//                      {

//                          //CaptionClass = Text19005663;
//                      }
//                      field(gAddress."Phone No.";gAddress."Phone No.")
//                      {ApplicationArea = all;
//                          Caption = 'Phone No.';
//                          Editable = false;
//                      }
//                      field(gAddress."Fax No.";gAddress."Fax No.")
//                      {ApplicationArea = all;
//                          Caption = 'Fax No.';
//                          Editable = false;
//                      }
//                  }*/
//         }
//     }

//     actions
//     {
//         area(Promoted)
//         {
//             group("O&rder1")
//             {
//                 Caption = 'Commande';
//                 actionref(Statistics1; Statistics) { }
//                 actionref(Card1; Card) { }
//                 actionref("Co&mments11"; "Co&mments1") { }
//                 actionref(Receipts1; Receipts) { }
//                 actionref(Invoices1; Invoices) { }
//                 actionref("Prepa&yment Invoices1"; "Prepa&yment Invoices") { }
//                 actionref("Prepayment Credi&t Memos1"; "Prepayment Credi&t Memos") { }
//                 actionref(Dimensions11; Dimensions1) { }
//                 actionref(Reports1; Reports) { }
//                 actionref(Approvals1; Approvals) { }
//                 actionref(Description11; Description1) { }
//                 actionref("Interaction Log E&ntries1"; "Interaction Log E&ntries") { }
//                 actionref("Whse. Receipt Lines1"; "Whse. Receipt Lines") { }
//                 actionref("In&vt. Put-away/Pick Lines1"; "In&vt. Put-away/Pick Lines") { }

//                 group("Dr&op Shipment1")
//                 {
//                     Caption = 'Livraison Directe';

//                     actionref("Get &Sales Order11"; "Get &Sales Order1") { }

//                     actionref("Sales &Order11"; "Sales &Order1") { }

//                 }

//                 group("Speci&al Order1")
//                 {
//                     Caption = 'Commande Spéciale';

//                     actionref("Get &Sales Order21"; "Get &Sales Order2") { }
//                     actionref("Sales &Order12"; "Sales &Order") { }

//                 }
//             }

//             group("&Line1")
//             {
//                 Caption = '&Ligne';

//                 actionref(Description2; Description) { }

//             }
//             actionref(WorkFlowBtn1; WorkFlowBtn) { }
//             actionref("&Print11"; "&Print1") { }

//             group("F&unctions1")
//             {
//                 Caption = 'Fonctions';
//                 actionref("Calculate &Invoice Discount1"; "Calculate &Invoice Discount") { }
//                 group("Create &Inter actionref1")
//                 {
//                     Caption = 'Créer &Interaction';

//                     actionref("Buy-from1"; "Buy-from") { }
//                     actionref("Pay-to Vendor1"; "Pay-to Vendor") { }

//                 }
//                 actionref("E&xplode BOM1"; "E&xplode BOM") { }
//                 actionref("Insert &Ext. Texts1"; "Insert &Ext. Texts") { }
//                 actionref("Get St&d. Vend. Purchase Codes1"; "Get St&d. Vend. Purchase Codes") { }
//                 actionref("&Reserve1"; "&Reserve") { }
//                 actionref("Order &Tracking1"; "Order &Tracking") { }
//                 actionref("Copy Document1"; "Copy Document") { }
//                 actionref("Archi&ve Document1"; "Archi&ve Document") { }
//                 actionref("Move Negative Lines1"; "Move Negative Lines") { }
//                 actionref("Close Order1"; "Close Order") { }
//                 actionref("Create &Whse. Receipt1"; "Create &Whse. Receipt") { }
//                 actionref("Create Inventor&y Put-away / Pick1"; "Create Inventor&y Put-away / Pick") { }
//                 actionref("Send A&pproval Request1"; "Send A&pproval Request") { }
//                 actionref("Cancel Approval Re&quest1"; "Cancel Approval Re&quest") { }
//                 actionref("Re&lease1"; "Re&lease") { }

//                 actionref("Re&open1"; "Re&open") { }
//                 actionref("En Cours de Verification1"; "En Cours de Verification") { }
//                 actionref(Reclamation1; Reclamation) { }
//                 actionref("Delete Order1"; "Delete Order") { }
//                 actionref("Send IC Purchase Order1"; "Send IC Purchase Order") { }
//             }

//             group("P&osting1")
//             {
//                 Caption = 'Validation';

//                 actionref("Test Report1"; "Test Report") { }

//                 actionref("Post Receipt1"; "Post Receipt") { }

//                 actionref("P&ost Invoice1"; "P&ost Invoice") { }
//                 actionref("P&ost1"; "P&ost") { }
//                 actionref("Post and &Print1"; "Post and &Print") { }
//                 actionref("Post &Batch1"; "Post &Batch") { }
//                 group("Prepa&yment1")
//                 {
//                     Caption = 'Acompte';

//                     actionref("Prepayment Test &Report1"; "Prepayment Test &Report") { }
//                     actionref("Post Prepayment &Invoice1"; "Post Prepayment &Invoice") { }
//                     actionref("Post and Print Prepmt. Invoic&e1"; "Post and Print Prepmt. Invoic&e") { }
//                     actionref("Post Prepayment &Credit Memo1"; "Post Prepayment &Credit Memo") { }
//                     actionref("Post and Print Prepmt. Cr. Mem&o1"; "Post and Print Prepmt. Cr. Mem&o") { }
//                 }
//             }

//             actionref("&Print111"; "&Print") { }
//             actionref(PurchHistoryBtn11; PurchHistoryBtn) { }
//             actionref(PurchHistoryBtn111; PurchHistoryBtn1) { }




//         }
//         area(navigation)
//         {
//             group("O&rder")
//             {
//                 Caption = 'O&rder';
//                 action(Statistics)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Statistics';
//                     Image = Statistics;

//                     ShortCutKey = 'F7';

//                     trigger OnAction()
//                     begin
//                         // >> HJ SORO 16-10-2014
//                         CduPurchasePost2.CalcTimbre(Rec);
//                         CduPurchasePost2.CalcFodec(Rec);
//                         // >> HJ SORO 16-10-2014
//                         rec.CalcInvDiscForHeader;
//                         COMMIT;
//                         page.RUNMODAL(PAGE::"Purchase Order Statistics", Rec);
//                     end;
//                 }
//                 action(Card)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Card';
//                     Image = EditLines;
//                     RunObject = Page "Vendor Card";
//                     RunPageLink = "No." = FIELD("Buy-from Vendor No.");
//                     ShortCutKey = 'Maj+F7';
//                 }
//                 action("Co&mments1")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Co&mments';
//                     Image = ViewComments;
//                     RunObject = Page "Purch. Comment Sheet";
//                     RunPageLink = "Document Type" = FIELD("Document Type"), "No." = FIELD("No."), "Document Line No." = CONST(0);
//                 }
//                 action(Receipts)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Receipts';
//                     Image = PostedReceipts;
//                     RunObject = Page "Posted Purchase Receipts";
//                     RunPageLink = "Order No." = FIELD("No.");
//                     RunPageView = SORTING("Order No.");
//                 }
//                 action(Invoices)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Invoices';
//                     Image = Invoice;
//                     RunObject = Page "Posted Purchase Invoices";
//                     RunPageLink = "Order No." = FIELD("No.");
//                     RunPageView = SORTING("Order No.");
//                 }
//                 action("Prepa&yment Invoices")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Prepa&yment Invoices';
//                     RunObject = Page "Posted Purchase Invoices";
//                     RunPageLink = "Prepayment Order No." = FIELD("No.");
//                     RunPageView = SORTING("Prepayment Order No.");
//                 }
//                 action("Prepayment Credi&t Memos")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Prepayment Credi&t Memos';
//                     RunObject = Page "Posted Purchase Credit Memos";
//                     RunPageLink = "Prepayment Order No." = FIELD("No.");
//                     RunPageView = SORTING("Prepayment Order No.");
//                 }
//                 action(Dimensions1)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Dimensions';
//                     Image = Dimensions;

//                     trigger OnAction()
//                     begin
//                         Rec.ShowDocDim;
//                     end;
//                 }
//                 action(Reports)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Reports';

//                     trigger OnAction()
//                     var
//                         lReportList: Record ReportList;
//                         lId: Integer;
//                         lRecRef: RecordRef;
//                     begin
//                         WITH lReportList DO BEGIN
//                             EVALUATE(lId, COPYSTR(CurrPage.OBJECTID(FALSE), 6));
//                             lRecRef.GETTABLE(Rec);
//                             lRecRef.SETRECFILTER;
//                             SetRecordRef(lRecRef, TRUE);
//                             ShowList(lId);
//                         END;
//                     end;
//                 }
//                 action(Approvals)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Approvals';
//                     Image = Approvals;

//                     trigger OnAction()
//                     var
//                         ApprovalEntries: Page "Approval Entries";
//                     begin
//                         ApprovalEntries.SetRecordFilters(DATABASE::"Purchase Header", rec."Document Type", rec."No.");
//                         ApprovalEntries.RUN;
//                     end;
//                 }
//                 action(Description1)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Description';

//                     trigger OnAction()
//                     var
//                         lDescription: Record "Description Line";
//                     begin
//                         //ACHATS
//                         lDescription.ShowDescription(38, rec."Document Type", rec."No.", 0);
//                         //ACHATS//
//                     end;
//                 }
//                 separator(separator100)
//                 {
//                 }
//                 action("Interaction Log E&ntries")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Interaction Log E&ntries';

//                     trigger OnAction()
//                     begin
//                         //+REF+CRM
//                         rec.fShowDocumentInteraction(Rec);
//                         //+REF+CRM//
//                     end;
//                 }
//                 action("Whse. Receipt Lines")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Whse. Receipt Lines';
//                     RunObject = Page "Whse. Receipt Lines";
//                     RunPageLink = "Source Type" = CONST(39), "Source Subtype" = FIELD("Document Type"), "Source No." = FIELD("No.");
//                     RunPageView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.");
//                 }
//                 action("In&vt. Put-away/Pick Lines")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'In&vt. Put-away/Pick Lines';
//                     RunObject = Page "Warehouse Activity List";
//                     RunPageLink = "Source Document" = CONST("Purchase Order"), "Source No." = FIELD("No.");
//                     RunPageView = SORTING("Source Document", "Source No.", "Location Code");
//                 }
//                 separator(separator200)
//                 {
//                 }
//                 group("Dr&op Shipment")
//                 {
//                     Caption = 'Dr&op Shipment';
//                     action("Get &Sales Order1")
//                     {
//                         Caption = 'Get &Sales Order';
//                         RunObject = Codeunit "Purch.-Get Drop Shpt.";
//                     }
//                     action("Sales &Order1")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Sales &Order';
//                         Image = Document;
//                         RunObject = Codeunit "Purch.-Get Drop Shpt.";

//                         trigger OnAction()
//                         begin
//                             // fOpenSalesOrderForm;
//                         end;
//                     }
//                 }
//                 group("Speci&al Order")
//                 {
//                     Caption = 'Speci&al Order';
//                     action("Get &Sales Order2")
//                     {
//                         Caption = 'Get &Sales Order';

//                         trigger OnAction()
//                         var
//                             DistIntegration: Codeunit "Dist. Integration";
//                             PurchHeader: Record "Purchase Header";
//                         begin
//                             PurchHeader.COPY(Rec);
//                             DistIntegration.GetSpecialOrders(PurchHeader);
//                             Rec := PurchHeader;
//                         end;
//                     }
//                     action("Sales &Order")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Sales &Order';
//                         Image = Document;

//                         trigger OnAction()
//                         begin
//                             fOpenSpecSalesOrderForm;
//                         end;
//                     }
//                 }
//                 separator(separator300)
//                 {
//                 }
//                 /*  GL2024 NAVIBAT   action("Reception Achat")
//                      {
//                          ApplicationArea = all;
//                          Caption = 'Reception Achat';
//                          RunObject = Page 8003949;
//                          RunPageLink = "Document Type" = FIELD("Document Type"), "No." = FIELD("No.");
//                      }*/
//             }
//             group("&Line")
//             {
//                 Caption = '&Line';
//                 //DYS fonction deplacer dans ligne
//                 /*
//                 group("Item Availability by")
//                 {
//                     Caption = 'Item Availability by';
//                     action(Period)
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Period';



//                         trigger OnAction()
//                         var
//                         Cduitemava: Codeunit "Item Availability Forms Mgt";
//                         begin
//                             Cduitemava.ShowItemAvailFromPurchLine(REC, 0);
//                             CurrPage.PurchLines.Page.ItemAvailability(0);
//                         end;
//                     }
//                     action(Variant)
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Variant';

//                         trigger OnAction()
//                         begin
//                             CurrPage.PurchLines.Page.ItemAvailability(1);
//                         end;
//                     }
//                     action(Location)
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Location';

//                         trigger OnAction()
//                         begin
//                             CurrPage.PurchLines.Page.ItemAvailability(2);
//                         end;
//                     }
//                 }
//                 */
//                 separator(separator1900)
//                 {
//                 }
//                 //DYS action deplacer dans ligne
//                 /*action("Reservation Entries")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Reservation Entries';
//                     Image = ReservationLedger;

//                     trigger OnAction()
//                     begin
//                         CurrPage.PurchLines.Page.ShowReservationEntries;
//                     end;
//                 }
//                 action("Item &Tracking Lines")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Item &Tracking Lines';
//                     Image = ItemTrackingLines;
//                     ShortCutKey = 'Maj+Ctrl+I';

//                     trigger OnAction()
//                     begin
//                         CurrPage.PurchLines.Page.OpenItemTrackingLines;
//                     end;
//                 }*/
//                 separator(separator400)
//                 {
//                 }
//                 //DYS action deplacer dans ligne
//                 /*
//                 action(Dimensions)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Dimensions';
//                     Image = Dimensions;
//                     ShortCutKey = 'Maj+Ctrl+D';

//                     trigger OnAction()
//                     begin
//                         CurrPage.PurchLines.Page.ShowDimensions;
//                     end;
//                 }

//                 action("Co&mments")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Co&mments';
//                     Image = ViewComments;

//                     trigger OnAction()
//                     begin
//                         CurrPage.PurchLines.Page.ShowLineComments;
//                     end;
//                 }
//                 action("Item Charge &Assignment")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Item Charge &Assignment';

//                     trigger OnAction()
//                     var
//                         RecLPurchaseLine: Record 39;
//                     begin
//                         // >> HJ DSFT 05-10-2012
//                         rec.TESTFIELD("N° Dossier");
//                         RecLPurchaseLine.SETRANGE("Document Type", rec."Document Type");
//                         RecLPurchaseLine.SETRANGE("Document No.", rec."No.");
//                         RecLPurchaseLine.SETRANGE(Type, RecLPurchaseLine.Type::"Charge (Item)");
//                         RecLPurchaseLine.MODIFYALL("N° Dossier", rec."N° Dossier");
//                         // >> HJ DSFT 05-10-2012
//                         CurrPage.PurchLines.Page.ItemChargeAssgnt;
//                     end;
//                 }*/
//                 action(Description)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Description';

//                     trigger OnAction()
//                     begin
//                         fShowDescription;
//                     end;
//                 }
//             }
//         }
//         area(processing)
//         {
//             action(WorkFlowBtn)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Wor&Kflow';

//                 ToolTip = 'Workflow';

//                 trigger OnAction()
//                 var
//                     lRecordRef: RecordRef;
//                     lWorkflowConnector: Codeunit "Workflow Connector";
//                 begin
//                     lRecordRef.GETTABLE(Rec);
//                     lWorkflowConnector.OnPush(page::"Purchase Order", lRecordRef);
//                 end;
//             }
//             action("&Print1")
//             {
//                 ApplicationArea = all;
//                 Caption = '&Print';
//                 Ellipsis = true;
//                 Image = Print;

//                 ToolTip = 'Print';

//                 trigger OnAction()
//                 begin
//                     // >> HJ DSFT 10-10-2012
//                     IF rec.Status <> rec.Status::Released THEN ERROR(Text003);
//                     RecPurchaseOrder.SETRANGE("Document Type", rec."Document Type");
//                     RecPurchaseOrder.SETRANGE("No.", rec."No.");
//                     REPORT.RUNMODAL(REPORT::"Bon Commande Format A4", TRUE, TRUE, RecPurchaseOrder);
//                     // >> HJ DSFT 10-10-2012
//                     // STD HJ DSFT 10-10-2012 DocPrint.PrintPurchHeader(Rec);
//                 end;
//             }
//             group("F&unctions")
//             {
//                 Caption = 'F&unctions';
//                 action("Calculate &Invoice Discount")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Calculate &Invoice Discount';
//                     Image = CalculateInvoiceDiscount;

//                     trigger OnAction()
//                     begin
//                         ApproveCalcInvDisc;
//                     end;
//                 }
//                 separator(separator600)
//                 {
//                 }
//                 group("Create &Interaction")
//                 {
//                     Caption = 'Create &Interaction';
//                     action("Buy-from")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Buy-from';

//                         trigger OnAction()
//                         begin
//                             //+REF+CRM
//                             rec.fCreateInteraction(rec."Buy-from Vendor No.", rec."No.");
//                             //+REF+CRM//
//                         end;
//                     }
//                     action("Pay-to Vendor")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Pay-to Vendor';

//                         trigger OnAction()
//                         begin
//                             //+REF+CRM
//                             rec.fCreateInteraction(rec."Pay-to Vendor No.", rec."No.");
//                             //+REF+CRM//
//                         end;
//                     }
//                 }
//                 action("E&xplode BOM")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'E&xplode BOM';
//                     Image = ExplodeBOM;

//                     trigger OnAction()
//                     begin
//                         fExplodeBOM;
//                     end;
//                 }
//                 action("Insert &Ext. Texts")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Insert &Ext. Texts';

//                     trigger OnAction()
//                     begin
//                         fInsertExtendedText;
//                     end;
//                 }
//                 separator(separator700)
//                 {
//                 }
//                 action("Get St&d. Vend. Purchase Codes")
//                 {
//                     Caption = 'Get St&d. Vend. Purchase Codes';
//                     Ellipsis = true;
//                     ApplicationArea = all;
//                     trigger OnAction()
//                     var
//                         StdVendPurchCode: Record "Standard Vendor Purchase Code";
//                     begin
//                         StdVendPurchCode.InsertPurchLines(Rec);
//                     end;
//                 }
//                 separator(separator800)
//                 {
//                 }
//                 action("&Reserve")
//                 {
//                     ApplicationArea = all;
//                     Caption = '&Reserve';
//                     Ellipsis = true;

//                     trigger OnAction()
//                     begin
//                         fShowReserve;
//                     end;
//                 }
//                 action("Order &Tracking")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Order &Tracking';

//                     trigger OnAction()
//                     begin
//                         fShowTracking;
//                     end;
//                 }
//                 separator(separator900)
//                 {
//                 }
//                 action("Copy Document")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Copy Document';
//                     Ellipsis = true;
//                     Image = CopyDocument;

//                     trigger OnAction()
//                     begin
//                         CopyPurchDoc.SetPurchHeader(Rec);
//                         CopyPurchDoc.RUNMODAL;
//                         CLEAR(CopyPurchDoc);
//                     end;
//                 }
//                 action("Archi&ve Document")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Archi&ve Document';

//                     trigger OnAction()
//                     begin
//                         ArchiveManagement.ArchivePurchDocument(Rec);
//                         rec.Status := rec.Status::Archived;
//                         rec.MODIFY;
//                         CurrPage.UPDATE(FALSE);
//                     end;
//                 }
//                 action("Move Negative Lines")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Deplacer lignes negatives';
//                     Ellipsis = true;

//                     trigger OnAction()
//                     begin
//                         CLEAR(MoveNegPurchLines);
//                         MoveNegPurchLines.SetPurchHeader(Rec);
//                         MoveNegPurchLines.RUNMODAL;
//                         MoveNegPurchLines.ShowDocument;
//                     end;
//                 }
//                 action("Close Order")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Close Order';

//                     trigger OnAction()
//                     begin
//                         fCompletelyReceived;
//                     end;
//                 }
//                 separator(separator1000)
//                 {
//                 }
//                 action("Create &Whse. Receipt")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Crée réception entrepôt';

//                     trigger OnAction()
//                     var
//                         GetSourceDocInbound: Codeunit "Get Source Doc. Inbound";
//                     begin
//                         GetSourceDocInbound.CreateFromPurchOrder(Rec);

//                         IF NOT rec.FIND('=><') THEN
//                             rec.INIT;
//                     end;
//                 }
//                 action("Create Inventor&y Put-away / Pick")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Crée prélèv./rangement stock';
//                     Ellipsis = true;
//                     Image = CreateInventoryPickup;

//                     trigger OnAction()
//                     begin
//                         rec.CreateInvtPutAwayPick;

//                         IF NOT rec.FIND('=><') THEN
//                             rec.INIT;
//                     end;
//                 }
//                 separator(separator1200)
//                 {
//                 }
//                 action("Send A&pproval Request")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Envoyer Demande d''Approbation';
//                     Image = SendApprovalRequest;

//                     trigger OnAction()
//                     var
//                         ApprovalMgt: Codeunit "Approvals Mgmt.";
//                     begin
//                         if ApprovalMgt.CheckPurchaseApprovalPossible(Rec) then
//                             ApprovalMgt.OnSendPurchaseDocForApproval(Rec);
//                     end;
//                 }
//                 action("Cancel Approval Re&quest")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Annuler Demande d''Approbation';

//                     trigger OnAction()
//                     var
//                         //ApprovalMgt: Codeunit "Approvals Mgmt.";
//                         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                         WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
//                     begin
//                         ApprovalsMgmt.OnCancelPurchaseApprovalRequest(Rec);
//                         WorkflowWebhookMgt.FindAndCancel(Rec.RecordId);
//                     end;
//                 }
//                 separator(separator1300)
//                 {
//                 }
//                 action("Re&lease")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Lancer';
//                     Image = ReleaseDoc;
//                     ShortCutKey = 'Ctrl+F9';

//                     trigger OnAction()
//                     var
//                         ReleasePurchDoc: Codeunit "Release Purchase Document";
//                     begin
//                         // >> HJ SORO 15-01-2015
//                         RecPurchaseLine.RESET;
//                         RecPurchaseLine.SETRANGE("Document Type", rec."Document Type");
//                         RecPurchaseLine.SETRANGE("Document No.", rec."No.");
//                         RecPurchaseLine.SETFILTER(Type, '<>%1', 0);

//                         //RecPurchaseLine.SETRANGE(Type,RecPurchaseLine.Type::Item);
//                         IF RecPurchaseLine.FINDFIRST THEN
//                             REPEAT
//                                 IF RecPurchaseLine."dysJob No." = '' THEN ERROR(Text009);
//                             UNTIL RecPurchaseLine.NEXT = 0;
//                         // >> HJ SORO 15-01-2015

//                         // >> HJ DSFT 18-10-2012

//                         rec.Approbateur := UPPERCASE(USERID);
//                         // >> HJ DSFT 18-10-2012
//                         ReleasePurchDoc.PerformManualRelease(Rec);
//                         // >> HJ SORO 09-01-2015
//                         RecPurchaseLine.RESET;
//                         RecPurchaseLine.SETRANGE("Document Type", rec."Document Type");
//                         RecPurchaseLine.SETRANGE("Document No.", rec."No.");
//                         IF RecPurchaseLine.FINDFIRST THEN
//                             REPEAT
//                                 RecPurchaseLine.Status := RecPurchaseLine.Status::Released;
//                                 RecPurchaseLine.MODIFY;
//                             UNTIL RecPurchaseLine.NEXT = 0;
//                         // >> HJ SORO 09-01-2015
//                     end;
//                 }
//                 action("Re&open")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Reouvrir';
//                     Image = ReOpen;

//                     trigger OnAction()
//                     var
//                         ReleasePurchDoc: Codeunit "Release Purchase Document";
//                     begin
//                         IF UserSetup.GET(UPPERCASE(USERID)) THEN;
//                         IF NOT UserSetup."Reouvrir DOC Achat" THEN ERROR(Text007);
//                         ReleasePurchDoc.PerformManualReopen(Rec);
//                         // >> HJ SORO 09-01-2015
//                         RecPurchaseLine.RESET;
//                         RecPurchaseLine.SETRANGE("Document Type", rec."Document Type");
//                         RecPurchaseLine.SETRANGE("Document No.", rec."No.");
//                         IF RecPurchaseLine.FINDFIRST THEN
//                             REPEAT
//                                 RecPurchaseLine.Status := RecPurchaseLine.Status::Open;
//                                 RecPurchaseLine.MODIFY;
//                             UNTIL RecPurchaseLine.NEXT = 0;
//                         // >> HJ SORO 09-01-2015
//                     end;
//                 }
//                 action("En Cours de Verification")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'En Cours de Verification';

//                     trigger OnAction()
//                     begin
//                         // >> HJ SORO 24-2014
//                         rec.Status := rec.Status::"En Cours De Verification";
//                         rec.MODIFY;
//                         // >> HJ SORO 24-2014
//                     end;
//                 }
//                 action(Reclamation)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Reclamation';

//                     trigger OnAction()
//                     begin
//                         // >> HJ SORO 24-2014
//                         rec.Status := rec.Status::Reclamation;
//                         rec.MODIFY;
//                         // >> HJ SORO 24-2014
//                     end;
//                 }
//                 separator(separator1400)
//                 {
//                 }
//                 /* GL2024 action("&Send BizTalk Purchase Order")
//                   {
//                       ApplicationArea = all;
//                       Caption = '&Send BizTalk Purchase Order';

//                       trigger OnAction()
//                       var
//                           BizTalkManagement: Codeunit 99008508;
//                           SalesHeader: Record 36;
//                           ApprovalMgt: Codeunit "Approvals Mgmt.";
//                       begin
//                           IF ApprovalMgt.PrePostApprovalCheck(SalesHeader, Rec) THEN
//                               BizTalkManagement.SendPurchaseOrder(Rec);
//                       end;
//                   }*/
//                 action("Delete Order")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Delete Order';

//                     trigger OnAction()
//                     var
//                         lPurchHeader: Record "Purchase Header";
//                         lDeleteInvOrder: Report "Delete Invoiced Purch. Orders";
//                     begin
//                         //ACHAT
//                         lPurchHeader.COPY(Rec);
//                         lPurchHeader.SETRECFILTER;
//                         lDeleteInvOrder.SETTABLEVIEW(lPurchHeader);
//                         lDeleteInvOrder.USEREQUESTPAGE(TRUE);
//                         lDeleteInvOrder.RUN;
//                         CurrPage.UPDATE;
//                         //ACHAT//
//                     end;
//                 }
//                 action("Send IC Purchase Order")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Send IC Purchase Order';

//                     trigger OnAction()
//                     var
//                         ICInOutboxMgt: Codeunit ICInboxOutboxMgt;
//                         SalesHeader: Record "Sales Header";
//                         ApprovalMgt: Codeunit "Approvals Mgmt.";
//                     begin
//                         IF ApprovalMgt.PrePostApprovalCheckPurch(Rec) THEN
//                             ICInOutboxMgt.SendPurchDoc(Rec, FALSE);
//                     end;
//                 }
//             }
//             group("P&osting")
//             {
//                 Caption = 'P&osting';
//                 action("Test Report")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Impression Test';
//                     Ellipsis = true;
//                     Image = TestReport;

//                     trigger OnAction()
//                     begin
//                         ReportPrint.PrintPurchHeader(Rec);
//                     end;
//                 }
//                 action("Post Receipt")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Post Receipt';
//                     Image = Post;

//                     ShortCutKey = 'Maj+F9';

//                     trigger OnAction()
//                     begin
//                         // >> HJ DSFT 03-10-2012
//                         RecPurchaseLine.RESET;
//                         IF UserSetup.GET(UPPERCASE(USERID)) THEN;
//                         IF UserSetup."Filtre Magasin" <> '' THEN BEGIN
//                             RecPurchaseLine.SETRANGE("Document Type", rec."Document Type");
//                             RecPurchaseLine.SETRANGE("Document No.", rec."No.");
//                             RecPurchaseLine.SETRANGE(Type, RecPurchaseLine.Type::Item);
//                             RecPurchaseLine.SETFILTER("Qty. to Receive", '<>%1', 0);
//                             IF RecPurchaseLine.FINDFIRST THEN
//                                 REPEAT
//                                     IF RecPurchaseLine."Location Code" <> UserSetup."Filtre Magasin" THEN
//                                         ERROR(Text010, UserSetup."Filtre Magasin",
// RecPurchaseLine."Line No.", RecPurchaseLine."No.", RecPurchaseLine."Location Code");
//                                 UNTIL RecPurchaseLine.NEXT = 0;
//                         END;
//                         // >> HJ DSFT 03-10-2012

//                         // >> HJ 06-02-2014
//                         RecPurchaseLine.RESET;
//                         RecPurchaseLine.SETRANGE("Document Type", rec."Document Type");
//                         RecPurchaseLine.SETRANGE("Document No.", rec."No.");
//                         IF RecPurchaseLine.FINDFIRST THEN
//                             IF RecPurchaseLine."Ancien Groupe Cpt Marche TVA" <> '' THEN
//                                 IF RecPurchaseLine."VAT Bus. Posting Group" <> RecPurchaseLine."Ancien Groupe Cpt Marche TVA" THEN
//                                     ERROR(Text005, RecPurchaseLine."Ancien Groupe Cpt Marche TVA", RecPurchaseLine."VAT Bus. Posting Group");
//                         // >> HJ 06-02-2014
//                         // >> HJ SORO 15-01-2015
//                         RecPurchaseLine.RESET;
//                         RecPurchaseLine.SETRANGE("Document Type", rec."Document Type");
//                         RecPurchaseLine.SETRANGE("Document No.", rec."No.");
//                         IF RecPurchaseLine.FINDFIRST THEN
//                             REPEAT
//                                 IF RecPurchaseLine."dysJob No." = '' THEN ERROR(Text009);
//                             UNTIL RecPurchaseLine.NEXT = 0;
//                         // >> HJ SORO 15-01-2015

//                         //+REF+FACTURATION_ACHAT
//                         PurchSetup.GET;
//                         IF PurchSetup."Calc. Inv. Discount" THEN BEGIN
//                             CurrPage.PurchLines.Page.ApproveCalcInvDisc();
//                             COMMIT;
//                         END;
//                         gPurchPost.InitRequest(FALSE, TRUE);
//                         gPurchPost.RUN(Rec);
//                         //+REF+FACTURATION_ACHAT//
//                     end;
//                 }
//                 action("P&ost Invoice")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'P&ost Invoice';
//                     ShortCutKey = 'F9';

//                     trigger OnAction()
//                     begin
//                         //+REF+ACHAT
//                         // >> HJ 06-02-2014
//                         IF UserSetup.GET(UPPERCASE(USERID)) THEN;
//                         IF NOT UserSetup."Validation Commande Achat" THEN ERROR(Text008);

//                         RecPurchaseLine.RESET;
//                         RecPurchaseLine.SETRANGE("Document Type", rec."Document Type");
//                         RecPurchaseLine.SETRANGE("Document No.", rec."No.");
//                         IF RecPurchaseLine.FINDFIRST THEN
//                             IF RecPurchaseLine."Ancien Groupe Cpt Marche TVA" <> '' THEN
//                                 IF RecPurchaseLine."VAT Bus. Posting Group" <> RecPurchaseLine."Ancien Groupe Cpt Marche TVA" THEN
//                                     ERROR(Text005, RecPurchaseLine."Ancien Groupe Cpt Marche TVA", RecPurchaseLine."VAT Bus. Posting Group");
//                         // >> HJ 06-02-2014
//                         // >> HJ SORO 15-01-2015
//                         RecPurchaseLine.RESET;
//                         RecPurchaseLine.SETRANGE("Document Type", rec."Document Type");
//                         RecPurchaseLine.SETRANGE("Document No.", rec."No.");
//                         IF RecPurchaseLine.FINDFIRST THEN
//                             REPEAT
//                                 IF RecPurchaseLine."dysJob No." = '' THEN ERROR(Text009);
//                             UNTIL RecPurchaseLine.NEXT = 0;
//                         // >> HJ SORO 15-01-2015

//                         PurchSetup.GET;
//                         IF PurchSetup."Calc. Inv. Discount" THEN BEGIN
//                             CurrPage.PurchLines.Page.ApproveCalcInvDisc();
//                             COMMIT;
//                         END;
//                         gPurchPost.InitRequest(FALSE, FALSE);
//                         gPurchPost.RUN(Rec);
//                         //+REF+ACHAT//
//                     end;
//                 }
//                 action("P&ost")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'P&ost';
//                     Ellipsis = true;
//                     Image = Post;

//                     ShortCutKey = 'F9';
//                     Visible = false;

//                     trigger OnAction()
//                     var
//                         SalesHeader: Record "Sales Header";
//                         ApprovalMgt: Codeunit "Approvals Mgmt.";
//                     begin
//                         IF ApprovalMgt.PrePostApprovalCheckPurch(Rec) THEN BEGIN
//                             IF TestPurchasePrepayment(Rec) THEN
//                                 ERROR(STRSUBSTNO(Text001, rec."Document Type", rec."No."))
//                             ELSE BEGIN
//                                 IF TestPurchasePayment(Rec) THEN BEGIN
//                                     IF NOT CONFIRM(STRSUBSTNO(Text002, rec."Document Type", rec."No."), TRUE) THEN
//                                         EXIT
//                                     ELSE
//                                         CODEUNIT.RUN(CODEUNIT::"Purch.-Post (Yes/No)", Rec);
//                                 END ELSE
//                                     CODEUNIT.RUN(CODEUNIT::"Purch.-Post (Yes/No)", Rec);
//                             END;
//                         END;
//                     end;
//                 }
//                 action("Post and &Print")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Post and &Print';
//                     Ellipsis = true;
//                     Image = PostPrint;

//                     ShortCutKey = 'Maj+F9';
//                     Visible = false;

//                     trigger OnAction()
//                     var
//                         SalesHeader: Record "Sales Header";
//                         ApprovalMgt: Codeunit "Approvals Mgmt.";
//                     begin
//                         IF ApprovalMgt.PrePostApprovalCheckPurch(Rec) THEN BEGIN
//                             IF TestPurchasePrepayment(Rec) THEN
//                                 ERROR(STRSUBSTNO(Text001, rec."Document Type", rec."No."))
//                             ELSE BEGIN
//                                 IF TestPurchasePayment(Rec) THEN BEGIN
//                                     IF NOT CONFIRM(STRSUBSTNO(Text002, rec."Document Type", rec."No."), TRUE) THEN
//                                         EXIT
//                                     ELSE
//                                         CODEUNIT.RUN(CODEUNIT::"Purch.-Post + Print", Rec);
//                                 END ELSE
//                                     CODEUNIT.RUN(CODEUNIT::"Purch.-Post + Print", Rec);
//                             END;
//                         END;
//                     end;
//                 }
//                 action("Post &Batch")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Post &Batch';
//                     Ellipsis = true;
//                     Image = PostBatch;

//                     trigger OnAction()
//                     begin
//                         REPORT.RUNMODAL(REPORT::"Batch Post Purchase Orders", TRUE, TRUE, Rec);
//                         CurrPage.UPDATE(FALSE);
//                     end;
//                 }
//                 separator(separator1500)
//                 {
//                 }
//                 group("Prepa&yment")
//                 {
//                     Caption = 'Acompte';
//                     action("Prepayment Test &Report")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Impression Test Acompte';
//                         Ellipsis = true;

//                         trigger OnAction()
//                         begin
//                             ReportPrint.PrintPurchHeaderPrepmt(Rec);
//                         end;
//                     }
//                     action("Post Prepayment &Invoice")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Validation Facture Acompte';
//                         Ellipsis = true;

//                         trigger OnAction()
//                         var
//                             SalesHeader: Record "Sales Header";
//                             ApprovalMgt: Codeunit "Approvals Mgmt.";
//                             PurchPostYNPrepmt: Codeunit "Purch.-Post Prepmt. (Yes/No)";
//                         begin
//                             IF ApprovalMgt.PrePostApprovalCheckPurch(Rec) THEN
//                                 PurchPostYNPrepmt.PostPrepmtInvoiceYN(Rec, FALSE);
//                         end;
//                     }
//                     action("Post and Print Prepmt. Invoic&e")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Valider et Imprimer Facture Acompte';
//                         Ellipsis = true;

//                         trigger OnAction()
//                         var
//                             SalesHeader: Record "Sales Header";
//                             ApprovalMgt: Codeunit "Approvals Mgmt.";
//                             PurchPostYNPrepmt: Codeunit "Purch.-Post Prepmt. (Yes/No)";
//                         begin
//                             IF ApprovalMgt.PrePostApprovalCheckPurch(Rec) THEN
//                                 PurchPostYNPrepmt.PostPrepmtInvoiceYN(Rec, TRUE);
//                         end;
//                     }
//                     action("Post Prepayment &Credit Memo")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Valider Avoir Acompte';
//                         Ellipsis = true;

//                         trigger OnAction()
//                         var
//                             SalesHeader: Record "Sales Header";
//                             ApprovalMgt: Codeunit "Approvals Mgmt.";
//                             PurchPostYNPrepmt: Codeunit "Purch.-Post Prepmt. (Yes/No)";
//                         begin
//                             IF ApprovalMgt.PrePostApprovalCheckPurch(Rec) THEN
//                                 PurchPostYNPrepmt.PostPrepmtCrMemoYN(Rec, FALSE);
//                         end;
//                     }
//                     action("Post and Print Prepmt. Cr. Mem&o")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Valider et Imprimer Avoir Acompte';
//                         Ellipsis = true;

//                         trigger OnAction()
//                         var
//                             SalesHeader: Record "Sales Header";
//                             ApprovalMgt: Codeunit "Approvals Mgmt.";
//                             PurchPostYNPrepmt: Codeunit "Purch.-Post Prepmt. (Yes/No)";
//                         begin
//                             IF ApprovalMgt.PrePostApprovalCheckPurch(Rec) THEN
//                                 PurchPostYNPrepmt.PostPrepmtCrMemoYN(Rec, TRUE);
//                         end;
//                     }
//                 }
//             }
//             action("&Print")
//             {
//                 ApplicationArea = all;
//                 Caption = 'Imprimer';
//                 Ellipsis = true;
//                 Image = Print;

//                 ToolTip = 'Imprimer';

//                 trigger OnAction()
//                 begin
//                     // >> HJ DSFT 10-10-2012
//                     IF rec.Status <> rec.Status::Released THEN ERROR(Text003);
//                     RecPurchaseOrder.SETRANGE("Document Type", rec."Document Type");
//                     RecPurchaseOrder.SETRANGE("No.", rec."No.");
//                     REPORT.RUNMODAL(REPORT::"BON COMMANDE SOUROUBAT 03", TRUE, TRUE, RecPurchaseOrder);
//                     // >> HJ DSFT 10-10-2012
//                     // STD HJ DSFT 10-10-2012 DocPrint.PrintPurchHeader(Rec);
//                 end;
//             }
//             action(PurchHistoryBtn)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Historique des &Achats';

//                 Visible = PurchHistoryBtnVisible;

//                 trigger OnAction()
//                 begin
//                     LookupVendPurchaseHistory(Rec, rec."Pay-to Vendor No.", TRUE);
//                 end;
//             }
//             action(PurchHistoryBtn1)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Historique des &Achats';

//                 Visible = PurchHistoryBtn1Visible;

//                 trigger OnAction()
//                 begin
//                     LookupVendPurchaseHistory(Rec, rec."Buy-from Vendor No.", FALSE);
//                 end;
//             }
//             //DYS procudure obsolet
//             /*
//             action("&Contacts")
//             {
//                 ApplicationArea = all;
//                 Caption = '&Contacts';
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 begin
//                     PurchInfoPaneMgmt.LookupContacts(Rec);
//                 end;
//             }
//             action("Order &Addresses")
//             {
//                 ApplicationArea = all;
//                 Caption = 'Order &Addresses';
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 begin
//                     PurchInfoPaneMgmt.LookupOrderAddr(Rec);
//                 end;
//             }*/
//         }
//     }

//     trigger OnAfterGetRecord()
//     begin
//         //POSTING_DESC
//         wDescr := rec.wShowPostingDescription(rec."Posting Description");
//         //POSTING_DESC//
//         //ACHATS
//         //GL2024  PurchInfoPaneMgmt.gGetAddress(Rec, gAddress);
//         //ACHATS//
//     end;

//     trigger OnDeleteRecord(): Boolean
//     begin
//         CurrPage.SAVERECORD;
//         EXIT(rec.ConfirmDeletion);
//     end;

//     trigger OnInit()
//     begin
//         PurchHistoryBtn1Visible := TRUE;
//         PayToCommentBtnVisible := TRUE;
//         PayToCommentPictVisible := TRUE;
//         PurchHistoryBtnVisible := TRUE;
//     end;

//     trigger OnModifyRecord(): Boolean
//     begin
//         IF rec.Status <> rec.Status::Open THEN ERROR(Text006);
//         //ACHATS
//         /*GL2024  IF (rec."Buy-from Vendor No." <> xRec."Buy-from Vendor No.") OR (rec."Order Address Code" <> xRec."Order Address Code") THEN
//               PurchInfoPaneMgmt.gGetAddress(Rec, gAddress);*/
//         //ACHATS//
//     end;

//     trigger OnNewRecord(BelowxRec: Boolean)
//     begin
//         rec."Responsibility Center" := UserMgt.GetPurchasesFilter();

//         //#6695
//         rec."Document Type" := rec."Document Type"::Order;
//         //#6695//
//         rec.Contrat := TRUE;
//     end;

//     var
//         PurchSetup: Record "Purchases & Payables Setup";
//         //DYS problème declaration page 511
//         //  ChangeExchangeRate: Page "Change Exchange Rate";
//         CopyPurchDoc: Report "Copy Purchase Document";
//         MoveNegPurchLines: Report "Move Negative Purchase Lines";
//         ReportPrint: Codeunit "Test Report-Print";
//         DocPrint: Codeunit "Document-Print";
//         UserMgt: Codeunit "User Setup Management";
//         ArchiveManagement: Codeunit ArchiveManagement;
//         Text001: Label 'Il existe des montants d’acompte non validés sur %1 %2.';
//         Text002: Label 'Il existe des factures d’acompte impayées liées à %1 %2. Voulez-vous continuer ?';
//         PurchInfoPaneMgmt: Codeunit "Purchases Info-Pane Management";
//         gPurchPost: Codeunit "Purch. Order - Post";
//         wDescr: Text[100];
//         gAddress: Record "Order Address";
//         "// HJ DSFT": Integer;
//         RecPurchaseOrder: Record "Purchase Header";
//         Text003: Label 'Vous Devez Lancer La Commande Avant D''Imprimer';
//         RecPurchaseLine: Record "Purchase Line";
//         RecPurchasesPayablesSetup: Record "Purchases & Payables Setup";
//         UserSetup: Record "User Setup";
//         InventorySetup: Record "Inventory Setup";
//         CduPurchasePost: Codeunit "Purch.-Post";
//         CduPurchasePost2: Codeunit PurchPostEvent;
//         CdeOldGroupeCptMarcheTVA: Code[20];
//         Text004: Label 'TVA,Exonération';
//         IntChoix: Integer;
//         Text005: Label 'Le Groupe Compta Marché à Eté Modifier Ancier Groupe %1 , Nouveau Groupe %2)';
//         Text006: Label 'Aucune Modification Permise Statut Non Ouvert';
//         Text007: Label 'Vous n''avez pas Le Droit De Re-ouvrir Les Commandes Achat, Consulter Votre Administrateur';
//         Text008: Label 'Vous n''avez pas Le Droit De Valider Les Commandes Achat, Consulter Votre Administrateur';
//         Text009: Label 'Affaire/Chantie Doit Etre Preciser';
//         Text010: Label 'Votre Magasin De Reception Est %1  Il n''est pas Celui Dans La Ligne %2 Article %3 Magasin %4';

//         PurchHistoryBtnVisible: Boolean;

//         PayToCommentPictVisible: Boolean;

//         PayToCommentBtnVisible: Boolean;

//         PurchHistoryBtn1Visible: Boolean;
//         Text19023272: Label 'Buy-from Vendor';
//         Text19005663: Label 'Pay-to Vendor';

//     local procedure ApproveCalcInvDisc()
//     begin
//         CurrPage.PurchLines.Page.ApproveCalcInvDisc;
//     end;

//     local procedure UpdateInfoPanel()
//     var
//         DifferBuyFromPayTo: Boolean;
//     begin
//         DifferBuyFromPayTo := rec."Buy-from Vendor No." <> rec."Pay-to Vendor No.";
//         PurchHistoryBtnVisible := DifferBuyFromPayTo;
//         PayToCommentPictVisible := DifferBuyFromPayTo;
//         PayToCommentBtnVisible := DifferBuyFromPayTo;
//         //dys fonction DocExist obsolet
//         // PurchHistoryBtn1Visible := PurchInfoPaneMgmt.DocExist(Rec, rec."Buy-from Vendor No.");
//         //dys fonction DocExist obsolet
//         //IF DifferBuyFromPayTo THEN
//         //  PurchHistoryBtnVisible := PurchInfoPaneMgmt.DocExist(Rec, rec."Pay-to Vendor No.")
//     end;


//     procedure fOpenSalesOrderForm()
//     begin
//         //RTC-2009
//         //DYS
//         //  CurrPage.PurchLines.Page.OpenSalesOrderForm;
//         //RTC-2009//
//     end;


//     procedure fOpenSpecSalesOrderForm()
//     begin
//         //RTC-2009
//         //DYS
//         //CurrPage.PurchLines.Page.OpenSpecOrderSalesOrderForm;
//         //RTC-2009//
//     end;


//     procedure fExplodeBOM()
//     begin
//         //RTC-2009
//         //DYS
//         // CurrPage.PurchLines.Page.ExplodeBOM;
//         //RTC-2009//
//     end;


//     procedure fInsertExtendedText()
//     begin
//         //RTC-2009
//         CurrPage.PurchLines.Page.InsertExtendedText(TRUE);
//         //RTC-2009//
//     end;


//     procedure fShowReserve()
//     begin
//         //RTC-2009
//         //DYS
//         //CurrPage.PurchLines.Page.ShowReservation;
//         //RTC-2009//
//     end;


//     procedure fShowTracking()
//     begin
//         //RTC-2009
//         CurrPage.PurchLines.Page.ShowTracking;
//         //RTC-2009//
//     end;


//     procedure fCompletelyReceived()
//     begin
//         //RTC-2009
//         //+REF+SOLDE_CDE
//         CurrPage.PurchLines.Page.fCompletelyReceived;
//         //+REF+SOLDE_CDE//
//         //RTC-2009//
//     end;


//     procedure fItmAvailPeriod()
//     begin
//         //RTC-2009
//         //DYS non utiliser
//         //  CurrPage.PurchLines.Page.ItemAvailability(0);
//         //RTC-2009//
//     end;


//     procedure fItmAvailVariante()
//     begin
//         //RTC-2009
//         //DYS non utiliser
//         // CurrPage.PurchLines.Page.ItemAvailability(1);
//         //RTC-2009//
//     end;


//     procedure fItmAvailWksp()
//     begin
//         //RTC-2009
//         //DYS non utiliser
//         //  CurrPage.PurchLines.Page.ItemAvailability(2);
//         //RTC-2009//
//     end;


//     procedure fReservationEntries()
//     begin
//         //RTC-2009
//         //DYS non utiliser
//         //  CurrPage.PurchLines.Page.ShowReservationEntries;
//         //RTC-2009//
//     end;


//     procedure fOpenItmTrackingLines()
//     begin
//         //RTC-2009
//         //DYS non utiliser
//         //   CurrPage.PurchLines.Page.OpenItemTrackingLines;
//         //RTC-2009//
//     end;


//     procedure fShowDimensions()
//     begin
//         //RTC-2009
//         //DYS non utiliser
//         // CurrPage.PurchLines.Page.ShowDimensions;
//         //RTC-2009//
//     end;


//     procedure fShowLineComments()
//     begin
//         //RTC-2009
//         //DYS non utiliser
//         //CurrPage.PurchLines.Page.ShowLineComments;
//         //RTC-2009//
//     end;


//     procedure fItemChargeAssgnt()
//     begin
//         //RTC-2009
//         //DYS non utiliser
//         //CurrPage.PurchLines.Page.ItemChargeAssgnt;
//         //RTC-2009//
//     end;


//     procedure fShowDescription()
//     begin
//         //RTC-2009
//         //OUVRAGE
//         CurrPage.PurchLines.Page.wShowDescription;
//         //OUVRAGE//
//         //RTC-2009//
//     end;

//     local procedure BuyfromVendorNoOnAfterValidate()
//     begin
//         CurrPage.UPDATE;
//     end;

//     local procedure PurchaserCodeC1000000022OnAfte()
//     begin
//         rec.CALCFIELDS("Nom Affectation");
//     end;

//     local procedure PaymentTermsCodeOnAfterValidat()
//     begin
//         rec.CALCFIELDS("Nom Condition Paiement");
//     end;

//     local procedure EntryPointC1000000018OnAfterVa()
//     begin
//         rec.CALCFIELDS("Nom Lieu Liv");
//     end;

//     local procedure PaytoVendorNoOnAfterValidate()
//     begin
//         CurrPage.UPDATE;
//     end;

//     local procedure ShortcutDimension1CodeOnAfterV()
//     begin
//         CurrPage.PurchLines.Page.UpdateForm(TRUE);
//     end;

//     local procedure ShortcutDimension2CodeOnAfterV()
//     begin
//         CurrPage.PurchLines.Page.UpdateForm(TRUE);
//     end;

//     local procedure PricesIncludingVATOnAfterValid()
//     begin
//         CurrPage.UPDATE;
//     end;

//     local procedure PurchaserCodeC10OnAfterValidat()
//     begin
//         CurrPage.PurchLines.Page.UpdateForm(TRUE);
//     end;

//     local procedure CurrencyCodeOnAfterValidate()
//     begin
//         CurrPage.PurchLines.Page.UpdateForm(TRUE);
//     end;

//     local procedure Prepayment37OnAfterValidate()
//     begin
//         CurrPage.UPDATE;
//     end;

//     procedure TestPurchasePrepayment(PurchaseHeader: Record "Purchase Header"): Boolean
//     var
//         PurchaseLines: Record "Purchase Line";
//     begin

//         PurchaseLines.SETRANGE("Document Type", PurchaseHeader."Document Type");
//         PurchaseLines.SETRANGE("Document No.", PurchaseHeader."No.");
//         PurchaseLines.SETFILTER("Prepmt. Line Amount", '<>%1', 0);
//         IF PurchaseLines.FIND('-') THEN BEGIN
//             REPEAT
//                 IF PurchaseLines."Prepmt. Amt. Inv." <> PurchaseLines."Prepmt. Line Amount" THEN
//                     EXIT(TRUE);
//             UNTIL PurchaseLines.NEXT = 0;
//         END;
//     end;

//     procedure TestPurchasePayment(PurchaseHeader: Record "Purchase Header"): Boolean
//     var
//         PurchaseSetup: Record "Purchases & Payables Setup";
//         VendLedgerEntry: Record "Vendor Ledger Entry";
//         PurchaseInvHeader: Record "Purch. Inv. Header";
//         EntryFound: Boolean;
//     begin

//         EntryFound := FALSE;
//         PurchaseSetup.GET;
//         IF PurchaseSetup."Check Prepmt. when Posting" THEN BEGIN
//             PurchaseInvHeader.SETCURRENTKEY("Prepayment Order No.", "Prepayment Invoice");
//             PurchaseInvHeader.SETRANGE("Prepayment Order No.", PurchaseHeader."No.");
//             PurchaseInvHeader.SETRANGE("Prepayment Invoice", TRUE);
//             IF PurchaseInvHeader.FIND('-') THEN BEGIN
//                 REPEAT
//                     VendLedgerEntry.SETCURRENTKEY("Document No.");
//                     VendLedgerEntry.SETRANGE("Document Type", VendLedgerEntry."Document Type"::Invoice);
//                     VendLedgerEntry.SETRANGE("Document No.", PurchaseInvHeader."No.");
//                     VendLedgerEntry.SETFILTER("Remaining Amt. (LCY)", '<>%1', 0);
//                     IF VendLedgerEntry.FIND('-') THEN
//                         EntryFound := TRUE;
//                 UNTIL (PurchaseInvHeader.NEXT = 0) OR (EntryFound);
//             END;
//         END;
//         IF EntryFound THEN
//             EXIT(TRUE)
//         ELSE
//             EXIT(FALSE);
//     end;

//     procedure LookupVendPurchaseHistory(var PurchHeader: Record "Purchase Header"; VendNo: code[20]; UsePayTo: Boolean)
//     var


//     begin

//     end;
// }

