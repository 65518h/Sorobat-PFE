Codeunit 8001424 "Dataport Management"
{
    // //+REF+DATAPORT CW 11/04/06 Dataport management


    trigger OnRun()
    begin
    end;

    var
        gLineNo: Integer;
        tNotSameVersion: label 'Imported version %1 is not expected one %2.\Do you want to continue ?';
        tNotSameCompany: label 'This file has been exported from %1 company.\Do you want to continue?';
        tNotSameObjectID: label 'This file is not for this format (%1).';
        tIncorrectFieldCount: label 'Incorrect field count for %1 table at line %2.';
        tUnexpectedEOF: label 'Unexpected End Of File (line %1).';
        gFieldArray: array[1000] of Integer;
        gFieldCount: Integer;
        gTableID: Integer;


    procedure OpenFile(var pFile: Codeunit "File Management2"; pImport: Boolean; pObjectID: Integer)
    begin
        /*********************************************
        *                     OpenFile              *
        *********************************************
        * Entrée : Codeunit File Management         *
        *        : Mode de gestion (Import/ Export) *
        *        : Identifiant de l'objet           *
        * Sortir : Néant                            *
        *********************************************
        * Initialise le DataPort Management         *
        * Verifie :                                 *
        * - la version du fichier                   *
        * - Le nom de la société                    *
        * - L'identifiant de l'objet d'import       *
        *********************************************/
        //pFile.TEXTMODE(TRUE);
        if pImport then begin
            Check(pFile, GetVersion, tNotSameVersion, false);
            Check(pFile, COMPANYNAME, tNotSameCompany, false);
            Check(pFile, Format(pObjectID), tNotSameObjectID, true);
        end else begin
            /*
            pFile.WRITE(GetVersion);
            pFile.WRITE(COMPANYNAME);
            pFile.WRITE(pObjectID);
            */
            pFile.fWriteLine(GetVersion);
            pFile.fWriteLine(COMPANYNAME);
            pFile.fWriteLine(Format(pObjectID));
        end;

    end;

    local procedure Check(var pFile: Codeunit "File Management2"; pCheck: Text[30]; pMessage: Text[250]; pError: Boolean)
    var
        lText: Text[30];
    begin
        /*********************************************************************
        *                                  Check                            *
        *********************************************************************
        * Entrée : Codeunit File Management                                 *
        *        : Le texte à vérifier                                      *
        *        : Message                                                  *
        *        : Indique si le message est une erreur ou un avertissement *
        * Sortir : Néant                                                    *
        *********************************************************************
        * Verifie à partir du fichier d'import, si le texte est identique   *
        * sinon affiche le message dans où celui est une erreur             *
        * sinon affiche ce message en tant qu'avertissement                 *
        *********************************************************************/
        //pFile.READ(lText);
        lText := CopyStr(pFile.fReadLine(), 1, 30);
        gLineNo += 1;
        if lText <> pCheck then
            if pError then
                Error(pMessage, lText, pCheck)
            else
                if not Confirm(pMessage, false, lText, pCheck) then
                    Error('');

    end;

    local procedure GetVersion(): Text[30]
    var
        //GL2024 License   lObject: Record "Object";
        //GL2024 License
        lObject: Record AllObj;
    //GL2024 License
    begin
        /*********************************************
        *                   GetVersion              *
        *********************************************
        * Entrée : Néant                            *
        * Sortir : Texte                            *
        *********************************************
        * Renvoie la version list du produit        *
        * Version obtenue à partir de la table      *
        * "Version List"                            *
        *********************************************/
        lObject.Get(lObject."Object Type"::Table, '', Database::"Version List");
        //GL2024 License  exit(lObject."Version List");

    end;

    local procedure GetChar(var pFile: Codeunit "File Management2"; var c: Char)
    begin
        if (pFile.fGetPosition() = pFile.fGetSize()) then
            Error(tUnexpectedEOF, gLineNo);
        c := pFile.fReadChar();
    end;


    procedure ExportTableID(var pFile: Codeunit "File Management2"; pTableID: Integer)
    var
        lRecordRef: RecordRef;
        lWindow: Dialog;
        lCount: Integer;
        lProgress: Decimal;
    begin
        /***********************************************
        *                ExportTableID                *
        ***********************************************
        * Entrée : Codeunit File Management           *
        *        : Identifiant de la table à exporter *
        * Sortir : Néant                              *
        ***********************************************
        * Export l'integralite du contenu de la table *
        * Dont l(identifiant est passé en parametre   *
        ***********************************************/
        lRecordRef.Open(pTableID);
        if lRecordRef.Find('-') then begin
            lCount := lRecordRef.COUNTAPPROX;
            lWindow.Open('@1@@@@@@@@@@@@@@@@@@');
            repeat
                lProgress += 1;
                lWindow.Update(1, (lProgress * 10000) DIV lCount);
                ExportRecord(pFile, lRecordRef);
            until lRecordRef.Next = 0;
            lWindow.Close();
        end;

    end;


    procedure ExportTable(var pFile: Codeunit "File Management2"; var pRecordRef: RecordRef)
    var
        lWindow: Dialog;
        lCount: Integer;
        lProgress: Decimal;
    begin
        /***********************************************
        *                 ExportTable                 *
        ***********************************************
        * Entrée : Codeunit File Management           *
        *        : RecordRef de la table à exporter   *
        * Sortir : Néant                              *
        ***********************************************
        * Export l'integralite du contenu de la table *
        * Dont le recordref est passé en parametre    *
        ***********************************************/
        if pRecordRef.Find('-') then begin
            lCount := pRecordRef.COUNTAPPROX;
            lWindow.Open('@1@@@@@@@@@@@@@@@@@@');
            repeat
                lProgress += 1;
                lWindow.Update(1, (lProgress * 10000) DIV lCount);
                ExportRecord(pFile, pRecordRef);
            until pRecordRef.Next = 0;
            lWindow.Close();
        end;

    end;


    procedure ExportRecord(var pFile: Codeunit "File Management2"; var pRecordRef: RecordRef)
    var
        lFieldRef: FieldRef;
        ltcProgress: label 'Exporting Table Data\\File   #1#############################\Table  #2#############################\Records               Fields #4#######\\@5@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@';
        ltcFileName: label 'TableData-';
        ltcFileNameSuffix: label '.txt';
        ltcFileSaveDialogCaption: label 'Export Table Data to...';
        ltcExportCanceled: label 'Export Table Data was canceled.';
        ltcExportCompleted: label 'Exporting TableData for table %1 completed sucessfully.';
        ltcNoFieldSelected: label 'There are no fields selected to export.';
        ltcFieldCountDontMatch: label 'Field Counts does not match.\RecordRef.FIELDCOUNT: %1\rField.COUNT: %2';
        i: Integer;
        lCR: Char;
        lLF: Char;
    begin
        /**************************************************
        *                 ExportRecord                   *
        **************************************************
        * Entrée : Codeunit File Management              *
        *        : RecordRef                             *
        * Sortir : Néant                                 *
        **************************************************
        * Export la valeur des champs de l'enregistement *
        * en cour                                        *
        **************************************************/
        gLineNo += 1;
        lCR := 13;
        lLF := 10;

        //pFile.WRITE(pRecordRef.NUMBER);
        pFile.fWriteLine(Format(pRecordRef.Number));
        if gFieldCount = 0 then begin
            for i := 1 to pRecordRef.FieldCount do begin
                lFieldRef := pRecordRef.FieldIndex(i);
                //#5647
                if FieldRefOK(lFieldRef) then
                    //#5647//
                    WriteField(pFile, lFieldRef);
            end;
            pFile.fWrite(Format(lCR) + Format(lLF));
        end else begin
            for i := 1 to gFieldCount do begin
                lFieldRef := pRecordRef.Field(gFieldArray[i]);
                WriteField(pFile, lFieldRef);
            end;
            pFile.fWrite(Format(lCR) + Format(lLF));
        end;

    end;

    local procedure FieldRefOK(var pFieldRef: FieldRef): Boolean
    begin
        /***********************************************
        *                 FieldRefOK                  *
        ***********************************************
        * Entrée : FieldRefà verifier                 *
        * Sortir : Boolean                            *
        ***********************************************
        * Renvoie vrai si le champ referencer par le  *
        * fieldRef n'est pas de type binaire ou blob  *
        * qu'il est de classe normal et qu'il soit    *
        * actif                                       *
        ***********************************************/
        exit(
          not (Format(pFieldRef.Type) in ['Binary', 'BLOB']) and
          (Format(pFieldRef.CLASS) = 'Normal') and
          pFieldRef.Active);

    end;


    procedure WriteField(var pFile: Codeunit "File Management2"; var pFieldRef: FieldRef)
    var
        lTab: Text[1];
    begin
        /***********************************************
        *                WriteField                   *
        ***********************************************
        * Entrée : Codeunit File Management           *
        *        : FieldRef                           *
        * Sortir : Néant                              *
        ***********************************************
        * Ecrit dans le fichier le valeur du champ    *
        * référencé par le FieldRef                   *
        ***********************************************/
        lTab[1] := 9;
        if FieldRefOK(pFieldRef) then begin
            //pFile.SEEK(pFile.POS - 2);   // before newline
            //pFile.WRITE(lTab + (fFieldFormat(pFieldRef)));
            pFile.fWrite(lTab + (fFieldFormat(pFieldRef)));
        end;

    end;


    procedure ReadField(var pFile: Codeunit "File Management2"; var pRecordRef: RecordRef; pFieldNo: Integer; var c: Char) Retour: Boolean
    var
        lTab: Char;
        lCR: Char;
        lLF: Char;
        lFieldValue: Text[250];
        i: Integer;
        lFieldRef: FieldRef;
    begin
        /***********************************************
        *                    ReadField                *
        ***********************************************
        * Entrée : Codeunit File Management           *
        *        : RecordRef                          *
        *        : Identifiant du champ               *
        * Sortir : Néant                              *
        ***********************************************
        * renvoie vrai si la lecture dans le fichier  *
        * de la valeur du champ, dont l'identiant"    *
        * est passé en parametre, s'est correctement  *
        * effectué                                    *
        ***********************************************/
        lTab := 9;
        lCR := 13;
        lLF := 10;
        if pFieldNo = 0 then begin
            while ((pFile.fGetPosition() <= pFile.fGetSize()) and (c <> lCR) and (c <> lTab)) do begin
                GetChar(pFile, c);
            end;
        end else begin
            lFieldValue := '';
            i := 0;
            while ((pFile.fGetPosition() <= pFile.fGetSize()) and (c <> lCR) and (c <> lTab)) do begin
                i += 1;
                lFieldValue[i] := c;
                GetChar(pFile, c);
            end;
            if pRecordRef.FieldExist(pFieldNo) then begin
                lFieldRef := pRecordRef.Field(pFieldNo);
                FieldRefEvaluate(lFieldRef, lFieldValue);
            end;
        end;
        GetChar(pFile, c);

    end;


    procedure Import(var pFile: Codeunit "File Management2"; pDelete: Boolean)
    var
        lWindow: Dialog;
        lProgress: Decimal;
    begin
        /***********************************************
        *                    Import                   *
        ***********************************************
        * Entrée : Codeunit File Management           *
        *        : Delete record                      *
        * Sortir : Néant                              *
        ***********************************************
        * Import l'integralité du contenu du fichier. *
        * Le parametre "Delete" indique si            *
        * l'enregistrement existe alors il est ecrasé *
        ***********************************************/
        //pFile.TEXTMODE(FALSE);
        lWindow.Open('DataportMgt.Import @1@@@@@@@@@@@@@@@@@@');
        //WHILE pFile.POS < pFile.LEN DO BEGIN
        while (not pFile.fGetEOF()) do begin

            //lProgress := ROUND(pFile.POS / pFile.LEN * 100,1);
            lProgress := ROUND(pFile.fGetPosition() / pFile.fGetSize() * 100, 1);
            lWindow.Update(1, lProgress * 100);

            ImportRecord(pFile, pDelete);
        end;
        lWindow.Close();

    end;

    local procedure ImportRecord(var pFile: Codeunit "File Management2"; pDelete: Boolean)
    var
        lFieldRef: FieldRef;
        lFieldRef2: FieldRef;
        i: Integer;
        iField: Integer;
        lTab: Char;
        lCR: Char;
        lLF: Char;
        lFieldValue: Text[250];
        c: Char;
        lField: Record "Field";
        lRecordRef: RecordRef;
        lRecordRef2: RecordRef;
        lTableID: Integer;
    begin
        /***********************************************
        *                    ImportRecord             *
        ***********************************************
        * Entrée : Codeunit File Management           *
        *        : Delete record                      *
        * Sortir : Néant                              *
        ***********************************************
        * Import l'integralité du contenu du fichier. *
        * Le parametre "Delete" indique si            *
        * l'enregistrement existe alors il est ecrasé *
        ***********************************************/
        lTab := 9;
        lCR := 13;
        lLF := 10;
        gLineNo += 1;

        GetChar(pFile, c);
        while ((pFile.fGetPosition() <= pFile.fGetSize()) and (c <> lCR) and (c <> lTab)) do begin
            i += 1;
            lFieldValue[i] := c;
            GetChar(pFile, c);
        end;

        if (lFieldValue = '') then begin
            GetChar(pFile, c);
            exit;
        end;

        Evaluate(lTableID, lFieldValue);
        if lTableID > 0 then begin
            lRecordRef.Open(lTableID);
            if lTableID <> gTableID then
                gFieldCount := 0;
        end;
        GetChar(pFile, c);

        if lTableID < 0 then begin
            gTableID := Abs(lTableID);
            gFieldCount := 0;
            lRecordRef.Open(gTableID);
            repeat
                lFieldValue := '';
                i := 0;
                while ((pFile.fGetPosition() <= pFile.fGetSize()) and (c <> lCR) and (c <> lTab)) do begin
                    i += 1;
                    lFieldValue[i] := c;
                    GetChar(pFile, c);
                end;
                gFieldCount += 1;
                Evaluate(gFieldArray[gFieldCount], lFieldValue);
                if lRecordRef.FieldExist(gFieldArray[gFieldCount]) then begin
                    lFieldRef := lRecordRef.Field(gFieldArray[gFieldCount]);
                    if not FieldRefOK(lFieldRef) then
                        gFieldArray[gFieldCount] := 0;
                end;
                GetChar(pFile, c);
            until ((pFile.fGetPosition() >= pFile.fGetSize()) or (c = lLF));
        end else
            if lTableID = 0 then begin
                repeat
                    GetChar(pFile, c);
                until ((pFile.fGetPosition() >= pFile.fGetSize()) or (c = lLF));
            end else
                if gFieldCount = 0 then begin
                    //pFile.fReadFile();
                    for iField := 1 to lRecordRef.FieldCount do begin
                        //#5647
                        //    ReadField(pFile,lRecordRef,iField,c);
                        lFieldRef := lRecordRef.FieldIndex(iField);
                        if FieldRefOK(lFieldRef) then begin
                            ReadField(pFile, lRecordRef, lFieldRef.Number, c);
                        end;
                        //#5647//
                    end;
                end else begin
                    //pFile.fReadFile();
                    for iField := 1 to gFieldCount do begin
                        ReadField(pFile, lRecordRef, gFieldArray[iField], c);
                    end;
                end;

        if (c <> lLF) then
            Error(tIncorrectFieldCount, lRecordRef.Caption, gLineNo);

        if lTableID > 0 then begin
            lRecordRef2 := lRecordRef.Duplicate;
            if not lRecordRef2.Find then
                lRecordRef.Insert()
            else
                if pDelete then begin
                    lRecordRef2.Delete();
                    lRecordRef.Insert();
                end else
                    if gFieldCount = 0 then begin
                        for iField := 1 to lRecordRef.FieldCount do begin
                            if gFieldArray[iField] <> 0 then begin
                                lFieldRef := lRecordRef.FieldIndex(iField);
                                lFieldRef2 := lRecordRef2.FieldIndex(iField);
                                if Format(lFieldRef.CLASS) = 'Normal' then
                                    lFieldRef2.Value := lFieldRef.Value;
                            end;
                        end;
                        lRecordRef2.Modify();
                    end else begin
                        for iField := 1 to gFieldCount do begin
                            if gFieldArray[iField] <> 0 then begin
                                if lRecordRef.FieldExist(gFieldArray[iField]) then begin
                                    lFieldRef := lRecordRef.Field(gFieldArray[iField]);
                                    lFieldRef2 := lRecordRef2.Field(gFieldArray[iField]);
                                    if Format(lFieldRef.CLASS) = 'Normal' then
                                        lFieldRef2.Value := lFieldRef.Value;
                                end;
                            end;
                        end;
                        lRecordRef2.Modify();
                    end;
        end;

    end;


    procedure FieldRefEvaluate(var pFieldRef: FieldRef; pValue: Text[250]): Text[250]
    var
        lField: Record "Field";
        lInteger: Integer;
        lText: Text[250];
        lCode: Code[80];
        lDecimal: Decimal;
        lOption: Option;
        lBoolean: Boolean;
        lDate: Date;
        lTime: Time;
        lDateTime: DateTime;
        lDateFormula: DateFormula;
    begin
        /***********************************************
        *              FieldRefEvaluate               *
        ***********************************************
        * Entrée : FieldRef                           *
        *        : Valeur                             *
        * Sortir : Valeur du FieldRef                 *
        ***********************************************
        * En fonction du type du champ referencé par  *
        * le parametre FieldRef, Evalue si la valeur  *
        * passé egalement en parametre est correcte   *
        ***********************************************/
        Evaluate(lField.Type, Format(pFieldRef.Type));

        case lField.Type of
            lField.Type::Integer:
                if Evaluate(lInteger, pValue) then begin
                    pFieldRef.Value := lInteger;
                    exit(Format(lInteger));
                end;
            lField.Type::Text:
                if Evaluate(lText, pValue) then begin
                    pFieldRef.Value := lText;
                    exit(Format(lText));
                end;
            lField.Type::Code:
                if Evaluate(lCode, pValue) then begin
                    pFieldRef.Value := lCode;
                    exit(Format(lCode));
                end;
            lField.Type::Decimal:
                begin
                    //#6580
                    pValue := fCastToDecimal(pValue, 0);
                    if not Evaluate(lDecimal, pValue) then begin
                        pValue := fCastToDecimal(pValue, 1);
                    end;
                    if not Evaluate(lDecimal, pValue) then begin
                        pValue := fCastToDecimal(pValue, 2);
                    end;
                    //#6580//
                    if Evaluate(lDecimal, pValue) then begin
                        pFieldRef.Value := lDecimal;
                        exit(Format(lDecimal));
                    end;
                end;
            lField.Type::Option:
                if Evaluate(lOption, pValue) then begin
                    pFieldRef.Value := lOption;
                    exit(Format(lOption));
                end;
            lField.Type::Boolean:
                if Evaluate(lBoolean, pValue) then begin
                    pFieldRef.Value := lBoolean;
                    exit(Format(lBoolean));
                end;
            lField.Type::Date:
                if Evaluate(lDate, pValue) then begin
                    pFieldRef.Value := lDate;
                    exit(Format(lDate));
                end;
            lField.Type::Time:
                if Evaluate(lTime, pValue) then begin
                    pFieldRef.Value := lTime;
                    exit(Format(lTime));
                end;
            lField.Type::DateTime:
                if Evaluate(lDateTime, pValue) then begin
                    pFieldRef.Value := lDateTime;
                    exit(Format(lDateTime));
                end;
            lField.Type::DateFormula:
                if Evaluate(lDateFormula, pValue) then begin
                    pFieldRef.Value := lDateFormula;
                    exit(Format(lDateFormula));
                end;
        end;

    end;


    procedure ExportFields(var pFile: Codeunit "File Management2"; pTableID: Integer; pFieldFilter: Text[80]; pMode: Option FieldNo,FieldName,FieldCaption)
    var
        lTab: Text[1];
        lRecordRef: RecordRef;
        lKeyRef: KeyRef;
        lFieldRef: FieldRef;
        i: Integer;
        j: Integer;
        lField: Record "Field";
        lCR: Char;
        lLF: Char;
    begin
        /****************************************************
        *                  ExportField                     *
        ****************************************************
        * Entrée : Codeunit File Management                *
        *        : Identifiant de la table                 *
        *        : FieldFilter                             *
        *        : Mode (FieldNo, fieldName, FieldCaption) *
        * Sortir : Néant                                   *
        ****************************************************
        * Exporte dans le fichier les elements des champs  *
        * de la table dont l'id est passé en paramétre     *
        * Les elements exportés  concernent :              *
        * - Numero du champ                                *
        * - Nom du champ                                   *
        * - Libelle du champ                               *
        ****************************************************/
        lTab[1] := 9;
        lCR := 13;
        lLF := 10;
        gLineNo += 1;
        lRecordRef.Open(pTableID);
        if pMode = 0 then
            pFile.fWrite(Format(-lRecordRef.Number))
        //pFile.WRITE(- lRecordRef.NUMBER)
        else
            pFile.fWrite('0');
        //pFile.WRITE(0);

        if pMode = Pmode::FieldNo then
            gFieldCount := 0;

        if pFieldFilter <> '' then begin
            lKeyRef := lRecordRef.KeyIndex(1);
            for j := 1 to lKeyRef.FieldCount do begin
                lFieldRef := lKeyRef.FieldIndex(j);
                if FieldRefOK(lFieldRef) then begin
                    //pFile.SEEK(pFile.POS - 2);   // before newline
                    case pMode of
                        Pmode::FieldNo:
                            begin
                                //pFile.WRITE(lTab + FORMAT(lFieldRef.NUMBER));
                                pFile.fWrite(lTab + Format(lFieldRef.Number));
                                gFieldCount += 1;
                                gFieldArray[gFieldCount] := lFieldRef.Number;
                            end;
                        Pmode::FieldName:
                            //pFile.WRITE(lTab + FORMAT(lFieldRef.NAME));
                            pFile.fWrite(lTab + Format(lFieldRef.Name));
                        Pmode::FieldCaption:
                            //pFile.WRITE(lTab + FORMAT(lFieldRef.CAPTION));
                            pFile.fWrite(lTab + Format(lFieldRef.Caption));
                    end;
                end;
            end;
        end;

        lField.SetRange(TableNo, pTableID);
        lField.SetRange(Class, lField.Class::Normal);
        lField.SetRange(Enabled, true);
        if pFieldFilter <> '' then
            lField.SetFilter("No.", pFieldFilter);
        if lField.FindSet then begin
            repeat
                lFieldRef := lRecordRef.Field(lField."No.");
                if FieldRefOK(lFieldRef) then begin
                    //pFile.SEEK(pFile.POS - 2);   // before newline
                    case pMode of
                        Pmode::FieldNo:
                            begin
                                //pFile.WRITE(lTab + FORMAT(lField."No."));
                                pFile.fWrite(lTab + Format(lField."No."));
                                gFieldCount += 1;
                                gFieldArray[gFieldCount] := lField."No.";
                            end;
                        Pmode::FieldName:
                            //pFile.WRITE(lTab + lField.FieldName);
                            pFile.fWrite(lTab + lField.FieldName);
                        Pmode::FieldCaption:
                            //pFile.WRITE(lTab + lField."Field Caption");
                            pFile.fWrite(lTab + lField."Field Caption");
                    end;
                end;
            until lField.Next = 0;
        end;
        pFile.fWrite(Format(lCR) + Format(lLF));

    end;


    procedure GetRecordRef(var pRecordRef: RecordRef; pTableID: Integer; pPrimarykey: Text[250]): Boolean
    var
        lKeyRef: KeyRef;
        lFieldRef: FieldRef;
        i: Integer;
    begin
        /***********************************************
        *                   GetRecordRef              *
        ***********************************************
        * Entrée : RecordReF                          *
        *        : Identifiant de la table            *
        *        : Clef primaire de la table          *
        * Sortir : Boolean                            *
        ***********************************************
        * Evalue l'ensemble des champ du recordref    *
        * de la table dont l'id est pass" en parametre*
        * avec la clef primaire                       *
        * renvoie si'il existe un enregistrement      *
        ***********************************************/
        pRecordRef.Open(pTableID);
        lKeyRef := pRecordRef.KeyIndex(1);
        for i := 1 to lKeyRef.FieldCount do begin
            lFieldRef := lKeyRef.FieldIndex(i);
            FieldRefEvaluate(lFieldRef, SelectStr(i, pPrimarykey));
        end;
        exit(pRecordRef.Find);

    end;


    procedure fCastToDecimal(pStrValue: Text[250]; pTypeProcess: Integer) Return: Text[250]
    var
        lIndex: Integer;
        lSpace255: Char;
    begin
        /***********************************************
        *                    fCastToDecimal           *
        ***********************************************
        * Entrée : Valeur Texte                       *
        *        : Type de traitement                 *
        * Sortir : Texte                              *
        ***********************************************
        * Renvoie le texte                            *
        ***********************************************/
        //#6580
        //0 --> Suppression des espaces
        //1 --> Substitution des , par .
        //2 --> Substitution des . par ,
        Return := '';
        for lIndex := 1 to StrLen(pStrValue) do begin
            case pTypeProcess of
                0:
                    begin
                        lSpace255 := 255;
                        if not (pStrValue[lIndex] in [' ', lSpace255]) then begin
                            Return := Return + Format(pStrValue[lIndex]);
                        end;
                    end;
                1:
                    begin
                        if (pStrValue[lIndex] = ',') then begin
                            Return := Return + '.';
                        end else begin
                            Return := Return + Format(pStrValue[lIndex]);
                        end;
                    end;
                2:
                    begin
                        if (pStrValue[lIndex] = '.') then begin
                            Return := Return + ',';
                        end else begin
                            Return := Return + Format(pStrValue[lIndex]);
                        end;
                    end;
            end;
        end;
        exit(Return);
        //#6580//

    end;


    procedure fFieldFormat(pFieldref: FieldRef) return: Text[512]
    var
        lBasic: Codeunit Basic;
        lrecordID: RecordID;
    begin
        /***********************************************
        *                    fFieldFormat             *
        ***********************************************
        * Entrée : Codeunit File Management           *
        *        : Delete record                      *
        * Sortir : Néant                              *
        ***********************************************
        * Import l'integralité du contenu du fichier. *
        * Le parametre "Delete" indique si            *
        * l'enregistrement existe alors il est ecrasé *
        ***********************************************/
        case Format(pFieldref.Type) of
            'RecordID':
                begin
                    Evaluate(lrecordID, Format(pFieldref.Value));
                    return := lBasic.FormatRecordID(lrecordID);
                end;
            else
                return := Format(pFieldref.Value);
        end;

    end;
}

