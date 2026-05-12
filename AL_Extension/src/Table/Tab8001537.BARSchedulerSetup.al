Table 8001537 "BAR : Scheduler Setup"
{
    //GL2024  ID dans Nav 2009 : "8001605"
    // #9030 XPE 28/07/2011
    // //+RAP+RAPPRO GESWAY 26/06/02 Table des paramètres de l'automate d'import des fichiers bancaires (multi-société)
    //                 28/10/02 Ajout fonctions FolderCheck et FilenameCheck
    //                 13/11/02 Longueur champs "Folder*","Filename*" à 250

    Caption = 'B.A.R. : Scheduler Setup';
    DataPerCompany = false;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Folder After Process"; Text[250])
        {
            Caption = 'Folder After Process';

            trigger OnValidate()
            begin
                //#9030
                //"Folder After Process" := FolderCheck("Folder After Process");
                //#9030//
            end;
        }
        field(3; "Filename After Process"; Text[250])
        {
            Caption = 'Filename After Process';
        }
        field(4; "Folder Before Process"; Text[250])
        {
            Caption = 'Folder Before Process';

            trigger OnValidate()
            begin
                //#9030
                //"Folder Before Process" := FolderCheck("Folder Before Process");
                //#9030//
            end;
        }
        field(5; "Filename Before Process"; Text[250])
        {
            Caption = 'Filename Before Process';

            trigger OnValidate()
            begin
                "Filename Before Process" := FilenameCheck("Filename Before Process");
            end;
        }
        field(6; "Folder After Process 2"; Text[250])
        {
            Caption = 'Folder After Process 2';
            Description = '#9030';
        }
        field(7; "Folder After Process 3"; Text[250])
        {
            Caption = 'Folder After Process 3';
            Description = '#9030';
        }
        field(8; "Folder After Process 4"; Text[250])
        {
            Caption = 'Folder After Process 4';
            Description = '#9030';
        }
        field(9; "Folder Before Process 2"; Text[250])
        {
            Caption = 'Folder Before Process 2';
            Description = '#9030';
        }
        field(10; "Folder Before Process 3"; Text[250])
        {
            Caption = 'Folder Before Process 3';
            Description = '#9030';
        }
        field(11; "Folder Before Process 4"; Text[250])
        {
            Caption = 'Folder Before Process 4';
            Description = '#9030';
        }
    }

    keys
    {
        key(STG_Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //#9030
        //TESTFIELD("Folder After Process");
        //TESTFIELD("Folder Before Process");
        fValidateFolder(0);
        fValidateFolder(1);
        //#9030//
        TestField("Filename Before Process");
        TestField("Filename After Process");
        //#9030
        //VALIDATE("Folder After Process");
        //VALIDATE("Folder Before Process");
        //#9030//
        Validate("Filename Before Process");
    end;

    trigger OnModify()
    begin
        //#9030
        //TESTFIELD("Folder After Process");
        //TESTFIELD("Folder Before Process");
        fValidateFolder(0);
        fValidateFolder(1);
        //#9030//
        TestField("Filename Before Process");
        TestField("Filename After Process");
        //#9030
        Validate("Folder After Process");
        Validate("Folder Before Process");
        //#9030//
        Validate("Filename Before Process");
    end;

    var
        Path: Text[100];
        Position: Text[30];
        i: Integer;
        Longueur: Integer;
        //GL2024 License  Fichier: Record File;
        Text10000: label 'Folder %1 is not valid.';
        Text10001: label 'Folder %1 doesn''t exist.';
        Text10002: label 'File %1 is not valid.';
        Text10003: label 'File %1 doesn''t exist.';
        tErrAfterProcess: label 'The folder for the after process is''nt set';
        tErrBoforeProcess: label 'The folder for the before process is''nt set';


    procedure FolderCheck(Folder: Text[1024]): Text[1024]
    var
        p: Integer;
        l: Integer;
        TempFolder: Text[250];
        lFileMgt: Codeunit "File Management2";
    begin
        if StrLen(Folder) = 0 then
            exit('');

        TempFolder := Folder;
        //#9030
        lFileMgt.fInitialise();
        if (lFileMgt.fIsFile(TempFolder)) then begin
            repeat
                p := StrPos(TempFolder, '\');
                if p > 0 then begin
                    l += p;
                    TempFolder := CopyStr(TempFolder, p + 1);
                end;
            until p = 0;
        end else begin
            l := StrLen(Folder);
        end;
        lFileMgt.fFinalize();
        Folder := CopyStr(Folder, 1, l);
        if (Folder[StrLen(Folder)] <> '\') then
            Folder := Folder + '\';
        //#9030//
        exit(Folder);
    end;


    procedure FilenameCheck(FileName: Text[250]): Text[30]
    var
        p: Integer;
    begin
        if StrLen(FileName) = 0 then
            exit('');

        repeat
            p := StrPos(FileName, '\');
            if p > 0 then
                FileName := CopyStr(FileName, p + 1);
        until p = 0;
        exit(FileName);
    end;


    procedure fGetFolder(pType: Option AfterProcess,BeforeProcess) Retour: Text[1024]
    begin
        //#9030
        Retour := '';
        case pType of
            Ptype::AfterProcess:
                begin
                    Retour += "Folder After Process";
                    Retour += "Folder After Process 2";
                    Retour += "Folder After Process 3";
                    Retour += "Folder After Process 4";
                end;
            Ptype::BeforeProcess:
                begin
                    Retour += "Folder Before Process";
                    Retour += "Folder Before Process 2";
                    Retour += "Folder Before Process 3";
                    Retour += "Folder Before Process 4";
                end;
        end;
        //#9030//
    end;


    procedure fSetFolder(pType: Option AfterProcess,BeforeProcess; pFolder: Text[1024])
    var
        lText: array[4] of Text[250];
        lIndex: Integer;
    begin
        //#9030
        pFolder := FolderCheck(pFolder);
        for lIndex := 1 to ArrayLen(lText) do begin
            lText[lIndex] := '';
        end;
        lIndex := 1;
        while (StrLen(pFolder) <> 0) and (lIndex <= ArrayLen(lText)) do begin
            lText[lIndex] := CopyStr(pFolder, 1, MaxStrLen(lText[lIndex]));
            pFolder := DelStr(pFolder, 1, MaxStrLen(lText[lIndex]));
            lIndex += 1;
        end;
        case pType of
            Ptype::AfterProcess:
                begin
                    "Folder After Process" := lText[1];
                    "Folder After Process 2" := lText[2];
                    "Folder After Process 3" := lText[3];
                    "Folder After Process 4" := lText[4];
                end;
            Ptype::BeforeProcess:
                begin
                    "Folder Before Process" := lText[1];
                    "Folder Before Process 2" := lText[2];
                    "Folder Before Process 3" := lText[3];
                    "Folder Before Process 4" := lText[4];
                end;
        end;
        //#9030//
    end;


    procedure fValidateFolder(pType: Option AfterProcess,BeforeProcess)
    var
        lFolder: Text[1024];
    begin
        //#9030
        lFolder := fGetFolder(pType);
        if (StrLen(lFolder) <> 0) then begin
            fSetFolder(pType, lFolder);
        end else begin
            case pType of
                Ptype::AfterProcess:
                    begin
                        Error(tErrAfterProcess);
                    end;
                Ptype::BeforeProcess:
                    begin
                        Error(tErrBoforeProcess);
                    end;
            end;
        end;
        //#9030//
    end;
}

