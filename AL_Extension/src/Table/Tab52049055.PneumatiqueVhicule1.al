table 52049055 "Pneumatique Véhicule1"
{
    //GL2024  ID dans Nav 2009 : "39004718"
    fields
    {
        field(1; "N° Véhicule"; Code[10])
        {
        }
        field(2; "Réf. Pneu"; Code[30])
        {

            trigger OnValidate()
            begin
                Pne.RESET;
                Pne.SETRANGE("Réf. Pneu", "Réf. Pneu");
                Pne.SETFILTER("N° Véhicule", '<>%1', "N° Véhicule");
                IF Pne.FIND('-') THEN
                    ERROR('Pneu installer dans une autre véhicule, Vérifier la référence du pneu');
            end;
        }
        field(3; "Désignation"; Text[50])
        {
        }
        field(4; "Type Pneu"; Code[10])
        {
            TableRelation = "Type Pneu";

            trigger OnValidate()
            begin
                IF TypePneu.GET("Type Pneu") THEN BEGIN
                    Largeur := TypePneu.Largeur;
                    Diamétre := TypePneu.Diamétre;
                    "durée de vie" := TypePneu."durée de vie";
                END;
            end;
        }
        field(5; "Marque Pneu"; Code[10])
        {
            TableRelation = "Marque Pneu";
        }
        field(6; Largeur; Code[10])
        {
            Editable = false;
        }
        field(7; "Diamétre"; Code[10])
        {
            Editable = false;
        }
        field(8; "Date d'installation"; Date)
        {
        }
        field(9; "durée de vie"; Decimal)
        {
            DecimalPlaces = 0 : 0;
            Editable = false;
        }
        field(10; Position; Code[10])
        {
            TableRelation = "Position Pneu";
        }
        field(11; Parcourus; Decimal)
        {
            CalcFormula = Sum("Mission Enregistré"."Km Parcourus" WHERE("N° Véhicule" = FIELD("N° Véhicule"),
                                                                         "Date Mission" = FIELD("Filtre Date")));
            FieldClass = FlowField;
        }
        field(12; "Filtre Date"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(13; "Date D'enLevement"; Date)
        {
        }
        field(14; Enlever; Boolean)
        {
        }
        field(15; "Num Ligne"; Integer)
        {
            Description = 'MBY 13/07/2011';
        }
    }

    keys
    {
        key(Key1; "N° Véhicule", "Réf. Pneu", "Date d'installation", "Num Ligne")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        TypePneu: Record "Type Pneu";
        Pne: Record "Pneumatique Véhicule";
}

