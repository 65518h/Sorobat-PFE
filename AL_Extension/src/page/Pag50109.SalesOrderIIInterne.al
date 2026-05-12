// page 50109 "Sales Order II Interne"
// {
//     // TRS-2009 XPE 02/10/09
//     // //PLANNING_TASK CW 26/08/09 MenuButton Order +Planning Tasks
//     // //#5535 Ajout
//     // //+REF+INVOICE CW CW 31/07/07 #4864
//     // //+ONE+PREPAYMENT CW 03/09/07
//     // //ACHAT CW 09/07/07 +Functions, DropShipment, GenerateDropShimment
//     // //QUOTE_FOOTER MB 26/03/07 Ajout de la fonction "pied de devis"
//     // //PROJET GESWAY 01/11/01 Ajout Job No.
//     //                 10/12/01 NextControl : Date document > N° projet > Lignes
//     // //PROJET_PHASE GESWAY 01/10/02 Ajout N° avenant
//     // //OUVRAGE GESWAY 20/03/03 Ajout "Copier un ouvrage" sur bouton Fonctions
//     // //REVISION GESWAY 04/04/03 Ajout Onglet Révision + nouveaux champs
//     // //DEVIS GESWAY 09/05/03 Ajout de Caractéristiques dans le bouton Devis
//     //                15/01/04 Ajout AssistEdit sur "Sell-to Cust. Name","Ship-to Name","Bill-to Name"
//     //                         Appel formulaire "Contact et Adresses" depuis ces champs
//     // //PROJET_FACT GESWAY 04/03/03 Appel formulaire de saisie de l'avancement, échéancier dans le bouton commande
//     //                      26/04/03 Imprimer mis dans le bouton Validation
//     //                      02/11/04 Ajout DataItemView : 'Soldé' à non
//     // //POSTING_DESC GESWAY 12/06/03 gestion "Posting Description" paramétrable
//     // //SUBCONTRACTOR GESWAY 04/07/03 Ajout fonction générer sous-traitance + Mise à jour coût
//     // //REPORT_SELECTED 16/01/04 Gestion de séléction des états Bouton Commande
//     // //URL CW 27/01/04 Appel Lignes, Pièces jointes
//     // //PROJET_ACTION GESWAY 27/02/04 Appel liste interactions du document depuis bouton Commande
//     // //CRM GESWAY 09/03/04 Ajout Interactions sur bouton Commande
//     // //ACOMPTE CLA 29/07/04 Ajout Acompte
//     // //CAUTION AC 05/01/05 Ajout Menu Item caution dans le menu commande
//     // //PRESENTATION MB 26/10/06 Ajout des bouton monter et descendre dans le menu ligne
//     // //MASK IMA 02/01/06 MaskFilter
//     // //CDE_CESSION MB 08/11/06 Ajout du menu "commande cession" dans le bouton fonction
//     // //+ABO+ GESWAY 15/07/02 Ajout "Subscription Starting Date","Subscription End Date" sur onglet Facturation
//     // //+WKF+ CW 04/08/02 +Workflow Button
//     // //+REF+ADDTEXT DL 23/09/05 Ajout boutons complémentaires (commentaires en-tête et pied doc.)
//     //                            Modif Filtre Type = '' sur bouton Comment
//     // //+REF+POST_DESC GESWAY 10/02/03 Ajout du champ "Posting Description" -> Onglet Facturation
//     // //+REF+FOLDER    CW     19/02/04 Ajout Dossier
//     // //+REF+REPORT_LIST MB 29/06/06 Ajout du menu Etats dans le bouton commande

//     Caption = 'Commande vente interne';
//     PageType = Card;
//     RefreshOnActivate = true;
//     SaveValues = true;
//     SourceTable = "Sales Header";
//     SourceTableView = SORTING("Order Type", "Document Type", "No.", "Invoicing Method", Finished) WHERE("Document Type" = CONST(Order), "Order Type" = FILTER(' '), "Commande Interne" = FILTER(true));
//     //  ApplicationArea = all;
//     //  UsageCategory = Administration;
//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'Général';
//                 field("No."; rec."No.")
//                 {
//                     ApplicationArea = all;

//                     trigger OnAssistEdit()
//                     begin
//                         IF rec.AssistEdit(xRec) THEN
//                             CurrPage.UPDATE;
//                     end;
//                 }
//                 field("Sell-to Customer No."; rec."Sell-to Customer No.")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'N° Client';
//                     Editable = "Sell-to Customer No.Editable";

//                     trigger OnValidate()
//                     begin
//                         SelltoCustomerNoOnAfterValidat;
//                     end;
//                 }
//                 field("Sell-to Customer Name"; rec."Sell-to Customer Name")
//                 {
//                     ApplicationArea = all;
//                     AssistEdit = true;
//                     Editable = "Sell-to Customer NameEditable";

//                     /* GL2024 NAVBT trigger OnAssistEdit()
//                       begin
//                           CurrPage.SAVERECORD;
//                           COMMIT;
//                           CLEAR(AddressContributors);
//                           AddressContributors.InitRequest(1);
//                           AddressContributors.SETTABLEVIEW(Rec);
//                           AddressContributors.SETRECORD(Rec);
//                           AddressContributors.RUNMODAL;
//                           //AddressContributors.GETRECORD(Rec);
//                           CurrPage.UPDATE;
//                       end;*/
//                 }
//                 field("Job No."; rec."Job No.")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Centrale';
//                     Editable = "Job No.Editable";
//                 }
//                 field("External Document No."; rec."External Document No.")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'N° BL';
//                 }
//                 field("User ID"; rec."User ID")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Ship-to Code"; rec."Ship-to Code")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Code Déstination';
//                     Editable = "Ship-to CodeEditable";
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 field("Ship-to Name"; rec."Ship-to Name")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Destination';
//                     Editable = "Ship-to NameEditable";
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 field(Engin; rec.Engin)
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 field("Description Engin"; rec."Description Engin")
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 field(Type; rec.Type)
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 field("N° Serie"; rec."N° Serie")
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 field("Posting Date"; rec."Posting Date")
//                 {
//                     ApplicationArea = all;

//                     trigger OnValidate()
//                     begin
//                         // RB SORO 21/08/2015 BETON
//                         RecSalesLineBeton.SETRANGE("Document Type", rec."Document Type");
//                         RecSalesLineBeton.SETRANGE("Document No.", rec."No.");
//                         IF RecSalesLineBeton.FINDFIRST THEN
//                             REPEAT
//                                 RecSalesLineBeton."Date Comptabilisation" := rec."Posting Date";
//                                 //RecSalesLineBeton."User ID" := "User ID";
//                                 RecSalesLineBeton.MODIFY;
//                             UNTIL RecSalesLineBeton.NEXT = 0;
//                         // RB SORO 21/08/2015 BETON
//                     end;
//                 }
//                 field("Document Date"; rec."Document Date")
//                 {
//                     ApplicationArea = all;

//                     trigger OnValidate()
//                     begin
//                         rec.VALIDATE("Shipment Date", 0D);
//                     end;
//                 }
//                 field("Order Date"; rec."Order Date")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Quote No."; rec."Quote No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Commande Interne"; rec."Commande Interne")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Last Shipping No."; rec."Last Shipping No.")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'N° Expédition';
//                 }
//                 field(Production; rec.Production)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 field("Formule Beton"; rec."Formule Beton")
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 field("Matricule Pompe"; rec."Matricule Pompe")
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 field("Prices Including VAT"; rec."Prices Including VAT")
//                 {
//                     ApplicationArea = all;
//                     Editable = "Prices Including VATEditable";

//                     trigger OnValidate()
//                     begin
//                         PricesIncludingVATC1000000013O;
//                     end;
//                 }
//             }
//             part(SalesLines; "Sales Order Subform")
//             {
//                 ApplicationArea = all;
//                 SubPageLink = "Document No." = FIELD("No.");
//                 SubPageView = SORTING("Order Type", "Document Type", "Document No.", "Presentation Code", "Structure Line No.", "Job No.");
//             }
//             /* GL2024   group(CustInfoPanel)
//                 {
//                     Caption = 'Customer Information';
//                     label("Sell-to Customer")
//                     {
//                         //CaptionClass = Text19070588;
//                     }
//                     field(STRSUBSTNO('(%1)',SalesInfoPaneMgt.CalcNoOfContacts(Rec));STRSUBSTNO('(%1)',SalesInfoPaneMgt.CalcNoOfContacts(Rec)))
//                     {
//                         Editable = false;
//                     }
//                     label("Bill-to Customer")
//                     {
//                         //CaptionClass = Text19069283;
//                     }
//                     field(SalesInfoPaneMgt.CalcAvailableCredit("Bill-to Customer No.");SalesInfoPaneMgt.CalcAvailableCredit("Bill-to Customer No."))
//                     {
//                         DecimalPlaces = 0:0;
//                         Editable = false;
//                     }
//                 }*/
//             group(TabControl)
//             {
//                 Caption = 'Affaire';
//                 field("Ship-to Code1"; rec."Ship-to Code")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Ship-to Name1"; rec."Ship-to Name")
//                 {
//                     ApplicationArea = all;
//                     AssistEdit = true;

//                     /*  GL2024 NAVIBAT     trigger OnAssistEdit()
//                       begin
//                           CurrPage.SAVERECORD;
//                           COMMIT;
//                           CLEAR(AddressContributors);
//                           AddressContributors.InitRequest(2);
//                           AddressContributors.SETTABLEVIEW(Rec);
//                           AddressContributors.SETRECORD(Rec);
//                           AddressContributors.RUNMODAL;
//                           //AddressContributors.GETRECORD(Rec);
//                           CurrPage.UPDATE;
//                       end;*/
//                 }
//                 field("Job Description"; rec."Job Description")
//                 {
//                     ApplicationArea = all;
//                     Editable = "Job DescriptionEditable";
//                 }
//                 field("Project Manager"; rec."Project Manager")
//                 {
//                     ApplicationArea = all;
//                     Editable = "Project ManagerEditable";

//                     trigger OnValidate()
//                     begin
//                         ProjectManagerOnAfterValidate;
//                     end;
//                 }
//                 field(ProjectManagerName; ProjectManagerName)
//                 {
//                     ApplicationArea = all;
//                     AssistEdit = true;
//                     Caption = 'Project Manager Name';
//                     Editable = false;

//                     /*  GL2024 NAVIBAT   trigger OnAssistEdit()
//                          begin
//                              CLEAR(AddressContributors);
//                              AddressContributors.InitRequest(4);
//                              AddressContributors.SETTABLEVIEW(Rec);
//                              AddressContributors.SETRECORD(Rec);
//                              AddressContributors.RUNMODAL;
//                              //AddressContributors.GETRECORD(Rec);
//                              CurrPage.UPDATE;
//                          end;*/
//                 }
//                 field("Job No.1"; rec."Job No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Job Starting Date"; rec."Job Starting Date")
//                 {
//                     ApplicationArea = all;
//                     Editable = "Job Starting DateEditable";
//                 }
//                 field("Job Ending Date"; rec."Job Ending Date")
//                 {
//                     ApplicationArea = all;
//                     Editable = "Job Ending DateEditable";
//                 }
//                 field("Shipment Date"; rec."Shipment Date")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Salesperson Code"; rec."Salesperson Code")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(ContactName; ContactName)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Contact Name';
//                     Editable = false;
//                 }
//                 field(Subject; rec.Subject)
//                 {
//                     ApplicationArea = all;

//                     trigger OnAssistEdit()
//                     var
//                         lDescription: Record "Description Line";
//                     begin
//                         lDescription.ShowDescription(36, rec."Document Type", rec."No.", 0);
//                     end;
//                 }
//                 /* GL2024  field("Credit Card No."; rec."Credit Card No.")
//                    {ApplicationArea = all;
//                    }
//                    field(GetCreditcardNumber; rec.GetCreditcardNumber)
//                    {ApplicationArea = all;
//                        Caption = 'Cr. Card Number (Last 4 Digits)';
//                    }*/
//             }
//             group(Invoice)
//             {
//                 Caption = 'Facturation';
//                 field("Contract Type"; rec."Contract Type")
//                 {
//                     ApplicationArea = all;
//                     Editable = "Contract TypeEditable";
//                 }
//                 field("Bill-to Customer No."; rec."Bill-to Customer No.")
//                 {
//                     ApplicationArea = all;
//                     Editable = "Bill-to Customer No.Editable";
//                 }
//                 field("Bill-to Contact No."; rec."Bill-to Contact No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Bill-to Name"; rec."Bill-to Name")
//                 {
//                     ApplicationArea = all;
//                     AssistEdit = true;
//                     Editable = "Bill-to NameEditable";

//                     /* GL2024  trigger OnAssistEdit()
//                        begin
//                            CurrPage.SAVERECORD;
//                            COMMIT;
//                            CLEAR(AddressContributors);
//                            AddressContributors.InitRequest(3);
//                            AddressContributors.SETTABLEVIEW(Rec);
//                            AddressContributors.SETRECORD(Rec);
//                            AddressContributors.RUNMODAL;
//                            //AddressContributors.GETRECORD(Rec);
//                            CurrPage.UPDATE;
//                        end;*/
//                 }
//                 field(Descr; wDescr)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Posting Description';
//                     Editable = DescrEditable;

//                     trigger OnValidate()
//                     begin
//                         //POSTING_DESC
//                         IF wDescr = '' THEN BEGIN
//                             REC."Posting Description" := REC.wPostingDescription;
//                             wDescr := REC.wShowPostingDescription(REC."Posting Description");
//                         END ELSE
//                             REC."Posting Description" := wDescr;
//                         //POSTING_DESC//
//                     end;
//                 }
//                 field("Prices Including VAT1"; rec."Prices Including VAT")
//                 {
//                     ApplicationArea = all;

//                     trigger OnValidate()
//                     begin
//                         PricesIncludingVATC131OnAfterV;
//                     end;
//                 }
//                 field("Payment Terms Code"; rec."Payment Terms Code")
//                 {
//                     ApplicationArea = all;
//                     Editable = "Payment Terms CodeEditable";
//                 }
//                 field("Payment Method Code"; rec."Payment Method Code")
//                 {
//                     ApplicationArea = all;
//                     Editable = "Payment Method CodeEditable";
//                 }
//                 field("Due Date"; rec."Due Date")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Currency Code"; rec."Currency Code")
//                 {
//                     ApplicationArea = all;
//                     Editable = "Currency CodeEditable";

//                     trigger OnAssistEdit()
//                     begin
//                         ChangeExchangeRate.SetParameter(REC."Currency Code", REC."Currency Factor", REC."Posting Date");
//                         IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
//                             REC.VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter);
//                             CurrPage.UPDATE;
//                         END;
//                         CLEAR(ChangeExchangeRate);
//                     end;
//                 }
//                 field("Part Payment"; rec."Part Payment")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("VAT Bus. Posting Group"; rec."VAT Bus. Posting Group")
//                 {
//                     ApplicationArea = all;
//                     Editable = "VAT Bus. Posting GroupEditable";
//                 }
//             }
//             group(Posting)
//             {
//                 Caption = 'Validation';
//                 field("Subscription Starting Date"; rec."Subscription Starting Date")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Subscription End Date"; rec."Subscription End Date")
//                 {
//                     ApplicationArea = all;
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
//                 field("Responsibility Center"; rec."Responsibility Center")
//                 {
//                     ApplicationArea = all;
//                     Editable = "Responsibility CenterEditable";
//                 }
//                 field("Location Code"; rec."Location Code")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Review Formula Code"; rec."Review Formula Code")
//                 {
//                     ApplicationArea = all;
//                     Editable = "Review Formula CodeEditable";
//                 }
//                 field("Review Base Date"; rec."Review Base Date")
//                 {
//                     ApplicationArea = all;
//                     Editable = "Review Base DateEditable";
//                 }
//                 field("Sell-to Contact No."; rec."Sell-to Contact No.")
//                 {
//                     ApplicationArea = all;
//                     Editable = true;
//                 }
//             }
//             group("Follow up")
//             {
//                 Caption = 'Suivi';
//                 field("Progress Degree"; rec."Progress Degree")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("No. of Archived Versions"; rec."No. of Archived Versions")
//                 {
//                     ApplicationArea = all;

//                     trigger OnDrillDown()
//                     var
//                         lSalesHeaderArchive: Record "Sales Header Archive";
//                     begin
//                         CurrPage.SAVERECORD;
//                         COMMIT;
//                         lSalesHeaderArchive.SETRANGE("Document Type", REC."Document Type"::Order);
//                         lSalesHeaderArchive.SETRANGE("No.", REC."No.");
//                         lSalesHeaderArchive.SETRANGE("Doc. No. Occurrence", REC."Doc. No. Occurrence");
//                         IF lSalesHeaderArchive.GET(REC."Document Type"::Quote, REC."No.", REC."Doc. No. Occurrence", REC."No. of Archived Versions") THEN;
//                         PAGE.RUNMODAL(PAGE::"Sales List Archive", lSalesHeaderArchive);
//                         CurrPage.UPDATE(FALSE);
//                     end;
//                 }
//                 field(Status; rec.Status)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Finished; rec.Finished)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Your Reference"; rec."Your Reference")
//                 {
//                     ApplicationArea = all;
//                 }
//             }
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
//             }
//             group(Détails)
//             {
//                 Caption = 'Détails';
//                 part("Dtails Commande Vente Beton"; "Dtails Commande Vente Beton")
//                 {
//                     ApplicationArea = all;
//                     SubPageLink = "Code Commande" = FIELD("No.");
//                 }
//             }
//         }
//     }

//     actions
//     {

//         area(Promoted)
//         {

//             group("O&rder11")
//             {
//                 Caption = 'O&rder';

//                 actionref(Statistics1; Statistics) { }
//                 actionref("Customer Card1"; "Customer Card") { }
//                 actionref("C&ontact Card1"; "C&ontact Card") { }

//                 group("Co&mments1")
//                 {
//                     Caption = 'Co&mmentaires';
//                     actionref("Standard Co&mments1"; "Standard Co&mments") { }
//                     actionref("Header Comments1"; "Header Comments") { }
//                     actionref("Footer Comments1"; "Footer Comments") { }
//                 }
//                 actionref("S&hipments1"; "S&hipments") { }
//                 actionref(Invoices1; Invoices) { }
//                 actionref("Prepa&yment Invoices1"; "Prepa&yment Invoices") { }
//                 actionref("Prepayment Credi&t Memos1"; "Prepayment Credi&t Memos") { }
//                 actionref(Dimensions1; Dimensions) { }
//                 actionref("A&pprovals1"; "A&pprovals") { }
//                 actionref(Folder1; Folder) { }
//                 actionref(Reports1; Reports) { }
//                 actionref(Description1; Description) { }
//                 actionref("Interaction Log E&ntries1"; "Interaction Log E&ntries") { }
//                 actionref("Price Study Archive1"; "Price Study Archive") { }
//                 actionref("Measurement : Document var1"; "Measurement : Document var") { }
//                 actionref("Quote Footer1"; "Quote Footer") { }
//                 actionref("Pla&nning1"; "Pla&nning") { }
//                 actionref("Invoicing Scheduler1"; "Invoicing Scheduler") { }
//                 actionref("Production Completion1"; "Production Completion") { }
//                 actionref("Planning Task1"; "Planning Task") { }
//             }


//             group("F&unctions1")
//             {
//                 Caption = 'F&onctions';

//                 actionref("Calculate &Invoice Discount1"; "Calculate &Invoice Discount") { }
//                 actionref("Copy Document1"; "Copy Document") { }
//                 group("Line copy1")
//                 {
//                     Caption = 'Line copy';
//                     actionref("From Sales Line Archive1"; "From Sales Line Archive") { }
//                     actionref("From Sales Line1"; "From Sales Line") { }
//                 }
//                 actionref("Archi&ve Document1"; "Archi&ve Document") { }
//                 actionref("Get Price1"; "Get Price") { }
//                 actionref("Get Li&ne Discount1"; "Get Li&ne Discount") { }
//                 actionref("E&xplode BOM1"; "E&xplode BOM") { }

//                 group("Drop Shipment1")
//                 {
//                     Caption = 'Drop Shipment';
//                     actionref("Purchase &Order11"; "Purchase &Order1") { }

//                 }

//                 group("Special Order1")
//                 {
//                     Caption = 'Special Order';
//                     actionref("Purchase &Order12"; "Purchase &Order") { }

//                 }

//                 actionref("Order &Tracking1"; "Order &Tracking") { }
//                 actionref("Nonstoc&k Items1"; "Nonstoc&k Items") { }


//                 actionref("Order &Promising1"; "Order &Promising") { }
//                 group(Warehouse1)
//                 {
//                     Caption = 'Warehouse';
//                     actionref("Shipment Lines1"; "Shipment Lines") { }
//                     actionref("Create &Whse. Shipment1"; "Create &Whse. Shipment") { }

//                 }
//                 actionref("Send A&pproval Request1"; "Send A&pproval Request") { }
//                 actionref("Cancel Approval Re&quest1"; "Cancel Approval Re&quest") { }
//                 actionref("Re&lease1"; "Re&lease") { }
//                 actionref("Re&open1"; "Re&open") { }

//                 group(Subcontracting1)
//                 {
//                     Caption = 'Subcontracting';
//                     actionref("Update Cost1"; "Update Cost") { }

//                     actionref("Purchase D&ocument1"; "Purchase D&ocument") { }
//                 }
//                 actionref("Update Budget1"; "Update Budget") { }


//             }

//             group("P&osting1")
//             {
//                 Caption = 'P&osting';
//                 actionref("Test Report1"; "Test Report") { }

//                 actionref("P&ost1"; "P&ost") { }
//                 actionref("Post and &Print1"; "Post and &Print") { }
//                 actionref("Post &Batch1"; "Post &Batch") { }
//                 group("Prepa&yment1")
//                 {
//                     Caption = 'Prepa&yment';
//                     actionref("Prepayment &Test Report1"; "Prepayment &Test Report") { }
//                     actionref("Post Prepayment &Invoice1"; "Post Prepayment &Invoice") { }
//                     actionref("Post and Print Prepmt. Invoic&e1"; "Post and Print Prepmt. Invoic&e") { }
//                     actionref("Post Prepayment &Credit Memo1"; "Post Prepayment &Credit Memo") { }
//                     actionref("Post and Print Prepmt. Cr. Mem&o1"; "Post and Print Prepmt. Cr. Mem&o") { }
//                 }
//             }

//             group("&Print1")
//             {
//                 Caption = '&Print';
//                 actionref("Order Confirmation1"; "Order Confirmation") { }
//                 actionref(Commande1; Commande) { }
//                 actionref("Work Order1"; "Work Order") { }
//                 actionref(Proforma1; Proforma) { }

//                 actionref("Pre-Invoice1"; "Pre-Invoice") { }
//             }


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
//                     Visible = false;

//                     trigger OnAction()
//                     var
//                         lGR: Record "Gen. Product Posting Group";
//                         lInvScheduler: Record "Invoice Scheduler";
//                     //GL2024 lStat: Page 8004045;
//                     begin
//                         // >> HJ SORO 16-10-2014
//                         CduSalesPost2.CalcTimbre(Rec);
//                         // >> HJ SORO 16-10-2014
//                         REC.CalcInvDiscForHeader;
//                         COMMIT;
//                         //+ONE+
//                         //page.RUNMODAL(page::"Sales Order Statistics",Rec);
//                         //+ONE+//
//                         //Currpage.SalesLines.PAGE.wCalcJobCostRepartition;       Fait dans lStat
//                         //COMMIT;
//                         //PROJET_FACT
//                         IF rec."Invoicing Method" = rec."Invoicing Method"::Scheduler THEN BEGIN
//                             CLEAR(lInvScheduler);
//                             lInvScheduler.SETRANGE("Sales Header Doc. Type", rec."Document Type");
//                             lInvScheduler.SETRANGE("Sales Header Doc. No.", rec."No.");
//                             lInvScheduler.SETFILTER("Document Percentage", '<>0');
//                             IF NOT lInvScheduler.ISEMPTY THEN BEGIN
//                                 lInvScheduler.FINDFIRST;
//                                 lInvScheduler.UpdateLineAmount(lInvScheduler);
//                                 COMMIT;
//                             END;
//                         END;
//                         //PROJET_FACT//
//                         //GL2024  lStat.GetSalesHeader("Document Type", rec"No.");
//                         lGR.SETRANGE("Document Type Filter", rec."Document Type");
//                         lGR.SETRANGE("Document No. Filter", rec."No.");
//                         //lGR.SETRANGE("Job Filter","Job No.");
//                         //#9092
//                         lGR.SETFILTER("Job Totaling", '%1', rec."Job No.");
//                         //#9092//
//                         //GL2024  lStat.SETTABLEVIEW(lGR);
//                         //Fenetre.CLOSE;
//                         //GL2024 lStat.RUNMODAL;
//                     end;
//                 }
//                 action("Customer Card")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Customer Card';
//                     RunObject = Page "Customer Card";
//                     RunPageLink = "No." = FIELD("Sell-to Customer No.");
//                     ShortCutKey = 'Maj+F7';
//                 }
//                 action("C&ontact Card")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'C&ontact Card';
//                     RunObject = Page "Contact List";
//                     RunPageLink = "No." = FIELD("Sell-to Contact No.");
//                 }
//                 group("Co&mments")
//                 {
//                     Caption = 'Co&mments';
//                     action("Standard Co&mments")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Standard Co&mments';
//                         RunObject = Page "Sales Comment Sheet";
//                         RunPageLink = "Document Type" = FIELD("Document Type"), "No." = FIELD("No."), "Document Line No." = CONST(0);
//                     }
//                     action("Header Comments")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Header Comments';

//                         trigger OnAction()
//                         var
//                             lSalesTextManagement: Codeunit "Sales Text Management";
//                         begin
//                             //+REF+ADDTEXT
//                             lSalesTextManagement.CommentText(Rec, 1);
//                             //+REF+ADDTEXT//
//                         end;
//                     }
//                     action("Footer Comments")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Footer Comments';

//                         trigger OnAction()
//                         var
//                             lSalesTextManagement: Codeunit "Sales Text Management";
//                         begin
//                             //+REF+ADDTEXT
//                             lSalesTextManagement.CommentText(Rec, 2);
//                             //+REF+ADDTEXT//
//                         end;
//                     }
//                 }
//                 action("S&hipments")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'S&hipments';
//                     RunObject = Page "Posted Sales Shipments";
//                     RunPageLink = "Order No." = FIELD("No.");
//                     RunPageView = SORTING("Order No.");
//                 }
//                 action(Invoices)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Invoices';
//                     Image = Invoice;
//                     RunObject = Page "Posted Sales Invoices";
//                     RunPageLink = "Order No." = FIELD("No.");
//                     RunPageView = SORTING("Order No.");
//                 }
//                 action("Prepa&yment Invoices")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Prepa&yment Invoices';
//                     RunObject = Page "Posted Sales Invoices";
//                     RunPageLink = "Prepayment Order No." = FIELD("No.");
//                     RunPageView = SORTING("Prepayment Order No.");
//                     Visible = false;
//                 }
//                 action("Prepayment Credi&t Memos")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Prepayment Credi&t Memos';
//                     RunObject = Page "Posted Sales Credit Memos";
//                     RunPageLink = "Prepayment Order No." = FIELD("No.");
//                     RunPageView = SORTING("Prepayment Order No.");
//                     Visible = false;
//                 }
//                 action(Dimensions)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Dimensions';
//                     Image = Dimensions;

//                     trigger OnAction()
//                     begin
//                         Rec.ShowDocDim;
//                     end;
//                 }
//                 action("A&pprovals")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'A&pprovals';
//                     Image = Approvals;

//                     trigger OnAction()
//                     var
//                         ApprovalEntries: Page "Approval Entries";
//                     begin
//                         ApprovalEntries.SetRecordFilters(DATABASE::"Sales Header", rec."Document Type", rec."No.");
//                         ApprovalEntries.RUN;
//                     end;
//                 }
//                 action(Folder)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Folder';

//                     trigger OnAction()
//                     var
//                         lFolderManagement: Codeunit "Folder management";
//                     begin
//                         //+REF+FOLDER
//                         lFolderManagement.SalesHeader(Rec);
//                         //+REF+FOLDER//
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
//                 /*//GL2024 NAVIBAT action("Statistics Criteria")
//                 {ApplicationArea = all;
//                     Caption = 'Statistics Criteria';

//                     trigger OnAction()
//                     var
//                         lSalesHeader: Record 36;
//                       //GL2024 NAVIBAT   lFormStatSales: Page 8035125;
//                     begin
//                         lSalesHeader := Rec;
//                         lFormStatSales.SETRECORD(lSalesHeader);
//                         lFormStatSales.fSetSalesDoc(TRUE);
//                         lFormStatSales.RUNMODAL();
//                         Rec := lSalesHeader;
//                         CurrPage.UPDATE(TRUE);
//                     end;
//                 }
//                action("Additionnals Informations")
//                 {ApplicationArea = all;
//                     Caption = 'Additionnals Informations';

//                     trigger OnAction()
//                     var
//                         lSalesHeader: Record 36;
//                       //GL2024 NAVIBAT  LfORMaDDiNFO: Page 8035126;
//                     begin
//                         lSalesHeader := Rec;
//                         LfORMaDDiNFO.SETRECORD(lSalesHeader);
//                         LfORMaDDiNFO.RUNMODAL;
//                         Rec := lSalesHeader;
//                         CurrPage.UPDATE(TRUE);
//                     end;
//                 }*/
//                 action(Description)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Description';

//                     trigger OnAction()
//                     var
//                         lDesc: Record "Description Line";
//                     begin
//                         lDesc.ShowDescription(36, rec."Document Type", rec."No.", 0);
//                     end;
//                 }
//                 /* GL2024  action("Contacts and Contributors")
//                     {ApplicationArea = all;
//                         Caption = 'Contacts and Contributors';
//                         RunObject = Page 8004022;
//                                         RunPageLink = "Document Type"=FIELD("Document Type"), "No."=FIELD("No.");
//                     }*/
//                 action("Interaction Log E&ntries")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Interaction Log E&ntries';

//                     trigger OnAction()
//                     begin
//                         //CRM
//                         REC.wShowDocumentInteraction(Rec);
//                         //CRM//
//                     end;
//                 }
//                 /* GL2024    action("Job Sales Documents")
//                   {ApplicationArea = all;
//                       Caption = 'Job Sales Documents';
//                       RunObject = Page 8004056;
//                                       RunPageLink = Job No.=FIELD(Job No.);
//                       RunPageView = SORTING(Job No.) WHERE(Job No.=FILTER(<>''), Order Type=CONST(" "));
//                   }*/
//                 action("Price Study Archive")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Price Study Archive';

//                     trigger OnAction()
//                     var
//                         lSalesHeaderArchive: Record "Sales Header Archive";
//                     begin
//                         lSalesHeaderArchive.SETCURRENTKEY("Document Type", "Order No.");
//                         lSalesHeaderArchive.SETRANGE("Document Type", lSalesHeaderArchive."Document Type"::Quote);
//                         lSalesHeaderArchive.SETRANGE("Order No.", REC."No.");
//                         IF NOT lSalesHeaderArchive.ISEMPTY THEN BEGIN
//                             IF lSalesHeaderArchive.COUNT > 1 THEN
//                                 PAGE.RUNMODAL(PAGE::"Sales List Archive", lSalesHeaderArchive);
//                             /*  //GL2024 NAVIBAT  ELSE
//                                    PAGE.RUNMODAL(PAGE::"NaviBat Sales Archive", lSalesHeaderArchive);*/
//                         END;
//                     end;
//                 }
//                 separator(separator11)
//                 {
//                 }
//                 action("Measurement : Document var")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Measurement : Document var';

//                     trigger OnAction()
//                     var
//                         lRecRef: RecordRef;
//                         lBOQCustMgt: Codeunit "BOQ Custom Management";
//                     begin
//                         //#6115
//                         lRecRef.GETTABLE(Rec);
//                         IF NOT lBOQCustMgt.fShowBOQLine(lRecRef) THEN
//                             EXIT;
//                         CurrPage.UPDATE(FALSE);
//                         //#6115//
//                     end;
//                 }
//                 action("Quote Footer")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Quote Footer';

//                     trigger OnAction()
//                     var
//                         lSalesLine: Record "Sales Line";
//                     begin
//                         lSalesLine.SETRANGE("Document Type", REC."Document Type");
//                         lSalesLine.SETRANGE("Document No.", REC."No.");
//                         //GL2024 NAVIBAT PAGE.RUNMODAL(PAGE::"Quote Footer", lSalesLine);
//                     end;
//                 }
//                 separator(separator1)
//                 {
//                 }
//                 action("Pla&nning")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Pla&nning';

//                     trigger OnAction()
//                     var
//                         SalesPlanForm: Page "Sales Order Planning";
//                     begin

//                         SalesPlanForm.SetSalesOrder(REC."No.");
//                         SalesPlanForm.RUNMODAL;
//                     end;
//                 }
//                 /* GL2024 action("Total needs")
//                   {ApplicationArea = all;
//                       Caption = 'Total needs';
//                       RunObject = Page 8004085;
//                                       RunPageLink = Document Type=FIELD(Document Type), Document No.=FIELD(No.);
//                       Visible = false;
//                   }
//                   action("Total needs 2")
//                   {ApplicationArea = all;
//                       Caption = 'Total needs 2';
//                       ShortCutKey = 'Ctrl+F11';

//                       trigger OnAction()
//                       var
//                           lFormNeed: Page 8004085;
//                       begin
//                           //#8255
//                           lFormNeed.fSetDocumentType(Rec."Document Type");
//                           lFormNeed.fSetDocumentNo(Rec."No.");
//                           lFormNeed.RUNMODAL();
//                           //#8255//
//                       end;
//                   }
//                   action(Guarantees)
//                   {ApplicationArea = all;
//                       Caption = 'Guarantees';
//                       RunObject = Page 8003994;
//                                       RunPageLink = Document Type=FIELD(Document Type), No.=FIELD(No.);
//                   }*/
//                 action("Invoicing Scheduler")
//                 {
//                     Caption = 'Invoicing Scheduler';
//                     ApplicationArea = all;
//                     trigger OnAction()
//                     var
//                         lInvSch: Record "Invoice Scheduler";
//                     begin
//                         //PROJET_FACT
//                         REC.TESTFIELD("Invoicing Method", REC."Invoicing Method"::Scheduler);
//                         lInvSch.SETRANGE("Sales Header Doc. Type", REC."Document Type");
//                         lInvSch.SETRANGE("Sales Header Doc. No.", REC."No.");
//                         PAGE.RUN(0, lInvSch);
//                         //PROJET_FACT//
//                     end;
//                 }
//                 action("Production Completion")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Production Completion';

//                     trigger OnAction()
//                     var
//                         lCompletionMgt: Codeunit "Completion Management";
//                     begin
//                         //PROJET_FACT
//                         //#4523  TESTFIELD(Status,Status::Released);
//                         //TESTFIELD("Invoicing Method");
//                         lCompletionMgt.fShowCompletion(Rec);
//                         //PROJET_FACT//
//                     end;
//                 }
//                 /*  GL2024 action(Prepayments)
//                    {ApplicationArea = all;
//                        Caption = 'Prepayments';
//                        RunObject = Page 8003978;
//                        RunPageLink = Document Type=FIELD(Document Type), No.=FIELD(No.);
//                    }*/
//                 action("Planning Task")
//                 {
//                     Caption = 'Planning Task';
//                     ApplicationArea = all;
//                     trigger OnAction()
//                     var
//                         lRecordRef: RecordRef;
//                         lPlanTask: Record "Planning Line";
//                     begin
//                         //PLANNING\\
//                         lRecordRef.GETTABLE(Rec);
//                         lPlanTask.SETFILTER("Source Record ID", FORMAT(lRecordRef.RECORDID));
//                         //GL2024 NAVIBAT  PAGE.RUNMODAL(PAGE::"Planning Task List", lPlanTask);
//                     end;
//                 }
//             }
//         }
//         area(processing)
//         {
//             group("P&osting")
//             {
//                 Caption = 'P&osting';
//                 Visible = false;
//                 action("Test Report")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Test Report';
//                     Ellipsis = true;
//                     Image = TestReport;

//                     trigger OnAction()
//                     begin
//                         ReportPrint.PrintSalesHeader(Rec);
//                     end;
//                 }
//                 action("P&ost")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'P&ost';
//                     Ellipsis = true;
//                     Image = Post;

//                     ShortCutKey = 'F9';

//                     trigger OnAction()
//                     var
//                         PurchaseHeader: Record "Purchase Header";
//                         ApprovalMgt: Codeunit "Approvals Mgmt.";
//                         CduReleasalesdoc: Codeunit "Prepayment Mgt.";
//                     begin
//                         //GL2024   IF ApprovalMgt.PrePostApprovalCheck(Rec, PurchaseHeader) THEN BEGIN

//                         IF ApprovalMgt.PrePostApprovalCheckSales(rec) and ApprovalMgt.PrePostApprovalCheckPurch(PurchaseHeader) then BEGIN
//                             IF CduReleasalesdoc.TestSalesPrepayment(Rec) THEN
//                                 ERROR(STRSUBSTNO(Text001, rec."Document Type", rec."No."))
//                             ELSE BEGIN
//                                 IF CduReleasalesdoc.TestSalesPayment(Rec) THEN
//                                     ERROR(STRSUBSTNO(Text002, rec."Document Type", rec."No."))
//                                 ELSE BEGIN
//                                     //#8742
//                                     rec.TESTFIELD("Invoicing Method", rec."Invoicing Method"::Direct);
//                                     //#8742//
//                                     //PROJET_FACT
//                                     CODEUNIT.RUN(CODEUNIT::"Sales-Post (Yes/No)", Rec);
//                                     CurrPage.UPDATE(FALSE);
//                                     //PROJET_FACT//
//                                 END;
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

//                     trigger OnAction()
//                     var
//                         PurchaseHeader: Record "Purchase Header";
//                         ApprovalMgt: Codeunit "Approvals Mgmt.";
//                         CduReleasalesdoc: Codeunit "Prepayment Mgt.";
//                     begin
//                         //GL2024  IF ApprovalMgt.PrePostApprovalCheck(Rec, PurchaseHeader) THEN BEGIN
//                         IF ApprovalMgt.PrePostApprovalCheckSales(rec) and ApprovalMgt.PrePostApprovalCheckPurch(PurchaseHeader) then BEGIN
//                             IF CduReleasalesdoc.TestSalesPrepayment(Rec) THEN
//                                 ERROR(STRSUBSTNO(Text001, rec."Document Type", rec."No."))
//                             ELSE BEGIN
//                                 IF CduReleasalesdoc.TestSalesPayment(Rec) THEN
//                                     ERROR(STRSUBSTNO(Text002, rec."Document Type", rec."No."))
//                                 ELSE BEGIN
//                                     //PROJET_FACT
//                                     rec.TESTFIELD("Invoicing Method", rec."Invoicing Method"::Direct);
//                                     CODEUNIT.RUN(CODEUNIT::"Sales-Post + Print", Rec);
//                                     CurrPage.UPDATE(FALSE);
//                                     //PROJET_FACT//
//                                 END;
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
//                         //PROJET_FACT
//                         IF rec."Invoicing Method" = rec."Invoicing Method"::Direct THEN
//                             //PROJET_FACT//
//                             REPORT.RUNMODAL(REPORT::"Batch Post Sales Invoices", TRUE, TRUE, Rec);
//                         CurrPage.UPDATE(FALSE);
//                     end;
//                 }
//                 separator(separator10)
//                 {
//                 }
//                 group("Prepa&yment")
//                 {
//                     Caption = 'Prepa&yment';
//                     Visible = false;
//                     action("Prepayment &Test Report")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Prepayment &Test Report';
//                         Ellipsis = true;

//                         trigger OnAction()
//                         begin
//                             ReportPrint.PrintSalesHeaderPrepmt(Rec);
//                         end;
//                     }
//                     action("Post Prepayment &Invoice")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Post Prepayment &Invoice';
//                         Ellipsis = true;

//                         trigger OnAction()
//                         var
//                             PurchaseHeader: Record "Purchase Header";
//                             SalesPostYNPrepmt: Codeunit "Sales-Post Prepayment (Yes/No)";
//                         begin
//                             //GL2024   IF ApprovalMgt.PrePostApprovalCheck(Rec, PurchaseHeader) THEN
//                             IF ApprovalMgt.PrePostApprovalCheckSales(rec) and ApprovalMgt.PrePostApprovalCheckPurch(PurchaseHeader) then
//                                 SalesPostYNPrepmt.PostPrepmtInvoiceYN(Rec, FALSE);
//                         end;
//                     }
//                     action("Post and Print Prepmt. Invoic&e")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Post and Print Prepmt. Invoic&e';
//                         Ellipsis = true;

//                         trigger OnAction()
//                         var
//                             PurchaseHeader: Record "Purchase Header";
//                             SalesPostYNPrepmt: Codeunit "Sales-Post Prepayment (Yes/No)";
//                         begin
//                             //GL2024     IF ApprovalMgt.PrePostApprovalCheck(Rec, PurchaseHeader) THEN
//                             IF ApprovalMgt.PrePostApprovalCheckSales(rec) and ApprovalMgt.PrePostApprovalCheckPurch(PurchaseHeader) then
//                                 SalesPostYNPrepmt.PostPrepmtInvoiceYN(Rec, TRUE);
//                         end;
//                     }
//                     action("Post Prepayment &Credit Memo")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Post Prepayment &Credit Memo';
//                         Ellipsis = true;

//                         trigger OnAction()
//                         var
//                             PurchaseHeader: Record "Purchase Header";
//                             SalesPostYNPrepmt: Codeunit "Sales-Post Prepayment (Yes/No)";
//                         begin
//                             //GL2024   IF ApprovalMgt.PrePostApprovalCheck(Rec, PurchaseHeader) THEN
//                             IF ApprovalMgt.PrePostApprovalCheckSales(rec) and ApprovalMgt.PrePostApprovalCheckPurch(PurchaseHeader) then
//                                 SalesPostYNPrepmt.PostPrepmtCrMemoYN(Rec, FALSE);
//                         end;
//                     }
//                     action("Post and Print Prepmt. Cr. Mem&o")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Post and Print Prepmt. Cr. Mem&o';
//                         Ellipsis = true;

//                         trigger OnAction()
//                         var
//                             PurchaseHeader: Record "Purchase Header";
//                             SalesPostYNPrepmt: Codeunit "Sales-Post Prepayment (Yes/No)";
//                         begin
//                             //GL2024      IF ApprovalMgt.PrePostApprovalCheck(Rec, PurchaseHeader) THEN
//                             IF ApprovalMgt.PrePostApprovalCheckSales(rec) and ApprovalMgt.PrePostApprovalCheckPurch(PurchaseHeader) then
//                                 SalesPostYNPrepmt.PostPrepmtCrMemoYN(Rec, TRUE);
//                         end;
//                     }
//                 }
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
//                 action("Copy Document")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Copy Document';
//                     Ellipsis = true;
//                     Image = CopyDocument;

//                     trigger OnAction()
//                     begin
//                         CopySalesDoc.SetSalesHeader(Rec);
//                         CopySalesDoc.RUNMODAL;
//                         CLEAR(CopySalesDoc);
//                     end;
//                 }
//                 group("Line copy")
//                 {
//                     Caption = 'Line copy';
//                     action("From Sales Line Archive")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'From Sales Line Archive';
//                         Ellipsis = true;

//                         trigger OnAction()
//                         begin
//                             //DEVIS
//                             //#8254
//                             CurrPage.UPDATE(FALSE);
//                             //#8254//
//                             //DEVIS//
//                         end;
//                     }
//                     action("From Sales Line")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'From Sales Line';
//                         Ellipsis = true;

//                         trigger OnAction()
//                         begin
//                             //DEVIS
//                             //#8254
//                             CurrPage.UPDATE(FALSE);
//                             //#8254//
//                             //DEVIS//
//                         end;
//                     }
//                 }
//                 action("Archi&ve Document")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Archi&ve Document';

//                     trigger OnAction()
//                     begin
//                         //#8211
//                         ArchiveManagement2.fSetQuoteToOrder(FALSE);
//                         ArchiveManagement.ArchiveSalesDocument(Rec);
//                         //#8211//
//                         CurrPage.UPDATE(FALSE);
//                     end;
//                 }
//                 action("Get Price")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Get Price';
//                     Ellipsis = true;

//                     trigger OnAction()
//                     begin
//                         CurrPage.SalesLines.PAGE.ShowPrices
//                     end;
//                 }
//                 action("Get Li&ne Discount")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Get Li&ne Discount';
//                     Ellipsis = true;

//                     trigger OnAction()
//                     begin
//                         CurrPage.SalesLines.PAGE.ShowLineDisc
//                     end;
//                 }
//                 action("E&xplode BOM")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'E&xplode BOM';
//                     Image = ExplodeBOM;
//                     Visible = false;

//                     trigger OnAction()
//                     begin
//                         CurrPage.SalesLines.PAGE.ExplodeBOM;
//                     end;
//                 }
//                 group("Drop Shipment")
//                 {
//                     Caption = 'Drop Shipment';
//                     action("Purchase &Order1")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Purchase &Order';
//                         Image = Document;

//                         trigger OnAction()
//                         begin
//                             CurrPage.SalesLines.PAGE.OpenPurchOrderForm;
//                         end;
//                     }
//                 }
//                 group("Special Order")
//                 {
//                     Caption = 'Special Order';
//                     action("Purchase &Order")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Purchase &Order';
//                         Image = Document;

//                         trigger OnAction()
//                         begin
//                             CurrPage.SalesLines.PAGE.OpenSpecialPurchOrderForm;
//                         end;
//                     }
//                 }
//                 /*GL2024   action("&Reserve")
//                    {
//                        Caption = '&Reserve';
//                        Ellipsis = true;
//                        ApplicationArea = all;
//                        trigger OnAction()
//                        begin
//                            //DYS fonction obsolet
//                            //CurrPage.SalesLines.PAGE.ShowReservation;
//                        end;
//                    }*/
//                 action("Order &Tracking")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Order &Tracking';

//                     trigger OnAction()
//                     begin
//                         CurrPage.SalesLines.PAGE.ShowTracking;
//                     end;
//                 }
//                 separator(separator9)
//                 {
//                 }
//                 action("Nonstoc&k Items")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Nonstoc&k Items';

//                     trigger OnAction()
//                     begin
//                         CurrPage.SalesLines.PAGE.ShowNonstockItems;
//                     end;
//                 }
//                 action("Order &Promising")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Order &Promising';

//                     trigger OnAction()
//                     var
//                         OrderPromisingLine: Record "Order Promising Line" temporary;
//                         OrderPromising: Page "Order Promising Lines";
//                     begin
//                         OrderPromisingLine.SETRANGE("Source Type", REC."Document Type");
//                         OrderPromisingLine.SETRANGE("Source ID", REC."No.");
//                         PAGE.RUNMODAL(PAGE::"Order Promising Lines", OrderPromisingLine);
//                     end;
//                 }
//                 group(Warehouse)
//                 {
//                     Caption = 'Warehouse';
//                     action("Shipment Lines")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Shipment Lines';
//                         RunObject = Page "Whse. Shipment Lines";
//                         RunPageLink = "Source Type" = CONST(37), "Source Subtype" = FIELD("Document Type"), "Source No." = FIELD("No.");
//                         RunPageView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.");
//                     }
//                     action("Create &Whse. Shipment")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Create &Whse. Shipment';

//                         trigger OnAction()
//                         var
//                             GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
//                         begin
//                             GetSourceDocOutbound.CreateFromSalesOrder(Rec);

//                             IF NOT rec.FIND('=><') THEN
//                                 rec.INIT;
//                         end;
//                     }
//                 }
//                 separator(separator3)
//                 {
//                 }
//                 action("Send A&pproval Request")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Send A&pproval Request';
//                     Image = SendApprovalRequest;

//                     trigger OnAction()
//                     var
//                         ApprovalMgt: Codeunit "Approvals Mgmt.";
//                         "Release Sales Document": Codeunit "Release Sales Document";
//                     begin
//                         //GL204  IF ApprovalMgt.SendSalesApprovalRequest(Rec) THEN;
//                         IF ApprovalMgt.IsSalesApprovalsWorkflowEnabled(Rec) THEN;
//                     end;
//                 }
//                 action("Cancel Approval Re&quest")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Cancel Approval Re&quest';

//                     trigger OnAction()
//                     var
//                         ApprovalMgt: Codeunit "Approvals Mgmt.";
//                         "Release Sales Document": Codeunit "Release Sales Document";
//                     begin

//                     end;
//                 }
//                 separator(separator4)
//                 {
//                 }
//                 action("Re&lease")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Re&lease';
//                     Image = ReleaseDoc;
//                     ShortCutKey = 'Ctrl+F9';

//                     trigger OnAction()
//                     var
//                         ReleaseSalesDoc: Codeunit "Release Sales Document";
//                     begin
//                         ReleaseSalesDoc.PerformManualRelease(Rec);
//                     end;
//                 }
//                 action("Re&open")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Re&open';
//                     Image = ReOpen;
//                     ShortCutKey = 'Maj+Ctrl+F9';

//                     trigger OnAction()
//                     var
//                         ReleaseSalesDoc: Codeunit "Release Sales Document";
//                         lSalesHeader: Record "Sales Header";
//                     begin
//                         ReleaseSalesDoc.PerformManualReopen(Rec);
//                         //DEVIS
//                         CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
//                         //DEVIS//
//                     end;
//                 }
//                 separator(separator5)
//                 {
//                 }
//                 group(Subcontracting)
//                 {
//                     Caption = 'Subcontracting';
//                     action("Update Cost")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Update Cost';

//                         trigger OnAction()
//                         var
//                             lSalesHeader: Record "Sales Header";
//                         begin
//                             //SUBCONTRACTOR
//                             lSalesHeader.COPY(Rec);
//                             lSalesHeader.SETRECFILTER;
//                             //GL2024 NAVIBAT    REPORT.RUNMODAL(REPORT::"Update Subcontracting Cost", TRUE, FALSE, lSalesHeader);
//                             //SUBCONTRACTOR//
//                         end;
//                     }
//                     action("Purchase D&ocument")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Purchase D&ocument';

//                         trigger OnAction()
//                         begin
//                             CurrPage.SalesLines.PAGE.OpenPurchOrderForm;
//                         end;
//                     }
//                 }
//                 separator(separator8)
//                 {
//                 }
//                 action("Update Budget")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Update Budget';

//                     trigger OnAction()
//                     var
//                         lSaleHeader: Record "Sales Header";
//                     begin
//                         lSaleHeader.COPY(Rec);
//                         lSaleHeader.SETRECFILTER;
//                         //GL2024 NAVIBAT  REPORT.RUNMODAL(REPORT::"Sales to Job Budget Entry", TRUE, FALSE, lSaleHeader);
//                     end;
//                 }
//                 /* GL2024 action("Import/Export Sales Lines")
//                   {ApplicationArea = all;
//                       Caption = 'Import/Export Sales Lines';

//                       trigger OnAction()
//                       var
//                           lQuoteFromExcel: Report 8004054;
//                       begin
//                           CLEAR(lQuoteFromExcel);
//                           lQuoteFromExcel.InitRequest(rec."Document Type", rec."No.");
//                           lQuoteFromExcel.RUNMODAL;
//                       end;
//                   }*/
//                 separator(separator6)
//                 {
//                 }
//                 /* GL2024   action(Authorize)
//                     {ApplicationArea = all;
//                         Caption = 'Authorize';

//                         trigger OnAction()
//                         begin
//                             Authorize;
//                         end;
//                     }
//                     action("Void A&uthorize")
//                     {
//                         Caption = 'Void A&uthorize';

//                         trigger OnAction()
//                         begin
//                             Void;
//                         end;
//                     }*/
//             }
//             group("&Print")
//             {
//                 Caption = '&Print';
//                 action("Order Confirmation")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Order Confirmation';
//                     Ellipsis = true;
//                     Image = Print;

//                     trigger OnAction()
//                     begin
//                         DocPrint.PrintSalesOrder(Rec, Usage::"Order Confirmation");
//                     end;
//                 }
//                 action(Commande)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Commande';

//                     trigger OnAction()
//                     begin
//                         // >> HJ DSFT 10-10-2012
//                         IF rec.Status <> rec.Status::Released THEN ERROR(Text003);
//                         RecSalesHeader.SETRANGE("Document Type", rec."Document Type");
//                         RecSalesHeader.SETRANGE("No.", rec."No.");
//                         REPORT.RUNMODAL(REPORT::"Bon Commande Vente", TRUE, TRUE, RecSalesHeader);
//                         // >> HJ DSFT 10-10-2012
//                         // STD HJ DSFT 10-10-2012 DocPrint.PrintPurchHeader(Rec);
//                     end;
//                 }
//                 action("Work Order")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Work Order';
//                     Ellipsis = true;
//                     Image = Print;

//                     trigger OnAction()
//                     begin
//                         DocPrint.PrintSalesOrder(Rec, Usage::"Work Order");
//                     end;
//                 }
//                 action(Proforma)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Proforma';

//                     trigger OnAction()
//                     var
//                         lSalesInvoiceHeader: Record "Sales Invoice Header";
//                     begin
//                         //+REF+INVOICE
//                         lSalesInvoiceHeader.SETRANGE("Print Document Type", lSalesInvoiceHeader."Print Document Type"::Order);
//                         lSalesInvoiceHeader.SETRANGE("No.", rec."No.");
//                         lSalesInvoiceHeader.PrintRecords(TRUE);
//                         //+REF+INVOICE//
//                     end;
//                 }
//                 action("Pre-Invoice")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Pre-Invoice';

//                     trigger OnAction()
//                     var
//                         lSalesInvoiceHeader: Record "Sales Invoice Header";
//                     begin
//                         //+REF+INVOICE
//                         lSalesInvoiceHeader.SETRANGE("Print Document Type", lSalesInvoiceHeader."Print Document Type"::"Invoice Request");
//                         lSalesInvoiceHeader.SETRANGE("No.", rec."No.");
//                         lSalesInvoiceHeader.PrintRecords(TRUE);
//                         //+REF+INVOICE//
//                     end;
//                 }
//             }
//             /*GL2024    action(SalesHistoryBtn)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Sales H&istory';
//                     Enabled = SalesHistoryBtnEnable;
//                     Promoted = true;
//                     PromotedCategory = Process;

//                     trigger OnAction()
//                     begin
//                         //DYS fonction obsolet
//                         // SalesInfoPaneMgt.LookupCustSalesHistory(Rec, rec."Bill-to Customer No.", TRUE);
//                     end;
//                 }
//                 action("&Avail. Credit")
//                 {
//                     ApplicationArea = all;
//                     Caption = '&Avail. Credit';
//                     Promoted = true;
//                     PromotedCategory = Process;

//                     trigger OnAction()
//                     begin
//                         //DYS fonction obsolet
//                         // SalesInfoPaneMgt.LookupAvailCredit(rec."Bill-to Customer No.");
//                     end;
//                 }
//                 action(SalesHistoryStn)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Sales Histor&y';
//                     Enabled = SalesHistoryStnEnable;
//                     Promoted = true;
//                     PromotedCategory = Process;

//                     trigger OnAction()
//                     begin
//                         //DYS fonction obsolet
//                         //  SalesInfoPaneMgt.LookupCustSalesHistory(Rec, rec."Sell-to Customer No.", FALSE);
//                     end;
//                 }
//                 action("&Contacts")
//                 {
//                     ApplicationArea = all;
//                     Caption = '&Contacts';
//                     Promoted = true;
//                     PromotedCategory = Process;

//                     trigger OnAction()
//                     begin
//                         //DYS fonction obsolet
//                         // SalesInfoPaneMgt.LookupContacts(Rec);
//                     end;
//                 }*/
//         }
//     }

//     trigger OnAfterGetRecord()
//     begin
//         IF rec."No." <> xRec."No." THEN BEGIN
//             wMarked := FALSE;
//         END;

//         IF (rec."Project Manager" <> '') AND Contact.GET(rec."Project Manager") THEN
//             ProjectManagerName := Contact.Name
//         ELSE
//             ProjectManagerName := '';
//         //POSTING_DESC
//         wDescr := rec.wShowPostingDescription(rec."Posting Description");
//         //POSTING_DESC//
//         IF (rec."Sell-to Contact No." <> '') AND Contact.GET(rec."Sell-to Contact No.") THEN
//             ContactName := Contact.GetSalutation(1, rec."Language Code")
//         ELSE
//             ContactName := '';

//         //PROJET_FACT
//         IF rec."Rider to Order No." <> '' THEN
//             ActivateHeader(FALSE)
//         ELSE BEGIN
//             ActivateHeader(TRUE);
//             //PROJET_FACT//
//             IF rec."Job No." <> '' THEN BEGIN
//                 "Job Starting DateEditable" := FALSE;
//                 "Job Ending DateEditable" := FALSE;
//             END
//             ELSE BEGIN
//                 "Job Starting DateEditable" := TRUE;
//                 "Job Ending DateEditable" := TRUE;
//             END;
//             //PROJET_FACT
//         END;
//         //PROJET_FACT//
//         // RB SORO 28/09/2017
//         UserSetup.RESET;
//         IF UserSetup.GET(UPPERCASE(USERID)) THEN;
//         IF UserSetup."Filtre Service Vente" <> UserSetup."Filtre Service Vente"::" " THEN BEGIN
//             rec.FILTERGROUP(2);
//             rec.SETRANGE("Service Vente", UserSetup."Filtre Service Vente");
//             rec.FILTERGROUP(0);
//         END;
//         // RB SORO 28/09/2017
//         OnAfterGetCurrRecord1;
//     end;

//     trigger OnDeleteRecord(): Boolean
//     begin
//         CurrPage.UPDATE(TRUE);
//         EXIT(rec.ConfirmDeletion);
//     end;

//     trigger OnInit()
//     begin
//         SalesHistoryStnEnable := TRUE;
//         BillToCommentPictEnable := TRUE;
//         SalesHistoryBtnEnable := TRUE;
//         DescrEditable := TRUE;
//         "Responsibility CenterEditable" := TRUE;
//         "Review Base DateEditable" := TRUE;
//         "Review Formula CodeEditable" := TRUE;
//         "Contract TypeEditable" := TRUE;
//         "VAT Bus. Posting GroupEditable" := TRUE;
//         "Bill-to NameEditable" := TRUE;
//         "Bill-to Customer No.Editable" := TRUE;
//         "Payment Terms CodeEditable" := TRUE;
//         "Payment Method CodeEditable" := TRUE;
//         "Currency CodeEditable" := TRUE;
//         "Prices Including VATEditable" := TRUE;
//         "Project ManagerEditable" := TRUE;
//         "Job DescriptionEditable" := TRUE;
//         "Ship-to NameEditable" := TRUE;
//         "Job No.Editable" := TRUE;
//         "Ship-to CodeEditable" := TRUE;
//         "Sell-to Customer NameEditable" := TRUE;
//         "Sell-to Customer No.Editable" := TRUE;
//         SalesCommentBtnEnable := TRUE;
//         BillToCommentBtnEnable := TRUE;
//         SellToCommentBtnEnable := TRUE;
//         HelpEnable := TRUE;
//         "Job Ending DateEditable" := TRUE;
//         "Job Starting DateEditable" := TRUE;
//         wSplashOpened := TRUE;
//         wOpenSplash.OPEN(tOpenSplash);
//         //wFormEditable := Currpage.EDITABLE;
//         wFormEditable := TRUE;
//     end;

//     trigger OnInsertRecord(BelowxRec: Boolean): Boolean
//     begin
//         rec.CheckCreditMaxBeforeInsert;
//     end;

//     trigger OnNewRecord(BelowxRec: Boolean)
//     begin
//         rec."Responsibility Center" := UserMgt.GetSalesFilter();
//         rec."Order Type" := rec."Order Type"::" ";
//         rec."Document Type" := rec."Document Type"::Order;
//         ProjectManagerName := '';
//         ContactName := '';
//         rec."Commande Interne" := TRUE;
//         OnAfterGetCurrRecord1;
//     end;

//     trigger OnOpenPage()
//     var
//         lMaskMgt: Codeunit "Mask Management";
//         lSalesHeader: Record "Sales Header";
//     begin
//         IF wSplashOpened THEN BEGIN
//             wSplashOpened := FALSE;
//             wOpenSplash.CLOSE;
//             //+WKF+ CW 04/08/02 +Workflow Button
//             HelpEnable := TRUE;
//             SellToCommentBtnEnable := TRUE;
//             BillToCommentBtnEnable := TRUE;
//             SalesCommentBtnEnable := TRUE;
//         END;

//         //Inutile ? et empêche le lien livraison directe SETRANGE("No.");
//         IF UserMgt.GetSalesFilter() <> '' THEN BEGIN
//             rec.FILTERGROUP(2);
//             rec.SETRANGE("Responsibility Center", UserMgt.GetSalesFilter());
//             rec.FILTERGROUP(0);
//         END;

//         //+ONE+
//         //SETRANGE("Date Filter",0D,WORKDATE - 1);
//         //+ONE+//

//         //#8686
//         IF NOT lSalesHeader.GET(rec."Document Type", rec."No.") THEN
//             IF rec.FIND('-') THEN;
//         //#8686//
//         //Currpage.SalesLines.PAGE.SetUpdateAllowed(wFormEditable);
//         NavibatSetup.GET2;

//         ShowExtendedText := TRUE;

//         //MASK
//         lMaskMgt.SalesHeader(Rec);
//         //MASK//
//         // RB SORO 28/09/2017
//         UserSetup.RESET;
//         IF UserSetup.GET(UPPERCASE(USERID)) THEN;
//         IF UserSetup."Filtre Service Vente" <> UserSetup."Filtre Service Vente"::" " THEN BEGIN
//             rec.FILTERGROUP(2);
//             rec.SETRANGE("Service Vente", UserSetup."Filtre Service Vente");
//             rec.FILTERGROUP(0);
//         END;
//         // RB SORO 28/09/2017
//     end;

//     var
//         Text000: Label 'Unable to execute this function while in view only mode.';
//         CopySalesDoc: Report "Copy Sales Document";
//         MoveNegSalesLines: Report "Move Negative Sales Lines";
//         ApprovalMgt: Codeunit "Approvals Mgmt.";
//         ReportPrint: Codeunit "Test Report-Print";
//         DocPrint: Codeunit "Document-Print";
//         ArchiveManagement: Codeunit ArchiveManagement;
//         ArchiveManagement2: Codeunit ArchiveManagementEvent;
//         SalesInfoPaneMgt: Codeunit "Sales Info-Pane Management";
//         SalesSetup: Record "Sales & Receivables Setup";
//         ChangeExchangeRate: Page "Change Exchange Rate";
//         UserMgt: Codeunit "User Setup Management";
//         Usage: Option "Order Confirmation","Work Order";
//         Text001: Label 'There are non posted Prepayment Amounts on %1 %2.';
//         Text002: Label 'There are unpaid Prepayment Invoices related to %1 %2.';
//         Contact: Record Contact;
//         //GL2024 NAVIBAT  AddressContributors: Page 8004022;
//         MoveOption: Option Same,Left,Right,Up,Down;
//         OldRec: Record "Sales Header";
//         PresentationCode: Code[10];
//         ProjectManagerName: Text[30];
//         ContactName: Text[250];
//         SupplyOrderMgt: Codeunit "Reordering Req. Management";
//         wDescr: Text[100];
//         NavibatSetup: Record NavibatSetup;
//         TextUpdate: Label 'Processing...';
//         Fenetre: Dialog;
//         ShowLevel: Integer;
//         ShowExtendedText: Boolean;
//         wMarked: Boolean;
//         wSplashOpened: Boolean;
//         wOpenSplash: Dialog;
//         tOpenSplash: Label 'Open In Progress...';
//         wFormEditable: Boolean;
//         "// VAr HJ DSFT": Integer;
//         RecSalesHeader: Record "Sales Header";
//         Text003: Label 'Veuillez Lancer La Commande Avant Impression';
//         CduSalesPost: Codeunit "Sales-Post";
//         CduSalesPost2: Codeunit SalesPostEvent;

//         "// RB SORO 07/09/2015 BETON": Integer;
//         RecSalesLineBeton: Record "Sales Line";
//         UserSetup: Record "User Setup";

//         "Job Starting DateEditable": Boolean;

//         "Job Ending DateEditable": Boolean;

//         HelpEnable: Boolean;

//         SellToCommentBtnEnable: Boolean;

//         BillToCommentBtnEnable: Boolean;

//         SalesCommentBtnEnable: Boolean;

//         "Sell-to Customer No.Editable": Boolean;

//         "Sell-to Customer NameEditable": Boolean;

//         "Ship-to CodeEditable": Boolean;

//         "Job No.Editable": Boolean;

//         "Ship-to NameEditable": Boolean;

//         "Job DescriptionEditable": Boolean;

//         "Project ManagerEditable": Boolean;

//         "Prices Including VATEditable": Boolean;

//         "Currency CodeEditable": Boolean;

//         "Payment Method CodeEditable": Boolean;

//         "Payment Terms CodeEditable": Boolean;

//         "Bill-to Customer No.Editable": Boolean;

//         "Bill-to NameEditable": Boolean;

//         "VAT Bus. Posting GroupEditable": Boolean;

//         "Contract TypeEditable": Boolean;

//         "Review Formula CodeEditable": Boolean;

//         "Review Base DateEditable": Boolean;

//         "Responsibility CenterEditable": Boolean;

//         DescrEditable: Boolean;

//         SalesHistoryBtnEnable: Boolean;

//         BillToCommentPictEnable: Boolean;

//         SalesHistoryStnEnable: Boolean;
//         Text19070588: Label 'Sell-to Customer';
//         Text19069283: Label 'Bill-to Customer';


//     procedure UpdateAllowed(): Boolean
//     begin
//         IF wFormEditable = FALSE THEN
//             ERROR(Text000);
//         EXIT(TRUE);
//     end;

//     local procedure UpdateInfoPanel()
//     var
//         DifferSellToBillTo: Boolean;
//     begin
//         DifferSellToBillTo := rec."Sell-to Customer No." <> rec."Bill-to Customer No.";
//         SalesHistoryBtnEnable := DifferSellToBillTo;
//         BillToCommentPictEnable := DifferSellToBillTo;
//         BillToCommentBtnEnable := DifferSellToBillTo;
//         //DYS fonction obsolet
//         //SalesHistoryStnEnable := SalesInfoPaneMgt.DocExist(Rec, rec."Sell-to Customer No.");
//         //IF DifferSellToBillTo THEN
//         //  SalesHistoryBtnEnable := SalesInfoPaneMgt.DocExist(Rec, rec."Bill-to Customer No.")
//     end;

//     local procedure ApproveCalcInvDisc()
//     begin
//         CurrPage.SalesLines.PAGE.ApproveCalcInvDisc;
//     end;


//     procedure ActivateHeader(Active: Boolean)
//     begin
//         "Sell-to Customer No.Editable" := Active;
//         "Sell-to Customer NameEditable" := Active;
//         "Ship-to CodeEditable" := Active;
//         "Job No.Editable" := Active;
//         "Ship-to NameEditable" := Active;
//         "Job Starting DateEditable" := Active;
//         "Job Ending DateEditable" := Active;
//         "Job DescriptionEditable" := Active;
//         "Project ManagerEditable" := Active;
//         "Prices Including VATEditable" := Active;
//         "Currency CodeEditable" := Active;
//         "Payment Method CodeEditable" := Active;
//         "Payment Terms CodeEditable" := Active;
//         "Bill-to Customer No.Editable" := Active;
//         "Bill-to NameEditable" := Active;
//         "VAT Bus. Posting GroupEditable" := Active;
//         "Contract TypeEditable" := Active;
//         "Review Formula CodeEditable" := Active;
//         "Review Base DateEditable" := Active;
//         "Responsibility CenterEditable" := Active;
//         DescrEditable := Active;
//     end;

//     local procedure SelltoCustomerNoOnAfterValidat()
//     var
//         RecSalesSetup: Record "Sales & Receivables Setup";
//     begin
//         CurrPage.UPDATE;
//         // RB SORO 11/01/2017 APPLIQUER DATE COMPTABILISATION PAR DEFAUT DS LES CMD VENTE BETON
//         IF rec."Document Type" = rec."Document Type"::Order THEN BEGIN
//             RecSalesSetup.GET;
//             IF RecSalesSetup."Date Cmd Beton" <> 0D THEN BEGIN
//                 rec.VALIDATE("Posting Date", RecSalesSetup."Date Cmd Beton");
//                 rec."Order Date" := RecSalesSetup."Date Cmd Beton";
//             END;
//         END;
//         // RB SORO 11/01/2017 APPLIQUER DATE COMPTABILISATION PAR DEFAUT DS LES CMD VENTE BETON
//     end;

//     local procedure PricesIncludingVATC1000000013O()
//     begin
//         CurrPage.UPDATE;
//     end;

//     local procedure ProjectManagerOnAfterValidate()
//     begin
//         IF (rec."Project Manager" <> xRec."Project Manager") AND (rec."Project Manager" <> '') THEN
//             IF Contact.GET(rec."Project Manager") THEN
//                 ProjectManagerName := Contact.Name
//             ELSE
//                 ProjectManagerName := '';
//         IF rec."Project Manager" = '' THEN
//             ProjectManagerName := '';
//     end;

//     local procedure PricesIncludingVATC131OnAfterV()
//     begin
//         CurrPage.UPDATE;
//     end;

//     local procedure ShortcutDimension1CodeOnAfterV()
//     begin
//         CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
//     end;

//     local procedure ShortcutDimension2CodeOnAfterV()
//     begin
//         CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
//     end;

//     local procedure Prepayment37OnAfterValidate()
//     begin
//         CurrPage.UPDATE;
//     end;

//     local procedure OnAfterGetCurrRecord1()
//     begin
//         xRec := Rec;
//         rec.SETRANGE("Document Type");
//     end;

//     local procedure SelltoContactNoOnDeactivate()
//     begin
//         IF rec."Sell-to Contact No." <> xRec."Sell-to Contact No." THEN
//             IF Contact.GET(rec."Sell-to Contact No.") THEN
//                 ContactName := Contact.GetSalutation(1, rec."Language Code");
//         //#4250
//         CurrPage.UPDATE;
//         //#4250//
//     end;
// }

