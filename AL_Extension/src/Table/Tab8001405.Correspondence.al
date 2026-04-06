Table 8001405 Correspondence
{
    // //+REF+CONVERT GESWAY 01/11/99 Table de correspondance
    //                       10/03/03 Longueur de pCode passée à 20 dans les fonctions
    //                       05/08/03 VersionList REF en non BGW

    Caption = 'Correspondence';

    fields
    {
        field(1; "Table"; Integer)
        {
            Caption = 'Table';
            NotBlank = true;
            //GL2024 License  TableRelation = Object.ID where(Type = const(Table));
            //GL2024 License
            TableRelation = AllObj."Object ID" where("Object Type" = const(Table));
            //GL2024 License
        }
        field(3; "External Code"; Code[20])
        {
            Caption = 'External code';
        }
        field(4; "Navision Code"; Code[20])
        {
            Caption = 'Navision code';
            TableRelation = if (Table = const(3)) "Payment Terms"
            else if (Table = const(4)) Currency
            else if (Table = const(6)) "Customer Price Group"
            else if (Table = const(8)) Language
            else if (Table = const(9)) "Country/Region"
            else if (Table = const(10)) "Shipment Method"
            else if (Table = const(13)) "Salesperson/Purchaser"
            else if (Table = const(14)) Location
            else if (Table = const(15)) "G/L Account"
            else if (Table = const(18)) Customer
            else if (Table = const(23)) Vendor
            else if (Table = const(27)) Item
            else if (Table = const(204)) "Unit of Measure"
            else if (Table = const(231)) "Reason Code"
            else if (Table = const(289)) "Payment Method"
            else if (Table = const(291)) "Shipping Agent"
            else if (Table = const(292)) "Reminder Terms";
        }
        field(5; Observation; Text[30])
        {
            Caption = 'Observation';
        }
    }

    keys
    {
        key(STG_Key1; "Table", "External Code")
        {
            Clustered = true;
        }
        key(STG_Key2; "Table", "Navision Code")
        {
        }
    }

    fieldgroups
    {
    }


    procedure ToNavision(pTable: Integer; pCode: Code[20]) Return: Code[20]
    begin
        if Get(pTable, pCode) then
            Return := "Navision Code"
        else
            Return := pCode;
    end;


    procedure FromNavision(pTable: Integer; pCode: Code[20]) Return: Code[20]
    begin
        SetCurrentkey(Table, "Navision Code");
        SetRange(Table, pTable);
        SetRange("Navision Code", pCode);
        if Find('-') then
            Return := "External Code"
        else
            Return := pCode;
    end;
}

