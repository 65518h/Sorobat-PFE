Table 8001425 "Sort Key"
{
    // //+BGW+SORT CW 21/07/03 Sort

    Caption = 'Sort Key';
    //LookupPageID = 8001446;

    fields
    {
        field(1; TableNo; Integer)
        {
            Caption = 'Table ID';

            //GL2024 License TableRelation = Object.ID where(Type = const(Table));
            //GL2024 License

            TableRelation = AllObj."Object ID" where("Object Type" = const(Table));
            //GL2024 License

        }
        field(2; SortKey; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; SortFields; Text[250])
        {
            Caption = 'Key';
        }
        field(4; Print; Option)
        {
            Caption = 'Print Detail';
            OptionCaption = 'If not Null,Always,Never';
            OptionMembers = "If not Null",Always,Never;
        }
    }

    keys
    {
        key(Key1; TableNo, SortKey)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        lSortLine: Record "Sort Field";
    begin
        lSortLine.SetCurrentkey(TableNo, SortKey);
        lSortLine.SetRange(TableNo, TableNo);
        lSortLine.SetRange(SortKey, SortKey);
        if not lSortLine.IsEmpty then
            lSortLine.DeleteAll(true);
    end;
}

