Codeunit 8001558 "StyloPDF Import"
{

    //GL2024  ID dans Nav 2009 : "8035042"
    // //OF TEST : Import Stylo PDF
    // // voir les temp


    trigger OnRun()
    var
        lStyloPDFSetup: Record "Solde Fournisseur II";
        //GL2024 License    lFilePath: Record File;
        lDotPosition: Integer;
        lExtension: Text[30];
        lReturnShell: Integer;
    begin
        //JobQueueEntry."Object Type to Run" := JobQueueEntry."Object Type to Run"::Codeunit;
        //JobQueueEntry."Object ID to Run" := 8035042;
        //JobQueueEntry.INSERT(TRUE);

        //TESTFIELD("Parameter String");
        //Balage du setup Stylo PDF, donc n imports
        if not lStyloPDFSetup.Find('-') then
            exit;
        repeat
            //Balayage des fichiers xml
            if lStyloPDFSetup.User <> '' then begin
                if lStyloPDFSetup."Code Fournisseur" = 'PDF' then
                    gTypePDF := true
                else
                    gTypePDF := false;
                //GL2024 License   lFilePath.SetRange(Path, lStyloPDFSetup.User);
                //Transfer des fichiers FTP vers Serveur
                /*   //GL2024 if not gTypePDF then
                        lReturnShell := SHELL(TestShell, 'ERP', PathName + '\ERP', '*.xml', 'n')*/
                //lReturnShell := SHELL(TestShell,'ERP',lStyloPDFSetup."Folder Before Import",'*.xml','n')
                /* //GL2024  else
                       lReturnShell := SHELL(TestShell, 'StyloPDF', PathName + '\PDF', '*.xml', 'n');*/
                //lReturnShell := SHELL(TestShell,'StyloPDF',lStyloPDFSetup."Folder Before Import",'*.xml','n');
                //GL2024 License  lFilePath.SetRange("Is a file", true);
                //lFilePath.SETRANGE(Name,'*.XML');
                //GL2024 License   if lFilePath.Find('-') then

                //Lecture des fichiers
                //GL2024 License repeat
                //GL2024 License   gExclure := false;
                //GL2024 License  lDotPosition := StrPos(lFilePath.Name, '.');
                //GL2024 License     lExtension := UpperCase(CopyStr(lFilePath.Name, lDotPosition + 1, 3));
                //GL2024 License  if lExtension = 'XML' then begin
                //gFileName := 'C:\Temp\bookdata_18_001_ERP_XML.XML';
                //GL2024     gImportXML(lFilePath.Path, lFilePath.Name, fIDGeneration(lFilePath.Name, lStyloPDFSetup."Heure Calcule"));
                //GL2024 License    if not gExclure then
                //GL2024 License     gCounter += 1;
                //archivage du fichier
                /* //GL2024   if not Rename(lFilePath.Path + lFilePath.Name, lStyloPDFSetup."Date Calcule" + lFilePath.Name) then begin
                        //RENAME(lStyloPDFSetup."Folder After Import" + lFilePath.Name,
                        //    lStyloPDFSetup."Folder After Import" + lFilePath.Name+DELCHR(FORMAT(TIME),':',''));
                        Erase(lStyloPDFSetup."Date Calcule" + lFilePath.Name);
                        Rename(lFilePath.Path + lFilePath.Name, lStyloPDFSetup."Date Calcule" + lFilePath.Name)
                    end;*/
                //GL2024 License  end;
                //GL2024 Licenseuntil lFilePath.Next = 0;
            end;
        until lStyloPDFSetup.Next = 0;
        if GuiAllowed then
            Message(StrSubstNo(Text001, Format(gCounter)));
    end;

    var
        gFile: File;
        gInStream: InStream;
        gID: Code[20];
        gCounter: Integer;
        Text001: label '%1 ficher(s) importés';
        TextCodeSecteur: label 'PR-02';
        gDateText: Text[30];
        TextToDoDescription: label 'Relance suite à visite Batimat';
        TextToDoCampaign: label 'BATIMAT';
        TextCom1: label 'Visite Batimat le %1 par %2';
        TextCom2Bis: label 'Intérêt : %1';
        gComInteret: Text[80];
        gComProjet: Text[80];
        gComCdc: Text[80];
        gComConsultation: Text[80];
        gComExistant: Text[80];
        gComCommentaire: Text[80];
        gComQualifSuivi: Text[80];
        gComAction: Text[80];
        gExclure: Boolean;
        TextCom3: label 'Projet : %1';
        TextCom4: label 'Cdc : %1';
        TextCom5: label 'Consultation : %1';
        TextCom20: label 'Qualification Batimat : %1';
        TextCom21: label 'Action : %1';
        gTypePDF: Boolean;
        TestShell: label 'P:\Temp\Batimat\ftpcmd.bat';
        PathName: label 'D:\Temp';
        TextCom3PDF: label 'Collaborateurs itinérants ? %1';
        JobQueueEntry: Record "Job Queue Entry";
        TextCom4PDF: label 'Equipés de mobiles ? %1';
        TextCom5PDF: label 'Présentation PDF en entreprise ? %1';


    procedure gImportXML(pFilePath: Text[250]; pFileName: Text[250]; pCode: Code[20])
    var
        lContactCpyTMP: Record Contact temporary;
        lContactPerTMP: Record Contact temporary;
        lCommentTMP: Record "Rlshp. Mgt. Comment Line" temporary;
        lXMLTools: Codeunit "XML tools";
        /* //GL2024    pXmlDoc: Automation;
             lXmlNode: Automation;
             lXmlCurNode: Automation;
             lXmlNamedNodeMap: Automation;
             lXmlAttribute: Automation;
             lXmlListNode: Automation;*/
        lBigText: BigText;
        lText: Text[250];
        i: Integer;
        lValue: Text[250];
        lName: Text[30];
    begin
        //Importation d'un fichier donc 1 contact sté, 1 contact, 1 action, 1 commentaire
        /*//GL2024  if not ISCLEAR(pXmlDoc) then
              Clear(pXmlDoc);
          Create(pXmlDoc);
          pXmlDoc.async := false;
          pXmlDoc.validateOnParse := true;*/

        fInitRecords(pCode, lContactCpyTMP, lContactPerTMP, lCommentTMP);

        /*//GL2024  if gFile.Open(pFilePath + pFileName) then begin
              gFile.CreateInstream(gInStream);
              if pXmlDoc.load(pFilePath + pFileName) then begin
                  //IF lXMLTools.LoadXMLFromFile(pXmlDoc,gFileName) THEN
                  //MESSAGE('pXmlDoc lu');
                  lXmlNode := pXmlDoc.documentElement;

                  lXmlCurNode := lXmlNode.selectSingleNode('//Data');
                  lXmlListNode := lXmlNode.selectNodes('//OSDATA|//OSDATA');
                  for i := 0 to lXmlListNode.length() - 1 do begin
                      //lXmlCurNode := lXmlNode.selectSingleNode('//OSDATA/following::OSDATA|following-sibling::OSDATA|/descendant::OSDATA');
                      lXmlCurNode := lXmlCurNode.selectSingleNode('//OSDATA[' + Format(i) + ']');
                      if (not ISCLEAR(lXmlCurNode)) then begin
                          lXmlNamedNodeMap := lXmlCurNode.attributes;
                          lXmlAttribute := lXmlNamedNodeMap.getNamedItem('Value');
                          if not ISCLEAR(lXmlAttribute) then begin
                              lValue := lXmlAttribute.value;
                          end;
                          lXmlAttribute := lXmlNamedNodeMap.getNamedItem('Name');
                          if not ISCLEAR(lXmlAttribute) then begin
                              lName := lXmlAttribute.value;
                          end;
                      end;//ISCLEAR

                      if lValue <> '' then
                          if not gTypePDF then
                              fInfosMgt(lName, lValue, lContactCpyTMP, lContactPerTMP, lCommentTMP)
                          else
                              fInfosMgtPDF(lName, lValue, lContactCpyTMP, lContactPerTMP, lCommentTMP);
                      if gExclure then
                          exit;

                  end;//FOR

                  fUpdateRecords(lContactCpyTMP, lContactPerTMP);

              end
              else
                  Message('Prb xml !');
              gFile.Close;
          end;*/
    end;


    procedure fIDGeneration(pFileName: Text[250]; pIDSise: Integer): Code[20]
    begin
        //IF STRPOS(pFileName,'
        //pFileName := COPYSTR(pFileName,);
        //pFileName := lFileManagement.fSetFullFileName(pFileName);
        exit(CopyStr(pFileName, 1, pIDSise));
    end;


    procedure fInfosMgt(pName: Text[30]; pValue: Text[250]; var pContactCpy: Record Contact temporary; var pContactPer: Record Contact temporary; var pComment: Record "Rlshp. Mgt. Comment Line" temporary)
    var
        lFieldName: Text[30];
        lPos: Integer;
        lField: Record "Field";
        lSizeComment: Integer;
    begin
        //Mise à jour des infos ERP
        //IF pValue = '1' THEN
        //  pValue := 'O'
        //ELSE
        //  pValue := 'N';
        lSizeComment := MaxStrLen(pComment.Comment);

        //Contact Ste
        case pName of
            'Contact.Salesperson.Code':
                pContactCpy."Salesperson Code" := pValue;
            'Contact.name':
                pContactCpy.Name := pValue;
            'Contact.Address':
                pContactCpy.Address := pValue;
            'Contact.Address.2':
                pContactCpy."Address 2" := pValue;
            'Contact.Post.Code':
                pContactCpy."Post Code" := pValue;
            'Contact.City':
                pContactCpy.City := pValue;
            'Contact.County':
                pContactCpy.County := pValue;
            'Contact.Activite':
                pContactCpy."Job Title" := pValue;
            //'Contact.Effectif' : pContactCpy.County := pValue;
            //'Person.Name' : pContactCpy.County := pValue;
            //'Person.Job.Title' : pContactCpy.County := pValue;
            'Contact.Phone.No':
                pContactCpy."Phone No." := pValue;
            'Person.E-Mail':
                pContactCpy."E-Mail" := pValue;
        //'Projet.Comment' : pContactCpy."E-Mail" := pValue;
        //'Projet.True'
        end;

        //pContactCpy.Name := pContactCpy."Company Name";

        //Contact Personne
        case pName of
            'Contact.Salesperson.Code':
                pContactPer."Salesperson Code" := pValue;
            //'Contact.Name' : pContactPer.Name := pValue;
            'Contact.Address':
                pContactPer.Address := pValue;
            'Contact.Address.2':
                pContactPer."Address 2" := pValue;
            'Contact.Post.Code':
                pContactPer."Post Code" := pValue;
            'Contact.City':
                pContactPer.City := pValue;
            'Contact.County':
                pContactPer.County := pValue;
            //'Contact.Activite' : pContactCpy."Job Title" := pValue;
            //'Contact.Effectif' : pContactCpy.County := pValue;
            'Person.Name':
                pContactPer.Name := pValue;
            //'Person.Job.Title' : pContactCpy.County := pValue;
            'Contact.Phone.No':
                pContactPer."Phone No." := pValue;
            'Person.E-Mail':
                pContactPer."E-Mail" := pValue;
        //'Projet.Comment' : pContactCpy."E-Mail" := pValue;
        //'Projet.True'
        end;

        //ToDo
        case pName of
            'Date.JJ':
                gDateText := pValue;
            'Date.MM':
                gDateText := gDateText + '/' + pValue;
        end;

        //Commentaires
        case pName of
            //Qualification / Suivi
            'Suivi.A':
                if pValue = '1' then
                    gComQualifSuivi := 'A ' + gComQualifSuivi;
            'Suivi.B':
                if pValue = '1' then
                    gComQualifSuivi := 'B ' + gComQualifSuivi;
            'Suivi.Comment':
                gComQualifSuivi := CopyStr(gComQualifSuivi + pValue, 1, lSizeComment);
            //Suivi.C='EP:Ajouter un test avant l'import pour ne pas créer dns NAV les fiches pour lesquelles 'a suivre' = C (sans intérêt)'
            'Suivi.C':
                if pValue = '1' then
                    gExclure := true;
            //Interet
            'Interet.Comment':
                gComInteret := CopyStr(gComInteret + '. ' + pValue, 1, lSizeComment);
            'Interet.P':
                if pValue = '1' then
                    gComInteret := 'P  ' + gComInteret;
            'Interet.N':
                if pValue = '1' then
                    gComInteret := 'N ' + gComInteret;
            'Interet.S':
                if pValue = '1' then
                    gComInteret := 'S ' + gComInteret;
            //Projet
            'Projet.True':
                if pValue = '1' then
                    gComProjet := 'Oui : ' + gComProjet;
            //'Projet.False' : IF pValue = '0' THEN
            //    gComProjet := 'Non : ' + gComProjet;
            'Projet.Comment':
                gComProjet := CopyStr(gComProjet + pValue, 1, lSizeComment);
            //Cdc
            'Cdc.True':
                if pValue = '1' then
                    gComCdc := 'Oui ' + gComCdc;
            'Cdc.False':
                if pValue = '1' then
                    gComCdc := 'Non ' + gComCdc;
            'Cdc.Comment':
                gComCdc := CopyStr(gComCdc + pValue, 1, lSizeComment);
            //Consultation
            'Consultation.True':
                if pValue = '1' then
                    gComConsultation := 'Oui ' + gComConsultation;
            'Consultation.False':
                if pValue = '1' then
                    gComConsultation := 'Non ' + gComConsultation;
            'Consultation.Comment':
                gComConsultation := CopyStr(gComConsultation + pValue, 1, lSizeComment);
            //Existant
            'Existant':
                gComExistant := CopyStr(pValue, 1, lSizeComment);
            //Commantaires
            'Commentaires':
                gComCommentaire := CopyStr(pValue, 1, lSizeComment);
            //Action
            'Action.Comment':
                gComAction := CopyStr(gComAction + pValue, 1, lSizeComment);
            'Action.A':
                gComAction := 'Tel ' + gComAction;
            'Action.B':
                gComAction := 'Dist ' + gComAction;
            'Action.C':
                gComAction := 'Rdv ' + gComAction;

        end;

        //pContactPers."Name"
        /*
        lPos := STRPOS(pName,'.');
        lFieldName := COPYSTR(pName,lPos+1,STRLEN(pName)-lPos);
        
        lField.SETRANGE(TableName,'5050');
        lField.SETRANGE(FieldName,lFieldName);
        IF lField.FIND('-') THEN BEGIN
          //pContact.
        END;
        */

    end;


    procedure fInitRecords(pId: Code[20]; var pContactCpy: Record Contact temporary; var pContactPer: Record Contact temporary; var pComment: Record "Rlshp. Mgt. Comment Line" temporary)
    var
        lContact: Record Contact;
    begin
        //Vide les tables temporaires
        Clear(gDateText);
        Clear(gComInteret);
        Clear(gComProjet);
        Clear(gComCdc);
        Clear(gComConsultation);
        Clear(gComExistant);
        Clear(gComCommentaire);
        Clear(gComQualifSuivi);
        Clear(gComAction);
        pContactCpy.DeleteAll;
        pContactPer.DeleteAll;
        pComment.DeleteAll;

        //Se place sur les records existant ou les initie
        //Contact Company
        if lContact.Get(pId) then
            pContactCpy.TransferFields(lContact)
        else begin
            pContactCpy."No." := pId;
            pContactCpy.Type := pContactCpy.Type::Company;
        end;

        //Contact Personne
        if lContact.Get(pId + 'P') then
            pContactPer.TransferFields(lContact)
        else begin
            pContactPer."No." := pId + 'P';
            pContactPer.Type := pContactPer.Type::Person;
        end;

        pComment.SetRange("Table Name", pComment."table name"::Contact);
        pComment.SetRange("No.", pId);
    end;


    procedure fUpdateRecords(pContactCpy: Record Contact temporary; pContactPer: Record Contact temporary)
    var
        lContact: Record Contact;
        lToDo: Record "To-do";
        lRlshpMgtCmtLine: Record "Rlshp. Mgt. Comment Line";
        lDate: Date;
        lRecordFound: Boolean;
    begin
        //Contact Company
        if lContact.Get(pContactCpy."No.") then;
        lContact.TransferFields(pContactCpy);
        lContact."Company No." := lContact."No.";
        lContact."Territory Code" := TextCodeSecteur;
        lContact.Comment := true;
        if not lContact.Insert then
            lContact.Modify;

        //Contact Personne
        if lContact.Get(pContactPer."No.") then;
        lContact.TransferFields(pContactPer);
        lContact."Company No." := pContactCpy."No.";
        lContact."Territory Code" := TextCodeSecteur;
        lContact.Comment := true;
        if not lContact.Insert then
            lContact.Modify;

        //Action
        lToDo.SetCurrentkey("Contact Company No.", Date, "Contact No.", Closed);
        lToDo.SetRange("Contact Company No.", pContactCpy."No.");
        if lToDo.FindSet then
            lRecordFound := true;
        lToDo."Contact Company No." := pContactCpy."No.";
        lToDo."Contact No." := pContactPer."No.";
        lToDo."System To-do Type" := lToDo."system to-do type"::"Contact Attendee";
        lToDo."Campaign No." := TextToDoCampaign;
        lToDo.Type := lToDo.Type::" ";
        lToDo.Description := TextToDoDescription;
        if Evaluate(lDate, gDateText + '/' + Format(Date2dmy(Today, 3))) then
            lToDo.Date := lDate
        else
            lToDo.Date := Today;
        lToDo."Salesperson Code" := pContactCpy."Salesperson Code";
        if lRecordFound then
            lToDo.Modify
        else
            if not lToDo.Insert(true) then
                lToDo.Modify;

        //Commentaires
        //key : Nom de la table,N°,N° interligne,N° ligne
        if not gTypePDF then begin
            lRlshpMgtCmtLine.SetRange("Table Name", lRlshpMgtCmtLine."table name"::Contact);
            lRlshpMgtCmtLine.SetRange("No.", pContactCpy."No.");
            lRlshpMgtCmtLine.Comment := StrSubstNo(TextCom1, lToDo.Date, pContactPer.Name);
            fUpdateComments(lRlshpMgtCmtLine, 1, lToDo.Date, pContactCpy."No.");
            lRlshpMgtCmtLine.Comment := '';
            fUpdateComments(lRlshpMgtCmtLine, 2, lToDo.Date, pContactCpy."No.");
            lRlshpMgtCmtLine.Comment := StrSubstNo(TextCom2Bis, gComInteret);
            fUpdateComments(lRlshpMgtCmtLine, 3, lToDo.Date, pContactCpy."No.");
            //Projet
            lRlshpMgtCmtLine.Comment := StrSubstNo(TextCom3, gComProjet);
            fUpdateComments(lRlshpMgtCmtLine, 4, lToDo.Date, pContactCpy."No.");
            //Cdc
            lRlshpMgtCmtLine.Comment := StrSubstNo(TextCom4, gComCdc);
            fUpdateComments(lRlshpMgtCmtLine, 5, lToDo.Date, pContactCpy."No.");
            //Consultation
            lRlshpMgtCmtLine.Comment := StrSubstNo(TextCom5, gComConsultation);
            fUpdateComments(lRlshpMgtCmtLine, 6, lToDo.Date, pContactCpy."No.");
            lRlshpMgtCmtLine.Comment := '';
            fUpdateComments(lRlshpMgtCmtLine, 7, lToDo.Date, pContactCpy."No.");
            //Existant
            lRlshpMgtCmtLine.Comment := gComExistant;
            fUpdateComments(lRlshpMgtCmtLine, 8, lToDo.Date, pContactCpy."No.");
            //Commentaires
            lRlshpMgtCmtLine.Comment := gComCommentaire;
            fUpdateComments(lRlshpMgtCmtLine, 14, lToDo.Date, pContactCpy."No.");
            lRlshpMgtCmtLine.Comment := '';
            fUpdateComments(lRlshpMgtCmtLine, 20, lToDo.Date, pContactCpy."No.");
            //Qualification / Suivi
            lRlshpMgtCmtLine.Comment := StrSubstNo(TextCom20, gComQualifSuivi);
            fUpdateComments(lRlshpMgtCmtLine, 21, lToDo.Date, pContactCpy."No.");
            //Action
            lRlshpMgtCmtLine.Comment := StrSubstNo(TextCom21, gComAction);
            fUpdateComments(lRlshpMgtCmtLine, 22, lToDo.Date, pContactCpy."No.");
        end
        else begin
            lRlshpMgtCmtLine.SetRange("Table Name", lRlshpMgtCmtLine."table name"::Contact);
            lRlshpMgtCmtLine.SetRange("No.", pContactCpy."No.");
            lRlshpMgtCmtLine.Comment := StrSubstNo(TextCom1, lToDo.Date, pContactPer.Name);
            fUpdateComments(lRlshpMgtCmtLine, 1, lToDo.Date, pContactCpy."No.");
            lRlshpMgtCmtLine.Comment := '';
            fUpdateComments(lRlshpMgtCmtLine, 2, lToDo.Date, pContactCpy."No.");
            lRlshpMgtCmtLine.Comment := StrSubstNo(TextCom2Bis, gComInteret);
            fUpdateComments(lRlshpMgtCmtLine, 3, lToDo.Date, pContactCpy."No.");
            //Projet
            lRlshpMgtCmtLine.Comment := StrSubstNo(TextCom3PDF, gComProjet);
            fUpdateComments(lRlshpMgtCmtLine, 4, lToDo.Date, pContactCpy."No.");
            //Cdc
            lRlshpMgtCmtLine.Comment := StrSubstNo(TextCom4PDF, gComCdc);
            fUpdateComments(lRlshpMgtCmtLine, 5, lToDo.Date, pContactCpy."No.");
            //Consultation
            lRlshpMgtCmtLine.Comment := StrSubstNo(TextCom5PDF, gComConsultation);
            fUpdateComments(lRlshpMgtCmtLine, 6, lToDo.Date, pContactCpy."No.");
            lRlshpMgtCmtLine.Comment := '';
            fUpdateComments(lRlshpMgtCmtLine, 7, lToDo.Date, pContactCpy."No.");
            //Existant
            lRlshpMgtCmtLine.Comment := gComExistant;
            fUpdateComments(lRlshpMgtCmtLine, 8, lToDo.Date, pContactCpy."No.");
            //Commentaires
            lRlshpMgtCmtLine.Comment := gComCommentaire;
            fUpdateComments(lRlshpMgtCmtLine, 14, lToDo.Date, pContactCpy."No.");
            lRlshpMgtCmtLine.Comment := '';
            fUpdateComments(lRlshpMgtCmtLine, 20, lToDo.Date, pContactCpy."No.");
            //Qualification / Suivi
            lRlshpMgtCmtLine.Comment := StrSubstNo(TextCom20, gComQualifSuivi);
            fUpdateComments(lRlshpMgtCmtLine, 21, lToDo.Date, pContactCpy."No.");
            //Action
            lRlshpMgtCmtLine.Comment := StrSubstNo(TextCom21, gComAction);
            fUpdateComments(lRlshpMgtCmtLine, 22, lToDo.Date, pContactCpy."No.");

        end;
    end;


    procedure fUpdateComments(pRlshpMgtCmtLine: Record "Rlshp. Mgt. Comment Line"; pLineNo: Integer; pDate: Date; pContactId: Code[20])
    begin
        pRlshpMgtCmtLine."No." := pContactId;
        pRlshpMgtCmtLine."Line No." := pLineNo;
        pRlshpMgtCmtLine.Date := pDate;
        if not pRlshpMgtCmtLine.Insert(true) then
            pRlshpMgtCmtLine.Modify(true);
    end;


    procedure fInfosMgtPDF(pName: Text[30]; pValue: Text[250]; var pContactCpy: Record Contact temporary; var pContactPer: Record Contact temporary; var pComment: Record "Rlshp. Mgt. Comment Line" temporary)
    var
        lFieldName: Text[30];
        lPos: Integer;
        lField: Record "Field";
        lSizeComment: Integer;
    begin
        //Mise à jour des infos !!! Spécifique PDF !!!
        //PDF : Attention, les attributs sont gérés différements (inverses parfois)
        lSizeComment := MaxStrLen(pComment.Comment);

        //Contact Ste
        case pName of
            'Contact.Salesperson.Code':
                pContactCpy."Salesperson Code" := pValue;
            'Contact.name':
                pContactCpy.Name := pValue;
            'Contact.Address':
                pContactCpy.Address := pValue;
            'Contact.Address.2':
                pContactCpy."Address 2" := pValue;
            'Contact.Post.Code':
                pContactCpy."Post Code" := pValue;
            'Contact.City':
                pContactCpy.City := pValue;
            'Contact.County':
                pContactCpy.County := pValue;
            'Contact.Activite':
                pContactCpy."Job Title" := pValue;
            //'Contact.Effectif' : pContactCpy.County := pValue;
            //'Person.Name' : pContactCpy.County := pValue;
            //'Person.Job.Title' : pContactCpy.County := pValue;
            'Contact.Phone.No':
                pContactCpy."Phone No." := pValue;
            'Person.E-Mail':
                pContactCpy."E-Mail" := pValue;
        end;

        //Contact Personne
        case pName of
            'Contact.Salesperson.Code':
                pContactPer."Salesperson Code" := pValue;
            //'Contact.Name' : pContactPer.Name := pValue;
            'Contact.Address':
                pContactPer.Address := pValue;
            'Contact.Address.2':
                pContactPer."Address 2" := pValue;
            'Contact.Post.Code':
                pContactPer."Post Code" := pValue;
            'Contact.City':
                pContactPer.City := pValue;
            'Contact.County':
                pContactPer.County := pValue;
            //'Contact.Activite' : pContactCpy."Job Title" := pValue;
            //'Contact.Effectif' : pContactCpy.County := pValue;
            'Person.Name':
                pContactPer.Name := pValue;
            //'Person.Job.Title' : pContactCpy.County := pValue;
            'Contact.Phone.No':
                pContactPer."Phone No." := pValue;
            'Person.E-Mail':
                pContactPer."E-Mail" := pValue;
        end;

        //ToDo
        case pName of
            'Date.JJ':
                gDateText := pValue;
            'Date.MM':
                gDateText := gDateText + '/' + pValue;
        end;

        //Commentaires
        case pName of
            //Qualification / Suivi
            'Suivi.A':
                if pValue = '1' then
                    gComQualifSuivi := 'A ' + gComQualifSuivi;
            'Suivi.B':
                if pValue = '1' then
                    gComQualifSuivi := 'B ' + gComQualifSuivi;
            'Suivi.Comment':
                gComQualifSuivi := CopyStr(gComQualifSuivi + pValue, 1, lSizeComment);
            //Suivi.C='EP:Ajouter un test avant l'import pour ne pas créer dns NAV les fiches pour lesquelles 'a suivre' = C (sans intérêt)'
            'Suivi.C':
                if pValue = '1' then
                    gExclure := true;
            //Interet !!! inverse
            'Interet.Comment':
                gComInteret := CopyStr(gComInteret + '. ' + pValue, 1, lSizeComment);
            'Interet.P':
                if pValue = '1' then
                    gComInteret := 'S  ' + gComInteret;
            'Interet.S':
                if pValue = '1' then
                    gComInteret := 'P ' + gComInteret;
            //Projet
            'Projet.True':
                if pValue = '1' then
                    gComProjet := ' Oui ' + gComProjet;
            'Projet.False':
                if pValue = '1' then
                    gComProjet := ' Non ' + gComProjet;
            'Projet.Comment':
                gComProjet := CopyStr(gComProjet + ' Combien : ' + pValue, 1, lSizeComment);
            'Cdc.Comment':
                gComProjet := CopyStr(gComProjet + ' Fonction : ' + pValue, 1, lSizeComment);
            //Cdc
            'Cdc.True':
                if pValue = '1' then
                    gComCdc := ' Oui ' + gComCdc;
            'Cdc.False':
                if pValue = '1' then
                    gComCdc := ' Non ' + gComCdc;
            'Consultation.Comment':
                gComCdc := CopyStr(gComCdc + ' Laquelle : ' + pValue, 1, lSizeComment);
            //Consultation
            'Consultation.True':
                if pValue = '1' then
                    gComConsultation := 'Oui ' + gComConsultation;
            'Consultation.False':
                if pValue = '1' then
                    gComConsultation := 'Non ' + gComConsultation;
            'Consultation.Comment1':
                gComConsultation := CopyStr(gComConsultation + ' Délai : ' + pValue, 1, lSizeComment);
            //Existant
            //'Existant' : gComExistant := COPYSTR(pValue,1,lSizeComment);
            'Existant':
                gComCommentaire := CopyStr(pValue, 1, lSizeComment);
            //Commantaires
            //'Commentaires' : gComCommentaire := COPYSTR(pValue,1,lSizeComment);
            //Action
            'Action.Comment':
                gComAction := CopyStr(gComAction + pValue, 1, lSizeComment);
            'Action.A':
                if pValue = '1' then
                    gComAction := 'Tel ' + gComAction;
            'Action.B':
                if pValue = '1' then
                    gComAction := 'Dist ' + gComAction;
            'Action.C':
                if pValue = '1' then
                    gComAction := 'Rdv ' + gComAction;

        end;
    end;
}

