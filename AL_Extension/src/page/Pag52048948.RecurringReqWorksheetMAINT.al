page 52048948 "Recurring Req. Worksheet MAINT"
{//GL2024  ID dans Nav 2009 : "39002153"
    AutoSplitKey = true;
    Caption = 'Recurring Req. Worksheet';
    DataCaptionFields = "Journal Batch Name";
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Requisition Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(gen)
            {
                field(CurrentJnlBatchName; CurrentJnlBatchName)
                {
                    ApplicationArea = all;
                    Caption = 'Nom';
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
            }

            repeater(Control1)
            {
                ShowCaption = false;
                field("Recurring Method"; rec."Recurring Method")
                {
                    ApplicationArea = all;
                }
                field("Recurring Frequency"; rec."Recurring Frequency")
                {
                    ApplicationArea = all;
                }
                field(Type; rec.Type)
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        ReqJnlManagement.GetDescriptionAndRcptName(Rec, Description2, BuyFromVendorName);
                    end;
                }
                field("No."; rec."No.")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        ReqJnlManagement.GetDescriptionAndRcptName(Rec, Description2, BuyFromVendorName);
                        REC.ShowShortcutDimCode(ShortcutDimCode);
                    end;
                }
                field("Variant Code"; rec."Variant Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Action Message"; rec."Action Message")
                {
                    ApplicationArea = all;
                }
                field("Accept Action Message"; rec."Accept Action Message")
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Description 2"; rec."Description 2")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = all;
                    Visible = true;
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = all;
                }
                field("Unit of Measure Code"; rec."Unit of Measure Code")
                {
                    ApplicationArea = all;
                }
                field("Vendor No."; rec."Vendor No.")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        ReqJnlManagement.GetDescriptionAndRcptName(Rec, Description2, BuyFromVendorName);
                        REC.ShowShortcutDimCode(ShortcutDimCode);
                    end;
                }
                field("Vendor Item No."; rec."Vendor Item No.")
                {
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; rec."Shortcut Dimension 2 Code")
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
                field("Currency Code"; REC."Currency Code")
                {
                    ApplicationArea = all;
                    AssistEdit = true;
                    Visible = false;

                    trigger OnAssistEdit()
                    begin
                        ChangeExchangeRate.SetParameter(rec."Currency Code", rec."Currency Factor", WORKDATE);
                        IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
                            rec.VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter);
                        END;
                        CLEAR(ChangeExchangeRate);
                    end;
                }
                field("Direct Unit Cost"; REC."Direct Unit Cost")
                {
                    ApplicationArea = all;
                }
                field("Line Discount %"; REC."Line Discount %")
                {
                    Visible = false;
                }
                field("Order Date"; REC."Order Date")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Due Date"; REC."Due Date")
                {
                    ApplicationArea = all;
                }
                field("Requester ID"; REC."Requester ID")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Prod. Order No."; REC."Prod. Order No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Confirmed; REC.Confirmed)
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Expiration Date"; REC."Expiration Date")
                {
                    ApplicationArea = all;
                }
            }
            // group(gen1)
            // {
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
            // }
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
                actionref("Reservation Entries1"; "Reservation Entries") { }
                actionref("Item &Tracking Lines1"; "Item &Tracking Lines") { }
            }

            group("F&unctions1")
            {
                Caption = 'F&unctions';

                actionref("Calculate Plan1"; "Calculate Plan") { }
                actionref("Carry &Out Action Message1"; "Carry &Out Action Message") { }
                actionref("&Reserve1"; "&Reserve") { }

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
                // group("Item Availability by")
                //  {
                //    Caption = 'Item Availability by';
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
                //    }
                action("Reservation Entries")
                {
                    ApplicationArea = all;
                    Caption = 'Reservation Entries';
                    Image = ReservationLedger;

                    trigger OnAction()
                    begin
                        rec.ShowReservationEntries(TRUE);
                    end;
                }
                /*GL2024     action(Dimensions)
                     {
                         Caption = 'Dimensions';
                         Image = Dimensions;
                         RunObject = Page "Journal Line Dimensions";
                                         RunPageLink = "Table ID"=CONST(246), "Journal Template Name"=FIELD("Worksheet Template Name"), "Journal Batch Name"=FIELD("Journal Batch Name"), "Journal Line No."=FIELD("Line No.");
                         ShortCutKey = 'Maj+Ctrl+D';
                     }*/
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

                        ReorderItems.SetTemplAndWorksheet(rec."Worksheet Template Name", rec."Journal Batch Name"/*, ''*/);
                        ReorderItems.RUNMODAL;
                        CLEAR(ReorderItems);
                    end;
                }
                action("Carry &Out Action Message")
                {
                    ApplicationArea = all;
                    Caption = 'Carry &Out Action Message';
                    Ellipsis = true;
                    Image = CarryOutActionMessage;

                    trigger OnAction()
                    var
                        MakePurchOrder: Report "Carry Out Action Msg. - Req.";
                    begin
                        MakePurchOrder.SetReqWkshLine(Rec);
                        MakePurchOrder.RUNMODAL;
                        MakePurchOrder.GetReqWkshLine(Rec);
                        CurrentJnlBatchName := REC.GETRANGEMAX("Journal Batch Name");
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("&Reserve")
                {
                    ApplicationArea = all;
                    Caption = '&Reserve';
                    Ellipsis = true;

                    trigger OnAction()
                    begin
                        CurrPage.SAVERECORD;
                        REC.ShowReservation;
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
        // ReqJnlManagement.TemplateSelection(PAGE::"Recurring Req. Worksheet", TRUE, 0, Rec, JnlSelected);
        ReqJnlManagement.WkshTemplateSelection(PAGE::"Recurring Req. Worksheet", TRUE, 0, Rec, JnlSelected);

        IF NOT JnlSelected THEN
            ERROR('');
        ReqJnlManagement.OpenJnl(CurrentJnlBatchName, Rec);
    end;



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

    var
        ChangeExchangeRate: Page "Change Exchange Rate";
        ReorderItems: Report "Calculate Plan - Req. Wksh.";
        ReqJnlManagement: Codeunit ReqJnlManagement;
        CurrentJnlBatchName: Code[10];
        Description2: Text[30];
        BuyFromVendorName: Text[30];
        ShortcutDimCode: array[8] of Code[20];
}

