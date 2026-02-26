Table 8001552 "Tax Setup2"
{
    //GL2024  ID dans Nav 2009 : "8001807"
    // //+TAX+TAXES GESWAY 08/04/03 Nouvelle table

    Caption = 'Tax Setup';
    //DrillDownPageID = 8001807;
    //LookupPageID = 8001807;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(90001; "Tax 1 Description"; Text[30])
        {
            Caption = 'Tax 1 Description';
        }
        field(90002; "Tax 2 Description"; Text[30])
        {
            Caption = 'Tax 2 Description';
        }
        field(90003; "Tax 3 Description"; Text[30])
        {
            Caption = 'Tax 3 Description';
        }
        field(90004; "Tax 4 Description"; Text[30])
        {
            Caption = 'Tax 4 Description';
        }
        field(90005; "Tax 5 Description"; Text[30])
        {
            Caption = 'Tax 5 Description';
        }
        field(90011; "Tax 1 Value Posting"; Option)
        {
            Caption = 'Tax 1 Value Posting';
            OptionCaption = 'No,Purchase,Sale,Sale and Purchase';
            OptionMembers = No,Purchase,Sale,"Sale and Purchase";
        }
        field(90012; "Tax 2 Value Posting"; Option)
        {
            Caption = 'Tax 2 Value Posting';
            OptionCaption = 'No,Purchase,Sale,Sale and Purchase';
            OptionMembers = No,Purchase,Sale,"Sale and Purchase";
        }
        field(90013; "Tax 3 Value Posting"; Option)
        {
            Caption = 'Tax 3 Value Posting';
            OptionCaption = 'No,Purchase,Sale,Sale and Purchase';
            OptionMembers = No,Purchase,Sale,"Sale and Purchase";
        }
        field(90014; "Tax 4 Value Posting"; Option)
        {
            Caption = 'Tax 4 Value Posting';
            OptionCaption = 'No,Purchase,Sale,Sale and Purchase';
            OptionMembers = No,Purchase,Sale,"Sale and Purchase";
        }
        field(90015; "Tax 5 Value Posting"; Option)
        {
            Caption = 'Tax 5 Value Posting';
            OptionCaption = 'No,Purchase,Sale,Sale and Purchase';
            OptionMembers = No,Purchase,Sale,"Sale and Purchase";
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

