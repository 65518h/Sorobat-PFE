page 50113 "Commande Affaire"
{
    // TRS-2009 XPE 02/10/09
    // //PLANNING_TASK CW 26/08/09 MenuButton Order +Planning Tasks
    // //#5535 Ajout
    // //+REF+INVOICE CW CW 31/07/07 #4864
    // //+ONE+PREPAYMENT CW 03/09/07 
    // //ACHAT CW 09/07/07 +Functions, DropShipment, GenerateDropShimment 
    // //QUOTE_FOOTER MB 26/03/07 Ajout de la fonction "pied de devis"
    // //PROJET GESWAY 01/11/01 Ajout Job No.
    //                 10/12/01 NextControl : Date document > N° projet > Lignes
    // //PROJET_PHASE GESWAY 01/10/02 Ajout N° avenant
    // //OUVRAGE GESWAY 20/03/03 Ajout "Copier un ouvrage" sur bouton Fonctions
    // //REVISION GESWAY 04/04/03 Ajout Onglet Révision + nouveaux champs
    // //DEVIS GESWAY 09/05/03 Ajout de Caractéristiques dans le bouton Devis
    //                15/01/04 Ajout AssistEdit sur "Sell-to Cust. Name","Ship-to Name","Bill-to Name"
    //                         Appel formulaire "Contact et Adresses" depuis ces champs
    // //PROJET_FACT GESWAY 04/03/03 Appel formulaire de saisie de l'avancement, échéancier dans le bouton commande
    //                      26/04/03 Imprimer mis dans le bouton Validation
    //                      02/11/04 Ajout DataItemView : 'Soldé' à non
    // //POSTING_DESC GESWAY 12/06/03 gestion "Posting Description" paramétrable
    // //SUBCONTRACTOR GESWAY 04/07/03 Ajout fonction générer sous-traitance + Mise à jour coût
    // //REPORT_SELECTED 16/01/04 Gestion de séléction des états Bouton Commande
    // //URL CW 27/01/04 Appel Lignes, Pièces jointes
    // //PROJET_ACTION GESWAY 27/02/04 Appel liste interactions du document depuis bouton Commande
    // //CRM GESWAY 09/03/04 Ajout Interactions sur bouton Commande
    // //ACOMPTE CLA 29/07/04 Ajout Acompte
    // //CAUTION AC 05/01/05 Ajout Menu Item caution dans le menu commande
    // //PRESENTATION MB 26/10/06 Ajout des bouton monter et descendre dans le menu ligne
    // //MASK IMA 02/01/06 MaskFilter
    // //CDE_CESSION MB 08/11/06 Ajout du menu "commande cession" dans le bouton fonction
    // //+ABO+ GESWAY 15/07/02 Ajout "Subscription Starting Date","Subscription End Date" sur onglet Facturation
    // //+WKF+ CW 04/08/02 +Workflow Button
    // //+REF+ADDTEXT DL 23/09/05 Ajout boutons complémentaires (commentaires en-tête et pied doc.)
    //                            Modif Filtre Type = '' sur bouton Comment
    // //+REF+POST_DESC GESWAY 10/02/03 Ajout du champ "Posting Description" -> Onglet Facturation
    // //+REF+FOLDER    CW     19/02/04 Ajout Dossier
    // //+REF+REPORT_LIST MB 29/06/06 Ajout du menu Etats dans le bouton commande

    Caption = 'Commande Affaire';
    PageType = Card;
    RefreshOnActivate = true;
    SaveValues = true;
    SourceTable = "Sales Header";
    //SourceTableView = SORTING("Order Type", "Document Type", "No.", "Invoicing Method", Finished) WHERE("Document Type" = CONST(Order), "Order Type" = FILTER(' '), "Commande Affaire" = FILTER(true), Cloturer = CONST(false));
    SourceTableView = SORTING("Order Type", "Document Type", "No.", "Invoicing Method", Finished) WHERE("Document Type" = CONST(Order), "Order Type" = FILTER(' '), "Commande Affaire" = FILTER(true));



    // HS ApplicationArea = all;
    // HS UsageCategory = Administration;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'Général';
                field("No."; rec."No.")
                {
                    ApplicationArea = all;

                    trigger OnAssistEdit()
                    begin
                        IF REC.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Sell-to Customer No."; rec."Sell-to Customer No.")
                {
                    ApplicationArea = all;
                    Caption = 'N° Client';
                    Editable = "Sell-to Customer No.Editable";

                    trigger OnValidate()
                    begin
                        SelltoCustomerNoOnAfterValidat;
                    end;
                }
                field("Sell-to Customer Name"; rec."Sell-to Customer Name")
                {
                    ApplicationArea = all;
                    AssistEdit = true;
                    Editable = "Sell-to Customer NameEditable";

                    /* GL2024  trigger OnAssistEdit()
                      begin
                          CurrPage.SAVERECORD;
                          COMMIT;
                          CLEAR(AddressContributors);
                          AddressContributors.InitRequest(1);
                          AddressContributors.SETTABLEVIEW(Rec);
                          AddressContributors.SETRECORD(Rec);
                          AddressContributors.RUNMODAL;
                          //AddressContributors.GETRECORD(Rec);
                          CurrPage.UPDATE;
                      end;*/
                }

                field("Job No."; rec."Job No.")
                {
                    ApplicationArea = all;
                    Caption = 'Centrale';
                    Editable = "Job No.Editable";
                }
                field("External Document No."; rec."External Document No.")
                {
                    ApplicationArea = all;
                    Caption = 'N° BL';
                }
                // field("Date Ordre Service"; rec."Date Ordre Service")
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                //     Style = Strong;
                //     StyleExpr = TRUE;
                // }
                // field("Nbre Mois Marché"; rec."Nbre Mois Marché")
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                //     Style = Strong;
                //     StyleExpr = TRUE;
                // }
                // field("Date Fin de Travaux"; rec."Date Fin de Travaux")
                // {
                //     ApplicationArea = all;
                //     Style = Strong;
                //     StyleExpr = TRUE;
                // }
                // field("Delai Suspension"; rec."Delai Suspension")
                // {
                //     ApplicationArea = all;
                //     Style = Strong;
                //     StyleExpr = TRUE;
                // }
                field("Assigned User ID"; rec."Assigned User ID")
                {
                    ApplicationArea = all;
                }
                // field("Date Debut Decompte"; rec."Date Debut Decompte")
                // {
                //     ApplicationArea = all;
                //     Style = Unfavorable;
                //     StyleExpr = TRUE;
                // }
                // field("Date Fin Decompte"; rec."Date Fin Decompte")
                // {
                //     ApplicationArea = all;
                //     Style = Unfavorable;
                //     StyleExpr = TRUE;
                // }
            }
            part(SalesLines; "Detail Marché")
            {
                Editable = ModifierDétailMarché;
                ApplicationArea = all;
                Caption = 'Détail Marché';
                SubPageLink = "Document No." = FIELD("No.");
                SubPageView = SORTING("Order Type", "Document Type", "Document No.", "Presentation Code", "Structure Line No.", "Job No.");
            }
            field(Presentation; PresentationCode)
            {
                ApplicationArea = all;
                Caption = 'Presentation Code';
                TableRelation = "Sales Line View";


                trigger OnValidate()
                begin
                    PresentationCodeOnAfterValidat;
                end;
            }
            field("Posting Date"; rec."Posting Date")
            {
                ApplicationArea = all;
            }
            field("Document Date"; rec."Document Date")
            {
                ApplicationArea = all;
                trigger OnValidate()
                begin
                    rec.VALIDATE("Shipment Date", 0D);
                end;
            }
            field("Order Date"; rec."Order Date")
            {
                ApplicationArea = all;
                Caption = 'Date Fin Prevue';
                Editable = true;
                Style = Strong;
                StyleExpr = TRUE;
            }
            field("Quote No."; rec."Quote No.")
            {
                ApplicationArea = all;
            }
            field("Opportunity No."; Rec."Opportunity No.")
            {
                ApplicationArea = all;
            }

            // field("Commande Interne"; rec."Commande Interne")
            // {
            //     ApplicationArea = all;
            //     Editable = false;
            // }
            field("Last Shipping No."; rec."Last Shipping No.")
            {
                ApplicationArea = all;
                Caption = 'N° Expédition';
            }

            /* GL2024   group(CustInfoPanel)
                {
                    Caption = 'Customer Information';
                    label()
                    {
                        CaptionClass = Text19070588;
                    }
                    field(STRSUBSTNO('(%1)',SalesInfoPaneMgt.CalcNoOfContacts(Rec));STRSUBSTNO('(%1)',SalesInfoPaneMgt.CalcNoOfContacts(Rec)))
                    {
                        Editable = false;
                    }
                    label()
                    {
                        CaptionClass = Text19069283;
                    }
                    field(SalesInfoPaneMgt.CalcAvailableCredit("Bill-to Customer No.");SalesInfoPaneMgt.CalcAvailableCredit("Bill-to Customer No."))
                    {
                        DecimalPlaces = 0:0;
                        Editable = false;
                    }
                }*/
            group(Job)
            {
                Caption = 'Affaire';
                field("Ship-to Code"; REC."Ship-to Code")
                {
                    ApplicationArea = all;
                    Editable = "Ship-to CodeEditable";
                }
                field("Ship-to Name"; REC."Ship-to Name")
                {
                    ApplicationArea = all;
                    AssistEdit = true;
                    Editable = "Ship-to NameEditable";

                    /* GL2024 trigger OnAssistEdit()
                      begin
                          CurrPage.SAVERECORD;
                          COMMIT;
                          CLEAR(AddressContributors);
                          AddressContributors.InitRequest(2);
                          AddressContributors.SETTABLEVIEW(Rec);
                          AddressContributors.SETRECORD(Rec);
                          AddressContributors.RUNMODAL;
                          //AddressContributors.GETRECORD(Rec);
                          CurrPage.UPDATE;
                      end;*/
                }
                field("Job Description"; REC."Job Description")
                {
                    ApplicationArea = all;
                    Editable = "Job DescriptionEditable";
                    caption = 'Désignation affaire';
                }
                field("Project Manager"; REC."Project Manager")
                {
                    ApplicationArea = all;
                    Editable = "Project ManagerEditable";
                    caption = 'Maître d''oeuvre';

                    trigger OnValidate()
                    begin
                        ProjectManagerOnAfterValidate;
                    end;
                }
                field(ProjectManagerName; ProjectManagerName)
                {
                    ApplicationArea = all;
                    AssistEdit = true;
                    Caption = 'Nom du maître d''oeuvre';
                    Editable = false;

                    /*GL2024    trigger OnAssistEdit()
                        begin
                            CLEAR(AddressContributors);
                            AddressContributors.InitRequest(4);
                            AddressContributors.SETTABLEVIEW(Rec);
                            AddressContributors.SETRECORD(Rec);
                            AddressContributors.RUNMODAL;
                            //AddressContributors.GETRECORD(Rec);
                            CurrPage.UPDATE;
                        end;*/
                }
                field("Job No.1"; REC."Job No.")
                {
                    ApplicationArea = all;
                }
                field("Job Starting Date"; REC."Job Starting Date")
                {
                    ApplicationArea = all;
                    Editable = "Job Starting DateEditable";
                    Caption = 'Date début Affaire';
                }
                field("Job Ending Date"; REC."Job Ending Date")
                {
                    ApplicationArea = all;
                    Editable = "Job Ending DateEditable";
                    Caption = 'Date fin Affaire';
                }
                field("Shipment Date"; REC."Shipment Date")
                {
                    ApplicationArea = all;
                }
                field("Salesperson Code"; REC."Salesperson Code")
                {
                    ApplicationArea = all;
                }
                field(ContactName; ContactName)
                {
                    ApplicationArea = all;
                    Caption = 'Nom du contact';
                    Editable = false;
                }
                field(Subject; REC.Subject)
                {
                    ApplicationArea = all;
                    trigger OnAssistEdit()
                    var
                        lDescription: Record "Description Line";
                    begin
                        lDescription.ShowDescription(36, rec."Document Type", rec."No.", 0);
                    end;
                }
                /* GL2024 field("Credit Card No."; "Credit Card No.")
                  {
                  }
                  field(GetCreditcardNumber; GetCreditcardNumber)
                  {
                      Caption = 'Cr. Card Number (Last 4 Digits)';
                  }*/
            }
            group(Invoice)
            {
                Caption = 'Facturation';
                field("Contract Type"; REC."Contract Type")
                {
                    ApplicationArea = all;
                    Editable = "Contract TypeEditable";
                }
                field("Bill-to Customer No."; REC."Bill-to Customer No.")
                {
                    ApplicationArea = all;
                    Editable = "Bill-to Customer No.Editable";
                }
                field("Bill-to Contact No."; REC."Bill-to Contact No.")
                {
                    ApplicationArea = all;
                }
                field("Bill-to Name"; REC."Bill-to Name")
                {
                    ApplicationArea = all;
                    AssistEdit = true;
                    Editable = "Bill-to NameEditable";

                    /* GL2024 trigger OnAssistEdit()
                      begin
                          CurrPage.SAVERECORD;
                          COMMIT;
                          CLEAR(AddressContributors);
                          AddressContributors.InitRequest(3);
                          AddressContributors.SETTABLEVIEW(Rec);
                          AddressContributors.SETRECORD(Rec);
                          AddressContributors.RUNMODAL;
                          //AddressContributors.GETRECORD(Rec);
                          CurrPage.UPDATE;
                      end;*/
                }
                field(Descr; wDescr)
                {
                    ApplicationArea = all;
                    Caption = 'Libellé écriture';
                    Editable = DescrEditable;

                    trigger OnValidate()
                    begin
                        //POSTING_DESC
                        IF wDescr = '' THEN BEGIN
                            REC."Posting Description" := REC.wPostingDescription;
                            wDescr := REC.wShowPostingDescription(REC."Posting Description");
                        END ELSE
                            REC."Posting Description" := wDescr;
                        //POSTING_DESC//
                    end;
                }
                field("Prices Including VAT"; REC."Prices Including VAT")
                {
                    ApplicationArea = all;
                    Editable = "Prices Including VATEditable";

                    trigger OnValidate()
                    begin
                        PricesIncludingVATOnAfterValid;
                    end;
                }
                field("User ID"; REC."User ID")
                {
                    ApplicationArea = all;
                    Caption = 'Code utilisateur';
                }
                field("Payment Terms Code"; REC."Payment Terms Code")
                {
                    ApplicationArea = all;
                    Editable = "Payment Terms CodeEditable";
                }
                field("Payment Method Code"; REC."Payment Method Code")
                {
                    ApplicationArea = all;
                    Editable = "Payment Method CodeEditable";
                }
                field("Due Date"; REC."Due Date")
                {
                    ApplicationArea = all;
                }
                field("Currency Code"; REC."Currency Code")
                {
                    ApplicationArea = all;
                    Editable = "Currency CodeEditable";

                    trigger OnAssistEdit()
                    begin
                        ChangeExchangeRate.SetParameter(REC."Currency Code", REC."Currency Factor", REC."Posting Date");
                        IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
                            REC.VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter);
                            CurrPage.UPDATE;
                        END;
                        CLEAR(ChangeExchangeRate);
                    end;
                }
                field("Part Payment"; REC."Part Payment")
                {
                    ApplicationArea = all;
                    Caption = 'Avance à déduire TTC';
                }
                field("VAT Bus. Posting Group"; REC."VAT Bus. Posting Group")
                {
                    ApplicationArea = all;
                    Editable = "VAT Bus. Posting GroupEditable";
                }
            }
            group(Posting)
            {
                Caption = 'Validation';
                field("Subscription Starting Date"; REC."Subscription Starting Date")
                {
                    ApplicationArea = all;
                    Caption = 'Date début abonnement';
                }
                field("Subscription End Date"; REC."Subscription End Date")
                {
                    ApplicationArea = all;
                    Caption = 'Date fin abonnement';
                }
                field("Shortcut Dimension 1 Code"; REC."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        ShortcutDimension1CodeOnAfterV;
                    end;
                }
                field("Shortcut Dimension 2 Code"; REC."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        ShortcutDimension2CodeOnAfterV;
                    end;
                }
                field("Responsibility Center"; REC."Responsibility Center")
                {
                    ApplicationArea = all;
                    Editable = "Responsibility CenterEditable";
                }
                field("Location Code"; REC."Location Code")
                {
                    ApplicationArea = all;
                }
                field("Review Formula Code"; REC."Review Formula Code")
                {
                    ApplicationArea = all;
                    Editable = "Review Formula CodeEditable";
                    Caption = 'Code formule révision';
                }
                field("Review Base Date"; REC."Review Base Date")
                {
                    ApplicationArea = all;
                    Caption = 'Date de base révision';
                    Editable = "Review Base DateEditable";
                }
                field("Sell-to Contact No."; REC."Sell-to Contact No.")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
            }
            group("Follow up")
            {
                Caption = 'Suivi';
                field("Progress Degree"; REC."Progress Degree")
                {
                    ApplicationArea = all;
                    caption = 'Stade d''avancement';
                }
                field("No. of Archived Versions"; REC."No. of Archived Versions")
                {
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    var
                        lSalesHeaderArchive: Record "Sales Header Archive";
                    begin
                        CurrPage.SAVERECORD;
                        COMMIT;
                        lSalesHeaderArchive.SETRANGE("Document Type", REC."Document Type"::Order);
                        lSalesHeaderArchive.SETRANGE("No.", REC."No.");
                        lSalesHeaderArchive.SETRANGE("Doc. No. Occurrence", REC."Doc. No. Occurrence");
                        IF lSalesHeaderArchive.GET(REC."Document Type"::Quote, REC."No.", REC."Doc. No. Occurrence", REC."No. of Archived Versions") THEN;
                        PAGE.RUNMODAL(PAGE::"Sales List Archive", lSalesHeaderArchive);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                field(Status; REC.Status)
                {
                    ApplicationArea = all;
                }
                field(Finished; REC.Finished)
                {
                    ApplicationArea = all;
                    caption = 'Soldé';
                    Editable = false;
                }
                field("Your Reference"; REC."Your Reference")
                {
                    ApplicationArea = all;
                }
            }
            group(Prepayment)
            {
                Caption = 'Acompte';
                field("Prepayment %"; REC."Prepayment %")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        Prepayment37OnAfterValidate;
                    end;
                }
                field("Compress Prepayment"; REC."Compress Prepayment")
                {
                    ApplicationArea = all;
                }
                field("Prepmt. Payment Terms Code"; REC."Prepmt. Payment Terms Code")
                {
                    ApplicationArea = all;
                }
                field("Prepayment Due Date"; REC."Prepayment Due Date")
                {
                    ApplicationArea = all;
                }
                field("Prepmt. Payment Discount %"; REC."Prepmt. Payment Discount %")
                {
                    ApplicationArea = all;
                }
                field("Prepmt. Pmt. Discount Date"; REC."Prepmt. Pmt. Discount Date")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(Promoted)
        {
            group("O&rder11")
            {
                Caption = 'Commande';

                actionref(Statistics1; Statistics) { }
                actionref("Customer Card1"; "Customer Card") { }
                actionref("C&ontact Card1"; "C&ontact Card") { }

                group("Co&mments16")
                {
                    Caption = 'Co&mmentaires';
                    actionref("Standard Co&mments1"; "Standard Co&mments") { }
                    actionref("Header Comments1"; "Header Comments") { }
                    actionref("Footer Comments1"; "Footer Comments") { }
                }
                actionref("S&hipments1"; "S&hipments") { }
                actionref(Invoices1; Invoices) { }
                actionref("Prepa&yment Invoices1"; "Prepa&yment Invoices") { }
                actionref("Prepayment Credi&t Memos1"; "Prepayment Credi&t Memos") { }
                actionref(Dimensions15; Dimensions) { }
                actionref("A&pprovals1"; "A&pprovals") { }
                actionref(Folder1; Folder) { }
                actionref(Reports1; Reports) { }
                actionref(Description1; Description) { }
                actionref("Statistics Criteria1"; "Statistics Criteria") { }
                actionref("Additionnals Informations1"; "Additionnals Informations") { }
                actionref("Interaction Log E&ntries1"; "Interaction Log E&ntries") { }
                actionref("Price Study Archive1"; "Price Study Archive") { }
                actionref("Measurement : Document var1"; "Measurement : Document var") { }
                actionref("Quote Footer1"; "Quote Footer") { }
                actionref("Pla&nning1"; "Pla&nning") { }
                actionref("Invoicing Scheduler1"; "Invoicing Scheduler") { }
                actionref("Production Completion1"; "Production Completion") { }
                actionref("Planning Task1"; "Planning Task") { }
            }


            group("&Line1")
            {
                Caption = 'Ligne';
                actionref("Reservation Entries1"; "Reservation Entries") { }
                actionref("Item &Tracking Lines1"; "Item &Tracking Lines") { }
                actionref("Select Item Substitution1"; "Select Item Substitution") { }
                actionref(Dimensions11; Dimensions1) { }
                actionref("Co&mments11"; "Co&mments1") { }
                actionref("Item Charge &Assignment1"; "Item Charge &Assignment") { }
                actionref("Comment Lines1"; "Comment Lines") { }
                actionref("Bill Of Qty1"; "Bill Of Qty") { }
                actionref(BOM1; BOM) { }
                actionref("Move Up1"; "Move Up") { }
                actionref("Mode Down1"; "Mode Down") { }
                actionref("Open/Close the Folder1"; "Open/Close the Folder") { }
            }
            actionref(WorkFlowBtn1; WorkFlowBtn) { }
            actionref("Move left1"; "Move left") { }
            actionref("Move Right1"; "Move Right") { }
            actionref("Hide/Show Header1"; "Hide/Show Header") { }
            actionref("Hide/Show Extended Text1"; "Hide/Show Extended Text") { }
            actionref("Hde/Show Structure1"; "Hde/Show Structure") { }

            group("F&unctions1")
            {
                Caption = 'Fonction&s';
                actionref("Calculate &Invoice Discount1"; "Calculate &Invoice Discount") { }
                actionref("Copy Document1"; "Copy Document") { }
                group("Line copy1")
                {
                    Caption = 'Cop&ier lignes';
                    actionref("From Sales Line Archive1"; "From Sales Line Archive") { }
                    actionref("From Sales Line1"; "From Sales Line") { }
                }
                actionref("Archi&ve Document1"; "Archi&ve Document") { }
                actionref("Get Price1"; "Get Price") { }
                actionref("Get Li&ne Discount1"; "Get Li&ne Discount") { }
                actionref("E&xplode BOM1"; "E&xplode BOM") { }

                group("Drop Shipment1")
                {
                    Caption = 'L&ivraison directe';
                    actionref("Generate Purchase Order1"; "Generate Purchase Order") { }


                    actionref("Purchase &Order11"; "Purchase &Order1") { }

                }

                group("Special Order1")
                {
                    Caption = 'Commande &spéciale';
                    actionref("Purchase &Order21"; "Purchase &Order") { }

                }
                actionref("&Reserve1"; "&Reserve") { }
                actionref("Order &Tracking1"; "Order &Tracking") { }
                actionref("Nonstoc&k Items1"; "Nonstoc&k Items") { }


                actionref("Order &Promising1"; "Order &Promising") { }
                group(Warehouse1)
                {
                    Caption = 'Magasin';
                    actionref("Shipment Lines1"; "Shipment Lines") { }
                    actionref("Create &Whse. Shipment1"; "Create &Whse. Shipment") { }

                }
                actionref("Send A&pproval Request1"; "Send A&pproval Request") { }
                actionref("Cancel Approval Re&quest1"; "Cancel Approval Re&quest") { }
                actionref("Re&lease1"; "Re&lease") { }
                actionref("Re&open1"; "Re&open") { }

                group("Re&quisition Order12")
                {
                    Caption = 'Deman&de d''appro.';
                    actionref("Generate Supply Order1"; "Generate Supply Order") { }
                    actionref("Supply Order1"; "Supply Order") { }
                }
                group("Transfer Order12")
                {
                    Caption = 'Commande interne';
                    actionref("Generate Transfer Order1"; "Generate Transfer Order") { }
                    actionref("Transfer Order123"; "Transfer Order") { }
                }


                group(Subcontracting1)
                {
                    Caption = 'So&us-traitance';
                    actionref("Generate Subcontracting1"; "Generate Subcontracting") { }
                    actionref("Update Cost1"; "Update Cost") { }

                    actionref("Purchase D&ocument1"; "Purchase D&ocument") { }
                }
                actionref("Update Budget1"; "Update Budget") { }


            }

            group("P&osting1")
            {
                Caption = '&Validation';
                actionref("Test Report1"; "Test Report") { }

                actionref("P&ost1"; "P&ost") { }
                actionref("Post and &Print1"; "Post and &Print") { }
                actionref("Post &Batch1"; "Post &Batch") { }
                group("Prepa&yment1")
                {
                    Caption = 'Acom&pte';
                    actionref("Prepayment &Test Report1"; "Prepayment &Test Report") { }
                    actionref("Post Prepayment &Invoice1"; "Post Prepayment &Invoice") { }
                    actionref("Post and Print Prepmt. Invoic&e1"; "Post and Print Prepmt. Invoic&e") { }
                    actionref("Post Prepayment &Credit Memo1"; "Post Prepayment &Credit Memo") { }
                    actionref("Post and Print Prepmt. Cr. Mem&o1"; "Post and Print Prepmt. Cr. Mem&o") { }
                }
            }

            group("&Print1")
            {
                Caption = 'Im&primer';
                actionref("Order Confirmation1"; "Order Confirmation") { }
                actionref(Commande1; Commande) { }
                actionref("Work Order1"; "Work Order") { }
                actionref(Proforma1; Proforma) { }

                actionref("Pre-Invoice1"; "Pre-Invoice") { }
            }
            actionref(Actualiser1; Actualiser) { }
        }

        area(processing)
        {
            group("O&rder")
            {
                Caption = 'Commande';
                action(Statistics)
                {
                    ApplicationArea = all;
                    Caption = 'Statistiques';
                    Image = Statistics;

                    ShortCutKey = 'F7';

                    trigger OnAction()
                    var
                        lGR: Record "Gen. Product Posting Group";
                        lInvScheduler: Record "Invoice Scheduler";
                    //GL2024 lStat: Page 8004045;
                    begin
                        // >> HJ SORO 16-10-2014
                        //    CduSalesPost2.CalcTimbre(Rec);
                        // >> HJ SORO 16-10-2014
                        REC.CalcInvDiscForHeader;
                        COMMIT;
                        //+ONE+
                        //page.RUNMODAL(page::"Sales Order Statistics",Rec);
                        //+ONE+//
                        //Currpage.SalesLines.PAGE.wCalcJobCostRepartition;       Fait dans lStat
                        //COMMIT;
                        //PROJET_FACT
                        IF rec."Invoicing Method" = rec."Invoicing Method"::Scheduler THEN BEGIN
                            CLEAR(lInvScheduler);
                            lInvScheduler.SETRANGE("Sales Header Doc. Type", rec."Document Type");
                            lInvScheduler.SETRANGE("Sales Header Doc. No.", rec."No.");
                            lInvScheduler.SETFILTER("Document Percentage", '<>0');
                            IF NOT lInvScheduler.ISEMPTY THEN BEGIN
                                lInvScheduler.FINDFIRST;
                                lInvScheduler.UpdateLineAmount(lInvScheduler);
                                COMMIT;
                            END;
                        END;
                        //PROJET_FACT//
                        //GL2024  lStat.GetSalesHeader("Document Type", "No.");
                        lGR.SETRANGE("Document Type Filter", rec."Document Type");
                        lGR.SETRANGE("Document No. Filter", rec."No.");
                        //lGR.SETRANGE("Job Filter","Job No.");
                        //#9092
                        lGR.SETFILTER("Job Totaling", '%1', rec."Job No.");
                        //#9092//
                        //GL2024   lStat.SETTABLEVIEW(lGR);
                        //Fenetre.CLOSE;
                        //GL2024   lStat.RUNMODAL;
                    end;
                }
                action("Customer Card")
                {
                    ApplicationArea = all;
                    Caption = 'Fiche Client';
                    image = Card;
                    RunObject = Page "Customer Card";
                    RunPageLink = "No." = FIELD("Sell-to Customer No.");
                    ShortCutKey = 'Maj+F7';
                }
                action("C&ontact Card")
                {
                    Caption = 'Fiche Contact';
                    image = Card;
                    RunObject = Page "Contact List";
                    RunPageLink = "No." = FIELD("Sell-to Contact No.");
                }
                group("Co&mments")
                {
                    Caption = 'Commentaires';
                    action("Standard Co&mments")
                    {
                        image = Comment;
                        ApplicationArea = all;
                        Caption = 'Co&mmentaires standard';
                        RunObject = Page "Sales Comment Sheet";
                        RunPageLink = "Document Type" = FIELD("Document Type"), "No." = FIELD("No."), "Document Line No." = CONST(0);
                    }
                    action("Header Comments")
                    {
                        image = Comment;
                        ApplicationArea = all;
                        Caption = 'Commentaires &en-tête';

                        trigger OnAction()
                        var
                            lSalesTextManagement: Codeunit "Sales Text Management";
                        begin
                            //+REF+ADDTEXT
                            lSalesTextManagement.CommentText(Rec, 1);
                            //+REF+ADDTEXT//
                        end;
                    }
                    action("Footer Comments")
                    {
                        image = Comment;
                        ApplicationArea = all;
                        Caption = 'Commentaires &pied';

                        trigger OnAction()
                        var
                            lSalesTextManagement: Codeunit "Sales Text Management";
                        begin
                            //+REF+ADDTEXT
                            lSalesTextManagement.CommentText(Rec, 2);
                            //+REF+ADDTEXT//
                        end;
                    }
                }
                action("S&hipments")
                {
                    ApplicationArea = all;
                    Caption = 'Livraisons';
                    Image = Delivery;
                    RunObject = Page "Posted Sales Shipments";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                }
                action(Invoices)
                {
                    ApplicationArea = all;
                    Caption = 'F&actures';
                    Image = Invoice;
                    RunObject = Page "Posted Sales Invoices";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                }
                action("Prepa&yment Invoices")
                {
                    ApplicationArea = all;
                    Caption = 'Factures acom&pte';
                    RunObject = Page "Posted Sales Invoices";
                    RunPageLink = "Prepayment Order No." = FIELD("No.");
                    RunPageView = SORTING("Prepayment Order No.");
                    Visible = false;
                }
                action("Prepayment Credi&t Memos")
                {
                    ApplicationArea = all;
                    Caption = 'A&voirs acompte';
                    RunObject = Page "Posted Sales Credit Memos";
                    RunPageLink = "Prepayment Order No." = FIELD("No.");
                    RunPageView = SORTING("Prepayment Order No.");
                    Visible = false;
                }
                action(Dimensions)
                {
                    ApplicationArea = all;
                    Caption = 'A&xes analytiques';
                    Image = Dimensions;

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim;
                    end;
                }
                action("A&pprovals")
                {
                    ApplicationArea = all;
                    Caption = '&Approbations';
                    Image = Approvals;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        ApprovalEntries.SetRecordFilters(DATABASE::"Sales Header", rec."Document Type", rec."No.");
                        ApprovalEntries.RUN;
                    end;
                }
                action(Folder)
                {
                    ApplicationArea = all;
                    Caption = 'Dossier';


                    trigger OnAction()
                    var
                        lFolderManagement: Codeunit "Folder management";
                    begin
                        //+REF+FOLDER
                        lFolderManagement.SalesHeader(Rec);
                        //+REF+FOLDER//
                    end;
                }
                action(Reports)
                {
                    ApplicationArea = all;
                    Caption = 'E&tats';
                    Image = Report;
                    trigger OnAction()
                    var
                        lReportList: Record ReportList;
                        lId: Integer;
                        lRecRef: RecordRef;
                    begin
                        WITH lReportList DO BEGIN
                            EVALUATE(lId, COPYSTR(CurrPage.OBJECTID(FALSE), 6));
                            lRecRef.GETTABLE(Rec);
                            lRecRef.SETRECFILTER;
                            SetRecordRef(lRecRef, TRUE);
                            ShowList(lId);
                        END;
                    end;
                }
                action("Statistics Criteria")
                {
                    ApplicationArea = all;
                    Caption = 'Critères Statistiques';
                    image = Statistics;

                    trigger OnAction()
                    var
                        lSalesHeader: Record "Sales Header";
                    //GL2024   lFormStatSales: Page 8035125;
                    begin
                        lSalesHeader := Rec;
                        //GL2024  lFormStatSales.SETRECORD(lSalesHeader);
                        //GL2024  lFormStatSales.fSetSalesDoc(TRUE);
                        //GL2024   lFormStatSales.RUNMODAL();
                        Rec := lSalesHeader;
                        CurrPage.UPDATE(TRUE);
                    end;
                }
                action("Additionnals Informations")
                {
                    ApplicationArea = all;
                    Caption = 'Informations Additionnelles';
                    Image = Info;

                    trigger OnAction()
                    var
                        lSalesHeader: Record "Sales Header";
                    //GL2024  LfORMaDDiNFO: Page 8035126;
                    begin
                        lSalesHeader := Rec;
                        //GL2024 LfORMaDDiNFO.SETRECORD(lSalesHeader);
                        //GL2024   LfORMaDDiNFO.RUNMODAL;
                        Rec := lSalesHeader;
                        CurrPage.UPDATE(TRUE);
                    end;
                }
                action(Description)
                {
                    ApplicationArea = all;
                    Caption = 'Description';
                    image = Description;

                    trigger OnAction()
                    var
                        lDesc: Record "Description Line";
                    begin
                        lDesc.ShowDescription(36, rec."Document Type", rec."No.", 0);
                    end;
                }
                /*GL2024 action("Contacts and Contributors")
                 {
                     Caption = 'Contacts and Contributors';
                     RunObject = Page 8004022;
                                     RunPageLink = Document Type=FIELD(Document Type), No.=FIELD(No.);
                 }*/
                action("Interaction Log E&ntries")
                {
                    ApplicationArea = all;
                    Caption = 'Ecritures journal interaction';
                    Image = Entries;
                    trigger OnAction()
                    begin
                        //CRM
                        rec.wShowDocumentInteraction(Rec);
                        //CRM//
                    end;
                }
                /*GL2024ction("Job Sales Documents")
                 {
                     Caption = 'Job Sales Documents';
                     RunObject = Page 8004056;
                     RunPageLink = Job No.=FIELD(Job No.);
                     RunPageView = SORTING(Job No.) WHERE(Job No.=FILTER(<>''), Order Type=CONST(" "));
                 }*/
                action("Price Study Archive")
                {
                    ApplicationArea = all;
                    Caption = 'Devis archivés';
                    Image = Price;

                    trigger OnAction()
                    var
                        lSalesHeaderArchive: Record "Sales Header Archive";
                    begin
                        lSalesHeaderArchive.SETCURRENTKEY("Document Type", "Order No.");
                        lSalesHeaderArchive.SETRANGE("Document Type", lSalesHeaderArchive."Document Type"::Quote);
                        lSalesHeaderArchive.SETRANGE("Order No.", REC."No.");
                        IF NOT lSalesHeaderArchive.ISEMPTY THEN BEGIN
                            IF lSalesHeaderArchive.COUNT > 1 THEN
                                PAGE.RUNMODAL(PAGE::"Sales List Archive", lSalesHeaderArchive)
                            //DYS page ADDON non migrer
                            // ELSE
                            //   PAGE.RUNMODAL(PAGE::"NaviBat Sales Archive", lSalesHeaderArchive);
                        END;
                    end;
                }
                separator(separator1)
                {
                }
                action("Measurement : Document var")
                {
                    ApplicationArea = all;
                    Caption = 'Métré : Variables du document';

                    trigger OnAction()
                    var
                        lRecRef: RecordRef;
                        lBOQCustMgt: Codeunit "BOQ Custom Management";
                    begin
                        //#6115
                        lRecRef.GETTABLE(Rec);
                        IF NOT lBOQCustMgt.fShowBOQLine(lRecRef) THEN
                            EXIT;
                        CurrPage.UPDATE(FALSE);
                        //#6115//
                    end;
                }
                action("Quote Footer")
                {
                    ApplicationArea = all;
                    Caption = 'Pied de devis';
                    Image = Quote;

                    trigger OnAction()
                    var
                        lSalesLine: Record "Sales Line";
                    begin
                        lSalesLine.SETRANGE("Document Type", REC."Document Type");
                        lSalesLine.SETRANGE("Document No.", REC."No.");
                        //GL2024  PAGE.RUNMODAL(PAGE::"Quote Footer", lSalesLine);
                    end;
                }
                separator(separator2)
                {
                }
                action("Pla&nning")
                {
                    ApplicationArea = all;
                    Caption = 'Pla&nification';
                    Image = Planning;

                    trigger OnAction()
                    var
                        SalesPlanForm: Page "Sales Order Planning";
                    begin
                        SalesPlanForm.SetSalesOrder(REC."No.");
                        SalesPlanForm.RUNMODAL;
                    end;
                }
                /* GL2024 action("Total needs")
                 {
                     Caption = 'Total needs';
                     RunObject = Page 8004085;
                     RunPageLink = Document Type=FIELD(Document Type), Document No.=FIELD(No.);
                     Visible = false;
                 }
                action("Total needs 2")
                {
                    Caption = 'Total needs 2';
                    ShortCutKey = 'Ctrl+F11';

                    trigger OnAction()
                    var
                        lFormNeed: Page 8004085;
                    begin
                        //#8255
                        lFormNeed.fSetDocumentType(Rec."Document Type");
                        lFormNeed.fSetDocumentNo(Rec."No.");
                        lFormNeed.RUNMODAL();
                        //#8255//
                    end;
                }
                action(Guarantees)
                {
                    Caption = 'Guarantees';
                    RunObject = Page 8003994;
                    RunPageLink = Document Type=FIELD(Document Type), No.=FIELD(No.);
                }*/
                action("Invoicing Scheduler")
                {
                    ApplicationArea = all;
                    Caption = 'Echéancier de facturation';
                    Image = Invoice;

                    trigger OnAction()
                    var
                        lInvSch: Record "Invoice Scheduler";
                    begin
                        //PROJET_FACT
                        REC.TESTFIELD("Invoicing Method", REC."Invoicing Method"::Scheduler);
                        lInvSch.SETRANGE("Sales Header Doc. Type", REC."Document Type");
                        lInvSch.SETRANGE("Sales Header Doc. No.", REC."No.");
                        PAGE.RUN(0, lInvSch);
                        //PROJET_FACT//
                    end;
                }
                action("Production Completion")
                {
                    ApplicationArea = all;
                    Caption = 'Avancement production';
                    Image = Production;

                    trigger OnAction()
                    var
                        lCompletionMgt: Codeunit "Completion Management";
                        "//HJ": Integer;
                        LSalesLine: Record "Sales Line";
                    begin
                        //PROJET_FACT
                        //#4523  TESTFIELD(Status,Status::Released);
                        //TESTFIELD("Invoicing Method");
                        /*    REC.TESTFIELD("Date Debut Decompte");
                            REC.TESTFIELD("Date Fin Decompte");
                            IF CONFIRM(Text004, FALSE) THEN BEGIN
                                LSalesLine.SETRANGE("Document Type", LSalesLine."Document Type"::Order);
                                LSalesLine.SETRANGE("Document No.", REC."No.");
                                LSalesLine.MODIFYALL("Qty. to Ship", 0);
                            END;*/
                        lCompletionMgt.fShowCompletion(Rec);
                        //PROJET_FACT//
                    end;
                }
                /* GL2024  action(Prepayments)
                   {
                       Caption = 'Prepayments';
                       RunObject = Page 8003978;
                       RunPageLink = Document Type=FIELD(Document Type), No.=FIELD(No.);
                   }*/
                action("Planning Task")
                {
                    ApplicationArea = all;
                    Caption = 'Tâches planning';
                    visible = false;

                    trigger OnAction()
                    var
                        lRecordRef: RecordRef;
                        lPlanTask: Record "Planning Line";
                    begin
                        //PLANNING\\
                        lRecordRef.GETTABLE(Rec);
                        lPlanTask.SETFILTER("Source Record ID", FORMAT(lRecordRef.RECORDID));
                        //GL2024   PAGE.RUNMODAL(PAGE::"Planning Task List", lPlanTask);
                    end;
                }
            }

            group("&Line")
            {
                Caption = 'Ligne';
                //DYS action dans ligne
                /*  action("Line Card")
                  {
                      ApplicationArea = all;
                      Caption = 'Line Card';
                      ShortCutKey = 'Maj+F7';

                      trigger OnAction()
                      begin
                          //#7652
                          CurrPage.SalesLines.PAGE.ShowLineCard;
                          //#7652//
                      end;
                  }
                  group("Item Availability by")
                  {
                      Caption = 'Item Availability by';
                      action(Period)
                      {
                          ApplicationArea = all;
                          Caption = 'Period';

                          trigger OnAction()
                          begin
                              CurrPage.SalesLines.PAGE.ItemAvailability(0);
                          end;
                      }
                      action(Variant)
                      {
                          ApplicationArea = all;
                          Caption = 'Variant';

                          trigger OnAction()
                          begin
                              CurrPage.SalesLines.PAGE.ItemAvailability(1);
                          end;
                      }
                      action(Location)
                      {
                          ApplicationArea = all;
                          Caption = 'Location';

                          trigger OnAction()
                          begin
                              CurrPage.SalesLines.PAGE.ItemAvailability(2);
                          end;
                      }
                      
            }
*/
                separator(separator3)
                {
                }
                action("Reservation Entries")
                {
                    ApplicationArea = all;
                    Caption = 'Ecritures réservation';
                    Image = ReservationLedger;

                    trigger OnAction()
                    begin
                        CurrPage.SalesLines.PAGE.OpenPurchOrderForm;
                    end;
                }
                action("Item &Tracking Lines")
                {
                    ApplicationArea = all;
                    Caption = 'Lignes traçabilité';
                    Image = ItemTrackingLines;
                    ShortCutKey = 'Maj+Ctrl+I';

                    trigger OnAction()
                    begin
                        CurrPage.SalesLines.PAGE.OpenItemTrackingLines;
                    end;
                }
                separator(separator4)
                {
                }
                action("Select Item Substitution")
                {
                    ApplicationArea = all;
                    Caption = 'Sélectionner article de substitution';
                    Image = SelectItemSubstitution;

                    trigger OnAction()
                    begin
                        CurrPage.SalesLines.PAGE.ShowItemSub;
                    end;
                }
                action(Dimensions1)
                {
                    ApplicationArea = all;
                    Caption = 'A&xe analytique';
                    Image = Dimensions;
                    ShortCutKey = 'Maj+Ctrl+D';

                    trigger OnAction()
                    begin
                        CurrPage.SalesLines.PAGE.ShowDimensions;
                    end;
                }
                action("Co&mments1")
                {
                    ApplicationArea = all;
                    Caption = 'Co&mmentaires';
                    Image = ViewComments;

                    trigger OnAction()
                    begin
                        CurrPage.SalesLines.PAGE.ShowLineComments;
                    end;
                }
                action("Item Charge &Assignment")
                {
                    ApplicationArea = all;
                    Image = Item;
                    Caption = '&Affectation frais annexes';

                    trigger OnAction()
                    begin
                        CurrPage.SalesLines.PAGE.ItemChargeAssgnt;
                    end;
                }
                action("Comment Lines")
                {
                    ApplicationArea = all;
                    Caption = 'Description';
                    image = Description;
                    trigger OnAction()
                    begin
                        CurrPage.SalesLines.PAGE.ShowDescription;
                    end;
                }
                separator(separator5)
                {
                }
                action("Bill Of Qty")
                {
                    ApplicationArea = all;
                    Caption = 'M&étré';

                    trigger OnAction()
                    var
                        lSalesLine: Record "Sales Line";
                    begin
                        CurrPage.SalesLines.PAGE.lMetre();
                    end;
                }
                action(BOM)
                {
                    ApplicationArea = all;
                    Caption = 'Ouvrage';
                    ShortCutKey = 'Maj+Ctrl+E';

                    trigger OnAction()
                    begin
                        CurrPage.SalesLines.PAGE.wStructure;
                    end;
                }
                action("Move Up")
                {
                    ApplicationArea = all;
                    Caption = 'Monter';
                    ShortCutKey = 'Maj+Ctrl+Haut';

                    trigger OnAction()
                    begin
                        CurrPage.SalesLines.PAGE.Move(MoveOption::Up);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Mode Down")
                {
                    ApplicationArea = all;
                    Caption = 'Descendre';
                    ShortCutKey = 'Maj+Ctrl+Bas';

                    trigger OnAction()
                    begin
                        CurrPage.SalesLines.PAGE.Move(MoveOption::Down);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Open/Close the Folder")
                {
                    ApplicationArea = all;
                    Caption = 'O&uvrir/Fermer le dossier';
                    ShortCutKey = 'Maj+Ctrl+O';

                    trigger OnAction()
                    begin
                        CurrPage.SalesLines.PAGE.ToggleExpandCollapse(FALSE);
                    end;
                }
                //DYS NAVIBAT
                /*  action("Calculate the quantity")
                  {
                      ApplicationArea = all;
                      Caption = 'Calculate the quantity';
                      ShortCutKey = 'Maj+F11';

                      trigger OnAction()
                      begin
                          CurrPage.SalesLines.PAGE.wCalculateQty;
                      end;
                  }*/
                separator(separator7)
                {
                }
                /* GL2024  action("Credit Cards Transaction Lo&g Entries")
                   { ApplicationArea = all;
                       Caption = 'Credit Cards Transaction Lo&g Entries';
                       RunObject = Page "DO Payment Trans. Log Entries";
                       RunPageLink = Document Type=FIELD(Document Type), Document No.=FIELD(No.), Customer No.=FIELD(Bill-to Customer No.);
                   }*/
            }
            action(WorkFlowBtn)
            {
                ApplicationArea = all;
                Caption = 'Wor&Kflow';
                Enabled = WorkFlowBtnEnable;
                visible = false;
                ToolTip = 'Workflow';

                trigger OnAction()
                var
                    lRecordRef: RecordRef;
                    lWorkflowConnector: Codeunit "Workflow Connector";
                begin
                    lRecordRef.GETTABLE(Rec);
                    lWorkflowConnector.OnPush(PAGE::"Sales Order", lRecordRef);
                end;
            }
            action("Move left")
            {
                ApplicationArea = all;
                Caption = 'Vers la gauche';
                visible = false;


                trigger OnAction()
                begin
                    CurrPage.SalesLines.PAGE.Move(MoveOption::Left);
                    CurrPage.UPDATE(FALSE);
                end;
            }
            action("Move Right")
            {
                ApplicationArea = all;
                Caption = 'Vers la droite';

                visible = false;

                trigger OnAction()
                begin
                    CurrPage.SalesLines.PAGE.Move(MoveOption::Right);
                end;
            }
            action("Hide/Show Header")
            {
                ApplicationArea = all;
                Caption = 'Masquer/Afficher en-tête';

                visible = false;

                trigger OnAction()
                begin

                    IF SalesLinesYPos = TabControlYPos THEN BEGIN
                        SalesLinesYPos := TabControlYPos + TabControlHeight + SalesLinesYPos;
                        SalesLinesHeight := SalesLinesHeight - SalesLinesYPos;
                    END ELSE BEGIN
                        SalesLinesHeight := SalesLinesHeight + SalesLinesYPos;
                        SalesLinesYPos := TabControlYPos;
                    END;
                end;
            }
            action("Hide/Show Extended Text")
            {
                ApplicationArea = all;
                Caption = 'Masquer/Afficher texte étendu';

                visible = false;

                trigger OnAction()
                begin
                    ShowExtendedText := NOT ShowExtendedText;
                    CurrPage.SalesLines.PAGE.wSetMarked(wMarked, ShowExtendedText);
                end;
            }
            action("Hde/Show Structure")
            {
                ApplicationArea = all;
                Caption = 'Masquer/Afficher Ouvrage';
                visible = false;


                trigger OnAction()
                begin
                    wMarked := NOT wMarked;
                    CurrPage.SalesLines.PAGE.wSetMarked(wMarked, ShowExtendedText);
                end;
            }
            group("F&unctions")
            {
                Caption = 'Fonctions';
                action("Calculate &Invoice Discount")
                {
                    ApplicationArea = all;
                    Caption = 'C&alculer remise facture';
                    Image = CalculateInvoiceDiscount;

                    trigger OnAction()
                    begin
                        ApproveCalcInvDisc;
                    end;
                }
                action("Copy Document")
                {
                    ApplicationArea = all;
                    Caption = '&Copier document';
                    Ellipsis = true;
                    Image = CopyDocument;

                    trigger OnAction()
                    begin
                        CopySalesDoc.SetSalesHeader(Rec);
                        CopySalesDoc.RUNMODAL;
                        CLEAR(CopySalesDoc);
                        CurrPage.SalesLines.PAGE.wSetMarked(wMarked, ShowExtendedText);
                    end;
                }
                group("Line copy")
                {
                    Caption = 'Cop&ier lignes';
                    action("From Sales Line Archive")
                    {
                        Caption = 'Depuis les documents de vente archivés';
                        Ellipsis = true;

                        trigger OnAction()
                        begin
                            //DEVIS
                            //#8254
                            CurrPage.SalesLines.PAGE.wCopyLine(TRUE);
                            CurrPage.UPDATE(FALSE);
                            //#8254//
                            //DEVIS//
                        end;
                    }
                    action("From Sales Line")
                    {
                        ApplicationArea = all;
                        Caption = 'Depuis les documents de vente';
                        Ellipsis = true;

                        trigger OnAction()
                        begin
                            //DEVIS
                            //#8254
                            CurrPage.SalesLines.PAGE.wCopyLine(FALSE);
                            CurrPage.UPDATE(FALSE);
                            //#8254//
                            //DEVIS//
                        end;
                    }
                }
                action("Archi&ve Document")
                {
                    ApplicationArea = all;
                    Caption = 'Archi&ver document';
                    Image = Archive;

                    trigger OnAction()
                    var
                        Cduarchivmgm: Codeunit ArchiveManagementEvent;
                    begin
                        //#8211
                        Cduarchivmgm.fSetQuoteToOrder(FALSE);
                        ArchiveManagement.ArchiveSalesDocument(Rec);
                        //#8211//
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Get Price")
                {
                    ApplicationArea = all;
                    Caption = 'Extraire prix';
                    image = Price;
                    Ellipsis = true;

                    trigger OnAction()
                    begin
                        CurrPage.SalesLines.PAGE.ShowPrices
                    end;
                }
                action("Get Li&ne Discount")
                {
                    ApplicationArea = all;
                    Caption = 'Ex&traire remise ligne';
                    Ellipsis = true;

                    trigger OnAction()
                    begin
                        CurrPage.SalesLines.PAGE.ShowLineDisc
                    end;
                }
                action("E&xplode BOM")
                {
                    ApplicationArea = all;
                    Caption = '&Eclater nomenclature';
                    Image = ExplodeBOM;
                    Visible = false;

                    trigger OnAction()
                    begin
                        CurrPage.SalesLines.PAGE.ExplodeBOM;
                    end;
                }
                group("Drop Shipment")
                {
                    Caption = 'L&ivraison directe';
                    action("Generate Purchase Order")
                    {
                        ApplicationArea = all;
                        Caption = 'Générer commande achat';

                        trigger OnAction()
                        begin
                            CurrPage.SalesLines.PAGE.gGenerateDropShipment;
                        end;
                    }
                    action("Purchase &Order1")
                    {
                        ApplicationArea = all;
                        Caption = 'Commande ac&hat';
                        Image = Document;

                        trigger OnAction()
                        begin
                            CurrPage.SalesLines.PAGE.OpenPurchOrderForm;
                        end;
                    }
                }
                group("Special Order")
                {
                    Caption = 'Commande &spéciale';
                    action("Purchase &Order")
                    {
                        ApplicationArea = all;
                        Caption = 'Commande ac&hat';
                        Image = Document;

                        trigger OnAction()
                        begin
                            CurrPage.SalesLines.PAGE.OpenSpecialPurchOrderForm;
                        end;
                    }
                }
                action("&Reserve")
                {
                    ApplicationArea = all;
                    Caption = '&Réserver';
                    Ellipsis = true;
                    Image = Reserve;

                    trigger OnAction()
                    begin
                        CurrPage.SalesLines.PAGE.ShowReservation;
                    end;
                }
                action("Order &Tracking")
                {
                    ApplicationArea = all;
                    Caption = 'Chaînage';

                    trigger OnAction()
                    begin
                        CurrPage.SalesLines.PAGE.ShowTracking;
                    end;
                }
                separator(separator8)
                {
                }
                action("Nonstoc&k Items")
                {
                    ApplicationArea = all;
                    Caption = 'Articles &non stockés';
                    image = Item;

                    trigger OnAction()
                    begin
                        CurrPage.SalesLines.PAGE.ShowNonstockItems;
                    end;
                }
                action("Order &Promising")
                {
                    ApplicationArea = all;
                    Caption = 'Promesse de livraison';
                    Image = Delivery;

                    trigger OnAction()
                    var
                        OrderPromisingLine: Record "Order Promising Line" temporary;
                        OrderPromising: Page "Order Promising Lines";
                    begin
                        OrderPromisingLine.SETRANGE("Source Type", REC."Document Type");
                        OrderPromisingLine.SETRANGE("Source ID", REC."No.");
                        PAGE.RUNMODAL(PAGE::"Order Promising Lines", OrderPromisingLine);
                    end;
                }
                group(Warehouse)
                {
                    Caption = 'Magasin';
                    action("Shipment Lines")
                    {
                        Image = Warehouse;
                        ApplicationArea = all;
                        Caption = 'Lignes expédition';
                        RunObject = Page "Whse. Shipment Lines";
                        RunPageLink = "Source Type" = CONST(37), "Source Subtype" = FIELD("Document Type"), "Source No." = FIELD("No.");
                        RunPageView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                    }
                    action("Create &Whse. Shipment")
                    {
                        ApplicationArea = all;
                        Caption = 'Créer &expédition entrepôt';
                        Image = Warehouse;

                        trigger OnAction()
                        var
                            GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
                        begin
                            GetSourceDocOutbound.CreateFromSalesOrder(Rec);

                            IF NOT rec.FIND('=><') THEN
                                rec.INIT;
                        end;
                    }
                }
                separator(separator9)
                {
                }
                action("Send A&pproval Request")
                {
                    ApplicationArea = all;
                    Caption = 'Envoyer demande d''a&pprobation';
                    Image = SendApprovalRequest;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                        "Release Sales Document": Codeunit "Release Sales Document";
                    begin
                        //GL2024  IF ApprovalMgt.SendSalesApprovalRequest(Rec) THEN;
                        IF ApprovalMgt.IsSalesApprovalsWorkflowEnabled(Rec) THEN;
                    end;
                }
                action("Cancel Approval Re&quest")
                {
                    ApplicationArea = all;
                    Caption = 'Annuler demande d''appro&bation';
                    Image = Cancel;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                        "Release Sales Document": Codeunit "Release Sales Document";
                    begin
                        //GL2024    IF ApprovalMgt.CancelSalesApprovalRequest(Rec, TRUE, TRUE) THEN;
                        ApprovalMgt.OnCancelSalesApprovalRequest(Rec)
                    end;
                }
                separator(separator10)
                {
                }
                action("Re&lease")
                {
                    ApplicationArea = all;
                    Caption = '&Lancer';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        ReleaseSalesDoc.PerformManualRelease(Rec);
                    end;
                }
                action("Re&open")
                {
                    ApplicationArea = all;
                    Caption = 'R&ouvrir';
                    Image = ReOpen;
                    ShortCutKey = 'Maj+Ctrl+F9';

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                        lSalesHeader: Record "Sales Header";
                    begin
                        ReleaseSalesDoc.PerformManualReopen(Rec);
                        //DEVIS
                        CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
                        //DEVIS//
                    end;
                }
                separator(separator11)
                {
                }
                group("Re&quisition Order")
                {
                    Caption = 'Deman&de d''appro.';
                    action("Generate Supply Order")
                    {
                        ApplicationArea = all;
                        Caption = 'Générer demande d''appro.';

                        trigger OnAction()
                        begin
                            CurrPage.SalesLines.PAGE.wSupplyOrder;
                        end;
                    }
                    action("Supply Order")
                    {
                        ApplicationArea = all;
                        Caption = 'Demande d''appro.';

                        trigger OnAction()
                        begin
                            CurrPage.SalesLines.PAGE.wFindSupplyOrder;
                        end;
                    }
                }
                group("Transfer Order1")
                {
                    Caption = 'Commande interne';
                    action("Generate Transfer Order")
                    {
                        ApplicationArea = all;
                        Caption = 'Générer Commande Interne';

                        trigger OnAction()
                        begin
                            CurrPage.SalesLines.PAGE.wTransfer;
                        end;
                    }
                    action("Transfer Order")
                    {
                        ApplicationArea = all;
                        Caption = 'Commande interne';
                        Image = Document;

                        trigger OnAction()
                        begin
                            CurrPage.SalesLines.PAGE.wFindTransfer;
                        end;
                    }
                }
                group(Subcontracting)
                {
                    Caption = 'So&us-traitance';
                    action("Generate Subcontracting")
                    {
                        ApplicationArea = all;
                        Caption = '&Générer sous-traitance';

                        trigger OnAction()
                        begin
                            //SUBCONTRACTOR
                            CurrPage.SalesLines.PAGE.wGenerateSubcontracting;
                            //SUBCONTRACTOR//
                        end;
                    }
                    action("Update Cost")
                    {
                        ApplicationArea = all;
                        Caption = '&Actualiser coût';

                        trigger OnAction()
                        var
                            lSalesHeader: Record "Sales Header";
                        begin
                            //SUBCONTRACTOR
                            lSalesHeader.COPY(Rec);
                            lSalesHeader.SETRECFILTER;
                            //DYS report addon non migrer
                            //  REPORT.RUNMODAL(REPORT::"Update Subcontracting Cost", TRUE, FALSE, lSalesHeader);
                            CurrPage.SalesLines.PAGE.wSetMarked(wMarked, ShowExtendedText);
                            //SUBCONTRACTOR//
                        end;
                    }
                    action("Purchase D&ocument")
                    {
                        ApplicationArea = all;
                        Caption = 'Document ac&hat';

                        trigger OnAction()
                        begin
                            CurrPage.SalesLines.PAGE.OpenPurchOrderForm;
                        end;
                    }
                }
                separator(separator12)
                {
                }
                action("Update Budget")
                {
                    ApplicationArea = all;
                    Caption = 'Mise à jour &Budget';

                    trigger OnAction()
                    var
                        lSaleHeader: Record "Sales Header";
                    begin
                        lSaleHeader.COPY(Rec);
                        lSaleHeader.SETRECFILTER;
                        //DYS report Addon Non migrer
                        //  REPORT.RUNMODAL(REPORT::"Sales to Job Budget Entry", TRUE, FALSE, lSaleHeader);
                    end;
                }
                /* GL2024 action("Import/Export Sales Lines")
                  { ApplicationArea = all;
                      Caption = 'Import/Export Sales Lines';

                      trigger OnAction()
                      var
                          lQuoteFromExcel: Report 8004054;
                      begin
                          CLEAR(lQuoteFromExcel);
                          lQuoteFromExcel.InitRequest(rec."Document Type",rec."No.");
                          lQuoteFromExcel.RUNMODAL;

                          CurrPage.SalesLines.PAGE.wSetMarked(wMarked,ShowExtendedText);
                      end;
                  }*/
                separator(separator14)
                {
                }
                /* GL2024 action(Authorize)
                 {
                     Caption = 'Authorize';

                     trigger OnAction()
                     begin
                         Authorize;
                     end;
                 }
                 action("Void A&uthorize")
                 {
                     Caption = 'Void A&uthorize';

                     trigger OnAction()
                     begin
                         Void;
                     end;
                 }*/
            }
            group("P&osting")
            {
                Caption = '&Validation';
                action("Test Report")
                {
                    ApplicationArea = all;
                    Caption = 'Impression test';
                    Ellipsis = true;
                    Image = TestReport;

                    trigger OnAction()
                    begin
                        ReportPrint.PrintSalesHeader(Rec);
                    end;
                }
                action("P&ost")
                {
                    ApplicationArea = all;
                    Caption = '&Valider';
                    Ellipsis = true;
                    Image = Post;

                    ShortCutKey = 'F9';

                    trigger OnAction()
                    var
                        PurchaseHeader: Record "Purchase Header";
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                        CduReleadoc: Codeunit "Prepayment Mgt.";
                    begin
                        //GL2024  IF ApprovalMgt.PrePostApprovalCheck(Rec, PurchaseHeader) THEN BEGIN
                        IF ApprovalMgt.PrePostApprovalCheckSales(rec) and ApprovalMgt.PrePostApprovalCheckPurch(PurchaseHeader) then BEGIN
                            IF CduReleadoc.TestSalesPrepayment(Rec) THEN
                                ERROR(STRSUBSTNO(Text001, REC."Document Type", REC."No."))
                            ELSE BEGIN
                                IF CduReleadoc.TestSalesPayment(Rec) THEN
                                    ERROR(STRSUBSTNO(Text002, REC."Document Type", REC."No."))
                                ELSE BEGIN
                                    //#8742
                                    REC.TESTFIELD("Invoicing Method", REC."Invoicing Method"::Direct);
                                    //#8742//
                                    //PROJET_FACT
                                    CODEUNIT.RUN(CODEUNIT::"Sales-Post (Yes/No)", Rec);
                                    CurrPage.UPDATE(FALSE);
                                    //PROJET_FACT//
                                END;
                            END;
                        END;
                    end;
                }
                action("Post and &Print")
                {
                    ApplicationArea = all;
                    Caption = 'Valider et i&mprimer';
                    Ellipsis = true;
                    Image = PostPrint;

                    ShortCutKey = 'Maj+F9';

                    trigger OnAction()
                    var
                        PurchaseHeader: Record "Purchase Header";
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                        CduReleadoc: Codeunit "Prepayment Mgt.";
                    begin
                        //GL2024    IF ApprovalMgt.PrePostApprovalCheck(Rec, PurchaseHeader) THEN BEGIN
                        IF ApprovalMgt.PrePostApprovalCheckSales(rec) and ApprovalMgt.PrePostApprovalCheckPurch(PurchaseHeader) then BEGIN
                            IF CduReleadoc.TestSalesPrepayment(Rec) THEN
                                ERROR(STRSUBSTNO(Text001, REC."Document Type", REC."No."))
                            ELSE BEGIN
                                IF CduReleadoc.TestSalesPayment(Rec) THEN
                                    ERROR(STRSUBSTNO(Text002, REC."Document Type", REC."No."))
                                ELSE BEGIN
                                    //PROJET_FACT
                                    REC.TESTFIELD("Invoicing Method", REC."Invoicing Method"::Direct);
                                    CODEUNIT.RUN(CODEUNIT::"Sales-Post + Print", Rec);
                                    CurrPage.UPDATE(FALSE);
                                    //PROJET_FACT//
                                END;
                            END;
                        END;
                    end;
                }
                action("Post &Batch")
                {
                    ApplicationArea = all;
                    Caption = 'Valider par l&ot';
                    Ellipsis = true;
                    Image = PostBatch;

                    trigger OnAction()
                    begin
                        //PROJET_FACT
                        IF REC."Invoicing Method" = REC."Invoicing Method"::Direct THEN
                            //PROJET_FACT//
                            REPORT.RUNMODAL(REPORT::"Batch Post Sales Invoices", TRUE, TRUE, Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                separator(separator15)
                {
                }
                group("Prepa&yment")
                {
                    Caption = 'Acom&pte';
                    Visible = false;
                    action("Prepayment &Test Report")
                    {
                        ApplicationArea = all;
                        Caption = 'Impression &test acompte';
                        Ellipsis = true;

                        trigger OnAction()
                        begin
                            ReportPrint.PrintSalesHeaderPrepmt(Rec);
                        end;
                    }
                    action("Post Prepayment &Invoice")
                    {
                        ApplicationArea = all;
                        Caption = 'Valider &facture acompte';
                        Ellipsis = true;

                        trigger OnAction()
                        var
                            PurchaseHeader: Record "Purchase Header";
                            SalesPostYNPrepmt: Codeunit "Sales-Post Prepayment (Yes/No)";
                        begin
                            //GL2024    IF ApprovalMgt.PrePostApprovalCheck(Rec, PurchaseHeader) THEN
                            IF ApprovalMgt.PrePostApprovalCheckSales(rec) and ApprovalMgt.PrePostApprovalCheckPurch(PurchaseHeader) then
                                SalesPostYNPrepmt.PostPrepmtInvoiceYN(Rec, FALSE);
                        end;
                    }
                    action("Post and Print Prepmt. Invoic&e")
                    {
                        ApplicationArea = all;
                        Caption = 'Valider et imprimer factur&e acompte';
                        Ellipsis = true;

                        trigger OnAction()
                        var
                            PurchaseHeader: Record "Purchase Header";
                            SalesPostYNPrepmt: Codeunit "Sales-Post Prepayment (Yes/No)";
                        begin
                            //GL2024   IF ApprovalMgt.PrePostApprovalCheck(Rec, PurchaseHeader) THEN
                            IF ApprovalMgt.PrePostApprovalCheckSales(rec) and ApprovalMgt.PrePostApprovalCheckPurch(PurchaseHeader) then
                                SalesPostYNPrepmt.PostPrepmtInvoiceYN(Rec, TRUE);
                        end;
                    }
                    action("Post Prepayment &Credit Memo")
                    {
                        ApplicationArea = all;
                        Caption = 'Valider &avoir acompte';
                        Ellipsis = true;

                        trigger OnAction()
                        var
                            PurchaseHeader: Record "Purchase Header";
                            SalesPostYNPrepmt: Codeunit "Sales-Post Prepayment (Yes/No)";
                        begin
                            //GL2024     IF ApprovalMgt.PrePostApprovalCheck(Rec, PurchaseHeader) THEN
                            IF ApprovalMgt.PrePostApprovalCheckSales(rec) and ApprovalMgt.PrePostApprovalCheckPurch(PurchaseHeader) then
                                SalesPostYNPrepmt.PostPrepmtCrMemoYN(Rec, FALSE);
                        end;
                    }
                    action("Post and Print Prepmt. Cr. Mem&o")
                    {
                        ApplicationArea = all;
                        Caption = 'Valider et imprimer av&oir acompte';
                        Ellipsis = true;

                        trigger OnAction()
                        var
                            PurchaseHeader: Record "Purchase Header";
                            SalesPostYNPrepmt: Codeunit "Sales-Post Prepayment (Yes/No)";
                        begin
                            //GL2024  IF ApprovalMgt.PrePostApprovalCheck(Rec, PurchaseHeader) THEN
                            IF ApprovalMgt.PrePostApprovalCheckSales(rec) and ApprovalMgt.PrePostApprovalCheckPurch(PurchaseHeader) then
                                SalesPostYNPrepmt.PostPrepmtCrMemoYN(Rec, TRUE);
                        end;
                    }
                }
            }
            group("&Print")
            {
                Caption = 'Im&primer';
                action("Order Confirmation")
                {
                    ApplicationArea = all;
                    Caption = 'Confirmation de commande';
                    Ellipsis = true;
                    Image = Print;

                    trigger OnAction()
                    begin
                        DocPrint.PrintSalesOrder(Rec, Usage::"Order Confirmation");
                    end;
                }
                action(Commande)
                {
                    ApplicationArea = all;
                    Caption = 'Commande';
                    Image = Print;

                    trigger OnAction()
                    begin
                        // >> HJ DSFT 10-10-2012
                        IF REC.Status <> REC.Status::Released THEN ERROR(Text003);
                        RecSalesHeader.SETRANGE("Document Type", REC."Document Type");
                        RecSalesHeader.SETRANGE("No.", REC."No.");
                        REPORT.RUNMODAL(REPORT::"Bon Commande Vente", TRUE, TRUE, RecSalesHeader);
                        // >> HJ DSFT 10-10-2012
                        // STD HJ DSFT 10-10-2012 DocPrint.PrintPurchHeader(Rec);
                    end;
                }
                action("Work Order")
                {
                    ApplicationArea = all;
                    Caption = 'Ordre de fabrication';
                    Ellipsis = true;
                    Image = Print;

                    trigger OnAction()
                    begin
                        DocPrint.PrintSalesOrder(Rec, Usage::"Work Order");
                    end;
                }
                action(Proforma)
                {
                    ApplicationArea = all;
                    Caption = 'Proforma';
                    Image = Print;

                    trigger OnAction()
                    var
                        lSalesInvoiceHeader: Record "Sales Invoice Header";
                    begin
                        //+REF+INVOICE
                        lSalesInvoiceHeader.SETRANGE("Print Document Type", lSalesInvoiceHeader."Print Document Type"::Order);
                        lSalesInvoiceHeader.SETRANGE("No.", REC."No.");
                        lSalesInvoiceHeader.PrintRecords(TRUE);
                        //+REF+INVOICE//
                    end;
                }
                action("Pre-Invoice")
                {
                    ApplicationArea = all;
                    Caption = 'Pré-facture';
                    Image = Print;

                    trigger OnAction()
                    var
                        lSalesInvoiceHeader: Record "Sales Invoice Header";
                    begin
                        //+REF+INVOICE
                        lSalesInvoiceHeader.SETRANGE("Print Document Type", lSalesInvoiceHeader."Print Document Type"::"Invoice Request");
                        lSalesInvoiceHeader.SETRANGE("No.", REC."No.");
                        lSalesInvoiceHeader.PrintRecords(TRUE);
                        //+REF+INVOICE//
                    end;
                }
            }
            /*GL2024   action(SalesHistoryBtn)
               {
                   ApplicationArea = all;
                   Caption = 'Sales H&istory';
                   Enabled = SalesHistoryBtnEnable;
                   Promoted = true;
                   PromotedCategory = Process;

                   trigger OnAction()
                   begin
                       //DYS action obsolet
                       // SalesInfoPaneMgt.LookupCustSalesHistory(Rec, REC."Bill-to Customer No.", TRUE);
                   end;
               }
               action("&Avail. Credit")
               {
                   ApplicationArea = all;
                   Caption = '&Avail. Credit';
                   Promoted = true;
                   PromotedCategory = Process;

                   trigger OnAction()
                   begin
                       //DYS action obsolet
                       // SalesInfoPaneMgt.LookupAvailCredit(REC."Bill-to Customer No.");
                   end;
               }
               action(SalesHistoryStn)
               {
                   ApplicationArea = all;
                   Caption = 'Sales Histor&y';
                   Enabled = SalesHistoryStnEnable;
                   Promoted = true;
                   PromotedCategory = Process;

                   trigger OnAction()
                   begin
                       //DYS action obsolet
                       // SalesInfoPaneMgt.LookupCustSalesHistory(Rec, REC."Sell-to Customer No.", FALSE);
                   end;
               }
               action("&Contacts")
               {
                   ApplicationArea = all;
                   Caption = '&Contacts';
                   Promoted = true;
                   PromotedCategory = Process;

                   trigger OnAction()
                   begin
                       //DYS action obsolet
                       // SalesInfoPaneMgt.LookupContacts(Rec);
                   end;
               }*/
            action(Actualiser)
            {
                ApplicationArea = all;
                Caption = 'Actualiser';
                image = UpdateDescription;


                trigger OnAction()
                begin
                    CurrPage.SalesLines.PAGE.EDITABLE(TRUE);

                    RecSalesLine.RESET;
                    RecSalesLine.SETRANGE(RecSalesLine."Document No.", REC."No.");
                    IF RecSalesLine.FINDFIRST THEN
                        REPEAT
                            RecSalesLine."Qty. to Ship" := 0;
                            RecSalesLine."Outstanding Qty. (Base)" := RecSalesLine."Outstanding Quantity";
                            RecSalesLine.MODIFY;
                        UNTIL RecSalesLine.NEXT = 0;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        CurrPage.SalesLines.PAGE.wPassEnt(Rec);
        IF REC."No." <> xRec."No." THEN BEGIN
            wMarked := FALSE;
            CurrPage.SalesLines.PAGE.SetAfterGet(PresentationCode);
        END;

        IF (REC."Project Manager" <> '') AND Contact.GET(REC."Project Manager") THEN
            ProjectManagerName := Contact.Name
        ELSE
            ProjectManagerName := '';
        //POSTING_DESC
        wDescr := REC.wShowPostingDescription(REC."Posting Description");
        //POSTING_DESC//
        IF (REC."Sell-to Contact No." <> '') AND Contact.GET(REC."Sell-to Contact No.") THEN
            ContactName := Contact.GetSalutation(1, REC."Language Code")
        ELSE
            ContactName := '';

        //PROJET_FACT
        IF REC."Rider to Order No." <> '' THEN
            ActivateHeader(FALSE)
        ELSE BEGIN
            ActivateHeader(TRUE);
            //PROJET_FACT//
            IF REC."Job No." <> '' THEN BEGIN
                "Job Starting DateEditable" := FALSE;
                "Job Ending DateEditable" := FALSE;
            END
            ELSE BEGIN
                "Job Starting DateEditable" := TRUE;
                "Job Ending DateEditable" := TRUE;
            END;
            //PROJET_FACT
        END;
        //PROJET_FACT//
        // >> HJ SORO 05-01-2014
        /*     IF UserSetup.GET(UPPERCASE(USERID)) THEN BEGIN
                 IF UserSetup."Affaire Par Defaut" <> '' THEN REC.SETFILTER("Job No.", UserSetup."Affaire Par Defaut" + '*');
             END;
             // >> HJ SORO 05-01-2014
             OnAfterGetCurrRecord;
             //GL20224
             // Recherche param utilisateur de l'utilisateur connecté
             if UserSetup.Get(UserId) then
                 ModifierDétailMarché := UserSetup."Autoriser Modification Détail Marché"
             else
                 ModifierDétailMarché := false; // par défaut non modifiable
             //GL2024*/
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.UPDATE(TRUE);
        EXIT(REC.ConfirmDeletion);
    end;

    trigger OnInit()
    begin
        SalesHistoryStnEnable := TRUE;
        BillToCommentPictEnable := TRUE;
        SalesHistoryBtnEnable := TRUE;
        DescrEditable := TRUE;
        "Responsibility CenterEditable" := TRUE;
        "Review Base DateEditable" := TRUE;
        "Review Formula CodeEditable" := TRUE;
        "Contract TypeEditable" := TRUE;
        "VAT Bus. Posting GroupEditable" := TRUE;
        "Bill-to NameEditable" := TRUE;
        "Bill-to Customer No.Editable" := TRUE;
        "Payment Terms CodeEditable" := TRUE;
        "Payment Method CodeEditable" := TRUE;
        "Currency CodeEditable" := TRUE;
        "Prices Including VATEditable" := TRUE;
        "Project ManagerEditable" := TRUE;
        "Job DescriptionEditable" := TRUE;
        "Ship-to NameEditable" := TRUE;
        "Job No.Editable" := TRUE;
        "Ship-to CodeEditable" := TRUE;
        "Sell-to Customer NameEditable" := TRUE;
        "Sell-to Customer No.Editable" := TRUE;
        SalesCommentBtnEnable := TRUE;
        BillToCommentBtnEnable := TRUE;
        SellToCommentBtnEnable := TRUE;
        HelpEnable := TRUE;
        WorkFlowBtnEnable := TRUE;
        "Job Ending DateEditable" := TRUE;
        "Job Starting DateEditable" := TRUE;
        wSplashOpened := TRUE;
        wOpenSplash.OPEN(tOpenSplash);
        //wFormEditable := Currpage.EDITABLE;
        wFormEditable := TRUE;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        REC.CheckCreditMaxBeforeInsert;
        CurrPage.SalesLines.PAGE.wPassEnt(Rec);
        CurrPage.SalesLines.PAGE.SetAfterGet(PresentationCode);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        REC."Responsibility Center" := UserMgt.GetSalesFilter();
        REC."Order Type" := REC."Order Type"::" ";
        REC."Document Type" := REC."Document Type"::Order;
        ProjectManagerName := '';
        ContactName := '';
        REC."Commande Affaire" := TRUE;
        OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage()
    var
        lMaskMgt: Codeunit "Mask Management";
        lSalesHeader: Record "Sales Header";
        "//HJ": Integer;
        SousAffectation: Record "Affectation Marche";
        LSalesLine: Record "Sales Line";
    begin
        IF wSplashOpened THEN BEGIN
            wSplashOpened := FALSE;
            wOpenSplash.CLOSE;
            //+WKF+ CW 04/08/02 +Workflow Button
            WorkFlowBtnEnable := TRUE;
            HelpEnable := TRUE;
            SellToCommentBtnEnable := TRUE;
            BillToCommentBtnEnable := TRUE;
            SalesCommentBtnEnable := TRUE;
        END;

        //Inutile ? et empêche le lien livraison directe SETRANGE("No.");
        IF UserMgt.GetSalesFilter() <> '' THEN BEGIN
            REC.FILTERGROUP(2);
            REC.SETRANGE("Responsibility Center", UserMgt.GetSalesFilter());
            REC.FILTERGROUP(0);
        END;

        //+ONE+
        //SETRANGE("Date Filter",0D,WORKDATE - 1);
        //+ONE+//

        //#8686
        IF NOT lSalesHeader.GET(REC."Document Type", REC."No.") THEN
            IF REC.FIND('-') THEN;
        //#8686//
        //Currpage.SalesLines.PAGE.SetUpdateAllowed(wFormEditable);
        NavibatSetup.GET2;

        ShowExtendedText := TRUE;

        //MASK
        lMaskMgt.SalesHeader(Rec);
        //MASK//
        // Remplir Sous Affectation HJ Soro 11-06-2016
        LSalesLine.SETRANGE("Document Type", REC."Document Type");
        LSalesLine.SETRANGE("Document No.", REC."No.");
        LSalesLine.SETRANGE(Type, LSalesLine.Type::Resource);
        IF LSalesLine.FINDFIRST THEN
            REPEAT
                SousAffectation.Code := LSalesLine."No.";
                SousAffectation.Description := LSalesLine.Description;
                SousAffectation.Marche := REC."Job No.";
                IF NOT SousAffectation.INSERT THEN SousAffectation.MODIFY;
            UNTIL LSalesLine.NEXT = 0;
        /*   REC."Date Debut Decompte" := 0D;
           REC."Date Fin Decompte" := 0D;
           REC.MODIFY;
           // Remplir Sous Affectation HJ Soro 11-06-2016
           // >> HJ SORO 05-01-2014
           IF UserSetup.GET(UPPERCASE(USERID)) THEN BEGIN
               IF UserSetup."Affaire Par Defaut" <> '' THEN REC.SETFILTER("Job No.", UserSetup."Affaire Par Defaut" + '*');
           END;
           // >> HJ SORO 05-01-2014

           //GL20224
           // Recherche param utilisateur de l'utilisateur connecté
           if UserSetup.Get(UserId) then
               ModifierDétailMarché := UserSetup."Autoriser Modification Détail Marché"
           else
               ModifierDétailMarché := false; // par défaut non modifiable*/
        //GL2024
    end;

    var
        Text000: Label 'Impossible d''exécuter cette fonction quand vous êtes en mode visualisation seule.';
        CopySalesDoc: Report "Copy Sales Document";
        MoveNegSalesLines: Report "Move Negative Sales Lines";
        ApprovalMgt: Codeunit "Approvals Mgmt.";
        ReportPrint: Codeunit "Test Report-Print";
        DocPrint: Codeunit "Document-Print";
        ArchiveManagement: Codeunit ArchiveManagement;
        SalesInfoPaneMgt: Codeunit "Sales Info-Pane Management";
        SalesSetup: Record "Sales & Receivables Setup";
        ChangeExchangeRate: Page "Change Exchange Rate";
        UserMgt: Codeunit "User Setup Management";
        Usage: Option "Order Confirmation","Work Order";
        Text001: Label '%1 %2 contient des acomptes non enregistrés.';
        Text002: Label 'Il existe des factures acompte impayées liées à %1 %2.';
        Contact: Record Contact;
        //GL2024  AddressContributors: Page 8004022;
        MoveOption: Option Same,Left,Right,Up,Down;
        OldRec: Record "Sales Header";
        PresentationCode: Code[10];
        ProjectManagerName: Text[30];
        ContactName: Text[250];
        SupplyOrderMgt: Codeunit "Reordering Req. Management";
        wDescr: Text[100];
        NavibatSetup: Record NavibatSetup;
        TextUpdate: Label 'Calcul en cours...';
        Fenetre: Dialog;
        ShowLevel: Integer;
        ShowExtendedText: Boolean;
        wMarked: Boolean;
        wSplashOpened: Boolean;
        wOpenSplash: Dialog;
        tOpenSplash: Label 'Ouverture en cours...';
        wFormEditable: Boolean;
        "// VAr HJ DSFT": Integer;
        RecSalesHeader: Record "Sales Header";

        Text003: Label 'Veuillez Lancer La Commande Avant Impression';
        CduSalesPost: Codeunit "Sales-Post";
        CduSalesPost2: Codeunit SalesPostEvent;
        UserSetup: Record "User Setup";
        Text004: Label 'Voulez vous remettre a zero les avancements de productions avant la nouvelle saisie ?';
        RecSalesLine: Record "Sales Line";

        "Job Starting DateEditable": Boolean;

        "Job Ending DateEditable": Boolean;

        WorkFlowBtnEnable: Boolean;

        HelpEnable: Boolean;

        SellToCommentBtnEnable: Boolean;

        BillToCommentBtnEnable: Boolean;

        SalesCommentBtnEnable: Boolean;
        SalesLinesYPos: Integer;
        TabControlYPos: Integer;
        TabControlHeight: Integer;
        SalesLinesHeight: Integer;

        "Sell-to Customer No.Editable": Boolean;

        "Sell-to Customer NameEditable": Boolean;

        "Ship-to CodeEditable": Boolean;

        "Job No.Editable": Boolean;

        "Ship-to NameEditable": Boolean;

        "Job DescriptionEditable": Boolean;

        "Project ManagerEditable": Boolean;

        "Prices Including VATEditable": Boolean;

        "Currency CodeEditable": Boolean;

        "Payment Method CodeEditable": Boolean;

        "Payment Terms CodeEditable": Boolean;

        "Bill-to Customer No.Editable": Boolean;

        "Bill-to NameEditable": Boolean;

        "VAT Bus. Posting GroupEditable": Boolean;

        "Contract TypeEditable": Boolean;

        "Review Formula CodeEditable": Boolean;

        "Review Base DateEditable": Boolean;

        "Responsibility CenterEditable": Boolean;

        DescrEditable: Boolean;

        SalesHistoryBtnEnable: Boolean;

        BillToCommentPictEnable: Boolean;

        SalesHistoryStnEnable: Boolean;
        [InDataSet]
        ModifierDétailMarché: Boolean;
    // Text19070588: Label 'Sell-to Customer';
    //  Text19069283: Label 'Bill-to Customer';


    procedure UpdateAllowed(): Boolean
    begin
        IF wFormEditable = FALSE THEN
            ERROR(Text000);
        EXIT(TRUE);
    end;

    local procedure UpdateInfoPanel()
    var
        DifferSellToBillTo: Boolean;
    begin
        DifferSellToBillTo := REC."Sell-to Customer No." <> REC."Bill-to Customer No.";
        SalesHistoryBtnEnable := DifferSellToBillTo;
        BillToCommentPictEnable := DifferSellToBillTo;
        BillToCommentBtnEnable := DifferSellToBillTo;
        //DYS FONCTION obsolet
        // SalesHistoryStnEnable := SalesInfoPaneMgt.DocExist(Rec, REC."Sell-to Customer No.");
        // IF DifferSellToBillTo THEN
        //   SalesHistoryBtnEnable := SalesInfoPaneMgt.DocExist(Rec, REC."Bill-to Customer No.")
    end;

    local procedure ApproveCalcInvDisc()
    begin
        CurrPage.SalesLines.PAGE.ApproveCalcInvDisc;
    end;


    procedure ActivateHeader(Active: Boolean)
    begin
        "Sell-to Customer No.Editable" := Active;
        "Sell-to Customer NameEditable" := Active;
        "Ship-to CodeEditable" := Active;
        "Job No.Editable" := Active;
        "Ship-to NameEditable" := Active;
        "Job Starting DateEditable" := Active;
        "Job Ending DateEditable" := Active;
        "Job DescriptionEditable" := Active;
        "Project ManagerEditable" := Active;
        "Prices Including VATEditable" := Active;
        "Currency CodeEditable" := Active;
        "Payment Method CodeEditable" := Active;
        "Payment Terms CodeEditable" := Active;
        "Bill-to Customer No.Editable" := Active;
        "Bill-to NameEditable" := Active;
        "VAT Bus. Posting GroupEditable" := Active;
        "Contract TypeEditable" := Active;
        "Review Formula CodeEditable" := Active;
        "Review Base DateEditable" := Active;
        "Responsibility CenterEditable" := Active;
        DescrEditable := Active;
    end;

    local procedure SelltoCustomerNoOnAfterValidat()
    begin
        CurrPage.UPDATE;
    end;

    local procedure ProjectManagerOnAfterValidate()
    begin
        IF (REC."Project Manager" <> xRec."Project Manager") AND (REC."Project Manager" <> '') THEN
            IF Contact.GET(REC."Project Manager") THEN
                ProjectManagerName := Contact.Name
            ELSE
                ProjectManagerName := '';
        IF REC."Project Manager" = '' THEN
            ProjectManagerName := '';
    end;

    local procedure PricesIncludingVATOnAfterValid()
    begin
        CurrPage.UPDATE;
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure Prepayment37OnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure PresentationCodeOnAfterValidat()
    begin
        CurrPage.SalesLines.PAGE.ShowColumns(PresentationCode);
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        REC.SETRANGE("Document Type");
    end;

    local procedure SelltoContactNoOnDeactivate()
    begin
        IF REC."Sell-to Contact No." <> xRec."Sell-to Contact No." THEN
            IF Contact.GET(REC."Sell-to Contact No.") THEN
                ContactName := Contact.GetSalutation(1, REC."Language Code");
        //#4250
        CurrPage.UPDATE;
        //#4250//
    end;
}

