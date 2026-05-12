Table 8001932 "Subscr. Review Value"
{
    // #2714 CW 28/05/08
    // //REVISION GESWAY 04/04/03 Nouvelle table

    Caption = 'Price Index Value';
    //DrillDownPageID = 8001932;
    //LookupPageID = 8001932;

    fields
    {
        field(1; "Index Code"; Code[10])
        {
            Caption = 'Code indice';
            TableRelation = "Subscr. Review Index";
        }
        field(2; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
        }
        field(3; Value; Decimal)
        {
            Caption = 'Value';
        }
    }

    keys
    {
        key(STG_Key1; "Index Code", "Starting Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }


    procedure GetValue(pCode: Code[10]; pDate: Date): Decimal
    var
        lIndexValue: Record "Subscr. Review Value";
    begin
        lIndexValue.SetRange("Index Code", pCode);
        lIndexValue.SetRange("Starting Date", 0D, pDate);
        if lIndexValue.Find('+') then
            exit(lIndexValue.Value);
        exit(0);
    end;
}

