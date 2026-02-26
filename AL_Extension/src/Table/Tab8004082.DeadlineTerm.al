Table 8004082 "Deadline Term"
{
    // //DEVIS CW 26/06/03 Nouvelle table condition de validité

    Caption = 'Deadline Code';
    // LookupPageID = 8004082;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; "Deadline formula"; DateFormula)
        {
            Caption = 'Deadline formula';
        }
        field(3; Description; Text[30])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

