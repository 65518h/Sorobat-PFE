Table 8001565 "Workflow Document Code"
{
    //GL2024  ID dans Nav 2009 : "8004222"
    // //+WKF+ GESWAY 01/01/00 Codes table

    Caption = 'Workflow Document Code';
    //  LookupPageID = 8004222;

    fields
    {
        field(1; "Table No"; Integer)
        {
            Caption = 'Table';
            //GL2024 License TableRelation = Object.ID where(Type = const(Table));
            //GL2024 License
            TableRelation = AllObj."Object ID" where("Object Type" = const(Table));
            //GL2024 License
        }
        field(2; "Field No"; Integer)
        {
            Caption = 'Field';
            TableRelation = Field."No." where(TableNo = field("Table No"));
        }
        field(3; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(4; "Document Template"; Integer)
        {
            Caption = 'Document Template';
            NotBlank = true;
            TableRelation = "Workflow Document Template";
        }
        field(5; Description; Text[30])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(STG_Key1; "Table No", "Field No", "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

