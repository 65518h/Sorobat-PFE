Table 84133 "UPG Planning Setup"
{

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
        }
        field(6; "Journal Template Name"; Code[10])
        {
        }
        field(7; "Journal Batch Name"; Code[10])
        {
        }
        field(8004135; "Scheduler Template Default"; Code[20])
        {
        }
        field(8004136; "Project Exported Description"; Text[50])
        {
        }
        field(8004137; "Export Type"; Option)
        {
            OptionMembers = MSProject,PlanningForce;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

