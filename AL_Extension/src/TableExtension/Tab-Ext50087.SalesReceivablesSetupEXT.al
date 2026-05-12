TableExtension 50087 "Sales & Receivables SetupEXT" extends "Sales & Receivables Setup"
{
    fields
    {
        field(50000; "Activer Suivi Mode Réglement"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'HJ DSFT 17-03-2011';
        }
        // field(50001; "Frais BIC"; Code[20])
        // {
        //     TableRelation = "Item Charge";
        //     DataClassification = ToBeClassified;
        //     Description = 'RB SORO 29/04/2015';
        // }
        field(50001; "Frais BIC"; Code[20])
        {
            TableRelation = "Item";
            DataClassification = ToBeClassified;
            Description = 'RB SORO 29/04/2015';
        }
        field(50002; "Taux BIC"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
            Description = 'RB SORO 29/04/2015';
        }
    }
}

