Table 8001513 "Column style name"
{
    //GL2024  ID dans Nav 2009 : "8001306"
    // //STATSEXPLORER STATSEXPLORER 01/10/01 Column style name

    Caption = 'Column style name';
    //LookupPageID = 8001306;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[80])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        Colonne.SetRange(Code, Code);
        Colonne.DeleteAll;

        FiltreColonne.SetRange(Code, Code);
        FiltreColonne.DeleteAll;
    end;

    var
        Colonne: Record "Statistic column";
        FiltreColonne: Record "Statistic column filter";
}

