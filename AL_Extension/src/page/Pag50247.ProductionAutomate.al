page 50247 "Production Automate"
{
    Caption = 'Production Automate';
    PageType = Card;
    SourceTable = "Production Order";
    SourceTableView = WHERE(Status = CONST(Released), Automate = CONST(true));
    ApplicationArea = all;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; rec."No.")
                {
                    Lookup = false;

                    trigger OnAssistEdit()
                    begin
                        IF rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Description 2"; rec."Description 2")
                {
                    ApplicationArea = all;
                }
                field("Source Type"; rec."Source Type")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        IF xRec."Source Type" <> Rec."Source Type" THEN
                            rec."Source No." := '';
                    end;
                }
                field("Source No."; rec."Source No.")
                {
                    ApplicationArea = all;
                    Caption = 'Produit';
                }
                field(Centrale; rec.Centrale)
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(Client; rec.Client)
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(Destination; rec.Destination)
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
                field("Due Date"; rec."Due Date")
                {
                    ApplicationArea = all;
                    Caption = 'Date Bon Sortie';

                    trigger OnValidate()
                    begin
                        DueDateOnAfterValidate;
                    end;
                }
                field("N° BL"; rec."N° BL")
                {
                    ApplicationArea = all;
                    Caption = 'N° Bon Sortie';
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = all;
                }
                field(Camion; rec.Camion)
                {
                    ApplicationArea = all;
                }
                field(Chauffeur; rec.Chauffeur)
                {
                    ApplicationArea = all;
                }
                field("Nombre Heure Travail"; rec."Nombre Heure Travail")
                {
                    ApplicationArea = all;
                }
                field("Nombre Voyage"; rec."Nombre Voyage")
                {
                    ApplicationArea = all;
                }
                field("Cout M3"; rec."Cout M3")
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
                field(Observation; rec.Observation)
                {
                    ApplicationArea = all;
                    MultiLine = true;
                }
            }
            part(ProdOrderLines; "Released Prod. Order Lines")
            {
                ApplicationArea = all;
                SubPageLink = "Prod. Order No." = FIELD("No.");
            }
            group(Planning)
            {
                Caption = 'Planning';
                field("Starting Time"; rec."Starting Time")
                {
                    ApplicationArea = all;
                }
                field("Starting Date"; rec."Starting Date")
                {
                    ApplicationArea = all;
                }
                field("Ending Time"; rec."Ending Time")
                {
                    ApplicationArea = all;
                }
                field("Ending Date"; rec."Ending Date")
                {
                    ApplicationArea = all;
                }
            }
            group(Validation)
            {
                Caption = 'Validation';
                field("Inventory Posting Group"; rec."Inventory Posting Group")
                {
                    ApplicationArea = all;
                }
                field("Gen. Prod. Posting Group"; rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = all;
                }
                field("Gen. Bus. Posting Group"; rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = all;
                }
                field(Blocked; rec.Blocked)
                {
                    ApplicationArea = all;
                }
                field("Last Date Modified"; rec."Last Date Modified")
                {
                    ApplicationArea = all;
                }
                field(Stockable; rec.Stockable)
                {
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        ShortcutDimension1CodeOnAfterV;
                    end;
                }
                field("Shortcut Dimension 2 Code"; rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        ShortcutDimension2CodeOnAfterV;
                    end;
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field("Bin Code"; rec."Bin Code")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(Promoted)
        {
            group("O&rder11")
            {
                Caption = 'O&rder';
                group("E&ntries11")
                {
                    Caption = 'E&ntries';

                    actionref("&Warehouse Entries1"; "&Warehouse Entries") { }
                }
                actionref("Co&mments1"; "Co&mments") { }
                actionref(Statistics1; Statistics) { }
                actionref("Put-away/Pick Lines1"; "Put-away/Pick Lines") { }
                actionref("Registered P&ick Lines1"; "Registered P&ick Lines") { }
                actionref("Plannin&g1"; "Plannin&g") { }
            }

            group("&Line1")
            {
                Caption = '&Line';
                group("Item Availability by1")
                {
                    Caption = 'Item Availability by';

                    actionref(Period1; Period) { }
                    actionref(Variant1; Variant) { }
                    actionref(Location1; Location) { }
                }

            }

            group("F&unctions1")
            {
                Caption = 'F&unctions';

                actionref("Re&fresh1"; "Re&fresh") { }
                actionref("Re&plan1"; "Re&plan") { }
                actionref("Change &Status11"; "Change &Status") { }
                actionref("&Update Unit Cost1"; "&Update Unit Cost") { }
                actionref("Order &Tracking1"; "Order &Tracking") { }
                actionref("Create I&nbound Whse. Request1"; "Create I&nbound Whse. Request") { }
                actionref("Create Inventor&y Put-away / Pick1"; "Create Inventor&y Put-away / Pick") { }
                actionref("Create Whse. Pick1"; "Create Whse. Pick") { }
                actionref("C&opy Prod. Order Document1"; "C&opy Prod. Order Document") { }
            }

            group("&Print1")
            {
                Caption = '&Print';
                actionref("Job Card1"; "Job Card") { }
                actionref("Mat. &Requisition1"; "Mat. &Requisition") { }
                actionref("Shortage List1"; "Shortage List") { }
                actionref("Gantt Chart1"; "Gantt Chart") { }
            }

            actionref("Creer Prod1"; "Creer Prod") { }
        }
        area(navigation)
        {
            group("O&rder")
            {
                Caption = 'O&rder';
                group("E&ntries")
                {
                    Caption = 'E&ntries';
                    /*GL2024  action("Item Ledger E&ntries")
                      {
                          ApplicationArea = all;
                          Caption = 'Item Ledger E&ntries';
                          Image = ItemLedger;
                          RunObject = Page "Item Ledger Entries";
                          //GL2024  RunPageLink = "Prod. Order No." = FIELD("No.");
                          //GL2024    RunPageView = SORTING("Prod. Order No.");
                          ShortCutKey = 'Ctrl+F7';
                      }
                      action("Capacity Ledger Entries")
                      {
                          ApplicationArea = all;
                          Caption = 'Capacity Ledger Entries';
                          RunObject = Page "Capacity Ledger Entries";
                          //GL2024   RunPageLink = "Prod. Order No." = FIELD("No.");
                          //GL2024   RunPageView = SORTING("Prod. Order No.");
                      }
                      action("Value Entries")
                      {
                          ApplicationArea = all;
                          Caption = 'Value Entries';
                          Image = ValueLedger;
                          RunObject = Page "Value Entries";
                          //GL2024    RunPageLink = "Prod. Order No." = FIELD("No.");
                          //GL2024    RunPageView = SORTING("Prod. Order No.");
                      }*/
                    action("&Warehouse Entries")
                    {
                        ApplicationArea = all;
                        Caption = '&Warehouse Entries';
                        Image = BinLedger;
                        RunObject = Page "Warehouse Entries";
                        RunPageLink = "Source Type" = FILTER(83 | 5406 | 5407), "Source Subtype" = FILTER(3 | 4 | 5), "Source No." = FIELD("No.");
                        RunPageView = SORTING("Source Type", "Source Subtype", "Source No.");
                    }
                }
                action("Co&mments")
                {
                    ApplicationArea = all;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Prod. Order Comment Sheet";
                    RunPageLink = Status = FIELD(Status), "Prod. Order No." = FIELD("No.");
                }
                /* GL2024 action(Dimensions1)
                  {   ApplicationArea = all;
                      Caption = 'Dimensions';
                      Image = Dimensions;
                      RunObject = Page "Production Document Dimensions";
                      RunPageLink = "Table ID" = CONST(5405), "Document Status" = FIELD(Status), "Document No." = FIELD("No."), "Document Line No." = CONST(0), Line No.=CONST(0);
                  }*/
                separator(separator1)
                {
                }
                action(Statistics)
                {
                    ApplicationArea = all;
                    Caption = 'Statistics';
                    Image = Statistics;

                    RunObject = Page "Production Order Statistics";
                    RunPageLink = Status = FIELD(Status), "No." = FIELD("No."), "Date Filter" = FIELD("Date Filter");
                    ShortCutKey = 'F7';
                }
                separator(separator2)
                {
                }
                action("Put-away/Pick Lines")
                {
                    ApplicationArea = all;
                    Caption = 'Put-away/Pick Lines';
                    RunObject = Page "Warehouse Activity Lines";
                    RunPageLink = "Source Type" = FILTER(5406 | 5407), "Source Subtype" = CONST(3), "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.", "Source Subline No.", "Unit of Measure Code", "Action Type", "Breakbulk No.", "Original Breakbulk");
                }
                action("Registered P&ick Lines")
                {
                    ApplicationArea = all;
                    Caption = 'Registered P&ick Lines';
                    Image = RegisteredDocs;
                    RunObject = Page "Registered Whse. Act.-Lines";
                    RunPageLink = "Source Type" = CONST(5407), "Source Subtype" = CONST(3), "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.", "Source Subline No.");
                }
                separator(separator3)
                {
                }
                action("Plannin&g")
                {
                    ApplicationArea = all;
                    Caption = 'Plannin&g';

                    trigger OnAction()
                    var
                        OrderPlanning: Page "Order Planning";
                    begin
                        OrderPlanning.SetProdOrder(Rec);
                        OrderPlanning.RUNMODAL;
                    end;
                }
            }
            group("&Line")
            {
                Caption = '&Line';
                group("Item Availability by")
                {
                    Caption = 'Item Availability by';
                    action(Period)
                    {
                        ApplicationArea = all;
                        Caption = 'Period';

                        trigger OnAction()
                        begin
                            CurrPage.ProdOrderLines.PAGE.ItemAvailability2(0);
                        end;
                    }
                    action(Variant)
                    {
                        ApplicationArea = all;
                        Caption = 'Variant';

                        trigger OnAction()
                        begin
                            CurrPage.ProdOrderLines.PAGE.ItemAvailability2(1);
                        end;
                    }
                    action(Location)
                    {
                        ApplicationArea = all;
                        Caption = 'Location';

                        trigger OnAction()
                        begin
                            CurrPage.ProdOrderLines.PAGE.ItemAvailability2(2);
                        end;
                    }
                }
                /*GL2024    action("Reservation Entries")
                    {
                        ApplicationArea = all;
                        Caption = 'Reservation Entries';
                        Image = ReservationLedger;

                        trigger OnAction()
                        begin
                            //DYS action deplacer dans ligne
                            // CurrPage.ProdOrderLines.PAGE.ShowReservationEntries;
                        end;
                    }
                    action(Dimensions)
                    {
                        ApplicationArea = all;
                        Caption = 'Dimensions';
                        Image = Dimensions;
                        ShortCutKey = 'Maj+Ctrl+D';

                        trigger OnAction()
                        begin

                            //DYS action deplacer dans ligne
                            // CurrPage.ProdOrderLines.PAGE.ShowDimensions;
                        end;
                    }
                    separator(separator10)
                    {
                    }
                    action("Ro&uting")
                    {
                        ApplicationArea = all;
                        Caption = 'Ro&uting';

                        trigger OnAction()
                        begin
                            //DYS action deplacer dans ligne
                            //CurrPage.ProdOrderLines.PAGE.ShowRouting;
                        end;
                    }
                    action(Components)
                    {
                        ApplicationArea = all;
                        Caption = 'Components';
                        Image = Components;

                        trigger OnAction()
                        begin
                            //DYS action deplacer dans ligne
                            // CurrPage.ProdOrderLines.PAGE.ShowComponents;
                        end;
                    }
                    action("Item &Tracking Lines")
                    {
                        ApplicationArea = all;
                        Caption = 'Item &Tracking Lines';
                        Image = ItemTrackingLines;
                        ShortCutKey = 'Maj+Ctrl+I';

                        trigger OnAction()
                        begin
                            //DYS action deplacer dans ligne
                            //CurrPage.ProdOrderLines.PAGE.OpenItemTrackingLines;
                        end;
                    }
                    separator(separator4)
                    {
                    }
                    action("&Production Journal")
                    {
                        ApplicationArea = all;
                        Caption = '&Production Journal';

                        trigger OnAction()
                        begin
                            IF ProductionOrder.GET(rec.Status, rec."No.") THEN BEGIN
                                ProductionOrder."Due Date" := DateEcheance;
                                ProductionOrder.MODIFY;
                            END;
                            //DYS action deplacer dans ligne
                            //CurrPage.ProdOrderLines.PAGE.ShowProductionJournal;
                        end;
                    }*/
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Re&fresh")
                {
                    ApplicationArea = all;
                    Caption = 'Re&fresh';
                    Ellipsis = true;
                    Image = Refresh;

                    trigger OnAction()
                    var
                        ProdOrder: Record "Production Order";
                    begin
                        ProdOrder.SETRANGE(Status, rec.Status);
                        ProdOrder.SETRANGE("No.", rec."No.");
                        REPORT.RUNMODAL(REPORT::"Refresh Production Order", TRUE, TRUE, ProdOrder);
                    end;
                }
                action("Re&plan")
                {
                    ApplicationArea = all;
                    Caption = 'Re&plan';
                    Ellipsis = true;
                    Image = Replan;

                    trigger OnAction()
                    var
                        ProdOrder: Record "Production Order";
                    begin
                        ProdOrder.SETRANGE(Status, rec.Status);
                        ProdOrder.SETRANGE("No.", rec."No.");
                        REPORT.RUNMODAL(REPORT::"Replan Production Order", TRUE, TRUE, ProdOrder);
                    end;
                }
                separator(separator5)
                {
                }
                action("Change &Status")
                {
                    ApplicationArea = all;
                    Caption = 'Change &Status';
                    Ellipsis = true;
                    Image = ChangeStatus;
                    RunObject = Codeunit "Prod. Order Status Management";
                }
                action("&Update Unit Cost")
                {
                    ApplicationArea = all;
                    Caption = '&Update Unit Cost';
                    Ellipsis = true;
                    Image = UpdateUnitCost;

                    trigger OnAction()
                    var
                        ProdOrder: Record "Production Order";
                    begin
                        ProdOrder.SETRANGE(Status, rec.Status);
                        ProdOrder.SETRANGE("No.", rec."No.");

                        REPORT.RUNMODAL(REPORT::"Update Unit Cost", TRUE, TRUE, ProdOrder);
                    end;
                }
                separator(separator6)
                {
                }
                /*GL2024   action("&Reserve")
                   {
                       ApplicationArea = all;
                       Caption = '&Reserve';

                       trigger OnAction()
                       begin
                           //DYS action deplacer dans ligne
                           // CurrPage.ProdOrderLines.PAGE.ShowReservation;
                       end;
                   }*/
                action("Order &Tracking")
                {
                    ApplicationArea = all;
                    Caption = 'Order &Tracking';

                    trigger OnAction()
                    begin
                        CurrPage.ProdOrderLines.PAGE.ShowTracking;
                    end;
                }
                /* GL2024  action("Production Sc&hedule")
                   {   ApplicationArea = all;
                       Caption = 'Production Sc&hedule';

                       trigger OnAction()
                       var
                           ProdSchedMgt: Codeunit 5500;
                       begin
                           ProdSchedMgt.ScheduleOrder(Rec, TRUE);
                       end;
                   }*/
                separator(separator7)
                {

                }
                action("Create I&nbound Whse. Request")
                {
                    ApplicationArea = all;
                    Caption = 'Create I&nbound Whse. Request';

                    trigger OnAction()
                    var
                        WhseOutputProdRelease: Codeunit "Whse.-Output Prod. Release";
                    begin
                        IF WhseOutputProdRelease.CheckWhseRqst(Rec) THEN
                            MESSAGE(Text002)
                        ELSE BEGIN
                            CLEAR(WhseOutputProdRelease);
                            IF WhseOutputProdRelease.Release(Rec) THEN
                                MESSAGE(Text000)
                            ELSE
                                MESSAGE(Text001);
                        END;
                    end;
                }
                action("Create Inventor&y Put-away / Pick")
                {
                    ApplicationArea = all;
                    Caption = 'Create Inventor&y Put-away / Pick';
                    Ellipsis = true;
                    Image = CreateInventoryPickup;

                    trigger OnAction()
                    begin
                        rec.CreateInvtPutAwayPick;
                    end;
                }
                action("Create Whse. Pick")
                {
                    ApplicationArea = all;
                    Caption = 'Create Whse. Pick';

                    trigger OnAction()
                    var
                        ProdOrderCompLine: Record "Prod. Order Component";
                        ItemTrackingMgt: Codeunit "Item Tracking Management";
                        WhseSourceType: Option " ",Receipt,Shipment,"Internal Put-away","Internal Pick",Production;
                    begin
                        ProdOrderCompLine.RESET;
                        ProdOrderCompLine.SETRANGE(Status, rec.Status);
                        ProdOrderCompLine.SETRANGE("Prod. Order No.", rec."No.");
                        IF ProdOrderCompLine.FIND('-') THEN
                            REPEAT
                                //GL2024  ItemTrackingMgt.InitItemTrkgForTempWkshLine(
                                ItemTrackingMgt.InitItemTrackingForTempWhseWorksheetLine(
                                  WhseSourceType::Production, ProdOrderCompLine."Prod. Order No.",
                                  ProdOrderCompLine."Prod. Order Line No.", DATABASE::"Prod. Order Component",
                                  ProdOrderCompLine.Status, ProdOrderCompLine."Prod. Order No.",
                                  ProdOrderCompLine."Prod. Order Line No.", ProdOrderCompLine."Line No.");
                            UNTIL ProdOrderCompLine.NEXT = 0;
                        COMMIT;
                        rec.CreatePick(UserId, 0, FALSe, false, false);
                    end;
                }
                separator(separator8)
                {
                }
                action("C&opy Prod. Order Document")
                {
                    ApplicationArea = all;
                    Caption = 'C&opy Prod. Order Document';
                    Ellipsis = true;
                    Image = CopyDocument;

                    trigger OnAction()
                    begin
                        CopyProdOrderDoc.SetProdOrder(Rec);
                        CopyProdOrderDoc.RUNMODAL;
                        CLEAR(CopyProdOrderDoc);
                    end;
                }
            }
            group("&Print")
            {
                Caption = '&Print';
                action("Job Card")
                {
                    ApplicationArea = all;
                    Caption = 'Job Card';
                    Ellipsis = true;
                    Image = "Report";

                    trigger OnAction()
                    begin
                        ManuPrintReport.PrintProductionOrder(Rec, 0);
                    end;
                }
                action("Mat. &Requisition")
                {
                    ApplicationArea = all;
                    Caption = 'Mat. &Requisition';
                    Ellipsis = true;
                    Image = "Report";

                    trigger OnAction()
                    begin
                        ManuPrintReport.PrintProductionOrder(Rec, 1);
                    end;
                }
                action("Shortage List")
                {
                    ApplicationArea = all;
                    Caption = 'Shortage List';
                    Ellipsis = true;
                    Image = "Report";

                    trigger OnAction()
                    begin
                        ManuPrintReport.PrintProductionOrder(Rec, 2);
                    end;
                }
                action("Gantt Chart")
                {
                    ApplicationArea = all;
                    Caption = 'Gantt Chart';
                    Ellipsis = true;
                    Image = "Report";

                    trigger OnAction()
                    begin
                        ManuPrintReport.PrintProductionOrder(Rec, 3);
                    end;
                }
            }
            action("Creer Prod")
            {
                ApplicationArea = all;
                Caption = 'Creer Prod';


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
                    //  CurrPage.ProdOrderLines.PAGE.ShowProductionJournal;
                    ShowProductionJournal;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IF rec.Automate THEN CurrPage.EDITABLE(FALSE) ELSE CurrPage.EDITABLE(TRUE);
    end;

    trigger OnOpenPage()
    begin
        IF rec.Automate THEN CurrPage.EDITABLE(FALSE) ELSE CurrPage.EDITABLE(TRUE);
    end;

    var
        CopyProdOrderDoc: Report "Copy Production Order Document";
        ManuPrintReport: Codeunit "Manu. Print Report";
        Text000: Label 'Inbound Whse. Requests are created.';
        Text001: Label 'No Inbound Whse. Request is created.';
        Text002: Label 'Inbound Whse. Requests have already been created.';
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

    procedure Actualliser()
    var
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
        Text000: Label 'Refreshing Production Orders...\\';
        Text001: Label 'Status         #1##########\';
        Text002: Label 'No.            #2##########';
        Text003: Label 'Routings must be calculated, when lines are calculated.';
        Text004: Label 'Component Need must be calculated, when lines are calculated.';
        Item: Record Item;
        ProdOrderLine: Record "Prod. Order Line";
        ProdOrderRtngLine: Record "Prod. Order Routing Line";
        ProdOrderComp: Record "Prod. Order Component";
        Family: Record Family;
        ProdOrderStatusMgt: Codeunit "Prod. Order Status Management";
        RoutingNo: Code[20];
    begin
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
                        CalcProdOrder.Calculate(ProdOrderLine, Direction, CalcRoutings, CalcComponents, FALSE, false);
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
    end;

    procedure ShowProductionJournal()
    var
        ProdOrder: Record "Production Order";
        ProductionJrnlMgt: Codeunit "Production Journal Mgt";
    begin
        CurrPage.SAVERECORD;
        //"Production Order".
        ProdOrder.GET(rec.Status, rec."No.");

        CLEAR(ProductionJrnlMgt);
        "Production Order Line".SETRANGE(Status, "Production Order".Status);
        "Production Order Line".SETRANGE("Prod. Order No.", "Production Order"."No.");
        IF "Production Order Line".FINDFIRST THEN
            ProductionJrnlMgt.Handling(ProdOrder, "Production Order Line"."Line No.");
    end;

    local procedure DueDateOnAfterValidate()
    begin
        DateEcheance := rec."Due Date";
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.ProdOrderLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.ProdOrderLines.PAGE.UpdateForm(TRUE);
    end;
}

