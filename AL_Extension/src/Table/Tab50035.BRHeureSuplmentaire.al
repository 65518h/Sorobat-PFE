Table 50035 "BR Heure Suplémentaire"
{

    fields
    {
        field(1; "Code Brouillard"; Code[20])
        {
        }
        field(2; Mois; Option)
        {
            OptionCaption = 'Janvier,Février,Mars,Avril,Mai,Juin,Juillet,Août,Septembre,Octobre,Novembre,Décembre,13ème,Congé,Prime,Autre,Solder jour de congé';
            OptionMembers = Janvier,"Février",Mars,Avril,Mai,Juin,Juillet,"Août",Septembre,Octobre,Novembre,"Décembre";
        }
        field(3; Annee; Integer)
        {
        }
        field(4; Maticule; Code[20])
        {
            TableRelation = Employee."No.";
        }
        field(5; "Salarié"; Text[60])
        {
        }
        field(6; "Type salarié"; Option)
        {
            OptionCaption = 'Hour based,Month based';
            OptionMembers = "Hour based","Month based";
        }
        field(7; Qualification; Code[20])
        {
        }
        field(8; "Description Qualification"; Text[50])
        {
        }
        field(9; Affectation; Code[10])
        {
        }
        field(10; "Deccription Affectation"; Text[50])
        {
        }
        field(11; "Base Calcule"; Decimal)
        {
        }
        field(12; "Net A Payer"; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(13; "Nombre Heure Suplémentaire"; Decimal)
        {
        }
        field(14; "Heures Par mois"; Decimal)
        {
        }
        field(15; "Max heure sup Mensuel"; Decimal)
        {
        }
        field(16; "Régime"; Code[20])
        {
        }
        field(17; "Appliquer Taux"; Boolean)
        {
            Description = 'MH SORO 12-09-2020';
        }
        field(18; Cloturer; Boolean)
        {
            Description = 'MH SORO 12-09-2020';
        }
    }

    keys
    {
        key(Key1; Mois, Annee, Maticule)
        {
            Clustered = true;
        }
        key(Key2; Affectation, Mois, Annee, Maticule)
        {
        }
    }

    fieldgroups
    {
    }
}