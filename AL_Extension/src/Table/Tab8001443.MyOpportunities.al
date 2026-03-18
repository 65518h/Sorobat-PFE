Table 8001443 "My Opportunities"
{
    Caption = 'My Opportunities';

    fields
    {
        field(1; "User ID"; Code[20])
        {
            Caption = 'User ID';
            TableRelation = User;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(2; "Salesperson Code"; Code[10])
        {
            Caption = 'Salesperson Code';
            NotBlank = true;
            TableRelation = "Salesperson/Purchaser";
        }
        field(3; "Open Opportunities"; Integer)
        {
            CalcFormula = count(Opportunity where("Salesperson Code" = field("Salesperson Code"),
                                                   Closed = const(false)));
            Caption = 'Open Opportunities';
            FieldClass = FlowField;
        }
        field(4; "Open To-dos"; Integer)
        {
            CalcFormula = count("To-do" where("Salesperson Code" = field("Salesperson Code"),
                                               Closed = const(false)));
            Caption = 'Open To-dos';
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(STG_Key1; "User ID", "Salesperson Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }


    procedure AddEntities(FilterStr: Text[250])
    var
        "Count": Integer;
        SalePerson: Record "Salesperson/Purchaser";
    begin
        Count := 0;

        SalePerson.SetFilter(Code, FilterStr);
        if SalePerson.FindSet then begin
            repeat
                "User ID" := UserId;
                "Salesperson Code" := SalePerson.Code;
                if Insert then
                    Count += 1;
            until SalePerson.Next = 0;
        end;
    end;
}

