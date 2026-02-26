Table 8003985 Free8003985
{
    // //REVISION GESWAY 04/04/03 Nouvelle table

    Caption = 'Price Index Value';
    // DrillDownPageID = 8003985;
    //LookupPageID = 8003985;

    fields
    {
        field(1; "Index Code"; Code[10])
        {
            Caption = 'Code indice';
            TableRelation = Free8003983;
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
        key(Key1; "Index Code", "Starting Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }


    procedure GetValue(pCode: Code[10]; pDate: Date): Decimal
    var
        lIndexValue: Record Free8003985;
    begin
        lIndexValue.SetRange("Index Code", pCode);
        lIndexValue.SetRange("Starting Date", 0D, pDate);
        if lIndexValue.Find('+') then
            exit(lIndexValue.Value);
        exit(0);
    end;
}

