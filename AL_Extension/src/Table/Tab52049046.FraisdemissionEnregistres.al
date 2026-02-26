table 52049046 "Frais de mission Enregistrées"
{
    //GL2024  ID dans Nav 2009 : "39004708"
    fields
    {
        field(1; "Code Mission"; Code[10])
        {
        }
        field(2; "Date mission"; Date)
        {
        }
        field(3; "Code Demandeur"; Code[10])
        {
        }
        field(4; "Code Frais"; Code[10])
        {
            //  TableRelation = "Item Charge" WHERE (Field50030 = FILTER (3));
        }
        field(5; "Désignation Frais"; Text[100])
        {
        }
        field(6; "Quantité"; Decimal)
        {
            DecimalPlaces = 0 : 0;
        }
        field(7; "Coût Unitaire"; Decimal)
        {
            AutoFormatType = 1;
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
        }
        field(11; Accepter; Boolean)
        {
        }
        field(12; Montant; Decimal)
        {
            AutoFormatType = 1;
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

    var
        FRAISANN: Record 5800;
        MISS: Record Missions;
}

