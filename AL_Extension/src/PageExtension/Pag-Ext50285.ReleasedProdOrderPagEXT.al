PageExtension 50285 "Released Prod Order_PagEXT" extends "Released Production Order"
{

    layout
    {
        modify("Due Date")
        {
            trigger OnAfterValidate()
            begin
                DateEcheance := rec."Due Date";
            end;
        }

        addafter("Source No.")
        {
            field(Centrale; Rec.Centrale)
            {
                ApplicationArea = all;
            }
            field(Client; Rec.Client)
            {
                ApplicationArea = all;
            }
            field(Destination; Rec.Destination)
            {
                ApplicationArea = all;
            }
            field("N° BL"; Rec."N° BL")
            {
                ApplicationArea = all;
            }
        }
        addafter(Quantity)
        {
            field(Camion; Rec.Camion)
            {
                ApplicationArea = all;
            }
            field(Chauffeur; Rec.Chauffeur)
            {
                ApplicationArea = all;
            }
            field("Nombre Heure Travail"; Rec."Nombre Heure Travail")
            {
                ApplicationArea = all;
            }
            field("Nombre Voyage"; Rec."Nombre Voyage")
            {
                ApplicationArea = all;
            }
            field("Cout M3"; Rec."Cout M3")
            {
                ApplicationArea = all;
            }
            field(Observation; Rec.Observation)
            {
                ApplicationArea = all;
            }
        }
        addafter("Bin Code")
        {
            field("Last Date Modified2"; Rec."Last Date Modified")
            {
                ApplicationArea = all;
            }
            field(Blocked2; Rec.Blocked)
            {
                ApplicationArea = all;
            }
            field(Stockable; Rec.Stockable)
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        addafter("&Print")
        {
            action("Creer Prod")
            {
                Caption = 'Create Prod';
                ApplicationArea = all;
                trigger OnAction()
                begin


                    rec.TESTFIELD("Source No.");
                    rec.TESTFIELD(Centrale);
                    rec.TESTFIELD(Client);
                    rec.TESTFIELD(Destination);
                    rec.TESTFIELD(Quantity);
                    rec.TESTFIELD("Due Date");
                    rec.TESTFIELD("N° BL");
                    IF NOT CONFIRM('Confirmer ?') THEN EXIT;
                    DateEcheance := rec."Due Date";
                    Actualliser;

                    IF ProductionOrder.GET(rec.Status, rec."No.") THEN BEGIN
                        ProductionOrder."Due Date" := DateEcheance;
                        ProductionOrder.MODIFY;
                    END;
                    IF ProdOrderLine.GET(ProductionOrder.Status, ProductionOrder."No.", 10000) THEN BEGIN
                        UpdateProdOrderCost.UpdateUnitCostOnProdOrder(ProdOrderLine, CalcMethod = CalcMethod::"All Levels", UpdateReservations);
                        IF Item.GET(ProductionOrder."Source No.") THEN BEGIN
                            Item."Unit Cost" := ProdOrderLine."Unit Cost";
                            Item."Last Direct Cost" := ProdOrderLine."Unit Cost";
                            Item.MODIFY;
                        END;
                    END;
                    //DYS
                    // Currpage.ProdOrderLines.page.ShowProductionJournal;
                    ShowProductionJournal;
                end;
            }
        }
        addfirst(Category_Print)
        {
            actionref("Creer Prod1"; "Creer Prod")
            {

            }
        }
    }
    PROCEDURE Actualliser();
    VAR
        CalcProdOrder: Codeunit "Calculate Prod. Order";
        CreateProdOrderLines: Codeunit "Create Prod. Order Lines";
        WhseProdRelease: Codeunit "Whse.-Production Release";
        WhseOutputProdRelease: Codeunit "Whse.-Output Prod. Release";
        Window: Dialog;
        Direction: Option Forward,Backward;
        CalcLines: Boolean;
        CalcRoutings: Boolean;
        CalcComponents: Boolean;
        CreateInbRqst: Boolean;
        Text000: label 'Refreshing Production Orders...\\';
        Text001: label 'Status         #1##########\';
        Text002: label 'No.            #2##########';
        Text003: label 'Routings must be calculated, when lines are calculated.';
        Text004: label 'Component Need must be calculated, when lines are calculated.';
        Item: Record Item;
        ProdOrderLine: Record "Prod. Order Line";
        ProdOrderRtngLine: Record "Prod. Order Routing Line";
        ProdOrderComp: Record "Prod. Order Component";
        Family: Record Family;
        ProdOrderStatusMgt: Codeunit "Prod. Order Status Management";
        RoutingNo: Code[20];
    BEGIN
        "Production Order".COPY(Rec);
        IF "Production Order".Status = "Production Order".Status::Finished THEN
            EXIT;
        IF Direction = Direction::Backward THEN
            rec.TESTFIELD("Due Date");

        RoutingNo := rec."Routing No.";
        CASE rec."Source Type" OF
            rec."Source Type"::Item:
                IF Item.GET(rec."Source No.") THEN
                    RoutingNo := Item."Routing No.";
            rec."Source Type"::Family:
                IF Family.GET(rec."Source No.") THEN
                    RoutingNo := Family."Routing No.";
        END;
        IF RoutingNo <> rec."Routing No." THEN BEGIN
            rec."Routing No." := RoutingNo;
            rec.MODIFY;
        END;

        ProdOrderLine.LOCKTABLE;

        //CheckReservationExist;

        IF 1 = 1 THEN
            CreateProdOrderLines.Copy("Production Order", Direction, '', false)
        ELSE BEGIN
            ProdOrderLine.SETRANGE(Status, rec.Status);
            ProdOrderLine.SETRANGE("Prod. Order No.", rec."No.");
            IF CalcRoutings OR CalcComponents THEN BEGIN
                IF ProdOrderLine.FIND('-') THEN
                    REPEAT
                        IF CalcRoutings THEN BEGIN
                            ProdOrderRtngLine.SETRANGE(Status, rec.Status);
                            ProdOrderRtngLine.SETRANGE("Prod. Order No.", rec."No.");
                            ProdOrderRtngLine.SETRANGE("Routing Reference No.", ProdOrderLine."Routing Reference No.");
                            ProdOrderRtngLine.SETRANGE("Routing No.", ProdOrderLine."Routing No.");
                            ProdOrderRtngLine.DELETEALL(TRUE);
                        END;
                        IF CalcComponents THEN BEGIN
                            ProdOrderComp.SETRANGE(Status, rec.Status);
                            ProdOrderComp.SETRANGE("Prod. Order No.", rec."No.");
                            ProdOrderComp.SETRANGE("Prod. Order Line No.", ProdOrderLine."Line No.");
                            ProdOrderComp.DELETEALL(TRUE);
                        END;
                    UNTIL ProdOrderLine.NEXT = 0;
                IF ProdOrderLine.FIND('-') THEN
                    REPEAT
                        ProdOrderLine."Due Date" := rec."Due Date";
                        CalcProdOrder.Calculate(ProdOrderLine, Direction, CalcRoutings, CalcComponents, FALSE, FALSE);
                    UNTIL ProdOrderLine.NEXT = 0;
            END;
        END;
        IF (Direction = Direction::Backward) AND
           (rec."Source Type" = rec."Source Type"::Family)
        THEN BEGIN
            rec.SetUpdateEndDate;

            rec.VALIDATE("Due Date", rec."Due Date");
        END;

        IF rec.Status = rec.Status::Released THEN BEGIN
            ProdOrderStatusMgt.FlushProdOrder("Production Order", "Production Order".Status, WORKDATE);
            WhseProdRelease.Release("Production Order");
            IF CreateInbRqst THEN
                WhseOutputProdRelease.Release("Production Order");
        END;
    END;

    PROCEDURE ShowProductionJournal();
    VAR
        ProdOrder: Record "Production Order";
        ProductionJrnlMgt: Codeunit "Production Journal Mgt";
    BEGIN
        CurrPage.SAVERECORD;
        //"Production Order".
        ProdOrder.GET(rec.Status, rec."No.");

        CLEAR(ProductionJrnlMgt);
        "Production Order Line".SETRANGE(Status, "Production Order".Status);
        "Production Order Line".SETRANGE("Prod. Order No.", "Production Order"."No.");
        IF "Production Order Line".FINDFIRST THEN
            ProductionJrnlMgt.Handling(ProdOrder, "Production Order Line"."Line No.");
    END;






    trigger OnOpenPage()
    begin
        //IF rec.Automate THEN CurrPage.EDITABLE(FALSE) ELSE CurrPage.EDITABLE(TRUE);
    end;

    trigger OnAfterGetRecord()
    begin
        //IF rec.Automate THEN CurrPage.EDITABLE(FALSE) ELSE CurrPage.EDITABLE(TRUE);
    end;


    var
        "Production Order": Record "Production Order";
        "Production Order Line": Record "Prod. Order Line";
        ProdOrderStatusManagement: Codeunit "Prod. Order Status Management";
        DateEcheance: Date;
        ProductionOrder: Record "Production Order";
        Item: Record Item;
        CalcMethod: Option "One Level","All Levels";
        UpdateReservations: Boolean;
        UpdateProdOrderCost: Codeunit "Update Prod. Order Cost";
        ProdOrderLine: Record "Prod. Order Line";
}