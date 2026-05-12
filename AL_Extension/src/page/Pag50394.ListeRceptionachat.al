page 50394 "Liste Réception achat"
{
    // new page
    Caption = 'Liste Réception achat';
    RefreshOnActivate = true;
    Editable = false;
    PageType = List;
    SourceTableView = WHERE("Document Type" = FILTER(Order));
    SourceTable = "Purchase Header";
    CardPageId = "Purchase Receipt";

    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group("Filters ")
            {
                Visible = false;
                Caption = 'Filters';

                field("Buy-from Vendor No.2"; gBuyFromVendorNo)
                {
                    Editable = true;

                    Caption = 'N° preneur d''ordre';
                    ApplicationArea = all;
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

                        //ACHAT_SUIVI
                        CurrPage.UPDATE(FALSE);
                        //ACHAT_SUIVI//
                    end;
                }
                field("Next Date Follow-Up"; gDateNextFollowUpFilter)
                {
                    Editable = true;

                    Caption = 'A relancer au';
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin

                        //ACHAT_SUIVI
                        Filters;
                        //ACHAT_SUIVI//

                        //ACHAT_SUIVI
                        CurrPage.UPDATE(FALSE);
                        //ACHAT_SUIVI//
                    end;
                }
                /*  field("Job No."; wJobFilter)
                  {
                      Editable = true;
                      Caption = 'N° affaire';
                      ApplicationArea = all;
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

                          //ACHAT_SUIVI
                          CurrPage.UPDATE(FALSE);
                          //ACHAT_SUIVI//
                      end;
                  }*/
            }
            repeater(Control1)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the date when the purchase document was created.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the date when the posting of the purchase document will be recorded.';
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the name of the vendor who delivered the items.';
                }
                field("DTA Coding Line"; Rec."DTA Coding Line")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the DTA coding line for the purchase document.';

                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the ID of the user who created the purchase document.';
                }
                field("Order Address Code"; Rec."Order Address Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the order address of the related vendor.';
                    Visible = false;
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the name of the vendor who delivered the items.';
                }
                field("Job No."; Rec."Job No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the job number that is associated with the purchase document.';
                }
                field("N° Demande d'achat"; Rec."N° Demande d'achat")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the purchase request number that is associated with the purchase document.';

                }
                field("N° DA Chantier"; Rec."N° DA Chantier")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the job number that is associated with the purchase document.';
                }
                field("Vendor Shipment No."; Rec."Vendor Shipment No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the vendor shipment number that is associated with the purchase document.';
                }
                field(Engin; Rec.Engins)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the engine number that is associated with the purchase document.';
                }
                field("Description Engin"; Rec."Description Engins")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the description of the engine number that is associated with the purchase document.';
                }

                field("Statut Commande"; Rec."Statut Commande")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the status of the purchase order.';
                    Style = Attention;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the status of the purchase document.';
                }
                field("Observation 1"; Rec."Observation 1")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the first observation that is associated with the purchase document.';
                }
                field("Observation 2"; Rec."Observation 2")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the second observation that is associated with the purchase document.';
                }
                field("Observation 3"; Rec."Observation 3")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the third observation that is associated with the purchase document.';
                }
                field("Posting Description"; Rec."Posting Description")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the description of the purchase document.';
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the date when the items are requested to be received.';
                }
                field("Promised Receipt Date"; Rec."Promised Receipt Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the date when the items are promised to be received.';
                }
                field("Vendor Order No."; Rec."Vendor Order No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the vendor order number that is associated with the purchase document.';
                }

                field("Vendor Authorization No."; Rec."Vendor Authorization No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the identification number of a compensation agreement.';
                }
                // field("Job No."; Rec."Job No.")
                // {
                //     ApplicationArea = Basic, Suite;
                //     ToolTip = 'Specifies the job number that is associated with the purchase document.';
                // }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = Location;
                    ToolTip = 'Specifies a code for the location where you want the items to be placed when they are received.';
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies which purchaser is assigned to the vendor.';
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the ID of the user who is responsible for the document.';
                }
                field("Pay-to Address 2"; Rec."Pay-to Address 2")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the second line of the address of the vendor that you received the invoice from.';

                }
                field("Pay-to Name 2"; Rec."Pay-to Name 2")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the second line of the name of the vendor that you received the invoice from.';

                }
                field("Shipment Remark"; Rec."Shipment Remark")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the shipment remark that is associated with the purchase document.';
                }
                field("Buy-from Post Code"; Rec."Buy-from Post Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the post code of the vendor who delivered the items.';
                    Visible = false;
                }
                field("Buy-from Country/Region Code"; Rec."Buy-from Country/Region Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the city of the vendor who delivered the items.';
                    Visible = false;
                }
                field("Buy-from Contact"; Rec."Buy-from Contact")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the name of the contact person at the vendor who delivered the items.';
                    Visible = false;
                }
                field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of the vendor that you received the invoice from.';
                    Visible = false;
                }
                field("Pay-to Name"; Rec."Pay-to Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the name of the vendor who you received the invoice from.';
                    Visible = false;
                }
                field("Pay-to Post Code"; Rec."Pay-to Post Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the post code of the vendor that you received the invoice from.';
                    Visible = false;
                }
                field("Pay-to Country/Region Code"; Rec."Pay-to Country/Region Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the country/region code of the address.';
                    Visible = false;
                }
                field("Pay-to Contact"; Rec."Pay-to Contact")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the name of the person to contact about an invoice from this vendor.';
                    Visible = false;
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a code for an alternate shipment address if you want to ship to another address than the one that has been entered automatically. This field is also used in case of drop shipment.';
                    Visible = false;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the name of the customer at the address that the items are shipped to.';
                    Visible = false;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the postal code of the address that the items are shipped to.';
                    Visible = false;
                }
                field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the country/region code of the address that the items are shipped to.';
                    Visible = false;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the name of the contact person at the address that the items are shipped to.';
                    Visible = false;
                }
                // field("Posting Date"; Rec."Posting Date")
                // {
                //     ApplicationArea = Basic, Suite;
                //     ToolTip = 'Specifies the date when the posting of the purchase document will be recorded.';
                //     Visible = false;
                // }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                    Visible = false;
                }
                // field("Location Code"; Rec."Location Code")
                // {
                //     ApplicationArea = Location;
                //     ToolTip = 'Specifies a code for the location where you want the items to be placed when they are received.';
                // }
                // field("Purchaser Code"; Rec."Purchaser Code")
                // {
                //     ApplicationArea = Suite;
                //     ToolTip = 'Specifies which purchaser is assigned to the vendor.';
                //     Visible = false;
                // }
                // field("Assigned User ID"; Rec."Assigned User ID")
                // {
                //     ApplicationArea = Basic, Suite;
                //     ToolTip = 'Specifies the ID of the user who is responsible for the document.';
                // }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the code of the currency of the amounts on the purchase lines.';
                    Visible = false;
                }
            }
            part("Sous-form. demande de prix"; "Sous-form. demande de prix")
            {//page 50015
                Caption = 'Sub-form price request';
                ApplicationArea = all;
                SubPageLink = "Document No." = FIELD("No."),
                                  "Document Type" = FIELD("Document Type");
            }
        }
        area(factboxes)
        {
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = Basic, Suite;
                ShowFilter = false;
            }

        }
    }

    actions
    {

    }
    trigger OnAfterGetRecord()
    begin

        //POSTING_DESC

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


    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    end;

    trigger OnOpenPage()
    begin
        Rec.CopyBuyFromVendorFilter();
    end;

    PROCEDURE Filters();
    BEGIN
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
    END;

    var
        wDescr: Text[100];
        wJobFilter: Text[50];
        gBuyFromVendorNo: Text[50];
        gDateNextFollowUpFilter: Date;
        RecPurchaseLine: Record "Purchase Line";
        BlnNonLivré: Boolean;
        BlnTotalementLivré: Boolean;
        BlnPartiellementLivé: Boolean;
        InventorySetup: Record "Inventory Setup";
        UserSetup: Record "User Setup";
}

