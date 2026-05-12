Codeunit 8001407 Basic
{
    // #8689 XPE 15/06/2001 Remise ne l'etat du fonction lié à la fiche 6901
    // #7407 XPE 15/12/2010
    // #6901 XPE 19/01/09 Creation de la fonction fGetLanguageCode
    // #6901 XPE 19/01/09 Modification de la fonction SubstituteValue
    // #6253 AC 08/07/08
    // //+BGW+BASIC CW 04/09/03 Remplace une variable par un champ d'un RecordRef


    trigger OnRun()
    var
        lRec: Record "Company Information";
        lRecordRef: RecordRef;
        lText: Text[250];
        lID: Text[30];
    begin
        // Only for testing
        lRec.Get;
        lRecordRef.GetTable(lRec);
        lText := 'Company %79.2-PhoneNo %79.7';
        Message('SubstituteValues:%1',
          SubstituteValues(lText, lRecordRef, '%79.', GlobalLanguage));
        Message('SubstituteCaptions:%1',
          SubstituteCaptions('Company %79.2 -PhoneNo %79.7', 0, GlobalLanguage));
        Message('SubstituteCaptions79:%1',
          SubstituteCaptions('Company %2 -PhoneNo %7', Database::"Company Information", GlobalLanguage));
        /*
        MESSAGE('%1, CaseSensitive=%2',StrReplace('Replace this by that in This sentence','this','that',FALSE,FALSE),FALSE);
        MESSAGE('%1, CaseSensitive=%2',StrReplace('Replace this by that in This sentence','this','that',TRUE,FALSE),TRUE);
        MESSAGE('%1, FullWord=%2',StrReplace('Replace this by that at this place','place','position',FALSE,FALSE),FALSE);
        MESSAGE('%1, FullWord=%2',StrReplace('Replace this by that at This place','place','position',FALSE,TRUE),TRUE);
        MESSAGE('%1',lText);
        //MESSAGE('%1',StrReplace('Replace %0 by Facture at This place','%0','Facture',FALSE,TRUE),TRUE);
        lText := '2:%2, 18.1:%18.1 (27.3:%27.3:10)';
        MESSAGE('%1=>\%2',lText,SubstituteCaptions(lText,18));
        */

    end;

    var
        tSyntaxError: label 'Syntax error in "%1" at %2 position';
        RoundingPrecision: Decimal;


    procedure SubstituteValues(var pText: Text[250]; pRecordRef: RecordRef; pID: Text[30]; pLanguage: Integer): Text[250]
    var
        lField: Record "Field";
        lRecordRef: RecordRef;
        lFieldRef: FieldRef;
        lFieldNo: Integer;
        lFieldWidth: Integer;
        lFieldValue: Text[250];
        lPos: Integer;
        lFrom: Integer;
        lIdLen: Integer;
        lLanguage: Record Language;
        lMaxLen: Integer;
        lTemp: Text[250];
        lLanguageCode: Code[10];
        lTranslationMgt: Codeunit "Translation Management";
    begin
        lPos := StrPos(pText, pID);
        lIdLen := StrLen(pID);
        lMaxLen := MaxStrLen(pText);

        //#6760 (6670)
        //WHILE (lPos <> 0) AND (lPos + lFrom < MAXSTRLEN(pText)) DO BEGIN
        while (lPos <> 0) and (lPos + lFrom < lMaxLen) do begin
            //#6760// (6670//)
            lPos += lFrom;
            lFrom := lPos;
            //#6316
            /*
              IF NOT ((lPos + lIdLen) > lMaxLen) THEN BEGIN
                lFrom := lMaxLen;
                EXIT(pText);
              END;
            */
            //#6316//
            if not (pText[lPos + lIdLen] in ['0' .. '9']) then
                lFrom += lIdLen
            else begin
                pText := DelStr(pText, lPos, lIdLen);
                lFieldNo := lExtractInteger(pText, lPos);
                if pText[lPos] = ':' then begin
                    pText := DelStr(pText, lPos, 1);
                    lFieldWidth := lExtractInteger(pText, lPos);
                end else
                    lFieldWidth := 0;
                if lField.Get(pRecordRef.Number, lFieldNo) then begin
                    lFieldRef := pRecordRef.Field(lFieldNo);
                    Evaluate(lField.Class, Format(lFieldRef.CLASS));
                    if lField.Class = lField.Class::FlowField then
                        lFieldRef.CalcField;
                    //#8689
                    //{REF
                    //#8689//
                    //#6901
                    lLanguageCode := fGetLanguageCode(pLanguage);
                    lFieldValue := lFormatField(lFieldRef, lFieldWidth);
                    if pRecordRef.FieldExist(1) then begin
                        lTranslationMgt.Format(pRecordRef.Number, lFieldNo, Format(pRecordRef.Field(1)), lLanguageCode, lFieldValue)
                        //#6901//
                    end else
                        lFieldValue := lFormatField(lFieldRef, lFieldWidth);
                    //#8689
                    //REF}
                    //#8689//
                    //#6900//
                    //#8689
                    //lFieldValue := lFormatField(lFieldRef,lFieldWidth);
                    //#8689//
                    pText := CopyStr(CopyStr(pText, 1, lPos - 1) + lFieldValue + CopyStr(pText, lPos), 1, MaxStrLen(pText));
                    lFrom += StrLen(lFieldValue) - 1;
                end;
            end;
            lPos := StrPos(CopyStr(pText, lFrom + 1), pID);
        end;
        exit(pText);

    end;


    procedure SubstituteCaptions(pText: Text[250]; pTableID: Integer; pLanguage: Integer): Text[250]
    var

        //GL2024 License "lObject": Record "Object";
        //GL2024 License
        "lObject": Record AllObj;
        //GL2024 License

        lField: Record "Field";
        lRecordRef: RecordRef;
        lFieldRef: FieldRef;
        lPos: Integer;
        lFieldNo: Integer;
        lTableCaption: Text[30];
        lRight: Text[250];
        lLanguage: Record Language;
    begin
        lPos := StrPos(pText, '%');
        while lPos > 0 do begin
            lRecordRef.Close;
            lTableCaption := '';
            pText := DelStr(pText, lPos, 1);
            lFieldNo := lExtractInteger(pText, lPos);
            if pText[lPos] = '.' then begin
                if lPos = StrLen(pText) then
                    lRecordRef.Open(pTableID)
                else
                    if not (pText[lPos + 1] in ['0' .. '9']) then
                        lRecordRef.Open(pTableID)
                    else
                        if not lObject.Get(lObject."Object Type"::Table, '', lFieldNo) then
                            exit(CopyStr(pText, 1, lPos) + '??') //ERROR(tSyntaxError,pText,lPos)
                        else begin
                            pText := DelStr(pText, lPos, 1);
                            pTableID := lFieldNo;
                            lRecordRef.Open(lFieldNo);
                            lFieldNo := lExtractInteger(pText, lPos);
                            lTableCaption := '"' + lRecordRef.Caption + '".';
                        end;
            end else
                if (pTableID <> 0) and (lObject.Get(lObject."Object Type"::Table, '', pTableID)) then
                    lRecordRef.Open(pTableID)
                else
                    exit(CopyStr(pText, 1, lPos) + '??'); //ERROR(tSyntaxError,pText,lPos);
            if (lFieldNo = 0) and (pTableID <> 0) then
                lFieldNo := 1;
            if not lField.Get(pTableID, lFieldNo) then
                exit(CopyStr(pText, 1, lPos) + '??'); //ERROR(tSyntaxError,pText,lPos);
            lFieldRef := lRecordRef.Field(lFieldNo);
            lRight := CopyStr(pText, lPos);
            pText := CopyStr(CopyStr(pText, 1, lPos - 1) + lTableCaption + '"' + lFieldRef.Caption + '"', 1, MaxStrLen(pText));
            lPos := StrPos(lRight, '%'); // Avoid '%' in TableCaption or FieldCaption
            if lPos <> 0 then
                lPos += StrLen(pText);
            pText := CopyStr(pText + lRight, 1, MaxStrLen(pText));
        end;
        exit(pText);
    end;

    local procedure lExtractInteger(var pText: Text[250]; pPos: Integer) Return: Integer
    var
        lText: Text[30];
    begin
        while (pPos <= StrLen(pText)) and (pText[pPos] in ['0' .. '9']) do begin
            lText := lText + CopyStr(pText, pPos, 1);
            pText := DelStr(pText, pPos, 1);
        end;
        if lText = '' then
            lText := '0';
        Evaluate(Return, lText);
    end;

    local procedure lFormatField(pFieldRef: FieldRef; pWidth: Integer) Return: Text[250]
    var
        lFieldRec: Record "Field";
        lInteger: Integer;
        lDecimal: Decimal;
    begin
        Evaluate(lFieldRec.Type, Format(pFieldRef.Type));
        Return := Format(pFieldRef.Value);
        if lFieldRec.Type = lFieldRec.Type::Option then begin
            Evaluate(lInteger, Return);
            Return := SelectStr(lInteger + 1, pFieldRef.OptionCaption);
        end;
        if (RoundingPrecision <> 0) and (lFieldRec.Type = lFieldRec.Type::Decimal) then begin
            Evaluate(lDecimal, Return);
            lDecimal := ROUND(lDecimal, RoundingPrecision);
            Return := Format(lDecimal);
        end;
        if pWidth <> 0 then
            Return := PadStr(Return, pWidth);
    end;


    procedure StrReplace(pText: Text[250]; pFrom: Text[250]; pTo: Text[250]; pCaseSensitive: Boolean; pFullWord: Boolean) Return: Text[250]
    var
        lPos: Integer;
        i: Integer;
    begin
        Return := pText;
        lPos := 1;
        repeat
            if (lPos > 1) and pFullWord then
                while (lPos < StrLen(Return)) and not (Return[lPos] in [' ', '.', ';', ',', '(', ')']) do
                    lPos += 1;
            if pCaseSensitive then
                i := StrPos(CopyStr(Return, lPos), pFrom)
            else
                i := StrPos(UpperCase(CopyStr(Return, lPos)), UpperCase(pFrom));
            lPos += i - 1;
            if i <> 0 then begin
                if not pFullWord or lCheckFullWord(Return, lPos, StrLen(pFrom)) then begin
                    Return := CopyStr(Return, 1, lPos - 1) + pTo + CopyStr(Return, lPos + StrLen(pFrom));
                    lPos += StrLen(pTo);
                end;
            end;
        until (i = 0) or (lPos > StrLen(Return));
    end;

    local procedure lCheckFullWord(pText: Text[250]; pPos: Integer; pLen: Integer): Boolean
    begin
        if pPos > 1 then
            if not (pText[pPos - 1] in [' ', '.', ';', ',', '(', ')']) then
                exit(false);
        if StrLen(pText) = pPos + pLen - 1 then
            exit(true);
        exit(pText[pPos + pLen] in [' ', '.', ';', ',', '(', ')']);
    end;


    procedure SetRoundingPrecision(pRoundingPrecision: Decimal)
    begin
        RoundingPrecision := pRoundingPrecision;
    end;


    procedure CheckDataBaseLicense(pTableID: Integer): Boolean
    var
        lLicensePermission: Record "License Permission";
    begin
        lLicensePermission.SetRange("Object Type", lLicensePermission."object type"::TableData);
        lLicensePermission.SetRange("Object Number", pTableID);
        lLicensePermission.SetFilter("Insert Permission", '<>%1', lLicensePermission."insert permission"::" ");
        exit(not lLicensePermission.IsEmpty);
    end;


    procedure AddRecordRef(var pRecordRef1: RecordRef; var pRecordRef2: RecordRef; pFactor: Decimal)
    var
        i: Integer;
        lFieldRef1: FieldRef;
        lFieldRef2: FieldRef;
        lField: Record "Field";
        lValue1: Decimal;
        lValue2: Decimal;
    begin
        for i := 1 to pRecordRef1.FieldCount do begin
            lFieldRef1 := pRecordRef1.FieldIndex(i);
            lFieldRef2 := pRecordRef2.FieldIndex(i);
            Evaluate(lField.Type, Format(lFieldRef1.Type));
            if lField.Type = lField.Type::Decimal then begin
                lValue1 := lFieldRef1.Value;
                lValue2 := lFieldRef2.Value;
                lValue1 += lValue2 * pFactor;
                lFieldRef1.Value := lValue1;
            end;
        end;
    end;


    procedure fGetLanguageCode(pLanguageID: Integer) Retour: Code[10]
    var
        lLanguage: Record Language;
        lDefaultLangue: Record Language;
    begin
        //#6901
        Retour := '';
        lLanguage.SetRange("Windows Language ID", pLanguageID);
        if (not lLanguage.IsEmpty()) then begin
            lLanguage.Find('-');
            // il faut savoir si on doit rechercher la langue par defaut
            lLanguage.CalcFields(lLanguage."Windows Language Name");
            if (lLanguage."Windows Language Name" <> '') then begin
                lDefaultLangue.SetRange(Name, lLanguage."Windows Language Name");
                if (not lDefaultLangue.IsEmpty()) then begin
                    lDefaultLangue.Find('-');
                    Retour := lDefaultLangue.Code;
                end else begin
                    Retour := lLanguage.Code;
                end;
            end else begin
                Retour := lLanguage.Code;
            end;
        end;
        //#6901//
    end;


    procedure FormatRecordID(pRecordID: RecordID) return: Text[500]
    var
        lRecRef: RecordRef;
        lBasic: Codeunit Basic;
        lKeyRef: KeyRef;
        lIndex: Integer;
        lFiedRef: FieldRef;
        lOption: Integer;
        lPos: Integer;
        tOption: label 'Option';
    begin
        return := Format(pRecordID);
        lRecRef := pRecordID.GetRecord;
        return := StrReplaceOneOnly(return, lRecRef.Name, Format(lRecRef.Number));
        lKeyRef := lRecRef.KeyIndex(1);
        for lIndex := 1 to lKeyRef.FieldCount do begin
            lFiedRef := lKeyRef.FieldIndex(lIndex);
            if Format(lFiedRef.Type) = tOption then begin
                Evaluate(lOption, Format(lFiedRef.Value));
                return := StrReplaceOneOnly(return, SelectStr(lOption + 1, Format(lFiedRef.OptionCaption)),
                                            Format(lFiedRef.Value));
            end;
        end;
    end;


    procedure StrReplaceOneOnly(pString: Text[500]; pFromString: Text[250]; pToString: Text[250]) Return: Text[500]
    var
        lPos: Integer;
    begin
        lPos := StrPos(pString, pFromString);
        Return := DelStr(pString, lPos, StrLen(pFromString));
        Return := InsStr(Return, pToString, lPos);
    end;


    procedure fIndexOfOption(pOptionCaptions: Text[1024]; pOption: Text[255]) return: Integer
    var
        lPosition: Integer;
        lSubString: Text[1024];
    begin
        //#7407
        /***************************************************
        *                 fIndexOfOption                  *
        ***************************************************
        * Entrée : Liste des options possibles            *
        *        : option a rechercher                    *
        * Sortie : Index de l'option dans la liste        *
        ***************************************************
        * retourne l'index de l'option passé en parametre *
        * à partir de liste des options possibles         *
        * Si l'option n'existe pas, retourne -1           *
        ***************************************************/
        return := -1;
        lPosition := StrPos(pOptionCaptions, pOption);
        if (lPosition <> 0) then begin
            return := 0;
            lSubString := CopyStr(pOptionCaptions, 1, lPosition - 1);
            // On compte le ","
            while (StrPos(lSubString, ',') <> 0) do begin
                return += 1;
                lSubString := CopyStr(lSubString, StrPos(lSubString, ',') + 1);
            end;
        end;
        //#7407//

    end;
}

