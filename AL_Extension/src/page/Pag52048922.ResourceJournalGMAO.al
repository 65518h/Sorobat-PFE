page 52048922 "Resource Journal GMAO"
{    //GL2024  ID dans Nav 2009 : "39002101"
    AutoSplitKey = true;
    Caption = 'Resource Journal';
    DataCaptionFields = "Journal Batch Name";
    DelayedInsert = true;
    PageType = List;
    SaveValues = true;
    SourceTable = "Res. Journal Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            field(CurrentJnlBatchName; CurrentJnlBatchName)
            {
                ApplicationArea = all;
                Caption = 'Batch Name';
                Lookup = true;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    CurrPage.SAVERECORD;
                    ResJnlManagement.LookupName(CurrentJnlBatchName, Rec);
                    CurrPage.UPDATE(FALSE);
                end;

                trigger OnValidate()
                begin
                    ResJnlManagement.CheckName(CurrentJnlBatchName, Rec);
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
                    ApplicationArea = all;
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
                field("Resource No."; REC."Resource No.")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        ResJnlManagement.GetRes(REC."Resource No.", ResName);
                        REC.ShowShortcutDimCode(ShortcutDimCode);
                    end;
                }
                field("Resource Group No."; REC."Resource Group No.")
                {
                    ApplicationArea = all;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        REC.ShowShortcutDimCode(ShortcutDimCode);
                    end;
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
                field("Work Type Code"; REC."Work Type Code")
                {
                    ApplicationArea = all;
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
                field("Direct Unit Cost"; REC."Direct Unit Cost")
                {
                    ApplicationArea = all;
                }
                field("Unit Cost"; REC."Unit Cost")
                {
                    ApplicationArea = all;
                }
                field("Total Cost"; REC."Total Cost")
                {
                    ApplicationArea = all;
                }
                field("Unit Price"; REC."Unit Price")
                {
                    ApplicationArea = all;
                }
                field("Total Price"; REC."Total Price")
                {
                    ApplicationArea = all;
                }
                //DYS supprimer dans BC
                // field(Chargeable; Chargeable)
                // {ApplicationArea = all;
                // }
                field("Reason Code"; REC."Reason Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
            }
            //GL2024 group(gpe)
            // {
            field(ResName; ResName)
            {
                ApplicationArea = all;
                Caption = 'Resource Name';
                Editable = false;
            }
            // }
        }
    }

    actions
    {
        area(Promoted)
        {
            group("&Resource1")
            {
                Caption = '&Resource';
                actionref(Card1; Card)
                { }
                actionref("Ledger E&ntries1"; "Ledger E&ntries")
                { }
            }

            group("P&osting1")
            {
                Caption = 'P&osting';
                actionref("Test Report1"; "Test Report") { }
                actionref("P&ost1"; "P&ost") { }
                actionref("Post and &Print1"; "Post and &Print") { }
            }
        }
        area(navigation)
        {
            /*GL2024  group("&Line")
              {
                  Caption = '&Line';
                  // action(Dimensions)
                  // {ApplicationArea = all;
                  //     Caption = 'Dimensions';
                  //     Image = Dimensions;
                  //     RunObject = Page 545;
                  //                     RunPageLink = Table ID=CONST(207), Journal Template Name=FIELD(Journal Template Name), Journal Batch Name=FIELD(Journal Batch Name), Journal Line No.=FIELD(Line No.);
                  //     ShortCutKey = 'Maj+Ctrl+D';
                  // }
              }*/
            group("&Resource")
            {
                Caption = '&Resource';
                action(Card)
                {
                    ApplicationArea = all;
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Resource List";
                    RunPageLink = "No." = FIELD("Resource No.");
                    ShortCutKey = 'Maj+F5';
                }
                action("Ledger E&ntries")
                {
                    ApplicationArea = all;
                    Caption = 'Ledger E&ntries';
                    RunObject = Page "Resource Ledger Entries";
                    RunPageLink = "Resource No." = FIELD("Resource No.");
                    RunPageView = SORTING("Resource No.");
                    ShortCutKey = 'Ctrl+F7';
                }
            }
        }
        area(processing)
        {
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
                        ReportPrint.PrintResJnlLine(Rec);
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
                        CODEUNIT.RUN(CODEUNIT::"Res. Jnl.-Post", Rec);
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
                        CODEUNIT.RUN(CODEUNIT::"Res. Jnl.-Post+Print", Rec);
                        CurrentJnlBatchName := REC.GETRANGEMAX("Journal Batch Name");
                        CurrPage.UPDATE(FALSE);
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
        REC.SetUpNewLine(xRec);
        CLEAR(ShortcutDimCode);
        OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage()
    var
        JnlSelected: Boolean;
    begin
        ResJnlManagement.TemplateSelection(PAGE::"Resource Journal", FALSE, Rec, JnlSelected);
        IF NOT JnlSelected THEN
            ERROR('');
        ResJnlManagement.OpenJnl(CurrentJnlBatchName, Rec);
    end;

    var
        ResJnlManagement: Codeunit ResJnlManagement;
        ReportPrint: Codeunit "Test Report-Print";
        CurrentJnlBatchName: Code[10];
        ResName: Text[30];
        ShortcutDimCode: array[8] of Code[20];

    local procedure CurrentJnlBatchNameOnAfterVali()
    begin
        CurrPage.SAVERECORD;
        ResJnlManagement.SetName(CurrentJnlBatchName, Rec);
        CurrPage.UPDATE(FALSE);
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        ResJnlManagement.GetRes(REC."Resource No.", ResName);
    end;
}

