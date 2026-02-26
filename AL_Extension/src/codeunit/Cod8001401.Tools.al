Codeunit 8001401 Tools
{
    // #8864 OF 20/04/11
    // #RTC - 2009 -- VERSION 6.01 XPE 02/04/2010
    // #5322 AC 04/12/07
    // //+BGW+ GESWAY 01/01/00 Convertisseur Ansi -> Ascii
    //         MB     05/04/06 Ajout fonctions ControlBarCod qui vérifie la validité d'un code barre EAN8, EAN13 et ITF14
    //                                         CalculateKey qui calcule la clef d'un code barre EAN8, EAN13 et ITF14
    //                                         EAN13ToITF14 qui convertit un EAN13 en ITF14
    //                                         ITF14ToEAN13 qui convertit un ITF14 en EAN13
    //         CW     23/08/06 +LeftPadStr(String,Length,PadChar)


    trigger OnRun()
    var
        Slimslam: Text[30];
        Slimslam2: Text[54];
    begin
    end;

    var
        AsciiStr: Text[250];
        AnsiStr: Text[250];
        CharVar: array[32] of Char;
        wDecInit: Boolean;
        wDecimalSeparator: Char;


    procedure Ansi2Ascii(_Text: Text[250]): Text[250]
    begin
        MakeVars;
        exit(ConvertStr(_Text, AnsiStr, AsciiStr));
    end;


    procedure Ascii2Ansi(_Text: Text[250]): Text[250]
    begin
        MakeVars;
        exit(ConvertStr(_Text, AsciiStr, AnsiStr));
    end;


    procedure MakeVars()
    begin
        AsciiStr := 'ÇüéâäàåçêëèïîìÄÅÉæÆôöòûùÿÖÜø£Ø×ƒáíóúñÑªº¿®¬½¼¡«»¦¦¦¦¦ÁÂÀ©¦¦++¢¥++--+-+ãÃ++--¦-+';
        AsciiStr := AsciiStr + '¤ðÐÊËÈiÍÎÏ++¦_¦Ì¯ÓßÔÒõÕµþÞÚÛÙýÝ¯´­±=¾¶§÷¸°¨·¹³²¦ ';
        CharVar[1] := 196;
        CharVar[2] := 197;
        CharVar[3] := 201;
        CharVar[4] := 242;
        CharVar[5] := 220;
        CharVar[6] := 186;
        CharVar[7] := 191;
        CharVar[8] := 188;
        CharVar[9] := 187;
        CharVar[10] := 193;
        CharVar[11] := 194;
        CharVar[12] := 192;
        CharVar[13] := 195;
        CharVar[14] := 202;
        CharVar[15] := 203;
        CharVar[16] := 200;
        CharVar[17] := 205;
        CharVar[18] := 206;
        CharVar[19] := 204;
        CharVar[20] := 175;
        CharVar[21] := 223;
        CharVar[22] := 213;
        CharVar[23] := 254;
        CharVar[24] := 218;
        CharVar[25] := 219;
        CharVar[26] := 217;
        CharVar[27] := 180;
        CharVar[28] := 177;
        CharVar[29] := 176;
        CharVar[30] := 185;
        CharVar[31] := 179;
        CharVar[32] := 178;
        AnsiStr := 'Ã³ÚÔõÓÕþÛÙÞ´¯ý' + Format(CharVar[1]) + Format(CharVar[2]) + Format(CharVar[3]) + 'µã¶÷' + Format(CharVar[4]);
        AnsiStr := AnsiStr + '¹¨ Í' + Format(CharVar[5]) + '°úÏÎâßÝ¾·±Ð¬' + Format(CharVar[6]) + Format(CharVar[7]);
        AnsiStr := AnsiStr + '«¼¢' + Format(CharVar[8]) + 'í½' + Format(CharVar[9]) + '___ªª' + Format(CharVar[10]) + Format(CharVar[11]);
        AnsiStr := AnsiStr + Format(CharVar[12]) + '®ªª++óÑ++--+-+Ò' + Format(CharVar[13]) + '++--ª-+ñ­ð';
        AnsiStr := AnsiStr + Format(CharVar[14]) + Format(CharVar[15]) + Format(CharVar[16]) + 'i' + Format(CharVar[17]) + Format(CharVar[18]);
        AnsiStr := AnsiStr + '¤++__ª' + Format(CharVar[19]) + Format(CharVar[20]) + 'Ë' + Format(CharVar[21]) + 'ÈÊ§';
        AnsiStr := AnsiStr + Format(CharVar[22]) + 'Á' + Format(CharVar[23]) + 'Ì' + Format(CharVar[24]) + Format(CharVar[25]);
        AnsiStr := AnsiStr + Format(CharVar[26]) + '²¦»' + Format(CharVar[27]) + '¡' + Format(CharVar[28]) + '=¥Âº¸©' + Format(CharVar[29]
        );
        AnsiStr := AnsiStr + '¿À' + Format(CharVar[30]) + Format(CharVar[31]) + Format(CharVar[32]) + '_ ';
    end;


    procedure ControlBarCod(pBarCod: Text[30]; var pMessage: Text[30]; pLenBarCod: Integer) Return: Boolean
    var
        tIncomplet: label 'Incomplet Code';
        tErrorCode: label 'Barcod Error';
    begin
        //pLenBarCod doit être égale à 13 pour un code EAN13, à 8 pour un code EAN8 ou à 14 pour un code ITF14

        pMessage := '';

        if pBarCod = '' then begin
        end
        else
            if (StrLen(pBarCod) <> pLenBarCod) or ((pLenBarCod <> 8) and (pLenBarCod <> 13) and (pLenBarCod <> 14)) then
                pMessage := tIncomplet
            else begin
                if ((pLenBarCod = 8) and (CalculateKey(pBarCod) <> pBarCod[8])) or
                   ((pLenBarCod = 13) and (CalculateKey(pBarCod) <> pBarCod[13])) or
                   ((pLenBarCod = 14) and (CalculateKey(pBarCod) <> pBarCod[14])) then
                    pMessage := tErrorCode;
            end;

        Return := (pMessage = '');
    end;


    procedure EAN13ToITF14(pBarCod: Text[13]; pFirstNbr: Integer) Return: Text[14]
    begin
        if StrLen(pBarCod) = 13 then
            Return := Format(pFirstNbr) + CopyStr(pBarCod, 1, 12) + Format(CalculateKey(Format(pFirstNbr) + pBarCod))
        else
            Return := '';
    end;


    procedure CalculateKey(pBarCod: Text[30]) pKey: Integer
    begin
        //Renvoi 99 si la longueur du code barre est différent de 8,13 ou 14

        case StrLen(pBarCod) of
            8:
                pKey := StrCheckSum(CopyStr(pBarCod, 1, 7), '1313131', 10);
            13:
                pKey := StrCheckSum(CopyStr(pBarCod, 1, 12), '131313131313', 10);
            14:
                pKey := StrCheckSum(CopyStr(pBarCod, 1, 13), '3131313131313', 10);
            else
                pKey := 99;
        end;
    end;


    procedure ITF14ToEAN13(pBarCod: Text[14]) Return: Text[13]
    begin
        if StrLen(pBarCod) = 14 then
            Return := CopyStr(pBarCod, 2, 12) + Format(CalculateKey(CopyStr(pBarCod, 2, 13)))
        else
            Return := '';
    end;


    procedure LeftPadStr(pString: Text[30]; pLength: Integer; pPadChar: Text[1]): Text[30]
    begin
        if StrLen(pString) > pLength then
            exit(CopyStr(pString, StrLen(pString) - pLength + 1));
        if pPadChar = '' then
            pPadChar := '';
        while StrLen(pString) < pLength do
            pString := InsStr(pString, pPadChar, 1);
        exit(pString);
    end;


    procedure GetDecimalSeparator(): Char
    var
        lGLSetup: Record "General Ledger Setup";
    begin
        //#5322
        if wDecInit then
            exit(wDecimalSeparator);
        wDecInit := true;
        lGLSetup.Get;
        if StrPos(Format(lGLSetup."Amount Rounding Precision"), ',') <> 0 then
            wDecimalSeparator := ','
        else
            wDecimalSeparator := '.';
        exit(wDecimalSeparator);
        //#5322//
    end;


    procedure VarToDec(pVar: Variant) Return: Decimal
    var
        lSpaceChar: Char;
    begin
        //#5322
        GetDecimalSeparator;
        case wDecimalSeparator of
            '.':
                if not Evaluate(Return, ConvertStr(DelChr(Format(pVar), '=', ' '), ',', '.')) then
                    Return := 0;
            ',':
                if not Evaluate(Return, ConvertStr(DelChr(Format(pVar), '=', ' '), '.', ',')) then
                    Return := 0;
        end;
        exit(Return);
        //#5322//
    end;


    procedure fGetEnvironPath(pEnvironVariable: Text[255]) retour: Text[1024]
    var
    //GL2024 Automation non compatible   lWshShell: Automation WshShell;
    begin
        //RTC - 2009 -- VERSION 6.01
        if (pEnvironVariable[1] <> '%') then
            pEnvironVariable := '%' + pEnvironVariable;
        if (pEnvironVariable[StrLen(pEnvironVariable)] <> '%') then
            pEnvironVariable := pEnvironVariable + '%';
        //GL2024 Automation non compatible   Create(lWshShell, true, ISSERVICETIER);
        //GL2024 Automation non compatible  retour := Format(lWshShell.ExpandEnvironmentStrings(pEnvironVariable));
        //GL2024 Automation non compatible Clear(lWshShell);
        //RTC - 2009 -- VERSION 6.01//
    end;


    procedure fRunCommandLine(pCommandLine: Text[1024]; pRunModal: Boolean)
    var
        //GL2024 Automation non compatible  lWshShell: Automation WshShell;
        lDummyInt: Integer;
    begin
        //RTC - 2009 -- VERSION 6.01
        lDummyInt := 1;
        //GL2024 Automation non compatible   Create(lWshShell, true, ISSERVICETIER);
        //GL2024 Automation non compatible    lWshShell.Run(pCommandLine, lDummyInt, pRunModal);
        //GL2024 Automation non compatible Clear(lWshShell);
        //RTC - 2009 -- VERSION 6.01//
    end;


    procedure fTextWithoutThousandSeparator(pText: Text[30]) lReturn: Text[30]
    var
        lTextSource: Text[1];
        lTextTarget: Text[1];
        lChar: Char;
        lLenght: Integer;
    begin
        /********************************************
        *     fTextWithoutThousandSeparator        *
        ********************************************
        * Entrée : Text (with thousand separator)  *
        * Sortie : Text (without blank for         *
        *           thousand separator             *
        ********************************************
        * Remplace le separateur de millier par    *
        * un blanc, utile pour les Imports et Exp. *
        ********************************************/
        //#8864\\
        lReturn := pText;
        lChar := 255;//'ÿ'
        lTextSource := Format(lChar);

        lTextTarget := '';
        lLenght := StrPos(pText, lTextSource);
        if (lLenght <> 0) then
            lReturn := DelStr(pText, lLenght, 1);

        lChar := 160;//Espace
        lTextSource := Format(lChar);
        lLenght := StrPos(pText, lTextSource);
        if (lLenght <> 0) then
            lReturn := DelStr(pText, lLenght, 1);

        exit(lReturn);

    end;


    procedure fInputBox(pPrompt: Text[250]; pTitle: Text[250]; pDefaultValue: Text[250]) retour: Text[250]
    var
    //GL2024 Automation non compatible lScriptControl: Automation ScriptControl;
    begin
        //#8974
        retour := '';
        //GL2024 Automation non compatible  Create(lScriptControl);
        //GL2024 Automation non compatible   lScriptControl.Language := 'vbscript';
        //GL2024 Automation non compatible   lScriptControl.AddCode('function getInput() getInput = inputbox("' + pPrompt + '","' + pTitle + '","' +
        //GL2024 Automation non compatible                         pDefaultValue + '") end function');
        //GL2024 Automation non compatible  Evaluate(retour, Format(lScriptControl.Eval('getInput')));
        //#8974//
    end;


    procedure fGetTextFromBlob(var pFieldRef: FieldRef) retour: Text[1024]
    var
        lBigText: BigText;
        tErrFieldType: label 'The Datatype of Field : %1 is not an Blob';
        lInStream: InStream;
        //GL2024    lTempBlob: Record 99008535 temporary;
        lRecRef: RecordRef;
        lFieldRef: FieldRef;
    begin
        retour := '';
        if (Format(pFieldRef.Type) = 'BLOB') then begin
            pFieldRef.CalcField();
            /*    lTempBlob.DeleteAll();
                lTempBlob.Init();
                lTempBlob."Primay Key" := 1;
                lRecRef.GetTable(lTempBlob);*/
            lFieldRef := lRecRef.Field(2);
            lFieldRef.Value := pFieldRef.Value;
            lFieldRef.CalcField();
            lRecRef.Insert(false);
            //GL2024    lTempBlob.Get(1);
            //GL2024   lTempBlob.CalcFields(lTempBlob.Blob);
            /*  //GL2024     if (lTempBlob.Blob.Hasvalue) then begin
                     lTempBlob.Blob.CreateInstream(lInStream);
                     lBigText.Read(lInStream);
                     lBigText.GetSubText(retour, 1, MaxStrLen(retour));
                 end;*/
        end else begin
            Error(StrSubstNo(tErrFieldType, pFieldRef.Caption));
        end;
    end;


    procedure fSetTextToBlob(var pFieldRef: FieldRef; pLongText: Text[1024])
    var
        OStream: OutStream;
        lBigText: BigText;
        //GL2024    lTempBlob: Record 99008535 temporary;
        tErrFieldType: label 'The Datatype of Field : %1 is not an Blob';
        lRecRef: RecordRef;
        lFieldRef: FieldRef;
    begin
        if (Format(pFieldRef.Type) = 'BLOB') then begin
            lBigText.AddText(pLongText);
            /* //GL2024     lTempBlob.Init();
                lTempBlob."Primay Key" := 1;
                lTempBlob.CalcFields(lTempBlob.Blob);
                lTempBlob.Blob.CreateOutstream(OStream);
                lBigText.Write(OStream);
                lTempBlob.Insert(false);
                lRecRef.GetTable(lTempBlob);*/
            lFieldRef := lRecRef.Field(2);
            lFieldRef.CalcField();
            pFieldRef.Value := lFieldRef.Value;
        end else begin
            Error(StrSubstNo(tErrFieldType, pFieldRef.Caption));
        end;
    end;
}

