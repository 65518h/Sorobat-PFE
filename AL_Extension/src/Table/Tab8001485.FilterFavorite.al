Table 8001485 "Filter Favorite"
{
    // #8675 CW 27/12/10
    // //+BGW+FILTER CW 26/12/10

    Caption = 'Favorite';

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
        field(2; "Table ID"; Integer)
        {
            Caption = 'Table ID';
            NotBlank = true;
            //GL2024 License TableRelation = Object.ID where(Type = const(Table));
            //GL2024 License
            TableRelation = AllObj."Object ID" where("Object Type" = const(Table));
            //GL2024 License
        }
        field(3; "Source Type"; Integer)
        {
            Caption = 'Source Type';
        }
        field(4; "No."; Code[20])
        {
            Caption = 'No.';
            NotBlank = true;
            TableRelation = if ("Table ID" = const(18)) Customer
            else
            if ("Table ID" = const(23)) Vendor
            else
            if ("Table ID" = const(27)) Item
            else
            if ("Table ID" = const(36)) "Sales Header"."No."
            else
            if ("Table ID" = const(156)) Resource
            else
            if ("Table ID" = const(167)) "Job"
            else
            if ("Table ID" = const(8004160)) Job
            else
            if ("Table ID" = const(5050)) Contact;
        }
        field(5; "Search Description"; Code[50])
        {
            Caption = 'Search Description';
        }
        field(6; Description; Text[50])
        {
            Caption = 'Description';

            trigger OnValidate()
            begin
                if ("Search Description" = UpperCase(xRec.Description)) or ("Search Description" = '') then
                    "Search Description" := Description;
            end;
        }
    }

    keys
    {
        key(Key1; "User ID", "Table ID", "Source Type", "No.")
        {
            Clustered = true;
        }
        key(Key2; "Table ID", "Source Type", "No.")
        {
        }
        key(Key3; "Table ID", "Search Description")
        {
        }
    }

    fieldgroups
    {
    }
}

