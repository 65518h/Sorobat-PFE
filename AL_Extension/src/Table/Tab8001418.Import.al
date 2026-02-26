table 8001418 Import
{
    // //+REF+IMPORT CW 21/07/03 Import

    DataCaptionFields = "Code", Description;
    // DrillDownPageID = 8001436;
    //LookupPageID = 8001436;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(4; "File Name"; Text[250])
        {
            Caption = 'FileName';
        }
        field(5; "File Format"; Option)
        {
            Caption = 'File Format';
            OptionCaption = 'Excel,Tab,Comma,SemiColon,Fixed';
            OptionMembers = Excel,Tab,Comma,SemiColon,"Fixed";
        }
        field(6; "Table ID"; Integer)
        {
            Caption = 'Table ID';
            //GL2024 License   TableRelation = Object.ID WHERE(Type = CONST(Table));
            //GL2024 License
            TableRelation = AllObj."Object ID" where("Object Type" = const(Table));
            //GL2024 License
            trigger OnLookup()
            var
                //GL2024 License  lObject: Record Object;
                //GL2024 License
                lObject: Record AllObj;
            //GL2024 License
            begin
                lObject.SETRANGE("Object Type", lObject."Object Type"::Table);
                IF PAGE.RunModal(page::Objects, lObject) = ACTION::LookupOK THEN BEGIN
                    "Table ID" := lObject."Object id";
                    ValidateTableID;
                END;
            end;

            trigger OnValidate()
            begin
                ValidateTableID;
            end;
        }
        field(7; "Import Group"; Code[10])
        {
            Caption = 'Groupe d''import';
            TableRelation = Code.Code WHERE("Table No" = CONST(8001418),
                                             "Field No" = CONST(7));
        }
        field(8; Mode; Option)
        {
            Caption = 'Mode';
            OptionCaption = 'Insert & Update,Insert,Update,Delete & Replace';
            OptionMembers = "Insert & Update",Insert,Update,"Delete & Replace";
        }
        field(9; "ASCII/ANSI"; Option)
        {
            Caption = 'ASCII/ANSI';
            OptionCaption = 'ASCII,ANSI';
            OptionMembers = ASCII,ANSI;
        }
        field(10; "Title Line No."; Integer)
        {
            //blankzero = true;
            Caption = 'Tilte Line';
        }
        field(11; "Field Delimiter"; Option)
        {
            Caption = 'Field Delimiter';
            OptionCaption = 'Aucun,",''';
            OptionMembers = "None","","''";
        }
        field(12; "Codeunit ID"; Integer)
        {
            //blankzero = true;
            Caption = 'N° codeunit';
            //GL2024 License  TableRelation = Object.ID WHERE(Type = CONST(Codeunit));
            //GL2024 License
            TableRelation = AllObj."Object ID" where("Object Type" = const(Codeunit));
            //GL2024 License
            trigger OnLookup()
            var
                //GL2024 License  lObject: Record Object;
                //GL2024 License
                lObject: Record AllObj;
            //GL2024 License
            begin
                lObject.SETRANGE("Object Type", lObject."Object Type"::Codeunit);
                IF PAGE.RunModal(page::Objects, lObject) = ACTION::LookupOK THEN
                    "Codeunit ID" := lObject."Object id";
                CALCFIELDS("Codeunit Caption")
            end;

            trigger OnValidate()
            begin
                CALCFIELDS("Codeunit Caption")
            end;
        }
        field(13; "Date Format"; Option)
        {
            Caption = 'Date Format';
            OptionCaption = 'European,American,Reverse';
            OptionMembers = European,American,Reverse;
        }
        field(14; "Trigger"; Option)
        {
            Caption = 'Déclencheur';
            OptionCaption = 'Aucun,OnInsert,OnModify,Les deux';
            OptionMembers = "None",OnInsert,OnModify,Both;
        }
        field(15; Protected; Boolean)
        {
            Caption = 'Protected';

            trigger OnValidate()
            begin
                MODIFY;
            end;
        }
        field(16; "Alias File Name"; Code[20])
        {
            Caption = 'Alias File Name';
            TableRelation = Import;
        }
        field(107; "Table Caption"; Text[250])
        {
            CalcFormula = Lookup(AllObjWithCaption."Object Caption" WHERE("Object Type" = CONST(Table),
                                                                           "Object ID" = FIELD("Table ID")));
            Caption = 'Table Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(108; "Codeunit Caption"; Text[30])
        {
            CalcFormula = Lookup(AllObjWithCaption."Object Caption" WHERE("Object Type" = CONST(Codeunit),
                                                                           "Object ID" = FIELD("Codeunit ID")));
            Caption = 'Table Caption';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        lImportLine: Record "Import Column";
        lCorres: Record "Import Correspondence";
    begin
        lImportLine.SETCURRENTKEY("Import Code");
        lImportLine.SETRANGE("Import Code", Code);
        lImportLine.DELETEALL(TRUE);

        lCorres.SETCURRENTKEY("Import Code");
        lCorres.SETRANGE("Import Code", Code);
        lCorres.DELETEALL(TRUE);
    end;

    trigger OnModify()
    begin
        TESTFIELD(Protected, FALSE);
    end;

    var
        tConfirmDeleteLines: Label 'Do you want to delete all lines ?';
        lNoImport: Label 'No import define for table %1, Template %2, Bacth %3.';
        lNotUniqueImport: Label 'No import define for table %1, Template %2, Bacth %3.';
        tConfirmImport: Label 'Do you want to import file %1?';


    procedure ValidateTableID()
    var
        lLine: Record "Import Column";
    begin
        IF (xRec."Table ID" <> 0) AND ("Table ID" <> xRec."Table ID") THEN BEGIN
            lLine.SETRANGE("Import Code", Code);
            IF lLine.FIND('-') THEN
                IF CONFIRM(tConfirmDeleteLines, FALSE) THEN
                    lLine.DELETEALL;
        END;
        CALCFIELDS("Table Caption");
    end;


    procedure ImportJournal(pTableNo: Integer; pTemplateID: Integer; pTemplateName: Code[10]; pBatchID: Integer; pBatchName: Code[10])
    var
        lImport: Record Import;
        lTemplateName: Record "Import Column";
        lBatchName: Record "Import Column";
    begin
        lTemplateName.SETRANGE(TableNo, pTableNo);
        lTemplateName.SETRANGE(FieldNo, pTemplateID);
        lTemplateName.SETRANGE(Constant, pTemplateName);
        lBatchName.SETRANGE(TableNo, pTableNo);
        lBatchName.SETRANGE(FieldNo, pBatchID);
        lBatchName.SETRANGE(Constant, pBatchName);
        IF lTemplateName.FIND('-') THEN BEGIN
            REPEAT
                lBatchName.SETRANGE("Import Code", lTemplateName."Import Code");
            UNTIL (lTemplateName.NEXT = 0) OR lBatchName.FIND('-');
            CASE lBatchName.COUNT OF
                0:
                    ERROR(lNoImport, pTableNo, pTemplateName, pBatchName);
                1:
                    BEGIN
                        lImport.GET(lBatchName."Import Code");
                        lImport.TESTFIELD("File Name");
                        lImport.SETRANGE(Code, lBatchName."Import Code");
                        //DYS REPORT ADDON NON MIGRER
                        // IF CONFIRM(tConfirmImport, FALSE, lImport."File Name") THEN
                        //     REPORT.RUN(REPORT::Import, FALSE, TRUE, lImport);
                    END;
                ELSE
                    ERROR(lNotUniqueImport, pTableNo, pTemplateName, pBatchName);
            END;
        END;
    end;
}

