Table 8003903 "Job Phase Comment Line"
{
    // //PROJET_PHASE GESWAY 01/11/01 Commentaires Phase projet
    // //MEMOPAD CW 01/01/06 +"Separator"

    Caption = 'Job Phase Comment Line';
    //  DrillDownPageID = 8003907;
    // LookupPageID = 8003907;

    fields
    {
        field(1; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = "Job";
        }
        field(2; "Phase Code"; Code[10])
        {
            Caption = 'Phase Code';
            //GL2024    TableRelation = Table8003902.Field2 where(Field1 = field("Job No."));
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(4; Date; Date)
        {
            Caption = 'Date';
        }
        field(5; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(6; Comment; Text[80])
        {
            Caption = 'Comments';
        }
        field(8001400; Separator; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Job No.", "Phase Code", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }


    procedure AjouterNouvLig()
    var
        LigComment: Record "Job Phase Comment Line";
    begin
        LigComment.SetRange("Job No.", "Job No.");
        LigComment.SetRange("Phase Code", "Phase Code");
        if not LigComment.Find('-') then
            Date := WorkDate;
    end;
}

