Codeunit 8001410 "Version list"
{
    // //+BGW+VERSION GESWAY 01/12/01 Check Version List (Called from CodeUnit 1)
    // 
    // Syntaxe de la version List  : XXXX.vv.rr
    //   XXXX est une suite de caractères quelconques (sauf '.') et de longueur indifférente (ex : REF3 ou NAVW13)
    //   vv est le numéro de version
    //   rr est le numéro de révision optionnel (il n'y a pas de révision .00)
    // 
    // La VersionList qui suit la REF3.01.05 est REF3.01.06 ou REF3.02
    //       et celle qui suit la REF3.02    est REF3.02.01 ou REF3.03
    // 
    // Une nouvelle VERSION inclut toutes les REVISIONs intermédiaires.
    // Ainsi par exemple, tous les objets REF3.01.01 à REF3.01.99 deviennent REF3.02.
    // Par contre les objets REF3.01 sont inchangés.


    trigger OnRun()
    var
        lNextMajor: Text[80];
        lNextVersion: Text[80];
        lNextRevision: Text[80];
    begin
        Object.Get(Object."Object Type"::Table, '', Database::"Version List");
        VersionList.SetFilter("Entry ID", '>0');
        if not VersionList.Find('+') then
            InsertVersionList()
        /*//GL2024 License    else
                if Object."Version List" = VersionList."Version List" then begin
                    exit
                end else begin
                    NextVersionList(VersionList."Version List", lNextMajor, lNextRevision, lNextVersion);
                    if (Object."Version List" in [lNextMajor, lNextRevision, lNextVersion]) or
                      (VersionList."Version List" = CopyStr(Object."Version List", 1, StrLen(Object."Version List") - 1)) then
                        InsertVersionList()
                    else
                        Error(tVersionOrder, VersionList."Version List", Object."Version List");
                end;//GL2024 License*/
    end;

    var
        //GL2024 License "Object": Record "Object";
        //GL2024 License
        "Object": Record AllObj;
        //GL2024 License
        VersionList: Record "Version List";
        tVersionOrder: label 'Versions was not installed in proped order.\You can''t upgrade from %1 to %2.';
        tDotCount: label 'Version List : %1 must be format as XXX9.99 or XXX9.99.99';
        tSyntaxError: label 'Version List %1 Syntax Error (XXXX.vv.rr)';


    procedure NextVersionList(pVersionList: Text[80]; var pNextMajor: Text[80]; var pNextRevision: Text[80]; var pNextVersion: Text[80])
    var
        i: Integer;
        j: Integer;
        k: Integer;
        lMajor: Text[80];
        lRevision: Text[80];
        lVersion: Text[80];
    begin
        i := StrPos(pVersionList, '.');
        if (i = 0) or (StrPos(pVersionList, ',') <> 0) then
            Error(tSyntaxError, pVersionList);
        j := StrPos(CopyStr(pVersionList, i + 1), '.');
        k := 1;
        while (k < i - 1) and not (pVersionList[k] in [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]) do
            k += 1;
        lMajor := CopyStr(pVersionList, k, i - k);
        if j = 0 then begin
            lVersion := CopyStr(pVersionList, i + 1);
            lRevision := '00';
        end else begin
            lVersion := CopyStr(pVersionList, i + 1, j - 1);
            lRevision := CopyStr(pVersionList, i + j + 1);
        end;
        pNextRevision := CopyStr(pVersionList, 1, i - 1) + '.' + lVersion + '.' + IncStr(lRevision);
        pNextVersion := CopyStr(pVersionList, 1, i - 1) + '.' + IncStr(lVersion);
        pNextMajor := CopyStr(pVersionList, 1, k - 1) + IncStr(lMajor) + '.00';
    end;


    procedure InsertVersionList()
    var
        lVersionList: Record "Version List";
        //GL2024 License "lObject": Record "Object";
        //GL2024 License
        "lObject": Record AllObj;
    //GL2024 License
    begin
        lObject.Get(lObject."Object Type"::Table, '', Database::"Version List");
        lVersionList.SetFilter("Entry ID", '>0'); // Avoid GUID Offset
        if lVersionList.FindLast then;
        lVersionList."Entry ID" += 1;
        //GL2024 License    lVersionList."Version List" := lObject."Version List";
        lVersionList.UserID := UserId;
        lVersionList.Date := Today;
        lVersionList.Time := Time;
        lVersionList.Insert;
    end;


    procedure ApplicationVersion(pBaseVersion: Text[30]): Text[30]
    var
        lMinutes: Integer;
        lSeconds: Integer;
    begin
        if Object.Get(Object."Object Type"::Table, '', Database::"Version List") then;
        /*//GL2024 License  if Object.Time >= 100000T then
              exit(CopyStr(StrSubstNo('%1 - %2', pBaseVersion, Object."Version List"), 1, 30))
          else begin
              Evaluate(lMinutes, Format(Object.Time, 0, '<Minutes>'));
              Evaluate(lSeconds, Format(Object.Time, 0, '<Seconds>'));
              exit(CopyStr(StrSubstNo('%1 - %2-%3', pBaseVersion, Object."Version List", lMinutes * 60 + lSeconds), 1, 30))
          end;//GL2024 License*/
    end;
}

