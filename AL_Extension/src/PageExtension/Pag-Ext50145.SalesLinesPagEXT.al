PageExtension 50145 "Sales Lines_PagEXT" extends "Sales Lines"
{
    DataCaptionExpression = FORMAT(rec."Order Type");
    //GL2024 SourceTableView = SORTING("Document Type", "Document No.", "Line No.");
    layout
    {
        modify("No.")
        {
            trigger OnLookup(var Text: Text): Boolean
            VAR
                lMultiple: Boolean;
                lLookup: Codeunit 8001427;

                wRecordref: RecordRef;
            begin
                //+ONE+
                CASE rec.Type OF
                    rec.Type::Item:
                        BEGIN
                            wRecordref.OPEN(DATABASE::Item);
                            rec.wLookUpNo(Rec, xRec, wRecordref, lMultiple, FALSE);
                        END;
                    rec.Type::Resource:
                        BEGIN
                            wRecordref.OPEN(DATABASE::Resource);
                            rec.wLookUpNo(Rec, xRec, wRecordref, lMultiple, FALSE);
                        END
                    ELSE
                        //+REF+SUGG_ACC
                        lLookup.SalesLineNo(Rec);
                //+REF+SUGG_ACC//
                END;
                wRecordref.CLOSE;
                //+ONE+//
            end;
        }
        addafter("Sell-to Customer No.")
        {
            field("Presentation Code"; Rec."Presentation Code")
            {
                ApplicationArea = all;
            }
        }
        addafter(Type)
        {
            field("Line Type"; Rec."Line Type")
            {
                ApplicationArea = all;
            }

        }

        addafter("No.")
        {
            field("Cross-Reference No."; Rec."Item Reference No.")
            {
                ApplicationArea = all;
            }
        }
        addafter(Description)
        {
            field("Purchasing Code"; Rec."Purchasing Code")
            {
                ApplicationArea = all;
            }
            field("Vendor No."; Rec."Vendor No.")
            {
                ApplicationArea = all;

            }
        }
        addafter(Reserve)
        {
            field(Rate; Rec.Rate)
            {
                ApplicationArea = all;
                Visible = false;
            }
            field(Duration; Rec.Duration)
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Need Qty"; Rec."Need Qty")
            {
                ApplicationArea = all;
                Visible = "Need QtyVISIBLE";
            }
        }
        addafter(Quantity)
        {
            field("Quantity (Base)"; Rec."Quantity (Base)")
            {
                ApplicationArea = all;
            }
        }

        addafter("Unit of Measure Code")
        {
            field("Total Cost (LCY)"; Rec."Total Cost (LCY)")
            {
                ApplicationArea = all;
                Visible = FALSE;
            }
            field("Overhead Amount (LCY)"; Rec."Overhead Amount (LCY)")
            {
                ApplicationArea = all;
                Visible = FALSE;
            }
            field("Job Costs (LCY)"; Rec."Job Costs (LCY)")
            {
                ApplicationArea = all;
                Visible = FALSE;
            }
            field("Theoretical Profit Amount(LCY)"; Rec."Theoretical Profit Amount(LCY)")
            {
                ApplicationArea = all;
            }
        }
        addafter("Line Amount")
        {
            field("Outstanding Amt Excl VAT(LCY)"; Rec."Outstanding Amt Excl VAT(LCY)")
            {
                ApplicationArea = all;
            }
        }

        addafter("Work Type Code")
        {
            field(RowID1; Rec.RowID1)
            {
                ApplicationArea = all;
            }
        }

        addafter("Outstanding Quantity")
        {
            field("Purch. Order Qty (Base)"; Rec."Purch. Order Qty (Base)")
            {
                Visible = FALSE;
                ApplicationArea = all;
            }
            field("Purch. Order Receipt Date"; Rec."Purch. Order Receipt Date")
            {
                Visible = FALSE;
                ApplicationArea = all;
            }
            field("Purch. Order Rcpt. Qty (Base)"; Rec."Purch. Order Rcpt. Qty (Base)")
            {
                Visible = FALSE;
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        addafter("&Line")
        {
            action("NotOrder")
            {
                Caption = 'Do Not Order';
                ApplicationArea = all;
                Visible = NotOrderVISIBLE;
                trigger OnAction()
                VAR
                    lSalesLine: Record "Sales Line";
                begin

                    IF lSalesLine.GET(lSalesLine."Document Type"::Order, rec."Supply Order No.", rec."Supply Order Line No.") THEN BEGIN
                        lSalesLine.Quantity -= rec."Quantity (Base)";
                        lSalesLine.VALIDATE(Quantity);
                        IF lSalesLine.Quantity > 0 THEN
                            lSalesLine.MODIFY
                        ELSE
                            lSalesLine.DELETE(TRUE);
                    END;
                    rec.VALIDATE("Supply Order No.", '');
                    rec."Supply Order Line No." := 0;
                    rec.MODIFY;
                end;
            }


        }
        addafter(Category_Process)
        {
            actionref("NotOrder1"; "NotOrder")
            { }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.FilterGroup(0);
        rec.SetCurrentKey("Document Type", "Document No.", "Line No.");

        Rec.FilterGroup(2);
    end;

    trigger OnAfterGetRecord()
    begin
        //CDE_INTERNE
        rec.CALCFIELDS("Need Qty");
        //CDE_INTERNE//
    end;

    trigger OnAfterGetCurrRecord()
    VAR
        lClassicVisible: Boolean;
    begin

        //CDE_INTERNE
        //RTC - 2009
        IF rec."Supply Order No." <> '' THEN BEGIN
            lClassicVisible := FALSE;
            "Need QtyVISIBLE" := (lClassicVisible);
            lClassicVisible := TRUE;
            NotOrderVISIBLE := (lClassicVisible);
        END
        ELSE BEGIN
            lClassicVisible := TRUE;
            "Need QtyVISIBLE" := (lClassicVisible);
            lClassicVisible := FALSE;
            NotOrderVISIBLE := (lClassicVisible);
        END;
        //RTC - 2009//
        //CDE_INTERNE//
    end;

    var
        "Need QtyVISIBLE": Boolean;
        NotOrderVISIBLE: Boolean;
}