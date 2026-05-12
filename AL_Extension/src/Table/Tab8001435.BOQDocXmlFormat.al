Table 8001435 "BOQ Doc Xml Format"
{
    // #7007 AC 25/02/09

    Caption = 'BOQ Doc Xml Format';

    fields
    {
        field(1; EntryNo; Integer)
        {
        }
        field(2; RecordID; RecordID)
        {
        }
        field(3; BOQXML; Blob)
        {
        }
    }

    keys
    {
        key(STG_Key1; EntryNo)
        {
        }
        key(STG_Key2; RecordID)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        lBOQXmlDoc: Record "BOQ Doc Xml Format";
    begin
        if lBOQXmlDoc.FindLast then
            EntryNo := lBOQXmlDoc.EntryNo + 1
        else
            EntryNo := 1;
    end;
}

