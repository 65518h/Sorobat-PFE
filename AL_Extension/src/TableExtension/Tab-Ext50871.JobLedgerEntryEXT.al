TableExtension 50871 "Job Ledger EntryEXT" extends "Job Ledger Entry"
{
    fields
    {
        field(50105; "Executed measurement"; Decimal)
        {
            Caption = 'Qté éxécutées';
            DataClassification = ToBeClassified;
        }
        field(82750; "Mask Code"; Code[10])
        {
            Caption = 'Mask Code';
            TableRelation = Mask;
        }
        field(99001; "ID pointage"; Code[10])
        {
        }
        field(99002; Balanced; Boolean)
        {
            Caption = 'Balanced';
        }
        field(8003500; "Analytical Distribution"; Boolean)
        {
            Caption = 'Analytical Distribution';
        }
        field(8003900; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            TableRelation = Vendor;
        }
        field(8003901; "Resource Type"; Option)
        {
            Caption = 'Resource Type';
            OptionCaption = 'Person,Machine';
            OptionMembers = Person,Machine,Structure;
        }
        field(8003903; "Attached to Ledger Entry No."; Integer)
        {
            Caption = 'Attached to Ledger Entry No.';
        }
        field(8003904; "Bal. Job No."; Code[20])
        {
            Caption = 'Bal. Job No.';
            TableRelation = Job;
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(8003905; "Pre-Assigned No."; Code[20])
        {
            Caption = 'Pre-Assigned No.';
        }
        field(8003906; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(8003907; "Mission No."; Code[20])
        {
            Caption = 'Mission No.';
        }
        field(8003910; "Overhead Amount"; Decimal)
        {
            Caption = 'Overhead Amount';
        }
        field(8003911; "Work Time Type"; Option)
        {
            Caption = 'Work Time Type';
            OptionCaption = ' ,Producted Hours,Unproduced Hours,Absence Hours,Premium,Transport,Meal';
            OptionMembers = " ","Producted Hours","Unproduced Hours","Absence Hours",Premium,Transport,Meal;
        }
        field(8003912; "G/L Entry No."; Integer)
        {
            //blankzero = true;
            Caption = 'G/L Entry No.';
            TableRelation = "G/L Entry";
        }
        field(8003931; "To Company"; Text[30])
        {
            Caption = 'To Company';
            TableRelation = Company;
        }
        field(8003932; "IC Job Ledg. Entry No."; Integer)
        {
            Caption = 'IC Job Ledg. Entry No.';
        }
        field(8004009; "Bal. Created Entry"; Boolean)
        {
            Caption = 'Bal. Created Entry';
        }
        field(8004010; "Amt. Transfered to G/L"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amt. Transfered to G/L';
        }
        field(8004011; "Add.-Curr. Amt. Transf to G/L"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Add.-Curr. Amt. Posted to G/L';
        }
        field(8004134; "Sales Document No."; Code[20])
        {
            Caption = 'Sales Document No.';
            TableRelation = "Sales Header"."No." where("Document Type" = const(Order));
            //This property is currently not supported
            //TestTableRelation = false;

            trigger OnValidate()
            begin
                if "Sales Document No." <> xRec."Sales Document No." then
                    "Sales Line No." := 0;
            end;
        }
        field(8004135; "Sales Line No."; Integer)
        {
            Caption = 'Sales Line No.';
            TableRelation = "Sales Line"."Line No." where("Document No." = field("Sales Document No."));
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(8004140; Descriptions; Boolean)
        {
            CalcFormula = exist("Description Line" where("Table ID" = const(8004161),
                                                          "Document Line No." = field("Entry No.")));
            Caption = 'Descriptions';
            Editable = false;
            FieldClass = FlowField;
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
    }
    keys
    {

        /*GL2024    key(STG_Key8; Type, "Entry Type", "Country/Region Code", "Source Code", "Posting Date")
            {
            }
            key(STG_Key9; "Entry Type", Type, "No.", "Gen. Prod. Posting Group", "Resource Group No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Job No.", "Work Type Code", "Reason Code", "Posting Date")
            {
                SumIndexFields = "Total Cost";
            }
            key(STG_Key10; "Entry Type", Type, "Job No.", "Job Task No.", "Gen. Prod. Posting Group", "Work Time Type", "Work Type Code", "Resource Group No.", "No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Reason Code", "Posting Date")
            {
                SumIndexFields = Quantity, "Total Cost (LCY)", "Line Amount (LCY)", "Total Cost";
            }
            key(STG_Key11; Type, "No.", "Work Type Code", "Job No.", "Job Task No.", "Posting Date")
            {
                SumIndexFields = "Total Cost (LCY)", "Line Amount (LCY)", Quantity;
            }
            key(STG_Key12; Type, "No.", "Posting Date", "Job No.", "Work Type Code")
            {
            }
            key(STG_Key13; Type, "No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Unit of Measure Code", "Location Code")
            {
            }
            key(STG_Key14; "Vendor No.", "Job No.", Type, "No.", "Posting Date")
            {
            }
            key(STG_Key15; "Analytical Distribution", "Entry Type", Type, "No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Reason Code", "Gen. Prod. Posting Group", "Gen. Bus. Posting Group", "Source Code", "Job No.", "Resource Group No.", "Work Type Code", "Job Task No.", "Posting Date")
            {
                SumIndexFields = "Total Cost";
            }
            key(STG_Key16; "Entry Type", "Bal. Created Entry", "Job Posting Group", "Job No.", "Gen. Prod. Posting Group", "Job Task No.", Type, "Resource Type", "Work Type Code", "Work Time Type", "No.", "Posting Date", "Global Dimension 1 Code", "Global Dimension 2 Code")
            {
                SumIndexFields = "Total Cost (LCY)", "Line Amount (LCY)", Quantity, "Overhead Amount";
            }
            key(STG_Key17; "Entry Type", Type, "Vendor No.", "Mission No.", "No.", "Work Type Code", "Bal. Job No.", "Posting Date")
            {
            }
            key(STG_Key18; "Pre-Assigned No.", "Line No.")
            {
            }
            key(STG_Key19; Balanced, "ID pointage")
            {
            }
            key(STG_Key20; "Job No.", "Gen. Prod. Posting Group", "Entry Type", "Work Type Code", Type, "Resource Type", "No.", "Posting Date", "Work Time Type", "Bal. Created Entry", "Job Posting Group", "Gen. Bus. Posting Group", "Sales Document No.")
            {
                SumIndexFields = "Total Cost (LCY)", "Line Amount (LCY)", Quantity, "Quantity (Base)";
            }
            key(STG_Key21; Type, "No.", "Job No.", "Work Type Code", "Posting Date")
            {
            }
            key(STG_Key22; "To Company", "IC Job Ledg. Entry No.")
            {
            }
            key(STG_Key23; Type, "No.", "Work Type Code", "Job Task No.", "Posting Date", "Job No.")
            {
            }
            key(STG_Key24; "Job No.", "Gen. Prod. Posting Group", "Entry Type", "Resource Type", "Work Type Code", "Posting Date", "Work Time Type", "Bal. Created Entry", "Global Dimension 1 Code", "Global Dimension 2 Code")
            {
                SumIndexFields = "Total Cost (LCY)", "Line Amount (LCY)", Quantity;
            }
            key(STG_Key25; "Posting Date", "Mission No.", "No.", "Work Type Code", Type)
            {
                SumIndexFields = Quantity;
            }
            key(STG_Key26; "Job No.", "Project Header No.", "Entry Type", "Resource Group No.", Type, "No.", "Planning Task No.", "Posting Date")
            {
                MaintainSQLIndex = false;
                SumIndexFields = "Quantity (Base)";
            }*/
    }
    trigger OnAfterDelete()
    VAR
        lDescriptionLine: Record 8004075;

        d: record "Invt. Receipt Line";
    begin
        //DESCRIPTION
        lDescriptionLine.DeleteLines(DATABASE::"Job Ledger Entry", 0, '', "Entry No.");
        //DESCRIPTION//  
    end;
}