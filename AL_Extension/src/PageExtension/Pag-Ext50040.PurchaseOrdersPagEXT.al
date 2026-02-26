PageExtension 50040 "Purchase Orders_PagEXT" extends "Purchase Orders"
{
    DataCaptionExpression = title;
    //GL2024   DataCaptionFields = "No.",Description;
    layout
    {

        addafter("Expected Receipt Date")
        {
            field("Job No."; Rec."Job No.")
            {
                ApplicationArea = all;
            }
        }

    }
    actions
    {
        modify("Show Document")
        {
            Visible = false;
        }
        addafter("Show Document")
        {
            action("Show Document 2")
            {
                ApplicationArea = Suite;
                Caption = 'Show Document ';
                Image = View;
                Promoted = true;
                ShortCutKey = 'Shift+F7';
                trigger OnAction()
                var

                    lPurchaseQuote: Page "Purchase Quote";
                    lPurchaseOrder: Page "Purchase Order";
                    lPurchaseHeader: Record "Purchase Header";
                begin

                    //CONSULT
                    lPurchaseHeader.SETRANGE("Document Type", rec."Document Type");
                    lPurchaseHeader.SETRANGE("No.", rec."Document No.");
                    CASE rec."Document Type" OF
                        rec."Document Type"::Quote:
                            BEGIN
                                CLEAR(lPurchaseQuote);
                                lPurchaseQuote.SETTABLEVIEW(lPurchaseHeader);
                                lPurchaseQuote.RUN;
                            END;
                        rec."Document Type"::Order:
                            BEGIN
                                CLEAR(lPurchaseOrder);
                                lPurchaseOrder.SETTABLEVIEW(lPurchaseHeader);
                                lPurchaseOrder.RUN;
                            END;
                    END;
                    //CONSULT//

                end;
            }
        }
    }
    trigger OnOpenPage()
    BEGIN
        //CONSULT
        IF rec.GETRANGEMAX("Document Type") = rec."Document Type"::Quote THEN
            Title := tPurchaseQuote
        ELSE
            Title := tPurchaseOrder;
        //CONSULT//
    END;

    VAR
        Title: Text[30];
        tPurchaseOrder: Label 'Purchase Orders';
        tPurchaseQuote: Label 'Offertes';
}


