Codeunit 8001446 "BOQ Management"
{
    // //#6592 Mise
    // //#6592 Ajout
    // //#6592 Suppression

    trigger OnRun()
    begin
    end;

    var
        //GL2024 Automation non compatible   wXmlDoc: Automation;
        //GL2024 Automation non compatible    wXmlNode: Automation;
        //GL2024 Automation non compatible   wXmlNodeList: Automation;
        //GL2024 Automation non compatible  wXmlRoot: Automation;
        wHasHeader: Boolean;
        Text001: label 'The document has been alreydy a Header';
        //GL2024 Automation non compatible     wXMLAttribute: Automation;
        wBoqLineType: Option Constant,Reference,Formula,Result;
        //GL2024 Automation non compatible   wXmlCurNode: Automation;
        Text002: label 'You must add a Header';
        wSingleInstance: Codeunit "Import SingleInstance2";
        //GL2024 Automation non compatible   wXmlDoc2: Automation;
        tQRY_GetBOQ: label '</Node[@RecordID=''%1'']/BOQs/Variable>';
        BOQNotDefined: Integer;
        BOQOnlyVariable: Integer;
        BOQWithResult: Integer;
        BOQWithError: Integer;
        tEncodingChar: label '#';
        tDecodingChar: label ' ';
        wToSeparator: Text[1];
        wFromSeparator: Text[1];
        wBOQDocXml: Record "BOQ Doc Xml Format";
        wEntryNo: Integer;


    procedure Initialize()
    begin
        /***********************************************
        *                     Initialize              *
        ***********************************************
        * Entrée : Néant                              *
        * Sortie : Néant                              *
        ***********************************************
        * Initialize l'ensemble de la structure       *
        * documentaire                                *
        ***********************************************/
        wHasHeader := false;
        fConstInitialize();

        /*  //GL2024 Automation non compatible if not ISCLEAR(wXmlDoc) then
              Clear(wXmlDoc);
          Create(wXmlDoc);
          //CREATE(wXmlNode);
          wXmlDoc.setProperty('SelectionLanguage', 'XPath');
          // Genere l'entete du document
          //wXmlNode := wXmlDoc.createProcessingInstruction('xml', 'version="1.0"');
          //wXmlDoc.insertBefore(wXmlNode, wXmlDoc.childNodes.item(0));
          wXmlNode := wXmlDoc.createElement('Document');
          wXmlDoc.appendChild(wXmlNode);
          wXmlRoot := wXmlDoc.documentElement;*/
        fSaveSingleInstance();

    end;


    procedure AddHeader(pRecordID: RecordID)
    var
    //GL2024 Automation non compatible  lNamedNodeMap: Automation;
    begin
        /***********************************************
        *                    AddHeader                *
        ***********************************************
        * Entrée : RecordID                           *
        * Sortie : Néant                              *
        ***********************************************
        * Ajoute un en-tête au document XML, ayant    *
        * comme RecordID, la valeur passée en prm     *
        ***********************************************/
        fSetDefaultNode();
        // Attention : on ajoute un en-tête ssi, il n'existe pas
        /*  //GL2024 Automation non compatible if (not wHasHeader) then begin
              wXmlNode := wXmlDoc.createElement('Node');
              wXMLAttribute := wXmlDoc.createAttribute('RecordID');
              wXMLAttribute.value := Format(pRecordID);
              lNamedNodeMap := wXmlNode.attributes;
              lNamedNodeMap.setNamedItem(wXMLAttribute);
              wXmlRoot := wXmlDoc.documentElement;
              wXmlRoot.appendChild(wXmlNode);
              wXmlRoot := wXmlNode;
              // Ajout de la balise BOQs et NODES
              wXmlNode := wXmlDoc.createElement('BOQs');
              wXMLAttribute := wXmlDoc.createAttribute('Value');
              lNamedNodeMap := wXmlNode.attributes;
              lNamedNodeMap.setNamedItem(wXMLAttribute);
              wXmlRoot.appendChild(wXmlNode);

              wXmlNode := wXmlDoc.createElement('NODES');
              wXmlRoot.appendChild(wXmlNode);

              wHasHeader := true;

              wXmlRoot := wXmlDoc.documentElement;
              fSaveSingleInstance();
          end else begin
              Error(Text001);
          end;*/

    end;


    procedure SetCurrentNode(pRecordID: RecordID) Return: Boolean
    begin
        /***********************************************
        *                SetCurrentNode               *
        ***********************************************
        * Entrée : RecordID                           *
        * Sortie : Néant                              *
        ***********************************************
        * Affecte comme noeud courant, le noeud       *
        * comportant comme recordID, la valeur passée *
        * en parametre                                *
        ***********************************************/
        fSetDefaultNode();
        //GL2024 Automation non compatible   wXmlCurNode := wXmlRoot.selectSingleNode('//Node[@RecordID=''' + Format(pRecordID) + ''']');
        //GL2024 Automation non compatible  Return := not (ISCLEAR(wXmlCurNode));

    end;

    /*//GL2024 Automation non compatible
        procedure SetAttribut(var pNamedNodeMap: Automation; var pXMLAttribute: Automation; pName: Text[80]; Pvalue: Text[255])
        begin

          //GL2024 Automation non compatible   pXMLAttribute := wXmlDoc.createAttribute(pName);
         //GL2024 Automation non compatible    pXMLAttribute.value := Pvalue;
            pNamedNodeMap.setNamedItem(pXMLAttribute);

        end;*/


    procedure AddBoqLine(pBOQ: Record "BOQ Line")
    var
        //GL2024 Automation non compatible   lNamedNodeMap: Automation;
        lBoqLineType: Option Constant,Reference,Formula,Result,"Not Defined";
    begin
        /***********************************************
        *                     AddBoqLine              *
        ***********************************************
        * Entrée : table ligne de metre               *
        * Sortie : Néant                              *
        ***********************************************
        * Ajoute une nouvelle ligne de metre dans le  *
        * Noeud courant                               *
        * Remarque : si la ligne n'est pas de type    *
        * Reference, le parametre pFieldNo est egale  *
        * à -1                                        *
        ***********************************************/
        fSetDefaultNode();
        /* //GL2024 Automation non compatible     wXmlNode := wXmlDoc.createElement('Variable');
             lNamedNodeMap := wXmlNode.attributes;

             //désignation
             wXMLAttribute := wXmlDoc.createAttribute('Description');
             wXMLAttribute.value := pBOQ.Description;
             lNamedNodeMap.setNamedItem(wXMLAttribute);

             //Type
             if (pBOQ."Variable Code" <> '') then begin
                 SetAttribut(lNamedNodeMap, wXMLAttribute, 'ID', pBOQ."Variable Code");
                 if pBOQ."Field No." <> 0 then begin
                     SetAttribut(lNamedNodeMap, wXMLAttribute, 'Type', 'REF');
                     SetAttribut(lNamedNodeMap, wXMLAttribute, 'Field', Format(pBOQ."Field No."));
                     SetAttribut(lNamedNodeMap, wXMLAttribute, 'Value', Format(pBOQ."Field No."));
                     wXmlNode.text := Format(pBOQ.Value);
                 end else
                     if (pBOQ.Formula <> '') then begin
                         SetAttribut(lNamedNodeMap, wXMLAttribute, 'Type', 'FORMULA');
                         SetAttribut(lNamedNodeMap, wXMLAttribute, 'Value', Format(pBOQ.Value));
                         wXmlNode.text := pBOQ.Formula;
                     end else
                         if pBOQ.Value <> 0 then begin
                             SetAttribut(lNamedNodeMap, wXMLAttribute, 'Type', 'CST');
                             wXmlNode.text := Format(pBOQ.Value);
                         end else begin
                             //#6872
                             SetAttribut(lNamedNodeMap, wXMLAttribute, 'Type', 'CST');
                             //#6872//
                         end;
             end else begin
                 SetAttribut(lNamedNodeMap, wXMLAttribute, 'ID', '');
                 if pBOQ.Formula <> '' then begin
                     SetAttribut(lNamedNodeMap, wXMLAttribute, 'Type', 'RESULT');
                     SetAttribut(lNamedNodeMap, wXMLAttribute, 'Value', Format(pBOQ.Value));
                     wXmlNode.text := pBOQ.Formula;
                 end else begin
                     SetAttribut(lNamedNodeMap, wXMLAttribute, 'Type', 'CST');
                     wXmlNode.text := Format(pBOQ.Value);
                 end;
             end;
             //#6872
             // ajout des attribut Value et Error
             //#7687
             if (pBOQ.Problem) then
                 SetAttribut(lNamedNodeMap, wXMLAttribute, 'Error', fCase('TRUE', true, true))
             else
                 SetAttribut(lNamedNodeMap, wXMLAttribute, 'Error', fCase('FALSE', true, true));
             //#7687//
             //#6872//
             wXmlCurNode.childNodes.item(0).appendChild(wXmlNode);*/
        fSaveSingleInstance();

    end;


    procedure Save(pFilename: Text[250])
    var
        lRecID: RecordID;
        lOutStream: OutStream;
        lEntryNo: Integer;
        lOK: Boolean;
        //GL2024 Automation non compatible    lNamedNodeMap: Automation;
        lXmlBigText: BigText;
        lSingleImport: Codeunit "Import SingleInstance2";
    begin
        /***********************************************
        *                     Save                    *
        ***********************************************
        * Entrée : Nom du fichier incluant le chemin  *
        * Sortie : Néant                              *
        ***********************************************
        * Enregistrement le document XML dans la table*
        * de stockage des BOQ                         *
        ***********************************************/
        fSetDefaultNode();
        /*
        IF wEntryNo = 0 THEN
          lOK := fgetEntryNo(wXmlRoot.childNodes.item(0),wEntryNo)
        ELSE
          lOK := TRUE;
        */
        //#9194
        /*  //GL2024 Automation non compatible  if (not fISEmpty(wXmlRoot)) then begin
               //#9194//
               if not lOK then begin
                   fgetRecordID(wXmlRoot.childNodes.item(0), lRecID);
                   wBOQDocXml.Reset;
                   wBOQDocXml.SetCurrentkey(RecordID);
                   //#8984
                   if (lSingleImport.fGetDatabaseType() = 'SQL') then begin
                       wBOQDocXml.SetRange(RecordID, lRecID);
                   end else begin
                       wBOQDocXml.SetFilter(wBOQDocXml.RecordID, StrSubstNo('=%1', Format(lRecID)));
                   end;
                   //#8984//
                   //wBOQDocXml.SETFILTER(RecordID,FORMAT(wXmlRoot.childNodes.item(0).attributes.getNamedItem('RecordID').nodeValue));
                   if not wBOQDocXml.FindFirst then begin
                       wBOQDocXml.Reset;
                       if wBOQDocXml.FindLast then
                           lEntryNo := wBOQDocXml.EntryNo;
                       wBOQDocXml.Init;
                       wBOQDocXml.EntryNo := lEntryNo + 1;
                       wBOQDocXml.RecordID := lRecID;
                       wBOQDocXml.Insert(true);
                   end;
                   wEntryNo := wBOQDocXml.EntryNo;
                   lNamedNodeMap := wXmlRoot.childNodes.item(0).attributes;
                   wXMLAttribute := wXmlDoc.createAttribute('EntryNo');
                   wXMLAttribute.value := Format(wBOQDocXml.EntryNo);
                   lNamedNodeMap.setNamedItem(wXMLAttribute);
                   fSaveSingleInstance();
               end else
                   wBOQDocXml.Get(wEntryNo);

               Clear(wBOQDocXml.BOQXML);
               //#8626
               if (not ISSERVICETIER) then begin
                   wBOQDocXml.CalcFields(BOQXML);
                   wBOQDocXml.BOQXML.CreateOutstream(lOutStream);
                   wXmlDoc.save(lOutStream);
               end else begin
                   wBOQDocXml.CalcFields(BOQXML);
                   wBOQDocXml.BOQXML.CreateOutstream(lOutStream);
                   Clear(lXmlBigText);
                   lXmlBigText.AddText(wXmlDoc.xml);
                   //MESSAGE('%1', lXmlBigText);
                   lXmlBigText.Write(lOutStream);
               end;
               //#8626//
               wBOQDocXml.Modify;
               //  wXmlDoc.save('C:\test.xml');
               //#9194
           end;
           //#9194//
           if pFilename <> '' then
               wXmlDoc.save(pFilename);*/

    end;


    procedure Load(pRecordID: RecordID) return: Boolean
    var
        lRecordID: RecordID;
    //GL2024 Automation non compatible  lNamedNodeMap: Automation;
    //GL2024 Automation non compatible  lXMLAttribute: Automation;
    //GL2024 Automation non compatible  lXmlNode: Automation;
    begin
        /***********************************************
        *                     Load                    *
        ***********************************************
        * Entrée : Néant                              *
        * Sortie : Néant                              *
        ***********************************************
        * Charge le document XML à partir de la table *
        * de stockage des BOQ                         *
        ***********************************************/
        //#6872
        fSetDefaultNode();
        //#6872//
        /*   //GL2024 Automation non compatible  return := not ISCLEAR(wXmlRoot);
            if return then begin
                lXmlNode := wXmlRoot.selectSingleNode('//Node');
                if (not ISCLEAR(lXmlNode)) then begin
                    lNamedNodeMap := lXmlNode.attributes;
                    lXMLAttribute := lNamedNodeMap.getNamedItem('RecordID');
                end;
                return := not ISCLEAR(lXMLAttribute);
                if return then
                    if (Evaluate(lRecordID, Format(lXMLAttribute.nodeValue))) then
                        return := (Format(lRecordID) = Format(pRecordID))
                    else
                        return := false;
            end;
            if not return then begin
                fConstInitialize();
                return := fLoadXMLDom(wXmlDoc, pRecordID);
                if return then begin
                    fSaveSingleInstance();
                    wXmlDoc.setProperty('SelectionLanguage', 'XPath');
                    wXmlRoot := wXmlDoc.documentElement;
                end;
            end;
            wHasHeader := return;*/

    end;


    procedure AddLine(pRecordID: RecordID)
    var
        //GL2024 Automation non compatible  lNamedNodeMap: Automation;
        lRecID: RecordID;
    begin
        /***********************************************
        *                  AddLine                    *
        ***********************************************
        * Entrée : RecordID de l'enregistrement       *
        * Sortie : Néant                              *
        ***********************************************
        * Ajout au noeud courant une nouvelle ligne   *
        * dans le document                            *
        * A la suite de ce processus le noeud courant *
        * Est le noeud nouvellement créé              *
        ***********************************************/
        // Attention, pour ajouter une ligne, il est necessaire d'avoir tout d'abord un en-tête
        fSetDefaultNode();
        /*  //GL2024 Automation non compatible if (wHasHeader) then begin
              if (not gNodeExist(pRecordID)) then begin
                  wXmlNode := wXmlDoc.createElement('Node');
                  wXMLAttribute := wXmlDoc.createAttribute('RecordID');
                  wXMLAttribute.value := Format(pRecordID);
                  lNamedNodeMap := wXmlNode.attributes;
                  lNamedNodeMap.setNamedItem(wXMLAttribute);
                  wXmlCurNode.childNodes.item(1).appendChild(wXmlNode);
                  wXmlCurNode := wXmlNode;
                  // Ajout de la balise BOQs et NODES
                  wXmlNode := wXmlDoc.createElement('BOQs');
                  wXMLAttribute := wXmlDoc.createAttribute('Value');
                  lNamedNodeMap := wXmlNode.attributes;
                  lNamedNodeMap.setNamedItem(wXMLAttribute);
                  wXmlCurNode.appendChild(wXmlNode);
                  wXmlNode := wXmlDoc.createElement('NODES');
                  wXmlCurNode.appendChild(wXmlNode);
              end;
          end else
              Error(Text002);*/

        fSaveSingleInstance();

    end;


    procedure GetAncestor(pRecordID: RecordID)
    begin
        /***********************************************
        *                  GetAncestor                *
        ***********************************************
        * Entrée : Néant                              *
        * Sortie : Néant                              *
        ***********************************************
        * Fait du noeud courant, l'ancestre du noeud  *
        * courant actuel                              *
        ***********************************************/
        fSetDefaultNode();
        //GL2024 Automation non compatible   wXmlCurNode := wXmlRoot.selectSingleNode('//Node[@RecordID=''' + Format(pRecordID) + ''']');
        //GL2024 Automation non compatible wXmlCurNode := wXmlCurNode.parentNode;
        //GL2024 Automation non compatible  wXmlCurNode := wXmlCurNode.parentNode;

    end;


    procedure GetDescendant(pRecordID: RecordID)
    begin
        /***********************************************
        *                  GetDescendant              *
        ***********************************************
        * Entrée : Néant                              *
        * Sortie : Néant                              *
        ***********************************************
        * Fait du noeud courant, le descendant du     *
        * noeud courant actuel                        *
        ***********************************************/
        fSetDefaultNode();
        //GL2024 Automation non compatible  wXmlCurNode := wXmlRoot.selectSingleNode('//Node[@RecordID=''' + Format(pRecordID) + ''']/descendant::Node');

    end;


    procedure GetPreviousNode(pRecordID: RecordID)
    var
        lQuery: Text[255];
    begin
        /***********************************************
        *                GetPreviousNode              *
        ***********************************************
        * Entrée : Néant                              *
        * Sortie : Néant                              *
        ***********************************************
        * Selectionne le noeud precedent comme noeud  *
        * courant, quelque soit la hierarchie         *
        ***********************************************/
        fSetDefaultNode();
        lQuery := '//Node[@RecordID=''' + Format(pRecordID) + ''']/preceding::Node[last()]' +
                  '|preceding-sibling::Node[Last()]|/ancestor::Node[last()]';
        //GL2024 Automation non compatible  wXmlCurNode := wXmlRoot.selectSingleNode(lQuery);

    end;


    procedure GetNextNode(pRecordID: RecordID)
    begin
        /***********************************************
        *                  GetNextNode                *
        ***********************************************
        * Entrée : Néant                              *
        * Sortie : Néant                              *
        ***********************************************
        * Selectionne le noeud suivant comme noeud    *
        * courant, quelque soit la hierarchie         *
        ***********************************************/
        fSetDefaultNode();
        //GL2024 Automation non compatible wXmlCurNode := wXmlCurNode.selectSingleNode(
        //GL2024 Automation non compatible  '//Node[@RecordID=''' + Format(pRecordID) + ''']/following::Node|following-sibling::Node|/descendant::Node');

    end;


    procedure Finalize()
    begin
        /***********************************************
        *                   Finalize                  *
        ***********************************************
        * Entrée : Néant                              *
        * Sortie : Néant                              *
        ***********************************************
        * "detruit" l'ensemble de la structure        *
        * documentaire et initialise le codeunit      *
        * en single instance qui stocke le fichier XML*
        ***********************************************/
        wHasHeader := false;
        //GL2024 Automation non compatible  Clear(wXmlDoc);
        //GL2024 Automation non compatible  Clear(wXmlNode);
        //GL2024 Automation non compatible   Clear(wXmlRoot);
        //GL2024 Automation non compatible   Clear(wXMLAttribute);
        //GL2024 Automation non compatible   Clear(wXmlCurNode);
        //GL2024 Automation non compatible   wSingleInstance.ClearXmlDoc;

    end;


    procedure GetBillOfQuantity(pRecordID: RecordID; var pBillOfQuantity: Record "BOQ Line")
    var
        //GL2024 Automation non compatible   lXmlNode: Automation;
        //GL2024 Automation non compatible  lListXmlNode: Automation;
        lIndex: Integer;
        lQuery: Text[255];
        lLevel: Integer;
    begin
        /***********************************************
        *               GetBillOfQuantity             *
        ***********************************************
        * Entrée : RecordID du noeud                  *
        * Sortie : Ensemble de métré                  *
        ***********************************************
        * Obtient la liste des métrés du RecordID     *
        * passé en parametre                          *
        ***********************************************/
        fSetDefaultNode();
        //#6872
        lLevel := 1;
        lQuery := '//Node[@RecordID="' + Format(pRecordID) + '"]/ancestor::Node'
                + '|//Node[@RecordID=''' + Format(pRecordID) + ''']/BOQs/Variable';
        //#6872//
        /* //GL2024 Automation non compatible lListXmlNode := wXmlRoot.selectNodes(lQuery);
         for lIndex := 0 to lListXmlNode.length() - 1 do begin
             lXmlNode := lListXmlNode.nextNode();
             //#6872
             if (lXmlNode.nodeName = 'Node') then begin
                 lLevel := lLevel + 1;
             end else begin
                 fAddBOQ(pBillOfQuantity, lXmlNode, pRecordID, lLevel);
             end;
             //#6872//
         end;*/

    end;


    /*
    //GL2024 Automation non compatible
      procedure fAddBOQ(var pBOQ: Record 8001434; pXmlNode: Automation; pREcordID: RecordID; pLevel: Integer)
      var
        //GL2024 Automation non compatible   lNamedNodeMap: Automation;
         //GL2024 Automation non compatible  lXMLAttribute: Automation;
          lBoqLineType: Option Constant,Reference,Formula,Result,"Not Defined";
          lEntryNo: Integer;
      begin

          fSetDefaultNode();
          lEntryNo := pBOQ."Entry No.";
          pBOQ.Init();
          pBOQ."Entry No." := lEntryNo + 10000;
          //#6872
          pBOQ.Level := pLevel;
          pBOQ.Substituted := false;
          //#6872//
          pBOQ.RecordID := pREcordID;

          //GL2024 Automation non compatible lNamedNodeMap := pXmlNode.attributes;

        //GL2024 Automation non compatible   lXMLAttribute := lNamedNodeMap.getNamedItem('Type');
       /* //GL2024 Automation non compatible   if not ISCLEAR(lXMLAttribute) then
              case Format(lXMLAttribute.value) of
                  'CST':
                      lBoqLineType := Lboqlinetype::Constant;
                  'REF':
                      lBoqLineType := Lboqlinetype::Reference;
                  'FORMULA':
                      lBoqLineType := Lboqlinetype::Formula;
                  'RESULT':
                      lBoqLineType := Lboqlinetype::Result;
                  else
                      lBoqLineType := Lboqlinetype::"Not Defined";
              end
          else
              lBoqLineType := Lboqlinetype::"Not Defined";

          //CLEAR(lXMLAttribute);
          lXMLAttribute := lNamedNodeMap.getNamedItem('ID');
          if not ISCLEAR(lXMLAttribute) then
              pBOQ."Variable Code" := lXMLAttribute.value;

          //Error
          //CLEAR(lXMLAttribute);
          lXMLAttribute := lNamedNodeMap.getNamedItem('Error');
          //#6872
          if not ISCLEAR(lXMLAttribute) then begin
              pBOQ.Problem := (UpperCase(Format(lXMLAttribute.value)) = 'TRUE');
          end;
          //#6872//
          //désignation
          //CLEAR(lXMLAttribute);
          lXMLAttribute := lNamedNodeMap.getNamedItem('Description');
          if not ISCLEAR(lXMLAttribute) then
              pBOQ.Description := lXMLAttribute.value;

          case lBoqLineType of
              Lboqlinetype::Constant:
                  if pXmlNode.text <> '' then
                      pBOQ.Value := fVarToDec(pXmlNode.text);

              Lboqlinetype::Reference:
                  begin
                      Clear(lXMLAttribute);
                      lXMLAttribute := lNamedNodeMap.getNamedItem('Field');
                      if Evaluate(pBOQ."Field No.", Format(lXMLAttribute.value)) then;
                  end;
              Lboqlinetype::Formula, Lboqlinetype::Result:
                  begin
                      //#7134
                      pBOQ.Formula := fTransformFormula(pXmlNode.text);
                      //pBOQ.Formula := pXmlNode.text;
                      //#7134//
                      Clear(lXMLAttribute);
                      lXMLAttribute := lNamedNodeMap.getNamedItem('Value');
                      if not ISCLEAR(lXMLAttribute) then
                          if Format(lXMLAttribute.value) <> '' then
                              if Evaluate(pBOQ.Value, Format(lXMLAttribute.value)) then;
                  end;
              else
                  pBOQ.Undefined := true
          end;
          // Gestion de l'infefinition
          pBOQ.fVerifyUndefinied();
          pBOQ.Insert();
          //#6872
          // Il faut certainement substituer les variables parentes
          fSubstituteVariable(pBOQ, pBOQ."Variable Code", pBOQ.Level);
          //#6872//

      end;*/


    procedure HasBillOfQuantity(pRecordID: RecordID) Retour: Boolean
    var
    //GL2024 Automation non compatible  lXmlNodes: Automation;
    begin
        /***********************************************
        *              HasBillOfQuantity              *
        ***********************************************
        * Entrée : RecordID                           *
        * Sortie : Booleen                            *
        ***********************************************
        * Renvoi VRAI, si le Noeud dont le RecordID   *
        * est passé en parametre possède un métré,    *
        * Faux sinon                                  *
        ***********************************************/
        fSetDefaultNode();
        //GL2024 Automation non compatible    lXmlNodes := wXmlRoot.selectNodes('//Node[@RecordID=''' + Format(pRecordID) + ''']/Variable');
        //GL2024 Automation non compatible   Retour := lXmlNodes.length <> 0;

    end;


    procedure AppendNodeAt(pFromRecordID: RecordID; pToRecordID: RecordID)
    begin
        /***********************************************
        *                     AppendNodeAt            *
        ***********************************************
        * Entrée : RecordID Source                    *
        *        : RecordID Destination               *
        * Sortie : Néant                              *
        ***********************************************
        * Ajoute en tant que fils le noeud referencé  *
        * par ToRecordID au noeud referencé par       *
        * FromRecordID                                *
        ***********************************************/
        fSetDefaultNode();
        if (SetCurrentNode(pFromRecordID)) then
            AddLine(pToRecordID);

    end;


    procedure RenameNodeAt(pRecordID: RecordID; pxRecordID: RecordID)
    var
    //GL2024 Automation non compatible lNamedNodeMap: Automation;
    //GL2024 Automation non compatible  lXMLAttribute: Automation;
    begin
        /***********************************************
        *                     RenameNodeAt            *
        ***********************************************
        * Entrée : RecordID Source                    *
        *        : RecordID Destination               *
        * Sortie : Néant                              *
        ***********************************************
        * Renomme un noeud referencé                  *
        ***********************************************/
        //#6889
        fSetDefaultNode();
        /*   //GL2024 Automation non compatible if (SetCurrentNode(pxRecordID)) then begin
               // recherche de l'attribut RecordID
               lNamedNodeMap := wXmlCurNode.attributes;
               lXMLAttribute := lNamedNodeMap.getNamedItem('RecordID');
               lXMLAttribute.value := Format(pRecordID);
           end;*/
        //#6889//

    end;

    local procedure fSetDefaultNode()
    begin
        /***********************************************
        *               fSetDefaultNode()             *
        ***********************************************
        * Entrée : Néant                              *
        * Sortie : Néant                              *
        ***********************************************
        *  Charge une instance de la variable wXmlDoc *
        ***********************************************/
        /*  //GL2024 Automation non compatible wSingleInstance.GetXmlDoc(wXmlDoc);
          if ISCLEAR(wXmlDoc) then
              Initialize
          else begin
              wXmlDoc.setProperty('SelectionLanguage', 'XPath');
              wXmlRoot := wXmlDoc.documentElement;
          end;*/

    end;


    /*
    //GL2024 Automation non compatible
     procedure fgetRecordID(pXmlNode: Automation; var pRecordID: RecordID)
     var
        //GL2024 Automation non compatible  lNamedNodeMap: Automation;
         //GL2024 Automation non compatible lXMLAttribute: Automation;
     begin

         //#9194
      (not fISEmpty(pXmlNode)) then begin
             //#9194//
             lNamedNodeMap := pXmlNode.attributes;
             lXMLAttribute := lNamedNodeMap.getNamedItem('RecordID');
             if (Evaluate(pRecordID, Format(lXMLAttribute.nodeValue))) then;
             //#9194
         end;
         //#9194//

     end;*/


    /*
    //GL2024 Automation non compatible
        procedure fgetEntryNo(pXmlNode: Automation; var pEntryNo: Integer) return: Boolean
        var
          //GL2024 Automation non compatible   lNamedNodeMap: Automation;
           //GL2024 Automation non compatible  lXMLAttribute: Automation;
        begin

            return := false;
            //#9194
         if (not fISEmpty(pXmlNode)) then begin
                //#9194//
                lNamedNodeMap := pXmlNode.attributes;
                lXMLAttribute := lNamedNodeMap.getNamedItem('EntryNo');
                return := not ISCLEAR(lXMLAttribute);
                if return then
                    if (Evaluate(pEntryNo, Format(lXMLAttribute.nodeValue))) then;
                //#9194
            end;
            //#9194//

        end;*/


    procedure DeleteNode(pRecordID: RecordID; pDeleteContain: Boolean)
    var
    //GL2024 Automation non compatible lDeleteNode: Automation;
    begin
        /***********************************************
        *                   DeleteNode                *
        ***********************************************
        * Entrée : pRecordID                          *
        *        : pDeleteContain                     *
        * Sortie : Néant                              *
        ***********************************************
        * Supprime du document XML le noeud identifié *
        * par son RecordID                            *
        * Toutefois, il est possible de conserver le  *
        * contenu de ce noeud par le parametre        *
        * pDeleteContain                              *
        ***********************************************/
        // si on ne supprime pas le contenu
        // il faut recuperer le noeud parent
        fSetDefaultNode();
        // Ici in peut s'occuper de la suppression

        /* //GL2024 Automation non compatible  lDeleteNode := wXmlRoot.selectSingleNode('//Node[@RecordID=''' + Format(pRecordID) + ''']');
          if ISCLEAR(lDeleteNode) then
              exit;
          wXmlCurNode := lDeleteNode.parentNode();
          if ISCLEAR(wXmlCurNode) then
              exit;
          wXmlCurNode.removeChild(lDeleteNode);*/
        fSaveSingleInstance();

    end;


    procedure AssignFatherNode(pNewFatherID: RecordID; pCurRecID: RecordID) return: Boolean
    var
        /*  //GL2024 Automation non compatible  lFromParentNode: Automation;
           lToParentNode: Automation;
           lFromCurrNode: Automation;
           lToCurrNode: Automation;
           lFromListSaveNode: Automation;
           lIndex: Integer;
           lSaveNode: Automation;*/
        lRecID: RecordID;
        lQuery: Text[1024];
    begin
        /***********************************************
        *            AssignFatherNode                 *
        ***********************************************
        * Entrée : pNewFatherID                       *
        *        : pCurRecID                          *
        * Sortie : Néant                              *
        ***********************************************
        * change le père du noeud en cours            *
        ***********************************************/
        fSetDefaultNode();
        return := true;

        //On selectionne le Noeud que l'on veut transformer
        //ainsi que ses fils.
        lQuery := '//Node[@RecordID=''' + Format(pCurRecID) + ''']';
        /*   //GL2024 Automation non compatible   lFromCurrNode := wXmlRoot.selectSingleNode(lQuery);

             //On selectionne le parent de destination
             lQuery := '//Node[@RecordID=''' + Format(pNewFatherID) + ''']/NODES';
             lToParentNode := wXmlRoot.selectSingleNode(lQuery);

             //On ajoute le Noeud à transformer SSI les noeud ne sont pas vide
             //et on mémorise le noeud que l'on vient d'ajouter
             if ((not ISCLEAR(lToParentNode)) and (not ISCLEAR(lFromCurrNode))) then begin
                 lToParentNode.appendChild(lFromCurrNode);
             end;*/

        //GL2024 Automation non compatible  fSaveSingleInstance();

    end;


    procedure SaveBoqLines(pRecordID: RecordID; var pBOQLines: Record "BOQ Line")
    var
        /*  //GL2024 Automation non compatible lVariableNode: Automation;
          lListVariable: Automation;
          lDeleteVar: Automation;*/
        lIndex: Integer;
    begin
        /***********************************************
        *                   SaveBoqLines              *
        ***********************************************
        * Entrée : pRecordID                          *
        *        : pBOQLines                          *
        * Sortie : Néant                              *
        ***********************************************
        * Met a jour les variables du noeud dont le   *
        * RecordID est passé en parametre             *
        ***********************************************/
        fSetDefaultNode();
        // on va tous supprimer puis tous ajouter
        // On se position le noeud des variables
        /* //GL2024 Automation non compatible lVariableNode := wXmlRoot.selectSingleNode('//Node[@RecordID=''' + Format(pRecordID) + ''']/BOQs');
         // Recuperation de l'ensemble des variables
         lListVariable := wXmlRoot.selectNodes('//Node[@RecordID=''' + Format(pRecordID) + ''']/BOQs/Variable');
         for lIndex := 0 to (lListVariable.length() - 1) do begin
             lDeleteVar := lListVariable.item(lIndex);
             lVariableNode.removeChild(lDeleteVar);
         end;
         // Mantemant on se position sur le noeud RecordID
         if (SetCurrentNode(pRecordID)) then begin
             if (not pBOQLines.IsEmpty()) then begin
                 pBOQLines.Find('-');
                 repeat
                     AddBoqLine(pBOQLines);
                 until (pBOQLines.Next() = 0);
             end;
         end;*/
        fSaveSingleInstance();

    end;


    procedure GetParentsBillOfQuantity(pRecordID: RecordID; var pBillOfQuantity: Record "BOQ Line")
    var
        lIndex: Integer;
        /*  //GL2024 Automation non compatible lListXmlNode: Automation;
          lXMLNode: Automation;*/
        lRecordID: RecordID;
        /*  //GL2024 Automation non compatible  lNamedNodeMap: Automation;
           lAttribute: Automation;*/
        lRecID: RecordID;
        lQuery: Text[1024];
        lLevel: Integer;
    begin
        /***********************************************
        *           GetParentsBillOfQuantity          *
        ***********************************************
        * Entrée : RecordID du noeud                  *
        * Sortie : Ensemble de métré                  *
        ***********************************************
        * Obtient la liste des métrés parent du       *
        * RecordID passé en parametre                 *
        ***********************************************/
        fSetDefaultNode();
        //#6872
        lLevel := 0;
        lQuery := '//Node[@RecordID="' + Format(pRecordID) + '"]/ancestor::Node'
                  + '|//Node[@RecordID="' + Format(pRecordID) + '"]/ancestor::Node/BOQs/Variable[@Type!="RESULT"]';
        //#6872//
        /*  //GL2024 Automation non compatible lListXmlNode := wXmlRoot.selectNodes(lQuery);
         for lIndex := 0 to lListXmlNode.length() - 1 do begin
             lXMLNode := lListXmlNode.item(lIndex);
             if (lXMLNode.nodeName = 'Node') then begin
                 //#6872
                 lLevel := lLevel + 1;
                 //#6872//
                 // extraction du RecordID
                 lNamedNodeMap := lXMLNode.attributes;
                 lAttribute := lNamedNodeMap.getNamedItem('RecordID');
                 if (Evaluate(lRecordID, Format(lAttribute.value))) then;
             end else begin
                 //#6872
                 fAddBOQ(pBillOfQuantity, lXMLNode, lRecordID, lLevel);
                 //#6872//
             end;
         end;*/

    end;


    procedure SetValueNode(pRecordID: RecordID; pValue: Decimal)
    var
    //GL2024 Automation non compatible   lNodeValue: Automation;
    //GL2024 Automation non compatible lNamedNodeMap: Automation;
    //GL2024 Automation non compatible lAttribute: Automation;
    begin
        /***********************************************
        *                SetValueNode                 *
        ***********************************************
        * Entrée : RecordID                           *
        *        : Value                              *
        * Sortie : Néant                              *
        ***********************************************
        * Affecte à l'attribut Value du noeud XML Dont*
        * le RecordID est passé en parametre la valeur*
        * Egalement passé en parametre                *
        ***********************************************/
        fSetDefaultNode();
        /* //GL2024 Automation non compatible lNodeValue := wXmlRoot.selectSingleNode('//Node[@RecordID=''' + Format(pRecordID) + ''']/BOQs');
         lNamedNodeMap := lNodeValue.attributes;
         lAttribute := lNamedNodeMap.removeNamedItem('Value');
         lAttribute.value := Format(pValue);
         lNamedNodeMap.setNamedItem(lAttribute);*/

    end;


    procedure GetValueNode(pRecordID: RecordID) Retour: Decimal
    var
    /*  //GL2024 Automation non compatible lNodeValue: Automation;
     lNamedNodeMap: Automation;
     lAttribute: Automation;*/
    begin
        /***********************************************
        *                GetValueNode                 *
        ***********************************************
        * Entrée : RecordID                           *
        * Sortie : Value                              *
        ***********************************************
        * Renvoi la valeur affectée à l'attribut      *
        * "Value" du noeud dont le recordID est       *
        * passé en parametre                          *
        ***********************************************/
        Retour := -1;
        fSetDefaultNode();
        /*  //GL2024 Automation non compatible lNodeValue := wXmlRoot.selectSingleNode('//Node[@RecordID=''' + Format(pRecordID) + ''']/BOQs');
          lNamedNodeMap := lNodeValue.attributes;
          lAttribute := lNamedNodeMap.getNamedItem('Value');
          if (Evaluate(Retour, lAttribute.value)) then;*/

    end;


    procedure SetRecordIDNode(pOldRecordID: RecordID; pNewRecordID: RecordID)
    var
    //GL2024 Automation non compatible lNamedNodeMap: Automation;
    //GL2024 Automation non compatible  lAttribute: Automation;
    begin
        /***********************************************
        *                 SetRecordIDNode             *
        ***********************************************
        * Entrée : OldRecordID                        *
        *        : NewRecordID                        *
        * Sortie : Néant                              *
        ***********************************************
        * Modifie le recordID du noeud referencé par  *
        * OldRecordID par la valeur du NewRecordID    *
        ***********************************************/
        fSetDefaultNode();
        /*  //GL2024 Automation non compatible if (SetCurrentNode(pOldRecordID)) then begin
              lNamedNodeMap := wXmlCurNode.attributes;
              lAttribute := lNamedNodeMap.removeNamedItem('RecordID');
              lAttribute.value := Format(pNewRecordID);
              lNamedNodeMap.setNamedItem(lAttribute);
          end;*/

    end;


    procedure VariableExist(pRecordID: RecordID; pVarID: Text[50]) Retour: Boolean
    var
    //GL2024 Automation non compatible lNodeValue: Automation;
    begin
        /***********************************************
        *                  VariableExist              *
        ***********************************************
        * Entrée : RecordID                           *
        *        : VarID                              *
        * Sortie : Boolean                            *
        ***********************************************
        * Renvoie Vrai, le noeud XML referencé par    *
        * RecordID possede un element de métré dont   *
        * l'idenfiant correspond au parametre VarID,  *
        * Faux sinon                                  *
        ***********************************************/
        Retour := false;
        fSetDefaultNode();
        //GL2024 Automation non compatible  lNodeValue := wXmlRoot.selectSingleNode('//Node[@RecordID=''' + Format(pRecordID) + ''']/BOQs/Variable[@ID=''' + pVarID + ''']');
        //GL2024 Automation non compatible Retour := ISCLEAR(lNodeValue);

    end;


    /* 
     //GL2024 Automation non compatible

    procedure GetChildNodes(pRecordID: RecordID; var pNodeList: Automation)
     begin

         fSetDefaultNode();
     pNodeList := wXmlRoot.selectNodes('//Node[@RecordID=''' + Format(pRecordID) + ''']/descendant::Node');

     end;*/


    procedure CopyBOQFrom(pRecordIDFromDocument: RecordID; pRecordIDFrom: RecordID; pRecordIDToDocument: RecordID; pRecordIDTo: RecordID; pAppend: Boolean) return: Boolean
    var
        /* //GL2024 Automation non compatible  lXMLDocFrom: Automation;
          lListVar: Automation;
          lNodeToVar: Automation;
          lXmlRootFrom: Automation;*/
        lIndex: Integer;
        /*   //GL2024 Automation non compatible   lXmlNode: Automation;
             lNodeToListVar: Automation;
             lNamedNodeMap: Automation;
             lXMLAttribute: Automation;*/
        lFieldNo: Integer;
        lBOQCustMgt: Codeunit "BOQ Custom Management";
    /*    //GL2024 Automation non compatible   lCurNode: Automation;
          lOldNode: Automation;
          lNewNode: Automation;*/
    begin
        /***********************************************
        *                   CopyBOQFrom               *
        ***********************************************
        * Entrée : RecordID Source du document        *
        *        : RecordID Source du noeud           *
        *        : RecordID Destination du document   *
        *        : RecordID Destination du noeud      *
        *        : Append boolean                     *
        * Sortie : Néant                              *
        ***********************************************
        * Copie le metré du noeud source dans le      *
        * document source vars le noeud destination du*
        * document destination                        *
        * la parametre Append permet d'ajouter les    *
        * nouvelles variables, sinon cela les substitues*
        ***********************************************/
        /*  //GL2024 Automation non compatible     return := fLoadXMLDom(lXMLDocFrom, pRecordIDFromDocument);
        if not return then
               exit;
           return := Load(pRecordIDToDocument);
           fSetDefaultNode();
           // chargement du document XML
           if (return) then begin
               // recherche des variables dans le document XML au niveau du RecordIDFrom
               lXmlRootFrom := lXMLDocFrom.documentElement;
               lListVar := lXmlRootFrom.selectNodes('//Node[@RecordID=''' + Format(pRecordIDFrom) + ''']/BOQs/Variable');
               // Pour chacune des variables les ajouter dans le RecordIDTO
               lNodeToVar := wXmlRoot.selectSingleNode('//Node[@RecordID=''' + Format(pRecordIDTo) + ''']/BOQs');
               // on peut maintenant proceder à l'insertion brute
               if ((not ISCLEAR(lNodeToVar)) and (lListVar.length <> 0)) then begin
                   if not pAppend then begin
                       //#7005
                       // Puisqu'il faut supprimer, on va prefere supprimer l'elements Boqs puis le recreer
                       lCurNode := wXmlRoot.selectSingleNode('//Node[@RecordID=''' + Format(pRecordIDTo) + ''']');
                       lOldNode := wXmlRoot.selectSingleNode('//Node[@RecordID=''' + Format(pRecordIDTo) + ''']/BOQs');
                       //lCurNode.removeChild(lDeleteNode);

                       lNewNode := wXmlDoc.createElement('BOQs');
                       lXMLAttribute := wXmlDoc.createAttribute('Value');
                       lNamedNodeMap := lNewNode.attributes;
                       lNamedNodeMap.setNamedItem(lXMLAttribute);
                       //lCurNode.appendChild(lDeleteNode);
                       lCurNode.replaceChild(lNewNode, lOldNode);
                       lNodeToVar := wXmlRoot.selectSingleNode('//Node[@RecordID=''' + Format(pRecordIDTo) + ''']/BOQs');*/
        /*
        lNodeToListVar := wXmlRoot.selectNodes('//Node[@RecordID=''' + FORMAT(pRecordIDTo) + ''']/BOQs/Variable');
        FOR lIndex := 0 TO lNodeToListVar.length - 1 DO BEGIN
          lXmlNode := lNodeToListVar.nextNode();
          IF ((NOT ISCLEAR(lNodeToVar)) AND (NOT ISCLEAR(lXmlNode))) THEN BEGIN
            lNodeToVar.removeChild(lXmlNode);
          END;
        END;
        */
        //#7005//
        /* //GL2024 Automation non compatible     end;
             for lIndex := 0 to lListVar.length - 1 do begin
                 lXmlNode := lListVar.nextNode();
                 lNamedNodeMap := lXmlNode.attributes();
                 if not ISCLEAR(lNamedNodeMap) then begin
                     lXMLAttribute := lNamedNodeMap.getNamedItem('Field');
                     if not ISCLEAR(lXMLAttribute) then begin
                         if Evaluate(lFieldNo, Format(lXMLAttribute.value)) then begin
                             lXMLAttribute.value := Format(lBOQCustMgt.fGetFieldNo(pRecordIDFrom, lFieldNo, pRecordIDTo));
                             lNamedNodeMap.removeNamedItem('Field');
                             lNamedNodeMap.setNamedItem(lXMLAttribute);
                             lXmlNode.text := '';
                         end;
                     end;
                 end;
                 if ((not ISCLEAR(lNodeToVar)) and (not ISCLEAR(lXmlNode))) then begin
                     lNodeToVar.appendChild(lXmlNode);
                 end;
             end;
         end else begin
             exit(false);
         end;
         //Save('');
         fSaveSingleInstance();
     end;*/

    end;

    /*
     //GL2024 Automation non compatible
     local procedure fLoadXMLDom(var pXMLDoc: Automation; pRecordID: RecordID) return: Boolean
     var
         lInStream: InStream;
         lSingleImport: Codeunit "Import SingleInstance";
         lTxt: Text[100];
         lInt: Integer;
         lFile: File;
     begin

         wBOQDocXml.SetCurrentkey(RecordID);
         //#8984
         if (lSingleImport.fGetDatabaseType() = 'SQL') then begin
             wBOQDocXml.SetRange(RecordID, pRecordID);
         end else begin
             wBOQDocXml.SetFilter(wBOQDocXml.RecordID, StrSubstNo('=%1', Format(pRecordID)));
         end;
         //#8984//
         //return := NOT wBOQDocXml.ISEMPTY;
         if not wBOQDocXml.FindFirst then
             exit(false);
         //#8784
         if (not wBOQDocXml.BOQXML.Hasvalue) then
             exit(false);
         //#8784//
         wBOQDocXml.CalcFields(BOQXML);
         wBOQDocXml.BOQXML.CreateInstream(lInStream);
       if ISCLEAR(pXMLDoc) then
             Create(pXMLDoc);

         return := pXMLDoc.load(lInStream);
         if (return) then begin
             pXMLDoc.validate;
             pXMLDoc.setProperty('SelectionLanguage', 'XPath');
         end;

     end;*/


    procedure GetBOQDefined(pRecordID: RecordID) return: Integer
    var
    //GL2024 Automation non compatible  lListVar: Automation;
    begin
        /***********************************************
        *                    GetBOQDefined            *
        ***********************************************
        * Entrée : RecordID                           *
        * Sortie : Integer                            *
        ***********************************************
        * Renvoie une valeur comprise entre 0 et 3    *
        * pour le noeud dont le recordID est passé en *
        * parametre                                   *
        * 0 : Aucun Métré de defini                   *
        * 1 : Metré contenant uniquement des variables*
        * 2 : Métré contenant des resultats           *
        * 3 : Le métré posséde des elements en erreur *
        ***********************************************/
        return := -1;
        fSetDefaultNode();
        // existe-t'il des variables ????
        /*  //GL2024 Automation non compatible lListVar := wXmlRoot.selectNodes('//Node[@RecordID=''' + Format(pRecordID) + ''']/BOQs/Variable');
          if (lListVar.length <> 0) then begin
              fConstInitialize();
              //#9035
              //Dans ce metre y a t'il des elements en erreur
              lListVar := wXmlRoot.selectNodes('//Node[@RecordID=''' + Format(pRecordID) + ''']/BOQs/Variable[@Error=''True'']');
              if (lListVar.length <> 0) then begin
                  return := BOQWithError;
              end else begin
                  //#9035
                  //Dans ce metre y a t'il des resultats
                  lListVar := wXmlRoot.selectNodes('//Node[@RecordID=''' + Format(pRecordID) + ''']/BOQs/Variable[@Type=''RESULT'']');
                  if (lListVar.length <> 0) then begin
                      return := BOQWithResult;
                  end else
                      return := BOQOnlyVariable;
                  //#9035
              end;
              //#9035//
          end else begin
              return := BOQNotDefined;
          end;*/

    end;

    local procedure fConstInitialize()
    begin
        /***********************************************
        *                  fConstInitialize           *
        ***********************************************
        * Entrée : Néant                              *
        * Sortie : Néant                              *
        ***********************************************
        * Initialize l'ensemble des constantes        *
        ***********************************************/
        BOQNotDefined := 0;
        BOQOnlyVariable := 1;
        BOQWithResult := 2;
        BOQWithError := 3;

    end;


    procedure DeleteBOQLine(pBOQ: Record "BOQ Line")
    var
        //GL2024 Automation non compatible   lXmlNode: Automation;
        //GL2024 Automation non compatible lListNode: Automation;
        lIndex: Integer;
        lFind: Boolean;
    begin
        /***********************************************
        *                  DeleteBoqLine              *
        ***********************************************
        * Entrée : table ligne de metre               *
        * Sortie : Néant                              *
        ***********************************************
        * supprime un ligne de metre dans le  Noeud   *
        * courant                                     *
        * Remarque : si la ligne n'est pas de type    *
        * Reference, le parametre pFieldNo est egale  *
        * à -1                                        *
        ***********************************************/
        fSetDefaultNode();

        // Attention, tous est fonction du type de noeud
        // Variable ou Resultat
        /* //GL2024 Automation non compatible if (pBOQ."Variable Code" <> '') then begin
             // C'est une variable
             lXmlNode := wXmlCurNode.selectSingleNode('//BOQs/Variable[@ID=''' + pBOQ."Variable Code" + ''']');
             if (not ISCLEAR(lXmlNode)) then begin
                 wXmlCurNode.childNodes.item(0).removeChild(lXmlNode);
             end;
         end else begin
             // La c'est un peut plus conpliqué
             lListNode := wXmlCurNode.selectNodes('//BOQs/Variable[@Type=''RESULT'']');
             lIndex := 0;
             lFind := false;
             while ((not lFind) and (lIndex < lListNode.length)) do begin
                 lXmlNode := lListNode.item(lIndex);
                 if (lXmlNode.text = pBOQ.Formula) then begin
                     wXmlCurNode.childNodes.item(0).removeChild(lXmlNode);
                 end;
                 lIndex := lIndex + 1;
             end;
         end;*/
        fSaveSingleInstance();

    end;


    procedure ModifyBOQLine(pxBOQ: Record "BOQ Line"; pBOQ: Record "BOQ Line")
    begin
    end;


    procedure fVarToDec(pVar: Text[250]) return: Decimal
    var
        lGLsetup: Record "General Ledger Setup";
        lTextValue: Text[250];
        lIndex: Integer;
        lTextDecimal: Text[250];
    begin
        if wToSeparator = '' then begin
            lGLsetup.Get;
            if StrPos(Format(lGLsetup."Amount Rounding Precision"), ',') <> 0 then begin
                wToSeparator := ',';
                wFromSeparator := '.';
            end else begin
                wToSeparator := '.';
                wFromSeparator := ',';
            end;
        end;
        lTextValue := ConvertStr(pVar, wFromSeparator, wToSeparator);
        //#7184
        //lTextValue := DELCHR(lTextValue, '=', ' ');
        for lIndex := 1 to StrLen(lTextValue) do begin
            if ((lTextValue[lIndex] <> 255) and (lTextValue[lIndex] <> 32)) then
                lTextDecimal += Format(lTextValue[lIndex]);
        end;
        lTextValue := lTextDecimal;
        //#7184//
        if (Evaluate(return, lTextValue)) then;
    end;


    procedure fTransformFormula(pVar: Text[1024]) return: Text[1024]
    var
        lGLsetup: Record "General Ledger Setup";
        lPos: Integer;
        lBeforeChar: Char;
        lAfterChar: Char;
    begin
        if wToSeparator = '' then begin
            lGLsetup.Get;
            if StrPos(Format(lGLsetup."Amount Rounding Precision"), ',') <> 0 then begin
                wToSeparator := ',';
                wFromSeparator := '.';
            end else begin
                wToSeparator := '.';
                wFromSeparator := ',';
            end;
        end;
        lPos := StrPos(pVar, wFromSeparator);
        return := '';
        while (lPos <> 0) do begin
            lBeforeChar := pVar[lPos - 1];
            lAfterChar := pVar[lPos + 1];
            if ((lBeforeChar in ['0' .. '9', '*', '-', '+', '/', '(']) and (lAfterChar in ['0' .. '9', '*', '-', '+', '/', '('])) then begin
                return += CopyStr(pVar, 1, lPos - 1) + wToSeparator;
            end else begin
                return += CopyStr(pVar, 1, lPos);
            end;
            pVar := CopyStr(pVar, lPos + 1);
            lPos := StrPos(pVar, wFromSeparator);
        end;
        return += pVar;
        //return := CONVERTSTR(pVar, wFromSeparator, wToSeparator);
    end;


    procedure GetUseVariable(pRecordID: RecordID; var pBOQ: Record "BOQ Line")
    var
        lQuery: array[2] of Text[250];
        //GL2024 Automation non compatible  lListXmlNode: Automation;
        lIndex: Integer;
        //GL2024 Automation non compatible   lXMLNode: Automation;
        //GL2024 Automation non compatible   lNamedNodeMAp: Automation;
        //GL2024 Automation non compatible    lAttribute: Automation;
        lIndexQuery: Integer;
        lRecordID: RecordID;
        lTypeAtt: Text[100];
        lLevel: Integer;
    begin
        //#6592
        /***********************************************
        *                GetUseVariable               *
        ***********************************************
        * Entrée : RecordID du noeud                  *
        *        : Ensemble de données des boqs       *
        * Sortie : Néant                              *
        ***********************************************
        * Obtient la liste des variables utilisables  *
        * au sein d'une formule à partir de RecordID  *
        * passé en parametre                          *
        ***********************************************/
        fSetDefaultNode();
        //#6872
        lLevel := 0;
        lQuery[1] := '//Node[@RecordID="' + Format(pRecordID) + '"]/ancestor::Node'
                  + '|//Node[@RecordID="' + Format(pRecordID) + '"]/ancestor::Node/BOQs/Variable[@Type!="RESULT"]';
        lQuery[2] := '//Node[@RecordID="' + Format(pRecordID) + '"]'
                  + '|//Node[@RecordID="' + Format(pRecordID) + '"]/BOQs/Variable[@Type!="RESULT"]';
        //#6872//
        /* //GL2024 Automation non compatible for lIndexQuery := 1 to 2 do begin
              lListXmlNode := wXmlRoot.selectNodes(lQuery[lIndexQuery]);
              for lIndex := 0 to lListXmlNode.length() - 1 do begin
                  lXMLNode := lListXmlNode.item(lIndex);
                  if (lXMLNode.nodeName = 'Node') then begin
                      // extraction du RecordID
                      //#6872
                      lLevel := lLevel + 1;
                      //#6872//
                      lNamedNodeMAp := lXMLNode.attributes;
                      lAttribute := lNamedNodeMAp.getNamedItem('RecordID');
                      if (Evaluate(lRecordID, Format(lAttribute.value))) then;
                  end else begin
                      // extraction du RecordID
                      lNamedNodeMAp := lXMLNode.attributes;
                      lAttribute := lNamedNodeMAp.getNamedItem('Type');
                      if (Evaluate(lTypeAtt, Format(lAttribute.value))) then;
                      if (lTypeAtt <> 'RESULT') then begin
                          fTestAlreadyExist(pBOQ, lXMLNode);
                          //#6872
                          fAddBOQ(pBOQ, lXMLNode, lRecordID, lLevel);
                          //#6872//
                      end;
                  end;
              end;
          end;*/
        //#6592//

    end;


    /*

     //GL2024 Automation non compatible
      procedure fTestAlreadyExist(var pBOQ: Record 8001434; pXMLNode: Automation)
      var
      //GL2024 Automation non compatible    lAttribute: Automation;
        //GL2024 Automation non compatible  lNamedNodeMap: Automation;
          lVarCode: Code[20];
      begin
          //#6592

        lNamedNodeMap := pXMLNode.attributes;
          lAttribute := lNamedNodeMap.getNamedItem('ID');
          if (not ISCLEAR(lAttribute)) then begin
              if (Evaluate(lVarCode, Format(lAttribute.value))) then;
              pBOQ.SetRange(pBOQ."Variable Code", lVarCode);
              if (not pBOQ.IsEmpty()) then begin
                  pBOQ.Find('-');
                  pBOQ.Delete();
              end;
              pBOQ.Reset;
              if (pBOQ.Find('+')) then;
          end;
          //#6592//

      end;*/


    procedure gNodeExist(pRecordID: RecordID) Return: Boolean
    var
    //GL2024 Automation non compatible   lXmlCurNode: Automation;
    begin
        /***********************************************
        *                SetCurrentNode               *
        ***********************************************
        * Entrée : RecordID                           *
        * Sortie : Néant                              *
        ***********************************************
        * Affecte comme noeud courant, le noeud       *
        * comportant comme recordID, la valeur passée *
        * en parametre                                *
        ***********************************************/
        fSetDefaultNode();
        //GL2024 Automation non compatible  lXmlCurNode := wXmlRoot.selectSingleNode('//Node[@RecordID=''' + Format(pRecordID) + ''']');
        //GL2024 Automation non compatible  Return := not (ISCLEAR(lXmlCurNode));

    end;


    procedure gPurgeNodes(pRecordID: RecordID)
    var
        //GL2024 Automation non compatible   lListXmlNode: Automation;
        //GL2024 Automation non compatible    lXMLCurNode: Automation;
        //GL2024 Automation non compatible   lDeleteXMLNode: Automation;
        i: Integer;
    begin
        /***********************************************
        *                gPurgeNodes                  *
        ***********************************************
        * Entrée : RecordID                           *
        * Sortie : Néant                              *
        ***********************************************
        * Supprime les doublon dans l'arbre XML       *
        * du métré                                    *
        ***********************************************/
        fSetDefaultNode();
        /* //GL2024 Automation non compatible lListXmlNode := wXmlRoot.selectNodes('//Node[@RecordID=''' + Format(pRecordID) + ''']');
          for i := 1 to lListXmlNode.length - 1 do begin
              lDeleteXMLNode := lListXmlNode.item(i);
              lXMLCurNode := lDeleteXMLNode.parentNode();
              lXMLCurNode.removeChild(lDeleteXMLNode);
          end;*/

    end;


    procedure fSubstituteVariable(var pBOQ: Record "BOQ Line"; pVarCode: Code[20]; pVarLevel: Integer)
    begin
        //#6872
        pBOQ.SetRange("Variable Code", pVarCode);
        pBOQ.SetRange(Substituted, false);
        pBOQ.SetFilter(Level, '<%1', pVarLevel);
        if (not pBOQ.IsEmpty()) then begin
            pBOQ.ModifyAll(Substituted, true);
        end;
        pBOQ.Reset;
        if (pBOQ.Find('+')) then;
        //#6872//
    end;


    procedure fCase(pValue: Text[255]; pUpperCase: Boolean; pFirstLetter: Boolean) return: Text[255]
    var
        lFirstLetter: Text[1];
        lRest: Text[255];
    begin
        //#6872
        return := '';
        if (pFirstLetter) then begin
            lFirstLetter := CopyStr(pValue, 1, 1);
            lRest := CopyStr(pValue, 2);
            if (pUpperCase) then begin
                return := UpperCase(lFirstLetter) + Lowercase(lRest);
            end else begin
                return := Lowercase(lFirstLetter) + UpperCase(lRest);
            end;

        end else begin
            if (pUpperCase) then begin
                return := UpperCase(pValue);
            end else begin
                return := Lowercase(pValue);
            end;
        end;
        //#6872//
    end;


    procedure fGetLevel(pRecordID: RecordID) Level: Integer
    var
        lQuery: Text[255];
        //GL2024 Automation non compatible    lListXMLNode: Automation;
        lIndex: Integer;
    //GL2024 Automation non compatible    lXmlNode: Automation;
    begin
        /***********************************************
        *                    fGetLevel                *
        ***********************************************
        * Entrée : RecordID du noeud                  *
        * Sortie : Niveau du métré                    *
        ***********************************************
        * Obtient le niveau des métrés du RecordID    *
        * passé en parametre                          *
        ***********************************************/
        fSetDefaultNode();
        //#6872
        Level := 0;
        lQuery := '//Node[@RecordID="' + Format(pRecordID) + '"]/ancestor::Node'
                + '|//Node[@RecordID=''' + Format(pRecordID) + ''']';
        //#6872//
        /* //GL2024 Automation non compatible  lListXMLNode := wXmlRoot.selectNodes(lQuery);
           for lIndex := 0 to lListXMLNode.length() - 1 do begin
               lXmlNode := lListXMLNode.nextNode();
               //#6872
               if (lXmlNode.nodeName = 'Node') then begin
                   Level := Level + 1;
               end;
               //#6872//
           end;*/

    end;


    procedure RenameChildFrom(pRecordID: RecordID; pxRecordID: RecordID)
    var
        lNewRecordID: RecordID;
        lSearchRecordID: RecordID;
        lSearchKey: Text[250];
        lIndex: Integer;
        //GL2024 Automation non compatible    lListXMLNode: Automation;
        lQuery: Text[250];
        //GL2024 Automation non compatible  lXmlNode: Automation;
        //GL2024 Automation non compatible     lNamedNodeMap: Automation;
        //GL2024 Automation non compatible     lAttribute: Automation;
        lTxtRecordID: Text[250];
        lTxtNewRecordID: Text[250];
        lGoodKey: Text[250];
    begin
        //#6902
        lSearchKey := Format(pxRecordID);
        lSearchKey := CopyStr(lSearchKey, StrPos(lSearchKey, ':'));

        lGoodKey := Format(pRecordID);
        lGoodKey := CopyStr(lGoodKey, StrPos(lGoodKey, ':'));

        lQuery := '//Node[@RecordID="' + Format(pRecordID) + '"]/descendant::Node[contains(@RecordID, "' + lSearchKey + '")]';
        /* //GL2024 Automation non compatible    lListXMLNode := wXmlRoot.selectNodes(lQuery);

             for lIndex := 0 to lListXMLNode.length() - 1 do begin
                 // On recupere le noeud XML
                 lXmlNode := lListXMLNode.nextNode();
                 lNamedNodeMap := lXmlNode.attributes;
                 // On determine le RecordID
                 lAttribute := lNamedNodeMap.getNamedItem('RecordID');
                 if (Evaluate(lSearchRecordID, Format(lAttribute.value))) then;
                 lTxtRecordID := Format(lAttribute.value);
                 lTxtNewRecordID := CopyStr(lTxtRecordID, 1, StrPos(lTxtRecordID, lSearchKey) - 1) + lGoodKey;
                 lTxtNewRecordID += CopyStr(lTxtRecordID, StrPos(lTxtRecordID, lSearchKey) + StrLen(lSearchKey));
                 if (Evaluate(lNewRecordID, lTxtNewRecordID)) then;
                 // Et bien maintenant on peut renommer
                 RenameNodeAt(lNewRecordID, lSearchRecordID);
             end;*/
        //#6902//
    end;


    procedure GetRecordIDDocument(var pRecordID: RecordID)
    var
    //GL2024 Automation non compatible    lXmlCurNode: Automation;
    //GL2024 Automation non compatible     lNamedNodeMap: Automation;
    //GL2024 Automation non compatible   lAttribute: Automation;
    begin
        /***********************************************
        *             GetRecordIDDocument             *
        ***********************************************
        * Entrée : RecordID du noeud                  *
        * Sortie : Niveau du métré                    *
        ***********************************************
        * Obtient le niveau des métrés du RecordID    *
        * passé en parametre                          *
        ***********************************************/
        //#7005
        fSetDefaultNode();
        /*//GL2024 Automation non compatible lXmlCurNode := wXmlRoot.selectSingleNode('//Document/Node');
        lNamedNodeMap := lXmlCurNode.attributes;
        lAttribute := lNamedNodeMap.getNamedItem('RecordID');
        if (Evaluate(pRecordID, Format(lAttribute.value))) then;*/
        //#7005//

    end;


    procedure fSearchReplaceAttValue(pFromValue: Text[80]; pToValue: Text[80]; pNode: Text[80]; pAttribute: Text[80]) retour: Boolean
    var
        lQuery: Text[255];
        //GL2024 Automation non compatible  lListXMLNode: Automation;
        //GL2024 Automation non compatible    lXmlNode: Automation;
        lIndex: Integer;
        //GL2024 Automation non compatible   lXMLAttribute: Automation;
        lBasic: Codeunit Basic;
        lToLeftValue: Text[80];
        lToRightValue: Text[80];
        lFromValue: Text[80];
    begin
        /***********************************************
        *          fSearchReplaceAttValue             *
        ***********************************************
        * Entrée : RecordID du noeud                  *
        * Sortie : Niveau du métré                    *
        ***********************************************
        * Obtient le niveau des métrés du RecordID    *
        * passé en parametre                          *
        ***********************************************/
        retour := false;
        fSetDefaultNode();
        if StrPos(pFromValue, '*') <> 0 then begin
            lFromValue := CopyStr(pFromValue, 1, StrPos(pFromValue, '*') - 1);
            //lQuery := '//*[starts-with('+pNode+ '[@'+ pAttribute + '],''' + lFromValue + ''')]';
            lQuery := '//' + pNode + '[starts-with(@' + pAttribute + ',''' + lFromValue + ''')]';
        end else begin
            lQuery := '//' + pNode + '[@' + pAttribute + '=''' + pFromValue + ''']';
            lFromValue := pFromValue;
        end;
        /*//GL2024 Automation non compatible   lListXMLNode := wXmlRoot.selectNodes(lQuery);

           lToLeftValue := pToValue;
           if StrPos(pToValue, '*') <> 0 then begin
               lToLeftValue := CopyStr(pToValue, 1, StrPos(pToValue, '*') - 1);
               lToRightValue := CopyStr(pToValue, StrPos(pToValue, '*') + 1);
           end;
           for lIndex := 0 to lListXMLNode.length() - 1 do begin
               lXmlNode := lListXMLNode.item(lIndex);
               lXMLAttribute := lXmlNode.attributes.getNamedItem(pAttribute);
               lXMLAttribute.value := lBasic.StrReplace(lXMLAttribute.value, lFromValue, lToLeftValue, true, false)
                                       + lToRightValue;
               retour := true;
           end;*/
        fSaveSingleInstance();

    end;


    procedure AddBOQFrom(pRecordIDFromDocument: RecordID; pRecordIDFrom: RecordID; pRecordIDToDocument: RecordID; pRecordIDTo: RecordID) return: Boolean
    var
        /*//GL2024 Automation non compatible   lXMLDocFrom: Automation;
           lListVar: Automation;
           lNodeToVar: Automation;
           lXmlRootFrom: Automation;*/
        lIndex: Integer;
        /*//GL2024 Automation non compatible  lXmlNode: Automation;
          lNodeToListVar: Automation;
          lNamedNodeMap: Automation;
          lXMLAttribute: Automation;*/
        lFieldNo: Integer;
        lBOQCustMgt: Codeunit "BOQ Custom Management";
    /* //GL2024 Automation non compatible  lCurNode: Automation;
       lOldNode: Automation;
       lNewNode: Automation;*/
    begin
        /***********************************************
        *                   AddBOQFrom                *
        ***********************************************
        * Entrée : RecordID Source du document        *
        *        : RecordID Source du noeud           *
        *        : RecordID Destination du document   *
        *        : RecordID Destination du noeud      *
        * Sortie : Néant                              *
        ***********************************************
        * Copie le metré du noeud source dans le      *
        * document source vars le noeud destination du*
        * document destination                        *
        ***********************************************/
        /* //GL2024 Automation non compatible  return := fLoadXMLDom(lXMLDocFrom, pRecordIDFromDocument);
           if not return then
               exit;
           //#7202
           //return := Load(pRecordIDToDocument);
           //#7202//
           fSetDefaultNode();
           // chargement du document XML
           if (return) then begin
               // recherche des noeuds dans le document XML au niveau du RecordIDFrom
               lXmlRootFrom := lXMLDocFrom.documentElement;
               lListVar := lXmlRootFrom.selectNodes('//Node[@RecordID=''' + Format(pRecordIDFrom) + ''']/NODES/Node');
               // Pour chacune des variables les ajouter dans le RecordIDTO
               lNodeToVar := wXmlRoot.selectSingleNode('//Node[@RecordID=''' + Format(pRecordIDTo) + ''']/NODES');
               // on peut maintenant proceder à l'insertion brute
               if ((not ISCLEAR(lNodeToVar)) and (lListVar.length <> 0)) then begin
                   for lIndex := 0 to lListVar.length - 1 do begin
                       lXmlNode := lListVar.nextNode();
                       if ((not ISCLEAR(lNodeToVar)) and (not ISCLEAR(lXmlNode))) then begin
                           lNodeToVar.appendChild(lXmlNode);
                       end;
                   end;
               end else begin
                   exit(false);
               end;
               //Save('');
               fSaveSingleInstance();
           end;*/

    end;


    procedure DeleteAllContains(pRecordID: RecordID)
    var
    /*//GL2024 Automation non compatible   lNodeToVar: Automation;
       lCurNode: Automation;
       lOldNode: Automation;
       lNewNode: Automation;
       lXMLAttribute: Automation;
       lNamedNodeMap: Automation;*/
    begin
        /***********************************************
        *              DeleteAllContains              *
        ***********************************************
        * Entrée : RecordID Source du noeud           *
        * Sortie : Néant                              *
        ***********************************************
        * Copie le metré du noeud source dans le      *
        * document source vars le noeud destination du*
        * document destination                        *
        * la parametre Append permet d'ajouter les    *
        * nouvelles variables, sinon cela les substitues*
        ***********************************************/
        fSetDefaultNode();
        // chargement du document XML
        // Pour chacune des variables les ajouter dans le RecordIDTO
        /* //GL2024 Automation non compatible   lNodeToVar := wXmlRoot.selectSingleNode('//Node[@RecordID=''' + Format(pRecordID) + ''']/BOQs');
            // on peut maintenant proceder à l'insertion brute
            if (not ISCLEAR(lNodeToVar)) then begin
                // Puisqu'il faut supprimer, on va prefere supprimer l'elements Boqs puis le recreer
                lCurNode := wXmlRoot.selectSingleNode('//Node[@RecordID=''' + Format(pRecordID) + ''']');
                lOldNode := wXmlRoot.selectSingleNode('//Node[@RecordID=''' + Format(pRecordID) + ''']/BOQs');
                lNewNode := wXmlDoc.createElement('BOQs');
                lXMLAttribute := wXmlDoc.createAttribute('Value');
                lNamedNodeMap := lNewNode.attributes;
                lNamedNodeMap.setNamedItem(lXMLAttribute);
                lCurNode.replaceChild(lNewNode, lOldNode);

                // Puisqu'il faut supprimer, on va prefere supprimer l'elements NODES puis le recreer
                lOldNode := wXmlRoot.selectSingleNode('//Node[@RecordID=''' + Format(pRecordID) + ''']/NODES');
                lNewNode := wXmlDoc.createElement('NODES');
                lCurNode.replaceChild(lNewNode, lOldNode);
            end;
            fSaveSingleInstance();*/

    end;

    local procedure fSaveSingleInstance()
    begin
        /***********************************************
        *             fSaveSingleInstance             *
        ***********************************************
        * Entrée : Néant                              *
        * Sortie : Néant                              *
        ***********************************************
        * Sauvegarde le document XML dans le          *
        * singleInstance en fonction"UseSingleInstance*
        ***********************************************/
        //GL2024 Automation non compatible     wSingleInstance.SetXmlDoc(wXmlDoc);

    end;


    procedure IsEmpty() retour: Boolean
    var
    //GL2024 Automation non compatible    lNode: Automation;
    begin
        //#7202
        /***********************************************
        *                    IsEmpty                  *
        ***********************************************
        * Entrée : Néant                              *
        * Sortie : Boolean                            *
        ***********************************************
        * Renvoie Vrai sir document XML Est Vide      *
        * Faux Sinon                                  *
        ***********************************************/
        /* //GL2024 Automation non compatible retour := ISCLEAR(wXmlDoc);
          if (not retour) then begin
              lNode := wXmlRoot.selectSingleNode('//Node');
              retour := ISCLEAR(lNode);
          end;*/
        //7202//

    end;


    procedure fSearchReplaceAttValueFrom(pFatherNode: Text[80]; pFromValue: Text[80]; pToValue: Text[80]; pNode: Text[80]; pAttribute: Text[80]) retour: Boolean
    var
        lQuery: Text[255];
        //GL2024 Automation non compatible  lListXMLNode: Automation;
        //GL2024 Automation non compatible    lXmlNode: Automation;
        lIndex: Integer;
        //GL2024 Automation non compatible     lXMLAttribute: Automation;
        lBasic: Codeunit Basic;
        lToLeftValue: Text[80];
        lToRightValue: Text[80];
        lFromValue: Text[80];
    //GL2024 Automation non compatible  lXmlFatherNode: Automation;
    begin
        /***********************************************
        *        fSearchReplaceAttValueFrom           *
        ***********************************************
        * Entrée : RecordID du noeud                  *
        * Sortie : Niveau du métré                    *
        ***********************************************
        * Obtient le niveau des métrés du RecordID    *
        * passé en parametre                          *
        ***********************************************/
        retour := false;
        fSetDefaultNode();
        if StrPos(pFromValue, '*') <> 0 then begin
            lFromValue := CopyStr(pFromValue, 1, StrPos(pFromValue, '*') - 1);
            //lQuery := '//*[starts-with('+pNode+ '[@'+ pAttribute + '],''' + lFromValue + ''')]';
            lQuery := '//' + pNode + '[starts-with(@' + pAttribute + ',''' + lFromValue + ''')]';
        end else begin
            lQuery := '//' + pNode + '[@' + pAttribute + '=''' + pFromValue + ''']';
            lFromValue := pFromValue;
        end;
        // recuperation du node parent ou l'on doit faire les remplacements
        /* //GL2024 Automation non compatible   lXmlFatherNode := wXmlRoot.selectSingleNode('//Node[@RecordID=''' + pFatherNode + ''']');
            if (not ISCLEAR(lXmlFatherNode)) then begin
                //ERROR(lXmlFatherNode.xml);
                lListXMLNode := lXmlFatherNode.selectNodes(CopyStr(lQuery, 2));
            end else begin
                lListXMLNode := wXmlRoot.selectNodes(lQuery);
            end;

            lToLeftValue := pToValue;
            if StrPos(pToValue, '*') <> 0 then begin
                lToLeftValue := CopyStr(pToValue, 1, StrPos(pToValue, '*') - 1);
                lToRightValue := CopyStr(pToValue, StrPos(pToValue, '*') + 1);
            end;
            for lIndex := 0 to lListXMLNode.length() - 1 do begin
                lXmlNode := lListXMLNode.item(lIndex);
                lXMLAttribute := lXmlNode.attributes.getNamedItem(pAttribute);
                lXMLAttribute.value := lBasic.StrReplace(lXMLAttribute.value, lFromValue, lToLeftValue, true, false)
                                        + lToRightValue;
                retour := true;
            end;*/
        fSaveSingleInstance();

    end;

    /*//GL2024 Automation non compatible
        procedure fGetXmlDocument(var pXmlDoc: Automation)
        begin
            //#7337
           //GL2024 Automation non compatible pXmlDoc := wXmlDoc;
            //#7337//
        end;*/

    /*//GL2024 Automation non compatible
        procedure fManagedNode(pRecordID: RecordID; pSrcXmlDoc: Automation; pLevel: Integer)
        var
           lListXMLNode: Automation;
       lNode: Automation;
         lListXmlVar: Automation;
      lVar: Automation;
            lRecVar: Record 8001434 temporary;
            lIndexNode: Integer;
            lIndexVar: Integer;
         lSrcXmlRoot: Automation;
        begin
            //#7337
            // Purge sur le doc dest
            gPurgeNodes(pRecordID);
            //Recherche du noeud pRecordID sur la document source
            lRecVar.DeleteAll;
          lSrcXmlRoot := pSrcXmlDoc.documentElement;
            lListXMLNode := lSrcXmlRoot.selectNodes('//Node[@RecordID=''' + Format(pRecordID) + ''']');
            for lIndexNode := 0 to lListXMLNode.length() - 1 do begin
                lNode := lListXMLNode.item(lIndexNode);
                // recherche des variables associées
                lListXmlVar := lNode.firstChild.childNodes;
                for lIndexVar := 0 to lListXmlVar.length() - 1 do begin
                    lVar := lListXmlVar.item(lIndexVar);
                    fAddBOQ(lRecVar, lVar, pRecordID, pLevel);
                    // Suppression des doublons
                    if (lRecVar."Variable Code" <> '') then begin
                        lRecVar.SetRange("Variable Code", lRecVar."Variable Code");
                        if ((not lRecVar.IsEmpty) and (lRecVar.Count > 1)) then begin
                            lRecVar.Find('+');
                            lRecVar.Delete;
                        end;
                        lRecVar.Reset;
                    end;
                end;
            end;
            // Sauvegarde des variables
            SaveBoqLines(pRecordID, lRecVar);
            //#7337//
        end;
    */

    procedure fSaveFile(pFileName: Text[250])
    begin
        //#7337
        //GL2024 Automation non compatible  wXmlDoc.save(pFileName);
        //#7337//
    end;


    procedure HasReferenceVariable(pRecordID: RecordID; pFieldNo: Integer) retour: Boolean
    var
        lQuery: Text[255];
    //GL2024 Automation non compatible lXmlNode: Automation;
    begin
        //#7357
        retour := false;
        fSetDefaultNode();
        lQuery := '//Node[@RecordID=''' + Format(pRecordID) + ''']/BOQs/Variable[@Type=''REF'' and @Field=''' + Format(pFieldNo) + ''']';
        //GL2024 Automation non compatible  lXmlNode := wXmlRoot.selectSingleNode(lQuery);
        //GL2024 Automation non compatible   retour := not ISCLEAR(lXmlNode);
        //#7357//
    end;


    procedure fHasBOQ(pRecordID: RecordID; pDescendant: Boolean) Retour: Boolean
    var
        lQuery: Text[255];
        //GL2024 Automation non compatible lXmlNodes: Automation;
        lXmlNodesNumber: Integer;
    begin
        /***********************************************
        *              HasBillOfQuantity              *
        ***********************************************
        * Entrée : RecordID                           *
        * Sortie : Booleen                            *
        ***********************************************
        * Renvoi VRAI, si le Noeud dont le RecordID   *
        * est passé en parametre possède un métré,    *
        * Faux sinon                                  *
        ***********************************************/
        fSetDefaultNode();
        lXmlNodesNumber := 0;
        if (pDescendant) then
            lQuery := '//Node[@RecordID=''' + Format(pRecordID) + ''']/descendant::Variable'
        else
            lQuery := '//Node[@RecordID=''' + Format(pRecordID) + ''']/BOQs/Variable';
        //GL2024 Automation non compatible   lXmlNodes := wXmlRoot.selectNodes(lQuery);
        //GL2024 Automation non compatible  Evaluate(lXmlNodesNumber, Format(lXmlNodes.length));
        Retour := (lXmlNodesNumber <> 0);

    end;


    procedure LoadFromFile(pFileName: Text[1024]) return: Boolean
    begin
        //#7267
        /***********************************************
        *                  LoadFromFile               *
        ***********************************************
        * Entrée : Néant                              *
        * Sortie : Néant                              *
        ***********************************************
        * Charge le document XML à partir de la table *
        * de stockage des BOQ                         *
        ***********************************************/
        //#6872
        fSetDefaultNode();
        //#6872//
        fConstInitialize();
        /* //GL2024 Automation non compatible if ISCLEAR(wXmlDoc) then
              Create(wXmlDoc);

          return := wXmlDoc.load(pFileName);
          if return then begin
              fSaveSingleInstance();
              wXmlDoc.setProperty('SelectionLanguage', 'XPath');
              wXmlRoot := wXmlDoc.documentElement;
          end;*/
        wHasHeader := return;
        //#7267//

    end;

    /*//GL2024 Automation non compatible
        procedure fISEmpty(pXMLDoc: Automation) Retour: Boolean
        var
            lxmltext: Text[1024];
        begin
            //#9194
            exit(false); // HJ
            lxmltext := '';
            Retour := false;
            if (not ISCLEAR(pXMLDoc)) then begin
                lxmltext := CopyStr(pXMLDoc.text, 1, 250);
                Retour := StrLen(lxmltext) = 0;
            end else begin
                Retour := true;
            end;
            //#9194//
        end;*/
}

