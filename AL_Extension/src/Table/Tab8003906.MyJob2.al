Table 8003906 "My Job2"
{
    // //RTC CW 30/03/10 Copy from 9150 VersionList=NAVW16.00

    Caption = 'My Job';

    fields
    {
        field(1; "User ID"; Code[20])
        {
            Caption = 'User ID';
            TableRelation = User;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(2; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            NotBlank = true;
            TableRelation = Job;
        }
    }

    keys
    {
        key(STG_Key1; "User ID", "Job No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Text001: label 'Added %1 new %2';


    procedure AddEntities(FilterStr: Text[250])
    var
        Job: Record Job;
        "Count": Integer;
    begin
        Count := 0;

        Job.SetFilter("No.", FilterStr);
        if Job.FindSet then
            repeat
                "User ID" := UserId;
                "Job No." := Job."No.";
                if Insert then
                    Count += 1;
            until Job.Next = 0;

        Message(Text001, Count, Job.TableCaption);
    end;
}

