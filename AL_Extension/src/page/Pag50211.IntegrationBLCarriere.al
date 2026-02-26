
// //HS New page  (modif lors d'importation nouvelle Fob bl carriere demander par mehdi).

// Page 50211 "Integration BL Carriere"
// {
//     DelayedInsert = true;
//     DeleteAllowed = false;
//     InsertAllowed = false;
//     PageType = List;
//     SourceTable = "BL Carriere";
//     SourceTableView = SORTING("N° Societe", "N° Sequence", Annee, ID)
//                     WHERE("N° Societe" = FILTER('C'),
//                           "Integerer BL Beton" = FILTER(false),
//                           "Code Commande Vente" = FILTER(''));
//     ApplicationArea = all;
//     UsageCategory = Administration;
//     Caption = 'Integration BL Carriere';

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1120011)
//             {
//                 ShowCaption = false;
//                 field(Date; REC.Date)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("N° Sequence"; REC."N° Sequence")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'N° BL';
//                     Editable = false;
//                     Style = Unfavorable;
//                     StyleExpr = true;
//                 }
//                 field("Code Produit"; REC."Code Produit")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Chantier; REC.Chantier)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Code Client"; Rec."Code Client")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Client Nav"; Rec."Client Nav")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Nom Client"; Rec."Nom Client")
//                 {
//                     ApplicationArea = all;
//                     Editable = true;
//                 }
//                 field("Chantier Client"; Rec."Chantier Client")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Code Chantier Client"; Rec."Code Chantier Client")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Produit Nav"; REC."Produit Nav")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Description Produit Nav"; REC."Description Produit Nav")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Produit Navision 2"; Rec."Produit Navision 2")
//                 {
//                     ApplicationArea = all;
//                     Editable = true;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Chantier Nav"; REC."Chantier Nav")
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Quantité"; REC.Quantité)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Quantité en Tonne"; Rec."Quantité en Tonne")
//                 {
//                     ApplicationArea = all;
//                     Editable = true;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field(PU; Rec.PU)
//                 {
//                     ApplicationArea = all;
//                     Editable = true;

//                 }
//                 field(Selectionner; Rec.Selectionner)
//                 {
//                     ApplicationArea = all;
//                     Editable = true;

//                 }
//                 field(Interne; Rec.Interne)
//                 {
//                     ApplicationArea = all;
//                     Editable = true;

//                 }
//                 field("Commande Associer"; Rec."Commande Associer")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 //////
//                 // field("N° Societe"; REC."N° Societe")
//                 // {
//                 //     ApplicationArea = all;
//                 //     Editable = false;
//                 //     Visible = false;
//                 // }


//                 // field("Integerer BL Beton"; REC."Integerer BL Beton")
//                 // {
//                 //     ApplicationArea = all;
//                 //     Editable = false;
//                 //     Visible = false;
//                 // }





//                 // field("Code Commande Vente"; REC."Code Commande Vente")
//                 // {
//                 //     ApplicationArea = all;
//                 //     Visible = false;
//                 // }
//                 // field(Camion; REC.Camion)
//                 // {
//                 //     ApplicationArea = all;
//                 //     Editable = false;
//                 // }
//                 // field("Camion Nav"; REC."Camion Nav")
//                 // {
//                 //     ApplicationArea = all;
//                 //     Editable = false;
//                 // }
//                 // field(Chauffeur; REC.Chauffeur)
//                 // {
//                 //     ApplicationArea = all;
//                 //     Editable = false;
//                 // }
//                 // field("Sous Affectation Marche"; REC."Sous Affectation Marche")
//                 // {
//                 //     ApplicationArea = all;
//                 //     Editable = true;
//                 //     Visible = false;
//                 // }
//                 // field("Affectation Marche"; REC."Affectation Marche")
//                 // {
//                 //     ApplicationArea = all;
//                 //     Editable = true;
//                 //     Visible = false;
//                 // }
//                 // field(Provenance; REC.Provenance)
//                 // {
//                 //     ApplicationArea = all;
//                 //     Editable = false;
//                 // }
//                 // field(Destination; REC.Destination)
//                 // {
//                 //     ApplicationArea = all;
//                 //     Editable = false;
//                 // }
//                 // field("Distance Parcourus"; REC."Distance Parcourus")
//                 // {
//                 //     ApplicationArea = all;
//                 //     Editable = false;
//                 // }
//                 // field(Volume; REC.Volume)
//                 // {
//                 //     ApplicationArea = all;
//                 //     Editable = false;
//                 // }
//                 // field("Durée Theorique (Minute)"; REC."Durée Theorique (Minute)")
//                 // {
//                 //     ApplicationArea = all;
//                 //     Editable = false;
//                 // }
//                 // field(Heure; REC.Heure)
//                 // {
//                 //     ApplicationArea = all;
//                 //     Editable = false;
//                 // }
//                 // field("Deuxiéme Controle"; REC."Deuxiéme Controle")
//                 // {
//                 //     ApplicationArea = all;
//                 //     Style = Strong;
//                 //     StyleExpr = true;
//                 // }
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             action(Validate)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Valider';
//                 Image = Post;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;
//                 trigger OnAction()
//                 var


//                 begin

//                     IF NOT CONFIRM(Text003) THEN EXIT;
//                     RecSalesReceivablesSetup.GET;
//                     RecBLCarriere.COPY(Rec);
//                     RecBLCarriere.SETRANGE(Selectionner, TRUE);
//                     RecBLCarriere.SETRANGE("N° Societe", Rec."N° Societe");
//                     IF RecBLCarriere.FINDFIRST THEN
//                         REPEAT
//                             CLEAR(RecSalesHeader);
//                             CLEAR(RecSalesLine);
//                             RecBLCarriere.CALCFIELDS("Produit Nav", "Client Nav", "Nom Client", "Code Chantier Client");
//                             IF RecBLCarriere."Client Nav" = '' THEN ERROR(Text001, RecBLCarriere."Code Client");
//                             IF RecBLCarriere."Produit Navision 2" = '' THEN BEGIN
//                                 IF RecBLCarriere."Produit Nav" = '' THEN ERROR(Text002, RecBLCarriere."Produit Nav");
//                             END;
//                             // Insertion Entet Vente
//                             RecSalesHeader.VALIDATE("Document Type", RecSalesHeader."Document Type"::Order);
//                             RecSalesHeader.VALIDATE("No.", NoSeriesMgt.GetNextNo(RecSalesReceivablesSetup."Order Nos.", RecBLCarriere.Date, TRUE));
//                             RecSalesHeader.VALIDATE("Posting Date", RecBLCarriere.Date);
//                             IF (RecBLCarriere."Code Client" = '') OR (RecBLCarriere."Code Client" = '') THEN BEGIN
//                                 RecSalesHeader.VALIDATE("Sell-to Customer No.", RecBLCarriere."Code Chantier Client");
//                             END
//                             ELSE BEGIN
//                                 RecSalesHeader.VALIDATE("Sell-to Customer No.", RecBLCarriere."Client Nav");
//                             END;
//                             RecSalesHeader.VALIDATE("Job No.", 'VENTECARRIEREJO'); //RecBLCarriere."Job No"
//                             RecSalesHeader.VALIDATE("External Document No.", RecBLCarriere."N° Sequence");
//                             RecSalesHeader.VALIDATE("No. Series", RecSalesReceivablesSetup."Order Nos.");
//                             RecSalesHeader.VALIDATE("Posting No. Series", RecSalesReceivablesSetup."Posted Invoice Nos.");
//                             RecSalesHeader.VALIDATE("Shipping No. Series", RecSalesReceivablesSetup."Posted Shipment Nos.");
//                             RecSalesHeader."External Document No." := RecBLCarriere."N° Sequence";
//                             RecSalesHeader."Prices Including VAT" := TRUE;
//                             IF RecBLCarriere.Interne THEN
//                                 RecSalesHeader."Commande Interne" := TRUE ELSE
//                                 RecSalesHeader."Commande Interne" := FALSE;
//                             RecSalesHeader."User ID" := UPPERCASE(USERID);
//                             IF RecBLCarriere."Client Nav" = 'CPV-0999' THEN BEGIN
//                                 RecSalesHeader."Sell-to Customer Name" := RecBLCarriere."Nom Client";
//                                 RecSalesHeader."Bill-to Name" := RecBLCarriere."Nom Client";
//                             END;
//                             IF NOT RecSalesHeader.INSERT THEN RecSalesHeader.MODIFY;
//                             // Insertion Lignie Vente
//                             RecSalesLine.VALIDATE("Document Type", RecSalesLine."Document Type"::Order);
//                             RecSalesLine.VALIDATE("Document No.", RecSalesHeader."No.");
//                             RecSalesLine.VALIDATE(Type, RecSalesLine.Type::Item);
//                             RecSalesLine."Line No." := 10000;
//                             IF RecBLCarriere."Produit Navision 2" <> '' THEN BEGIN
//                                 RecSalesLine.VALIDATE("No.", RecBLCarriere."Produit Navision 2");
//                             END
//                             ELSE
//                                 RecSalesLine.VALIDATE("No.", RecBLCarriere."Produit Nav");
//                             BEGIN
//                             END;
//                             IF Rec."N° Societe" = 'C' THEN
//                                 RecSalesLine.VALIDATE(Quantity, RecBLCarriere."Quantité en Tonne")
//                             ELSE
//                                 RecSalesLine.VALIDATE(Quantity, RecBLCarriere.Quantité);

//                             IF Rec.PU <> 0 THEN
//                                 RecSalesLine.VALIDATE("Unit Price", Rec.PU)
//                             ELSE
//                                 ERROR(Text007, RecBLCarriere."N° Sequence");
//                             IF NOT RecSalesLine.INSERT THEN RecSalesLine.MODIFY;
//                             // Validation Commande Vente
//                             // Insertion N° Bpn de Commande dans la liste des BL Carriere
//                             RecBLCarriere."Integerer BL Beton" := TRUE;
//                             RecBLCarriere."Code Commande Vente" := RecSalesHeader."No.";
//                             RecBLCarriere.Selectionner := FALSE;
//                             RecBLCarriere.MODIFY;
//                         UNTIL RecBLCarriere.NEXT = 0;
//                     CurrPage.UPDATE;
//                     MESSAGE(Text004);
//                 end;
//             }
//             action(Recuperer)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Récupérer';
//                 Image = Post;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;
//                 trigger OnAction()
//                 var
//                 begin
//                     RecupererBL();
//                 end;
//             }
//             action("Recuper Carriere")
//             {
//                 ApplicationArea = all;
//                 Caption = 'Récuper Carriere';
//                 Image = Post;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;
//                 RunObject = xmlport "Recuper Carriere V2";

//             }
//         }
//     }
//     procedure RecupererBL()
//     var

//         SQLString: Text[1000];
//         RecordsAffected: Text[1000];
//         RSOption: Integer;
//         FieldValue: Integer;
//         ConnectString: Text[1000];
//         Datecalcul: Date;
//         RecGeneralleadgersetup: Record "General Ledger Setup";
//         ServeurXRT: Text[30];
//         BaseXRT: Text[30];
//         Password: Code[20];
//         ERR1: Label 'Impossible de créer la variable de connection autonome ADO';
//         ERR2: Label 'Impossible de créer la variable de curseur automation ADO';
//         ERR3: Label 'Vous devez saisir le nom du serveur XRT dans paramètre comptabilité';
//         ERR4: Label 'Vous devez saisir le nom de la base XRT dans paramètre comptabilité';
//     begin

//         /*Hs Automation    IF NOT CONFIRM(Text003, FALSE) THEN EXIT;
//          IF ISCLEAR(ADOConnection) THEN BEGIN
//              IF NOT CREATE(ADOConnection) THEN BEGIN
//                  ERROR(ERR1);
//              END;
//          END;

//          IF ISCLEAR(ADORecSet) THEN BEGIN
//              IF NOT CREATE(ADORecSet) THEN BEGIN
//                  ERROR(ERR2);
//              END;
//          END;
//          //IF RecGeneralleadgersetup.GET THEN
//          //  BEGIN
//          //    ServeurXRT :='10.100.192.2';
//          //    BaseXRT    :='CENTRALEZ4';
//          //    Password   :='consultation';
//          //  END;

//          IF RecGeneralleadgersetup.GET THEN BEGIN
//              ServeurXRT := '10.100.192.86\sqlexpress';
//              BaseXRT := 'BD_TRAVAIL';
//              Password := 'consultation';
//          END;


//          IF ServeurXRT = '' THEN
//              ERROR(ERR3);
//          IF BaseXRT = '' THEN
//              ERROR(ERR4);
//          ConnectString := 'Provider=SQLOLEDB.1;Data Source=' + ServeurXRT + ';'
//                           + 'Initial Catalog=' + BaseXRT + ';User ID=consultation;Password=123';

//          //MESSAGE(ConnectString);
//          ADOConnection.ConnectionString(ConnectString);


//          ADOConnection.Open;
//          RecordsAffected := '';
//          RSOption := 0;
//          Datecalcul := WORKDATE;
//          IF SalesReceivablesSetup.GET() THEN BEGIN
//              ParamNumero := SalesReceivablesSetup."Parametre Numero ID";
//              ParamClient := SalesReceivablesSetup."Parametre Numero Client";
//              ParamChantier := SalesReceivablesSetup."Parametre Numero Chantier";
//              ParamProduit := SalesReceivablesSetup."Parametre Numero Produit";
//              ParamIDdetailsCons := SalesReceivablesSetup."Parametre ID details Conso";
//          END;
//          //ParamNumero:=42629;
//          //***************** TABLE BL
//          //SQLString := 'select * from T_BL where BL_ID> 42630';

//          SQLString := 'select *,Cast(BL_CubageLivre as varchar(10)) as CubageLivre,' +
//                  'Cast(BL_Heure_Premiere_Gachee as varchar(10)) as HeurePremiere,' +
//                  'Cast(BL_CubageLivre as Decimal(5,1)) as CubageLivre2 from T_BL where BL_ID>' + FORMAT(ParamNumero);


//          ADORecSet := ADOConnection.Execute(SQLString, RecordsAffected, RSOption);
//          IF NOT ADORecSet.EOF THEN BEGIN
//              ADORecSet.MoveFirst;
//              REPEAT
//                  RecEnteteRecupération."N° Societe" := 'BZ4';
//                  RecEnteteRecupération.Date := ADORecSet.Fields.Item('BL_DateLanceFab').Value;
//                  RecEnteteRecupération."N° Sequence" := FORMAT(ADORecSet.Fields.Item('BL_Numero').Value);
//                  Chaine := ADORecSet.Fields.Item('CubageLivre').Value;
//                  Chaine := CONVERTSTR(Chaine, '.', ',');
//                  HeureBL := ADORecSet.Fields.Item('HeurePremiere').Value;
//                  EVALUATE(RecEnteteRecupération.Quantité, Chaine);
//                  //RecEnteteRecupération.Quantité:=ADORecSet.Fields.Item('BL_CubageLivre').Value;
//                  //RecEnteteRecupération.Heure:=ADORecSet.Fields.Item('BL_Heure_Premiere_Gachee').Value;
//                  EVALUATE(RecEnteteRecupération.Heure, HeureBL);
//                  RecEnteteRecupération.Nature := ADORecSet.Fields.Item('FOR_Nature_Cim').Value;
//                  RecEnteteRecupération.Dosage := ADORecSet.Fields.Item('FOR_Dosage_CKA_Reel').Value;
//                  RecEnteteRecupération.Adjuvant := ADORecSet.Fields.Item('FOR_Adjuvant').Value;
//                  RecEnteteRecupération.Pompe := ADORecSet.Fields.Item('PRO_Nom0').Value;
//                  RecEnteteRecupération.Camion := ADORecSet.Fields.Item('CAM_Code').Value;
//                  RecEnteteRecupération."Nom Chauffeur" := ADORecSet.Fields.Item('CHF_Nom').Value;
//                  RecEnteteRecupération."Code Client" := ADORecSet.Fields.Item('CLI_Code').Value;
//                  RecEnteteRecupération.Chantier := ADORecSet.Fields.Item('CHA_Code').Value;
//                  RecEnteteRecupération."Code Produit" := ADORecSet.Fields.Item('FOR_Code').Value;
//                  SalesReceivablesSetup."Parametre Numero ID" := ADORecSet.Fields.Item('BL_ID').Value;
//                  SalesReceivablesSetup.MODIFY;

//                  IF RecEnteteRecupération.INSERT(TRUE) THEN;
//                  ADORecSet.MoveNext;
//              UNTIL ADORecSet.EOF;
//          END;
//          ADORecSet.Close;
//          //***************** TABLE BL

//          //***************** TABLE CLIENT
//          SQLString := 'select * from T_CLIENT where CLI_ID>' + FORMAT(ParamClient);

//          ADORecSet := ADOConnection.Execute(SQLString, RecordsAffected, RSOption);
//          IF NOT ADORecSet.EOF THEN BEGIN
//              ADORecSet.MoveFirst;
//              REPEAT
//                  ClientRecupération."N° Societe" := 'BZ4';
//                  ClientRecupération."Code Client" := ADORecSet.Fields.Item('CLI_Code').Value;
//                  ClientRecupération."Designation Client" := ADORecSet.Fields.Item('CLI_Nom').Value;
//                  SalesReceivablesSetup."Parametre Numero Client" := ADORecSet.Fields.Item('CLI_ID').Value;
//                  SalesReceivablesSetup.MODIFY;

//                  IF ClientRecupération.INSERT(TRUE) THEN;
//                  ADORecSet.MoveNext;
//              UNTIL ADORecSet.EOF;
//          END;
//          ADORecSet.Close;
//          //***************** TABLE CLIENT

//          //***************** TABLE CHANTIER
//          SQLString := 'select * from T_CHANTIER where CHA_ID>' + FORMAT(ParamChantier);

//          ADORecSet := ADOConnection.Execute(SQLString, RecordsAffected, RSOption);
//          IF NOT ADORecSet.EOF THEN BEGIN
//              ADORecSet.MoveFirst;
//              REPEAT
//                  ChantierRecupération."N° Societe" := 'BZ4';
//                  ChantierRecupération.Chantier := ADORecSet.Fields.Item('CHA_Code').Value;
//                  ChantierRecupération.Client := ADORecSet.Fields.Item('CLI_Code').Value;
//                  ChantierRecupération."Designation Chantier" := ADORecSet.Fields.Item('CHA_Nom').Value;
//                  SalesReceivablesSetup."Parametre Numero Chantier" := ADORecSet.Fields.Item('CHA_ID').Value;
//                  SalesReceivablesSetup.MODIFY;

//                  IF ChantierRecupération.INSERT(TRUE) THEN;
//                  ADORecSet.MoveNext;
//              UNTIL ADORecSet.EOF;
//          END;
//          ADORecSet.Close;
//          //***************** TABLE CHANTIER

//          //***************** TABLE PRODUIT
//          SQLString := 'select * from T_FORMULE where FOR_ID>' + FORMAT(ParamProduit);

//          ADORecSet := ADOConnection.Execute(SQLString, RecordsAffected, RSOption);
//          IF NOT ADORecSet.EOF THEN BEGIN
//              ADORecSet.MoveFirst;
//              REPEAT
//                  ProduitRecupération."N° Societe" := 'BZ4';
//                  ProduitRecupération."Code Produit" := ADORecSet.Fields.Item('FOR_Code').Value;
//                  ProduitRecupération."Designation Produit" := ADORecSet.Fields.Item('FOR_Nom').Value;
//                  SalesReceivablesSetup."Parametre Numero Produit" := ADORecSet.Fields.Item('FOR_ID').Value;
//                  SalesReceivablesSetup.MODIFY;

//                  IF ProduitRecupération.INSERT(TRUE) THEN;
//                  ADORecSet.MoveNext;
//              UNTIL ADORecSet.EOF;
//          END;
//          ADORecSet.Close;
//          //***************** TABLE PRODUIT

//          //***************** TABLE DETAILS CONSOMMATION
//          SQLString := 'select * ,Cast(CON_Quantite as varchar(10)) as Qte from T_CONSO_DETAILS where CON_ID>' + FORMAT(ParamIDdetailsCons);

//          ADORecSet := ADOConnection.Execute(SQLString, RecordsAffected, RSOption);
//          IF NOT ADORecSet.EOF THEN BEGIN
//              ADORecSet.MoveFirst;
//              REPEAT
//                  DetailsConsommationBL.Con_ID := FORMAT(ADORecSet.Fields.Item('CON_ID').Value);
//                  DetailsConsommationBL.Mat_Code := FORMAT(ADORecSet.Fields.Item('MAT_CODE').Value);
//                  Chaine := ADORecSet.Fields.Item('Qte').Value;
//                  Chaine := CONVERTSTR(Chaine, '.', ',');
//                  EVALUATE(DetailsConsommationBL.Quantité, Chaine);
//                  DetailsConsommationBL.Num_BL := FORMAT(ADORecSet.Fields.Item('CON_BL').Value);
//                  SalesReceivablesSetup."Parametre ID details Conso" := ADORecSet.Fields.Item('CON_ID').Value;
//                  SalesReceivablesSetup.MODIFY;
//                  IF DetailsConsommationBL.INSERT(TRUE) THEN;
//                  ADORecSet.MoveNext;
//              UNTIL ADORecSet.EOF;
//          END;
//          ADORecSet.Close;
//          //***************** TABLE DETAILS CONSOMMATION

//          //***************** TABLE MATERIAUX
//          SQLString := 'select * FROM T_MATERIAU';

//          ADORecSet := ADOConnection.Execute(SQLString, RecordsAffected, RSOption);
//          IF NOT ADORecSet.EOF THEN BEGIN
//              ADORecSet.MoveFirst;
//              REPEAT
//                  MateriauxBLBeton.Mat_ID := FORMAT(ADORecSet.Fields.Item('MAT_ID').Value);
//                  MateriauxBLBeton.Mat_Code := FORMAT(ADORecSet.Fields.Item('MAT_Code').Value);
//                  MateriauxBLBeton.Mat_Nom := FORMAT(ADORecSet.Fields.Item('MAT_Nom').Value);
//                  MateriauxBLBeton.Mat_Unité := FORMAT(ADORecSet.Fields.Item('MAT_DosageUnite').Value);
//                  IF MateriauxBLBeton.INSERT(TRUE) THEN;
//                  ADORecSet.MoveNext;
//              UNTIL ADORecSet.EOF;
//          END;
//          ADORecSet.Close;
//          //***************** TABLE TABLE MATERIAUX


//          ADOConnection.Close;
//          MESSAGE(Text006);*/
//     end;
//     /*HS trigger OnAfterGetRecord()
//       begin
//           REC.CalcFields("Chantier Nav", "Camion Nav", "Produit Nav");
//       end;

//       trigger OnOpenPage()
//       begin
//           if UserSetup.Get(UpperCase(UserId)) then
//               if UserSetup."Affaire Par Defaut" <> '' then begin
//                   ChantierCarriere.SetRange(Correspondance, UserSetup."Affaire Par Defaut");
//                   if ChantierCarriere.FindFirst then
//                       REC.SetRange(Chantier, ChantierCarriere.Chantier);
//               end;
//       end;
//   */
//     var
//         //Text001: label '#1 lines selected.\Are you sure to want to validate the selected lines ?';
//         Job: Record Job;
//         BlCarriere: Record "BL Carriere";
//         UserSetup: Record "User Setup";
//         ChantierCarriere: Record "Chantier Carriere";
//         ItemJournalLine: Record "Item Journal Line";
//         ItemJrlLine2: Record "Item Journal Line";
//         PurchaseLine: Record "Purchase Line";
//         Ligne: Integer;
//         EnteteRendemenVehEnr: Record "Entete rendement Vehicule Enr";
//         LigneRendVehiculeEnr: Record "Ligne Rendement Vehicule Enr";
//         LigneRendVehiculeEnr2: Record "Ligne Rendement Vehicule Enr";
//         Compteur: Integer;
//         // Text002: label 'Traitement Achevé Avec Succé';

//         Text001: label 'Vous devez vérifier la correspondance de base client pour le client %1';
//         Text002: label 'Vous devez vérifier la correspondance de base article pour l''article %1';
//         Text003: label 'Lancer La Creation Des Commandes ?';
//         Text004: label 'Taches Achever Avec Succée';
//         Text005: label 'Lancer La Récupération ?';
//         Text006: label 'Action Achever Avec Succé';
//         Text007: label 'Prix Unitaire doite Etre Mentionné Bon N° %1';
//         NoSeriesMgt: Codeunit NoSeriesManagement;
//         RecSalesReceivablesSetup: Record "Sales & Receivables Setup";
//         RecBLCarriere: Record "BL Carriere";
//         RecSalesHeader: Record "Sales Header";
//         RecSalesLine: Record "Sales Line";
//         RecSalesHeader2: Record "Sales Header";
//         ParamNumero: Integer;
//         Chaine: Text[30];
//         dec: Decimal;
//         SQLString: Text[1000];
//         ConnectString: Text[1000];
//         ServeurXRT: Text[30];
//         UserXRT: Text[30];
//         Password: Code[20];
//         RecEnteteRecupération: Record "BL Carriere";
//         ClientRecupération: Record "Client Carriere";
//         ChantierRecupération: Record "Chantier Carriere";
//         ProduitRecupération: Record "Produit Carriere";
//         SalesReceivablesSetup: Record "Sales & Receivables Setup";
//         ParamClient: Integer;
//         ParamChantier: Integer;
//         ParamProduit: Integer;
//         DetailsConsommationBL: Record "Details Consommation BL Beton";
//         ParamIDdetailsCons: Integer;
//         MateriauxBLBeton: Record "Materiaux BL Beton";
//         HeureBL: Text[30];
// }

