Table 8004091 "Vendor Discount Group"
{
    // //+OFF+REMISE GESWAY 17/10/02 Table "Groupe remise fournisseur"

    Caption = 'Vendor Discount Group';
    // LookupPageID = 8004094;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(50000; Synchronise; Boolean)
        {
        }
        field(50001; "Num Sequence Syncro"; Integer)
        {
            Description = 'RB SORO 06/03/2015';
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
        key(Key2; Synchronise)
        {
        }
    }

    fieldgroups
    {
    }
}

