PageExtension 50212 "Get Shipment Lines_PagEXT" extends "Get Shipment Lines"

{


    layout
    {

        addafter("Document No.")
        {
            field("N° BL Central"; Rec."N° BL Central")
            {
                ApplicationArea = all;
            }
            field("Order No."; Rec."Order No.")
            {
                ApplicationArea = all;
            }
            field("Posting Date"; Rec."Posting Date")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {

    }
    trigger OnOpenPage()
    VAR
        lSalesHeader: Record "Sales Header";
    begin

        //DEVIS
        /*GL2024 ERREUR ERRUR RUN PAGE IF rec.FIND('+') THEN
             REPEAT
                 rec.MARK(TRUE);
                 IF lSalesHeader.GET(lSalesHeader."Document Type"::Order, rec."Order No.") THEN
                     IF (lSalesHeader."Invoicing Method" <> lSalesHeader."Invoicing Method"::Direct) OR
                        (lSalesHeader."Order Type" <> lSalesHeader."Order Type"::" ") THEN
                         rec.MARK(FALSE);
             UNTIL rec.NEXT(-1) = 0;
         rec.MARKEDONLY(TRUE);*/
        //DEVIS//
    end;

}
