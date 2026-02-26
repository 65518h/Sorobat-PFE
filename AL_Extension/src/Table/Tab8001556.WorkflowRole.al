Table 8001556 "Workflow Role"
{
    //GL2024  ID dans Nav 2009 : "8004202"
    // //+WKF+ CW 03/08/02 New

    Caption = 'Workflow Role';
    // LookupPageID = 8004202;

    fields
    {
        field(1; "Role ID"; Code[10])
        {
            Caption = 'Role ID';
            NotBlank = true;
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(3; "User Filter"; Code[20])
        {
            Caption = 'User filter';
            FieldClass = FlowFilter;
        }
        field(4; "User Granted"; Boolean)
        {
            CalcFormula = exist("Workflow Role - User" where("User ID" = field("User Filter"),
                                                              "Role ID" = field("Role ID")));
            Caption = 'User Granted';
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                "User Granted" := xRec."User Granted";
            end;
        }
        field(5; "Main User ID"; Code[20])
        {
            Caption = 'Utilisateur principal';
            TableRelation = "User Setup";

            trigger OnLookup()
            begin
                //   LoginManagement.LookupUserID("Main User ID");
            end;

            trigger OnValidate()
            begin
                // LoginManagement.ValidateUserID("Main User ID");
            end;
        }
        field(6; "Notification Number"; Integer)
        {
            CalcFormula = count("Workflow Journal Line" where("To Role" = field(filter("Role ID")),
                                                               "To User ID" = field("User Filter"),
                                                               Open = const(true),
                                                               "Due Date" = field("Due Date Filter")));
            Caption = 'Notification Number';
            FieldClass = FlowField;
        }
        field(7; "Due Date Filter"; Date)
        {
            Caption = 'Due Date';
            FieldClass = FlowFilter;
        }
        field(8; "Last due Date"; Date)
        {
            CalcFormula = min("Workflow Journal Line"."Due Date" where("Due Date" = filter(<> ''),
                                                                        "To User ID" = field("User Filter"),
                                                                        "To Role" = field("Role ID"),
                                                                        Open = const(true)));
            Caption = 'Last Due Date';
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Role ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        lUserRole: Record "Workflow Role - User";
    begin
        lUserRole.SetRange("Role ID", "Role ID");
        lUserRole.DeleteAll;
    end;

    var
        LoginManagement: Codeunit "User Management";
}

