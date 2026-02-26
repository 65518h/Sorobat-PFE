table 52049031 "Bareme des frais de mission"
{ //GL2024  ID dans Nav 2009 : "39001503"
  //GL2024  DrillDownPageID = 70143;
  //GL2024  LookupPageID = 70143;

    fields
    {
        field(1; "Code Frais"; Code[20])
        {
        }
        field(2; "Groupe Destination"; Code[20])
        {
            //TableRelation = Table66690;
        }
        field(3; "Moyen Transport"; Code[10])
        {
            TableRelation = "Liste Moyens de transport";
        }
        field(4; Designation; Text[50])
        {
        }
        field(5; Quantite; Decimal)
        {
        }
        field(6; "Montant DS"; Decimal)
        {
        }
        field(7; Type; Option)
        {
            OptionMembers = ,Interne,Externe;
        }
        field(8; "Type Ligne"; Option)
        {
            OptionMembers = ,"Agents et cadres",Chauffeurs;
        }
        field(100; "G/L Account"; Code[20])
        {
            Caption = 'N° Compte';
            TableRelation = "G/L Account";
        }
        field(101; "Bal. G/L Account"; Code[20])
        {
            Caption = 'N° Compte contrepartie';
            TableRelation = "G/L Account";
        }
    }

    keys
    {
        key(Key1; "Code Frais", "Groupe Destination", "Moyen Transport")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

