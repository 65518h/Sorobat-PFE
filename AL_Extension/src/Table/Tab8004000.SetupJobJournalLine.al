Table 8004000 "Setup Job Journal Line"
{

    // //POINTAGE GESWAY 04/06/02 Paramétrage des champs de la feuille pointage

    Caption = 'Setup Job Journal Line';
    // DrillDownPageID = 8004008;
    // LookupPageID = 8004008;

    fields
    {
        field(1; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            TableRelation = "Job Journal Template";
        }
        field(2; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            TableRelation = "Job Journal Batch".Name where("Journal Template Name" = field("Journal Template Name"));
        }
        field(3; "Job No."; Boolean)
        {
            Caption = 'Job No.';
        }
        field(4; "Posting Date"; Boolean)
        {
            Caption = 'Posting Date';
        }
        field(5; "Document No."; Boolean)
        {
            Caption = 'Document No.';
        }
        field(6; Type; Boolean)
        {
            Caption = 'Type';
        }
        field(8; "No."; Boolean)
        {
            Caption = 'No.';
        }
        field(9; Description; Boolean)
        {
            Caption = 'Description';
        }
        field(10; Quantity; Boolean)
        {
            Caption = 'Quantity';
        }
        field(12; "Direct Unit Cost"; Boolean)
        {
            Caption = 'Direct Unit Cost';
        }
        field(13; "Unit Cost"; Boolean)
        {
            Caption = 'Unit Cost';
        }
        field(14; "Total Cost"; Boolean)
        {
            Caption = 'Total Cost';
        }
        field(15; "Unit Price"; Boolean)
        {
            Caption = 'Unit Price';
        }
        field(16; "Total Price"; Boolean)
        {
            Caption = 'Total Price';
        }
        field(17; "Resource Group No."; Boolean)
        {
            Caption = 'Resource Group No.';
        }
        field(18; "Unit of Measure Code"; Boolean)
        {
            Caption = 'Unit of Measure Code';
        }
        field(21; "Location Code"; Boolean)
        {
            Caption = 'Location Code';
        }
        field(22; Chargeable; Boolean)
        {
            Caption = 'Chargeable';
        }
        field(31; "Shortcut Dimension 1 Code"; Boolean)
        {
            //CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
        }
        field(32; "Shortcut Dimension 2 Code"; Boolean)
        {
            //CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
        }
        field(33; "Work Type Code"; Boolean)
        {
            Caption = 'Work Type Code';
        }
        field(34; "Price Group Code"; Boolean)
        {
            Caption = 'Price Group Code';
        }
        field(37; "Appl.-to Item Entry"; Boolean)
        {
            Caption = 'Appl.-to Item Entry';
        }
        field(45; "Phase Code"; Boolean)
        {
            Caption = 'Phase Code';
        }
        field(46; "Task Code"; Boolean)
        {
            Caption = 'Task Code';
        }
        field(47; "Step Code"; Boolean)
        {
            Caption = 'Step Code';
        }
        field(63; "Profit %"; Boolean)
        {
            Caption = 'Profit %';
        }
        field(64; "Applies-to Entry"; Boolean)
        {
            Caption = 'Applies-to Entry';
        }
        field(68; "Apply and Close (Job)"; Boolean)
        {
            Caption = 'Apply and Close (Job)';
        }
        field(79; "Gen. Bus. Posting Group"; Boolean)
        {
            Caption = 'Gen. Bus. Posting Group';
        }
        field(80; "Gen. Prod. Posting Group"; Boolean)
        {
            Caption = 'Gen. Prod. Posting Group';
        }
        field(81; "Transaction Type"; Boolean)
        {
            Caption = 'Transaction Type';
        }
        field(82; "Transport Method"; Boolean)
        {
            Caption = 'Transport Method';
        }
        field(83; "Country Code"; Boolean)
        {
            Caption = 'Country Code';
        }
        field(87; "Document Date"; Boolean)
        {
            Caption = 'Document Date';
        }
        field(88; "External Document No."; Boolean)
        {
            Caption = 'External Document No.';
        }
        field(1000; "Job Task No."; Boolean)
        {
            Caption = 'Job Task No.';

            trigger OnValidate()
            var
                JobTask: Record "Job Task";
            begin
            end;
        }
        field(5402; "Variant Code"; Boolean)
        {
            Caption = 'Variant Code';
        }
        field(8003900; "Vendor No."; Boolean)
        {
            Caption = 'Vendor No.';
        }
        field(8003901; "Machine No ."; Boolean)
        {
            Caption = 'Machine No .';
        }
        field(8003902; "Order No."; Boolean)
        {
            Caption = 'Order No.';
        }
        field(8003903; "Job Description"; Boolean)
        {
            Caption = 'Job Description';
        }
        field(8003904; "Phase Description"; Boolean)
        {
            Caption = 'Phase Description';
        }
        field(8003906; "Quantity 1"; Boolean)
        {
            //blankzero = true;
            //CaptionClass = GetCaptionClass(1);
            Caption = 'Quantity 1';
        }
        field(8003907; "Quantity 2"; Boolean)
        {
            //blankzero = true;
            //CaptionClass = GetCaptionClass(2);
            Caption = 'Quantiy 2';
        }
        field(8003908; "Quantity 3"; Boolean)
        {
            //blankzero = true;
            //CaptionClass = GetCaptionClass(3);
            Caption = 'Quantiy 3';
        }
        field(8003909; "Quantity 4"; Boolean)
        {
            //blankzero = true;
            //CaptionClass = GetCaptionClass(4);
            Caption = 'Quantiy 4';
        }
        field(8003910; "Quantity 5"; Boolean)
        {
            //blankzero = true;
            //CaptionClass = GetCaptionClass(5);
            Caption = 'Quantiy 5';
        }
        field(8003911; "Quantity 6"; Boolean)
        {
            //blankzero = true;
            //CaptionClass = GetCaptionClass(6);
            Caption = 'Quantiy 6';
        }
        field(8003912; "Quantity 7"; Boolean)
        {
            //blankzero = true;
            //CaptionClass = GetCaptionClass(7);
            Caption = 'Quantiy 7';
        }
        field(8003913; "Quantity 8"; Boolean)
        {
            //blankzero = true;
            //CaptionClass = GetCaptionClass(8);
            Caption = 'Quantiy 8';
        }
        field(8003914; "Quantity 9"; Boolean)
        {
            //blankzero = true;
            //CaptionClass = GetCaptionClass(9);
            Caption = 'Quantiy 9';
        }
        field(8003915; "Quantity 10"; Boolean)
        {
            //blankzero = true;
            //CaptionClass = GetCaptionClass(10);
            Caption = 'Quantiy 10';
        }
        field(8003916; "Shortcut Dimension 3 Code"; Boolean)
        {
            //CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
        }
        field(8003917; "Shortcut Dimension 4 Code"; Boolean)
        {
            //CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
        }
        field(8003918; "Shortcut Dimension 5 Code"; Boolean)
        {
            //CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
        }
        field(8003919; "Shortcut Dimension 6 Code"; Boolean)
        {
            //CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';
        }
        field(8003920; "Shortcut Dimension 7 Code"; Boolean)
        {
            //CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 7 Code';
        }
        field(8003921; "Shortcut Dimension 8 Code"; Boolean)
        {
            //CaptionClass = '1,2,8';
            Caption = 'Shortcut Dimension 8 Code';
        }
        field(8003922; "Intervention Zone Code"; Boolean)
        {
            Caption = 'Intervention Zone Code';
        }
        field(8003923; "Intervention Zone Qty"; Boolean)
        {
            Caption = 'Intervention Zone Qty';
        }
        field(8003924; "Driver Code"; Boolean)
        {
            Caption = 'Driver Code';
        }
        field(8003925; "Driver Quantity"; Boolean)
        {
            Caption = 'Driver Qty';
        }
        field(8004134; "Sales Document No."; Boolean)
        {
            Caption = 'Sales Document No.';
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(8004135; "Sales Line No."; Boolean)
        {
            Caption = 'Sales Line No.';
            //This property is currently not supported
            //TestTableRelation = false;
        }
    }

    keys
    {
        key(Key1; "Journal Template Name", "Journal Batch Name")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }


    procedure GetCaptionClass(pNum: Integer): Text[80]
    begin
        exit(CopyStr('8004000,' + Format(pNum) + ',' + "Journal Template Name" + ',' + "Journal Batch Name", 1, 80));
    end;
}

