Codeunit 8001425 "Translation Mgt PerCompanyNo"
{
    // //+REF+TRANSLATION CW 11/10/05 Translation management


    trigger OnRun()
    begin
    end;

    var
        Translation: Record "Translation PerCompanyNo";
        Language: Record Language;


    procedure Format(pTableNo: Integer; pFieldNo: Integer; pCode: Code[20]; pLanguageCode: Code[10]; var pText: Text[50]): Text[250]
    begin
        exit(Format2(pTableNo, pFieldNo, pCode, 0, pLanguageCode, pText));
    end;


    procedure AfterValidate(pTableNo: Integer; pFieldID: Integer; pCode: Code[20]; xText: Text[250]; var pText: Text[250])
    var
        lLanguageCode: Code[10];
        lCompanyInfo: Record "Company Information";
    begin
        AfterValidate2(pTableNo, pFieldID, pCode, 0, xText, pText);
    end;


    procedure AssistEdit(pTableNo: Integer; pFieldID: Integer; pCode: Code[20])
    begin
        AssistEdit2(pTableNo, pFieldID, pCode, 0);
    end;


    procedure DeleteTranslations(pTableNo: Integer; pFieldNo: Integer; pCode: Code[20])
    begin
        DeleteTranslations2(pTableNo, pFieldNo, pCode, 0);
    end;


    procedure RenameTranslations(pTableID: Integer; pFieldNo: Integer; pOldCode: Code[20]; pNewCode: Code[20])
    var
        lNewTranslation: Record "Translation PerCompanyNo";
    begin
        RenameTranslations2(pTableID, pFieldNo, pOldCode, 0, pNewCode, 0);
    end;


    procedure Format2(pTableNo: Integer; pFieldNo: Integer; pCode: Code[20]; pLineNo: Integer; pLanguageCode: Code[10]; var pText: Text[50]): Text[250]
    begin
        /* GL2024 Procedure standard dans nav2009 n'existe dans bc24   if pLanguageCode = '' then
          pLanguageCode := Language.GetUserLanguage;*/
        if Translation.Get(pTableNo, pFieldNo, pCode, pLineNo, pLanguageCode) then
            pText := Translation.Description;
        exit(pText);
    end;


    procedure AfterValidate2(pTableNo: Integer; pFieldID: Integer; pCode: Code[20]; pLineNo: Integer; xText: Text[250]; var pText: Text[250])
    var
        lLanguageCode: Code[10];
        lCompanyInfo: Record "Company Information";
    begin
        //GL2024 Procedure standard dans nav2009 n'existe dans bc24    lLanguageCode := Language.GetUserLanguage;
        if not Translation.Get(pTableNo, pFieldID, pCode, pLineNo, lLanguageCode) then begin
            if lCompanyInfo.Get and (lCompanyInfo."Default Language Code" in ['', lLanguageCode]) then
                exit;
            Translation.TableID := pTableNo;
            Translation.FieldID := pFieldID;
            Translation.Code := pCode;
            Translation."Line No." := pLineNo;
            Translation.Language := lLanguageCode;
            Translation.Description := pText;
            Translation.Insert(true);
        end else
            if pText = '' then
                Translation.Delete(true)
            else begin
                Translation.Description := pText;
                Translation.Modify(true);
            end;
        pText := xText; // Restore
    end;


    procedure AssistEdit2(pTableNo: Integer; pFieldID: Integer; pCode: Code[20]; pLineNo: Integer)
    begin
        Translation.FilterGroup(10);
        Translation.SetRange(TableID, pTableNo);
        Translation.SetRange(FieldID, pFieldID);
        Translation.FilterGroup(0);
        Translation.SetRange(Code, pCode);
        Translation.SetRange("Line No.", pLineNo);
        Page.RunModal(0, Translation);
    end;


    procedure DeleteTranslations2(pTableNo: Integer; pFieldNo: Integer; pCode: Code[20]; pLineNo: Integer)
    begin
        Translation.SetRange(TableID, pTableNo);
        if pFieldNo <> 0 then
            Translation.SetRange(FieldID, pFieldNo);
        Translation.SetRange(Code, pCode);
        Translation.SetRange("Line No.", pLineNo);
        Translation.DeleteAll;
    end;


    procedure RenameTranslations2(pTableID: Integer; pFieldNo: Integer; pOldCode: Code[20]; pOldLineNo: Integer; pNewCode: Code[20]; pNewLineNo: Integer)
    var
        lNewTranslation: Record "Translation PerCompanyNo";
    begin
        Translation.SetRange(TableID, pTableID);
        if pFieldNo <> 0 then
            Translation.SetRange(FieldID, pFieldNo);
        Translation.SetRange(Code, pOldCode);
        Translation.SetRange("Line No.", pOldLineNo);
        repeat
            lNewTranslation := Translation;
            lNewTranslation.Code := pNewCode;
            lNewTranslation."Line No." := pNewLineNo;
            lNewTranslation.Insert(true);
        until Translation.Next = 0;
        Translation.DeleteAll(true);
    end;
}

