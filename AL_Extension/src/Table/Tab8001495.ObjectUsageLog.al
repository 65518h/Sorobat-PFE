Table 8001495 "Object Usage Log"
{
    // //+REF+OBJECT_USAGE CW 18/10/10

    Caption = 'Object Usage Log';
    DataPerCompany = false;

    fields
    {
        field(1; "Object Type"; Option)
        {
            Caption = 'Object Type';
            OptionCaption = ' ,Table,Form,Report,Dataport,Codeunit';
            OptionMembers = " ","Table",Form,"Report",Dataport,"Codeunit";
        }
        field(2; "Object ID"; Integer)
        {
            Caption = 'Object ID';
            NotBlank = true;
            TableRelation = if ("Object Type" = filter(> " ")) AllObj."Object ID" where("Object Type" = field("Object Type"));
        }
        field(3; Date; Date)
        {
            Caption = 'Date';
        }
        field(4; "User ID"; Code[20])
        {
            Caption = 'User ID';
            NotBlank = true;
            TableRelation = "User Setup";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            var
                LoginMgt: Codeunit "User Management";
            begin
                // LoginMgt.LookupUserID("User ID");
            end;

            trigger OnValidate()
            var
                LoginMgt: Codeunit "User Management";
            begin
                //LoginMgt.ValidateUserID("User ID");
            end;
        }
        field(5; "Company Name"; Text[30])
        {
            Caption = 'Company Name';
            TableRelation = Company;
        }
        field(6; "No. of Usage"; Integer)
        {
            Caption = 'Nbre d''utilisation';
        }
        field(10; "Object Name"; Text[80])
        {
            CalcFormula = lookup(AllObjWithCaption."Object Caption" where("Object Type" = field("Object Type"),
                                                                           "Object ID" = field("Object ID")));
            Caption = 'Report Name';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Object Type", "Object ID", Date, "User ID", "Company Name")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Res: Record Resource;
}

