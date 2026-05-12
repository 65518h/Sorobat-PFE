TableExtension 50140 RelativeEXT extends Relative
{
    fields
    {
        field(8099000; "Associated deduction"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Associated deduction';
        }
        field(8099001; "Holding on end date"; DateFormula)
        {
            Caption = 'Holding on end date';
        }
        field(8099198; "User ID"; Code[20])
        {
            Editable = false;
            TableRelation = User;
        }
        field(8099199; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(39001400; Type; Option)
        {
            OptionMembers = " ",Enfant,"Père","Mère",Conjoint;

            trigger OnValidate()
            begin
                if Type <> 1 then begin
                    "Associated deduction" := 0;
                    "Type Prise En Charge" := 1;
                end;
            end;
        }
        field(39001410; "Type Prise En Charge"; Option)
        {
            OptionMembers = "Prise En Charge Total"," Assurance Groupe";

            trigger OnValidate()
            begin
                if "Type Prise En Charge" = 1 then
                    "Associated deduction" := 0;
            end;
        }
    }

    trigger OnInsert()
    BEGIN
        "Last Date Modified" := WORKDATE;
        "User ID" := USERID;
    END;

    trigger OnModify()
    BEGIN
        "Last Date Modified" := WORKDATE;
        "User ID" := USERID;
    END;

    trigger OnRename()
    BEGIN
        "Last Date Modified" := WORKDATE;
        "User ID" := USERID;
    END;

}

