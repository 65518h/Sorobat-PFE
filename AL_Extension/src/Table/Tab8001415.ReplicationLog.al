Table 8001415 "Replication Log"
{
    // //+REF+REPLIC CW 29/04/05 Table des Log


    fields
    {
        field(1; TableID; Integer)
        {
            NotBlank = true;
            //GL2024 License     TableRelation = Object.ID where(Type = const(Table));

            //GL2024 License
            TableRelation = AllObj."Object ID" where("Object Type" = const(Table));
            //GL2024 License
        }
        field(2; "Trigger"; Option)
        {
            OptionMembers = Insert,Modify,Delete,Rename;
        }
        field(3; "User ID"; Code[20])
        {
            NotBlank = true;
            TableRelation = User;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = true;

            trigger OnLookup()
            var
                LoginMgt: Codeunit "User Management";
            begin
            end;

            trigger OnValidate()
            var
                LoginMgt: Codeunit "User Management";
            begin
            end;
        }
        field(4; DateTime; DateTime)
        {
            NotBlank = true;
        }
        field(11; "Key 1"; Code[20])
        {
        }
        field(12; "Key 2"; Code[20])
        {
        }
        field(13; "Key 3"; Code[20])
        {
        }
        field(14; "Key 4"; Code[20])
        {
        }
        field(15; "Key 5"; Code[20])
        {
        }
        field(16; "Key 6"; Code[20])
        {
        }
        field(17; "Key 7"; Code[20])
        {
        }
        field(18; "Key 8"; Code[20])
        {
        }
        field(19; "Key 9"; Code[20])
        {
        }
        field(21; "To Key 1"; Code[20])
        {
        }
        field(22; "To Key 2"; Code[20])
        {
        }
        field(23; "To Key 3"; Code[20])
        {
        }
        field(24; "To Key 4"; Code[20])
        {
        }
        field(25; "To Key 5"; Code[20])
        {
        }
        field(26; "To Key 6"; Code[20])
        {
        }
        field(27; "To Key 7"; Code[20])
        {
        }
        field(28; "To Key 8"; Code[20])
        {
        }
        field(29; "To Key 9"; Code[20])
        {
        }
    }

    keys
    {
        key(STG_Key1; TableID, "Key 1", "Key 2", "Key 3", "Key 4", "Key 5", "Key 6", "Key 7", "Key 8", "Key 9", "Trigger")
        {
            Clustered = true;
        }
        key(STG_Key2; DateTime)
        {
        }
    }

    fieldgroups
    {
    }
}

