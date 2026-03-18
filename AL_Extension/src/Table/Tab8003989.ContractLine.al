Table 8003989 "Contract Line"
{
    // //PROJET_FACT CLA 11/10/04 Ligne du type de contrat

    Caption = 'Contract Line';

    fields
    {
        field(1; "Contract type"; Code[10])
        {
            Caption = 'Contract type';
            NotBlank = true;
            TableRelation = "Contract Type";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            NotBlank = true;
        }
        field(3; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(4; "Progress Degree"; Code[10])
        {
            Caption = 'Progress Degree';
            TableRelation = "Document Progress Degree" where("Document Type" = const(Order));

            trigger OnValidate()
            var
                lProgress: Record "Document Progress Degree";
            begin
            end;
        }
        field(5; Percentage; Decimal)
        {
            //blankzero = true;
            Caption = 'Percentage';
            MaxValue = 100;
            MinValue = -100;
        }
        field(6; "Scheduler Gen. Prod. Post. Gp"; Code[10])
        {
            Caption = 'Scheduler Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
    }

    keys
    {
        key(STG_Key1; "Contract type", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

