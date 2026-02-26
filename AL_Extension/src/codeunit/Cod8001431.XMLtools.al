Codeunit 8001431 "XML tools"
{

    trigger OnRun()
    begin
    end;

    var
        Text001: label 'Code Erreur : %1\URL : %2\ reason : %3\srcText : %4\ Line : %5\ LinePos : %6\Filepos : %7';

    //GL2024 Automation non compatible
    // procedure CreateXML(var pXmlDoc: Automation )
    // var
    //     lXmlNode: Automation ;
    // begin
    //     /*<Methode Name="CreateXML" Local="FALSE">
    //       <Summary>"Création d'une instance d'un document XML"</Summary>
    //       <Flow>
    //         <Input Type="'Microsoft XML, v4.0'.DOMDocument" Var="TRUE"/>
    //       </Flow>
    //     </Methode>*/

    //     //Instenciation l'OCX
    //     DestroyXML(pXmlDoc);
    //     Create(pXmlDoc);

    //     //paramétrage des propriétés de l'OCX
    //     lSetProperties(pXmlDoc);

    //     // Genere l'entete du document
    //     lXmlNode := pXmlDoc.createProcessingInstruction('xml', 'version="1.0"  encoding="UTF-8"');
    //     pXmlDoc.insertBefore(lXmlNode, pXmlDoc.childNodes.item(0));

    // end;
    //GL2024 Automation non compatible
    // local procedure lSetProperties(var pXmlDoc: Automation )
    // begin
    //     /*<Methode Name="lSetProperties" Local="TRUE">
    //       <Summary>"Charge les propriétés par défaut de l'instance de l'OCX"</Summary>
    //       <Flow>
    //         <Input Type="'Microsoft XML, v4.0'.DOMDocument" Var="TRUE"/>
    //       </Flow>
    //     </Methode>*/
    //     pXmlDoc.async := false;
    //     pXmlDoc.validateOnParse := true;
    //     pXmlDoc.setProperty('SelectionLanguage', 'XPath');

    // end;

    //GL2024 Automation non compatible
    // procedure DestroyXML(var pXmlDoc: Automation )
    // begin
    //     /*<Methode Name="DestroyXML" Local="FALSE">
    //       <Summary>"Destruction d'une instance d'un document XML"</Summary>
    //       <Flow>
    //         <Input Type="'Microsoft XML, v4.0'.DOMDocument" Var="TRUE"/>
    //       </Flow>
    //     </Methode>*/

    //     //Destruction l'OCX
    //     if XMLTestExist(pXmlDoc) then
    //       Clear(pXmlDoc);

    // end;


    procedure XMLTestExist(var pVariant: Variant): Boolean
    var
        tError001: label 'This méthod can''t be called with this type of variable';
    begin
        /*<Methode Name="XMLTestExist" Local="FALSE">
          <Summary>
            "Test si l'OCX est instancié.
            Cette fonction peut être utiliser pour tester un doc, un noeud, un attribut ou une liste d'élément du fichier XML."
          </Summary>
          <Flow>
            <Input Type="Variant" Var="TRUE"/>
            <Output Type="Boolean"/>
          </Flow>
        </Methode>*/

        //test du type de variable
        if not pVariant.ISAUTOMATION then
            Error(tError001);

        //GL2024 Automation non compatible  exit(not ISCLEAR(pVariant));

    end;

    //GL2024 Automation non compatible
    // procedure XMLVerifyByXSD(var pXmlDoc: Automation ;pShowErrorMessage: Boolean) Return: Boolean
    // var
    //     lXmlParseError: Automation ;
    // begin
    //     /*<Methode Name="XMLVerifyByXSD" Local="FALSE">
    //       <Summary>Cette Fonction permet de tester un fichier XML en fonction d'un schema XSD</Summary>
    //       <Flow>
    //         <Input Type="'Microsoft XML, v4.0'.DOMDocument" Var="TRUE"/>
    //         <Input Type="Boolean" Var="FALSE">"Pour afficher un message en cas d'erreur"</Input>
    //         <Output Type="Boolean"/>
    //       </Flow>
    //     </Methode>*/

    //     lXmlParseError := pXmlDoc.validate;
    //     Return := (lXmlParseError.errorCode <> 0);

    //     if Return and pShowErrorMessage then
    //       Message(Text001,
    //                lXmlParseError.errorCode, lXmlParseError.url,
    //                lXmlParseError.reason, lXmlParseError.srcText,
    //                lXmlParseError.line, lXmlParseError.linepos,
    //                lXmlParseError.filepos);

    // end;
    //GL2024 Automation non compatible
    // local procedure lInitializeCacheXSD(var pXmlDoc: Automation ;var pXmlShema: Automation ;pNameSpace: Text[250];pSchemaLoc: Text[250])
    // var
    //     lXmlCache: Automation ;
    // begin
    //     /*<Methode Name="lInitializeCacheXSD" Local="TRUE">
    //       <Summary>
    //         "Cette Fonction permet de charger un schema XSD dans une instance d'un document Xml"
    //       </Summary>
    //       <Flow>
    //         <Input Type="'Microsoft XML, v4.0'.DOMDocument" Var="TRUE"/>
    //       </Flow>
    //     </Methode>*/

    //     Create(lXmlCache);
    //     lXmlCache.add(pNameSpace,pSchemaLoc);
    //     pXmlDoc.schemas(lXmlCache);

    // end;

    //GL2024 Automation non compatible
    // procedure LoadXMLFromFile(var pXmlDoc: Automation ;pFileRoot: Text[1024]) Return: Boolean
    // begin
    //     /*<Methode Name="LoadXMLFromFile" Local="FALSE">
    //       <Summary>"Charger une instance Xml à partir d'un fichier"</Summary>
    //       <Flow>
    //         <Input Type="'Microsoft XML, v4.0'.DOMDocument" Var="TRUE"/>
    //         <Input Type="Text(1024)" Var="FALSE"/>
    //         <Output Type="Boolean">Le fichier est correctement chargé</Output>
    //       </Flow>
    //     </Methode>*/

    //     Return := pXmlDoc.load(pFileRoot);
    //     //paramétrage des propriétés de l'OCX
    //     if Return then
    //      lSetProperties(pXmlDoc);

    // end;
    //GL2024 Automation non compatible

    // procedure LoadXMLFromStream(var pXmlDoc: Automation ;pInStream: InStream) Return: Boolean
    // begin
    //     /*<Methode Name="LoadXMLFromStream" Local="FALSE">
    //       <Summary>"Charger une instance Xml à partir d'un flux"</Summary>
    //       <Flow>
    //         <Input Type="'Microsoft XML, v4.0'.DOMDocument" Var="TRUE"/>
    //         <Input Type="InStream" Var="FALSE"/>
    //         <Output Type="Boolean">Le fichier est correctement chargé</Output>
    //       </Flow>
    //     </Methode>*/

    //     Return := pXmlDoc.load(pInStream);
    //     //paramétrage des propriétés de l'OCX
    //     if Return then
    //      lSetProperties(pXmlDoc);

    // end;

    //GL2024 Automation non compatible
    // procedure SaveXMLToFile(var pXmlDoc: Automation ;pFileRoot: Text[1024];pOverwrite: Boolean): Boolean
    // begin
    //     /*<Methode Name="SaveXMLToFile" Local="FALSE">
    //       <Summary>Sauvegarde le flux de données XML dans un fichier</Summary>
    //       <Flow>
    //         <Input Type="'Microsoft XML, v4.0'.DOMDocument" Var="TRUE"/>
    //         <Input Type="Text(1024)" Var="FALSE">Emplacement du fichier</Input>
    //         <Input Type="boolean" Var="FALSE">Autorise l'écrasement du fichier</Input>
    //         <Output Type="Boolean">retourne False si le fichier XML n'a pas été sauvegarder</Output>
    //       </Flow>
    //     </Methode>*/

    //     //Test si le fichier de destination existe
    //     if not pOverwrite and Exists(pFileRoot) then
    //       exit(false);
    //     //Sauvegarde du fichier
    //     pXmlDoc.save(pFileRoot);
    //     exit(true);

    // end;

    //GL2024 Automation non compatible
    // procedure SaveXMLToStream(var pXmlDoc: Automation ;var pOutStream: OutStream)
    // begin
    //     /*<Methode Name="SaveXMLToStream" Local="FALSE">
    //       <Summary>Sauvegarde le flux de données XML dans un flux de données</Summary>
    //       <Flow>
    //         <Input Type="'Microsoft XML, v4.0'.DOMDocument" Var="TRUE"/>
    //         <Input Type="OutStream" Var="TRUE"/>
    //       </Flow>
    //     </Methode>*/
    //     //Sauvegarde du fichier
    //     pXmlDoc.save(pOutStream);

    // end;

    //GL2024 Automation non compatible
    // procedure CreateNode(var pXmlDoc: Automation ;var pXmlNode: Automation ;pNodeName: Text[260])
    // begin
    //     /*<Methode Name="CreateNode" Local="FALSE">
    //       <Summary>Créer un noeud</Summary>
    //       <Flow>
    //         <Input Type="'Microsoft XML, v4.0'.DOMDocument" Var="TRUE">Document XML</Input>
    //         <Input Type="'Microsoft XML, v4.0'.IXMLDOMNode" Var="TRUE">Noeud à créer</Input>
    //         <Input Type="Text(260)" Var="TRUE">Nom du Noeud à créer</Input>
    //       </Flow>
    //     </Methode>*/
    //     pXmlNode := pXmlDoc.createElement(pNodeName);

    // end;

    //GL2024 Automation non compatible
    // procedure AddAttribute(var pXMLNode: Automation ;pName: Text[260];pNodeValue: Text[260]) return: Boolean
    // var
    //     lXMLNewAttributeNode: Automation ;
    // begin
    //     /*<Methode Name="AddAttribute" Local="FALSE">
    //       <Summary></Summary>
    //       <Flow>
    //         <Input Type="'Microsoft XML, v4.0'.IXMLDOMNode" Var="TRUE">Noeud à paramétrer</Input>
    //         <Input Type="Text(260)" Var="FALSE">Nom de l'attribut</Input>
    //         <Input Type="Text(260)" Var="FALSE">Valeur de l'attribut</Input>
    //         <Output Type="Boolean"/>
    //       </Flow>
    //     </Methode>*/

    //     lXMLNewAttributeNode := pXMLNode.ownerDocument.createAttribute(pName);
    //     return := XMLTestExist(lXMLNewAttributeNode) and (pNodeValue <> '');
    //     if return then begin
    //       lXMLNewAttributeNode.nodeValue := pNodeValue;
    //       pXMLNode.attributes.setNamedItem(lXMLNewAttributeNode);
    //     end;

    // end;

    //GL2024 Automation non compatible
    // procedure AppendHeader(var pXmlDoc: Automation ;var pXmlRoot: Automation )
    // begin
    //     /*<Methode Name="AppendHeader" Local="FALSE">
    //       <Summary>
    //         "Ajout de l'entête dand un fichier XML."</Summary>
    //       <Flow>
    //         <Input Type="'Microsoft XML, v4.0'.DOMDocument" Var="TRUE">Document XML</Input>
    //         <Input Type="'Microsoft XML, v4.0'.IXMLDOMNode" Var="TRUE">Noeud de l'entête</Input>
    //       </Flow>
    //     </Methode>*/

    //     //ajout du noeud
    //     pXmlDoc.appendChild(pXmlRoot);

    // end;

    //GL2024 Automation non compatible
    // procedure AppendNode(var pXmlRoot: Automation ;var pXmlNode: Automation )
    // var
    //     lXmlNode: Automation ;
    // begin
    //     /*<Methode Name="AppendNode" Local="FALSE">
    //       <Summary></Summary>
    //       <Flow>
    //         <Input Type="'Microsoft XML, v4.0'.IXMLDOMNode" Var="TRUE">Noeud parent</Input>
    //         <Input Type="'Microsoft XML, v4.0'.IXMLDOMNode" Var="TRUE">Noeud Fils</Input>
    //       </Flow>
    //     </Methode>*/
    //     //ajout du noeud
    //     pXmlRoot.appendChild(pXmlNode);

    // end;

    //GL2024 Automation non compatible
    // procedure FindRootNode(pXmlDoc: Automation ;var pXmlRoot: Automation ) return: Boolean
    // begin
    //     /*<Methode Name="" Local="FALSE">
    //       <Summary></Summary>
    //       <Flow>
    //         <Input Type="'Microsoft XML, v4.0'.DOMDocument" Var="FALSE">Document XML</Input>
    //         <Input Type="'Microsoft XML, v4.0'.IXMLDOMNode" Var="TRUE">Noeud d'origine de la structure XML</Input>
    //         <Output Type="Boolean"/>
    //       </Flow>
    //     </Methode>*/
    //     pXmlRoot := pXmlDoc.documentElement;
    //     return := XMLTestExist(pXmlRoot);

    // end;

    //GL2024 Automation non compatible
    // procedure GetRequestNode(pXmlRoot: Automation ;var pXmlNode: Automation ;pRequest: Text[1024]) Return: Boolean
    // begin
    //     /*<Methode Name="GetRequestNode" Local="FALSE">
    //       <Summary></Summary>
    //       <Flow>
    //         <Input Type="'Microsoft XML, v4.0'.IXMLDOMNode" Var="FALSE">Noeud d'origine de la Requete Xpath</Input>
    //         <Input Type="'Microsoft XML, v4.0'.IXMLDOMNode" Var="TRUE">Noeud de retour</Input>
    //         <Input Type="Text(1024)" Var="FALSE"/>
    //         <Output Type="Boolean"/>
    //       </Flow>
    //     </Methode>*/
    //     pXmlNode := pXmlRoot.selectSingleNode(pRequest);
    //     Return := XMLTestExist(pXmlNode);

    // end;

    //GL2024 Automation non compatible
    // procedure GetRequestNodeList(pXmlRoot: Automation ;var pXmlNodeList: Automation ;pRequest: Text[1024]) Return: Integer
    // begin
    //     /*<Methode Name="" Local="FALSE">
    //       <Summary></Summary>
    //       <Flow>
    //         <Input Type="'Microsoft XML, v4.0'.IXMLDOMNode" Var="FALSE">Noeud d'origine de la Requete Xpath</Input>
    //         <Input Type="'Microsoft XML, v4.0'.IXMLDOMNodeList" Var="TRUE">Liste des Noeuds de retour</Input>
    //         <Input Type="Text(1024)" Var="FALSE"/>
    //         <Output Type="Boolean"/>
    //       </Flow>
    //     </Methode>*/
    //     pXmlNodeList := pXmlRoot.selectNodes(pRequest);
    //     Return := pXmlNodeList.length();

    // end;
}

