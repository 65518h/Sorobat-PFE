Table 8001529 "Statistic User"
{
    //GL2024  ID dans Nav 2009 : "8001323"
    // //STATSEXPLORER STATSEXPLORER 01/10/10 Statistic User for sheduler line

    Caption = 'Statistic User';

    fields
    {
        field(1; "Sheduler code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
            TableRelation = "Statistic Scheduler header";
        }
        field(2; "Statistic code"; Code[10])
        {
            Caption = 'Statistic code';
        }
        field(3; "User ID"; Code[20])
        {
            Caption = 'User ID';
            TableRelation = "User Setup";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            var
                LoginMgt: Codeunit "User Management";
            begin
                //LoginMgt.LookupUserID("User ID");
                Validate("User ID");
            end;

            trigger OnValidate()
            var
                LoginMgt: Codeunit "User Management";
            begin
                //LoginMgt.ValidateUserID("User ID");
            end;
        }
    }

    keys
    {
        key(STG_Key1; "Sheduler code", "Statistic code", "User ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

