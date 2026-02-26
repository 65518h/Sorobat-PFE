Table 8003927 "Column View"
{
    // //REPORT AC 30/12/04 Column Key Table
    //                      liste des champs de la table "Job Phase" utilisé dans le report 50003.


    fields
    {
        field(1; TableNo; Integer)
        {
            //GL2024 License      TableRelation = Object.ID where(Type = const(Table));
            //GL2024 License
            TableRelation = AllObj."Object ID" where("Object Type" = const(Table));
            //GL2024 License
        }
        field(2; ColumnKey; Integer)
        {
        }
        field(3; Description; Text[250])
        {
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
        lColumnFieldTmp: Record "Column View Field";
    begin
        lColumnFieldTmp.SetCurrentkey(TableNo, ColumnKey);
        lColumnFieldTmp.SetRange(TableNo, TableNo);
        lColumnFieldTmp.SetRange(ColumnKey, ColumnKey);
        lColumnFieldTmp.DeleteAll(true);
    end;
}

