TableExtension 50141 "Employee RelativeEXT" extends "Employee Relative"
{
    fields
    {
        modify("Relative Code")
        {
            trigger OnBeforeValidate()
            begin
                T.RESET;
                T.SETRANGE(Code, "Relative Code");
                IF T.FIND('-') THEN BEGIN
                    "Relative's Employee No." := "Employee No.";
                    "Associated deduction" := T."Associated deduction";
                END
            end;
        }

        field(50000; Sexe; Option)
        {
            OptionMembers = Masculin,"Féminin";
        }
        field(39001400; Type; Option)
        {
            OptionMembers = " ",Enfant,"Père","Mère",Conjoint;

            trigger OnValidate()
            begin
                if Rec.Type <> 1 then begin
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
        field(39001411; "Date de fin Ass. Groupe"; Date)
        {
        }
        field(39001412; "Associated deduction"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Associated deduction';
            Editable = true;
        }
        field(39001413; "Holding on end date"; Date)
        {
            Caption = 'Date de fin de prise en charge';
        }
        field(39001414; "User ID"; Code[20])
        {
            Editable = false;
            TableRelation = User;
        }
        field(39001415; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
    }
    keys
    {
        key(STG_Key2; "Associated deduction")
        {
            SumIndexFields = "Associated deduction";
        }
    }

    var
        T: Record Relative;
}

