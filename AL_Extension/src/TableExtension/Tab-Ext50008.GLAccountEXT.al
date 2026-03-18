TableExtension 50008 "G/L AccountEXT" extends "G/L Account"
{
    fields
    {
        modify("No.")
        {
            trigger OnAfterValidate()
            var
                lNaviBat: Record NavibatSetup;
            begin
                //+REF+FR
                IF "No."[1] IN ['1' .. '5'] THEN
                    "Income/Balance" := "Income/Balance"::"Balance Sheet"
                ELSE
                    "Income/Balance" := "Income/Balance"::"Income Statement";
                //+REF+FR//

                //PROJET
                IF "Income/Balance" = "Income/Balance"::"Income Statement" THEN BEGIN
                    "Job Posting" := "Job Posting"::"Code Mandatory";
                    //#5045
                    //  "Post Job Entry" := TRUE;
                    IF "No." <> xRec."No." THEN BEGIN
                        lNaviBat.GET2;
                        "Post Job Entry" := lNaviBat."Post Job Entry";
                    END;
                    //#5045//
                END;
                //PROJET//
            end;
        }

        modify("No. 2")
        {

            Caption = 'No. 2';
            TableRelation = "Compte SysCoaDa";
            trigger OnAfterValidate()
            var
            begin
                // >> HJ DSFT 23-01-2012
                IF RecCompteSysCoaDa.GET("No. 2") THEN
                    "Designation Syscohada" := RecCompteSysCoaDa."Designation"
                ELSE
                    "Designation Syscohada" := '';
                // >> HJ DSFT 23-01-2012

            end;
        }

        modify("Gen. Prod. Posting Group")
        {
            Caption = 'Gen. Prod. Posting Group';
        }



        field(50000; "Designation Syscohada"; Text[50])
        {
            Description = 'bsk 24042012';
        }
        field(50001; "G/L Entry Type Filter1"; Option)
        {
            Caption = 'G/L Entry Type Filter';
            FieldClass = FlowFilter;
            OptionCaption = 'Definitive,Simulation';
            OptionMembers = Definitive,Simulation;
        }
        field(50100; "Compte ABK"; Boolean)
        {
            Description = 'BSK 27092012';
        }
        field(50101; Over; Code[20])
        {
        }
        field(50102; "Global Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Global Dimension 3 Code';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Default Dimension"."Dimension Value Code" where("Table ID" = const(15), "No." = field("No."), "Dimension Code" = const('EF')));
        }
        field(50103; "Global Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Global Dimension 4 Code';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Default Dimension"."Dimension Value Code" where("Table ID" = const(15), "No." = field("No."), "Dimension Code" = const('NATURES')));
        }
        field(73754; Replication; Boolean)
        {
            Caption = 'Replication';
            Editable = false;
        }
        field(8001408; "Sugg. for Sales Doc."; Boolean)
        {
            Caption = 'Sugg. for Sales Doc.';
        }
        field(8001409; "Sugg. for Purch. Doc."; Boolean)
        {
            Caption = 'Sugg. for Purch. Doc.';
        }
        field(8001600; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(8001601; "Reason Value Posting"; Option)
        {
            Caption = 'Reason Code Value Posting';
            OptionCaption = ' ,Code Mandatory,Same Code,No Code';
            OptionMembers = " ","Code Mandatory","Same Code","No Code";
        }
        field(8001900; "Subscription Period Control"; Option)
        {
            Caption = 'Control period subscription';
            OptionCaption = ' ,Obligatory period,No period';
            OptionMembers = " ","Obligatory period","No period";
        }
        field(8003923; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            Description = 'BAT';
            TableRelation = Job;
        }
        field(8003924; "Job Posting"; Option)
        {
            Caption = 'Job Posting';
            Description = 'BAT';
            OptionCaption = ' ,Code Mandatory,Same Code,No Code';
            OptionMembers = " ","Code Mandatory","Same Code","No Code";
        }
        field(8003925; "Post Job Entry"; Boolean)
        {
            Caption = 'Post job Entry';
            Description = 'BAT';

            trigger OnValidate()
            var
                lNaviBat: Record NavibatSetup;
            begin
                //#5045
                if ("Post Job Entry" <> xRec."Post Job Entry") and ("Post Job Entry" = false) and
                   ("Income/Balance" = "income/balance"::"Income Statement") then begin
                    lNaviBat.GET2;
                    if lNaviBat."Post Job Entry" then
                        TestField("Post Job Entry", lNaviBat."Post Job Entry");
                end;
                //#5045//
            end;
        }
    }
    keys
    {

        key(STG_Key12; "No. 2")
        {
        }
    }








    trigger OnAfterInsert()
    var
    begin
        //+REF+REPLIC
        wReplicationRef.GETTABLE(Rec);
        wReplicationTrigger.OnInsert(wReplicationRef);
        //+REF+REPLIC// 
    end;

    trigger OnafterModify()
    var
        lReplicationRef: RecordRef;
    begin
        //+REF+REPLIC
        wReplicationRef.GETTABLE(Rec);
        lReplicationRef.GETTABLE(xRec);
        wReplicationTrigger.OnModify(wReplicationRef, lReplicationRef);
        //+REF+REPLIC//
    end;

    trigger OnafterDelete()
    var
        lTranslationMgt: Codeunit "Translation Management";
        lRecordRef: RecordRef;
    begin
        //+REF+REPLIC
        wReplicationRef.GETTABLE(Rec);
        wReplicationTrigger.OnDelete(wReplicationRef);
        //+REF+REPLIC//
        //+REF+TRANSLATION
        lRecordRef.GETTABLE(Rec);
        lTranslationMgt.DeleteTranslations(lRecordRef.NUMBER, FIELDNO(Name), "No.");
        //+REF+TRANSLATION//
    end;

    trigger OnafterRename()
    var
        lReplicationRef: RecordRef;
        lTranslationMgt: Codeunit "Translation Management";
        lRecordRef: RecordRef;
    begin
        //+REF+REPLIC
        lReplicationRef.GETTABLE(xRec);
        wReplicationRef.GETTABLE(Rec);
        wReplicationTrigger.OnRename(lReplicationRef, wReplicationRef);
        //+REF+REPLIC//
        //+REF+TRANSLATION
        lRecordRef.GETTABLE(Rec);
        lTranslationMgt.RenameTranslations(lRecordRef.NUMBER, FIELDNO(Name), xRec."No.", "No.");
        //+REF+TRANSLATION
    end;



    procedure fTranslation() Return: Text[250]
    var
        lRecordRef: RecordRef;
        lTranslationMgt: Codeunit "Translation Management";
        lText: Text[250];
    begin
        //+REF+TRANSLATION
        lRecordRef.GetTable(Rec);
        lText := Name;
        lText := lTranslationMgt.Format(lRecordRef.Number, FieldNo(Name), "No.", '', lText);
        exit(CopyStr(lText, 1, MaxStrLen(Name)));
        //+REF+TRANSLATION//
    end;



    var
        TextFR: label 'The first number in %1 must be from 1 to 9.';
        wReplicationTrigger: Codeunit "Replication Trigger";
        wReplicationRef: RecordRef;
        //GL2024 TextError: Label;
        RecCompteSysCoaDa: Record 50020;
}

