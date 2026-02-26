page 52048906 "Consumption Journal GMAO"
{
    //GL2024  ID dans Nav 2009 : "39002100"
    AutoSplitKey = true;
    Caption = 'Consumption Journal GMAO';
    DataCaptionFields = "Journal Batch Name";
    DelayedInsert = true;
    PageType = List;
    SaveValues = true;
    SourceTable = "Item Journal Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            field(template; CurrentJnlBatchName)
            {
                ApplicationArea = all;
                Caption = 'Batch Name';
                Lookup = true;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    CurrPage.SAVERECORD;
                    ItemJnlMgt.LookupName(CurrentJnlBatchName, Rec);
                    CurrPage.UPDATE(FALSE);
                end;

                trigger OnValidate()
                begin
                    ItemJnlMgt.CheckName(CurrentJnlBatchName, Rec);
                    CurrentJnlBatchNameOnAfterVali;
                end;
            }
            repeater(Control1)
            {
                ShowCaption = false;
                field("Posting Date"; REC."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Document Date"; REC."Document Date")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Entry Type"; REC."Entry Type")
                {
                    OptionCaption = 'Purchase,Sale,Positive Adjmt.,Negative Adjmt.';
                }
                field("Document No."; REC."Document No.")
                {
                    ApplicationArea = all;
                }
                field("External Document No."; REC."External Document No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Item No."; REC."Item No.")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        ItemJnlMgt.GetItem(REC."Item No.", ItemDescription);
                        REC.ShowShortcutDimCode(ShortcutDimCode);
                    end;
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
                field("Location Code"; REC."Location Code")
                {
                    ApplicationArea = all;
                    Visible = true;
                }
                field("Bin Code"; REC."Bin Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Salespers./Purch. Code"; REC."Salespers./Purch. Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Gen. Bus. Posting Group"; REC."Gen. Bus. Posting Group")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Gen. Prod. Posting Group"; REC."Gen. Prod. Posting Group")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Quantity; REC.Quantity)
                {
                    ApplicationArea = all;
                }
                field("Unit of Measure Code"; REC."Unit of Measure Code")
                {
                    ApplicationArea = all;
                }
                field("Unit Amount"; REC."Unit Amount")
                {
                    ApplicationArea = all;
                }
                field(Amount; REC.Amount)
                {
                    ApplicationArea = all;
                }
                field("Indirect Cost %"; REC."Indirect Cost %")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Unit Cost"; REC."Unit Cost")
                {
                    ApplicationArea = all;
                }
                field("Applies-to Entry"; REC."Applies-to Entry")
                {
                    ApplicationArea = all;
                }
                field("Applies-from Entry"; REC."Applies-from Entry")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Transaction Type"; REC."Transaction Type")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Transport Method"; REC."Transport Method")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Country/Region Code"; REC."Country/Region Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Reason Code"; REC."Reason Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
            }
            // group(gpe)
            // {
            field(ItemDescription; ItemDescription)
            {
                ApplicationArea = all;
                Caption = 'Item Description';
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
            }
            actionref("Item &Tracking Lines1"; "Item &Tracking Lines") { }
            actionref("Bin Contents1"; "Bin Contents") { }
            group("&Item1")
            {
                Caption = '&Item';
                actionref(Card1; Card) { }
                actionref("Ledger E&ntries1"; "Ledger E&ntries") { }
            }
            group("F&unctions1")
            {
                Caption = 'F&unctions';
                actionref("E&xplode BOM1"; "E&xplode BOM") { }
                actionref("&Calculate Whse. Adjustment1"; "&Calculate Whse. Adjustment") { }
            }

            group("P&osting11")
            {
                Caption = 'P&osting';
                actionref("Test Report1"; "Test Report") { }
                actionref("P&ost1"; "P&ost") { }
                actionref("Post and &Print1"; "Post and &Print") { }
            }

            actionref("&Print1"; "&Print") { }
        }
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                // action(Dimensions)
                // {ApplicationArea = all;
                //     Caption = 'Dimensions';
                //     Image = Dimensions;
                //     RunObject = Page 545;
                //                     RunPageLink = Table ID=CONST(83), Journal Template Name=FIELD(Journal Template Name), Journal Batch Name=FIELD(Journal Batch Name), Journal Line No.=FIELD(Line No.);
                //     ShortCutKey = 'Maj+Ctrl+D';
                // }
                action("Item &Tracking Lines")
                {
                    ApplicationArea = all;
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;

                    trigger OnAction()
                    begin
                        REC.OpenItemTrackingLines(FALSE);
                    end;
                }
                action("Bin Contents")
                {
                    ApplicationArea = all;
                    Caption = 'Bin Contents';
                    Image = BinContent;
                    RunObject = Page "Bin Contents List";
                    RunPageLink = "Location Code" = FIELD("Location Code"), "Item No." = FIELD("Item No."), "Variant Code" = FIELD("Variant Code");
                    RunPageView = SORTING("Location Code", "Item No.", "Variant Code");
                }
            }
            group("&Item")
            {
                Caption = '&Item';
                action(Card)
                {
                    ApplicationArea = all;
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Item List";
                    RunPageLink = "No." = FIELD("Item No.");
                    ShortCutKey = 'Maj+F5';
                }
                action("Ledger E&ntries")
                {
                    ApplicationArea = all;
                    Caption = 'Ledger E&ntries';
                    RunObject = Page "Item Ledger Entries";
                    RunPageLink = "Item No." = FIELD("Item No.");
                    RunPageView = SORTING("Item No.");
                    ShortCutKey = 'Ctrl+F7';
                }
                //GL2024  group("Item Availability by")
                //  {
                //  Caption = 'Item Availability by';
                // action(Period)
                // {ApplicationArea = all;
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
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("E&xplode BOM")
                {
                    ApplicationArea = all;
                    Caption = 'E&xplode BOM';
                    Image = ExplodeBOM;
                    RunObject = Codeunit "Item Jnl.-Explode BOM";
                }
                action("&Calculate Whse. Adjustment")
                {
                    ApplicationArea = all;
                    Caption = '&Calculate Whse. Adjustment';
                    Ellipsis = true;

                    trigger OnAction()
                    begin
                        CalcWhseAdjmt.SetItemJnlLine(Rec);
                        CalcWhseAdjmt.RUNMODAL;
                        CLEAR(CalcWhseAdjmt);
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
                        ReportPrint.PrintItemJnlLine(Rec);
                    end;
                }
                action("P&ost")
                {
                    ApplicationArea = all;
                    Caption = 'P&ost';
                    Image = Post;

                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin

                        CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post", Rec);
                        CurrentJnlBatchName := REC.GETRANGEMAX("Journal Batch Name");
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Post and &Print")
                {
                    ApplicationArea = all;
                    Caption = 'Post and &Print';
                    Image = PostPrint;

                    ShortCutKey = 'Maj+F11';

                    trigger OnAction()
                    begin
                        CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post+Print", Rec);
                        CurrentJnlBatchName := REC.GETRANGEMAX("Journal Batch Name");
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


                trigger OnAction()
                var
                    ItemJnlLine: Record "Item Journal Line";
                begin
                    ItemJnlLine.COPY(Rec);
                    ItemJnlLine.SETRANGE("Journal Template Name", REC."Journal Template Name");
                    ItemJnlLine.SETRANGE("Journal Batch Name", REC."Journal Batch Name");
                    REPORT.RUNMODAL(REPORT::"Inventory Movement", TRUE, TRUE, ItemJnlLine);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        REC.ShowShortcutDimCode(ShortcutDimCode);
        OnAfterGetCurrRecord;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        IF REC."Entry Type" > REC."Entry Type"::"Negative Adjmt." THEN
            ERROR(Text000, REC."Entry Type");
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

        //SetUpNewLineGMAO(xRec);
        //"Work order" := xRec."Work order";
        //"Work sheet" := xRec."Work sheet";
        CLEAR(ShortcutDimCode);
        OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage()
    var
        JnlSelected: Boolean;
    begin
        ItemJnlMgt.TemplateSelection(PAGE::"Item Journal", 0, FALSE, Rec, JnlSelected);
        IF NOT JnlSelected THEN
            ERROR('');
        ItemJnlMgt.OpenJnl(CurrentJnlBatchName, Rec);
        /*wmgt.GET;
        IF wmgt."Feuille Déf con. Article" <> '' THEN
         BEGIN
         CurrentJnlBatchName := wmgt."Feuille Déf con. Article";
         ItemJnlMgt.CheckName(CurrentJnlBatchName,Rec);
         Currpage.SAVERECORD;
         ItemJnlMgt.SetName(CurrentJnlBatchName,Rec);
         Currpage.UPDATE(FALSE);
        
         END;
         */

    end;

    var
        Text000: Label 'You cannot use entry type %1 in this journal.';
        ItemJnlMgt: Codeunit ItemJnlManagement;
        ReportPrint: Codeunit "Test Report-Print";
        CalcWhseAdjmt: Report "Calculate Whse. Adjustment";
        CurrentJnlBatchName: Code[10];
        ItemDescription: Text[50];
        ShortcutDimCode: array[8] of Code[20];
    //GL3900    ART: Record "ARTICLE/BT";
    //GL3900    wmgt: Record "Work Setup";

    local procedure CurrentJnlBatchNameOnAfterVali()
    begin
        CurrPage.SAVERECORD;
        ItemJnlMgt.SetName(CurrentJnlBatchName, Rec);
        CurrPage.UPDATE(FALSE);
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        ItemJnlMgt.GetItem(REC."Item No.", ItemDescription);
    end;
}

