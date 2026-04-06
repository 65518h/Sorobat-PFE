table 52049054 "Carte Autoroute enregistrer"
{ //GL2024  ID dans Nav 2009 : "39004717"
    DrillDownPageID = "Carte Autoroute Enreg";
    LookupPageID = "Carte Autoroute Enreg";

    fields
    {
        field(1; "N° Véhicule"; Code[20])
        {
            TableRelation = Véhicule;
        }
        field(2; "N° Mission"; Code[20])
        {
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
        }
        field(15; Multiple; Integer)
        {
        }
        field(16; "Date de Prise"; Date)
        {
        }
    }

    keys
    {
        key(STG_Key1; Sequence, "N° Véhicule", "N° Mission")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        InsertItemEntry;
    end;


    procedure InsertItemEntry()
    var
        RecItemEntry: Record 83;
        CUItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
        "RecParamétreParc": Record "Paramétre Parc";
    begin
        IF RecParamétreParc.GET THEN BEGIN
            //MBY 14/02/2011
            RecItemEntry.RESET;
            RecItemEntry."Journal Template Name" := RecParamétreParc."Journal Template";
            RecItemEntry."Journal Batch Name" := RecParamétreParc."Journal Batch";
            RecItemEntry."Line No." := 10000;
            RecItemEntry."Document No." := "N° Mission";
            IF RecItemEntry.FINDSET THEN
                RecItemEntry.DELETEALL;
            //MBY 14/02/2011
            RecItemEntry.RESET;
            RecItemEntry."Journal Template Name" := RecParamétreParc."Journal Template";
            RecItemEntry."Journal Batch Name" := RecParamétreParc."Journal Batch";
            RecItemEntry."Line No." := 10000;
            RecItemEntry.VALIDATE("Item No.", "N°Carte Autoroute");
            RecItemEntry."Document No." := "N° Mission";

            RecItemEntry.VALIDATE("Posting Date", "Date de Prise");
            RecItemEntry.VALIDATE("Entry Type", 3);//negatif adjustment
            RecItemEntry."Location Code" := RecParamétreParc."Code Magasin";
            RecItemEntry.VALIDATE(Quantity, "Montant Carte");
            RecItemEntry.Description := 'Prise de carte autoroute ' + "N° Mission";
            RecItemEntry."N° Materiel" := "N° Véhicule";
            RecItemEntry.INSERT;
            CUItemJnlPostLine.RUN(RecItemEntry);
        END
        ELSE
            ERROR('Vérifiez Paramètres Parc');
    end;
}

