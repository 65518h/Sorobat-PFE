Table 8004141 "Planning Task Assignment"
{
    // //PLANNING_TASK CW 31/08/09

    Caption = 'Job Task Allocation';
    // DrillDownPageID = 8035006;
    //LookupPageID = 8035006;

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
    }

    keys
    {
        key(Key1; "Task No.", Type, "No.")
        {
            Clustered = true;
            MaintainSIFTIndex = false;
        }
        key(Key2; "Project Header No.", "Task No.", Type, "No.")
        {
            MaintainSQLIndex = false;
            SumIndexFields = Quantity;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Last Date Modified" := CurrentDatetime;
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := CurrentDatetime;
    end;

    trigger OnRename()
    begin
        Error(tRenameNotAllowed);
    end;

    var
        tRenameNotAllowed: label 'Affectation non modifiable. Supprimez cette ligne et ajoutez la nouvelle.';
}

