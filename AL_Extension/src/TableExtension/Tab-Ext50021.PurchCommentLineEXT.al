TableExtension 50021 "Purch. Comment LineEXT" extends "Purch. Comment Line"
{
    fields
    {
        field(50000; "Dys Comment"; Text[150])
        {
            DataClassification = ToBeClassified;
            Caption = 'Comment';
        }

        field(8001400; Separator; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }
}

