Table 8001550 "Tax Gen. Prod. Posting Group"
{
    //GL2024  ID dans Nav 2009 : "8001805"
    // //+TAX+TAXES GESWAY 08/04/03 Nouvelle table

    Caption = 'Tax Gen. Prod. Posting Group';
    //DrillDownPageID = 8001805;
    //LookupPageID = 8001805;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(3; Type; Option)
        {
            Caption = 'Tax Type';
            //GL2024 MaxValue = "5";
            //GL2024   MinValue = Tax2;
            OptionCaption = 'Tax 1,Tax 2,Tax 3,Tax 4,Tax 5';
            OptionMembers = Tax1,Tax2,Tax3,Tax4,Tax5;
        }
    }

    keys
    {
        key(Key1; Type, "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

