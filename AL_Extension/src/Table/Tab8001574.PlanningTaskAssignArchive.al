Table 8001574 "Planning Task Assign Archive"
{
    //GL2024  ID dans Nav 2009 : "8035003"
    // //PLANNING_TASK CW 31/08/09

    Caption = 'Job Task Allocation';
    // DrillDownPageID = 8035006;
    // LookupPageID = 8035006;

    fields
    {
        field(1; "Project Header No."; Code[20])
        {
            Caption = 'Project Header No.';
            TableRelation = "Planning Header"."No.";
        }
        field(3; "Task No."; Text[20])
        {
            Caption = 'Task No.';
        }
        field(4; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Resource,Resource Group';
            OptionMembers = Resource,"Resource Group";
        }
        field(5; "No."; Code[20])
        {
            Caption = 'No.';
            NotBlank = true;
            TableRelation = if (Type = const(Resource)) Resource."No." where(Type = filter(Person .. Machine))
            else
            if (Type = const("Resource Group")) "Resource Group"."No." where(Type = filter(Person .. Machine));
        }
        field(10; Quantity; Decimal)
        {
            //blankzero = true;
            Caption = 'Quantity';
        }
        field(60; "Last Date Modified"; DateTime)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(61; "Deleted Date"; DateTime)
        {
            Caption = 'Deleted Date';
            Editable = false;
        }
        field(5047; "Version No."; Integer)
        {
            Caption = 'Version No.';
        }
    }

    keys
    {
        key(STG_Key1; "Task No.", Type, "No.", "Version No.")
        {
            Clustered = true;
            MaintainSIFTIndex = false;
            SumIndexFields = Quantity;
        }
        key(STG_Key2; "Project Header No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnRename()
    begin
        Error(tRenameNotAllowed);
    end;

    var
        tRenameNotAllowed: label 'Affectation non modifiable. Supprimez cette ligne et ajoutez la nouvelle.';
}

