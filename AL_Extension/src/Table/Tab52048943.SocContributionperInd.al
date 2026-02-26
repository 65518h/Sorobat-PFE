table 52048943 "Soc. Contribution per Ind."
{
    //GL2024  ID dans Nav 2009 : "39001402"
    Caption = 'Soc. Contribution per Ind.';

    fields
    {
        field(1; "Indemnity Code"; Code[20])
        {
            Caption = 'Indemnity Code';
            TableRelation = Indemnity;
        }
        field(2; "Social Contribution Code"; Code[10])
        {
            Caption = 'Social Contribution Code';
            TableRelation = "Social Contribution";

            trigger OnValidate()
            begin
                IF SocialContribution.GET("Social Contribution Code") THEN BEGIN
                    "Employer's part" := SocialContribution."Employer's part";
                    "Employee's part" := SocialContribution."Employee's part";
                    "Basis of calculation" := SocialContribution."Basis of calculation";
                    "Deductible of taxable basis" := SocialContribution."Deductible of taxable basis";
                END;
            end;
        }
        field(3; "Employer's part"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Employer''s part';
            Editable = false;
        }
        field(4; "Employee's part"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Employee''s part';
            Editable = false;
        }
        field(15; "Basis of calculation"; Option)
        {
            Caption = 'Basis of calculation';
            Editable = false;
            OptionCaption = 'Base = Brut du mois,Base = Brut du mois-(6*SMIG)';
            OptionMembers = "Base = Brut du mois","Base = Brut du mois-(6*SMIG)";
        }
        field(25; "Deductible of taxable basis"; Boolean)
        {
            Caption = 'Deductible of taxable basis';
            Editable = false;
        }
        field(8099198; "User ID"; Code[20])
        {
            Editable = false;
            // TableRelation = Table2000000002;
        }
        field(8099199; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Indemnity Code", "Social Contribution Code")
        {
            Clustered = true;
            SumIndexFields = "Employer's part", "Employee's part";
        }
        key(Key2; "Deductible of taxable basis")
        {
            SumIndexFields = "Employer's part", "Employee's part";
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Last Date Modified" := WORKDATE;
        "User ID" := USERID;
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := WORKDATE;
        "User ID" := USERID;
    end;

    trigger OnRename()
    begin
        "Last Date Modified" := WORKDATE;
        "User ID" := USERID;
    end;

    var
        SocialContribution: Record "Social Contribution";
}

