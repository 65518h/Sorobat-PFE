Table 8003926 "Column View Field"
{
    // //REPORT AC 30/12/04 Column Field Table
    //                      Table de selection de champs de la table "Job Phase" utilisé dans le report 50003.


    fields
    {
        field(1; TableNo; Integer)
        {
            Caption = 'Table No.';
            //GL2024 License TableRelation = Object.ID where(Type = const(Table));
            //GL2024 License
            TableRelation = AllObj."Object ID" where("Object Type" = const(Table));
            //GL2024 License
        }
        field(2; ColumnKey; Integer)
        {
            Caption = 'Column Key';
            TableRelation = "Column View".ColumnKey where(TableNo = field(TableNo));
        }
        field(3; LineNo; Integer)
        {
            Caption = 'Line No.';
        }
        field(4; ColumnNo; Integer)
        {
            Caption = 'Column No.';
            TableRelation = Field."No." where(TableNo = field(TableNo));
        }
        field(5; Caption; Text[30])
        {
            Caption = 'Title';
        }
        field(6; Description; Text[30])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(STG_Key1; TableNo, ColumnKey, LineNo)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if (Count > 14) then
            Error(Error001);
    end;

    var
        Error001: label 'Out of list';
}

