page 52048944 "Req. Worksheet Maintenance"
{//GL2024  ID dans Nav 2009 : "39002152"
    AutoSplitKey = true;
    Caption = 'Req. Worksheet';
    DataCaptionFields = "Journal Batch Name";
    DelayedInsert = true;
    PageType = List;
    SaveValues = true;
    SourceTable = "Requisition Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            field(CurrentJnlBatchName; CurrentJnlBatchName)
            {
                ApplicationArea = all;
                Caption = 'Name';
                Lookup = true;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    CurrPage.SAVERECORD;
                    ReqJnlManagement.LookupName(CurrentJnlBatchName, Rec);
                    CurrPage.UPDATE(FALSE);
                end;

                trigger OnValidate()
                begin
                    ReqJnlManagement.CheckName(CurrentJnlBatchName, Rec);
                    CurrentJnlBatchNameOnAfterVali;
                end;
            }
            repeater(Control1)
            {
                ShowCaption = false;
                field(Type; REC.Type)
                {
                    ApplicationArea = all;
                    OptionCaption = ' ,G/L Account,Item,Maintenance item';

                    trigger OnValidate()
                    begin
                        ReqJnlManagement.GetDescriptionAndRcptName(Rec, Description2, BuyFromVendorName);
                    end;
                }
                field("No."; REC."No.")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        ReqJnlManagement.GetDescriptionAndRcptName(Rec, Description2, BuyFromVendorName);
                        REC.ShowShortcutDimCode(ShortcutDimCode);
                    end;
                }
                field("Action Message"; REC."Action Message")
                {
                    ApplicationArea = all;
                }
                field("Accept Action Message"; REC."Accept Action Message")
                {
                    ApplicationArea = all;
                }
                field("Variant Code"; REC."Variant Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Description; REC.Description)
                {
                    ApplicationArea = all;
                }
                field("Description 2"; REC."Description 2")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Transfer-from Code"; REC."Transfer-from Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Location Code"; REC."Location Code")
                {
                    ApplicationArea = all;
                }
                field("Original Quantity"; REC."Original Quantity")
                {
                    ApplicationArea = all;
                }
                field(Quantity; REC.Quantity)
                {
                    ApplicationArea = all;
                }
                field("Unit of Measure Code"; REC."Unit of Measure Code")
                {
                    ApplicationArea = all;
                }
                field("Direct Unit Cost"; REC."Direct Unit Cost")
                {
                    ApplicationArea = all;
                }
                field("Currency Code"; REC."Currency Code")
                {
                    ApplicationArea = all;
                    AssistEdit = true;
                    Visible = false;

                    trigger OnAssistEdit()
                    begin
                        ChangeExchangeRate.SetParameter(REC."Currency Code", REC."Currency Factor", WORKDATE);
                        IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
                            REC.VALIDATE(REC."Currency Factor", ChangeExchangeRate.GetParameter);
                        END;
                        CLEAR(ChangeExchangeRate);
                    end;
                }
                field("Line Discount %"; REC."Line Discount %")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Original Due Date"; REC."Original Due Date")
                {
                    ApplicationArea = all;
                }
                field("Due Date"; REC."Due Date")
                {
                    ApplicationArea = all;
                }
                field("Order Date"; REC."Order Date")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Vendor No."; REC."Vendor No.")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        ReqJnlManagement.GetDescriptionAndRcptName(Rec, Description2, BuyFromVendorName);
                        REC.ShowShortcutDimCode(ShortcutDimCode);
                    end;
                }
                field("Vendor Item No."; REC."Vendor Item No.")
                {
                    ApplicationArea = all;
                }
                field("Order Address Code"; REC."Order Address Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Sell-to Customer No."; REC."Sell-to Customer No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Ship-to Code"; REC."Ship-to Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Prod. Order No."; REC."Prod. Order No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Requester ID"; REC."Requester ID")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Confirmed; REC.Confirmed)
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; REC."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; REC."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(ShortcutDimCode3; ShortcutDimCode[3])
                {
                    ApplicationArea = all;
                    //CaptionClass = '1,2,3';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        REC.LookupShortcutDimCode(3, ShortcutDimCode[3]);
                    end;

                    trigger OnValidate()
                    begin
                        REC.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                }
                field(ShortcutDimCode4; ShortcutDimCode[4])
                {
                    ApplicationArea = all;
                    //CaptionClass = '1,2,4';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        REC.LookupShortcutDimCode(4, ShortcutDimCode[4]);
                    end;

                    trigger OnValidate()
                    begin
                        REC.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }
                field(ShortcutDimCode5; ShortcutDimCode[5])
                {
                    ApplicationArea = all;
                    //CaptionClass = '1,2,5';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        REC.LookupShortcutDimCode(5, ShortcutDimCode[5]);
                    end;

                    trigger OnValidate()
                    begin
                        REC.ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                    end;
                }
                field(ShortcutDimCode6; ShortcutDimCode[6])
                {
                    ApplicationArea = all;
                    //CaptionClass = '1,2,6';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        REC.LookupShortcutDimCode(6, ShortcutDimCode[6]);
                    end;

                    trigger OnValidate()
                    begin
                        REC.ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                    end;
                }
                field(ShortcutDimCode7; ShortcutDimCode[7])
                {
                    ApplicationArea = all;
                    //CaptionClass = '1,2,7';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        REC.LookupShortcutDimCode(7, ShortcutDimCode[7]);
                    end;

                    trigger OnValidate()
                    begin
                        REC.ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                }
                field(ShortcutDimCode8; ShortcutDimCode[8])
                {
                    ApplicationArea = all;
                    //CaptionClass = '1,2,8';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        REC.LookupShortcutDimCode(8, ShortcutDimCode[8]);
                    end;

                    trigger OnValidate()
                    begin
                        REC.ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
                field("Ref. Order No."; REC."Ref. Order No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Ref. Order Type"; REC."Ref. Order Type")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Replenishment System"; REC."Replenishment System")
                {
                    ApplicationArea = all;
                }
                field("Ref. Line No."; REC."Ref. Line No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Planning Flexibility"; REC."Planning Flexibility")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
            }
            group(GP)
            {
                field(Description2; Description2)
                {
                    ApplicationArea = all;
                    Caption = 'Description';
                    Editable = false;
                }
                field(BuyFromVendorName; BuyFromVendorName)
                {
                    ApplicationArea = all;
                    Caption = 'Buy-from Vendor Name';
                    Editable = false;
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
                actionref(Card1; Card) { }
                actionref("Item &Tracking Lines1"; "Item &Tracking Lines") { }
            }
            group("F&unctions1")
            {
                Caption = 'F&unctions';
                actionref("Calculate Plan1"; "Calculate Plan") { }

                group("Drop Shipment1")
                {
                    Caption = 'Drop Shipment';
                    actionref("Get &Sales Orders11"; "Get &Sales Orders1") { }
                    actionref("Sales &Order11"; "Sales &Order1") { }
                }
                group("Special Order1")
                {
                    Caption = 'Special Order';
                    actionref("Get &Sales Orders12"; "Get &Sales Orders") { }
                    actionref("Sales &Order12"; "Sales &Order") { }
                    actionref("Carry &Out Action Message1"; "Carry &Out Action Message") { }
                    actionref("&Reserve1"; "&Reserve") { }
                    actionref("Order &Tracking1"; "Order &Tracking") { }

                }
            }
        }
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                action(Card)
                {
                    ApplicationArea = all;
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Codeunit "Req. Wksh.-Show Card";
                    ShortCutKey = 'Maj+F5';
                }
                //  group("Item Availability by")
                //  {
                // Caption = 'Item Availability by';
                // action(Period)
                // {
                //     Caption = 'Period';

                //     trigger OnAction()
                //     begin
                //         ItemAvailability(0);
                //     end;
                // }
                // action(Variant)
                // {
                //     Caption = 'Variant';

                //     trigger OnAction()
                //     begin
                //         ItemAvailability(1);
                //     end;
                // }
                // action(Location)
                // {
                //     Caption = 'Location';

                //     trigger OnAction()
                //     begin
                //         ItemAvailability(2);
                //     end;
                // }
                // }
                // action(Dimensions)
                // {
                //     Caption = 'Dimensions';
                //     Image = Dimensions;
                //     RunObject = Page 545;
                //                     RunPageLink = Table ID=CONST(246), Journal Template Name=FIELD(Worksheet Template Name), Journal Batch Name=FIELD(Journal Batch Name), Journal Line No.=FIELD(Line No.);
                //     ShortCutKey = 'Maj+Ctrl+D';
                // }
                action("Item &Tracking Lines")
                {
                    ApplicationArea = all;
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;

                    trigger OnAction()
                    begin
                        REC.OpenItemTrackingLines;
                    end;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Calculate Plan")
                {
                    ApplicationArea = all;
                    Caption = 'Calculate Plan';
                    Ellipsis = true;
                    Image = CalculatePlan;

                    trigger OnAction()
                    begin

                        CalculatePlan.SetTemplAndWorksheet(rec."Worksheet Template Name", rec."Journal Batch Name"/*, ''*/);
                        CalculatePlan.RUNMODAL;
                        CLEAR(CalculatePlan);
                    end;
                }
                group("Drop Shipment")
                {
                    Caption = 'Drop Shipment';
                    action("Get &Sales Orders1")
                    {
                        ApplicationArea = all;
                        Caption = 'Get &Sales Orders';
                        Ellipsis = true;

                        trigger OnAction()
                        begin
                            GetSalesOrder.SetReqWkshLine(Rec, 0);
                            GetSalesOrder.RUNMODAL;
                            CLEAR(GetSalesOrder);
                        end;
                    }
                    action("Sales &Order1")
                    {
                        ApplicationArea = all;
                        Caption = 'Sales &Order';
                        Image = Document;

                        trigger OnAction()
                        begin
                            SalesHeader.SETRANGE("No.", REC."Sales Order No.");
                            SalesOrder.SETTABLEVIEW(SalesHeader);
                            SalesOrder.EDITABLE := FALSE;
                            SalesOrder.RUN;
                        end;
                    }
                }
                group("Special Order")
                {
                    Caption = 'Special Order';
                    action("Get &Sales Orders")
                    {
                        ApplicationArea = all;
                        Caption = 'Get &Sales Orders';
                        Ellipsis = true;

                        trigger OnAction()
                        begin
                            GetSalesOrder.SetReqWkshLine(Rec, 1);
                            GetSalesOrder.RUNMODAL;
                            CLEAR(GetSalesOrder);
                        end;
                    }
                    action("Sales &Order")
                    {
                        ApplicationArea = all;
                        Caption = 'Sales &Order';
                        Image = Document;

                        trigger OnAction()
                        begin
                            SalesHeader.SETRANGE("No.", REC."Sales Order No.");
                            SalesOrder.SETTABLEVIEW(SalesHeader);
                            SalesOrder.EDITABLE := FALSE;
                            SalesOrder.RUN;
                        end;
                    }
                }
                action("Carry &Out Action Message")
                {
                    ApplicationArea = all;
                    Caption = 'Carry &Out Action Message';
                    Ellipsis = true;
                    Image = CarryOutActionMessage;

                    trigger OnAction()
                    var
                        PerformAction: Report "Carry Out Action Msg. - Req.";
                    begin
                        PerformAction.SetReqWkshLine(Rec);
                        PerformAction.RUNMODAL;
                        PerformAction.GetReqWkshLine(Rec);
                        CurrentJnlBatchName := REC.GETRANGEMAX("Journal Batch Name");
                        CurrPage.UPDATE(FALSE);
                    end;
                }

                action("&Reserve")
                {
                    ApplicationArea = all;
                    Caption = '&Reserve';

                    trigger OnAction()
                    begin
                        CurrPage.SAVERECORD;
                        REC.ShowReservation;
                    end;
                }
                action("Order &Tracking")
                {
                    ApplicationArea = all;
                    Caption = 'Order &Tracking';

                    trigger OnAction()
                    var
                        TrackingForm: Page "Order Tracking";
                    begin
                        TrackingForm.SetReqLine(Rec);
                        TrackingForm.RUNMODAL;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        REC.ShowShortcutDimCode(ShortcutDimCode);
        OnAfterGetCurrRecord;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        REC."Accept Action Message" := FALSE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        ReqJnlManagement.SetUpNewLine(Rec, xRec);
        CLEAR(ShortcutDimCode);
        OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage()
    var
        JnlSelected: Boolean;
    begin
        //  ReqJnlManagement.TemplateSelection(PAGE::"Req. Worksheet", FALSE, 0, Rec, JnlSelected);
        ReqJnlManagement.WkshTemplateSelection(PAGE::"Req. Worksheet", FALSE, 0, Rec, JnlSelected);
        IF NOT JnlSelected THEN
            ERROR('');
        ReqJnlManagement.OpenJnl(CurrentJnlBatchName, Rec);
    end;

    var
        SalesHeader: Record "Sales Header";
        ChangeExchangeRate: Page "Change Exchange Rate";
        SalesOrder: Page "Sales Order";
        GetSalesOrder: Report "Get Sales Orders";
        CalculatePlan: Report "Calculate Plan - Req. Wksh.";
        ReqJnlManagement: Codeunit ReqJnlManagement;
        CurrentJnlBatchName: Code[10];
        Description2: Text[30];
        BuyFromVendorName: Text[30];
        ShortcutDimCode: array[8] of Code[20];

    local procedure CurrentJnlBatchNameOnAfterVali()
    begin
        CurrPage.SAVERECORD;
        ReqJnlManagement.SetName(CurrentJnlBatchName, Rec);
        CurrPage.UPDATE(FALSE);
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        ReqJnlManagement.GetDescriptionAndRcptName(Rec, Description2, BuyFromVendorName);
    end;
}

