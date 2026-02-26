Codeunit 8001547 "XML PLanniOne Export Mgt"
{
    //GL2024  ID dans Nav 2009 : "8035000"
    // 24/02/10
    // #7555 OF 28/09/09
    // //AFF PLAN PLANNINGFORCE


    trigger OnRun()
    var
        lXMLRefPlanniOne: Codeunit "XML Ref PlanniOne";
        lXMLTaskPlanniOne: Codeunit "XML Task PlanniOne";
    begin
        //#7555 pour DELETE, remplacé par Execute ................................................................
        /*
        lInitialize(wXmlDoc);
        lCreateHeader(wXmlDoc);
        
        lXMLRefPlanniOne.SetRoles(wXmlDoc,'role',wExportRole,wFilterRole);
        lXMLRefPlanniOne.SetSkills(wXmlDoc,'skill',wExportSkill,wFilterSkill);
        lXMLRefPlanniOne.SetSchedules(wXmlDoc,wExportSchedule,wFilterSchedule);
        lXMLRefPlanniOne.SetResources(wXmlDoc,'resource',wExportRes,wFilterRes);
        //wExportTask
        lXMLTaskPlanniOne.SetFilterTask(wExportTask);
        lXMLTaskPlanniOne.SetTasks(wXmlDoc);
        wXmlDoc.save(wFileName);
        lInitializeSchema(wXmlSchema);
        lInitializeCacheSchema(wXmlDoc,wXmlSchema);
        lValidateXML(wXmlDoc);
        */

    end;


    var
        //GL2024 Automation non compatible    wXmlDoc: Automation;
        AttPFD_schemaVersion: label '1.0';
        "AttPFD_xmlns:xsi": label 'http://www.w3.org/2001/XMLSchema-instance';
        tCalendarName: label '%1''s calendar';
        //GL2024 Automation non compatible   wXmlSchema: Automation;
        //GL2024 Automation non compatible   wXmlCache: Automation;
        wExportRes: Boolean;
        wExportRole: Boolean;
        wExportSkill: Boolean;
        wExportSchedule: Boolean;
        wExportTask: RecordRef;
        wFileName: Text[1024];
        tERRORFIle: label 'You must specify a filename';
        wFilter: Integer;
        wFilterRes: Code[10];
        wFilterRole: Code[10];
        wFilterSkill: Code[10];
        wFilterSchedule: Code[10];
        tERRORSchema: label 'The file is not like the schema waited !';
        wSchemaValide: Boolean;


    procedure Execute(pTaskOnly: Boolean; pAllRef: Boolean)
    var
        //GL2024 Automation non compatible  lXMLDOM6: Automation;
        lXMLRefPlanniOne: Codeunit "XML Ref PlanniOne";
        lXMLTaskPlanniOne: Codeunit "XML Task PlanniOne";
    begin
        //#7555
        /* //GL2024 Automation non compatible lInitialize(wXmlDoc);
          lCreateHeader(wXmlDoc);*/

        // filter on Ref link with tasks
        if pTaskOnly and (not pAllRef) then
            lXMLRefPlanniOne.fSetRefFromTasks(wExportTask, wFilterRole, wFilterSkill, wFilterRes);

        /* //GL2024 Automation non compatible lXMLRefPlanniOne.SetRoles(wXmlDoc, 'role', wExportRole, wFilterRole);
          lXMLRefPlanniOne.SetSkills(wXmlDoc, 'skill', wExportSkill, wFilterSkill);
          lXMLRefPlanniOne.SetSchedules(wXmlDoc, wExportSchedule, wFilterSchedule);
          lXMLRefPlanniOne.SetResources(wXmlDoc, 'resource', wExportRes, wFilterRes);

          if pTaskOnly then begin
              lXMLTaskPlanniOne.SetFilterTask(wExportTask);
              lXMLTaskPlanniOne.SetTasks(wXmlDoc);
          end
          else
              lXMLTaskPlanniOne.SetEmptyTask(wXmlDoc);

          wXmlDoc.save(wFileName);*/
        //fValidateXMLDocument(wXmlDoc);
        //GL2024 Automation non compatible fValidateXMLWithSchema();
    end;


    procedure SetExportRef(pExportRes: Boolean; pExportRole: Boolean; pExportSkill: Boolean; pExportSchedule: Boolean)
    begin
        wExportRes := pExportRes;
        wExportRole := pExportRole;
        wExportSkill := pExportSkill;
        wExportSchedule := pExportSchedule;
    end;


    procedure SetExportTask(pExportTask: RecordRef)
    begin
        wExportTask := pExportTask.Duplicate
    end;


    procedure SetExportFile(pFileName: Text[1024])
    begin
        wFileName := pFileName;
        if wFileName = '' then
            Error(tERRORFIle)
    end;

    /*//GL2024 Automation non compatible
      local procedure lInitialize(var pXmlDoc: Automation)
      var
          lXmlNode: Automation;
      begin
          if not ISCLEAR(pXmlDoc) then
              Clear(pXmlDoc);
          Create(pXmlDoc);
          pXmlDoc.async := false;
          pXmlDoc.validateOnParse := true;

          pXmlDoc.setProperty('SelectionLanguage', 'XPath');

          // Genere l'entete du document
          lXmlNode := pXmlDoc.createProcessingInstruction('xml', 'version="1.0"  encoding="UTF-8"');
          pXmlDoc.insertBefore(lXmlNode, pXmlDoc.childNodes.item(0));
      end;

      local procedure lValidateXML(var pXmlDoc: Automation)
      var
          lXmlParseError: Automation;
      begin
          //plus utilisé
          lXmlParseError := pXmlDoc.validate;
          if lXmlParseError.errorCode <> 0 then
              Message('Code Erreur : %1\URL : %2\ reason : %3\srcText : %4\ Line : %5\ LinePos : %6\Filepos : %7',
                       lXmlParseError.errorCode,
                       lXmlParseError.url,
                       lXmlParseError.reason,
                       lXmlParseError.srcText,
                       lXmlParseError.line,
                       lXmlParseError.linepos,
                       lXmlParseError.filepos);
      end;

      local procedure lInitializeSchema(var pXmlDoc: Automation)
      var
          lSchemaLoc: Text[250];
      begin
          //plus utilisé
          if not ISCLEAR(pXmlDoc) then
              Clear(pXmlDoc);
          Create(pXmlDoc);
          pXmlDoc.async := false;
          pXmlDoc.validateOnParse := true;

          pXmlDoc.setProperty('SelectionLanguage', 'XPath');
          // Genere l'entete du document
          //pXmlDoc.load('D:\Gesway\pf_schema3.xsd');
          //lSchemaLoc := lPlanningSetup.PlanningProjetSchema;
          pXmlDoc.load(lSchemaLoc);
      end;

      local procedure lInitializeCacheSchema(var pXmlDoc: Automation; var pXmlShema: Automation)
      var
          lNameSpace: Text[250];
          lSchemaLoc: Text[250];
      begin
          //plus utilisé
          if not ISCLEAR(wXmlCache) then
              Clear(wXmlCache);
          Create(wXmlCache);
          lNameSpace := '';
          //wXmlCache.add(lNameSpace, pXmlShema);
          //wXmlCache.add(lNameSpace, 'D:\Gesway\pf_schema3.xsd');
          //lSchemaLoc := lPlanningSetup.PlanningProjetSchema;
          wXmlCache.add(lNameSpace, 'O:\Planification\PF_import_schema4855.xsd');
          pXmlDoc.schemas(wXmlCache);
      end;

      local procedure lCreateHeader(var pXmlDoc: Automation)
      var
          lXmlNode: Automation;
          lPlanningSetup: Record 8004133;
      begin
          lXmlNode := pXmlDoc.createElement('planning-force-data');
          //ajout des attributs
          lAddAttribute(lXmlNode, 'schemaVersion', AttPFD_schemaVersion);
          lAddAttribute(lXmlNode, 'xmlns:xsi', "AttPFD_xmlns:xsi");
          //24/02/10
          //lAddAttribute(lXmlNode,'xsi:noNamespaceSchemaLocation',lPlanningSetup.PlanningProjetSchema;);
          //24/02/10//
          lPlanningSetup.Get;
          lAddAttribute(lXmlNode, 'xsi:noNamespaceSchemaLocation', lPlanningSetup.PlanningProjetSchema);
          //ajout du noeud
          pXmlDoc.appendChild(lXmlNode);
      end;

      local procedure lAddAttribute(var pXMLNode: Automation; pName: Text[260]; pNodeValue: Text[260]) ExitStatus: Integer
      var
          lXMLNewAttributeNode: Automation;
          lChar: Char;
      begin
          lXMLNewAttributeNode := pXMLNode.ownerDocument.createAttribute(pName);

          if pName = 'id' then
              pNodeValue := DelChr(pNodeValue, '=', ' ');

          if ISCLEAR(lXMLNewAttributeNode) then begin
              ExitStatus := 60;
              exit(ExitStatus)
          end;

          if pNodeValue <> '' then
              lXMLNewAttributeNode.nodeValue := pNodeValue;

          pXMLNode.attributes.setNamedItem(lXMLNewAttributeNode);
      end;

  */
    procedure SetExportFilter(pExportRes: Code[10]; pExportRole: Code[10]; pExportSkill: Code[10]; pExportSchedule: Code[10])
    begin
        wFilterRes := pExportRes;
        wFilterRole := pExportRole;
        wFilterSkill := pExportSkill;
        wFilterSchedule := pExportSchedule;
    end;


    procedure lFormatValue(pText: Text[250]) pReturn: Text[250]
    var
        lFromCharReplace: Text[30];
        lToCharReplace: Text[30];
    begin
        lFromCharReplace := 'àäâÄÂéèëêËÊîïÏÎöôÖÔùüûÜÛ';
        lToCharReplace := 'aaaAAeeeeEEiiIIooOOuuuUU';
        pReturn := ConvertStr(pText, lFromCharReplace, lToCharReplace);
    end;


    procedure fFormatDecimal(pValue: Text[30]) pReturn: Text[10]
    var
        lGeneralLedgerSetup: Record "General Ledger Setup";
        lDecimalSeparator: Text[1];
    begin
        pValue := CopyStr(pValue, 1, 10);
        lGeneralLedgerSetup.Get;
        if StrPos(Format(lGeneralLedgerSetup."Amount Rounding Precision"), ',') <> 0 then
            pReturn := ConvertStr(pValue, ',', '.')
        else
            pReturn := pValue;
    end;


    procedure fFormatID(pValueID: Text[50]) pReturn: Text[50]
    var
        lFromCharReplace: Text[30];
        lToCharReplace: Text[30];
    begin
        lFromCharReplace := ':,_';
        lToCharReplace := '---';
        pReturn := ConvertStr(pValueID, lFromCharReplace, lToCharReplace);
    end;


    /* //GL2024 Automation non compatible
    procedure fValidateXMLDocument(xmldom: Automation): Boolean
     var
         "Schema": Automation;
         ReceiveXMLDocument: Codeunit 99008515;
         xmlSchemaCache: Automation;
         XMLDOMDocument: Automation;
         XMLSchema: Automation;
         lOk: Boolean;
     begin*/
    // ne fonctionne pas !!!
    /*
    //IF ISCLEAR(xmlschema) THEN
    CLEAR(XMLSchema);
    CLEAR(xmlSchemaCache);
    CLEAR(Schema);
    CLEAR(XMLDOMDocument);
    //CREATE(xmlschema,TRUE,FALSE);

    //CREATE(xmlSchemaCache,TRUE,FALSE);
    //CREATE(Schema,TRUE,FALSE);
    XMLSchema.save(Schema);
    //NAVISION
    //xmlSchemaCache.add('',Schema);
    //xmlSchemaCache.add(Schema.namespaceURI,Schema);
    xmlSchemaCache.add('',Schema);
    xmlSchemaCache.add(Schema.namespaceURI,'O:\Planification\PF_import_schema4855.xsd');
    //NAVISION//
    //CREATE(XMLDOMDocument,TRUE,FALSE);

    XMLDOMDocument.async := FALSE;
    XMLDOMDocument.schemas := xmlSchemaCache;
    IF XMLDOMDocument.load(xmldom) THEN
      EXIT(TRUE)
    ELSE
      EXIT(FALSE);
    */

    /* end;*/

    /*//GL2024 Automation non compatible
        procedure fValidateXMLWithSchema()
        var
            xmlSchema: Automation;
            xmlSchemaCache: Automation;
            xmlDocumentTmp: Automation;
            XMLParseError: Automation;
            lSchemaLoc: Text[250];
            lPlanningSetup: Record 8004133;
        begin
            //http://dynamicsuser.net/forums/t/15045.aspx#
            lPlanningSetup.Get;
            wSchemaValide := true;

            Create(xmlSchemaCache);
            lSchemaLoc := lPlanningSetup.PlanningProjetSchema;
            xmlSchemaCache.add('', lSchemaLoc);

            Create(xmlDocumentTmp);
            xmlDocumentTmp.async := false;
            xmlDocumentTmp.schemas := xmlSchemaCache;

            if not xmlDocumentTmp.load(wFileName) then begin
                XMLParseError := xmlDocumentTmp.parseError;
                if XMLParseError.errorCode <> 0 then begin
                    //MESSAGE('Error validating via XSD\\Reason: ' + XMLParseError.reason + '\Line: ' +
                    //    FORMAT(XMLParseError.line) +' ' );
                    Message(tERRORSchema + '\\Prb: ' + XMLParseError.reason + '\Line: ' +
                        Format(XMLParseError.line) + ' ');
                    wSchemaValide := false;
                end;
                /*
                XmlParseError := xmlDocumentTmp.validate;
                IF XmlParseError.errorCode <> 0 THEN
                  MESSAGE('Code Erreur : %1\URL : %2\ reason : %3\srcText : %4\ Line : %5\ LinePos : %6\Filepos : %7',
                           XmlParseError.errorCode,
                           XmlParseError.url,
                           XmlParseError.reason,
                           XmlParseError.srcText,
                           XmlParseError.line,
                           XmlParseError.linepos,
                           XmlParseError.filepos);
                */
    /* //GL2024 Automation non compatible end;

  end;*/


    procedure fSchemaValide(): Boolean
    begin
        exit(wSchemaValide);
    end;
}

