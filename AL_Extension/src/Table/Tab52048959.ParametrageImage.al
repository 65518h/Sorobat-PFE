Table 52048959 "Parametrage Image"
{
    //GL2024  ID dans Nav 2009 : "39001508"
    fields
    {
        field(1; "Num Table"; Integer)
        {
        }
        field(2; "Dernier Document"; Code[100])
        {
        }
        field(3; "Dernier Code"; Code[100])
        {
        }
        field(4; "Derniere Sequence"; decimal)
        {
        }
        field(5; "Nom Table"; Text[30])
        {
        }
        field(50000; "Table"; Option)
        {
            OptionMembers = " ","E Vente","Ecriture Article","E Achat","E Recpetion","E Gasoil","E Pointage","E Reparation",Article,Caisse,CH1,CH2,CH3,CH4,CH5,CH6,CH7,CH8,"Retour Achat","Production";
        }
        field(50001; Chantier; Boolean)
        {
        }
        field(50002; "Mon Chantier"; Boolean)
        {
        }
        field(50003; "Date Creation"; Date)
        {
        }
        field(50004; "N° Caisse Chantier Extra"; Code[20])
        {
        }
        field(50005; "N° Caisse Chantier Cpt"; Code[20])
        {
        }
        field(50006; "N° Caisse Chantier Aliment"; Code[20])
        {
        }
        /*  field(50007; Mois; Option)
          {
              OptionMembers = " ",Janvier,Fevrier,Mars,Avril,Mai,Jiun,Juillet,Aout,Septembre,Octobre,Novembre,Decembre;
          }
          field(50008; "Année"; Integer)
          {
          }*/
    }

    keys
    {
        key(STG_Key1; "Table")
        {
            Clustered = true;
        }
        key(STG_Key2; "Derniere Sequence")
        {

        }
    }

    fieldgroups
    {
    }

    var
    //GL3900   RecTypeAss: Record "Type Assurance Vie";
}

