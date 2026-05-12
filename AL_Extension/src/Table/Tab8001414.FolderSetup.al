Table 8001414 "Folder Setup"
{
    // //+REF+FOLDER GESWAY 03/01/02 Configuration des répertoires

    Caption = 'Folder Setup';
    // DrillDownPageID = 8001420;
    //LookupPageID = 8001420;

    fields
    {
        field(1; "Table ID"; Integer)
        {
            Caption = 'Table ID';
            NotBlank = true;

            trigger OnLookup()
            begin
                SetFilters;
                if PAGE.RunModal(page::Objects, Object) = Action::LookupOK then
                    "Table ID" := Object."Object ID";
            end;

            trigger OnValidate()
            begin
                if not isTableInFilter("Table ID") then
                    Error(Text001);
            end;
        }
        field(2; "Folder path"; Text[250])
        {
            Caption = 'Emplacement dossier';

            trigger OnLookup()
            var
                //GL2024   lFieldSelection: Page 8001437;
                lVarID: Text[30];
                CurrentValue: Text[30];
                FolderTmp: Text[30];
                i: Integer;
                lExit: Boolean;
            begin
                TestField("Table ID");
                SetFilters;

                CurrentValue := '';
                i := StrPos("Folder path", '%');
                if i = 0 then
                    lVarID := Format("Table ID") + '.1'
                else begin
                    while (i < StrLen("Folder path")) and not lExit do begin
                        i += 1;
                        if ("Folder path"[i] in ['0' .. '9']) or
                           ("Folder path"[i] = '.') and (StrPos(lVarID, '.') = 0) then
                            lVarID := lVarID + CopyStr("Folder path", i, 1)
                        else
                            lExit := true;
                    end;
                    if StrPos(lVarID, '.') = 0 then
                        lVarID := Format("Table ID") + '.' + lVarID;
                end;
                /*
                  FolderTmp := COPYSTR("Folder path",i + 1);
                  i := STRPOS(FolderTmp,' ');
                  IF i > 0 THEN
                    CurrentValue := COPYSTR(FolderTmp,1,i-1)
                  ELSE
                    CurrentValue := COPYSTR(FolderTmp,1);
                  i := STRPOS(CurrentValue,'.');
                  IF i = 0 THEN
                    CurrentValue := FORMAT("Table ID") + '.' + CurrentValue;
                END ELSE
                  CurrentValue := FORMAT("Table ID") + '.1';
                */

                /*     //GL2024 Clear(lFieldSelection);
                  lFieldSelection.InitRequest(lVarID);
                  lFieldSelection.LookupMode(true);
                  lFieldSelection.SetTableview(Object);
                  if lFieldSelection.RunModal = Action::LookupOK then begin
                      "Folder path" := "Folder path" + '%' + lFieldSelection.GetResult;
                      Validate("Folder path");
                  end;*/

            end;

            trigger OnValidate()
            var
                i: Integer;
            begin
                if StrPos("Folder path", 'Path') > 0 then
                    "Folder path" := FolderCheck("Folder path");
            end;
        }
    }

    keys
    {
        key(STG_Key1; "Table ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Text001: label 'You have entered an illegal value.';
        //GL2024 License    "Object": Record "Object";
        //GL2024 License
        "Object": Record AllObj;
    //GL2024 License


    procedure FolderCheck(Folder: Text[250]): Text[250]
    var
        p: Integer;
        l: Integer;
        TempFolder: Text[250];
    begin
        if StrLen(Folder) = 0 then
            exit('');

        TempFolder := Folder;
        repeat
            p := StrPos(TempFolder, '\');
            if p > 0 then begin
                l += p;
                TempFolder := CopyStr(TempFolder, p + 1);
            end;
        until p = 0;
        exit(CopyStr(Folder, 1, l));
    end;


    procedure SetFilters()
    begin
        Object.SetRange("Object Type", Object."Object Type"::Table);
        Object.SetFilter("Object ID", '15|18|23|27|36|38|156|167|5050|5200|5714|5600|6505');
    end;


    procedure isTableInFilter(pTableNo: Integer): Boolean
    begin
        SetFilters;
        if Object.Find('-') then
            repeat
                if Object."Object ID" = pTableNo then
                    exit(true);
            until Object.Next = 0;
        exit(false);
    end;
}

