Codeunit 8001423 "Translation Management"
{
    // #8698 SD 13/01/11
    // #6901 XPE 19/01/09  Modification de la fonction FORMAT
    // #6901 XPE 19/01/09 Modification de la fonction FORMAT2
    // //+REF+TRANSLATION CW 11/10/05 Translation management
    // 
    // Use a text editor to add this code at the place above.
    // Use suggested IDs (@80014xx) to avoid conflicts when merging.
    // 
    // Sample : "Payment terms" (Table 3, Form 4)
    // 
    // ========================================================================================
    // 1) Table : Modify theese triggers
    // ========================================================================================
    // 
    //     ........................................................................................
    //     OnDelete=VAR
    //                lTranslationMgt@8001400 : Codeunit 8001423;
    //                lRecordRef@8001401 : RecordRef;
    //              BEGIN
    //                ---TRANSLATION
    //                lRecordRef.GETTABLE(Rec);
    //                lTranslationMgt.DeleteTranslations(lRecordRef.NUMBER,0,Code);
    //                ---TRANSLATION---
    //              END;
    // 
    //     OnRename=VAR
    //                lTranslationMgt@8001400 : Codeunit 8001423;
    //                lRecordRef@8001401 : RecordRef;
    //                xRecordRef@8001402 : RecordRef;
    //              BEGIN
    //                ---TRANSLATION
    //                lRecordRef.GETTABLE(Rec);
    //                xRecordRef.GETTABLE(xRec);
    //                lTranslationMgt.RenameTranslations(lRecordRef.NUMBER,0,xRec.Code,Code);
    //                ---TRANSLATION---
    //              END;
    //     ........................................................................................
    // 
    //   Documentation :
    //     ........................................................................................
    //       //+REF+TRANSLATION CW 11/10/05 OnDelete, OnRename
    //     ........................................................................................
    // 
    // ========================================================================================
    // 2) Form List : Add theese triggers to Description/Name TextBox  :
    //     OnFormat=VAR
    //                lTranslationMgt@8001400 : Codeunit 8001423;
    //                lRecordRef@8001401 : RecordRef;
    //              BEGIN
    //                ---+REF+TRANSLATION
    //                lRecordRef.GETTABLE(Rec);
    //                lTranslationMgt.Format(lRecordRef.NUMBER,FIELDNO(Description),Code,'',Text);
    //                ---+REF+TRANSLATION---
    //              END;
    // 
    //     OnAssistEdit=VAR
    //                    lTranslationMgt@8001400 : Codeunit 8001423;
    //                    lRecordRef@8001401 : RecordRef;
    //                  BEGIN
    //                    ---+REF+TRANSLATION
    //                    lRecordRef.GETTABLE(Rec);
    //                    lTranslationMgt.AssistEdit(lRecordRef.NUMBER,FIELDNO(Description),Code);
    //                    ---+REF+TRANSLATION---
    //                  END;
    // 
    //     OnAfterValidate=VAR
    //                       lTranslationMgt@8001400 : Codeunit 8001423;
    //                       lRecordRef@8001401 : RecordRef;
    //                     BEGIN
    //                       ---+REF+TRANSLATION
    //                       lRecordRef.GETTABLE(Rec);
    //                       lTranslationMgt.AfterValidate(lRecordRef.NUMBER,FIELDNO(Description),Code,xRec.Description,Description);
    //                       ---+REF+TRANSLATION---
    //                     END;
    // ========================================================================================
    //     ........................................................................................
    // 
    //   Documentation :
    //     ........................................................................................
    //       //+REF+TRANSLATION CW 11/10/05 +Description Translation Triggers
    //     ........................................................................................


    trigger OnRun()
    begin
    end;

    var
        Translation: Record Translation2;
        Language: Record Language;


    procedure Format(pTableNo: Integer; pFieldNo: Integer; pCode: Code[20]; pLanguageCode: Code[10]; var pText: Text[250]): Text[250]
    var
        lRecordRef: RecordRef;
        lFieldRef: FieldRef;
        lTableNoRelation: Integer;
    begin
        //#6901
        // Il serait interessant, de savoir, si le champ possede une relation.
        // dans ce cas, il faut obtenir la traduction par la table de relation
        lRecordRef.Open(pTableNo);
        lFieldRef := lRecordRef.Field(pFieldNo);
        lTableNoRelation := lFieldRef.Relation;
        lRecordRef.Close;
        if (lTableNoRelation > 0) then begin
            exit(Format2(lTableNoRelation, -1, pCode, 0, pLanguageCode, pText));
        end else begin
            exit(Format2(pTableNo, pFieldNo, pCode, 0, pLanguageCode, pText));
        end;
        //#6901//
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
        lNewTranslation: Record Translation2;
    begin
        RenameTranslations2(pTableID, pFieldNo, pOldCode, 0, pNewCode, 0);
    end;


    procedure Format2(pTableNo: Integer; pFieldNo: Integer; pCode: Code[20]; pLineNo: Integer; pLanguageCode: Code[10]; var pText: Text[250]): Text[250]
    begin
        /* GL2024 Procedure standard dans nav2009 n'existe dans bc24
          if pLanguageCode = '' then
     pLanguageCode := Language.GetUserLanguage;*/

        //#6901
        Translation.SetRange(Translation.TableID, pTableNo);
        Translation.SetRange(Translation."Language Code", pLanguageCode);
        Translation.SetRange(Translation."Line No.", pLineNo);
        if (pFieldNo <> -1) then begin
            Translation.SetRange(Translation.Code, pCode);
            Translation.SetRange(Translation.FieldID, pFieldNo);
        end else begin
            Translation.SetRange(Translation.Code, pText);
        end;

        if (not Translation.IsEmpty) then begin
            Translation.Find('-');
            //IF Translation.GET(pTableNo,pFieldNo,pCode,pLanguageCode,pLineNo) THEN
            //#6901//
            pText := Translation.Description;
        end;
        exit(pText);
    end;


    procedure AfterValidate2(pTableNo: Integer; pFieldID: Integer; pCode: Code[20]; pLineNo: Integer; xText: Text[250]; var pText: Text[250])
    var
        lLanguageCode: Code[10];
        lCompanyInfo: Record "Company Information";
    begin
        // GL2024 Procedure standard dans nav2009 n'existe dans bc24   lLanguageCode := Language.GetUserLanguage;
        /*
        //+REF+ "Default Languge Code" doesn't exists in BGW
        IF lCompanyInfo.GET AND (lCompanyInfo."Default Language Code" IN ['',lLanguageCode]) THEN
          EXIT;
        //+REF+//
        */
        if not Translation.Get(pTableNo, pFieldID, pCode, lLanguageCode, pLineNo) then begin
            Translation.TableID := pTableNo;
            Translation.FieldID := pFieldID;
            Translation.Code := pCode;
            Translation."Line No." := pLineNo;
            Translation."Language Code" := lLanguageCode;
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
        //#8698
        Translation.Reset;
        //#8698//
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
        lNewTranslation: Record Translation2;
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
            if lNewTranslation.Insert(true) then;
        until Translation.Next = 0;
        Translation.DeleteAll(true);
    end;
}

