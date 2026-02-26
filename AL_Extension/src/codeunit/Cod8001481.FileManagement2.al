Codeunit 8001481 "File Management2"
{
    // /*
    //  * Author : PETIT Xavier
    //  * Created on 10/06/2010
    //  * Version : 1.5
    //  * Manage the TextFile
    //  */


    trigger OnRun()
    begin
    end;

    var

        //GL2024 Automation non compatible   gFileSystemObject: Automation FileSystemObject;

        //GL2024 Automation non compatible    gFile: Automation File;

        //GL2024 Automation non compatible   gTextStream: Automation TextStream;
        gDirectory: Text[250];
        gFileName: Text[250];
        tDirMissing: label 'The Folder is missing';
        tFileMissing: label 'The filename is missing';
        tErrFileOpen: label 'An Error Occured at the openning of the file';
        tErrOutArray: label 'The index is out of bound';
        gFieldSeparator: Text[10];
        gStringSeparator: Text[10];
        gData: array[255] of Text[250];
        gDataType: array[255] of Option "Code",Text,Decimal,Option,Boolean,Date,Time,DateTime,"Integer",BigInt,DateFormula;
        gError: Text[1024];
        gNbData: Integer;
        gSize: Integer;
        gByteRead: Integer;
        gQueryReplace: Boolean;

        //GL2024 Automation non compatible   gListFile: Automation Dictionary;
        gEndOfFile: Option CRLF,CR,LF;
        gShowMessageDlg: Boolean;
        tFileExist: label 'The file %1 already exist. Do you want to write this ?';


    procedure fSetDirectory(pPath: Text[250])
    var
        lEndChar: Char;
    begin
        /***************************************************
        *                fSetDirectory                    *
        ***************************************************
        * Input : The path of the file                    *
        * Output : Nothing                                *
        ***************************************************
        * Set the directory of import or export Data      *
        ***************************************************/
        lEndChar := pPath[StrLen(pPath)];
        if (lEndChar <> '\') then
            gDirectory := pPath + '\'
        else
            gDirectory := pPath;

    end;


    procedure fGetDirectory() Return: Text[250]
    begin
        /***************************************************
        *                fGetDirectory                    *
        ***************************************************
        * Input : Nothing                                 *
        * Output : The path of the file                   *
        ***************************************************
        * Get the directory of import or export Data      *
        ***************************************************/
        Return := gDirectory;

    end;


    procedure fSetFileName(pFilename: Text[250])
    begin
        /***************************************************
        *                fSetFileName                     *
        ***************************************************
        * Input : The Filename of import or export        *
        * Output : Nothing                                *
        ***************************************************
        * Set the Filename of import or export Data       *
        * This name must have the extension               *
        ***************************************************/
        gFileName := pFilename;

    end;


    procedure fGetFileName() Return: Text[250]
    begin
        /***************************************************
        *                fGetFileName                     *
        ***************************************************
        * Input : Nothing                                 *
        * Output : The filename                           *
        ***************************************************
        * Get the filename of import export data          *
        ***************************************************/
        Return := gFileName;

    end;


    procedure fOpenFile(pCreate: Boolean; pIoMode: Option Reading,Writing,Append; pFormat: Option "System Default",Unicode,Ascii) Return: Boolean
    var
        lIoMode: Integer;
        lFormat: Integer;
    begin
        /***************************************************
        *                fOpenFile                        *
        ***************************************************
        * Input : Write                                   *
        * Output : Boolean                                *
        ***************************************************
        * Return True if the filename is opened correctly,*
        * False Otherise                                  *
        * If Write parameter is TRUE, the file is opened  *
        * In write, Read otherwise                        *
        ***************************************************/
        Return := false;

        case (pIoMode) of
            Piomode::Reading:
                lIoMode := 1;
            Piomode::Writing:
                lIoMode := 2;
            Piomode::Append:
                lIoMode := 8;
        end;

        case (pFormat) of
            Pformat::"System Default":
                lFormat := -2;
            Pformat::Unicode:
                lFormat := -1;
            Pformat::Ascii:
                lFormat := 0;
        end;

        /* 
    //GL2024 Automation non compatible
       if (ISCLEAR(gFileSystemObject)) then
                fInitialise();

            if (StrLen(gDirectory) <> 0) and (StrLen(gFileName) <> 0) then begin
                if ((not gQueryReplace) and (pIoMode = Piomode::Writing) and (fFileExists(gDirectory + gFileName))) then begin
                    //#9168
                    if (gShowMessageDlg) then begin
                        if (Confirm(StrSubstNo(tFileExist, gFileName)) = true) then begin
                            gFileSystemObject.DeleteFile(gDirectory + gFileName);
                        end else begin
                            exit(false);
                        end;
                    end else begin
                        gFileSystemObject.DeleteFile(gDirectory + gFileName);
                    end;
                    //#9168//
                end;
                gTextStream := gFileSystemObject.OpenTextFile(gDirectory + gFileName, lIoMode, pCreate, lFormat);
                gFile := gFileSystemObject.GetFile(gDirectory + gFileName);
                gSize := gFile.Size();
                Clear(gFile);
            end;*/
        Return := true;

    end;


    procedure fCloseFile()
    begin
        /***************************************************
        *                   fCloseFile                    *
        ***************************************************
        * Input : Nothing                                 *
        * Output : Nothing                                *
        ***************************************************
        * Close the file of import or export Data         *
        ***************************************************/

        //GL2024 Automation non compatible  gTextStream.Close();

        //GL2024 Automation non compatible   Clear(gTextStream);

    end;


    procedure fWrite(pValue: Text[250])
    begin
        /***************************************************
        *                 fWriteLine                      *
        ***************************************************
        * Input : Text to be written in the file          *
        * Output : Nothing                                *
        ***************************************************
        * Write the data                                  *
        ***************************************************/

        //GL2024 Automation non compatible  gTextStream.Write(pValue);

    end;


    procedure fWriteLine(pLine: Text[1024])
    var
        lIndex: Integer;
    begin
        /***************************************************
        *                 fWriteLine                      *
        ***************************************************
        * Input : Text to be written in the file          *
        * Output : Nothing                                *
        ***************************************************
        * Write the data                                  *
        ***************************************************/

        //GL2024 Automation non compatible   gTextStream.WriteLine(pLine);

    end;


    procedure fInitialise()
    var
        lIndex: Integer;
    begin
        /***************************************************
        *                 fInitialise                     *
        ***************************************************
        * Input : Nothing                                 *
        * Output : Nothing                                *
        ***************************************************
        *                                                 *
        ***************************************************/
        gFieldSeparator := '';
        gStringSeparator := '';
        gDirectory := '';
        gFileName := '';
        gError := '';
        gNbData := 0;
        gSize := 0;
        gByteRead := 0;
        //#8974
        gEndOfFile := Gendoffile::CRLF;
        //#8974//
        //#9168
        gShowMessageDlg := true;
        gQueryReplace := false;
        //#9168//
        for lIndex := 1 to ArrayLen(gData) do begin
            gData[lIndex] := '';
            gDataType[lIndex] := gDataType[lIndex] ::Text;
        end;

        //GL2024 Automation non compatible  Create(gFileSystemObject, true, ISSERVICETIER);

    end;


    procedure fFinalize()
    begin
        /***************************************************
        *                   fFinalyse                     *
        ***************************************************
        * Input : Nothing                                 *
        * Output : Nothing                                *
        ***************************************************
        *                                                 *
        ***************************************************/

        //GL2024 Automation non compatible   Clear(gTextStream);

        //GL2024 Automation non compatible  Clear(gFile);

        //GL2024 Automation non compatible Clear(gFileSystemObject);

    end;


    procedure fRead(pLong: Integer) Return: Text[1024]
    begin
        /***************************************************
        *                  fRead                          *
        ***************************************************
        * Input : Nothing                                 *
        * Output : Boolean                                *
        ***************************************************
        * True, if the file has been correctly read       *
        * False otherwise                                 *
        ***************************************************/

        //GL2024 Automation non compatible    Return := gTextStream.Read(pLong);
        gByteRead += StrLen(Return);

    end;


    procedure fReadLine() Return: Text[1024]
    var
        lLine: Text[1024];
    begin
        /***************************************************
        *                  fReadFile                      *
        ***************************************************
        * Input : Nothing                                 *
        * Output : Boolean                                *
        ***************************************************
        * True, if the file has been correctly read       *
        * False otherwise                                 *
        ***************************************************/

        //GL2024 Automation non compatible   Return := gTextStream.ReadLine();
        gByteRead += StrLen(Return);

    end;


    procedure fGetEOF() Return: Boolean
    begin
        /***************************************************
        *                    fGetEOF                      *
        ***************************************************
        * Input : Nothing                                 *
        * Output : Boolean                                *
        ***************************************************
        * True, if at End of File, False OtherWise        *
        ***************************************************/

        //GL2024 Automation non compatible  Return := gTextStream.AtEndOfStream();

    end;


    procedure fGetExtension(var pFilename: Text[255]) Return: Text[30]
    var
        lPosition: Integer;
    begin
        /*****************************************************
        *               fGetExtension                       *
        *****************************************************
        * Input : Filename                                  *
        * Output : Extension of the filename              *
        *****************************************************
        * Return the extension of the filename in parameter *
        *****************************************************/
        Return := '';
        lPosition := StrPos(pFilename, '.');
        if (lPosition <> 0) then begin
            Return := CopyStr(pFilename, lPosition);
            pFilename := CopyStr(pFilename, 1, lPosition - 1);
        end;

    end;


    procedure fSetFullFileName(pFullFileName: Text[1024])
    var
        lExitLoop: Boolean;
        lPointBreak: Integer;
    begin
        lExitLoop := false;
        lPointBreak := StrLen(pFullFileName);
        while (not lExitLoop) or (lPointBreak <= 1) do
            if CopyStr(pFullFileName, lPointBreak, 1) = '\' then begin
                gFileName := CopyStr(pFullFileName, lPointBreak + 1);
                lExitLoop := true;
            end else
                lPointBreak -= 1;
        fSetDirectory(CopyStr(pFullFileName, 1, lPointBreak));
    end;


    procedure fSetFieldSeparator(pFieldSeparator: Text[10])
    begin
        /***************************************************
        *                fSetFieldSeparator               *
        ***************************************************
        * Input : The Filed Separator Character           *
        * Output : Nothing                                *
        ***************************************************
        * Set the Separator between each field            *
        ***************************************************/
        gFieldSeparator := pFieldSeparator;

    end;


    procedure fGetFieldSeparator() Return: Text[10]
    begin
        /***************************************************
        *                fGetFieldSeparator               *
        ***************************************************
        * Input : Nothing                                 *
        * Output : The Field Separator                    *
        ***************************************************
        * Get the separator between each field            *
        ***************************************************/
        Return := gFieldSeparator;

    end;


    procedure fSetStringSeparator(pStringSeparator: Text[10])
    begin
        /***************************************************
        *                fSetStringSeparator              *
        ***************************************************
        * Input : The String Separator                    *
        * Output : Nothing                                *
        ***************************************************
        * Set the String separator for the strign datatype*
        ***************************************************/
        gStringSeparator := pStringSeparator;

    end;


    procedure fGetStringSeparator() Return: Text[10]
    begin
        /***************************************************
        *                fGetStringSeparator              *
        ***************************************************
        * Input : Nothing                                 *
        * Output : The String Separator                   *
        ***************************************************
        * Get the String separator                        *
        ***************************************************/
        Return := gStringSeparator;

    end;


    procedure fWriteFile(pElementNumber: Integer)
    var
        lIndex: Integer;
        lCR: Char;
        lLF: Char;
    begin
        /***************************************************
        *                 fWriteFile                      *
        ***************************************************
        * Input : Number of element at written            *
        * Output : Nothing                                *
        ***************************************************
        * Write the data for the ElementNumber parameter  *
        ***************************************************/
        /* 
  //GL2024 Automation non compatible for lIndex := 1 to pElementNumber - 1 do begin
              if (gDataType[lIndex] <> gDataType[lIndex] ::Code) and (gDataType[lIndex] <> gDataType[lIndex] ::Text) then
                  gTextStream.Write(gData[lIndex] + gFieldSeparator)
              else
                  gTextStream.Write(gStringSeparator + gData[lIndex] + gStringSeparator + gFieldSeparator);
          end;*/
        /* 
   //GL2024 Automation non compatible  if (gDataType[pElementNumber] <> gDataType[pElementNumber] ::Code) and
              (gDataType[pElementNumber] <> gDataType[pElementNumber] ::Text) then
               gTextStream.Write(gData[pElementNumber])
           else
               gTextStream.Write(gStringSeparator + gData[pElementNumber] + gStringSeparator);*/

        //#8974
        lCR := 13;
        lLF := 10;
        /* 
  //GL2024 Automation non compatible case (gEndOfFile) of
              Gendoffile::CRLF:
                  begin
                      gTextStream.Write(Format(lCR));
                      gTextStream.Write(Format(lLF));
                  end;
              Gendoffile::CR:
                  begin
                      gTextStream.Write(Format(lCR));
                  end;
              Gendoffile::LF:
                  begin
                      gTextStream.Write(Format(lLF));
                  end;
          end;*/
        //#8974//

    end;


    procedure fSetData(pData: Text[250]; pDataType: Option "Code",Text,Decimal,Option,Boolean,Date,Time,DateTime,"Integer",BigInt,DateFormula; pIndex: Integer) Return: Boolean
    begin
        /***************************************************
        *                  fSetData                       *
        ***************************************************
        * Input : The data to insert in the file          *
        *       : Data type of the data                   *
        *       : Index of the array, where the data will *
        *         be inserted                             *
        * Output : booelan                                *
        ***************************************************
        * Return true, whether the data have been         *
        * correctly inserted, False otherise              *
        ***************************************************/
        Return := false;
        if (pIndex > 0) and (pIndex <= ArrayLen(gData)) then begin
            gData[pIndex] := pData;
            gDataType[pIndex] := pDataType;
        end else
            gError := tErrOutArray;

    end;


    procedure fReadFile() Return: Boolean
    var
        lLine: Text[1024];
    begin
        /***************************************************
        *                  fReadFile                      *
        ***************************************************
        * Input : Nothing                                 *
        * Output : Boolean                                *
        ***************************************************
        * True, if the file has been correctly read       *
        * False otherwise                                 *
        ***************************************************/
        Return := false;

        //GL2024 Automation non compatible    lLine := gTextStream.ReadLine();
        gByteRead += StrLen(lLine);
        Return := fDecomposeLine(lLine);

    end;

    local procedure fDecomposeLine(pLine: Text[1024]) Return: Boolean
    var
        lPosition: Integer;
        lSubText: Text[250];
        lIndex: Integer;
    begin
        /***************************************************
        *                fDecomposeLine                   *
        ***************************************************
        * Input : Line to decompose                       *
        * Output : Boolean                                *
        ***************************************************
        * True, if the decomposition well done,           *
        * False otherwise                                 *
        ***************************************************/
        Return := false;
        lIndex := 1;
        lPosition := StrPos(pLine, gFieldSeparator);
        while (lPosition <> 0) do begin
            lSubText := CopyStr(pLine, 1, lPosition - 1);
            pLine := DelStr(pLine, 1, lPosition);
            fIsString(lSubText);
            gData[lIndex] := lSubText;
            lPosition := StrPos(pLine, gFieldSeparator);
            lIndex += 1;
        end;
        lSubText := pLine;
        fIsString(lSubText);
        gData[lIndex] := lSubText;
        gNbData := lIndex;

    end;


    procedure fGetData(pIndex: Integer) Return: Text[255]
    begin
        /***************************************************
        *                  fGetData                       *
        ***************************************************
        * Input : Index                                   *
        * Output : Boolean                                *
        ***************************************************
        * Return the value at the index in parametrer     *
        ***************************************************/
        Return := gData[pIndex];

    end;


    procedure fSetDataType(pIndex: Integer; pValue: Text[255])
    begin
        /***************************************************
        *                 fSetDataType                    *
        ***************************************************
        * Input : Index                                   *
        *       : Value to check                          *
        * Output : Boolean                                *
        ***************************************************
        * Check the datatype of the value in parameter    *
        * And set this one at the index in parameter      *
        ***************************************************/

    end;


    procedure fIsString(var pString: Text[250]) Return: Boolean
    begin
        /***************************************************
        *                   fIsString                     *
        ***************************************************
        * Input : String to check                         *
        * Output : Boolean                                *
        ***************************************************
        * True, if the value is a string,                 *
        * False otherwise                                 *
        ***************************************************/
        Return := false;
        if (gStringSeparator <> '') then begin
            if ((Format(pString[1]) = gStringSeparator) and
                (Format(pString[StrLen(pString)]) = gStringSeparator)) then begin
                pString := CopyStr(pString, 2, StrLen(pString) - 2);
                Return := true;
            end;
        end;

    end;


    procedure fGetDataNumbers() Retour: Integer
    begin
        /***************************************************
        *                   fGetDataNumbers               *
        ***************************************************
        * Input : Nothing                                 *
        * Output : Integer                                *
        ***************************************************
        * Return the number of column Data find where the *
        * process read a line into the file               *
        ***************************************************/
        Retour := gNbData;

    end;


    procedure fGetSize() Retour: Integer
    begin
        /***************************************************
        *                      fGetSize                   *
        ***************************************************
        * Input : Nothing                                 *
        * Output : Integer                                *
        ***************************************************
        * Return the size of the file                     *
        ***************************************************/
        Retour := gSize;

    end;


    procedure fGetPosition() Retour: Integer
    begin
        /***************************************************
        *                      fGetPosition               *
        ***************************************************
        * Input : Nothing                                 *
        * Output : Integer                                *
        ***************************************************
        * Return the number of Bytes read into the file   *
        ***************************************************/
        Retour := gByteRead;

    end;


    procedure fReadChar() Retour: Char
    var
        lRead: Text[1];
    begin
        /***************************************************
        *                  fReadChar                      *
        ***************************************************
        * Input : Nothing                                 *
        * Output : Boolean                                *
        ***************************************************
        * True, if the file has been correctly read       *
        * False otherwise                                 *
        ***************************************************/

        //GL2024 Automation non compatible  lRead := gTextStream.Read(1);
        gByteRead += StrLen(lRead);
        Retour := lRead[1];

    end;


    procedure fCopyFile(pTargetFile: Text[1024]; pOverwrite: Boolean)
    begin
        /***************************************************
        *                  fCopyFile                      *
        ***************************************************
        * Input : Nothing                                 *
        * Output : Boolean                                *
        ***************************************************
        * True, if the file has been correctly read       *
        * False otherwise                                 *
        ***************************************************/

        //GL2024 Automation non compatible  gFileSystemObject.CopyFile(gDirectory + gFileName, pTargetFile, pOverwrite);

    end;

    /*
    //GL2024 Automation non compatible
        procedure fFileRename(pOldFileName: Text[1024]; pNewFileName: Text[1024])
        begin
            if ISCLEAR(gFileSystemObject) then
                Create(gFileSystemObject, true, true);
            gFileSystemObject.MoveFile(pOldFileName, pNewFileName);
        end;


        procedure fFileExists(pFileName: Text[1024]): Boolean
        begin
            if ISCLEAR(gFileSystemObject) then
                Create(gFileSystemObject, true, true);
            exit(gFileSystemObject.FileExists(pFileName));
        end;

    */
    procedure fSetQueryReplace(pQueryReplace: Boolean)
    begin
        /***************************************************
        *                fSetQueryReplace                 *
        ***************************************************
        * Input : Query Replace                           *
        * Output : Nothing                                *
        ***************************************************
        * Set the Query Replace                           *
        * TRUE --> Show Queried before replace            *
        * FALSE --> Dont Show                             *
        ***************************************************/
        gQueryReplace := pQueryReplace;

    end;


    procedure fGetQueryReplace() retour: Boolean
    begin
        /***************************************************
        *                fGetQueryReplace                 *
        ***************************************************
        * Input : The Query Replace                       *
        * Output : Nothing                                *
        ***************************************************
        * Get the query replace                           *
        ***************************************************/
        retour := gQueryReplace;

    end;

    /* //GL2024 
        procedure fImportBlob(var pBlobRef: Record 99008535 temporary)
        var
            IStream: InStream;
            FileVar: File;
            OStream: OutStream;
            MagicPath: Text[1024];
            i: Integer;
        begin
            FileVar.CreateTempfile;
            FileVar.CreateInstream(IStream);
            DownloadFromStream(IStream, '', '<TEMP>', '', MagicPath);
            FileVar.Close();
            for i := StrLen(MagicPath) downto 1 do begin
                if MagicPath[i] = '\' then begin
                    MagicPath := CopyStr(MagicPath, 1, i);
                    i := 1;
                end;
            end;
            //GL2024 Automation non compatible   gFileSystemObject.CopyFile(gDirectory + gFileName, MagicPath + '\' + gFileName);
            UploadIntoStream('', '<TEMP>', '', gFileName, IStream);
            pBlobRef.Blob.CreateOutstream(OStream);
            CopyStream(OStream, IStream);
        end;
    */

    procedure fGetFiles(pPath: Text[1024]; pWildcard: Text[1024]) retour: Integer
    var
        lChkLicenceMgt: Codeunit "Check Licence Management";
    begin
        //#9031
        // Create the object used tosearch the different file
        //GL2024 Automation non compatible Create(gListFile, true, ISSERVICETIER);
        //GL2024 Automation non compatible    retour := lChkLicenceMgt.fFileMgtGetFiles(gListFile, gFileSystemObject, pPath, pWildcard);
        //#9031//
    end;


    procedure fGetFileAt(pIndex: Integer) retour: Text[1024]
    var
        lIndexStr: Text[30];
    begin
        //#9031
        retour := '';
        lIndexStr := Format(pIndex);
        /* //GL2024 Automation non compatible  if (not ISCLEAR(gListFile)) and ((pIndex > 0) and (pIndex <= gListFile.Count)) then begin
               if (gListFile.Exists(lIndexStr)) then
                   retour := Format(gListFile.Item(lIndexStr));
           end;*/
        //#9031//
    end;


    procedure fIsFile(pPath: Text[1024]) retour: Boolean
    var
        //GL2024 Automation non compatible  lFolder: Automation Folder;
        //GL2024 Automation non compatible  lFiles: Automation Files;
        //GL2024 Automation non compatible   lFolders: Automation Folders;
        lIsFolder: Boolean;
        lIsFile: Boolean;
    begin
        /***************************************************
        *                    fIsFile                      *
        ***************************************************
        * Input : Element to be tested if is a file       *
        * Output : Boolean                                *
        ***************************************************
        * Try to identify, if the element in parameter is *
        * a file contain in the current folder            *
        ***************************************************/
        retour := false;
        //GL2024 Automation non compatible    lIsFile := gFileSystemObject.FileExists(pPath);
        //GL2024 Automation non compatible    lIsFolder := gFileSystemObject.FolderExists(pPath);
        retour := (lIsFile) or ((not lIsFile) and (not lIsFolder));

    end;


    procedure fSetEOFCharacter(pEOF: Option CRLF,CR,LF)
    begin
        //#8974
        gEndOfFile := pEOF;
        //#8974//
    end;


    procedure fGetEOFCharacter() retour: Integer
    begin
        //#8974
        retour := gEndOfFile;
        //#8974
    end;


    procedure fGetShowDialog() Retour: Boolean
    begin
        //#9168
        Retour := gShowMessageDlg;
        //#9168//
    end;


    procedure fSetShowDialog(pShow: Boolean)
    begin
        //#9168
        gShowMessageDlg := pShow;
        //#9168//
    end;
}

