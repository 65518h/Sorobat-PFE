page 52048932 "Purchase Order Mainten"
{//GL2024  ID dans Nav 2009 : "39002151"
    Caption = 'Purchase Order';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "Purchase Header";
    SourceTableView = WHERE("Document Type" = FILTER(Order));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; REC."No.")
                {
                    ApplicationArea = all;

                    trigger OnAssistEdit()
                    begin
                        IF REC.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Buy-from Vendor No."; REC."Buy-from Vendor No.")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        BuyfromVendorNoOnAfterValidate;
                    end;
                }
                field("Buy-from Contact No."; REC."Buy-from Contact No.")
                {
                    ApplicationArea = all;
                }
                field("Buy-from Vendor Name"; REC."Buy-from Vendor Name")
                {
                    ApplicationArea = all;
                }
                field("Buy-from Address"; REC."Buy-from Address")
                {
                    ApplicationArea = all;
                }
                field("Buy-from Address 2"; REC."Buy-from Address 2")
                {
                    ApplicationArea = all;
                }
                field("Buy-from Post Code"; REC."Buy-from Post Code")
                {
                    ApplicationArea = all;
                    Caption = 'Buy-from Post Code/City';
                }
                field("Buy-from City"; REC."Buy-from City")
                {
                    ApplicationArea = all;
                }
                field("Buy-from Contact"; REC."Buy-from Contact")
                {
                    ApplicationArea = all;
                }
                field("No. of Archived Versions"; REC."No. of Archived Versions")
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; REC."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Order Date"; REC."Order Date")
                {
                    ApplicationArea = all;
                }
                field("Document Date"; REC."Document Date")
                {
                    ApplicationArea = all;
                }
                field("Vendor Order No."; REC."Vendor Order No.")
                {
                    ApplicationArea = all;
                }
                field("Vendor Shipment No."; REC."Vendor Shipment No.")
                {
                    ApplicationArea = all;
                }
                field("Vendor Invoice No."; REC."Vendor Invoice No.")
                {
                    ApplicationArea = all;
                }
                field("Order Address Code"; REC."Order Address Code")
                {
                    ApplicationArea = all;
                }
                field("Purchaser Code"; REC."Purchaser Code")
                {
                    ApplicationArea = all;
                }
                field("Responsibility Center"; REC."Responsibility Center")
                {
                    ApplicationArea = all;
                }
                field(Status; REC.Status)
                {
                    ApplicationArea = all;
                }
            }
            part(PurchLines; "Purchase Order Subform")
            {
                SubPageLink = "Document No." = FIELD("No.");
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                field("Pay-to Vendor No."; REC."Pay-to Vendor No.")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        PaytoVendorNoOnAfterValidate;
                    end;
                }
                field("Pay-to Contact No."; REC."Pay-to Contact No.")
                {
                    ApplicationArea = all;
                }
                field("Pay-to Name"; REC."Pay-to Name")
                {
                    ApplicationArea = all;
                }
                field("Pay-to Address"; REC."Pay-to Address")
                {
                    ApplicationArea = all;
                }
                field("Pay-to Address 2"; REC."Pay-to Address 2")
                {
                    ApplicationArea = all;
                }
                field("Pay-to Post Code"; REC."Pay-to Post Code")
                {
                    ApplicationArea = all;
                    Caption = 'Pay-to Post Code/City';
                }
                field("Pay-to City"; REC."Pay-to City")
                {
                    ApplicationArea = all;
                }
                field("Pay-to Contact"; REC."Pay-to Contact")
                {
                    ApplicationArea = all;
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
                field("Payment Terms Code"; REC."Payment Terms Code")
                {
                    ApplicationArea = all;
                }
                field("Due Date"; REC."Due Date")
                {
                    ApplicationArea = all;
                }
                field("Payment Discount %"; REC."Payment Discount %")
                {
                    ApplicationArea = all;
                }
                field("Pmt. Discount Date"; REC."Pmt. Discount Date")
                {
                    ApplicationArea = all;
                }
                field("Payment Method Code"; REC."Payment Method Code")
                {
                    ApplicationArea = all;
                }
                field("On Hold"; REC."On Hold")
                {
                    ApplicationArea = all;
                }
                field("Prices Including VAT"; REC."Prices Including VAT")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        PricesIncludingVATOnAfterValid;
                    end;
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                field("Ship-to Name"; REC."Ship-to Name")
                {
                    ApplicationArea = all;
                }
                field("Ship-to Address"; REC."Ship-to Address")
                {
                    ApplicationArea = all;
                }
                field("Ship-to Address 2"; REC."Ship-to Address 2")
                {
                    ApplicationArea = all;
                }
                field("Ship-to Post Code"; REC."Ship-to Post Code")
                {
                    ApplicationArea = all;
                    Caption = 'Ship-to Post Code/City';
                }
                field("Ship-to City"; REC."Ship-to City")
                {
                    ApplicationArea = all;
                }
                field("Ship-to Contact"; REC."Ship-to Contact")
                {
                    ApplicationArea = all;
                }
                field("Location Code"; REC."Location Code")
                {
                    ApplicationArea = all;
                }
                field("Inbound Whse. Handling Time"; REC."Inbound Whse. Handling Time")
                {
                    ApplicationArea = all;
                }
                field("Shipment Method Code"; REC."Shipment Method Code")
                {
                    ApplicationArea = all;
                }
                field("Lead Time Calculation"; REC."Lead Time Calculation")
                {
                    ApplicationArea = all;
                }
                field("Requested Receipt Date"; REC."Requested Receipt Date")
                {
                    ApplicationArea = all;
                }
                field("Promised Receipt Date"; REC."Promised Receipt Date")
                {
                    ApplicationArea = all;
                }
                field("Expected Receipt Date"; REC."Expected Receipt Date")
                {
                    ApplicationArea = all;
                }
                field("Sell-to Customer No."; REC."Sell-to Customer No.")
                {
                    ApplicationArea = all;
                }
                field("Ship-to Code"; REC."Ship-to Code")
                {
                    ApplicationArea = all;
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                field("Currency Code"; REC."Currency Code")
                {
                    ApplicationArea = all;

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
                field("Transaction Type"; REC."Transaction Type")
                {
                    ApplicationArea = all;
                }
                field("Transaction Specification"; REC."Transaction Specification")
                {
                    ApplicationArea = all;
                }
                field("Transport Method"; REC."Transport Method")
                {
                    ApplicationArea = all;
                }
                field("Entry Point"; REC."Entry Point")
                {
                    ApplicationArea = all;
                }
                field(Area1; REC.Area)
                {
                    ApplicationArea = all;
                }
            }
            // group("E - Commerce")
            // {
            //Caption = 'E - Commerce';
            // field("BizTalk Purchase Order"; REC."BizTalk Purchase Order")
            // {
            //     Editable = false;
            // }
            // field("Date Sent"; REC."Date Sent")
            // {
            //     Editable = false;
            // }
            // field("Time Sent"; REC."Time Sent")
            // {
            //     Editable = false;
            // }
            // field("Vendor Quote No."; REC."Vendor Quote No.")
            // {
            // }
            // field("BizTalk Purch. Order Cnfmn."; REC."BizTalk Purch. Order Cnfmn.")
            // {
            //     Editable = false;
            // }
            // field("Date Received"; REC."Date Received")
            // {
            //     Editable = false;
            // }
            // field("Time Received"; REC."Time Received")
            // {
            //     Editable = false;
            // }
            // field("BizTalk Purchase Receipt"; REC."BizTalk Purchase Receipt")
            // {
            //     Editable = false;
            // }
            // field("BizTalk Purchase Invoice"; REC."BizTalk Purchase Invoice")
            // {
            //     Editable = false;
            // }
            //}
        }
    }

    actions
    {
        area(navigation)
        {
            group("O&rder")
            {
                Caption = 'O&rder';
                action(Statistics)
                {
                    ApplicationArea = all;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';

                    trigger OnAction()
                    begin
                        PurchSetup.GET;
                        /*IF PurchSetup."Calc. Inv. Discount" THEN BEGIN
                            CurrPage.PurchLines.PAGE.CalcInvDisc;
                            COMMIT;
                        END;*/
                        PAGE.RUNMODAL(PAGE::"Purchase Order Statistics", Rec);
                    end;
                }
                action(Card)
                {
                    ApplicationArea = all;
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Vendor List";
                    RunPageLink = "No." = FIELD("Buy-from Vendor No.");
                    ShortCutKey = 'Maj+F5';
                }
                action("Co&mments")
                {
                    ApplicationArea = all;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"), "No." = FIELD("No.");
                }
                action(Receipts)
                {
                    ApplicationArea = all;
                    Caption = 'Receipts';
                    Image = PostedReceipts;
                    RunObject = Page "Posted Purchase Receipts";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                }
                action(Invoices)
                {
                    ApplicationArea = all;
                    Caption = 'Invoices';
                    Image = Invoice;
                    RunObject = Page "Posted Purchase Invoices";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                }
                action(Dimensions1)
                {
                    ApplicationArea = all;
                    Caption = 'Dimensions';
                    Image = Dimensions;

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim;
                    end;
                }

                action("Whse. Receipt Lines")
                {
                    ApplicationArea = all;
                    Caption = 'Whse. Receipt Lines';
                    RunObject = Page "Whse. Receipt Lines";
                    RunPageLink = "Source Type" = CONST(39), "Source Subtype" = FIELD("Document Type"), "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                }
                action("In&vt. Put-away/Pick Lines")
                {
                    ApplicationArea = all;
                    Caption = 'In&vt. Put-away/Pick Lines';
                    RunObject = Page "Warehouse Activity List";
                    RunPageLink = "Source Document" = CONST("Purchase Order"), "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Document", "Source No.", "Location Code");
                }

                group("Dr&op Shipment")
                {
                    Caption = 'Dr&op Shipment';
                    action("Get &Sales Order1")
                    {
                        ApplicationArea = all;
                        Caption = 'Get &Sales Order';
                        RunObject = Codeunit "Purch.-Get Drop Shpt.";
                    }
                    action("Sales &Order1")
                    {
                        ApplicationArea = all;
                        Caption = 'Sales &Order';
                        Image = Document;

                        trigger OnAction()
                        begin
                            //CurrPage.PurchLines.PAGE.OpenSalesOrderForm;
                        end;
                    }
                }
                group("Speci&al Order")
                {
                    Caption = 'Speci&al Order';
                    action("Get &Sales Order")
                    {
                        ApplicationArea = all;
                        Caption = 'Get &Sales Order';

                        trigger OnAction()
                        var
                            DistIntegration: Codeunit "Dist. Integration";
                            PurchHeader: Record "Purchase Header";
                        begin
                            PurchHeader.COPY(Rec);
                            DistIntegration.GetSpecialOrders(PurchHeader);
                            Rec := PurchHeader;
                        end;
                    }
                    action("Sales &Order")
                    {
                        ApplicationArea = all;
                        Caption = 'Sales &Order';
                        Image = Document;

                        trigger OnAction()
                        begin
                            //  CurrPage.PurchLines.PAGE.OpenSpecOrderSalesOrderForm;
                        end;
                    }
                }
            }
            /*  group("&Line")
              {
                  Caption = '&Line';
                  group("Item Availability by")
                  {
                      Caption = 'Item Availability by';
                      action(Period)
                      {
                          Caption = 'Period';

                          trigger OnAction()
                          begin
                              CurrPage.PurchLines.page.ItemAvailability(0);
                          end;
                      }
                      action(Variant)
                      {
                          Caption = 'Variant';

                          trigger OnAction()
                          begin
                              CurrPage.PurchLines.page.ItemAvailability(1);
                          end;
                      }
                      action(Location)
                      {
                          Caption = 'Location';

                          trigger OnAction()
                          begin
                              CurrPage.PurchLines.page.ItemAvailability(2);
                          end;
                      }
                  }

                  action("Reservation Entries")
                  {
                      Caption = 'Reservation Entries';
                      Image = ReservationLedger;

                      trigger OnAction()
                      begin
                          CurrPage.PurchLines.page.ShowReservationEntries;
                      end;
                  }
                  action("Item &Tracking Lines")
                  {
                      Caption = 'Item &Tracking Lines';
                      Image = ItemTrackingLines;

                      trigger OnAction()
                      begin
                          CurrPage.PurchLines.page.OpenItemTrackingLines;
                      end;
                  }

                  action(Dimensions)
                  {
                      Caption = 'Dimensions';
                      Image = Dimensions;
                      ShortCutKey = 'Maj+Ctrl+D';

                      trigger OnAction()
                      begin
                          CurrPage.PurchLines.page.ShowDimensions;
                      end;
                  }
                  action("Item Charge &Assignment")
                  {
                      Caption = 'Item Charge &Assignment';

                      trigger OnAction()
                      begin
                          CurrPage.PurchLines.page.ItemChargeAssgnt;
                      end;
                  }
              }*/
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Calculate &Invoice Discount")
                {
                    ApplicationArea = all;
                    Caption = 'Calculate &Invoice Discount';
                    Image = CalculateInvoiceDiscount;

                    trigger OnAction()
                    begin
                        CurrPage.PurchLines.PAGE.ApproveCalcInvDisc;
                    end;
                }

                /*  action("E&xplode BOM")
                  {ApplicationArea = all;
                      Caption = 'E&xplode BOM';
                      Image = ExplodeBOM;

                      trigger OnAction()
                      begin
                          CurrPage.PurchLines.PAGE.ExplodeBOM;
                      end;
                  }*/
                action("Insert &Ext. Texts")
                {
                    ApplicationArea = all;
                    Caption = 'Insert &Ext. Texts';

                    trigger OnAction()
                    begin
                        CurrPage.PurchLines.page.InsertExtendedText(TRUE);
                    end;
                }

                action("Get St&d. Vend. Purchase Codes")
                {
                    ApplicationArea = all;
                    Caption = 'Get St&d. Vend. Purchase Codes';
                    Ellipsis = true;

                    trigger OnAction()
                    var
                        StdVendPurchCode: Record "Standard Vendor Purchase Code";
                    begin
                        StdVendPurchCode.InsertPurchLines(Rec);
                    end;
                }

                /*  action("Get &Phase/Task/Step")
                  {ApplicationArea = all;
                      Caption = 'Get &Phase/Task/Step';
                      Ellipsis = true;

                      trigger OnAction()
                      begin
                          CurrPage.PurchLines.PAGE.UpdateAllowed;
                      end;
                  }
  */
                /*  action("&Reserve")
                  {
                      Caption = '&Reserve';
                      Ellipsis = true;

                      trigger OnAction()
                      begin
                          CurrPage.PurchLines.page.ShowReservation;
                      end;
                  }*/
                action("Order &Tracking")
                {
                    ApplicationArea = all;
                    Caption = 'Order &Tracking';

                    trigger OnAction()
                    begin
                        CurrPage.PurchLines.page.ShowTracking;
                    end;
                }

                action("Copy Document")
                {
                    ApplicationArea = all;
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    Image = CopyDocument;

                    trigger OnAction()
                    begin
                        CopyPurchDoc.SetPurchHeader(Rec);
                        CopyPurchDoc.RUNMODAL;
                        CLEAR(CopyPurchDoc);
                    end;
                }
                action("Archi&ve Document")
                {
                    ApplicationArea = all;
                    Caption = 'Archi&ve Document';

                    trigger OnAction()
                    begin
                        ArchiveManagement.ArchivePurchDocument(Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Move Negative Lines")
                {
                    ApplicationArea = all;
                    Caption = 'Move Negative Lines';
                    Ellipsis = true;

                    trigger OnAction()
                    begin
                        CLEAR(MoveNegPurchLines);
                        MoveNegPurchLines.SetPurchHeader(Rec);
                        MoveNegPurchLines.RUNMODAL;
                        MoveNegPurchLines.ShowDocument;
                    end;
                }

                action("Create &Whse. Receipt")
                {
                    ApplicationArea = all;
                    Caption = 'Create &Whse. Receipt';

                    trigger OnAction()
                    var
                        GetSourceDocInbound: Codeunit "Get Source Doc. Inbound";
                    begin
                        GetSourceDocInbound.CreateFromPurchOrder(Rec);
                    end;
                }
                action("Create Inventor&y Put-away / Pick")
                {
                    ApplicationArea = all;
                    Caption = 'Create Inventor&y Put-away / Pick';
                    Ellipsis = true;
                    Image = CreateInventoryPickup;

                    trigger OnAction()
                    begin
                        REC.CreateInvtPutAwayPick;
                    end;
                }

                action("Re&lease")
                {
                    ApplicationArea = all;
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    RunObject = Codeunit "Release Purchase Document";
                    ShortCutKey = 'Ctrl+F9';
                }
                action("Re&open")
                {
                    ApplicationArea = all;
                    Caption = 'Re&open';
                    Image = ReOpen;

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        ReleasePurchDoc.Reopen(Rec);
                    end;
                }

                // action("&Send BizTalk Purchase Order")
                // {
                //     Caption = '&Send BizTalk Purchase Order';

                //     trigger OnAction()
                //     var
                //         BizTalkManagement: Codeunit 99008508;
                //     begin
                //         BizTalkManagement.SendPurchaseOrder(Rec);
                //     end;
                // }
                action("Send IC Purchase Order")
                {
                    Caption = 'Send IC Purchase Order';
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        ICInOutboxMgt: Codeunit ICInboxOutboxMgt;
                    begin
                        ICInOutboxMgt.SendPurchDoc(Rec, FALSE);
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                action("Test Report")
                {
                    ApplicationArea = all;
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;

                    trigger OnAction()
                    begin
                        ReportPrint.PrintPurchHeader(Rec);
                    end;
                }
                action("P&ost")
                {
                    ApplicationArea = all;
                    Caption = 'P&ost';
                    Ellipsis = true;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Codeunit "Purch.-Post (Yes/No)";
                    ShortCutKey = 'F9';
                }
                action("Post and &Print")
                {
                    ApplicationArea = all;
                    Caption = 'Post and &Print';
                    Ellipsis = true;
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Codeunit "Purch.-Post + Print";
                    ShortCutKey = 'Maj+F11';
                }
                action("Post &Batch")
                {
                    ApplicationArea = all;
                    Caption = 'Post &Batch';
                    Ellipsis = true;
                    Image = PostBatch;

                    trigger OnAction()
                    begin
                        REPORT.RUNMODAL(REPORT::"Batch Post Purchase Orders", TRUE, TRUE, Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
            }
            action("&Print")
            {
                ApplicationArea = all;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    DocPrint.PrintPurchHeader(Rec);
                end;
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SAVERECORD;
        EXIT(REC.ConfirmDeletion);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        REC."Responsibility Center" := UserMgt.GetPurchasesFilter();
    end;

    trigger OnOpenPage()
    begin
        IF UserMgt.GetPurchasesFilter() <> '' THEN BEGIN
            REC.FILTERGROUP(2);
            REC.SETRANGE("Responsibility Center", UserMgt.GetPurchasesFilter());
            REC.FILTERGROUP(0);
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

    local procedure BuyfromVendorNoOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure PaytoVendorNoOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure PricesIncludingVATOnAfterValid()
    begin
        CurrPage.UPDATE;
    end;
}

