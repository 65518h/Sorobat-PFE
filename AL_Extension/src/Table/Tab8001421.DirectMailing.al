Table 8001421 "Direct Mailing"
{
    // //+BGW+OFFICE GESWAY 18/12/03 Nouvelle table Publipostage

    Caption = 'Direct Mailing';
    //LookupPageID = 8001440;

    fields
    {
        field(1; "Code"; Code[10])
        {
            NotBlank = true;
        }
        field(2; Description; Text[30])
        {
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
    begin
        DirectMailingLine.SetRange(Code, Code);
        DirectMailingLine.DeleteAll;
    end;

    var
        DirectMailingLine: Record "Direct Mailing Line";
}

