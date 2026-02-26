Codeunit 8001534 "Workflow Operation"
{
    //GL2024  ID dans Nav 2009 : "8004201"
    // //+WKF+ CW 06/03/03 Check

    TableNo = "Workflow Journal Line";

    trigger OnRun()
    begin
        CheckAddOn('8004200', rec.TableCaption, 50, Rec.COUNTAPPROX);
        rec.Insert(true);
        //3520
        if rec."Attached to Line No." = 0 then begin
            rec."Attached to Line No." := rec."Entry No.";
            rec.Modify;
        end;
        //3520//
    end;


    procedure CheckAddOn(pGranuleID: Code[20]; pTableCaption: Text[80]; pLimit: Integer; pCount: Integer): Integer
    var
        lAddOnKey: Record "Add-On Licence";
        lCodeID: Integer;
        lExpiration: Integer;
        lReturn: Integer;
        tDemoLicence: label 'This demo version is limited to %2 %1';
    begin
        if StrPos(COMPANYNAME, 'CRONUS') = 1 then
            exit(0)
        else
            if lAddOnKey.Get(pGranuleID, SerialNumber) then
                exit(CheckGranuleKey(lAddOnKey."Granule Key", SerialNumber, pGranuleID))
            else
                if pCount > pLimit then
                    Error(tDemoLicence, pTableCaption, pLimit, pCount)
                else
                    Message(tDemoLicence, pTableCaption, pLimit, pCount);
    end;


    procedure CheckGranuleKey(pGranuleKeyCode: Code[20]; pLicenceID: Code[30]; pGranuleID: Code[20]): Integer
    var
        n: Integer;
        d: Integer;
        lMaxiCode: Integer;
        lMinimum: Integer;
        lExpiration: Integer;
        lExpirationDate: Date;
        tInvalidKey: label 'Invalid key for granule %1';
        lGranuleKey: Integer;
        tOutOfDate: label 'Your licence Workflow has expired.\Contact the system manager for more information.';
    begin
        lMaxiCode := 16;
        n := 32639;
        d := 23677;
        if not Evaluate(lGranuleKey, pGranuleKeyCode) then
            exit(-1);

        lGranuleKey := lGranuleKey - lMinimum;
        lExpiration := lGranuleKey DIV (n * lMaxiCode);
        if Decrypter(lGranuleKey MOD n, d, n) <> f(pLicenceID, pGranuleID, n) then
            exit(-1)
        else
            if lExpiration <> 0 then begin
                lExpirationDate := 20010101D + (lExpiration + 1) * 7;
                if lExpirationDate < Today then
                    Error(tOutOfDate);
            end;

        exit(lGranuleKey DIV n MOD lMaxiCode);
    end;


    procedure Decrypter(c: Integer; d: Integer; n: Integer) Return: Integer
    begin
        Return := PowerMod(c, d, n);
    end;

    local procedure f(pLicenceID: Code[30]; pGranuleID: Code[20]; pModulo: Integer) Return: Integer
    var
        i: Integer;
        wStr: Text[50];
    begin
        Return := 0;
        wStr := Reverse(pGranuleID) + Reverse(pLicenceID);

        for i := 1 to StrLen(wStr) do begin
            Return := Return MOD pModulo;
            if i MOD 2 = 0 then
                Return := Return + ((wStr[i] - 32) MOD 64) * 2
            else
                Return := Return * 2 + ((wStr[i] - 32) MOD 64);
        end;
        Return := (Return * 13) MOD pModulo;
    end;


    procedure PowerMod(a: Integer; b: Integer; c: Integer) Return: Integer
    var
        i: Integer;
    begin
        //Return := a^b mod c
        if c = 0 then
            exit(0);
        Return := 1;
        for i := 1 to b do
            Return := (Return * a) MOD c;
    end;


    procedure Reverse(Text: Text[30]) Return: Text[30]
    var
        i: Integer;
        l: Integer;
    begin
        Return := Text;
        l := StrLen(Text);
        for i := 1 to StrLen(Text) do
            Return[i] := Text[l - i + 1];
    end;
}

