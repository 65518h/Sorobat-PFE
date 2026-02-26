PageExtension 50097 "Req. Worksheet_PagEXT" extends "Req. Worksheet"
{
    layout
    {

        addafter(Confirmed)
        {
            field("Job No."; Rec."Job No.")
            {
                Visible = false;
                ApplicationArea = all;
            }
            field("Job Task No."; Rec."Job Task No.")
            {
                Visible = false;
                ApplicationArea = all;
            }

            field("Work Center No."; Rec."Work Center No.")
            {
                Visible = false;
                ApplicationArea = all;
            }
        }

    }
    actions
    {
        modify("Sales &Order")
        {
            Visible = false;

        }

        addafter("Sales &Order")
        {
            action("Sales &Order2")
            {

                AccessByPermission = TableData "Sales Header" = R;
                ApplicationArea = Planning;
                Caption = 'Sales &Order';
                Image = Document;
                Enabled = Rec."Sales Order No." <> '';
                ToolTip = 'View the sales order that is the source of the line. This applies only to drop shipments and special orders.';

                trigger OnAction()
                begin
                    SalesHeader.SetRange("No.", Rec."Sales Order No.");
                    //DEVIS
                    IF wSalesOrder2.GET(wSalesOrder2."Document Type"::Order, rec."Sales Order No.") AND
                    (wSalesOrder2."Order Type" = wSalesOrder2."Order Type"::" ") THEN BEGIN
                        wNavibatOrder.SETTABLEVIEW(SalesHeader);
                        wNavibatOrder.EDITABLE := FALSE;
                        wNavibatOrder.RUN;
                    END ELSE BEGIN
                        //DEVIS//

                        SalesOrder.SetTableView(SalesHeader);
                        SalesOrder.Editable := false;
                        SalesOrder.Run();
                        //DEVIS
                    END;
                    //DEVIS//
                end;
            }
        }
        addafter("Sales &Order_Promoted")
        {
            actionref("Sales &Order21"; "Sales &Order2")
            {

            }
        }
        modify(Action75)
        {
            Visible = false;
        }

        addafter(Action75)
        {
            action(Action750)
            {
                AccessByPermission = TableData "Sales Header" = R;
                ApplicationArea = Planning;
                Caption = 'Sales &Order';
                Image = Document;
                Enabled = Rec."Sales Order No." <> '';
                ToolTip = 'View the sales order that is the source of the line. This applies only to drop shipments and special orders.';

                trigger OnAction()
                begin
                    SalesHeader.SetRange("No.", Rec."Sales Order No.");
                    //DEVIS
                    IF wSalesOrder2.GET(wSalesOrder2."Document Type"::Order, rec."Sales Order No.") AND
                    (wSalesOrder2."Order Type" = wSalesOrder2."Order Type"::" ") THEN BEGIN
                        wNavibatOrder.SETTABLEVIEW(SalesHeader);
                        wNavibatOrder.EDITABLE := FALSE;
                        wNavibatOrder.RUN;
                    END ELSE BEGIN
                        //DEVIS//
                        SalesOrder.SetTableView(SalesHeader);
                        SalesOrder.Editable := false;
                        SalesOrder.Run();
                        //DEVIS
                    END;
                    //DEVIS//
                end;
            }
        }
        addafter(Action75_Promoted)
        {
            actionref(Action7501; Action750)
            {

            }
        }
        addafter("F&unctions")
        {
            action("Wor&Kflow")
            {
                ApplicationArea = all;
                caption = 'Wor&Kflow';
                trigger OnAction()
                VAR
                    lRecordRef: RecordRef;
                    lWorkflowConnector: Codeunit "Workflow Connector";
                BEGIN

                    lRecordRef.GETTABLE(Rec);
                    lWorkflowConnector.OnPush(PAGE::"Req. Worksheet", lRecordRef);


                end;
            }
        }
        addafter(CalculatePlan_Promoted)
        {
            actionref("Wor&Kflow1"; "Wor&Kflow")
            {

            }
        }
    }
    var
        wSalesOrder2: Record "Sales Header";
        wNavibatOrder: Page "Sales Order";
        SalesHeader: Record "Sales Header";
        SalesOrder: Page "Sales Order";
}


