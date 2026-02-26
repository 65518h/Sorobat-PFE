page 50296 "Reception Non Stockable"
{
    Caption = 'Reception Non Stockablet';
    SourceTable = "Purchase Header";
    // SourceTableView = WHERE("Document Type" = FILTER(Order), Contrat = CONST(true));
    SourceTableView = WHERE("Document Type" = FILTER(Order));
    ApplicationArea = all;
    PageType = Card;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            group("Shipping")
            {
                Caption = 'Shipping';
                label("ATTENTION SORTIE STOCK AUTOMATIQUE")
                {
                    Caption = '.............ATTENTION SORTIE STOCK AUTOMATIQUE...............';
                    Style = Unfavorable;
                }
                field("N° commande"; REC."No.")
                {
                    Caption = 'Order No.';
                }
                field("Nom du destinataire"; REC."Ship-to Name")
                {
                    Caption = 'Nom du destinataire';
                }
                field("Adresse destinataire"; REC."Ship-to Address")
                {
                    Caption = 'Adresse destinataire';
                }
                field("Date comptabilisation"; REC."Posting Date")
                {
                    Caption = 'Date comptabilisation';
                }
                field("Date document"; REC."Document Date")
                {
                    Caption = 'Date document';
                }
                field("N° B.L. fournisseur"; REC."Vendor Shipment No.")
                {
                    Caption = 'N° B.L. fournisseur';
                }
            }
            group("Général")
            {
                Caption = 'General';
                field("N° preneur d'ordre"; REC."Buy-from Vendor No.")
                {
                    Caption = 'N° preneur d''ordre';

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;
                    end;
                }
                field("N° contact preneur d'ordre"; REC."Buy-from Contact No.")
                {
                    Caption = 'N° preneur d''ordre';
                }
                field("Nom du fournisseur"; REC."Buy-from Vendor Name")
                {
                }
                field("Adresse fournisseur"; REC."Buy-from Address")
                {
                }
                field("Adresse fournisseur 2"; REC."Buy-from Address 2")
                {
                }
                field("Ville fournisseur"; REC."Buy-from City")
                {
                }
                field("Code postal fournisseur"; REC."Buy-from Post Code")
                {
                }
                field("Contact fournisseur"; REC."Buy-from Contact")
                {
                }
                field("Date commande"; REC."Order Date")
                {
                }
                field("N° commande fournisseur"; REC."Vendor Order No.")
                {
                }
                field("Responsibility Center"; REC."Responsibility Center")
                {
                }
                field("N° affaire"; REC."Job No.")
                {
                    Caption = 'Job No.';
                }
                field("Type document"; REC."Document Type")
                {
                }
                // part("Purchase Receipt Subform"; "Ligne Reception Non Stockable")
                // {
                //     Caption = 'Purchase Receipt Subform';
                //     SubPageLink = "Document No." = FIELD("No.");
                // }
                //DYS page addon non migrer
                // part("Purchase Receipt Subform";8003959)
                // {
                //     Caption = 'Purchase Receipt Subform';
                //     SubPageLink = Document No.=FIELD(No.);
                // }
            }
        }
    }

    actions
    {
        area(Promoted)
        {
            group("Commande1")
            {
                Caption = 'O&rder';
                actionref(Commentaires1; Commentaires) { }
                actionref(Fiche1; Fiche) { }
                actionref("Co&mmentaires1"; "Co&mmentaires") { }
                actionref("Bons de réception1"; "Bons de réception") { }
                actionref("Commande Origine1"; "Commande Origine") { }
            }

            group("Fonction&s1")
            {
                Caption = 'F&unctions';
                actionref("Clô&turer la commande1"; "Clô&turer la commande") { }
                actionref("PV Reception1"; "PV Reception") { }
            }

            group(Validation1)
            {
                Caption = 'P&osting';
                actionref("Valider réception1"; "Valider réception") { }
            }
        }
        area(creation)
        {
            group("Commande")
            {
                Caption = 'O&rder';
                action(Commentaires)
                {
                    Caption = 'Comment';
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"), "No." = FIELD("No.");
                }
                /*GL2024  action(Lister)
                  {
                      Caption = 'List';
                      ShortCutKey = 'F5';
                  }
                  action(Statistiques)
                  {
                      Caption = 'Statistics';
                      ShortCutKey = 'F9';
                  }*/
                action(Fiche)
                {
                    Caption = 'Card';
                    RunObject = Page "Vendor Card";
                    RunPageLink = "No." = FIELD("Buy-from Vendor No.");
                    ShortCutKey = 'Maj+F5';
                }
                action("Co&mmentaires")
                {
                    Caption = 'Co&mments';
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"), "No." = FIELD("No.");
                }
                action("Bons de réception")
                {
                    Caption = 'Receipts';
                    RunObject = Page "Posted Purchase Receipts";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                }
                /*GL2024   action(Description)
                   {
                       Caption = 'Description';
                   }*/
                action("Commande Origine")
                {
                    Caption = 'Commande Origine';
                    RunObject = Page "Purchase Order";
                    RunPageLink = "Document Type" = FIELD("Document Type"), "No." = FIELD("No.");
                }
            }
            group("<Fonction&s>")
            {
                Caption = 'F&unctions';
                action("Clô&turer la commande")
                {
                    Caption = 'Delete Order';

                    trigger OnAction()
                    var
                        lPurchHeader: Record "Purchase Header";
                        lDeleteInvOrder: Report "Delete Invoiced Purch. Orders";
                    begin
                        //ACHAT
                        lPurchHeader.COPY(Rec);
                        lPurchHeader.SETRECFILTER;
                        lDeleteInvOrder.SETTABLEVIEW(lPurchHeader);
                        lDeleteInvOrder.USEREQUESTPAGE(TRUE);
                        lDeleteInvOrder.RUN;
                        CurrPage.UPDATE;
                        //ACHAT//
                    end;
                }
                /*GL2024   action("So&lder la commande")
                   {
                       Caption = 'Close Order';

                       trigger OnAction()
                       begin
                           //+REF+SOLDE_CDE
                           //GL2024
                           //Currpage.PurchLines.page.wCompletelyReceived;
                           //+REF+SOLDE_CDE//
                       end;
                   }*/
                action("PV Reception")
                {
                    Caption = 'PV Reception';
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    var
                        RecLPvReception: Record "PV Reception";
                        IntNumSequence: Integer;
                    begin
                        // >> HJ DSFT 25-04-2012
                        REC.TESTFIELD("Vendor Shipment No.");
                        //GL2024
                        //IntNumSequence:= CurrPAGE.PurchLines.PAGE.InsertPVReception;
                        REC."N° Sequence" := IntNumSequence;
                        REC.MODIFY;
                        RecLPvReception.SETRANGE("N° Sequence", IntNumSequence);
                        IF RecLPvReception.FINDFIRST THEN PAGE.RUN(PAGE::"PV Reception", RecLPvReception);
                        // >> HJ DSFT 25-04-2012
                    end;
                }
            }
            group(Validation)
            {
                Caption = 'P&osting';
                action("Valider réception")
                {
                    Caption = 'Post Receipt';
                    ShortCutKey = 'F11';

                    trigger OnAction()
                    var
                        RecLPurchaseLine: Record "Purchase Line";
                    begin
                        // >> HJ SORO 12-05-2015
                        IF NOT CONFIRM(Text001) THEN EXIT;
                        REC.TESTFIELD("Vendor Shipment No.");
                        ItemJournalLine.LOCKTABLE;
                        ItemJournalLine.SETRANGE("Journal Template Name", 'SYNCHRO');
                        ItemJournalLine.SETRANGE("Journal Batch Name", 'SYNCHRO');
                        ItemJournalLine.DELETEALL;
                        PurchaseLine.SETRANGE("Document Type", REC."Document Type");
                        PurchaseLine.SETRANGE("Document No.", REC."No.");
                        PurchaseLine.SETRANGE(Type, PurchaseLine.Type::Item);
                        PurchaseLine.SETFILTER("Qty. to Receive", '<>%1', 0);
                        IF PurchaseLine.FINDFIRST THEN
                            REPEAT
                                Ligne += 10000;
                                IF PurchaseLine."Qty. to Receive" <> 0 THEN BEGIN
                                    PurchaseLine.TESTFIELD("Job No.");
                                    PurchaseLine.TESTFIELD("Affectation Marche");
                                    PurchaseLine.TESTFIELD("Sous Affectation Marche");
                                    /*  PurchaseLine.TESTFIELD(Provenance);
                                      PurchaseLine.TESTFIELD(Destination);
                                      PurchaseLine.TESTFIELD(Heure);
                                      PurchaseLine.TESTFIELD(Chauffeur);
                                      PurchaseLine.TESTFIELD(Vehicule);*/
                                END;
                                ItemJournalLine."Journal Template Name" := 'SYNCHRO';
                                ItemJournalLine."Journal Batch Name" := 'SYNCHRO';
                                ItemJournalLine."Line No." := Ligne;
                                ItemJournalLine."Document No." := COPYSTR('SORTIE BL:' + REC."Vendor Shipment No.", 1, 20);
                                ItemJournalLine.VALIDATE("Item No.", PurchaseLine."No.");
                                ItemJournalLine."Posting Date" := REC."Posting Date";
                                ItemJournalLine."Entry Type" := ItemJournalLine."Entry Type"::"Negative Adjmt.";
                                ItemJournalLine.VALIDATE("Location Code", PurchaseLine."Location Code");
                                ItemJournalLine.VALIDATE(Quantity, PurchaseLine."Qty. to Receive");
                                //  ItemJournalLine."Lieu De Livraison / Provenance" := PurchaseLine."Job No.";
                                ItemJournalLine.Marche := PurchaseLine."Job No.";
                                ItemJournalLine."Job No." := PurchaseLine."Job No.";
                                ItemJournalLine."Sous Affectation Marche" := PurchaseLine."Sous Affectation Marche";
                                ItemJournalLine."External Document No." := REC."Vendor Shipment No.";
                                ItemJournalLine."Affectation Marche" := PurchaseLine."Affectation Marche";
                                ItemJournalLine."Qty. per Unit of Measure" := PurchaseLine."Qty. per Unit of Measure";
                                ItemJournalLine.INSERT;
                                // Partie Rendement Camion
                                EnteteRendemenVehEnr.Journee := REC."Posting Date";
                                EnteteRendemenVehEnr.Provenance := PurchaseLine.Provenance;
                                EnteteRendemenVehEnr.Destination := PurchaseLine.Destination;
                                EnteteRendemenVehEnr.Vehicule := PurchaseLine.Vehicule;
                                EnteteRendemenVehEnr.Produit := PurchaseLine."No.";
                                EnteteRendemenVehEnr.Marche := PurchaseLine."Job No.";
                                EnteteRendemenVehEnr.Chauffeur := PurchaseLine.Chauffeur;
                                EnteteRendemenVehEnr.Volume := PurchaseLine.Volume;
                                EnteteRendemenVehEnr."Distance Parcourus" := PurchaseLine."Distance Parcourus";
                                EnteteRendemenVehEnr."Durée Theorique (Minute)" := PurchaseLine."Durée Theorique (Minute)";
                                IF EnteteRendemenVehEnr.INSERT THEN;

                            /*   LigneRendVehiculeEnr.Journee := REC."Posting Date";
                               LigneRendVehiculeEnr."Code Affaire" := PurchaseLine."Job No.";
                               LigneRendVehiculeEnr.Heure := PurchaseLine.Heure;
                               LigneRendVehiculeEnr.Provenance := PurchaseLine.Provenance;
                               LigneRendVehiculeEnr.Destination := PurchaseLine.Destination;
                               LigneRendVehiculeEnr.Vehicule := PurchaseLine.Vehicule;
                               LigneRendVehiculeEnr.Produit := PurchaseLine."No.";
                               LigneRendVehiculeEnr.Chauffeur := PurchaseLine.Chauffeur;
                               LigneRendVehiculeEnr."Distance Parcourus" := PurchaseLine."Distance Parcourus";
                               LigneRendVehiculeEnr.Volume := PurchaseLine.Volume;
                               LigneRendVehiculeEnr."Durée Theorique (Minute)" := PurchaseLine."Durée Theorique (Minute)";
                               LigneRendVehiculeEnr.Heure := PurchaseLine.Heure;
                               LigneRendVehiculeEnr2.SETCURRENTKEY(Heure);
                               LigneRendVehiculeEnr2.SETRANGE(Journee, REC."Posting Date");
                               LigneRendVehiculeEnr2.SETRANGE(Provenance, PurchaseLine.Provenance);
                               LigneRendVehiculeEnr2.SETRANGE(Destination, PurchaseLine.Destination);
                               LigneRendVehiculeEnr2.SETRANGE(Produit, PurchaseLine."No.");
                               LigneRendVehiculeEnr2.SETRANGE(Vehicule, PurchaseLine.Vehicule);
                               IF LigneRendVehiculeEnr2.FINDLAST THEN
                                   LigneRendVehiculeEnr."Ecart (Minute)" := ((PurchaseLine.Heure - LigneRendVehiculeEnr2.Heure) / 60000) -
                                                                             PurchaseLine."Durée Theorique (Minute)";
                               LigneRendVehiculeEnr.INSERT;

                           // Partie Rendment Camion*/
                            UNTIL PurchaseLine.NEXT = 0;

                        RecLPurchaseLine.SETRANGE("Document Type", REC."Document Type");
                        RecLPurchaseLine.SETRANGE("Document No.", REC."No.");
                        IF RecLPurchaseLine.FINDFIRST THEN
                            REPEAT
                                RecLPurchaseLine.Synchronise := FALSE;
                                RecLPurchaseLine."Requested Receipt Date" := WORKDATE;
                                RecLPurchaseLine.Status := RecLPurchaseLine.Status::Released;
                                RecLPurchaseLine.MODIFY;
                            UNTIL RecLPurchaseLine.NEXT = 0;
                        // >> HJ SORO 12-05-2015



                        //FACTURATION_ACHAT
                        PurchSetup.GET;
                        //GL2024
                        /*IF PurchSetup."Calc. Inv. Discount" THEN BEGIN
                        
                          CurrPAGE.PurchLines.PAGE.CalcInvDisc;
                          COMMIT;
                        END;   */
                        //??TESTFIELD(Status,Status::Released);

                        // >> HJ DSFT 20-06-2012
                        //GL2024
                        //CurrPAGE.PurchLines.PAGE.InsertPVReception;
                        // >> HJ DSFT 20-06-2012

                        wPurchPost.InitRequest(FALSE, TRUE);
                        wPurchPost.RUN(Rec);
                        //FACTURATION_ACHAT//
                        // >> HJ DSFT 03-10-2012

                        RecLPurchaseLine.SETRANGE("Document Type", REC."Document Type");
                        RecLPurchaseLine.SETRANGE("Document No.", REC."No.");
                        IF RecLPurchaseLine.FINDFIRST THEN
                            REPEAT
                                RecLPurchaseLine."PV Generer" := FALSE;
                                RecLPurchaseLine.Synchronise := FALSE;
                                RecLPurchaseLine."Sequence PV" := 0;
                                RecLPurchaseLine.VALIDATE("Qty. to Receive", 0);
                                RecLPurchaseLine.MODIFY;
                            UNTIL RecLPurchaseLine.NEXT = 0;
                        ItemJrlLine2.SETRANGE("Journal Template Name", 'SYNCHRO');
                        ItemJrlLine2.SETRANGE("Journal Batch Name", 'SYNCHRO');
                        IF ItemJrlLine2.FINDFIRST THEN BEGIN
                            ItemJournalLine.SETRANGE("Journal Template Name", 'SYNCHRO');
                            ItemJournalLine.SETRANGE("Journal Batch Name", 'SYNCHRO');
                            ///ItemJnlPost.RUN(ItemJournalLine);
                            CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post 2", ItemJournalLine);
                        END;

                        // >> HJ DSFT 03-10-2012

                    end;
                }

            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        REC.SETRANGE("Document Type");
        //POSTING_DESC
        wDescr := REC.wShowPostingDescription(REC."Posting Description");
        //POSTING_DESC//
        //ACHATS
        wUpdateTelFax;
        //ACHATS//
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.UPDATE(TRUE);
        EXIT(REC.ConfirmDeletion);
    end;

    trigger OnFindRecord(Which: Text): Boolean
    begin
        IF REC.FIND(Which) THEN
            EXIT(TRUE)
        ELSE BEGIN
            REC.SETRANGE("No.");
            EXIT(REC.FIND(Which));
        END;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        //ACHATS
        IF (REC."Buy-from Vendor No." <> xRec."Buy-from Vendor No.") OR (REC."Order Address Code" <> xRec."Order Address Code") THEN
            wUpdateTelFax;
        //ACHATS//
    end;

    trigger OnOpenPage()
    begin
        /*IF UserMgt.GetPurchasesFilter() <> '' THEN BEGIN
          FILTERGROUP(2);
          SETRANGE("Responsibility Center",UserMgt.GetPurchasesFilter());
          FILTERGROUP(0);
        END;*/
        IF UserMgt.GetPurchasesFilter() <> '' THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Responsibility Center", UserMgt.GetPurchasesFilter());
            Rec.FILTERGROUP(0);
        END;

    end;

    var
        PurchSetup: Record "Purchases & Payables Setup";
        ChangeExchangeRate: Page "Change Exchange Rate";
        CopyPurchDoc: Report "Copy Purchase Document";
        MoveNegPurchLines: Report "Move Negative Purchase Lines";
        ReportPrint: Codeunit "Test Report-Print";
        DocPrint: Codeunit "Document-Print";
        UserMgt: Codeunit "User Setup Management";
        ArchiveManagement: Codeunit ArchiveManagement;
        wPurchPost: Codeunit "Purch. Order - Post";
        wDescr: Text[100];
        wNoTel: Text[30];
        wFaxNo: Text[30];
        ItemJournalLine: Record "Item Journal Line";
        ItemJrlLine2: Record "Item Journal Line";
        PurchaseLine: Record "Purchase Line";
        Ligne: Integer;
        "//HJ SORO": Integer;
        EnteteRendemenVehEnr: Record "Entete rendement Vehicule Enr";
        LigneRendVehiculeEnr: Record "Ligne Rendement Vehicule Enr";
        LigneRendVehiculeEnr2: Record "Ligne Rendement Vehicule Enr";
        Text001: Label 'Attention Cette Feuille Génére Une Sortie De Stock, Voulez Quand Meme Continuer ?';


    procedure wUpdateTelFax()
    var
        lVendor: Record Vendor;
        lDest: Record "Order Address";
        lCont: Record Contact;
    begin
        //ACHATS
        wNoTel := '';
        wFaxNo := '';
        IF REC."Order Address Code" = '' THEN BEGIN
            IF REC."Buy-from Contact No." <> '' THEN
                IF lCont.GET(REC."Buy-from Contact No.") THEN BEGIN
                    wNoTel := lCont."Phone No.";
                    wFaxNo := lCont."Fax No.";
                END;
            IF lVendor.GET(REC."Buy-from Vendor No.") THEN BEGIN
                IF wNoTel = '' THEN
                    wNoTel := lVendor."Phone No.";
                IF wFaxNo = '' THEN
                    wFaxNo := lVendor."Fax No.";
            END;
        END ELSE BEGIN
            IF lDest.GET(REC."Buy-from Vendor No.", REC."Order Address Code") THEN BEGIN
                wNoTel := lDest."Phone No.";
                wFaxNo := lDest."Fax No.";
            END;
            IF wNoTel = '' THEN BEGIN
                IF REC."Buy-from Contact No." <> '' THEN
                    IF lCont.GET(REC."Buy-from Contact No.") THEN
                        wNoTel := lCont."Phone No.";
                IF wNoTel = '' THEN
                    IF lVendor.GET(REC."Buy-from Vendor No.") THEN
                        wNoTel := lVendor."Phone No.";
            END;
            IF wFaxNo = '' THEN BEGIN
                IF REC."Buy-from Contact No." <> '' THEN
                    IF lCont.GET(REC."Buy-from Contact No.") THEN
                        wFaxNo := lCont."Fax No.";
                IF wFaxNo = '' THEN
                    IF lVendor.GET(REC."Buy-from Vendor No.") THEN
                        wFaxNo := lVendor."Fax No.";
            END;
        END;
        //ACHATS//
    end;


    procedure "//HJ DSFT"()
    begin
    end;


    procedure InsertPvReception()
    begin
        // >> HJ DSFT 25-04-2012
        //GL2024
        //Currpage.PurchLines.page.InsertPVReception;
        // >> HJ DSFT 25-04-2012
    end;


    procedure Sortie()
    var
        ItemJournalLine: Record "Item Journal Line";
        ItemJrlLine2: Record "Item Journal Line";
        PurchaseLine: Record "Purchase Line";
        Ligne: Integer;
    begin
        ItemJournalLine.SETRANGE("Journal Template Name", 'SYNCHRO');
        ItemJournalLine.SETRANGE("Journal Batch Name", 'SYNCHRO');
        ItemJournalLine.DELETEALL;

        PurchaseLine.SETRANGE("Document Type", REC."Document Type");
        PurchaseLine.SETRANGE("Document No.", REC."No.");
        PurchaseLine.SETRANGE(Type, PurchaseLine.Type::Item);
        PurchaseLine.SETFILTER("Qty. to Receive", '<>%1', 0);
        IF PurchaseLine.FINDFIRST THEN
            REPEAT
                Ligne += 10000;
                ItemJournalLine."Journal Template Name" := 'SYNCHRO';
                ItemJournalLine."Journal Batch Name" := 'SYNCHRO';
                ItemJournalLine."Line No." := Ligne;
                ItemJournalLine."Document No." := 'SORTIE-' + FORMAT(TODAY);
                ItemJournalLine.VALIDATE("Item No.", PurchaseLine."No.");
                ItemJournalLine."Posting Date" := REC."Posting Date";
                ItemJournalLine."Entry Type" := ItemJournalLine."Entry Type"::"Negative Adjmt.";
                ItemJournalLine.VALIDATE("Location Code", PurchaseLine."Location Code");
                ItemJournalLine.VALIDATE(Quantity, PurchaseLine."Qty. to Receive");
                // ItemJournalLine."Lieu De Livraison / Provenance" := PurchaseLine."Job No.";
                ItemJournalLine.Marche := PurchaseLine."Job No.";
                ItemJournalLine."Job No." := PurchaseLine."Job No.";
                ItemJournalLine."Sous Affectation Marche" := PurchaseLine."Sous Affectation Marche";
                ItemJournalLine."Affectation Marche" := PurchaseLine."Affectation Marche";
                ItemJournalLine."Qty. per Unit of Measure" := PurchaseLine."Qty. per Unit of Measure";
                ItemJournalLine."Filtre Article" := PurchaseLine."Sous Affectation Marche";
                ItemJournalLine.INSERT;
            UNTIL PurchaseLine.NEXT = 0;

        ItemJrlLine2.SETRANGE("Journal Template Name", 'SYNCHRO');
        ItemJrlLine2.SETRANGE("Journal Batch Name", 'SYNCHRO');
        IF ItemJrlLine2.FINDFIRST THEN BEGIN
            ItemJournalLine.SETRANGE("Journal Template Name", 'SYNCHRO');
            ItemJournalLine.SETRANGE("Journal Batch Name", 'SYNCHRO');
            ///ItemJnlPost.RUN(ItemJournalLine);
            CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post 2", ItemJournalLine);
        END;
    end;
}

