table 52049045 "Frais de mission"
{
    //GL2024  ID dans Nav 2009 : "39004707"
    fields
    {
        field(1; "Code Mission"; Code[10])
        {

            trigger OnValidate()
            begin
                MISS.SETRANGE("N° Mission", "Code Mission");
                IF MISS.FIND('-') THEN BEGIN
                    "Date mission" := MISS."Date Mission";
                    "Code Demandeur" := MISS."Code Demandeur";
                END;
            end;
        }
        field(2; "Date mission"; Date)
        {
        }
        field(3; "Code Demandeur"; Code[10])
        {
        }
        field(4; "Code Frais"; Code[10])
        {
            //TableRelation = "Item Charge" WHERE (Field50030 = FILTER (3));

            trigger OnValidate()
            begin
                IF FRAISANN.GET("Code Frais") THEN BEGIN
                    "Désignation Frais" := FRAISANN.Description;
                    "Gen. Prod. Posting Group" := FRAISANN."Gen. Prod. Posting Group";
                    "VAT Prod. Posting Group" := FRAISANN."VAT Prod. Posting Group";
                    "Tax Group Code" := FRAISANN."Tax Group Code";
                    // >>IMS 23 02 2011
                    // "Type Compte contre partie" := FRAISANN."Type compte Contre Partie";
                    //"N° Compte contre partie" := FRAISANN."N° Compte contre partie";
                    // >>IMS 23 02 2011
                END;
            end;
        }
        field(5; "Désignation Frais"; Text[100])
        {
        }
        field(6; "Quantité"; Decimal)
        {
            DecimalPlaces = 0 : 0;

            trigger OnValidate()
            begin
                VALIDATE(Montant, Quantité * "Coût Unitaire");
            end;
        }
        field(7; "Coût Unitaire"; Decimal)
        {
            AutoFormatType = 1;

            trigger OnValidate()
            begin
                VALIDATE(Montant, Quantité * "Coût Unitaire");
            end;
        }
        field(8; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";

            trigger OnValidate()
            var
                GenProdPostingGrp: Record 251;
            begin
            end;
        }
        field(9; "Tax Group Code"; Code[10])
        {
            Caption = 'Tax Group Code';
            TableRelation = "Tax Group";
        }
        field(10; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";

            trigger OnValidate()
            begin
                IF VATSetup.GET('', "VAT Prod. Posting Group") THEN
                    "Montant TTC" := Montant * (1 + (VATSetup."VAT %" / 100));
            end;
        }
        field(11; Accepter; Boolean)
        {
        }
        field(12; Montant; Decimal)
        {
            AutoFormatType = 1;

            trigger OnValidate()
            begin
                //
                IF VATSetup.GET('', "VAT Prod. Posting Group") THEN
                    "Montant TTC" := Montant * (1 + (VATSetup."VAT %" / 100));
            end;
        }
        field(13; "Type Compte contre partie"; Option)
        {
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset",Employee;
        }
        field(14; "N° Compte contre partie"; Code[10])
        {
        }
        field(15; "Montant TTC"; Decimal)
        {
        }
        field(16; "N° Document"; Code[10])
        {
        }
        field(17; "N° ligne"; Integer)
        {
        }
        field(18; "Date Comptabilisation"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "N° Document", "Code Mission", "N° ligne")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        LigneFraisMission.SETRANGE("N° Document", "N° Document");
        LigneFraisMission.SETRANGE("Code Mission", "Code Mission");
        IF LigneFraisMission.FIND('+') THEN
            "N° ligne" := LigneFraisMission."N° ligne" + 10000
        ELSE
            "N° ligne" := 10000;
        IF EntFrais.GET("N° Document") THEN
            "Date Comptabilisation" := EntFrais."Date Comptabilisation";
    end;

    var
        FRAISANN: Record 5800;
        MISS: Record "Mission Enregistré";
        VATSetup: Record 325;
        LigneFraisMission: Record "Frais de mission";
        EntFrais: Record "Entête Frais de mission";
}

