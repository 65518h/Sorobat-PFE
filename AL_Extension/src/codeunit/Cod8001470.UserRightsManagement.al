Codeunit 8001470 "User Rights Management"
{
    // //+REF+PROFILE CW 14/01/06 from URPW13.70 codeunit 70000


    trigger OnRun()
    begin
    end;

    var
        //GL2024 NAVIBAT     CreatePermissions: Page 8001474;
        Text001: label 'You must filter on user to use this function';
        Text002: label 'SUPER';


    procedure GetDBUserID() UserID: Code[20]
    var
    //GL2024 User: Record 2000000002;
    begin
        /*  //GL2024 if Page.RunModal(Page::Users, User) = Action::LookupOK then
             exit(User."User ID");*/
    end;


    procedure GetCompanyName(): Text[30]
    var
        Company: Record Company;
    begin
        if Page.RunModal(0, Company) = Action::LookupOK then
            exit(Company.Name);
    end;


    procedure ShowRolesNotConectedToAUser()
    var
        //GL2024 MemberOf: Record 2000000003;
        UserRole: Record "Permission Set";
        UserRole2: Record "Permission Set" temporary;
    begin
        if UserRole.Find('-') then
            repeat
            //GL2024    MemberOf.SetRange("Role ID", UserRole."Role ID");
            /*  //GL2024 if not MemberOf.Find('-') then begin
                  UserRole2 := UserRole;
                  UserRole2.Insert;
              end;*/
            until UserRole.Next = 0;
        //GL2024 NAVIBAT  PAGE.Run(page::"User Roles List", UserRole2);
    end;


    procedure ShowRolesForAPermission(Permission: Record Permission)
    var
        Permission2: Record Permission;
        UserRole: Record "Permission Set";
        UserRole2: Record "Permission Set" temporary;
    begin
        Permission2.SetRange("Object Type", Permission."Object Type");
        Permission2.SetRange("Object ID", Permission."Object ID");
        Permission2.SetRange("Read Permission", Permission."Read Permission");
        Permission2.SetRange("Insert Permission", Permission."Insert Permission");
        Permission2.SetRange("Modify Permission", Permission."Modify Permission");
        Permission2.SetRange("Delete Permission", Permission."Delete Permission");
        Permission2.SetRange("Execute Permission", Permission."Execute Permission");
        Permission2.SetRange("Security Filter", Permission."Security Filter");
        if Permission2.Find('-') then
            repeat
                if UserRole.Get(Permission2."Role ID") then begin
                    UserRole2 := UserRole;
                    UserRole2.Insert;
                end;
            until Permission2.Next = 0;
        //GL2024 NAVIBAT   PAGE.Run(page::"User Roles List", UserRole2);
    end;


    procedure CreatePermForExistingRole(Role: Code[20])
    begin
        //GL2024   CreatePermissions.SetRole(Role);
        //GL2024  CreatePermissions.Run;
    end;


    procedure CreatePermForNewRole()
    begin
        //GL2024  CreatePermissions.Run;
    end;


    procedure CreateMemberOf(UserID: Code[20]; RoleID: Code[20])
    var
        //GL2024   MemberOf: Record 2000000003;
        //GL2024 User: Record 2000000002;
        Role: Record "Permission Set";
    begin
        /* //GL2024 User.Get(UserID);
         Role.Get(RoleID);
         MemberOf."User ID" := User."User ID";
         MemberOf."Role ID" := Role."Role ID";
         MemberOf."User Name" := User.Name;
         MemberOf."Role Name" := Role.Name;
         MemberOf.Insert;*/
    end;


    procedure ComparePermissions(var Permission: Record Permission; Permission2: Record Permission)
    begin
        if Permission2."Read Permission" > Permission."Read Permission" then
            Permission."Read Permission" := Permission2."Read Permission";
        if Permission2."Insert Permission" > Permission."Insert Permission" then
            Permission."Insert Permission" := Permission2."Insert Permission";
        if Permission2."Modify Permission" > Permission."Modify Permission" then
            Permission."Modify Permission" := Permission2."Modify Permission";
        if Permission2."Delete Permission" > Permission."Delete Permission" then
            Permission."Delete Permission" := Permission."Delete Permission";
        if Permission2."Execute Permission" > Permission."Execute Permission" then
            Permission."Execute Permission" := Permission2."Execute Permission";
    end;


    procedure AddPermissionToRole(Role: Record "Permission Set"; Permission: Record Permission)
    var
        Permission2: Record Permission;
    begin
        Permission2.SetRange("Role ID", Role."Role ID");
        Permission2.SetRange("Object Type", Permission."Object Type");
        Permission2.SetRange("Object ID", Permission."Object ID");
        if Permission2.Find('-') then begin
            ComparePermissions(Permission2, Permission);
            Permission2.Modify;
        end else begin
            Permission2 := Permission;
            Permission2."Role ID" := Role."Role ID";
            Permission2.Insert;
        end;
    end;


    procedure CopyPermFromRole(var Role1: Record "Permission Set"; var Role2: Record "Permission Set")
    var
        Text001: label 'Select role to copy to';
        Text002: label 'Select role to copy from';
        Permission: Record Permission;
    begin
        Permission.SetRange("Role ID", Role2."Role ID");
        if Permission.Find('-') then
            repeat
                AddPermissionToRole(Role1, Permission);
            until Permission.Next = 0;
    end;


    procedure AddMainMenuToUserLookUp(UserID: Code[20]): Integer
    var
        //GL2024 License "Object": Record "Object";
        //GL2024 License
        "Object": Record AllObj;
    //GL2024 License
    begin
        Object.SetRange("Object Type", Object."Object Type"::Page);
        if Page.RunModal(Page::Objects, Object) = Action::LookupOK then begin
            AddMainMenuToUser(UserID, Object."Object ID");
            exit(Object."Object ID");
        end else
            exit(0);
    end;


    procedure AddMainMenuToUser(UserID: Code[20]; MainMenuID: Integer): Integer
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup."User ID" := UserID;
        //UserSetup."Main Menu ID" := MainMenuID;
        if not UserSetup.Insert then
            UserSetup.Modify;
    end;


    procedure CreateUser()
    var
    //GL2024     User: Record 2000000002;
    //GL2024     MemberOf: Record 2000000003;
    begin
        /*  //GL2024  User."User ID" := Text002;
           User.Insert;
           MemberOf."User ID" := User."User ID";
           MemberOf."Role ID" := Text002;
           MemberOf."Role Name" := Text002;
           MemberOf.Insert;*/
    end;


    procedure InputObject()
    var
        DialogBox: Dialog;
        InputValue: Text[30];
    begin
        DialogBox.Open('type: #1#########\' +
                       'nummer: #2#######');
        //GL2024  DialogBox.INPUT(1, InputValue);
    end;
}

