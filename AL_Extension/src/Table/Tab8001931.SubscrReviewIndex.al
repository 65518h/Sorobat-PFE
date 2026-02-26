Table 8001931 "Subscr. Review Index"
{
    // #2714 CW 28/05/08
    // //REVISION GESWAY 04/04/03 Nouvelle table

    Caption = 'Price Index';
    //DrillDownPageID = 8001931;
    // LookupPageID = 8001931;

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
        lIndexValue: Record "Subscr. Review Value";
    begin
        lIndexValue.SetRange("Index Code", Code);
        lIndexValue.DeleteAll;
    end;
}

