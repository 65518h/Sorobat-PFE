table 52049025 "Calcul Cout"
{
    //GL2024  ID dans Nav 2009 : "39004749"
    fields
    {
        field(1; Rubrique; Code[20])
        {
            TableRelation = "Rubrique Cout";
        }
        field(2; "Element Calcul"; Text[100])
        {
        }
        field(3; Cout; Decimal)
        {
            DecimalPlaces = 0 : 0;

            trigger OnValidate()
            begin
                Calculer;
            end;
        }
        field(4; Unite; Integer)
        {

            trigger OnValidate()
            begin
                Calculer;
            end;
        }
        field(5; "Cout Journalier"; Decimal)
        {
            DecimalPlaces = 0 : 0;
        }
        field(6; Type; Option)
        {
            OptionMembers = Carriere,"Centrale Enrobé","Centrale a Beton";
        }
        field(7; Remarque; Text[250])
        {
        }
        field(8; Ligne; Integer)
        {
            AutoIncrement = true;
        }
        field(50000; Formule; Option)
        {
            OptionMembers = "/","*","% Charge Directe",Mensuelle;
        }
        field(50001; Dynamique; Boolean)
        {
        }
        field(50002; Materiel; Code[20])
        {
            TableRelation = Véhicule;
        }
        field(50003; Mo; Boolean)
        {
        }
        field(50004; Produit; Code[20])
        {
            TableRelation = Item;
        }
        field(50005; "Mo Attaché"; Option)
        {
            OptionMembers = " ",Carriere,"Central Enrobé","Central Beton",Prefa,GRH;
        }
        field(50006; "Charge Direct"; Boolean)
        {
        }
        field(50007; "% Charge Direct"; Decimal)
        {
        }
        field(50008; "Nombre Jours Etallonnage"; Integer)
        {
        }
    }

    keys
    {
        key(STG_Key1; Ligne)
        {
            Clustered = true;
        }
        key(STG_Key2; Rubrique, "Element Calcul")
        {
        }
    }

    fieldgroups
    {
    }


    procedure Calculer()
    begin
        IF Formule = 0 THEN BEGIN
            IF Unite <> 0 THEN "Cout Journalier" := ROUND(Cout / Unite, 1)
        END
        ELSE
            IF Unite <> 0 THEN "Cout Journalier" := ROUND(Cout * Unite, 1);
    end;
}

