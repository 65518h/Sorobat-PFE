Table 8004103 Fractionation
{
    // //+PMT+MULTI-ECH GESWAY 27/12/02 Table Fractionnement paiement
    // //RETENTION CLA 09/06/04 Ajout Retenue de garantie

    Caption = 'Fractionation';
    //DrillDownPageID = 8004110;
    //LookupPageID = 8004110;

    fields
    {
        field(1; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Fractionation %"; Decimal)
        {
            Caption = 'Fractionation %';
            DecimalPlaces = 2 : 5;
            MaxValue = 100;
            MinValue = 0;
        }
        field(4; "Time between fractionation"; Code[20])
        {
            Caption = 'Time between fractionation';
            DateFormula = true;
        }
        field(8004040; "Retention Code"; Code[10])
        {
            Caption = 'Retention Code';
            TableRelation = Retention;
        }
    }

    keys
    {
        key(STG_Key1; "Payment Terms Code", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

