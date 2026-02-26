Table 8003904 "Job Phase Import"
{
    // //PROJET_PHASE GESWAY 01/11/01 Import à partir d'un fichier texte


    fields
    {
        field(1; "Job No."; Code[20])
        {
            Caption = 'Job No.';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Phase Code"; Code[10])
        {
            Caption = 'Phase Code';
        }
        field(4; Description; Text[250])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Job No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

