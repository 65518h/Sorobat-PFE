Codeunit 8001415 "Check Licence Management"
{
    // PROTECTED


    trigger OnRun()
    begin
        exit;
        //PROTECTED
    end;


    procedure LicenceCheck(pGranuleID: Code[10]; pWithCheckSession: Boolean)
    var
        lAddOnKey: Record "Add-On Licence";
        tLicenceNotEnable: label 'Your license is not enable.\Contact the system manager for more information.';
        tDevelopperLicense: label 'You are using a developper license.\Workdate has been set to %1.';
    begin
        //PROTECTED
    end;


    procedure CheckGranuleKey(pGranuleKeyCode: Code[20]; pLicenceID: Code[30]; pGranuleID: Code[20]; pWithCheckSession: Boolean) Return: Integer
    var
        n: Integer;
        d: Integer;
        lMaxiCode: Integer;
        lMinimum: Integer;
        lExpiration: Integer;
        lExpirationDate: Date;
        tInvalidKey: label 'Invalid key for granule %1';
        lGranuleKey: Integer;
        tCloseToExpiration: label 'Warning :the activation key for granule %1 should be renewed before %2.';
        tOutOfDate: label 'You must renew the activation key for granule %1\Contact the system manager for more information.';
    begin
        //PROTECTED
    end;

    local procedure Decrypter(c: Integer; d: Integer; n: Integer) Return: Integer
    begin
        //PROTECTED
    end;

    local procedure f(pLicenceID: Code[30]; pGranuleID: Code[20]; pModulo: Integer) Return: Integer
    var
        i: Integer;
        wStr: Text[50];
    begin
        //PROTECTED
    end;

    local procedure PowerMod(a: Integer; b: Integer; c: Integer) Return: Integer
    var
        i: Integer;
    begin
        //PROTECTED
    end;

    local procedure Reverse(Text: Text[30]) Return: Text[30]
    var
        i: Integer;
        l: Integer;
    begin
        //PROTECTED
    end;


    procedure Sessions() Return: Integer
    var
        lLicense: Record "License Information";
        lInteger: Integer;
    begin
        //PROTECTED
    end;


    /* 
    //GL2024 Automation non compatible
      procedure fFileMgtGetFiles(var pListFile: Automation Dictionary; var gFileSystemObject: Automation FileSystemObject; pPath: Text[1024]; pWildcard: Text[1024]) retour: Integer
       var
           lObjVBScript: Automation ScriptControl;
           lObjFolder: Automation Folder;
           lObjFiles: Automation Files;
       begin
           //PROTECTED
       end;

       local procedure fCreateScript(var pScript: Automation ScriptControl)
       var
           C13: Char;
           C10: Char;
       begin
           //PROTECTED
       end;

   */
    procedure GetExpirationDate() Return: Date
    var
        lLicenseInformation: Record "License Information";
        ltExpires: label 'Expires                 :';
        lMM_DD_YY: Text[30];
    begin
        //PROTECTED
    end;
}

