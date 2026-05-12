Page 50251 "Ligne Avoir Decompte"
{
    // //PROJET GESWAY 01/11/01 Job No. : Visible OUI
    //                          Ajout des champs Phase Code, Task Code, Step Code, Work Type Code
    // //DEVIS GESWAY 07/01/05 Tri sur la clé Document No.,Presentation Code

    AutoSplitKey = true;
    Caption = 'Ligne Avoir Decompte';
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = List;
    SourceTable = "Sales Shipment Line";
    SourceTableView = sorting("Document No.", "Line No.");
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Line No."; REC."Line No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field("No."; REC."No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Description; REC.Description)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Location Code"; REC."Location Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Quantity; REC.Quantity)
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    Editable = false;
                }
                field("Quantité Avoir"; REC."Quantité Avoir")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    var
                        HJ: Integer;
                        CduSalesPost: Codeunit SalesPostEvent;
                    begin
                        if REC."Quantité Avoir" > 0 then Error(Text001);
                        //   CduSalesPost.UpdateLivraisonRapportChantier(REC."Document No.", REC."Line No.", REC."Quantité Avoir");
                    end;
                }
                field("Unit Price"; REC."Unit Price")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Unit of Measure Code"; REC."Unit of Measure Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Job No."; REC."Job No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = true;
                }
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
                actionref(Dimensions1; Dimensions) { }

                actionref("Co&mments1"; "Co&mments") { }
                actionref("Item &Tracking Entries1"; "Item &Tracking Entries") { }
                actionref("Item Invoice &Lines1"; "Item Invoice &Lines") { }
            }

            group("F&unctions1")
            {
                Caption = 'F&unctions';
                actionref("Order Tra&cking1"; "Order Tra&cking") { }
                actionref("&Undo Shipment1"; "&Undo Shipment") { }
            }
        }
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                action(Dimensions)
                {
                    ApplicationArea = all;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Maj+Ctrl+D';

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50250. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesShipmLines.FORM.*/
                        _ShowDimensions;

                    end;
                }
                action("Co&mments")
                {
                    ApplicationArea = all;
                    Caption = 'Co&mments';
                    Image = ViewComments;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50250. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesShipmLines.FORM.*/
                        _ShowLineComments;

                    end;
                }
                action("Item &Tracking Entries")
                {
                    ApplicationArea = all;
                    Caption = 'Item &Tracking Entries';
                    Image = ItemTrackingLedger;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50250. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesShipmLines.FORM.*/
                        _ShowItemTrackingLines;

                    end;
                }
                action("Item Invoice &Lines")
                {
                    ApplicationArea = all;
                    Caption = 'Item Invoice &Lines';

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50250. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesShipmLines.FORM.*/
                        _ShowItemSalesInvLines;

                    end;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Order Tra&cking")
                {
                    ApplicationArea = all;
                    Caption = 'Order Tra&cking';

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50250. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesShipmLines.FORM.*/
                        ShowTracking;

                    end;
                }
                action("&Undo Shipment")
                {
                    ApplicationArea = all;
                    Caption = '&Undo Shipment';

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50250. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesShipmLines.FORM.*/
                        UndoShipmentPosting;

                    end;
                }
            }
        }
    }

    var
        //HJTXT: text;
        Text001: label 'Quantité Doit Etree Negative';


    procedure ShowTracking()
    var
        ItemLedgEntry: Record "Item Ledger Entry";
        TempItemLedgEntry: Record "Item Ledger Entry" temporary;
        TrackingForm: Page "Order Tracking";
    begin
        REC.TestField(REC.Type, REC.Type::Item);
        if REC."Item Shpt. Entry No." <> 0 then begin
            ItemLedgEntry.Get(REC."Item Shpt. Entry No.");
            TrackingForm.SetItemLedgEntry(ItemLedgEntry);
        end else
            TrackingForm.SetMultipleItemLedgEntries(TempItemLedgEntry,
              Database::"Sales Shipment Line", 0, REC."Document No.", '', 0, REC."Line No.");

        TrackingForm.RunModal;
    end;


    procedure _ShowDimensions()
    begin
        Rec.ShowDimensions;
    end;


    procedure ShowDimensions()
    begin
        Rec.ShowDimensions;
    end;


    procedure _ShowItemTrackingLines()
    begin
        Rec.ShowItemTrackingLines;
    end;


    procedure ShowItemTrackingLines()
    begin
        Rec.ShowItemTrackingLines;
    end;


    procedure UndoShipmentPosting()
    var
        SalesShptLine: Record "Sales Shipment Line";
    begin
        SalesShptLine.Copy(Rec);
        CurrPage.SetSelectionFilter(SalesShptLine);
        Codeunit.Run(Codeunit::"Undo Sales Shipment Line", SalesShptLine);
    end;


    procedure _ShowItemSalesInvLines()
    begin
        REC.TestField(Type, REC.Type::Item);
        Rec.ShowItemSalesInvLines;
    end;


    procedure ShowItemSalesInvLines()
    begin
        REC.TestField(Type, REC.Type::Item);
        Rec.ShowItemSalesInvLines;
    end;


    procedure _ShowLineComments()
    begin
        Rec.ShowLineComments;
    end;


    procedure ShowLineComments()
    begin
        Rec.ShowLineComments;
    end;
}

