TableExtension 50108 "IC PartnerEXT" extends "IC Partner"
{
    fields
    {
        field(8003900; "Resource No."; Code[20])
        {
            Caption = 'Resource No.';
            TableRelation = Resource."No." where(Type = const(Person));
        }
    }

}

