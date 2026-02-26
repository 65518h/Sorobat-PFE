PageExtension 50033 "Purchase Quote_PagEXT" extends "Purchase Quote"
{
    layout
    {
        modify("No.")
        {
            Visible = true;
            Editable = false;
            trigger OnAssistEdit()
            begin
                IF rec.AssistEdit(xRec) THEN
                    CurrPage.UPDATE;
            end;
        }

        modify("Buy-from Contact No.")
        {
            trigger OnLookup(var Text: Text): Boolean
            begin
                //ACHATS
                rec.wBuyFromContactLookUp;
                CurrPage.UPDATE;
                //ACHATS//
            end;
        }
        addafter(Status)
        {
            field("Posting Date"; Rec."Posting Date")
            {

                ApplicationArea = all;
            }


            field("Generer A Partir DA"; Rec."Generer A Partir DA")
            {
                ApplicationArea = all;
                Style = Attention;
                StyleExpr = true;
                trigger OnValidate()
                var

                    RecPurchaseRequest: Record "Purchase Request";
                    RecPurchaseRequetLine: Record "Purchase Request Line";
                begin
                    IF rec."Generer A Partir DA" = '' THEN EXIT;
                    IF NOT CONFIRM(Text001) THEN EXIT;
                    IF RecPurchaseRequest.GET(rec."Generer A Partir DA") THEN BEGIN
                        rec."DA Créer Par" := RecPurchaseRequest."User ID";

                        //     rec."Job No." := RecPurchaseRequest."Job No.";
                        Rec.Validate("Job No.", RecPurchaseRequest."Job No.");
                        //   rec.Engin := RecPurchaseRequest.Engin;
                        rec."Date DA" := RecPurchaseRequest."Order Date";
                        rec."N° Demande d'achat" := rec."Generer A Partir DA";
                        rec.MODIFY;
                        RecPurchaseRequetLine.SETfilter(Statut, '%1|%2', RecPurchaseRequetLine.Statut::approved, RecPurchaseRequetLine.Statut::"Partially Covered");
                        RecPurchaseRequetLine.SETRANGE("Document No.", rec."Generer A Partir DA");
                        IF RecPurchaseRequetLine.FINDFIRST THEN
                            REPEAT

                                PurchaseLigne."Document Type" := rec."Document Type";
                                PurchaseLigne."Document No." := rec."No.";
                                PurchaseLigne."Line No." := RecPurchaseRequetLine."Line No.";
                                PurchaseLigne.VALIDATE(Type, RecPurchaseRequetLine.Type);
                                PurchaseLigne.VALIDATE("No.", RecPurchaseRequetLine."No.");
                                PurchaseLigne.VALIDATE("Location Code", RecPurchaseRequetLine."Location Code");
                                PurchaseLigne.VALIDATE(Quantity, RecPurchaseRequetLine.Quantity);
                                PurchaseLigne.VALIDATE("dysJob No.", RecPurchaseRequest."Job No.");
                                //    PurchaseLigne.VALIDATE("dysJob Task No.", RecPurchaseRequetLine."Job Task No.");
                                PurchaseLigne."DYSJob Task No." := RecPurchaseRequetLine."Job Task No.";
                                PurchaseLigne.VALIDATE("Direct Unit Cost", RecPurchaseRequetLine."Unit Cost");
                                IF PurchaseLigne.INSERT THEN;
                            UNTIL RecPurchaseRequetLine.NEXT = 0;
                        // "User ID":=SalesHeader."Requester ID";
                        // "Attached to Doc. No.":="Generer A Partir DA";

                    END;
                    // IF rec."Generer A Partir DA" = '' THEN EXIT;
                    // IF NOT CONFIRM(Text001) THEN EXIT;
                    // IF SalesHeader.GET(SalesHeader."Document Type"::Order, rec."Generer A Partir DA") THEN BEGIN
                    //     rec."DA Créer Par" := SalesHeader."User ID";
                    //     rec."Job No." := SalesHeader."Job No.";
                    //     rec.Engin := SalesHeader.Engin;
                    //     rec."Date DA" := SalesHeader."Order Date";
                    //     rec."N° Demande d'achat" := rec."Generer A Partir DA";
                    //     rec.MODIFY;
                    //     SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Order);
                    //     SalesLine.SETRANGE("Document No.", rec."Generer A Partir DA");
                    //     IF SalesLine.FINDFIRST THEN
                    //         REPEAT

                    //             PurchaseLigne."Document Type" := rec."Document Type";
                    //             PurchaseLigne."Document No." := rec."No.";
                    //             PurchaseLigne."Line No." := SalesLine."Line No.";
                    //             PurchaseLigne.VALIDATE(Type, SalesLine.Type);
                    //             PurchaseLigne.VALIDATE("No.", SalesLine."No.");
                    //             PurchaseLigne.VALIDATE("Location Code", SalesLine."Location Code");
                    //             PurchaseLigne.VALIDATE(Quantity, SalesLine.Quantity);
                    //             PurchaseLigne.VALIDATE("Job No.", SalesHeader."Job No.");
                    //             IF PurchaseLigne.INSERT THEN;
                    //         UNTIL SalesLine.NEXT = 0;
                    //     // "User ID":=SalesHeader."Requester ID";
                    //     // "Attached to Doc. No.":="Generer A Partir DA";

                    // END;
                end;
            }
            // field(Engin; Rec.Engin)
            // {

            //     ApplicationArea = all;
            // }
            field("DA Créer Par"; Rec."DA Créer Par")
            {

                ApplicationArea = all;
                Style = Attention;
                StyleExpr = true;
            }
            field("User ID"; Rec."User ID")
            {
                Caption = 'Demandeur';
                ApplicationArea = all;
            }

            field("Job No."; Rec."Job No.")
            {
                Caption = 'N° Affaire';
                ApplicationArea = all;
                ShowMandatory = true;

            }
            field("Your Reference"; Rec."Your Reference")
            {
                ApplicationArea = all;
            }
        }

        addafter("On Hold")
        {
            field("Posting Description"; wDescr)
            {
                Caption = 'Posting Description';
                ApplicationArea = all;
                trigger OnValidate()
                begin
                    //POSTING_DESC
                    rec."Posting Description" := wDescr;
                    //POSTING_DESC//
                end;
            }
            field("N° Demande d'achat"; Rec."N° Demande d'achat")
            {
                ApplicationArea = all;
            }
            field("Remarque de Livrison"; Rec."Remarque de Livrison")
            {
                ApplicationArea = all;
            }
            /*     field(Engin2; Rec.Engin) 
                 {
                     ApplicationArea = all;
                 }
                 field("Description Engin"; Rec."Description Engin")
                 {
                     ApplicationArea = all;
                 }*/
        }

        addafter("Ship-to Post Code")
        {
            field("Ship-to Job No."; Rec."Ship-to Job No.")
            {
                ApplicationArea = all;
            }
        }


    }

    actions
    {

        addafter(Approvals)
        {
            separator(separator100)
            {
            }
            action("Interaction Log E&ntries")
            {
                Caption = 'Interaction Log E&ntries';
                ApplicationArea = all;
                trigger OnAction()
                begin

                    //+REF+CRM
                    rec.fShowDocumentInteraction(Rec);
                    //+REF+CRM//
                end;
            }
            separator(separator200)
            {
            }
            group("Vendor Offers")
            {
                Caption = 'Vendor Offers';

                action("Proposer offres")
                {
                    ApplicationArea = all;
                    Caption = 'Suggest Offers';

                    trigger OnAction()
                    var
                        lPriceOfferMngt: Codeunit "Price Offer Management";
                    begin

                        //+OFF+OFFRE
                        rec.TESTFIELD("Attached to Doc. No.", '');
                        CLEAR(lPriceOfferMngt);
                        lPriceOfferMngt.SuggestOffer(Rec, FALSE);
                        //+OFF+OFFRE//
                    end;
                }
                /* GL2024    action("Offers List")
                    {
                        ApplicationArea = all;
                        Caption = 'Offers List';
                        //DYS page addon non migrer
                        // RunObject = Page 8004092;
                        // RunPageLink = "Attached to Doc. Type" = FIELD("Document Type"),
                        //               "Attached to Doc. No." = FIELD("No.");
                        // RunPageView = SORTING("Document Type", "No.");
                    }
                    action("Compare Offers")
                    {
                        ApplicationArea = all;
                        Caption = 'Compare Offers';
                        //DYS page addon non migrer
                        // RunObject = Page 8004091;
                        // RunPageLink = "Document Type" = FIELD("Document Type"),
                        //               "Document No." = FIELD("No."),
                        //               Type = FILTER(Item | "G/L Account");
                    }
                    separator(separator102)
                    {
                    }*/
                action("Export Offers to Excel")
                {

                    ApplicationArea = all;
                    Caption = 'Export Offers to Excel';
                    trigger OnAction()
                    var
                        lOfferPurchHeader: Record "Purchase Header";
                    //DYS REPORT addon non migrer
                    // lExportToExcel: Report 8004092;
                    begin

                        //+OFF+OFFRE
                        lOfferPurchHeader.RESET;
                        lOfferPurchHeader.SETCURRENTKEY("Attached to Doc. Type", "Attached to Doc. No.");
                        lOfferPurchHeader.FILTERGROUP(2);
                        lOfferPurchHeader.SETRANGE("Attached to Doc. Type", rec."Document Type");
                        lOfferPurchHeader.SETRANGE("Attached to Doc. No.", rec."No.");
                        lOfferPurchHeader.FILTERGROUP(0);

                        IF lOfferPurchHeader.FIND('-') THEN BEGIN
                            //DYS
                            // CLEAR(lExportToExcel);
                            // lExportToExcel.SETTABLEVIEW(lOfferPurchHeader);
                            // lExportToExcel.RUN;
                        END;
                        //+OFF+OFFRE//
                    end;
                }
                /* GL2024  action("Import Offers from Excel")
                  {

                      ApplicationArea = all;
                      Caption = 'Import Offers from Excel';
                      trigger OnAction()
                      var
                      //DYS REPORT addon non migrer
                      //    lImportToExcel: Report 8004093;
                      begin

                          //+OFF+OFFRE
                          rec.TESTFIELD("No.");
                          // CLEAR(lImportToExcel);
                          // lImportToExcel.InitSourceDoc(rec."No.");
                          // lImportToExcel.RUN;
                          //+OFF+OFFRE//
                      end;
                  }*/
                action("Generated Files List")
                {

                    ApplicationArea = all;
                    Caption = 'Generated Files List';
                    trigger OnAction()
                    var
                        lPriceOfferMngt: Codeunit "Price Offer Management";
                    begin

                        //+OFF+OFFRE
                        lPriceOfferMngt.ShowGenerateFilesList;
                        //+OFF+OFFRE//
                    end;
                }
                separator(separator103)
                {
                }
                /* GL2024  action("Delete Ordered Quotes...")
                   {
                       Caption = 'Delete Ordered Quotes...';
                       ApplicationArea = all;

                       trigger OnAction()
                       var
                       //DYS REPORT addon non migrer
                       // lDeleteOrderedQuote: Report 8004095;
                       begin

                           //+OFF+OFFRE
                           // CLEAR(lDeleteOrderedQuote);
                           // lDeleteOrderedQuote.SETTABLEVIEW(Rec);
                           // lDeleteOrderedQuote.RUNMODAL;
                           CurrPage.UPDATE(FALSE);
                           //+OFF+OFFRE//
                       end;
                   }*/
            }
        }

        modify(Print)
        {
            Visible = false;
        }

        addafter(Print)
        {
            action("&Print2")
            {
                Caption = 'Imprimer';
                Ellipsis = true;
                Image = Print;
                //  Promoted = true;
                // PromotedCategory = Process;
                ApplicationArea = all;
                trigger OnAction()
                begin
                    //GL2024 Code standard comment // DocPrint.PrintPurchHeader(Rec);
                    // >> HJ DSFT 11-10-2012
                    RecPurchaseOrder.SETRANGE("Document Type", rec."Document Type");
                    RecPurchaseOrder.SETRANGE("No.", rec."No.");
                    REPORT.RUNMODAL(REPORT::"Demande offre de prix", TRUE, TRUE, RecPurchaseOrder);
                    // >> HJ DSFT 11-10-2012
                    // STD HJ DSFT 11-10-2012 DocPrint.PrintPurchHeader(Rec);
                end;
            }
            action("&Imprimer Tableau Comparatif")
            {
                Caption = 'Imprimer Tableau Comparatif';
                ApplicationArea = all;
                Image = Print;
                trigger OnAction()
                begin
                    // >> HJ DSFT 11-10-2012
                    RecPurchaseOrder.SETRANGE("Document Type", rec."Document Type");
                    RecPurchaseOrder.SETRANGE("No.", rec."No.");
                    REPORT.RUNMODAL(REPORT::"Tableau Comparatif", TRUE, TRUE, RecPurchaseOrder);
                    // >> HJ DSFT 11-10-2012
                    // STD HJ DSFT 11-10-2012 DocPrint.PrintPurchHeader(Rec);
                end;
            }
            action("Hist Article")
            {
                Caption = 'Hist Article';
                ApplicationArea = all;
                Visible = false;
                trigger OnAction()
                begin
                    // >> HJ DSFT 11-10-2012
                    /*IF Engin = '' THEN ERROR(Text002);
    RecPurchaseOrder.SETRANGE("Document Type", "Document Type");
    RecPurchaseOrder.SETRANGE("No.", "No.");
    REPORT.RUNMODAL(REPORT::Comparatif, TRUE, TRUE, RecPurchaseOrder);*/
                    // >> HJ DSFT 11-10-2012
                    // STD HJ DSFT 11-10-2012 DocPrint.PrintPurchHeader(Rec);
                end;
            }

        }
        addafter(Print_Promoted)
        {
            actionref("&Print21"; "&Print2")
            {

            }
            actionref("&Imprimer Tableau Comparatif1"; "&Imprimer Tableau Comparatif")
            {

            }
        }

        addafter(CalculateInvoiceDiscount)
        {
            group("Create &Interaction")
            {
                Caption = 'Créer &Interaction';
                action("Buy-from")
                {
                    Caption = 'Preneur d''ordre';
                    ApplicationArea = all;
                    trigger OnAction()
                    begin
                        //+REF+CRM
                        rec.fCreateInteraction(rec."Buy-from Vendor No.", rec."No.");
                        //+REF+CRM//
                    end;
                }
                action("Pay-to Vendor")
                {
                    Caption = 'Fournisseur à payer';
                    ApplicationArea = all;
                    trigger OnAction()
                    begin

                        //+REF+CRM
                        rec.fCreateInteraction(rec."Pay-to Vendor No.", rec."No.");
                        //+REF+CRM//
                    end;
                }
            }
        }
        addafter(CalculateInvoiceDiscount_Promoted)
        {
            group("Create &Interaction1")
            {
                Caption = 'Create &Interaction';
                actionref("Buy-from1"; "Buy-from")
                {

                }
                actionref("Pay-to Vendor1"; "Pay-to Vendor")
                {

                }
            }
        }
        addafter(CancelApprovalRequest)
        {
            action("Sales &Document")
            {
                Caption = 'Document Vente';
                ApplicationArea = all;
                trigger OnAction()
                begin

                    //SUBCONTRACTOR
                    CurrPAGE.PurchLines.PAGE.wOpenSalesForm;
                    //SUBCONTRACTOR//
                end;
            }
        }
        addafter(CancelApprovalRequest_Promoted)
        {
            actionref("Sales &Document1"; "Sales &Document")
            {

            }
        }

        addafter("Make Order")
        {
            group("&Line")
            {
                Caption = '&Ligne';
                action(Description)
                {
                    Caption = 'Description';
                    ApplicationArea = all;
                    trigger OnAction()
                    begin

                        //OUVRAGE
                        CurrPAGE.PurchLines.PAGE.wShowDescription;
                        //OUVRAGE//
                    end;
                }
                action("Show Related Offers Lines")
                {
                    Caption = 'Afficher Lignes Offres Associées';
                    ApplicationArea = all;
                    trigger OnAction()
                    begin

                        //+OFF+OFFRE
                        rec.TESTFIELD("Attached to Doc. No.", '');
                        CurrPAGE.PurchLines.PAGE.wShowRelatedOfferLines;
                        //+OFF+OFFRE//
                    end;
                }
            }
        }
        addafter(Category_Process)
        {
            group("Line")
            {
                Caption = 'Line';
                actionref(Description1; Description)
                {

                }
                actionref("Show Related Offers Lines1"; "Show Related Offers Lines")
                {

                }
            }
        }
        modify(MakeOrder)
        {
            trigger OnbeforeAction()
            var
                lOfferSetup: Record "Price Offer Setup";
                lOfferHeader: Record "Purchase Header";
                lBasic: Codeunit Basic;
                Text8004090: label 'You cannot generate orders from a main price request';
                Text8004091: label 'You cannot generate an order from a price offer. Use the Compare offers, Functions, Create order form';
            begin
                //ABZ PurchaseRequest.SETRANGE("No.", rec."N° Demande d'achat");
                PurchaseRequest.get(rec."N° Demande d'achat");
                IF NOT (PurchaseRequest.Statut = PurchaseRequest.Statut::approved) THEN ERROR(Text003);
                //+OFF+OFFRE
                IF rec."Attached to Doc. No." <> '' THEN
                    ERROR(Text8004091);

                //MERGE MB 01/08/06
                //IF lOfferSetup.READPERMISSION THEN BEGIN
                IF lBasic.CheckDataBaseLicense(DATABASE::"Price Offer Setup") THEN BEGIN
                    //MERGE MB 01/08/06
                    lOfferSetup.GET;
                    lOfferHeader.SETCURRENTKEY("Attached to Doc. Type", "Attached to Doc. No.");
                    lOfferHeader.SETRANGE("Attached to Doc. Type", rec."Document Type");
                    lOfferHeader.SETRANGE("Attached to Doc. No.", rec."No.");
                    IF (lOfferHeader.FIND('-')) OR
                    (rec."Buy-from Vendor No." = lOfferSetup."Default Quote Vendor")
                    THEN
                        ERROR(Text8004090);
                END;
            end;
        }

        addafter(Approvals_Promoted)
        {
            actionref("Interaction Log E&ntries1"; "Interaction Log E&ntries")
            {

            }
            group("Vendor Offers1")
            {
                Caption = 'Vendor Offers';
                actionref("Proposer offres1"; "Proposer offres")
                {

                }
                actionref("Export Offers to Excel1"; "Export Offers to Excel")
                {

                }
                actionref("Generated Files List1"; "Generated Files List")
                {

                }

            }
        }

    }





    trigger OnModifyRecord(): Boolean
    begin
        //ACHATS
        // IF (rec."Buy-from Vendor No." <> xRec."Buy-from Vendor No.") OR (rec."Order Address Code" <> xRec."Order Address Code") THEN
        //DYS fonction commenté dans CDu PurchInfoPaneMgmt
        //   PurchInfoPaneMgmt.gGetAddress(Rec, gAddress);
        //ACHATS//
    end;

    trigger OnAfterGetRecord()
    begin


        rec.SETRANGE("Document Type");
        //OFFRE_DE_PRIX
        IF rec."Attached to Doc. No." <> '' THEN
            Currpage.PurchLines.page.wSetRelatedOffer(TRUE);
        //OFFRE_DE_PRIX//
        //POSTING_DESC
        wDescr := rec.wShowPostingDescription(rec."Posting Description");
        //POSTING_DESC//
        //ACHATS
        //DYS fonction commenté dans CDu PurchInfoPaneMgmt
        //PurchInfoPaneMgmt.gGetAddress(Rec, gAddress);
        //ACHATS//
    end;

    trigger OnOpenPage()
    begin

        //+OFF+OFFRE
        //IF GETFILTER("Attached to Doc. No.") = '' THEN
        //  SETRANGE("Attached to Doc. No.",'');
        //+OFF+OFFRE//
    end;

    var
        RecPurchaseOrder: Record "Purchase Header";
        PurchInfoPaneMgmt: Codeunit "Purchases Info-Pane Management";
        SalesHeader: Record "Sales Header";
        "PurchaseRequest": Record "Purchase Request";
        SalesLine: Record "Sales Line";
        PurchaseLigne: Record "Purchase Line";
        Text8004090: Label 'You can not create order from a lead quote.';
        Text8004091: Label 'You can not generate an order from a price offer.\Use the form Compare Offers, Functions, Make order.';
        Text001: Label 'Do you want to confirm the retrieval of the items from this purchase request?';
        wDescr: Text[100];
        gAddress: Record "Order Address";
        Text002: Label 'FRA=Aucun Engin Associé a Ce Devis';
        Text003: Label 'DA Doit Etre Approber Avant De Créer Commande';
}
