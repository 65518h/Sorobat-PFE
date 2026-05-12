page 52048883 "Item Card PDR"
{
    //GL2024  ID dans Nav 2009 : "39002098"
    Caption = 'Item Card PDR';
    Description = 'SourceTable=Table27';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = item;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; REC."No.")
                {
                    ApplicationArea = all;

                    trigger OnAssistEdit()
                    begin
                        IF REC.AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }
                field(Description; REC.Description)
                {
                    ApplicationArea = all;
                }
                field("Base Unit of Measure"; REC."Base Unit of Measure")
                {
                    ApplicationArea = all;
                }
                // field("Bill of Materials"; REC."Bill of Materials")
                // {ApplicationArea = all;
                // }
                field("Shelf No."; REC."Shelf No.")
                {
                    ApplicationArea = all;
                }
                field("Automatic Ext. Texts"; REC."Automatic Ext. Texts")
                {
                    ApplicationArea = all;
                }
                field("Created From Nonstock Item"; REC."Created From Nonstock Item")
                {
                    ApplicationArea = all;
                }
                field("Item Category Code"; REC."Item Category Code")
                {
                    ApplicationArea = all;
                }
                // field("Product Group Code"; REC."Product Group Code")
                // {ApplicationArea = all;
                // }
                field("Search Description"; REC."Search Description")
                {
                    ApplicationArea = all;
                }
                field(Inventory; REC.Inventory)
                {
                    ApplicationArea = all;
                }
                field("Qty. on Purch. Order"; REC."Qty. on Purch. Order")
                {
                    ApplicationArea = all;
                }
                field("Qty. on Prod. Order"; REC."Qty. on Prod. Order")
                {
                    ApplicationArea = all;
                }
                field("Qty. on Component Lines"; REC."Qty. on Component Lines")
                {
                    ApplicationArea = all;
                }
                field("Qty. on Sales Order"; REC."Qty. on Sales Order")
                {
                    ApplicationArea = all;
                }
                field("Qty. on Service Order"; REC."Qty. on Service Order")
                {
                    ApplicationArea = all;
                }
                field("Service Item Group"; REC."Service Item Group")
                {
                    ApplicationArea = all;
                }
                field(Blocked; REC.Blocked)
                {
                    ApplicationArea = all;
                }
                field("Last Date Modified"; REC."Last Date Modified")
                {
                    ApplicationArea = all;
                }
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                field("Costing Method"; REC."Costing Method")
                {
                    ApplicationArea = all;
                }
                field(AverageCostLCY; AverageCostLCY)
                {
                    ApplicationArea = all;
                    AutoFormatType = 2;
                    Caption = 'Average Cost (LCY)';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        CODEUNIT.RUN(CODEUNIT::"Show Avg. Calc. - Item", Rec);
                    end;
                }
                field("Standard Cost"; REC."Standard Cost")
                {
                    ApplicationArea = all;
                }
                field("Unit Cost"; REC."Unit Cost")
                {
                    ApplicationArea = all;
                }
                field("Overhead Rate"; REC."Overhead Rate")
                {
                    ApplicationArea = all;
                }
                field("Indirect Cost %"; REC."Indirect Cost %")
                {
                    ApplicationArea = all;
                }
                field("Last Direct Cost"; REC."Last Direct Cost")
                {
                    ApplicationArea = all;
                }
                field("Price/Profit Calculation"; REC."Price/Profit Calculation")
                {
                    ApplicationArea = all;
                }
                field("Profit %"; REC."Profit %")
                {
                    ApplicationArea = all;
                }
                field("Unit Price"; REC."Unit Price")
                {
                    ApplicationArea = all;
                }
                field("Gen. Prod. Posting Group"; REC."Gen. Prod. Posting Group")
                {
                    ApplicationArea = all;
                }
                field("VAT Prod. Posting Group"; REC."VAT Prod. Posting Group")
                {
                    ApplicationArea = all;
                }
                field("Inventory Posting Group"; REC."Inventory Posting Group")
                {
                    ApplicationArea = all;
                }
                field("Net Invoiced Qty."; REC."Net Invoiced Qty.")
                {
                    ApplicationArea = all;
                }
                field("Allow Invoice Disc."; REC."Allow Invoice Disc.")
                {
                    ApplicationArea = all;
                }
                field("Item Disc. Group"; REC."Item Disc. Group")
                {
                    ApplicationArea = all;
                }
                field("Sales Unit of Measure"; REC."Sales Unit of Measure")
                {
                    ApplicationArea = all;
                }
            }
            group(Replenishment)
            {
                Caption = 'Replenishment';
                field("Replenishment System"; REC."Replenishment System")
                {
                    ApplicationArea = all;
                    OptionCaption = 'Purchase,Prod. Order';
                }
                group(Purchase)
                {
                    Caption = 'Purchase';
                    field("Vendor No."; REC."Vendor No.")
                    {
                        ApplicationArea = all;
                    }
                    field("Vendor Item No."; REC."Vendor Item No.")
                    {
                        ApplicationArea = all;
                    }
                    field("Purch. Unit of Measure"; REC."Purch. Unit of Measure")
                    {
                        ApplicationArea = all;
                    }
                    field("Lead Time Calculation"; REC."Lead Time Calculation")
                    {
                        ApplicationArea = all;
                    }
                }
                group(Production)
                {
                    Caption = 'Production';
                    field("Manufacturing Policy"; REC."Manufacturing Policy")
                    {
                        ApplicationArea = all;
                    }
                    field("Routing No."; REC."Routing No.")
                    {
                        ApplicationArea = all;
                    }
                    field("Production BOM No."; REC."Production BOM No.")
                    {
                        ApplicationArea = all;
                    }
                    field("Rounding Precision"; REC."Rounding Precision")
                    {
                        ApplicationArea = all;
                    }
                    field("Flushing Method"; REC."Flushing Method")
                    {
                        ApplicationArea = all;
                    }
                    field("Scrap %"; REC."Scrap %")
                    {
                        ApplicationArea = all;
                    }
                    field("Lot Size"; REC."Lot Size")
                    {
                        ApplicationArea = all;
                    }
                }
            }
            group(Planning)
            {
                Caption = 'Planning';
                field("Reordering Policy"; REC."Reordering Policy")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        EnablePlanningControls
                    end;
                }
                field("Include Inventory"; REC."Include Inventory")
                {
                    ApplicationArea = all;
                    Enabled = "Include InventoryEnable";
                }
                field(Reserve; REC.Reserve)
                {
                    ApplicationArea = all;
                }
                field("Order Tracking Policy"; REC."Order Tracking Policy")
                {
                    ApplicationArea = all;
                }
                field("Stockkeeping Unit Exists"; REC."Stockkeeping Unit Exists")
                {
                    ApplicationArea = all;
                }
                field(Critical; REC.Critical)
                {
                    ApplicationArea = all;
                }
                // field("Reorder Cycle"; REC."Reorder Cycle")
                // {ApplicationArea = all;
                //     Enabled = "Reorder CycleEnable";
                // }
                field("Safety Lead Time"; REC."Safety Lead Time")
                {
                    ApplicationArea = all;
                    Enabled = "Safety Lead TimeEnable";
                }
                field("Safety Stock Quantity"; REC."Safety Stock Quantity")
                {
                    ApplicationArea = all;
                    Enabled = "Safety Stock QuantityEnable";
                }
                field("Reorder Point"; REC."Reorder Point")
                {
                    ApplicationArea = all;
                    Enabled = "Reorder PointEnable";
                }
                field("Reorder Quantity"; REC."Reorder Quantity")
                {
                    ApplicationArea = all;
                    Enabled = "Reorder QuantityEnable";
                }
                field("Maximum Inventory"; REC."Maximum Inventory")
                {
                    ApplicationArea = all;
                    Enabled = "Maximum InventoryEnable";
                }
                field("Minimum Order Quantity"; REC."Minimum Order Quantity")
                {
                    ApplicationArea = all;
                    Enabled = "Minimum Order QuantityEnable";
                }
                field("Maximum Order Quantity"; REC."Maximum Order Quantity")
                {
                    ApplicationArea = all;
                    Enabled = "Maximum Order QuantityEnable";
                }
                field("Order Multiple"; REC."Order Multiple")
                {
                    ApplicationArea = all;
                    Enabled = "Order MultipleEnable";
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                field("Tariff No."; REC."Tariff No.")
                {
                    ApplicationArea = all;
                }
                field("Country/Region of Origin Code"; REC."Country/Region of Origin Code")
                {
                    ApplicationArea = all;
                }
            }
            group("Item Tracking")
            {
                Caption = 'Item Tracking';
                field("Item Tracking Code"; REC."Item Tracking Code")
                {
                    ApplicationArea = all;
                }
                field("Serial Nos."; REC."Serial Nos.")
                {
                    ApplicationArea = all;
                }
                field("Lot Nos."; REC."Lot Nos.")
                {
                    ApplicationArea = all;
                }
                field("Expiration Calculation"; REC."Expiration Calculation")
                {
                    ApplicationArea = all;
                }
            }
            group("E - Commerce")
            {
                Caption = 'E - Commerce';
                /*GL2024 group("Commerce Portal")
                 {
                     Caption = 'Commerce Portal';
                     //DYS
                     // field(ProdOrderExist; ProdOrderExist)
                     // {ApplicationArea = all;
                     // }
                 }*/
                group(BizTalk)
                {
                    Caption = 'BizTalk';
                    field("Common Item No."; REC."Common Item No.")
                    {
                        ApplicationArea = all;
                    }
                }
            }
            group(Warehouse)
            {
                Caption = 'Warehouse';
                field("Special Equipment Code"; REC."Special Equipment Code")
                {
                    ApplicationArea = all;
                }
                field("Put-away Template Code"; REC."Put-away Template Code")
                {
                    ApplicationArea = all;
                }
                field("Put-away Unit of Measure Code"; REC."Put-away Unit of Measure Code")
                {
                    ApplicationArea = all;
                }
                field("Phys Invt Counting Period Code"; REC."Phys Invt Counting Period Code")
                {
                    ApplicationArea = all;
                }
                field("Last Phys. Invt. Date"; REC."Last Phys. Invt. Date")
                {
                    ApplicationArea = all;
                }
                field("Last Counting Period Update"; REC."Last Counting Period Update")
                {
                }
                // field("Next Counting Period"; REC."Next Counting Period")
                // {ApplicationArea = all;
                // }
                field("Identifier Code"; REC."Identifier Code")
                {
                    ApplicationArea = all;
                }
                field("Use Cross-Docking"; REC."Use Cross-Docking")
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

            group("&Item1")
            {
                Caption = '&Item';

                actionref("Stockkeepin&g Units1"; "Stockkeepin&g Units") { }
                group("E&ntries1")
                {
                    Caption = 'E&ntries';

                    actionref("Ledger E&ntries1"; "Ledger E&ntries") { }

                    actionref("&Reservation Entries1"; "&Reservation Entries") { }
                    actionref("&Phys. Inventory Ledger Entries1"; "&Phys. Inventory Ledger Entries") { }
                    actionref("&Value Entries1"; "&Value Entries") { }
                    actionref("Item &Tracking Entries1"; "Item &Tracking Entries") { }
                }
                group(Statistics11)
                {
                    Caption = 'Statistics';
                    actionref(Statistics12; Statistics) { }
                    actionref("Entry Statistics1"; "Entry Statistics") { }
                    actionref("T&urnover1"; "T&urnover") { }
                    actionref("Items b&y Location1"; "Items b&y Location") { }

                }

                group("&Item Availability by1")
                {
                    Caption = 'Articles &par magasin';

                    actionref(Period1; Period) { }
                    actionref(Variant1; Variant) { }
                    actionref(Location1; Location) { }
                    actionref("&Bin Contents1"; "&Bin Contents") { }
                    actionref("Co&mments1"; "Co&mments") { }
                    actionref(Dimensions1; Dimensions) { }
                    actionref("&Picture1"; "&Picture") { }
                    actionref("&Units of Measure1"; "&Units of Measure") { }
                    actionref("Va&riants1"; "Va&riants") { }
                    actionref("Cross Re&ferences1"; "Cross Re&ferences") { }
                    actionref("Substituti&ons1"; "Substituti&ons") { }
                    actionref("Nonstoc&k Items1"; "Nonstoc&k Items") { }
                    actionref(Translations1; Translations) { }
                    actionref("E&xtended Texts1"; "E&xtended Texts") { }
                }
                group("Assembly List1")
                {
                    Caption = 'Assembly List';
                    actionref("Bill of Materials1"; "Bill of Materials") { }
                    actionref("Where-Used List1"; "Where-Used List") { }
                    actionref("Calc. Stan&dard Cost11"; "Calc. Stan&dard Cost1") { }

                }
                group("Manufa&cturing1")
                {
                    Caption = 'Manufa&cturing';

                    actionref("Where-Used1"; "Where-Used") { }

                    actionref("Calc. Stan&dard Cost12"; "Calc. Stan&dard Cost") { }

                }
                actionref("Ser&vice Items1"; "Ser&vice Items") { }

                group("Troubles&hooting11")
                {
                    Caption = 'Troubles&hooting';
                    actionref("Troubleshooting &Setup1"; "Troubleshooting &Setup") { }
                    actionref("Troubles&hooting12"; "Troubles&hooting") { }
                }

                group("R&esource1")
                {
                    Caption = 'R&esource';
                    actionref("Resource Skills1"; "Resource Skills") { }
                    actionref("Skilled Resources1"; "Skilled Resources") { }
                }
                actionref(Identifiers1; Identifiers) { }
            }

            group("S&ales1")
            {
                Caption = 'S&ales';
                actionref(Prices12; Prices) { }
                actionref("Line Discounts12"; "Line Discounts") { }
                actionref(Orders12; Orders) { }
                actionref("Return Orders12"; "Return Orders") { }
            }

            group("&Purchases1")
            {
                Caption = '&Purchases';

                actionref("Ven&dors1"; "Ven&dors") { }
                actionref(Prices11; Prices1) { }
                actionref("Line Discounts11"; "Line Discounts1") { }
                actionref(Orders11; Orders1) { }
                actionref("Return Orders11"; "Return Orders1") { }

            }

            group("F&unctions1")
            {
                Caption = 'F&unctions';
                actionref("&Create Stockkeeping Unit1"; "&Create Stockkeeping Unit") { }
                actionref("C&alculate Counting Period1"; "C&alculate Counting Period") { }

            }

        }
        area(navigation)
        {
            group("&Item")
            {
                Caption = '&Item';
                action("Stockkeepin&g Units")
                {
                    ApplicationArea = all;
                    Caption = 'Stockkeepin&g Units';
                    RunObject = Page "Stockkeeping Unit List";
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.");
                }
                group("E&ntries")
                {
                    Caption = 'E&ntries';
                    action("Ledger E&ntries")
                    {
                        ApplicationArea = all;
                        Caption = 'Ledger E&ntries';
                        RunObject = Page "Item Ledger Entries";
                        RunPageLink = "Item No." = FIELD("No.");
                        RunPageView = SORTING("Item No.");
                        ShortCutKey = 'Ctrl+F7';
                    }
                    action("&Reservation Entries")
                    {
                        ApplicationArea = all;
                        Caption = '&Reservation Entries';
                        Image = ReservationLedger;
                        RunObject = Page "Reservation Entries";
                        RunPageLink = "Reservation Status" = CONST(Reservation), "Item No." = FIELD("No.");
                        RunPageView = SORTING("Item No.", "Variant Code", "Location Code", "Reservation Status");
                    }
                    action("&Phys. Inventory Ledger Entries")
                    {
                        ApplicationArea = all;
                        Caption = '&Phys. Inventory Ledger Entries';
                        Image = PhysicalInventoryLedger;
                        RunObject = Page "Phys. Inventory Ledger Entries";
                        RunPageLink = "Item No." = FIELD("No.");
                        RunPageView = SORTING("Item No.");
                    }
                    action("&Value Entries")
                    {
                        ApplicationArea = all;
                        Caption = '&Value Entries';
                        Image = ValueLedger;
                        RunObject = Page "Value Entries";
                        RunPageLink = "Item No." = FIELD("No.");
                        RunPageView = SORTING("Item No.");
                    }
                    action("Item &Tracking Entries")
                    {
                        ApplicationArea = all;
                        Caption = 'Item &Tracking Entries';
                        Image = ItemTrackingLedger;

                        trigger OnAction()
                        var
                            ItemTrackingMgt: Codeunit "Item Tracking Management";
                            ItemTrackingDocMgt: Codeunit "Item Tracking Doc. Management";
                        begin
                            //ItemTrackingMgt.CallItemTrackingEntryForm(3, '', REC."No.", '', '', '', '');
                            ItemTrackingDocMgt.ShowItemTrackingForEntity(3, '', Rec."No.", '', '');
                        end;
                    }
                }
                group(Statistics1)
                {
                    Caption = 'Statistics';
                    action(Statistics)
                    {
                        ApplicationArea = all;
                        Caption = 'Statistics';
                        Image = Statistics;

                        ShortCutKey = 'F7';

                        trigger OnAction()
                        var
                            ItemStatistics: Page "Item Statistics";
                        begin
                            ItemStatistics.SetItem(Rec);
                            ItemStatistics.RUNMODAL;
                        end;
                    }
                    action("Entry Statistics")
                    {
                        ApplicationArea = all;
                        Caption = 'Entry Statistics';
                        RunObject = Page "Item Entry Statistics";
                        RunPageLink = "No." = FIELD("No."), "Date Filter" = FIELD("Date Filter"), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"), "Location Filter" = FIELD("Location Filter"), "Drop Shipment Filter" = FIELD("Drop Shipment Filter"), "Variant Filter" = FIELD("Variant Filter");
                    }
                    action("T&urnover")
                    {
                        ApplicationArea = all;
                        Caption = 'T&urnover';
                        RunObject = Page "Item Turnover";
                        RunPageLink = "No." = FIELD("No."), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"), "Location Filter" = FIELD("Location Filter"), "Drop Shipment Filter" = FIELD("Drop Shipment Filter"), "Variant Filter" = FIELD("Variant Filter");
                    }
                }
                action("Items b&y Location")
                {
                    ApplicationArea = all;
                    Caption = 'Items b&y Location';
                    Image = ItemAvailbyLoc;

                    trigger OnAction()
                    var
                        ItemsByLocation: Page "Items by Location";
                    begin
                        ItemsByLocation.SETRECORD(Rec);
                        ItemsByLocation.RUN;
                    end;
                }
                group("&Item Availability by")
                {
                    Caption = 'Articles &par magasin';
                    action(Period)
                    {
                        ApplicationArea = all;
                        Caption = 'Period';
                        RunObject = Page "Item Availability by Periods";
                        RunPageLink = "No." = FIELD("No."), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"), "Location Filter" = FIELD("Location Filter"), "Drop Shipment Filter" = FIELD("Drop Shipment Filter"), "Variant Filter" = FIELD("Variant Filter");
                    }
                    action(Variant)
                    {
                        ApplicationArea = all;
                        Caption = 'Variant';
                        RunObject = Page "Item Availability by Variant";
                        RunPageLink = "No." = FIELD("No."), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"), "Location Filter" = FIELD("Location Filter"), "Drop Shipment Filter" = FIELD("Drop Shipment Filter"), "Variant Filter" = FIELD("Variant Filter");

                    }
                    action(Location)
                    {
                        ApplicationArea = all;
                        Caption = 'Location';
                        RunObject = Page "Item Availability by Location";
                        RunPageLink = "No." = FIELD("No."), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"), "Location Filter" = FIELD("Location Filter"), "Drop Shipment Filter" = FIELD("Drop Shipment Filter"), "Variant Filter" = FIELD("Variant Filter");
                    }
                }
                action("&Bin Contents")
                {
                    ApplicationArea = all;
                    Caption = '&Bin Contents';
                    Image = BinContent;
                    RunObject = Page "Item Bin Contents";
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.");
                }
                action("Co&mments")
                {
                    ApplicationArea = all;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = CONST(Item), "No." = FIELD("No.");
                }
                action(Dimensions)
                {
                    ApplicationArea = all;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = CONST(27), "No." = FIELD("No.");
                    ShortCutKey = 'Maj+Ctrl+D';
                }
                action("&Picture")
                {
                    ApplicationArea = all;
                    Caption = '&Picture';
                    RunObject = Page "Item Picture";
                    RunPageLink = "No." = FIELD("No."), "Date Filter" = FIELD("Date Filter"), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"), "Location Filter" = FIELD("Location Filter"), "Drop Shipment Filter" = FIELD("Drop Shipment Filter"), "Variant Filter" = FIELD("Variant Filter");
                }

                action("&Units of Measure")
                {
                    ApplicationArea = all;
                    Caption = '&Units of Measure';
                    RunObject = Page "Item Units of Measure";
                    RunPageLink = "Item No." = FIELD("No.");
                }
                action("Va&riants")
                {
                    ApplicationArea = all;
                    Caption = 'Va&riants';
                    RunObject = Page "Item Variants";
                    RunPageLink = "Item No." = FIELD("No.");
                }
                action("Cross Re&ferences")
                {
                    ApplicationArea = all;
                    Caption = 'Cross Re&ferences';
                    RunObject = Page "Item Reference Entries";
                    RunPageLink = "Item No." = FIELD("No.");
                }
                action("Substituti&ons")
                {
                    ApplicationArea = all;
                    Caption = 'Substituti&ons';
                    RunObject = Page "Item Substitution Entry";
                    RunPageLink = Type = CONST(Item), "No." = FIELD("No.");
                }
                action("Nonstoc&k Items")
                {
                    ApplicationArea = all;
                    Caption = 'Nonstoc&k Items';
                    RunObject = Page "Catalog Item List";
                }
                action(Translations)
                {
                    ApplicationArea = all;
                    Caption = 'Translations';
                    RunObject = Page "Item Translations";
                    RunPageLink = "Item No." = FIELD("No.");
                }
                action("E&xtended Texts")
                {
                    ApplicationArea = all;
                    Caption = 'E&xtended Texts';
                    RunObject = Page "Extended Text List";
                    RunPageLink = "Table Name" = CONST(Item), "No." = FIELD("No.");
                    RunPageView = SORTING("Table Name", "No.", "Language Code", "All Language Codes", "Starting Date", "Ending Date");
                }

                group("Assembly List")
                {
                    Caption = 'Assembly List';
                    action("Bill of Materials")
                    {
                        ApplicationArea = all;
                        Caption = 'Bill of Materials';
                        RunObject = Page "Assembly BOM";
                        RunPageLink = "Parent Item No." = FIELD("No.");
                    }
                    action("Where-Used List")
                    {
                        ApplicationArea = all;
                        Caption = 'Where-Used List';
                        RunObject = Page "Where-Used List";
                        RunPageLink = Type = CONST(Item), "No." = FIELD("No.");
                        RunPageView = SORTING(Type, "No.");
                    }
                    action("Calc. Stan&dard Cost1")
                    {
                        ApplicationArea = all;
                        Caption = 'Calc. Stan&dard Cost';

                        trigger OnAction()
                        begin
                            CalculateStdCost.CalcItem(rec."No.", TRUE);
                        end;
                    }
                }
                group("Manufa&cturing")
                {
                    Caption = 'Manufa&cturing';
                    action("Where-Used")
                    {
                        ApplicationArea = all;
                        Caption = 'Where-Used';

                        trigger OnAction()
                        var
                            ProdBOMWhereUsed: Page "Prod. BOM Where-Used";
                        begin
                            ProdBOMWhereUsed.SetItem(Rec, WORKDATE);
                            ProdBOMWhereUsed.RUNMODAL;
                        end;
                    }
                    action("Calc. Stan&dard Cost")
                    {
                        ApplicationArea = all;
                        Caption = 'Calc. Stan&dard Cost';

                        trigger OnAction()
                        begin
                            CalculateStdCost.CalcItem(rec."No.", FALSE);
                        end;
                    }
                }

                action("Ser&vice Items")
                {
                    ApplicationArea = all;
                    Caption = 'Ser&vice Items';
                    RunObject = Page "Service Items";
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.");
                }
                group("Troubles&hooting1")
                {
                    Caption = 'Troubles&hooting';
                    action("Troubleshooting &Setup")
                    {
                        ApplicationArea = all;
                        Caption = 'Troubleshooting &Setup';
                        Image = Troubleshoot;
                        RunObject = Page "Troubleshooting Setup";
                        RunPageLink = Type = CONST(Item), "No." = FIELD("No.");
                    }
                    action("Troubles&hooting")
                    {
                        ApplicationArea = all;
                        Caption = 'Troubles&hooting';

                        trigger OnAction()
                        begin
                            TroubleshHeader.ShowForItem(Rec);
                        end;
                    }
                }
                group("R&esource")
                {
                    Caption = 'R&esource';
                    action("Resource Skills")
                    {
                        ApplicationArea = all;
                        Caption = 'Resource Skills';
                        RunObject = Page "Resource Skills";
                        RunPageLink = Type = CONST(Item), "No." = FIELD("No.");
                    }
                    action("Skilled Resources")
                    {
                        ApplicationArea = all;
                        Caption = 'Skilled Resources';

                        trigger OnAction()
                        var
                            ResourceSkill: Record "Resource Skill";
                        begin
                            CLEAR(SkilledResourceList);
                            SkilledResourceList.Initialize(ResourceSkill.Type::Item, REC."No.", REC.Description);
                            SkilledResourceList.RUNMODAL;
                        end;
                    }
                }

                action(Identifiers)
                {
                    ApplicationArea = all;
                    Caption = 'Identifiers';
                    RunObject = Page "Item Identifiers";
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.", "Variant Code", "Unit of Measure Code");
                }
            }
            group("S&ales")
            {
                Caption = 'S&ales';
                action(Prices)
                {
                    ApplicationArea = all;
                    Caption = 'Prices';
                    Image = ResourcePrice;
                    RunObject = Page "Sales Prices";
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.");
                }
                action("Line Discounts")
                {
                    ApplicationArea = all;
                    Caption = 'Line Discounts';
                    RunObject = Page "Sales Line Discounts";
                    RunPageLink = Type = CONST(Item), Code = FIELD("No.");
                    RunPageView = SORTING(Type, Code);
                }

                action(Orders)
                {
                    ApplicationArea = all;
                    Caption = 'Orders';
                    Image = Document;
                    RunObject = Page "Sales Orders";
                    RunPageLink = Type = CONST(Item), "No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", Type, "No.");
                }
                action("Return Orders")
                {
                    ApplicationArea = all;
                    Caption = 'Return Orders';
                    Image = ReturnOrder;
                    RunObject = Page "Sales Return Orders";
                    RunPageLink = Type = CONST(Item), "No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", Type, "No.");
                }
            }
            group("&Purchases")
            {
                Caption = '&Purchases';
                action("Ven&dors")
                {
                    ApplicationArea = all;
                    Caption = 'Ven&dors';
                    RunObject = Page "Item Vendor Catalog";
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.");
                }
                action(Prices1)
                {
                    ApplicationArea = all;
                    Caption = 'Prices';
                    Image = ResourcePrice;
                    RunObject = Page "Purchase Prices";
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.");
                }
                action("Line Discounts1")
                {
                    ApplicationArea = all;
                    Caption = 'Line Discounts';
                    RunObject = Page "Purchase Line Discounts";
                    // RunPageLink = Code = FIELD("No.");
                }

                action(Orders1)
                {
                    ApplicationArea = all;
                    Caption = 'Orders';
                    Image = Document;
                    RunObject = Page "Purchase Orders";
                    RunPageLink = Type = CONST(Item), "No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", Type, "No.");
                }
                action("Return Orders1")
                {
                    ApplicationArea = all;
                    Caption = 'Return Orders';
                    Image = ReturnOrder;
                    RunObject = Page "Purchase Return Orders";
                    RunPageLink = Type = CONST(Item), "No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", Type, "No.");
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("&Create Stockkeeping Unit")
                {
                    ApplicationArea = all;
                    Caption = '&Create Stockkeeping Unit';

                    trigger OnAction()
                    var
                        Item: Record Item;
                    begin
                        Item.SETRANGE("No.", REC."No.");
                        REPORT.RUNMODAL(REPORT::"Create Stockkeeping Unit", TRUE, FALSE, Item);
                    end;
                }
                action("C&alculate Counting Period")
                {
                    ApplicationArea = all;
                    Caption = 'C&alculate Counting Period';

                    trigger OnAction()
                    var
                        PhysInvtCountMgt: Codeunit "Phys. Invt. Count.-Management";
                    begin
                        PhysInvtCountMgt.UpdateItemPhysInvtCount(Rec);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        ItemCostMgt.CalculateAverageCost(Rec, AverageCostLCY, AverageCostACY);
        EnablePlanningControls;
    end;

    trigger OnInit()
    begin
        "Include InventoryEnable" := TRUE;
        "Order MultipleEnable" := TRUE;
        "Maximum Order QuantityEnable" := TRUE;
        "Minimum Order QuantityEnable" := TRUE;
        "Maximum InventoryEnable" := TRUE;
        "Reorder QuantityEnable" := TRUE;
        "Reorder PointEnable" := TRUE;
        "Safety Stock QuantityEnable" := TRUE;
        "Safety Lead TimeEnable" := TRUE;
        "Reorder CycleEnable" := TRUE;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //GL2024
        // PDR := TRUE;
    end;

    var
        TroubleshHeader: Record "Troubleshooting Header";
        SkilledResourceList: Page "Skilled Resource List";
        ItemCostMgt: Codeunit ItemCostManagement;
        CalculateStdCost: Codeunit "Calculate Standard Cost";
        AverageCostLCY: Decimal;
        AverageCostACY: Decimal;


        "Reorder CycleEnable": Boolean;

        "Safety Lead TimeEnable": Boolean;

        "Safety Stock QuantityEnable": Boolean;

        "Reorder PointEnable": Boolean;

        "Reorder QuantityEnable": Boolean;

        "Maximum InventoryEnable": Boolean;

        "Minimum Order QuantityEnable": Boolean;

        "Maximum Order QuantityEnable": Boolean;

        "Order MultipleEnable": Boolean;

        "Include InventoryEnable": Boolean;


    procedure EnablePlanningControls()
    var
        PlanningGetParam: Codeunit "Planning-Get Parameters";
        ReorderCycleEnabled: Boolean;
        SafetyLeadTimeEnabled: Boolean;
        SafetyStockQtyEnabled: Boolean;
        ReorderPointEnabled: Boolean;
        ReorderQuantityEnabled: Boolean;
        MaximumInventoryEnabled: Boolean;
        MinimumOrderQtyEnabled: Boolean;
        MaximumOrderQtyEnabled: Boolean;
        OrderMultipleEnabled: Boolean;
        IncludeInventoryEnabled: Boolean;
    begin

        /* GL2024PlanningGetParam.SetUpPlanningControls(REC."Reordering Policy",
          ReorderCycleEnabled, SafetyLeadTimeEnabled, SafetyStockQtyEnabled,
          ReorderPointEnabled, ReorderQuantityEnabled, MaximumInventoryEnabled,
          MinimumOrderQtyEnabled, MaximumOrderQtyEnabled, OrderMultipleEnabled, IncludeInventoryEnabled);*/
        "Reorder CycleEnable" := ReorderCycleEnabled;
        "Safety Lead TimeEnable" := SafetyLeadTimeEnabled;
        "Safety Stock QuantityEnable" := SafetyStockQtyEnabled;
        "Reorder PointEnable" := ReorderPointEnabled;
        "Reorder QuantityEnable" := ReorderQuantityEnabled;
        "Maximum InventoryEnable" := MaximumInventoryEnabled;
        "Minimum Order QuantityEnable" := MinimumOrderQtyEnabled;
        "Maximum Order QuantityEnable" := MaximumOrderQtyEnabled;
        "Order MultipleEnable" := OrderMultipleEnabled;
        "Include InventoryEnable" := IncludeInventoryEnabled;

    end;

    local procedure AverageCostLCYOnActivate()
    begin
        ItemCostMgt.CalculateAverageCost(Rec, AverageCostLCY, AverageCostACY);
    end;
}

