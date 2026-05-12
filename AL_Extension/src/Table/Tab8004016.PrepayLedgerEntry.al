Table 8004016 "Prepay Ledger Entry"
{
    // //PREPAIE GESWAY 01/12/01 Ajout de zones Taux, Montant, Libellé absence, Code loi et N° de ligne

    Caption = 'Prepay ledger';
    DataCaptionFields = "Employee No.";
    //DrillDownPageID = 8004016;
    //LookupPageID = 8004016;

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            NotBlank = true;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                Employee.Get("Employee No.");
            end;
        }
        field(2; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(3; "From Date"; Date)
        {
            Caption = 'From Date';
        }
        field(4; "To Date"; Date)
        {
            Caption = 'To Date';
        }
        field(5; "Prepay Reason Code"; Code[10])
        {
            Caption = 'Cause of prepay Code';
            TableRelation = "Prepay Reason Code";

            trigger OnValidate()
            begin
                Causeofpaycode.Get("Prepay Reason Code");
                Description := Causeofpaycode.Description;
                Validate("Unit of Measure Code", Causeofpaycode."Unit Code");
            end;
        }
        field(6; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(7; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                "Quantity (Base)" := CalcBaseQty(Quantity);
            end;
        }
        field(8; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Human Resource Unit of Measure";

            trigger OnValidate()
            begin
                HumanResUnitOfMeasure.Get("Unit of Measure Code");
                "Qty. per Unit of Measure" := HumanResUnitOfMeasure."Qty. per Unit of Measure";
                Validate(Quantity);
            end;
        }
        field(11; Comment; Boolean)
        {
            CalcFormula = exist("Human Resource Comment Line" where("Table Name" = const(7),
                                                                     "Table Line No." = field("Entry No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(12; "Quantity (Base)"; Decimal)
        {
            Caption = 'Quantity (Base)';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                TestField("Qty. per Unit of Measure", 1);
                Validate(Quantity, "Quantity (Base)");
            end;
        }
        field(13; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
            InitValue = 1;
        }
        field(8001701; Rate; Decimal)
        {
            Caption = 'Rate';
        }
        field(8001702; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(8001704; "Prepay Rule Code"; Code[10])
        {
            Caption = 'Prepay Rule Code';
            Editable = false;
            TableRelation = "Prepay Rule"."Rule Code" where("Rule Code" = field("Prepay Rule Code"),
                                                             "Line No." = field("Prepay Line No."));
        }
        field(8001705; "Prepay Line No."; Integer)
        {
            Caption = 'Prepay Line No.';
            Editable = false;
            TableRelation = "Prepay Rule"."Line No." where("Rule Code" = field("Prepay Rule Code"),
                                                            "Line No." = field("Prepay Line No."));
        }
    }

    keys
    {
        key(STG_Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(STG_Key2; "Employee No.", "From Date")
        {
            SumIndexFields = Quantity, "Quantity (Base)";
        }
        key(STG_Key3; "Employee No.", "Prepay Reason Code", "From Date")
        {
            SumIndexFields = Quantity, "Quantity (Base)";
        }
        key(STG_Key4; "Prepay Reason Code", "From Date")
        {
            SumIndexFields = Quantity, "Quantity (Base)";
        }
        key(STG_Key5; "From Date", "To Date")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        PrepayLedger.SetCurrentkey("Entry No.");
        if PrepayLedger.Find('+') then
            "Entry No." := PrepayLedger."Entry No." + 1
        else
            "Entry No." := 1;
    end;

    var
        Causeofpaycode: Record "Prepay Reason Code";
        Employee: Record Employee;
        PrepayLedger: Record "Prepay Ledger Entry";
        HumanResUnitOfMeasure: Record "Human Resource Unit of Measure";

    local procedure CalcBaseQty(Qty: Decimal): Decimal
    begin
        TestField("Qty. per Unit of Measure");
        exit(ROUND(Qty * "Qty. per Unit of Measure", 0.00001));
    end;
}

