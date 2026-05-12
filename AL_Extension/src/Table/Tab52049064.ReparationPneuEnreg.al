
Table 52049064 "Reparation Pneu Enreg."
{
    //GL2024  ID dans Nav 2009 : "39004705"
    fields
    {
        field(1; "N° Reparation"; Code[20])
        {
        }
        field(2; "N° Ligne"; Integer)
        {
        }
        field(12; "Réf. Pneu"; Code[100])
        {
        }
        field(13; Marque; Code[10])
        {
            //GL2024    TableRelation = Table70025;
        }
        field(14; Type; Code[20])
        {
            //GL2024     TableRelation = Table70024;
        }
        field(15; "Type opétation"; Option)
        {
            OptionCaption = 'Nouveau,enlevé,Echange';
            OptionMembers = Nouveau,"enlevé",Echange;
        }
        field(16; "Coût Opération"; Decimal)
        {
            AutoFormatType = 1;
        }
        field(17; Position; Code[10])
        {
            //GL2024    TableRelation = Table70029;
        }
        field(18; "Km Parcourus"; Decimal)
        {
        }
        field(19; "N°Véhicule"; Code[20])
        {
        }
    }

    keys
    {
        key(STG_Key1; "N° Reparation", "N° Ligne")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        RPneu.Reset;
        RPneu.SetRange("N° Reparation", "N° Reparation");
        if RPneu.Find('+') then
            "N° Ligne" := RPneu."N° Ligne" + 10000
        else
            "N° Ligne" := 10000;
    end;

    var
        RPneu: Record "Reparation Pneu";
}

