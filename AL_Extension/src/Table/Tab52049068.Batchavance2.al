table 52049068 Batchavance2
{
    DataClassification = ToBeClassified;

    fields
    {
        field(2; NOPaie; Code[50])
        {
            DataClassification = ToBeClassified;


        }
        field(1; NOSalarie; Code[50])
        {
            DataClassification = ToBeClassified;

        }
        field(3; avance; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(4; Netcashed; Decimal)
        {
            DataClassification = ToBeClassified;

        }
    }

    keys
    {
        key(pk; NOPaie) { }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}