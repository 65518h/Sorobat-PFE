Table 8004053 "Sales Line View"
{
    // //DEVIS GESWAY 27/11/02 Paramétrage de colonne de l'étude de prix

    Caption = 'Sales Line View';
    //  DrillDownPageID = 8004059;
    //LookupPageID = 8004059;

    fields
    {
        field(1; "View Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(2; "Presentation Description"; Text[30])
        {
            Caption = 'View Description';
        }
        field(6; "No."; Boolean)
        {
            Caption = 'No.';
            InitValue = true;
        }
        field(7; "Location Code"; Boolean)
        {
            Caption = 'Location Code';
        }
        field(10; "Shipment Date"; Boolean)
        {
            Caption = 'Shipment Date';
        }
        field(11; Description; Boolean)
        {
            Caption = 'Description';
            InitValue = true;
        }
        field(12; "Description 2"; Boolean)
        {
            Caption = 'Description 2';
        }
        field(13; "Unit of Measure"; Boolean)
        {
            Caption = 'Unit Code';
        }
        field(15; Quantity; Boolean)
        {
            Caption = 'Quantity';
            InitValue = true;
        }
        field(16; "% to Invoice"; Boolean)
        {
            Caption = '% to Invoice';
        }
        field(17; "Qty. to Invoice"; Boolean)
        {
            Caption = 'Qty. to Invoice';
        }
        field(18; "Qty. to Ship"; Boolean)
        {
            Caption = 'Qty. to Ship';
        }
        field(22; "Unit Price"; Boolean)
        {
            Caption = 'Unit Price';
            InitValue = true;
        }
        field(27; "Line Discount %"; Boolean)
        {
            Caption = 'Line Discount %';
        }
        field(28; "Line Discount Amount"; Boolean)
        {
            Caption = 'Line Discount Amount';
        }
        field(31; SalesPriceExist; Boolean)
        {
            Caption = 'Sales Price Exist';
        }
        field(32; "Allow Invoice Disc."; Boolean)
        {
            Caption = 'Allow Invoice Disc.';
        }
        field(40; "Shortcut Dimension 1 Code"; Boolean)
        {
            //CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
        }
        field(41; "Shortcut Dimension 2 Code"; Boolean)
        {
            //CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
        }
        field(42; "Customer Price Group"; Boolean)
        {
            Caption = 'Customer Price Group';
        }
        field(45; "Job No."; Boolean)
        {
            Caption = 'Job No.';
        }
        field(52; "Work Type Code"; Boolean)
        {
            Caption = 'Work Type Code';
        }
        field(60; "Quantity Shipped"; Boolean)
        {
            Caption = 'Quantity Shipped';
        }
        field(61; "Quantity Invoiced"; Boolean)
        {
            Caption = 'Quantity Invoiced';
        }
        field(69; "Inv. Discount Amount"; Boolean)
        {
            Caption = 'Inv. Discount Amount';
        }
        field(75; "Gen. Prod. Posting Group"; Boolean)
        {
            Caption = 'Gen. Prod. Posting Group';
        }
        field(89; "VAT Bus. Posting Group"; Boolean)
        {
            Caption = 'VAT Bus. Posting Group';

            trigger OnValidate()
            begin
                Validate("VAT Prod. Posting Group");
            end;
        }
        field(90; "VAT Prod. Posting Group"; Boolean)
        {
            Caption = 'VAT Prod. Posting Gr.';
        }
        field(100; "Unit Cost"; Boolean)
        {
            Caption = 'Unit Cost';
            InitValue = true;

            trigger OnValidate()
            var
                UnitOfMeasureTranslation: Record "Unit of Measure Translation";
            begin
            end;
        }
        field(103; "Line Amount"; Boolean)
        {
            Caption = 'Line Amount';
            InitValue = true;
        }
        field(1001; "Job Task No."; Boolean)
        {
            Caption = 'Job Task No.';
        }
        field(5402; "Variant Code"; Boolean)
        {
            Caption = 'Variant Code';
        }
        field(5404; "Qty. per Unit of Measure"; Boolean)
        {
            Caption = 'Qty. per Unit of Measure';
            InitValue = true;
        }
        field(5407; "Unit of Measure Code"; Boolean)
        {
            Caption = 'Unit of Measure Code';
        }
        field(5415; "Quantity (Base)"; Boolean)
        {
            Caption = 'Quantity (Base)';
        }
        field(5600; "FA Posting Date"; Boolean)
        {
            Caption = 'FA Posting Date';
        }
        field(5602; "Depreciation Book Code"; Boolean)
        {
            Caption = 'Depreciation Book Code';
            TableRelation = "Depreciation Book";
        }
        field(5605; "Depr. until FA Posting Date"; Boolean)
        {
            Caption = 'Depr. until FA Posting Date';
        }
        field(5702; "Substitution Available"; Boolean)
        {
            Caption = 'Substitution Available';
        }
        field(5705; "Cross-Reference No."; Boolean)
        {
            Caption = 'Cross-Reference No.';
        }
        field(5710; "Non Stock"; Boolean)
        {
            Caption = 'Nonstock';
        }
        field(5711; "Purchasing code"; Boolean)
        {
            Caption = 'Purchasing code';
        }
        field(5752; "Completely Shipped"; Boolean)
        {
            Caption = 'Completely Shipped';
        }
        field(8003912; "Internal Description"; Boolean)
        {
            Caption = 'Internal Description';
        }
        field(8003914; "Unit-Amount Rounding Precision"; Boolean)
        {
            Caption = 'Unit-Amount Rounding Precision';
            MinValue = false;

            trigger OnValidate()
            var
                lSalesLine: Record "Sales Line";
            begin
            end;
        }
        field(8003916; Marker; Boolean)
        {
            Caption = 'Marker';
        }
        field(8003947; "Purch. Order Qty (Base)"; Boolean)
        {
            Caption = 'Purchase Order Qty (Base)';
        }
        field(8003948; "Purch. Order Receipt Date"; Boolean)
        {
            Caption = 'Purch. Order Expected Receipt Date';
        }
        field(8003949; "Purch. Order Rcpt. Qty (Base)"; Boolean)
        {
            Caption = 'Qty. Received (Base)';
        }
        field(8003950; Option; Boolean)
        {
            Caption = 'Option';
        }
        field(8003951; "Distribution Basis"; Boolean)
        {
            Caption = 'Distribution Basis';
        }
        field(8003952; "Distribution Method"; Boolean)
        {
            Caption = 'Distribution Method';
        }
        field(8003953; "Job Cost Marked"; Boolean)
        {
            Caption = 'Job Cost Marked';
        }
        field(8003955; "Rate Amount"; Boolean)
        {
            Caption = 'Rate or Amount';
            Description = 'Taux ou montant de frais ou de remise en fonction du mode de calcul sélectionné';
        }
        field(8003956; "Gen. Prod. Posting Prorata"; Boolean)
        {
            Caption = 'Gen. Prod. Posting Prorata';
        }
        field(8003960; "Internal Order"; Boolean)
        {
            Caption = 'Internal Order';
        }
        field(8003961; "Transfer Order"; Boolean)
        {
            Caption = 'Transfer Order';
        }
        field(8004050; "Line Type"; Boolean)
        {
            Caption = 'Line Type';
            InitValue = true;
        }
        field(8004056; "Presentation Code"; Boolean)
        {
            Caption = 'Presentation No.';
        }
        field(8004057; Level; Boolean)
        {
            Caption = 'Level';
        }
        field(8004058; "Vendor No."; Boolean)
        {
            Caption = 'Vendor No.';
        }
        field(8004059; "Total Cost (LCY)"; Boolean)
        {
            Caption = 'Total Cost (LCY)';
            InitValue = true;
        }
        field(8004062; "Theoretical Profit Amount(LCY)"; Boolean)
        {
            Caption = 'Theoretical Profit Amount (LCY)';
        }
        field(8004063; "Overhead Amount (LCY)"; Boolean)
        {
            Caption = 'Overhead Amount (LCY)';

            trigger OnValidate()
            var
                Cust: Record Customer;
            begin
            end;
        }
        field(8004064; "Fixed Price"; Boolean)
        {
            Caption = 'Fixed Sale Price';
        }
        field(8004065; "Sales Line Disc. Exists"; Boolean)
        {
            Caption = 'Sales Line Disc. Exists';
        }
        field(8004066; "Value 1"; Boolean)
        {
            //CaptionClass = wQtyGetCaptionClass(1);
            Caption = 'Value 1';
        }
        field(8004067; "Value 2"; Boolean)
        {
            //CaptionClass = wQtyGetCaptionClass(2);
            Caption = 'Value 2';
        }
        field(8004068; "Value 3"; Boolean)
        {
            //CaptionClass = wQtyGetCaptionClass(3);
            Caption = 'Value 3';
        }
        field(8004069; "Value 4"; Boolean)
        {
            //CaptionClass = wQtyGetCaptionClass(4);
            Caption = 'Value 4';
        }
        field(8004070; "Value 5"; Boolean)
        {
            //CaptionClass = wQtyGetCaptionClass(5);
            Caption = 'Value 5';
        }
        field(8004071; "Value 6"; Boolean)
        {
            //CaptionClass = wQtyGetCaptionClass(6);
            Caption = 'Value 6';
        }
        field(8004072; "Value 7"; Boolean)
        {
            //CaptionClass = wQtyGetCaptionClass(7);
            Caption = 'Value 7';
        }
        field(8004073; "Value 8"; Boolean)
        {
            //CaptionClass = wQtyGetCaptionClass(8);
            Caption = 'Value 8';
        }
        field(8004074; "Value 9"; Boolean)
        {
            //CaptionClass = wQtyGetCaptionClass(9);
            Caption = 'Value 9';
        }
        field(8004075; "Value 10"; Boolean)
        {
            //CaptionClass = wQtyGetCaptionClass(10);
            Caption = 'Value 10';
        }
        field(8004076; Comment; Boolean)
        {
            Caption = 'Comment';
        }
        field(8004077; "Job Costs (LCY)"; Boolean)
        {
            //blankzero = true;
            Caption = 'Job Costs (LCY)';
        }
        field(8004078; "Print Option Line"; Boolean)
        {
            Caption = 'Print Option Line';
        }
        field(8004079; "Amount 1"; Boolean)
        {
            ////CaptionClass = wAmountGetCaptionClass(1);
            Caption = 'Amount 1';
        }
        field(8004080; "Amount 2"; Boolean)
        {
            ////CaptionClass = wAmountGetCaptionClass(2);
            Caption = 'Amount 2';
        }
        field(8004081; "Amount 3"; Boolean)
        {
            ////CaptionClass = wAmountGetCaptionClass(3);
            Caption = 'Amount 3';
        }
        field(8004082; "Amount 4"; Boolean)
        {
            ////CaptionClass = wAmountGetCaptionClass(4);
            Caption = 'Amount 4';
        }
        field(8004083; "Amount 5"; Boolean)
        {
            ////CaptionClass = wAmountGetCaptionClass(5);
            Caption = 'Amount 5';
        }
        field(8004084; "Amount 6"; Boolean)
        {
            ////CaptionClass = wAmountGetCaptionClass(6);
            Caption = 'Amount 6';
        }
        field(8004085; "Amount 7"; Boolean)
        {
            ////CaptionClass = wAmountGetCaptionClass(7);
            Caption = 'Amount 7';
        }
        field(8004086; "Amount 8"; Boolean)
        {
            ////CaptionClass = wAmountGetCaptionClass(8);
            Caption = 'Amount 8';
        }
        field(8004087; "Amount 9"; Boolean)
        {
            ////CaptionClass = wAmountGetCaptionClass(9);
            Caption = 'Amount 9';
        }
        field(8004088; "Amount 10"; Boolean)
        {
            ////CaptionClass = wAmountGetCaptionClass(10);
            Caption = 'Amount 10';
        }
        field(8004089; "Person Quantity"; Boolean)
        {
            Caption = 'Person Quantity';
        }
        field(8004090; "Total Cost LCY Excl. Person"; Boolean)
        {
            Caption = 'Total Cost LCY Excl. Person';
        }
        field(8004091; Rate; Boolean)
        {
            Caption = 'Rate';
        }
        field(8004092; Duration; Boolean)
        {
            Caption = 'Duration';
        }
        field(8004093; "Bill of quantities"; Boolean)
        {
            Caption = 'Measurement';
        }
        field(8004094; "Variables Not Defined"; Boolean)
        {
            Caption = 'Undefined var';
        }
        field(8004099; "Job Costs Margin Included"; Boolean)
        {
            Caption = 'Job Costs Margin Included';
        }
        field(8004134; Subcontracting; Boolean)
        {
            Caption = 'Subcontracting';
        }
        field(8004135; "Profit %"; Boolean)
        {
            Caption = 'Profit %';
        }
        field(8004136; "Non Valued Code"; Boolean)
        {
            Caption = 'Non-Valued Code';
        }
        field(8004137; "Profit Amount"; Boolean)
        {
            Caption = 'Profit Amount';
        }
    }

    keys
    {
        key(Key1; "View Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Text8003900: label '%1 (Sales)';

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


    procedure wQtyGetCaptionClass(FieldNumber: Integer): Text[80]
    var
        lQtySetup: Record "Quantity Setup";
    begin
        //#7196
        if not lQtySetup.Get then
            lQtySetup.Init;
        case FieldNumber of
            1:
                begin
                    if ((lQtySetup."Value 1 Name" = '') or
                       (lQtySetup."Used in 1" = lQtySetup."used in 1"::Purchases)) then
                        exit('8004050,' + FieldCaption("Value 1"));
                    exit('8004050,' + lQtySetup."Value 1 Name");
                end;
            2:
                begin
                    if ((lQtySetup."Value 2 Name" = '') or
                       (lQtySetup."Used in 2" = lQtySetup."used in 2"::Purchases)) then
                        exit('8004050,' + FieldCaption("Value 2"));
                    exit('8004050,' + lQtySetup."Value 2 Name");
                end;
            3:
                begin
                    if ((lQtySetup."Value 3 Name" = '') or
                       (lQtySetup."Used in 3" = lQtySetup."used in 3"::Purchases)) then
                        exit('8004050,' + FieldCaption("Value 3"));
                    exit('8004050,' + lQtySetup."Value 3 Name");
                end;
            4:
                begin
                    if ((lQtySetup."Value 4 Name" = '') or
                       (lQtySetup."Used in 4" = lQtySetup."used in 4"::Purchases)) then
                        exit('8004050,' + FieldCaption("Value 4"));
                    exit('8004050,' + lQtySetup."Value 4 Name");
                end;
            5:
                begin
                    if ((lQtySetup."Value 5 Name" = '') or
                       (lQtySetup."Used in 5" = lQtySetup."used in 5"::Purchases)) then
                        exit('8004050,' + FieldCaption("Value 5"));
                    exit('8004050,' + lQtySetup."Value 5 Name");
                end;
            6:
                begin
                    if ((lQtySetup."Value 6 Name" = '') or
                       (lQtySetup."Used in 6" = lQtySetup."used in 6"::Purchases)) then
                        exit('8004050,' + FieldCaption("Value 6"));
                    exit('8004050,' + lQtySetup."Value 6 Name");
                end;
            7:
                begin
                    if ((lQtySetup."Value 7 Name" = '') or
                       (lQtySetup."Used in 7" = lQtySetup."used in 7"::Purchases)) then
                        exit('8004050,' + FieldCaption("Value 7"));
                    exit('8004050,' + lQtySetup."Value 7 Name");
                end;
            8:
                begin
                    if ((lQtySetup."Value 8 Name" = '') or
                       (lQtySetup."Used in 8" = lQtySetup."used in 8"::Purchases)) then
                        exit('8004050,' + FieldCaption("Value 8"));
                    exit('8004050,' + lQtySetup."Value 8 Name");
                end;
            9:
                begin
                    if ((lQtySetup."Value 9 Name" = '') or
                       (lQtySetup."Used in 9" = lQtySetup."used in 9"::Purchases)) then
                        exit('8004050,' + FieldCaption("Value 9"));
                    exit('8004050,' + lQtySetup."Value 9 Name");
                end;
            10:
                begin
                    if ((lQtySetup."Value 10 Name" = '') or
                       (lQtySetup."Used in 10" = lQtySetup."used in 10"::Purchases)) then
                        exit('8004050,' + FieldCaption("Value 10"));
                    exit('8004050,' + lQtySetup."Value 10 Name");
                end;
        end;
        //#7196//
    end;
}

