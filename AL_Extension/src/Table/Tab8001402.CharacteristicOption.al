Table 8001402 "Characteristic Option"
{
    // //+REF+CHARACT GESWAY 01/01/00 Table des codes des caractéristiques complémentaires

    Caption = 'Characteristic option';
    //  LookupPageID = 8001402;

    fields
    {
        field(1; "Table Name"; Option)
        {
            Caption = 'Table Name';
            OptionCaption = 'Account (G/L),Customer,Contact,Vendor,Item,Resource,Job,Fixed Asset,Employee';
            OptionMembers = "Account (G/L)",Customer,Contact,Vendor,Item,Resource,Job,"Fixed Asset",Employee;
        }
        field(2; "Characteristic code"; Code[10])
        {
            Caption = 'Characteristic code';
            TableRelation = "Characteristic Code".Code where("Table Name" = field("Table Name"),
                                                              Code = field("Characteristic code"));
        }
        field(3; Option; Code[10])
        {
            Caption = 'Option';
            NotBlank = true;
        }
        field(4; Description; Text[30])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Table Name", "Characteristic code", Option)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

