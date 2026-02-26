Codeunit 8001414 "Folder management"
{
    // //+REF+FOLDER CW 03/01/02 Appel de l'explorateur à partir d'une fiche
    //                  03/04/02 Si pas de %1, recherche document html
    //                  27/01/04 Ajout SalesHeader, PurchaseHeader


    trigger OnRun()
    begin
    end;

    var
        tFolderOpenError: label 'Folder %1 does not exists or unreachable.';
        Basic: Codeunit Basic;
        FolderSetUp: Record "Folder Setup";
        tCreateFolder: label 'Folder %1 does not exists.\Do you want to create it ?';
        tFolderNotDefine: label 'Folder path not défined for table %1';
        tFileOpenError: label 'File %1 does not exists or unreachable.';
        RecRef: RecordRef;
        FolderName: Text[250];
        test: File;
        tUnableToCreateFolder: label 'Unable to create folder %1 (error %2)';
        HideValidationDialog: Boolean;


    procedure GetFolder(pRecRef: RecordRef): Text[250]
    begin
        if not FolderSetUp.Get(pRecRef.Number) or (FolderSetUp."Folder path" = '') then
            Error(tFolderNotDefine, pRecRef.Caption)
        else
            exit(FolderSetUp."Folder path");
    end;


    procedure Substitute(var pFolder: Text[250]; pRecordRef: RecordRef)
    begin
        Basic.SubstituteValues(pFolder, pRecordRef, '%' + Format(pRecordRef.Number) + '.', 0);
    end;


    procedure OpenFolder(pFolder: Text[250]; pRecRef: RecordRef)
    var
        lError: Integer;
        //GL2024 License   lFile: Record File;
        i: Integer;
        lTools: Codeunit Tools;
    begin
        if StrPos(pFolder, '%') <> 0 then
            Basic.SubstituteValues(pFolder, pRecRef, '%', 0);
        if pFolder[StrLen(pFolder)] <> '\' then
            Hyperlink(pFolder)
        else begin
            //  pFolder := COPYSTR(pFolder,1,STRLEN(pFolder));
            //  IF STRPOS(pFolder,'\') = 0 THEN
            //    lFile.Name := pFolder
            //  ELSE BEGIN
            //    i := STRLEN(pFolder);
            //    WHILE pFolder[i] <> '\' DO
            //      i -= 1;
            //    lFile.Name := COPYSTR(pFolder,i+1);
            //    lFile.Path := COPYSTR(pFolder,1,i-1);
            //  END;
            //  lFile.SETRANGE(Path,lFile.Path);
            //  lFile.SETRANGE(Name,lFile.Name);
            //  IF lFile.FIND('-') THEN
            //    ShellFolder('Explorer.exe /n,"%1"',pFolder,tFolderOpenError)
            //  ELSE IF CONFIRM(STRSUBSTNO(tCreateFolder,CONVERTSTR(pFolder,'\','/'))) THEN BEGIN

            /* //GL2024 Automation non compatible  if CreateDirectory(pFolder) then
                   ShellFolder(lTools.fGetEnvironPath('WinDir') + '\Explorer.exe', pFolder, tFolderOpenError);*/
            //ShellFolder(ENVIRON('WinDir') + '\Explorer.exe',pFolder,tFolderOpenError);
            //  END;
        end;
    end;


    procedure ShellFolder(pCommand: Text[80]; pFolder: Text[250]; pErrorMessage: Text[250]): Boolean
    var
        lErr: Integer;
        lTools: Codeunit Tools;
    begin
        lErr := 1;
        lTools.fRunCommandLine(pCommand + ' ' + pFolder, true);
        //lErr := SHELL(pCommand,pFolder);
        //IF (lErr <> 1) AND (pErrorMessage <> '') THEN
        //  ERROR(pErrorMessage,CONVERTSTR(pFolder,'\','/'),lErr);
        exit(lErr = 1);
    end;

    /*
    //GL2024 Automation non compatible
        procedure CreateDirectory(pDirectory: Text[250]): Boolean
        var
          //GL2024 Automation non compatible  lFileSystem: Automation FileSystemObject;
            lDirectory: Text[250];
            lTmpStr: Text[250];
            lOK: Boolean;
        begin
            // Thank's to Mibuso Tips&Tricks Forum
        //GL2024 Automation non compatible    Create(lFileSystem);
            if not lFileSystem.FolderExists(pDirectory) then begin
                if HideValidationDialog then
                    lOK := true
                else
                    lOK := Confirm(StrSubstNo(tCreateFolder, ConvertStr(pDirectory, '\', '/')));

                if lOK then begin
                    lTmpStr := pDirectory;
                    while StrPos(lTmpStr, '\') > 0 do begin
                        lDirectory := lDirectory + CopyStr(lTmpStr, 1, StrPos(lTmpStr, '\') - 1) + '\';
                        lTmpStr := DelStr(lTmpStr, 1, StrPos(lTmpStr, '\'));
                        if not lFileSystem.FolderExists(lDirectory) then
                            lFileSystem.CreateFolder(lDirectory);
                    end;
                    if not lFileSystem.FolderExists(lDirectory) then
                        lFileSystem.CreateFolder(pDirectory);
                    exit(true);
                end else
                    exit(false);
            end;
            exit(true);
        end;

    */
    procedure GLAccount(pRec: Record "G/L Account")
    begin
        RecRef.GetTable(pRec);
        FolderName := GetFolder(RecRef);
        Substitute(FolderName, RecRef);
        OpenFolder(FolderName, RecRef);
    end;


    procedure Customer(pRec: Record Customer)
    begin
        RecRef.GetTable(pRec);
        FolderName := GetFolder(RecRef);
        Substitute(FolderName, RecRef);
        OpenFolder(FolderName, RecRef);
    end;


    procedure Vendor(pRec: Record Vendor)
    begin
        RecRef.GetTable(pRec);
        FolderName := GetFolder(RecRef);
        Substitute(FolderName, RecRef);
        OpenFolder(FolderName, RecRef);
    end;


    procedure Item(pRec: Record Item)
    begin
        RecRef.GetTable(pRec);
        FolderName := GetFolder(RecRef);
        Substitute(FolderName, RecRef);
        OpenFolder(FolderName, RecRef);
    end;


    procedure Resource(pRec: Record Resource)
    begin
        RecRef.GetTable(pRec);
        FolderName := GetFolder(RecRef);
        Substitute(FolderName, RecRef);
        OpenFolder(FolderName, RecRef);
    end;


    procedure Job(pRec: Record Job)
    begin
        RecRef.GetTable(pRec);
        FolderName := GetFolder(RecRef);
        Substitute(FolderName, RecRef);
        OpenFolder(FolderName, RecRef);
    end;


    procedure Contact(pRec: Record Contact)
    var
        lRecRef: RecordRef;
        lContact: Record Contact;
    begin
        RecRef.GetTable(pRec);
        FolderName := GetFolder(RecRef);
        if pRec.Type = pRec.Type::Company then
            Substitute(FolderName, RecRef)
        else
            if lContact.Get(pRec."Company No.") then begin
                lRecRef.GetTable(lContact);
                Substitute(FolderName, lRecRef);
            end;
        OpenFolder(FolderName, RecRef);
    end;


    procedure Employee(pRec: Record Employee)
    begin
        RecRef.GetTable(pRec);
        FolderName := GetFolder(RecRef);
        Substitute(FolderName, RecRef);
        OpenFolder(FolderName, RecRef);
    end;


    procedure FixedAsset(pRec: Record "Fixed Asset")
    begin
        RecRef.GetTable(pRec);
        FolderName := GetFolder(RecRef);
        Substitute(FolderName, RecRef);
        OpenFolder(FolderName, RecRef);
    end;


    procedure SalesHeader(pRec: Record "Sales Header")
    var
        lRecRef: RecordRef;
        lCustomer: Record Customer;
        lContact: Record Contact;
        lJob: Record Job;
    begin
        RecRef.GetTable(pRec);
        FolderName := GetFolder(RecRef);
        Substitute(FolderName, RecRef);

        if lCustomer.Get(pRec."Sell-to Customer No.") then;
        lRecRef.GetTable(lCustomer);
        Substitute(FolderName, lRecRef);

        if not lContact.Get(pRec."Sell-to Contact No.") then begin
        end
        else
            if lContact.Type = lContact.Type::Person then
                if not lContact.Get(lContact."Company No.") then
                    lContact.Init;
        lRecRef.GetTable(lContact);
        Substitute(FolderName, lRecRef);

        OpenFolder(FolderName, RecRef);
    end;


    procedure PurchaseHeader(pRec: Record "Purchase Header")
    var
        lRecRef: RecordRef;
        lVendor: Record Vendor;
        lContact: Record Contact;
        lJob: Record Job;
    begin
        RecRef.GetTable(pRec);
        FolderName := GetFolder(RecRef);
        Substitute(FolderName, RecRef);

        if lVendor.Get(pRec."Sell-to Customer No.") then;
        lRecRef.GetTable(lVendor);
        Substitute(FolderName, lRecRef);

        if not lContact.Get(pRec."Buy-from Contact No.") then begin
        end
        else
            if lContact.Type = lContact.Type::Person then
                if not lContact.Get(lContact."Company No.") then
                    lContact.Init;
        lRecRef.GetTable(lContact);
        Substitute(FolderName, lRecRef);


        OpenFolder(FolderName, RecRef);
    end;


    procedure SetHideValidationDialog(pHideValidationDialog: Boolean)
    begin
        HideValidationDialog := pHideValidationDialog;
    end;


    procedure Lot(pRec: Record "Lot No. Information")
    begin
        RecRef.GetTable(pRec);
        FolderName := GetFolder(RecRef);
        Substitute(FolderName, RecRef);
        OpenFolder(FolderName, RecRef);
    end;
}

