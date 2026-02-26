Table 8003987 "Production Completion Entry"
{
    // //PROJET_FACT GESWAY 16/04/03 Nouvelle table de suivi de l'avancement de production
    // //PERF MB 21/08/06 MAJ SIFT Index
    // //NAVIONE AC 15/01/07 Ajout d'une clé "Document No.","Posting Date"

    Caption = 'Production Completion Entry';
    DataCaptionFields = "Order No.", "Closing No.";
    DrillDownPageID = "Production Completion Entries";
    LookupPageID = "Production Completion Entries";

    fields
    {
        field(1; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job;
        }
        field(2; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
            TableRelation = "Job Task"."Job Task No." where("Job No." = field("Job No."));
        }
        field(3; "Closing No."; Integer)
        {
            Caption = 'Closing No.';
        }
        field(4; "Previous Completion %"; Decimal)
        {
            Caption = 'Previous Completion %';
        }
        field(5; "New Completion %"; Decimal)
        {
            Caption = 'New Completion %';

            trigger OnValidate()
            begin
                CalculateCompletion;
            end;
        }
        field(6; "Completion Difference (%)"; Decimal)
        {
            Caption = 'Completion Difference (%)';
        }
        field(11; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(12; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(15; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(18; "Work Type Code"; Code[10])
        {
            Caption = 'Work Type Code';
        }
        field(20; "Previous Quantity"; Decimal)
        {
            Caption = 'Previous Quantity';
        }
        field(21; "New Quantity"; Decimal)
        {
            Caption = 'New Quantity';

            trigger OnValidate()
            begin
                CalculateCompletion;
            end;
        }
        field(22; "Quantity Difference"; Decimal)
        {
            Caption = 'Quantity Difference';
        }
        field(29; "Order No."; Code[20])
        {
            Caption = 'Order No.';
        }
        field(30; "Order Line No."; Integer)
        {
            Caption = 'Order Line No.';
        }
        field(31; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(32; Canceled; Boolean)
        {
            Caption = 'Cancel';
        }
        field(50000; Article; Code[20])
        {
            CalcFormula = lookup("Sales Line"."No." where("Document No." = field("Order No."),
                                                           "Line No." = field("Order Line No.")));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Job No.", "Job Task No.", "Closing No.", "Document No.")
        {
            SumIndexFields = "Completion Difference (%)", "Quantity Difference";
        }
        key(Key3; "Job No.", "Closing No.")
        {
        }
        key(Key4; "Order No.", "Order Line No.", "Closing No.")
        {
            SumIndexFields = "Completion Difference (%)", "Quantity Difference";
        }
        key(Key5; "Posting Date", "Document No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        lComplEntry: Record "Production Completion Entry";
    begin
        if lComplEntry.Find('+') then
            "Entry No." := lComplEntry."Entry No." + 1
        else
            "Entry No." := 1;
    end;


    procedure CalculateCompletion()
    var
        lCompletion: Record "Production Completion Entry";
        lSalesLine: Record "Sales Line";
    begin
        //#4682
        /*DELETE
        IF "New Quantity" = 0 THEN
          EXIT;
        DELETE*/
        //#4682//

        lCompletion.SetCurrentkey("Order No.", "Order Line No.");
        lCompletion.SetRange("Order No.", "Order No.");
        lCompletion.SetRange("Order Line No.", "Order Line No.");
        lCompletion.SetFilter("Entry No.", '<%1', "Entry No.");
        if not lCompletion.Find('+') then begin
            lCompletion.Init;
            //#4682
            if "New Quantity" = 0 then
                exit;
            //#4682//

        end;
        lSalesLine.Get(lSalesLine."document type"::Order, "Order No.", "Order Line No.");

        if lSalesLine.Disable then
            exit;

        "Previous Completion %" := lCompletion."New Completion %";
        "Previous Quantity" := lCompletion."New Quantity";

        "Quantity Difference" := "New Quantity" - "Previous Quantity";
        if "New Quantity" = lSalesLine.Quantity then
            "New Completion %" := 100
        else
            "New Completion %" := "New Quantity" * 100 / lSalesLine.Quantity;
        "Completion Difference (%)" := "New Completion %" - "Previous Completion %";

    end;
}

