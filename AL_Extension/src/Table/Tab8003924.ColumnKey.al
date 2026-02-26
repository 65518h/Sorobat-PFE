Table 8003924 "Column Key"
{
    // //REPORT YB 12/08/04 table des choix de colonne (Cf. report 8003904)

    Caption = 'Column Key';
    // LookupPageID = 8003904;

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
        field(2; ColumnKey; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; ColumnFields; Text[250])
        {
            Caption = 'Key';
        }
    }

    keys
    {
        key(Key1; TableNo, ColumnKey)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        lColumnField: Record "Column Field";
    begin
        lColumnField.SetCurrentkey(TableNo, ColumnKey);
        lColumnField.SetRange(TableNo, TableNo);
        lColumnField.SetRange(ColumnKey, ColumnKey);
        lColumnField.DeleteAll(true);
    end;
}

