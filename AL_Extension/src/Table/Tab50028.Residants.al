Table 50028 Residants
{

    fields
    {
        field(1; Chantier; Code[20])
        {
        }
        field(2; Proprietaire; Code[20])
        {
        }
        field(3; "Code Appartement"; Code[20])
        {
        }
        field(4; Residant; Text[100])
        {
        }
        field(5; Matricule; Code[20])
        {
        }
        field(6; "Nom Et Prenom"; Text[100])
        {
            //GL2024 CalcFormula = lookup(Employee."First Name" where ("No."=field(Matricule)));
            CalcFormula = lookup(Employee."First Name" where("No." = field(Matricule)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(7; Qualification; Code[20])
        {
            Editable = true;
        }
        field(8; Tel; Code[20])
        {
            Editable = false;
        }
        field(9; "Chambre Liberé"; Boolean)
        {
        }
        field(10; "Date Liberation Chambre"; Date)
        {
        }
    }

    keys
    {
        key(Key1; Chantier, Proprietaire, "Code Appartement", Residant)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

