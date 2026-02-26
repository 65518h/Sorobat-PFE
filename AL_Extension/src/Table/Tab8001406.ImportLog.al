Table 8001406 "Import Log"
{
    // #7809 ML 25/01/10
    // //+REF+IMPORT CW 21/07/03 Import

    Caption = 'Import Log';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Import Code"; Code[20])
        {
            Caption = 'File';
        }
        field(3; "Import Line No."; Integer)
        {
            //blankzero = true;
            Caption = 'Source Line No.';
        }
        field(4; "Start DateTime"; DateTime)
        {
            Caption = 'Date Time';
        }
        field(5; TableID; Integer)
        {
            //GL2024 License  TableRelation = Object.ID where(Type = const(Table));
            //GL2024 License
            TableRelation = AllObj."Object ID" where("Object Type" = const(Table));
            //GL2024 License
        }
        field(6; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(7; "Trigger"; Option)
        {
            OptionMembers = BeforeUpdate,PreImport,PostImport;
        }
        field(8; Level; Option)
        {
            Caption = 'Niveau';
            OptionCaption = 'Notification,Warning,Error,Severe';
            OptionMembers = Notification,Warning,Error,Severe;
        }
        field(10; Description; Text[250])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Import Code")
        {
        }
        key(Key3; "Start DateTime")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        lRec: Record "Import Log";
    begin
        if lRec.Find('+') then
            "Entry No." := lRec."Entry No." + 1
        else
            "Entry No." := 1;
        if Level = Level::Severe then
            if not Confirm(tSevereError + '\' + '%4\' + tContinue, false, "Import Code", "Import Line No.", Code, Description) then
                Error(tImportAborted);
    end;

    var
        Counter: Integer;
        tDeletePreviousLog: label 'Voulez-vous supprimer les messages précédents ?';
        tSevereError: label 'Severe error during %1 import, line %2 %3';
        tContinue: label 'Voulez-vous continuer ?';
        tImportAborted: label 'Importation annulée. Aucune ligne importée.';

    procedure AskQuestion(var pImport: Record Import)
    var
        lImportLog: Record "Import Log";
        lDelete: Boolean;
        lAsked: Boolean;
    begin
        lImportLog.SetCurrentkey("Import Code");
        while pImport.Next <> 0 do begin
            lImportLog.SetRange("Import Code", pImport.Code);
            if not lAsked then begin
                if Confirm(tDeletePreviousLog, true) then begin
                    lAsked := true;
                    lDelete := true;
                end else
                    lAsked := true;
            end;
            if lDelete then
                lImportLog.DeleteAll;
        end;
    end;


    procedure Initialize(pImportCode: Code[20]; pTableID: Integer)
    begin
        Init;
        "Import Code" := pImportCode;
        "Start DateTime" := CurrentDatetime;
        TableID := pTableID;
    end;


    procedure Add(pLine: Integer; pCode: Code[20]; pMessage: Text[250])
    begin
        "Import Line No." := pLine;
        Code := pCode;
        Description := pMessage;
        Insert(true);
        Counter += 1;
    end;


    procedure HowMany() Return: Integer
    begin
        Return := Counter;
    end;
}

