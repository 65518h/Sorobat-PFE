PageExtension 50224 "Warehouse Receipt_PagEXT" extends "Warehouse Receipt"

{
    layout
    {

    }

    actions
    {
        addafter("CalculateCrossDock")
        {
            action("PV Reception")
            {
                Caption = 'PV Reception';
                ApplicationArea = all;
                ShortCutKey = F9;
                trigger OnAction()
                VAR
                    IntNumSequence: Integer;
                    RecLPvReception: Record "PV Reception";
                begin

                    // >> HJ DSFT 25-04-2012
                    IntNumSequence := Currpage.WhseReceiptLines.page.InsertPVReception;
                    rec."N° Sequence" := IntNumSequence;
                    rec.MODIFY;
                    RecLPvReception.SETRANGE("N° Sequence", IntNumSequence);
                    IF RecLPvReception.FINDFIRST THEN page.RUN(page::"PV Reception", RecLPvReception);
                    // >> HJ DSFT 25-04-2012
                end;
            }
        }
        addafter(CalculateCrossDock_Promoted)
        {
            actionref("PV Reception1"; "PV Reception")
            {

            }
        }
    }



    PROCEDURE InsertPvReception();
    BEGIN

        // >> HJ DSFT 25-04-2012
        Currpage.WhseReceiptLines.page.InsertPVReception;
        // >> HJ DSFT 25-04-2012

    END;

    PROCEDURE UpdateFields();
    BEGIN

        // >> HJ DSFT 25-04-2012
        IF RecWarehouseReceiptHeader.GET(rec."No.") THEN BEGIN
            //RecWarehouseReceiptHeader."N° Sequence":=0;
            RecWarehouseReceiptHeader."Vendor Shipment No." := '';
            IF RecWarehouseReceiptHeader.MODIFY THEN;
            Currpage.UPDATE;
        END;
        Currpage.WhseReceiptLines.page.PurgeDonnées;
        // >> HJ DSFT 25-04-2012
    END;



    var

        RecWarehouseReceiptHeader: Record "Warehouse Receipt Header";
}