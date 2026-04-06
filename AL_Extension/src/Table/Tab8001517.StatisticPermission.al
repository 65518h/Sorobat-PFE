Table 8001517 "Statistic Permission"
{
    //GL2024  ID dans Nav 2009 : "8001310"
    // #6646 SD 03/11/08
    // //STATSEXPLORER STATSEXPLORER 01/10/01 Statistic Permission

    Caption = 'Statistic Permission';

    fields
    {
        field(1; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Statistic,Category';
            OptionMembers = Statistique,"Catégorie";
        }
        field(10; "Code"; Code[10])
        {
            Caption = 'Code';
            TableRelation = if (Type = filter(Statistique)) "Standard statistic".Code
            else
            if (Type = filter(Catégorie)) "Statistic category".Code;
        }
        field(20; "Authorized group"; Code[20])
        {
            Caption = 'Authorized group';
            //GL2024  TableRelation = "User Role";
        }
    }

    keys
    {
        key(STG_Key1; Type, "Code", "Authorized group")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }


    procedure Autorisation(TypeSecurite: Option Statistique,"Catégorie"; CodeStatistique: Code[10]; User: Code[20]) Permission: Boolean
    var
        //MembreSecurite: Record 2000000003;
        StatistiquePredefinie: Record "Standard statistic";
        lSID: Text[100];
        lLoginMgt: Codeunit "User Management";
    begin
        Reset;
        //DYS FONCTION OBSOLET
        // lSID := lLoginMgt.GetSID(UserId);
        // if lSID = '' then
        //     exit(DBAutorisation(TypeSecurite, CodeStatistique, User))
        // else
        //     exit(WINAutorisation(TypeSecurite, CodeStatistique, lSID))
    end;


    procedure DBAutorisation(TypeSecurite: Option Statistique,"Catégorie"; CodeStatistique: Code[10]; User: Code[20]) Permission: Boolean
    var
        // MembreSecurite: Record 2000000003;
        StatistiquePredefinie: Record "Standard statistic";
        lSID: Text[100];
        lLoginMgt: Codeunit "User Management";
    begin
        Reset;
        //DYS FONCTION OBSOLET
        // Recherche des administrateurs
        // MembreSecurite.SetRange("User ID", User);
        // MembreSecurite.SetFilter("Role ID", '%1', 'SUPER*');
        // if not MembreSecurite.IsEmpty then
        //     exit(true);

        // MembreSecurite.SetRange(Company, COMPANYNAME);
        // if not MembreSecurite.IsEmpty then
        //     exit(true);
        // MembreSecurite.Reset;

        // //IF (MembreSecurite.WRITEPERMISSION) OR (NOT FIND('-')) OR (STRPOS(COMPANYNAME,'CRONUS') = 1) THEN
        // if IsEmpty or (StrPos(COMPANYNAME, 'CRONUS') = 1) then
        //     exit(true)
        // else begin
        //     // On recherche une permission sur la stat
        //     SetRange(Type, TypeSecurite);
        //     SetRange(Code, CodeStatistique);
        //     if not IsEmpty then begin
        //         FindFirst;
        //         repeat
        //             if MembreSecurite.Get(User, "Authorized group") then
        //                 exit(true);
        //             if MembreSecurite.Get(User, "Authorized group", COMPANYNAME) then
        //                 exit(true);
        //         until (Next = 0) or (Permission);
        //     end;

        //     // Sinon on recherche une permission sur la catégorie
        //     if (StatistiquePredefinie.Get(CodeStatistique)) and (StatistiquePredefinie.Category <> '') then begin
        //         SetRange(Type, Type::Catégorie);
        //         SetRange(Code, StatistiquePredefinie.Category);
        //         if not IsEmpty then begin
        //             FindFirst;
        //             repeat
        //                 if MembreSecurite.Get(User, "Authorized group") then
        //                     exit(true);
        //                 if MembreSecurite.Get(User, "Authorized group", COMPANYNAME) then
        //                     exit(true);
        //             until (Next = 0) or (Permission);
        //         end;
        //     end;

        //     exit(false);
        // end;
    end;


    procedure WINAutorisation(TypeSecurite: Option Statistique,"Catégorie"; CodeStatistique: Code[10]; User: Text[100]) Permission: Boolean
    var
        WindowsAccessCtrl: Record "Access Control";
        StatistiquePredefinie: Record "Standard statistic";
    begin
        Reset;
        // Recherche des administrateurs
        //GL2024  WindowsAccessCtrl.SetRange("Login SID", User);
        WindowsAccessCtrl.SetFilter("Role ID", '%1', 'SUPER*');
        if not WindowsAccessCtrl.IsEmpty then
            exit(true);

        WindowsAccessCtrl.SetRange("Company Name", COMPANYNAME);
        if not WindowsAccessCtrl.IsEmpty then
            exit(true);
        WindowsAccessCtrl.Reset;

        //IF (WindowsAccessCtrl.WRITEPERMISSION) OR (NOT FIND('-')) OR (STRPOS(COMPANYNAME,'CRONUS') = 1) THEN
        if IsEmpty or (StrPos(COMPANYNAME, 'CRONUS') = 1) then
            exit(true)
        else begin
            // On recherche une permission sur la stat
            SetRange(Type, TypeSecurite);
            SetRange(Code, CodeStatistique);
            if not IsEmpty then begin
                FindFirst;
                repeat
                    if WindowsAccessCtrl.Get(User, "Authorized group") then
                        exit(true);
                    if WindowsAccessCtrl.Get(User, "Authorized group", COMPANYNAME) then
                        exit(true);
                until (Next = 0) or (Permission);
            end;

            // Sinon on recherche une permission sur la catégorie
            if (StatistiquePredefinie.Get(CodeStatistique)) and (StatistiquePredefinie.Category <> '') then begin
                SetRange(Type, Type::Catégorie);
                SetRange(Code, StatistiquePredefinie.Category);
                if not IsEmpty then begin
                    FindFirst;
                    repeat
                        if WindowsAccessCtrl.Get(User, "Authorized group") then
                            exit(true);
                        if WindowsAccessCtrl.Get(User, "Authorized group", COMPANYNAME) then
                            exit(true);
                    until (Next = 0) or (Permission);
                end;
            end;

            exit(false);
        end;
    end;
}

