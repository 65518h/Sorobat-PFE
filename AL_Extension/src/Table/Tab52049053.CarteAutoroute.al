table 52049053 "Carte Autoroute"
{ //GL2024  ID dans Nav 2009 : "39004716"
    DrillDownPageID = "Carte Autoroute";
    LookupPageID = "Carte Autoroute";

    fields
    {
        field(1; "N° Véhicule"; Code[10])
        {
            TableRelation = Véhicule;
        }
        field(2; "N° Mission"; Code[20])
        {
            TableRelation = Missions;

            trigger OnValidate()
            begin
                IF Miss.GET("N° Mission") THEN
                    "Date de Prise" := Miss."Date Mission";
            end;
        }
        field(3; "N°Carte Autoroute"; Code[20])
        {
            TableRelation = Item."No." WHERE("No." = FIELD("N° Véhicule"),
                                            "Type Carte" = CONST("Carte Autoroute"));
        }
        field(5; Solde; Decimal)
        {
            DecimalPlaces = 0 : 3;
        }
        field(6; "Montant Carte"; Decimal)
        {
            DecimalPlaces = 0 : 3;

            trigger OnValidate()
            begin
                //IBK DSFT 19 04 2012
                IF RecArticle.GET("N°Carte Autoroute") THEN;
                RecArticle.CALCFIELDS(Inventory);
                IF ("Montant Carte" > RecArticle.Inventory) THEN
                    ERROR(Text001);
            end;
        }
        field(12; Sequence; Integer)
        {
            AutoIncrement = true;
        }
        field(13; Type; Option)
        {
            OptionCaption = ' ,Autoroute,Payéage';
            OptionMembers = " ",Autoroute,"Payéage";
        }
        field(14; "Code"; Code[20])
        {
            TableRelation = Payéage.Code WHERE(Type = FIELD(Type));

            trigger OnValidate()
            begin
                RecPayéage.RESET;
                RecPayéage.SETRANGE(Code, Code);
                IF RecPayéage.FINDFIRST THEN BEGIN
                    "Montant Carte" := RecPayéage.Coût;
                    Multiple := 1;
                END;
                VALIDATE("Montant Carte");
                VALIDATE(Multiple);
            end;
        }
        field(15; Multiple; Integer)
        {

            trigger OnValidate()
            begin
                "Montant Carte" := Multiple * "Montant Carte";
            end;
        }
        field(16; "Date de Prise"; Date)
        {
        }
    }

    keys
    {
        key(Key1; Sequence, "N° Véhicule", "N° Mission")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Veh: Record Véhicule;
        "RecPayéage": Record Payéage;
        Miss: Record Missions;
        RecArticle: Record 27;
        Text001: Label 'Vous devez avoir un stock suffissant pour cette carte autoroute';
}

