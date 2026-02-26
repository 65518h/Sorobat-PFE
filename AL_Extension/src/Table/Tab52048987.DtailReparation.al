Table 52048987 "Détail Reparation"
{
    //GL2024  ID dans Nav 2009 : "39004690"
    fields
    {
        field(1; "N° Reparation"; Code[20])
        {
        }
        field(2; "N° Ligne"; Integer)
        {
        }
        field(3; "Type Réparation"; Option)
        {
            OptionCaption = 'Reparer,Changer';
            OptionMembers = Reparer,Changer;
        }
        field(4; "Code Réparation"; Code[10])
        {
            TableRelation = Pannes;

            trigger OnValidate()
            begin
                if Panne.Get("Code Réparation") then
                    Désignation := Panne.Désignation;

                if Repa.Get("N° Reparation") then
                    "N° Véhicule" := Repa."N° Véhicule";
            end;
        }
        field(5; "Désignation"; Text[100])
        {
        }
        field(6; "Montant Reparation"; Decimal)
        {
            AutoFormatType = 1;
        }
        field(7; "N° Véhicule"; Code[10])
        {
        }
        field(50000; Synchronise; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "N° Reparation", "N° Ligne")
        {
            Clustered = true;
            SumIndexFields = "Montant Reparation";
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        LigRep.Reset;
        LigRep.SetRange("N° Reparation", "N° Reparation");
        if LigRep.Find('+') then
            "N° Ligne" := LigRep."N° Ligne" + 10000
        else
            "N° Ligne" := 10000;
    end;

    var
        LigRep: Record "Détail Reparation";
        Panne: Record Pannes;
        Repa: Record "Réparation Véhicule";
}

