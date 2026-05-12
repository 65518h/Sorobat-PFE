TableExtension 50127 "Sales Cycle StageEXT" extends "Sales Cycle Stage"
{
    fields
    {
        field(8001400; "Estimate optional"; Boolean)
        {
            Caption = 'Estimate optional';
        }
        field(8001401; "Campaign skip"; Boolean)
        {
            Caption = 'Campaign skip';
        }
        field(8001402; "Activate first stage"; Boolean)
        {
            Caption = 'Activate first stage';
        }
        field(8001404; Create; Option)
        {
            Caption = 'Create ...';
            OptionCaption = ' ,Interaction,Quote,To-Do';
            OptionMembers = " ",Interaction,Quote,"To-Do";

            trigger OnValidate()
            begin
                if Create <> xRec.Create then
                    case Create of
                        Create::" ", Create::Quote:
                            Clear("Interaction Template");
                    end;
            end;
        }
        field(8001405; "Interaction Template"; Code[10])
        {
            Caption = 'Code';
            TableRelation = "Interaction Template";
        }
    }
}

