TableExtension 50053 "Res. Ledger EntryEXT" extends "Res. Ledger Entry"
{
    fields
    {
        modify("Job No.")
        {
            Caption = 'Job No.';
        }
        modify("Gen. Prod. Posting Group")
        {
            Caption = 'Gen. Prod. Posting Group';
        }
        field(82750; "Mask Code"; Code[10])
        {
            Caption = 'Code Masque';
            TableRelation = Mask;
        }
        field(8004131; "Start Time"; Time)
        {
            Caption = 'Starting Time';
        }
        field(8004134; "Source Record ID"; RecordID)
        {
            Caption = 'Sales Document No.';
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(8004135; "Source Line No."; Integer)
        {
            Caption = 'Sales Line No.';
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(8004140; "Planning Source"; Boolean)
        {
            Caption = 'Planning Source';
        }
        field(8004141; "Employee Absence Entry No."; Integer)
        {
            Caption = 'Employee Absence Entry No.';
        }
        field(8035001; "Project Header No."; Code[20])
        {
            Caption = 'Project Header No.';
            TableRelation = "Planning Header Archive"."No.";
        }
        field(8035003; "Planning Task No."; Text[20])
        {
            Caption = 'Planning Task No.';
            TableRelation = "Planning Line Archive"."Task No.";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(8035006; "Responsable Person"; Code[20])
        {
            CalcFormula = lookup("Planning Line"."Person Responsible" where("Task No." = field("Planning Task No.")));
            Editable = false;
            FieldClass = FlowField;
        }
    }
    keys
    {

        key(Key9; "Resource No.", "Posting Date", "Job No.", "Work Type Code")
        {
        }

        key(Key10; "Resource No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Unit of Measure Code", "Resource Group No.")
        {
        }

        key(Key11; "Entry Type", "Resource No.", "Gen. Bus. Posting Group", "Gen. Prod. Posting Group", "Resource Group No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Job No.", "Work Type Code", "Reason Code", "Posting Date")
        {
            SumIndexFields = Quantity, "Total Cost", "Total Price";
        }

        key(Key12; "Work Type Code", "Resource No.", "Entry Type", "Posting Date")
        {
            SumIndexFields = "Quantity (Base)";
        }

        /*GL2024   key(Key13;"Entry Type","Planning Source",Chargeable,"Unit of Measure Code","Resource Group No.","Resource No.","Planning Task No.","Posting Date")
           {
           MaintainSIFTIndex = false;
           SumIndexFields = Quantity,"Total Cost","Total Price","Quantity (Base)";
           }

           key(Key14;"Entry Type","Planning Source",Chargeable,"Unit of Measure Code","Resource No.","Planning Task No.","Posting Date")
           {
           MaintainSIFTIndex = false;
           SumIndexFields = Quantity,"Total Cost","Total Price","Quantity (Base)";
           }

           key(Key15;"Project Header No.","Planning Task No.","Posting Date")
           {
           MaintainSIFTIndex = false;
           SumIndexFields = Quantity,"Total Cost","Total Price","Quantity (Base)";
           }*/
        key(Key16; "Employee Absence Entry No.")
        {
            MaintainSIFTIndex = false;
            //GL2024 SumIndexFields = Quantity, "Total Cost", "Total Price", "Quantity (Base)";
        }
    }
}

