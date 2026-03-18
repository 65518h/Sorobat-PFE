Table 8001470 "Role Profile"
{
    // //+REF+PROFILE CW 11/01/06 Profile Matrix
    //   No cascade delete from UserRole to avoid UserRole table modification.
    //   but RoleProfile.OnDeleteRecord delete RoleProfile cascade

    DataPerCompany = false;

    fields
    {
        field(1; "Profile ID"; Code[20])
        {
            Caption = 'Profile ID';
            NotBlank = true;
            //GL2024 TableRelation = "User Role";
        }
        field(2; "Role ID"; Code[20])
        {
            Caption = 'Role ID';
            NotBlank = true;
            //GL2024   TableRelation = "User Role";
        }
    }

    keys
    {
        key(STG_Key1; "Profile ID", "Role ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

