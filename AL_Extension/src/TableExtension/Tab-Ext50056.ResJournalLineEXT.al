TableExtension 50056 "Res. Journal LineEXT" extends "Res. Journal Line"
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
        field(8004131; "Start Time"; Time)
        {
            Caption = 'Starting Time';
        }
        field(8004134; "Source Record ID"; RecordID)
        {
            Caption = 'Sales Document No.';
            TableRelation = "Sales Header"."No." where("Document Type" = const(Order));
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(8004135; "Source  Line No."; Integer)
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



    var

        //   ResCost : Record 202;

        ResCost: Record "Resource Cost";



}

