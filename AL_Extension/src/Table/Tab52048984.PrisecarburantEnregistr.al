Table 52048984 "Prise carburant Enregistré"
{
    //GL2024  ID dans Nav 2009 : "39004685"
    DrillDownPageID = "Historique Prise de Carburant";
    LookupPageID = "Historique Prise de Carburant";

    fields
    {
        field(1; "N° Véhicule"; Code[10])
        {
            TableRelation = Véhicule;
        }
        field(2; "N° Mission"; Code[20])
        {
            TableRelation = Missions;
        }
        field(3; "N° Bon Gasoil"; Code[20])
        {
        }
        field(4; "Coût Réel Mission"; Decimal)
        {
            AutoFormatType = 1;
        }
        field(5; "Gasoil Consommé"; Decimal)
        {
        }
        field(6; Energie; Code[20])
        {
            Editable = false;
        }
        field(7; "Cons. Min"; Decimal)
        {
        }
        field(8; "Cons.Max"; Decimal)
        {
        }
        field(9; "Date de Prise"; Date)
        {
        }
        field(10; "Consommation Moyenne"; Decimal)
        {
            Editable = false;
        }
        field(11; "Côut unitaire"; Decimal)
        {
            DecimalPlaces = 0 : 3;
            Editable = false;
        }
        field(12; Sequence; Integer)
        {
            AutoIncrement = true;
        }
        field(13; "Gasoil Consommé Prevu"; Decimal)
        {
            Editable = false;
        }
        field(14; "N° Carte Carburant"; Code[20])
        {
            TableRelation = Item."No." where("Type Carte" = const("Carte Carburant"));
        }
        field(15; "Sans Carte"; Boolean)
        {
        }
        field(16; "Coût Prevu Mission"; Decimal)
        {
            DecimalPlaces = 0 : 3;
        }
        field(17; "N° Affaire"; Code[20])
        {
        }
        field(18; "Article Associé"; Code[20])
        {
        }
        field(19; "% Indicateur Réel/Prevu"; Decimal)
        {
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; Sequence, "N° Véhicule", "N° Mission")
        {
            Clustered = true;
            SumIndexFields = "Gasoil Consommé", "Coût Réel Mission";
        }
        key(Key2; "Date de Prise", "N° Véhicule")
        {
            SumIndexFields = "Gasoil Consommé", "Coût Réel Mission";
        }
        key(Key3; "N° Véhicule", "N° Mission", "Date de Prise")
        {
            SumIndexFields = "Gasoil Consommé", "Coût Réel Mission";
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Sans Carte" = false then
            InsertItemEntry;
    end;

    var
        ParcSetup: Record "Paramétre Parc";
        Veh: Record "Véhicule";
        Text001: label 'Prise de carburant mission  :';
        Text002: label 'Vérifiez Paramètres Parc';


    procedure InsertItemEntry()
    var
        RecItemEntry: Record "Item Journal Line";
        CUItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
        "RecParamétreParc": Record "Paramétre Parc";
    begin
        if RecParamétreParc.Get then begin
            //MBY 14/02/2011
            RecItemEntry.Reset;
            RecItemEntry."Journal Template Name" := RecParamétreParc."Journal Template";
            RecItemEntry."Journal Batch Name" := RecParamétreParc."Journal Batch";
            RecItemEntry."Line No." := 10000;
            RecItemEntry."Document No." := "N° Mission";
            if RecItemEntry.FindSet then
                RecItemEntry.DeleteAll;
            RecItemEntry.Reset;
            RecItemEntry."Journal Template Name" := RecParamétreParc."Journal Template";
            RecItemEntry."Journal Batch Name" := RecParamétreParc."Journal Batch";
            RecItemEntry."Line No." := 10000;
            if "N° Carte Carburant" <> '' then
                RecItemEntry.Validate("Item No.", "N° Carte Carburant")
            else
                RecItemEntry.Validate("Item No.", "Article Associé");
            RecItemEntry."Document No." := "N° Mission";

            RecItemEntry.Validate("Posting Date", "Date de Prise");
            RecItemEntry.Validate("Entry Type", 3);//negatif adjustment
            RecItemEntry."Location Code" := RecParamétreParc."Code Magasin";
            if "N° Carte Carburant" <> '' then
                RecItemEntry.Validate(Quantity, "Coût Réel Mission")
            else
                RecItemEntry.Validate(Quantity, "Gasoil Consommé");
            RecItemEntry.Validate("Unit Cost", "Côut unitaire");
            RecItemEntry.Description := CopyStr(Text001, 1) + "N° Mission";
            RecItemEntry."N° Materiel" := "N° Véhicule";
            RecItemEntry.Materiel := "N° Véhicule";
            RecItemEntry.Marche := "N° Affaire";
            RecItemEntry.Insert;
            CUItemJnlPostLine.Run(RecItemEntry);
        end
        else
            Error(Text002);
    end;
}

