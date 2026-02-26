page 50303 "Purchase List >=15000"
{
    // //PROJET GESWAY 29/03/04 Ajout N° chantier,"Order Date","Posting Description"
    // //MISC CW 08/06/06 +"Requested Receipt Date", "Promised Receipt Date", "Vendor Order No."
    // //MASK IMA 02/01/06 Le groupe confidentialité
    // //+ABO+ CW 11/03/09 Card.OnPush runform Subscription
    // //+REF+ACHAT_SUIVI GESWAY 01/02/06 Ajout des champs "Expiration Date" et "Vendor Shipment No."
    //                    GD 24/04/06 Ajout des filtres Affaire, preneur d'ordre & date de prochaine relance en entête
    //                           Ajout colonne date prochaine relance
    //                           Ajout boutton menu Créer interaction
    //                           Ajout boutton menu Ligne

    Caption = 'Purchase List >=15000';
    ApplicationArea = all;
    UsageCategory = lists;
    DataCaptionFields = "Document Type";
    Editable = true;
    PageType = List;
    SourceTable = "Purchase Header";
    SourceTableView = WHERE(Status = FILTER(<> Archived), "Amount Including VAT" = FILTER(>= 15000), "Document Type" = CONST(Order), Contrat = CONST(false));

    layout
    {
        area(content)
        {
            group(Filters1)
            {
                Caption = 'Filters';
                field(gBuyFromVendorNo; gBuyFromVendorNo)
                {
                    ApplicationArea = all;
                    Caption = 'Buy-from Vendor No.';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        lVendor: Record Vendor;
                    begin
                        //ACHAT_SUIVI
                        lVendor.FIND('-');
                        IF PAGE.RUNMODAL(PAGE::"Vendor List", lVendor) = ACTION::LookupOK THEN
                            IF gBuyFromVendorNo = '' THEN
                                gBuyFromVendorNo := STRSUBSTNO('%1', lVendor."No.")
                            ELSE
                                gBuyFromVendorNo += STRSUBSTNO('|%1', lVendor."No.");
                        Filters;
                        CurrPage.UPDATE(FALSE);
                        //ACHAT_SUIVI//
                    end;

                    trigger OnValidate()
                    begin
                        //ACHAT_SUIVI
                        Filters;
                        //ACHAT_SUIVI//
                        gBuyFromVendorNoOnAfterValidat;
                    end;
                }
                field(gDateNextFollowUpFilter; gDateNextFollowUpFilter)
                {
                    ApplicationArea = all;
                    Caption = 'Next Date Follow-Up';

                    trigger OnValidate()
                    begin
                        //ACHAT_SUIVI
                        Filters;
                        //ACHAT_SUIVI//
                        gDateNextFollowUpFilterOnAfter;
                    end;
                }
                field(wJobFilter; wJobFilter)
                {
                    ApplicationArea = all;
                    Caption = 'Job No.';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        lJob: Record Job;
                    begin
                        //ACHAT_SUIVI
                        lJob.FIND('-');
                        IF PAGE.RUNMODAL(PAGE::"Job List", lJob) = ACTION::LookupOK THEN
                            IF wJobFilter = '' THEN
                                wJobFilter := STRSUBSTNO('%1', lJob."No.")
                            ELSE
                                wJobFilter += STRSUBSTNO('|%1', lJob."No.");
                        Filters;
                        CurrPage.UPDATE(FALSE);
                        //ACHAT_SUIVI//
                    end;

                    trigger OnValidate()
                    begin
                        //ACHAT_SUIVI
                        Filters;
                        //ACHAT_SUIVI//
                        wJobFilterOnAfterValidate;
                    end;
                }
            }
            repeater(content1)
            {
                Editable = false;
                ShowCaption = false;
                field("Order Date"; rec."Order Date")
                {
                    ApplicationArea = all;
                }
                field("Posting Date1"; rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                }
                field("Buy-from Vendor No."; rec."Buy-from Vendor No.")
                {
                    ApplicationArea = all;
                }
                field("Your Reference"; rec."Your Reference")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Price Offer Amount1"; rec."Price Offer Amount")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = TRUE;

                }
                field("Amount Including VAT1"; rec."Amount Including VAT")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = TRUE;

                }
                field("Order Address Code"; rec."Order Address Code")
                {
                    ApplicationArea = all;
                    Visible = false;

                }
                field("User ID"; rec."User ID")
                {
                    ApplicationArea = all;
                }
                field("Buy-from Vendor Name"; rec."Buy-from Vendor Name")
                {
                    ApplicationArea = all;
                }
                field("N° Demande d'achat"; rec."N° Demande d'achat")
                {
                    ApplicationArea = all;
                }
                field("N° DA Chantier"; rec."N° DA Chantier")
                {
                    ApplicationArea = all;
                }
                field("Vendor Cr. Memo No."; rec."Vendor Cr. Memo No.")
                {
                    ApplicationArea = all;
                }
                field("Facture En Instance"; rec."Facture En Instance")
                {
                    ApplicationArea = all;
                }
                /*  field("Vendor Quote No."; rec."Vendor Quote No.")
                  { ApplicationArea = all;
                      Caption = 'N° Commande SAGE';
                  }*/
                field("Vendor Shipment No.1"; rec."Vendor Shipment No.")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = TRUE;
                    ;
                }
                field(Engin; rec.Engins)
                {
                    ApplicationArea = all;
                }
                field("Description Engin"; rec."Description Engins")
                {
                    ApplicationArea = all;
                }
                field("Statut Commande"; rec."Statut Commande")
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                    StyleExpr = TRUE;

                }
                field("Shipment Remark"; rec."Shipment Remark")
                {
                    ApplicationArea = all;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = all;
                }
                field("Pay-to Address 2"; rec."Pay-to Address 2")
                {
                    ApplicationArea = all;
                }
                field("Pay-to Name 2"; rec."Pay-to Name 2")
                {
                    ApplicationArea = all;
                }
                field("Vendor Shipment No."; rec."Vendor Shipment No.")
                {
                    ApplicationArea = all;
                }
                field(wDescr; wDescr)
                {
                    ApplicationArea = all;
                    Caption = 'Posting Description';

                }
                field("Requested Receipt Date"; rec."Requested Receipt Date")
                {
                    ApplicationArea = all;
                }
                field("Promised Receipt Date1"; rec."Promised Receipt Date")
                {
                    ApplicationArea = all;
                }
                /*   field("Promised Receipt Date"; rec."Promised Receipt Date")
                   {
                   }*/
                field("Vendor Order No."; rec."Vendor Order No.")
                {
                    ApplicationArea = all;
                }
                field("Vendor Authorization No."; rec."Vendor Authorization No.")
                {
                    ApplicationArea = all;
                }
                field("Buy-from Post Code"; rec."Buy-from Post Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Buy-from Country/Region Code"; rec."Buy-from Country/Region Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Buy-from Contact"; rec."Buy-from Contact")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Pay-to Vendor No."; rec."Pay-to Vendor No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Pay-to Name"; rec."Pay-to Name")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Pay-to Post Code"; rec."Pay-to Post Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Pay-to Country/Region Code"; rec."Pay-to Country/Region Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Pay-to Contact"; rec."Pay-to Contact")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Ship-to Code"; rec."Ship-to Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Ship-to Name"; rec."Ship-to Name")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Ship-to Post Code"; rec."Ship-to Post Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Ship-to Country/Region Code"; rec."Ship-to Country/Region Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Ship-to Contact"; rec."Ship-to Contact")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Date Next Follow-Up"; rec."Date Next Follow-Up")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Job No."; rec."Job No.")
                {
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        DimMgt.LookupDimValueCodeNoUpdate(1);
                    end;
                }
                field("Shortcut Dimension 2 Code"; rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        DimMgt.LookupDimValueCodeNoUpdate(2);
                    end;
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = all;
                    Visible = true;
                }
                field("Purchaser Code1"; rec."Purchaser Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Assigned User ID"; rec."Assigned User ID")
                {
                    ApplicationArea = all;
                }
                field("Purchaser Code"; rec."Purchaser Code")
                {
                    ApplicationArea = all;
                }
                field(Amount; rec.Amount)
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Price Offer Amount"; rec."Price Offer Amount")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Amount Including VAT"; rec."Amount Including VAT")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Currency Code"; rec."Currency Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
            }
            part("Sous-form. demande de prix"; "Sous-form. demande de prix")
            {
                ApplicationArea = all;
                Editable = false;
                SubPageLink = "Document No." = FIELD("No."), "Document Type" = FIELD("Document Type");
            }
        }
    }

    actions
    {
        area(Promoted)
        {
            group("&Line1")
            {
                Caption = '&Line';
                actionref(Card1; Card) { }

            }

            group("Create &Interact1")
            {
                Caption = 'Create &Interact';
                actionref("Buy-from Vendor1"; "Buy-from Vendor") { }
                actionref("Pay-to Vendor1"; "Pay-to Vendor") { }
            }
        }
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                Visible = false;
                action(Card)
                {
                    ApplicationArea = all;
                    Caption = 'Card';
                    Image = EditLines;
                    ShortCutKey = 'Maj+F5';

                    trigger OnAction()
                    begin
                        CASE rec."Document Type" OF
                            rec."Document Type"::Quote:
                                PAGE.RUN(PAGE::"Purchase Quote", Rec);
                            rec."Document Type"::"Blanket Order":
                                PAGE.RUN(PAGE::"Blanket Purchase Order", Rec);
                            rec."Document Type"::Order:
                                PAGE.RUN(PAGE::"Purchase Order", Rec);
                            rec."Document Type"::Invoice:
                                PAGE.RUN(PAGE::"Purchase Invoice", Rec);
                            rec."Document Type"::"Return Order":
                                PAGE.RUN(PAGE::"Purchase Return Order", Rec);
                            rec."Document Type"::"Credit Memo":
                                PAGE.RUN(PAGE::"Purchase Credit Memo", Rec);
                        //+ABO+
                        /*  GL2024 rec."Document Type"::Subscription:
                               PAGE.RUN(PAGE::"Purchase Contract", Rec);*/
                        //+ABO+
                        END;
                    end;
                }
                /*GL2024 action("Update Next Reminder Date")
                 {
                     Caption = 'Update Next Reminder Date';
                     //DYS page addon non migrer
                     // RunObject = Page 8001459;
                     //                 RunPageLink = "No."=FIELD("No."), "Document Type"=FIELD("Document Type");
                 }*/
                /* GL2024 NAVIBAT action("Update Next Reminder Date")
                  { ApplicationArea = all;Caption = 'Update Next Reminder Date';
                      RunObject = Page 8001459;
                                      RunPageLink = No.=FIELD(No.), Document Type=FIELD(Document Type);
                  }*/
            }
            group("Create &Interact")
            {
                Caption = 'Create &Interact';
                Visible = false;
                action("Buy-from Vendor")
                {
                    ApplicationArea = all;
                    Caption = 'Buy-from Vendor';

                    trigger OnAction()
                    begin
                        //ACHAT_SUIVI
                        rec.fCreateInteraction(rec."Buy-from Vendor No.", rec."No.");
                        //ACHAT_SUIVI//
                    end;
                }
                action("Pay-to Vendor")
                {
                    ApplicationArea = all;
                    Caption = 'Pay-to Vendor';


                    trigger OnAction()
                    begin
                        //ACHAT_SUIVI
                        rec.fCreateInteraction(rec."Pay-to Vendor No.", rec."No.");
                        //ACHAT_SUIVI//
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //POSTING_DESC
        wDescr := rec.wShowPostingDescription(rec."Posting Description");
        //POSTING_DESC//
        // >> HJ DSFT 17-07-2013
        BlnNonLivré := FALSE;
        BlnTotalementLivré := FALSE;
        BlnPartiellementLivé := FALSE;
        RecPurchaseLine.RESET;
        RecPurchaseLine.SETRANGE("Document Type", rec."Document Type");
        RecPurchaseLine.SETRANGE("Document No.", rec."No.");
        RecPurchaseLine.SETRANGE(Type, RecPurchaseLine.Type::Item);
        RecPurchaseLine.SETFILTER("Quantity Received", '<>%1', 0);
        IF NOT RecPurchaseLine.FINDFIRST THEN BEGIN
            BlnNonLivré := TRUE;
            rec."Statut Commande" := 1;
        END;


        RecPurchaseLine.RESET;
        RecPurchaseLine.SETRANGE("Document Type", rec."Document Type");
        RecPurchaseLine.SETRANGE("Document No.", rec."No.");
        RecPurchaseLine.SETRANGE(Type, RecPurchaseLine.Type::Item);
        RecPurchaseLine.SETFILTER("Quantity Received", '<>%1', 0);
        IF RecPurchaseLine.FINDFIRST THEN BEGIN
            BlnPartiellementLivé := TRUE;
            rec."Statut Commande" := 2;
        END;


        RecPurchaseLine.RESET;
        RecPurchaseLine.SETRANGE("Document Type", rec."Document Type");
        RecPurchaseLine.SETRANGE("Document No.", rec."No.");
        RecPurchaseLine.SETFILTER("Outstanding Quantity", '<>%1', 0);
        IF NOT RecPurchaseLine.FINDFIRST THEN BEGIN
            BlnTotalementLivré := TRUE;
            rec."Statut Commande" := 3;
        END;

        // >> HJ DSFT 17-07-2013
    end;

    trigger OnOpenPage()
    var
        lMaskMgt: Codeunit "Mask Management";
    begin
        //MASK
        lMaskMgt.PurchaseHeader(Rec);
        //MASK//
        // >> HJ SORO 13-01-2015
        IF UserSetup.GET(UPPERCASE(USERID)) THEN;
        // IF UserSetup."Filtre Magasin" <> '' THEN
        //     IF InventorySetup.GET THEN
        //         IF InventorySetup."Appliquer Filtre Magasin" THEN rec.SETRANGE("Location Code", UserSetup."Filtre Magasin");
        // >> HJ SORO 13-01-2015
    end;

    var
        DimMgt: Codeunit DimensionManagement;
        wDescr: Text[100];
        wJobFilter: Text[50];
        gBuyFromVendorNo: Text[50];
        gDateNextFollowUpFilter: Date;
        RecPurchaseLine: Record "Purchase Line";
        "BlnNonLivré": Boolean;
        "BlnTotalementLivré": Boolean;
        "BlnPartiellementLivé": Boolean;
        InventorySetup: Record "Inventory Setup";
        UserSetup: Record "User Setup";


    procedure Filters()
    begin
        //ACHAT_SUIVI
        IF gBuyFromVendorNo = '' THEN
            rec.SETRANGE("Buy-from Vendor No.")
        ELSE
            rec.SETRANGE("Buy-from Vendor No.", gBuyFromVendorNo);

        IF gDateNextFollowUpFilter <> 0D THEN BEGIN
            rec.SETFILTER("Date Next Follow-Up", '<>%1&<=%2', 0D, gDateNextFollowUpFilter);
            rec.SETRANGE("Completely Received", FALSE);
        END ELSE
            rec.SETRANGE("Date Next Follow-Up");
        //ACHAT_SUIVI//
    end;

    local procedure gBuyFromVendorNoOnAfterValidat()
    begin
        //ACHAT_SUIVI
        CurrPage.UPDATE(FALSE);
        //ACHAT_SUIVI//
    end;

    local procedure gDateNextFollowUpFilterOnAfter()
    begin
        //ACHAT_SUIVI
        CurrPage.UPDATE(FALSE);
        //ACHAT_SUIVI//
    end;

    local procedure wJobFilterOnAfterValidate()
    begin
        //ACHAT_SUIVI
        CurrPage.UPDATE(FALSE);
        //ACHAT_SUIVI//
    end;
}

