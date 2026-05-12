Table 8004013 "Prepay Time Rate"
{
    // //PREPAIE ETP 01/01/99 Taux repris de la paie pour actualisation écritures ressource et projet
    //           DL  27/12/05 Ajout champs "Charge Rate"
    //           CLA 13/02/06 Ne visualiser que les ressources de type Homme

    Caption = 'Prepay Time Rate';

    fields
    {
        field(1; "Resource No."; Code[20])
        {
            Caption = 'Resource No.';
            NotBlank = true;
            TableRelation = Resource where(Type = const(Person));
        }
        field(2; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            NotBlank = true;
        }
        field(3; "Unit Cost"; Decimal)
        {
            Caption = 'Unit Cost';
        }
        field(4; "Charge Rate"; Decimal)
        {
            Caption = 'Charge Rate';
        }
    }

    keys
    {
        key(STG_Key1; "Resource No.", "Starting Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

