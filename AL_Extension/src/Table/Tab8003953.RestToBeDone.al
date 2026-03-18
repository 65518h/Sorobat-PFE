Table 8003953 "Rest To Be Done"
{
    // //PROJET_REVISION CLA 16/06/03 Nouvelle table pour saisie du reste à engager dans Sous-formulaire phase projet

    Caption = 'Rest To Be Done';

    fields
    {
        field(1; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job;
        }
        field(2; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
            TableRelation = "Job Task"."Job Task No." where("Job No." = field("Job No."));
        }
        field(3; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
        }
        field(4; "New Budget Amount"; Decimal)
        {
            //blankzero = true;
            Caption = 'New Budget Amount';
        }
    }

    keys
    {
        key(STG_Key1; "Job No.", "Job Task No.", "Gen. Prod. Posting Group")
        {
            Clustered = true;
            SumIndexFields = "New Budget Amount";
        }
    }

    fieldgroups
    {
    }
}

