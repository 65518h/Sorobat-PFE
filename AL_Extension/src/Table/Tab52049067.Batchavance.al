table 52049067 Batchavance
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; NOAvance; Code[50])
        {
            DataClassification = ToBeClassified;

        }
        field(2; Dateeffet; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(3; DateFin; Date)
        {
            DataClassification = ToBeClassified;

        }
    }

    keys
    {
        key(PK; NOAvance)
        {
            Clustered = true;
        }

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