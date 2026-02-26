TableExtension 50131 "Sales Line ArchiveEXT" extends "Sales Line Archive"
{
    //DYS page addon non migrer
    //  LookuppageID = 8004074;
    // DrillDownpageID = 8004074;

    fields
    {
        modify("No.")
        {
            TableRelation = if (Type = const(" "),
                                "Line Type" = const(" ")) "Standard Text"
            else
            if (Type = const(" "),
                                         "Line Type" = const(Structure)) Resource where(Type = const(Structure))
            else
            if ("Line Type" = const(Totaling),
                                                  "Job No." = filter(<> ''),
                                                  "No." = const('')) "Job Task"."Job Task No." where("Job No." = field("Job No."))
            else
            if (Type = const("G/L Account")) "G/L Account"
            else
            if (Type = const(Item)) Item where("Location Filter" = field("Location Code"))
            else
            if (Type = const("Fixed Asset")) "Fixed Asset"
            else
            if (Type = const("Charge (Item)")) "Item Charge"
            else
            if (Type = const(Resource),
                                                           "Line Type" = const(Person)) Resource."No." where(Type = const(Person))
            else
            if (Type = const(Resource),
                                                                    "Line Type" = const(Machine)) Resource."No." where(Type = const(Machine))
            else
            if (Type = const(Resource),
                                                                             "Line Type" = const(Structure)) Resource."No." where(Type = const(Structure))
            else
            if (Type = const(Resource),
                                                                                      "Line Type" = const(" ")) Resource."No." where(Type = filter(<> Structure));
        }

        modify("Job No.")
        {
            Caption = 'Job No.';
        }
        modify("Gen. Prod. Posting Group")
        {
            Caption = 'Gen. Prod. Posting Group';
        }

        field(51000; "Description 2 soroubat"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(8003900; "Completion Amount"; Decimal)
        {
            //blankzero = true;
            Caption = 'Completion Amount';
            Editable = false;
        }
        field(8003901; "Job Task No.2"; Code[20])
        {
            Caption = 'Job Task No.';
            Description = '#8880';
            TableRelation = "Job Task"."Job Task No." where("Job No." = field("Job No."),
                                                             Blocked = filter(False));
        }
        field(8003902; "New Completion %"; Decimal)
        {
            //blankzero = true;
            Caption = 'New Completion (%)';
            Editable = false;
        }
        field(8003903; "Scheduler Line No."; Integer)
        {
            Caption = 'Scheduler Line No.';
            Editable = false;
        }
        field(8003904; "Previous Prod. Completion %"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Production Completion Entry"."Completion Difference (%)" where("Order No." = field("Document No."),
                                                                                               "Order Line No." = field("Line No.")));
            Caption = 'Previous  Prod. Completion (%)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8003907; "Outstanding Amt Excl VAT(LCY)"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Outstanding Amt Excl VAT(LCY)';
            Editable = false;

            trigger OnValidate()
            var
                Currency2: Record Currency;
            begin
            end;
        }
        field(8003908; "Order Type"; Option)
        {
            Caption = 'Order Type';
            Editable = false;
            OptionCaption = ' ,Internal Order,Transfer';
            OptionMembers = " ","Internal Order",Transfer;
        }
        field(8003909; "Rider No."; Code[20])
        {
            Caption = 'Rider No.';
        }
        field(8003910; "Completely Invoiced"; Boolean)
        {
            Caption = 'Completely Invoiced';
            Editable = false;
        }
        field(8003914; "Unit-Amount Rounding Precision"; Decimal)
        {
            Caption = 'Unit-Amount Rounding Precision';
            DecimalPlaces = 0 : 9;
            MinValue = 0;

            trigger OnValidate()
            var
                lSalesLine: Record "Sales Line";
            begin
            end;
        }
        field(8003916; Marker; Code[20])
        {
            Caption = 'Marker';
        }
        field(8003943; "Purchasing Document Type"; Option)
        {
            Caption = 'Purchasing Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(8003945; "Purchasing Order No."; Code[20])
        {
            Caption = 'Purchasing Order No.';
            TableRelation = if ("Special Order" = const(true)) "Purchase Header"."No." where("Document Type" = const(Order),
                                                                                            "No." = field("Special Order Purchase No."))
            else
            if ("Drop Shipment" = const(true)) "Purchase Header"."No." where("Document Type" = const(Order),
                                                                                                                                                                 "No." = field("Purchase Order No."));
        }
        field(8003946; "Purchasing Order Line No."; Integer)
        {
            Caption = 'Purchasing Order Line No.';
        }
        field(8003947; "Purch. Order Qty (Base)"; Decimal)
        {
            //blankzero = true;
            CalcFormula = lookup("Purchase Line"."Quantity (Base)" where("Document Type" = const(Order),
                                                                          "Document No." = field("Purchasing Order No."),
                                                                          "Line No." = field("Purchasing Order Line No.")));
            Caption = 'Purchase Order Qty (Base)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8003948; "Purch. Order Receipt Date"; Date)
        {
            CalcFormula = lookup("Purchase Line"."Expected Receipt Date" where("Document Type" = const(Order),
                                                                                "Document No." = field("Purchasing Order No."),
                                                                                "Line No." = field("Purchasing Order Line No.")));
            Caption = 'Purch. Order Expected Receipt Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8003949; "Purch. Order Rcpt. Qty (Base)"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Purch. Rcpt. Line"."Quantity (Base)" where("Sales Order No." = field("Document No."),
                                                                           "Sales Order Line No." = field("Line No.")));
            Caption = 'Qty. Received (Base)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8003950; Option; Boolean)
        {
            Caption = 'Option';

            trigger OnValidate()
            var
                lStructLine: Record "Sales Line";
                lRec: Record "Sales Line";
            begin
            end;
        }
        field(8003951; "Assignment Basis"; Option)
        {
            //blankzero = true;
            Caption = 'Distribution Basis';
            OptionCaption = ' ,Person Quantity,Direct Cost,Cost Price,Estimated Price,Specific';
            OptionMembers = " ","Person Quantity","Direct Cost","Cost Price","Estimated Price",Specific;
        }
        field(8003952; "Assignment Method"; Option)
        {
            Caption = 'Distribution Method';
            OptionCaption = ' ,All,Totaling,Selection,No Subcontracting,Subcontracting';
            OptionMembers = " ",All,Totaling,Selection,"No Subcontracting",Subcontracting;
        }
        field(8003953; "Job Cost Assignment"; Code[10])
        {
            Caption = 'Job Cost Marked';
        }
        field(8003954; "Value Option"; Option)
        {
            Caption = 'Mode de calcul';
            OptionCaption = 'Amount,% on Base,% on Result';
            OptionMembers = Amount,"% on Base","% on Result";
        }
        field(8003955; "Rate Amount"; Decimal)
        {
            Caption = 'Rate or Amount';
            Description = 'Taux ou montant de frais ou de remise en fonction du mode de calcul sélectionné';
        }
        field(8003956; "Gen. Prod. Posting Prorata"; Text[30])
        {
            Caption = 'Gen. Prod. Posting Prorata';
            TableRelation = if ("Assignment Basis" = filter(<> " ")) "Gen. Product Posting Group";
            ValidateTableRelation = false;
        }
        field(8003980; Tantieme; Integer)
        {
            //blankzero = true;
            Caption = 'Percentage';
        }
        field(8003981; "Order No."; Code[20])
        {
            Caption = 'Order No.';
        }
        field(8003982; "Order Line No."; Integer)
        {
            Caption = 'Order Line No.';
        }
        field(8003983; "Amount Excl. VAT (LCY)"; Decimal)
        {
            Caption = 'Amount Excl. VAT (LCY)';
        }
        field(8003984; "WIP Amount Posted"; Decimal)
        {
            Caption = 'WIP Amount Posted';
        }
        field(8003985; "Global Disc. Amount"; Decimal)
        {
            Caption = 'Global Disc. Amount';
            DecimalPlaces = 2 : 2;
        }
        field(8004048; "Number of Resources"; Decimal)
        {
            //blankzero = true;
            Caption = 'Number of Resources';
            DecimalPlaces = 0 : 2;
        }
        field(8004049; "Rate Quantity"; Decimal)
        {
            //blankzero = true;
            Caption = 'Rate Quantity';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            var
                lNumber: Decimal;
            begin
            end;
        }
        field(8004050; "Line Type"; Option)
        {
            Caption = 'Line Type';
            OptionCaption = ' ,Totaling,Item,Person,Machine,Structure,G/L Account,Charge (Item),Other';
            OptionMembers = " ",Totaling,Item,Person,Machine,Structure,"G/L Account","Charge (Item)",Other;

            trigger OnValidate()
            var
                lSalesLine: Record "Sales Line";
            begin
            end;
        }
        field(8004051; "Initial Job Budget Entry ID"; Integer)
        {
            Caption = 'Initial Job Budget Entry ID';
        }
        field(8004052; "Structure Line No."; Integer)
        {
            Caption = 'Structure Line No.';
        }
        field(8004053; "Quantity Per Structure"; Decimal)
        {
            Caption = 'Quantity Per Structure';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            var
                lStructureLine: Record "Sales Line";
            begin
            end;
        }
        field(8004054; "Found Price"; Decimal)
        {
            Caption = 'Found Price';
        }
        field(8004055; "Fixed Quantity"; Decimal)
        {
            //blankzero = true;
            Caption = 'Fixed Quantity';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                Validate("Quantity Per Structure");
            end;
        }
        field(8004056; "Presentation Code"; Text[20])
        {
            Caption = 'Presentation Code';

            trigger OnValidate()
            var
                lSalesLine: Record "Sales Line";
                lSalesLineBis: Record "Sales Line" temporary;
                lTabCodeNew: array[20] of Integer;
                lTabCode: array[20] of Integer;
                lCode: Text[80];
                i: Integer;
            begin
            end;
        }
        field(8004057; Level; Integer)
        {
            Caption = 'Level';
        }
        field(8004058; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            TableRelation = Vendor;

            trigger OnLookup()
            var
                lItemVendor: Record "Item Vendor";
                lVendor: Record Vendor;
            begin
            end;
        }
        field(8004059; "Total Cost (LCY)"; Decimal)
        {
            //blankzero = true;
            Caption = 'Total Cost (LCY)';
            Editable = false;
        }
        field(8004060; "Internal Order No."; Code[20])
        {
            Caption = 'Supply Order No.';
            TableRelation = "Sales Header"."No." where("Document Type" = const(Order),
                                                        "Order Type" = const("Supply Order"),
                                                        "Job No." = field("Job No."));

            trigger OnValidate()
            var
                lSalesLine: Record "Sales Line";
                lSalesLine2: Record "Sales Line";
                i: Integer;
                j: Integer;
            begin
            end;
        }
        field(8004061; "Supply Order Line No."; Integer)
        {
            Caption = 'Supply Order Line No.';
            TableRelation = "Sales Line"."Line No." where("Document Type" = const(Order),
                                                           "No." = field("Internal Order No."));
        }
        field(8004062; "Profit Amount (LCY)"; Decimal)
        {
            Caption = 'Profit Amount (LCY)';
            Editable = false;
        }
        field(8004063; "Overhead Amount (LCY)"; Decimal)
        {
            //blankzero = true;
            Caption = 'Overhead Amount (LCY)';
            Editable = false;
        }
        field(8004064; "Fixed Price"; Boolean)
        {
            Caption = 'Sales Price Fixed';
        }
        field(8004065; "Optionnal Quantity"; Decimal)
        {
            //blankzero = true;
            Caption = 'Option Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(8004066; "Value 1"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(1);
            Caption = 'Value 1';
        }
        field(8004067; "Value 2"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(2);
            Caption = 'Value 2';
        }
        field(8004068; "Value 3"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(3);
            Caption = 'Value 3';
        }
        field(8004069; "Value 4"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(4);
            Caption = 'Value 4';
        }
        field(8004070; "Value 5"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(5);
            Caption = 'Value 5';
        }
        field(8004071; "Value 6"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(6);
            Caption = 'Value 6';
        }
        field(8004072; "Value 7"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(7);
            Caption = 'Value 7';
        }
        field(8004073; "Value 8"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(8);
            Caption = 'Value 8';
        }
        field(8004074; "Value 9"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(9);
            Caption = 'Value 9';
        }
        field(8004075; "Value 10"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(10);
            Caption = 'Value 10';
        }
        field(8004076; Comment; Boolean)
        {
            CalcFormula = exist("Description Line Archive" where("Table ID" = const(37),
                                                                  "Document Type" = field("Document Type"),
                                                                  "Document No." = field("Document No."),
                                                                  "Document Line No." = field("Line No."),
                                                                  "Version No." = field("Version No."),
                                                                  "Doc. No. Occurrence" = field("Doc. No. Occurrence")));
            Caption = 'Co&mment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004077; "Job Costs (LCY)"; Decimal)
        {
            //blankzero = true;
            Caption = 'Job Costs (LCY)';
            Editable = false;
        }
        field(8004079; "Amount 1"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wAmountGetCaptionClass(1);
            Caption = 'Amount 1';
            Editable = false;
        }
        field(8004080; "Amount 2"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wAmountGetCaptionClass(2);
            Caption = 'Amount 2';
            Editable = false;
        }
        field(8004081; "Amount 3"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wAmountGetCaptionClass(3);
            Caption = 'Amount 3';
            Editable = false;
        }
        field(8004082; "Amount 4"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wAmountGetCaptionClass(4);
            Caption = 'Amount 4';
            Editable = false;
        }
        field(8004083; "Amount 5"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wAmountGetCaptionClass(5);
            Caption = 'Amount 5';
            Editable = false;
        }
        field(8004084; "Amount 6"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wAmountGetCaptionClass(6);
            Caption = 'Amount 6';
            Editable = false;
        }
        field(8004085; "Amount 7"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wAmountGetCaptionClass(7);
            Caption = 'Amount 7';
            Editable = false;
        }
        field(8004086; "Amount 8"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wAmountGetCaptionClass(8);
            Caption = 'Amount 8';
            Editable = false;
        }
        field(8004087; "Amount 9"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wAmountGetCaptionClass(9);
            Caption = 'Amount 9';
            Editable = false;
        }
        field(8004088; "Amount 10"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wAmountGetCaptionClass(10);
            Caption = 'Amount 10';
            Editable = false;
        }
        field(8004090; "Print Option Line"; Option)
        {
            Caption = 'Print Option Line';
            OptionCaption = ' ,Page Skip';
            OptionMembers = " ","Page Skip";
        }
        field(8004093; "Print Structure Line"; Boolean)
        {
            Caption = 'Print Structure Line';
        }
        field(8004094; Rate; Decimal)
        {
            //blankzero = true;
            Caption = 'Rate';
            DecimalPlaces = 0 : 5;
        }
        field(8004098; Duration; Decimal)
        {
            //blankzero = true;
            Caption = 'Duration';
            DecimalPlaces = 0 : 5;
        }
        field(8004101; "Field Filter"; Integer)
        {
            Caption = 'Field Filter';
            FieldClass = FlowFilter;
        }
        field(8004105; "Specific Item"; Boolean)
        {
            Caption = 'Specific Item';
        }
        field(8004134; Subcontracting; Option)
        {
            Caption = 'Subcontracting';
            OptionCaption = ' ,Furniture and Fixing,Fixing';
            OptionMembers = " ","Furniture and Fixing",Fixing;

            trigger OnValidate()
            var
                lLineType: label ' ,Totaling,Item,Person,Machine,Structure,G/L Account';
            begin
            end;
        }
        field(8004135; Disable; Boolean)
        {
            Caption = 'Disable';
        }
        field(8004136; "Disable Quantity"; Decimal)
        {
            Caption = 'Disable Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(8004137; "Resource Group No."; Code[20])
        {
            Caption = 'Resource Group No.';
            TableRelation = "Resource Group";
        }
    }
    keys
    {

        /* GL2024     key(Key6;"Document Type","Document No.","Line No.","Doc. No. Occurrence","Version No.","Presentation Code")
              {
              }
              key(Key8;"Document Type","Document No.","Doc. No. Occurrence","Version No.","Gen. Prod. Posting Group","Line Type","Structure Line No.",Quantity)
              {
              SumIndexFields = "Quantity (Base)","Total Cost (LCY)","Overhead Amount (LCY)","Job Costs (LCY)","Amount Excl. VAT (LCY)",Amount;
              }
              key(Key9;"Document Type","Document No.","Doc. No. Occurrence","Version No.","Presentation Code")
              {
              }*/
    }


    trigger OnAfterDelete()
    var
        lRecRef: RecordRef;
        lBOQCustMgt: Codeunit "BOQ Custom Management";
    begin
        //#7639
        lRecRef.GETTABLE(Rec);
        lBOQCustMgt.gOndelete(lRecRef, TRUE);
        //#7639//

    end;


    local procedure wAmountGetCaptionClass(FieldNumber: Integer): Text[80]
    var
        lSetupFormula: Record "Setup Formula Amount";
    begin
        if not lSetupFormula.Get(37, FieldNumber) then
            lSetupFormula.Init;
        if lSetupFormula.Description = '' then begin
            case FieldNumber of
                1:
                    lSetupFormula.Description := FieldCaption("Amount 1");
                2:
                    lSetupFormula.Description := FieldCaption("Amount 2");
                3:
                    lSetupFormula.Description := FieldCaption("Amount 3");
                4:
                    lSetupFormula.Description := FieldCaption("Amount 4");
                5:
                    lSetupFormula.Description := FieldCaption("Amount 5");
                6:
                    lSetupFormula.Description := FieldCaption("Amount 6");
                7:
                    lSetupFormula.Description := FieldCaption("Amount 7");
                8:
                    lSetupFormula.Description := FieldCaption("Amount 8");
                9:
                    lSetupFormula.Description := FieldCaption("Amount 9");
                10:
                    lSetupFormula.Description := FieldCaption("Amount 10");
                else
                    ;
            end;
        end;

        exit('8004050,' + lSetupFormula.Description);
    end;

    local procedure wQtyGetCaptionClass(FieldNumber: Integer): Text[80]
    var
        lQtySetup: Record "Quantity Setup";
    begin
        if not lQtySetup.Get then
            lQtySetup.Init;
        if lQtySetup."Value 1 Name" = '' then
            lQtySetup."Value 1 Name" := FieldCaption("Value 1");
        if lQtySetup."Value 2 Name" = '' then
            lQtySetup."Value 2 Name" := FieldCaption("Value 2");
        if lQtySetup."Value 3 Name" = '' then
            lQtySetup."Value 3 Name" := FieldCaption("Value 3");
        if lQtySetup."Value 4 Name" = '' then
            lQtySetup."Value 4 Name" := FieldCaption("Value 4");
        if lQtySetup."Value 5 Name" = '' then
            lQtySetup."Value 5 Name" := FieldCaption("Value 5");
        if lQtySetup."Value 6 Name" = '' then
            lQtySetup."Value 6 Name" := FieldCaption("Value 6");
        if lQtySetup."Value 7 Name" = '' then
            lQtySetup."Value 7 Name" := FieldCaption("Value 7");
        if lQtySetup."Value 8 Name" = '' then
            lQtySetup."Value 8 Name" := FieldCaption("Value 8");
        if lQtySetup."Value 9 Name" = '' then
            lQtySetup."Value 9 Name" := FieldCaption("Value 9");
        if lQtySetup."Value 10 Name" = '' then
            lQtySetup."Value 10 Name" := FieldCaption("Value 10");

        case FieldNumber of
            1:
                exit('8004050,' + lQtySetup."Value 1 Name");
            2:
                exit('8004050,' + lQtySetup."Value 2 Name");
            3:
                exit('8004050,' + lQtySetup."Value 3 Name");
            4:
                exit('8004050,' + lQtySetup."Value 4 Name");
            5:
                exit('8004050,' + lQtySetup."Value 5 Name");
            6:
                exit('8004050,' + lQtySetup."Value 6 Name");
            7:
                exit('8004050,' + lQtySetup."Value 7 Name");
            8:
                exit('8004050,' + lQtySetup."Value 8 Name");
            9:
                exit('8004050,' + lQtySetup."Value 9 Name");
            10:
                exit('8004050,' + lQtySetup."Value 10 Name");
        end;
    end;



}

