Table 8004012 "Prepay Results"
{
    // //PREPAIE ETP 01/01/99 Table de calcul temporaire

    Caption = 'Prepay Results';
    DataCaptionFields = "Employee No.";
    DrillDownPageID = "Employee Absences";
    LookupPageID = "Employee Absences";

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            NotBlank = true;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                Salarié.Get("Employee No.");
                "Shortcut Dimension 1 Code" := Salarié."Global Dimension 1 Code";
                "Shortcut Dimension 2 Code" := Salarié."Global Dimension 2 Code";
            end;
        }
        field(2; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(3; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
        }
        field(4; "End Date"; Date)
        {
            Caption = 'End Date';
        }
        field(5; "Absence Cause Code"; Code[10])
        {
            Caption = 'Cause of Absence Code';
            TableRelation = "Cause of Absence";

            trigger OnValidate()
            begin
                MotifAbsence.Get("Absence Cause Code");
                Description := MotifAbsence.Description;
                "Unit Code" := MotifAbsence."Unit of Measure Code";
            end;
        }
        field(6; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(7; Quantity; Decimal)
        {
            Caption = 'Quantity';
        }
        field(8; "Unit Code"; Text[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Unit of Measure";
        }
        field(9; "Shortcut Dimension 1 Code"; Code[20])
        {
            //CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(10; "Shortcut Dimension 2 Code"; Code[20])
        {
            //CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(11; Rate; Decimal)
        {
            Caption = 'Rate';
        }
        field(12; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(14; "Lowest Value"; Decimal)
        {
            Caption = 'Lowest Value';
            DecimalPlaces = 2 : 2;
            //GL2024 InitValue = 999"999.99";
        }
        field(15; "Highest value"; Decimal)
        {
            Caption = 'Highest value';
            DecimalPlaces = 2 : 2;
        }
        field(20; "Detail Key"; Integer)
        {
            Caption = 'Detail Key';
        }
        field(100; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(101; "Rule Code"; Code[10])
        {
            Caption = 'Rule Code';
        }
    }

    keys
    {
        key(STG_Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(STG_Key2; "Employee No.", "Starting Date")
        {
            SumIndexFields = Quantity;
        }
        key(STG_Key3; "Employee No.", "Absence Cause Code", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", "Starting Date")
        {
            SumIndexFields = Quantity;
        }
        key(STG_Key4; "Absence Cause Code", "Starting Date")
        {
            SumIndexFields = Quantity;
        }
        key(STG_Key5; "Starting Date", "End Date")
        {
        }
        key(STG_Key6; "Employee No.", "Absence Cause Code", "Detail Key")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        AbsenceSalarie.SetCurrentkey("Entry No.");
        if AbsenceSalarie.Find('+') then
            "Entry No." := AbsenceSalarie."Entry No." + 1
        else
            "Entry No." := 1;
    end;

    var
        MotifAbsence: Record "Cause of Absence";
        "Salarié": Record Employee;
        AbsenceSalarie: Record "Employee Absence";
}

