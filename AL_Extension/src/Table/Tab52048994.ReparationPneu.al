Table 52048994 "Reparation Pneu"
{
    //GL2024  ID dans Nav 2009 : "39004703"
    fields
    {
        field(1; "N° Reparation"; Code[20])
        {
        }
        field(2; "N° Ligne"; Integer)
        {
        }
        field(12; "Réf. Pneu"; Code[10])
        {

            trigger OnValidate()
            begin

                IF ("Type opétation" = 1) OR ("Type opétation" = 2) THEN BEGIN
                    Rep.SETRANGE("N° Reparation", "N° Reparation");
                    IF Rep.FIND('-') THEN BEGIN
                        pneu.SETRANGE("N° Véhicule", Rep."N° Véhicule");
                        pneu.SETRANGE("Réf. Pneu", "Réf. Pneu");
                        IF NOT pneu.FIND('-') THEN
                            ERROR('Ce pneu n''est pas installé dans cette véhicule, Vérifier la référence !!!')
                        ELSE BEGIN
                            Marque := pneu."Marque Pneu";
                            Type := pneu."Type Pneu";
                            Position := pneu.Position;
                        END;
                    END;
                END;


            end;
        }
        field(13; Marque; Code[10])
        {
            TableRelation = "Marque Pneu";
        }
        field(14; Type; Code[10])
        {
            TableRelation = "Type Pneu";
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
            //GL3900   TableRelation = "Position Pneu";
        }
        field(18; "Km Parcourus"; Decimal)
        {
        }
        field(19; "N°Véhicule"; Code[20])
        {


            trigger OnValidate()
            begin
                pneu.SetRange("N° Véhicule", "N°Véhicule");
                if pneu.FindFirst then begin
                    "Réf. Pneu" := pneu."Réf. Pneu";
                    Marque := pneu."Marque Pneu";
                    Type := pneu."Type Pneu";
                end;
            end;

        }
    }

    keys
    {
        key(Key1; "N° Reparation", "N° Ligne", "N°Véhicule")
        {
            Clustered = true;
            SumIndexFields = "Coût Opération";
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
        pneu: Record "Pneumatique Véhicule";
        i: Integer;
        Rep: Record "Réparation Véhicule";
        Veh: Record "Véhicule";
}

