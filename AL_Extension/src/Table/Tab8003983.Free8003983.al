Table 8003983 Free8003983
{
    // //REVISION GESWAY 04/04/03 Nouvelle table

    Caption = 'Price Index';
    //DrillDownPageID = 8003983;
    //LookupPageID = 8003983;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[30])
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
    var
        lIndexValue: Record Free8003985;
    begin
        lIndexValue.SetRange("Index Code", Code);
        lIndexValue.DeleteAll;
    end;
}

