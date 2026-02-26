// page 50246 "C.Beton-Production"
// {
//     DelayedInsert = true;
//     DeleteAllowed = false;
//     InsertAllowed = false;
//     PageType = List;
//     SourceTable = "BL Carriere";
//     SourceTableView = SORTING(Date) WHERE("N° Societe" = FILTER('BZ4'), "Production Créer" = CONST(false), "N° Production" = FILTER(''));

//     ApplicationArea = all;
//     UsageCategory = Lists;
//     Caption = 'C.Beton-Production';

//     layout
//     {
//         area(content)
//         {
//             group(Production)
//             {
//                 Caption = 'Production';
//                 repeater(content1)
//                 {
//                     ShowCaption = false;
//                     field(Date; rec.Date)
//                     {
//                         ApplicationArea = all;
//                         Editable = false;
//                         Enabled = true;
//                     }
//                     field(Heure; rec.Heure)
//                     {
//                         ApplicationArea = all;
//                         Editable = false;
//                     }
//                     field("N° Sequence"; rec."N° Sequence")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'BL N°';
//                         Editable = false;
//                     }
//                     field("Code Produit"; rec."Code Produit")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Produit';
//                     }
//                     field("Produit Production"; rec."Produit Production")
//                     {
//                         ApplicationArea = all;
//                     }
//                     field(Nature; rec.Nature)
//                     {
//                         ApplicationArea = all;
//                     }
//                     field(Dosage; rec.Dosage)
//                     {
//                         ApplicationArea = all;
//                     }
//                     field(Adjuvant; rec.Adjuvant)
//                     {
//                         ApplicationArea = all;
//                     }
//                     field("Code Client"; rec."Code Client")
//                     {
//                         ApplicationArea = all;
//                         Editable = false;
//                     }
//                     field("Client Nav"; rec."Client Nav")
//                     {
//                         ApplicationArea = all;
//                         Editable = false;
//                     }
//                     field("Nom Client"; rec."Nom Client")
//                     {
//                         ApplicationArea = all;
//                         Style = Unfavorable;
//                         StyleExpr = TRUE;
//                     }
//                     field("Chantier Client"; rec."Chantier Client")
//                     {
//                         ApplicationArea = all;
//                         Editable = false;
//                     }
//                     field(Quantité; rec.Quantité)
//                     {
//                         ApplicationArea = all;
//                         DecimalPlaces = 0 : 3;
//                         Editable = false;
//                         Style = Strong;
//                         StyleExpr = TRUE;
//                     }
//                     field("Selection Production"; rec."Selection Production")
//                     {
//                         ApplicationArea = all;
//                     }
//                     field(Recuperer2; Recuperer)
//                     {
//                         ApplicationArea = all;
//                         Editable = false;

//                         /* GL2024 trigger OnAssistEdit()
//                           begin
//                               CLEAR(FrmCreerDetProdBeton);
//                               FrmCreerDetProdBeton.GeTBLOrigine(rec."N° Sequence", rec.Quantité);
//                               FrmCreerDetProdBeton.RUNMODAL;
//                               CurrPage.UPDATE;
//                           end;*/
//                     }
//                 }
//             }
//             group("Detail Consommation Automate")
//             {
//                 Caption = 'Detail Consommation Automate';
//                 part("Detail-Consom-Automate"; "Detail-Consom-Automate")
//                 {
//                     ApplicationArea = all;

//                     SubPageLink = "Num_BL" = FIELD("N° Sequence");
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             action("Créer Production")
//             {
//                 ApplicationArea = all;
//                 Caption = 'Créer Production';
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 var
//                     Cdu22event: Codeunit "Item Jnl.-Post Line_CDU22";
//                 begin
//                     IF NOT CONFIRM(Text005) THEN EXIT;
//                     ItemJrlLine2.SETRANGE("Journal Template Name", 'SYNCHRO');
//                     ItemJrlLine2.SETRANGE("Journal Batch Name", 'SYNCHRO');
//                     ItemJrlLine2.DELETEALL;
//                     BLCarriere.COPY(Rec);
//                     BLCarriere.SETRANGE("Selection Production", TRUE);
//                     IF BLCarriere.FINDFIRST THEN
//                         REPEAT
//                             DetailConsommationCentral2.SETRANGE(Num_BL, BLCarriere."N° Sequence");
//                             IF DetailConsommationCentral2.FINDFIRST THEN BEGIN

//                                 i += 1;
//                                 BLCarriere.CALCFIELDS("Produit Production", "Nom Client", "Chantier Client");
//                                 IF BLCarriere."Produit Production" = '' THEN ERROR(Text001, BLCarriere."N° Sequence");
//                                 //--ENTREE PROD
//                                 CLEAR(ItemJournalLine);
//                                 Ligne += 10000;
//                                 ItemJournalLine."Journal Template Name" := 'SYNCHRO';
//                                 ItemJournalLine."Journal Batch Name" := 'SYNCHRO';
//                                 ItemJournalLine."Line No." := Ligne;
//                                 ItemJournalLine."Document No." := COPYSTR('PROD:' + BLCarriere."N° Sequence", 1, 20);
//                                 ItemJournalLine.VALIDATE("Item No.", BLCarriere."Produit Production");
//                                 ItemJournalLine."Qty. per Unit of Measure" := 1;
//                                 ItemJournalLine."Posting Date" := BLCarriere.Date;
//                                 ItemJournalLine."Entry Type" := ItemJournalLine."Entry Type"::"Positive Adjmt.";
//                                 ItemJournalLine.Production := TRUE;
//                                 ItemJournalLine."Source No." := BLCarriere."Produit Production";
//                                 IF BLCarriere."N° Societe" = 'BZ4' THEN BEGIN
//                                     ProductionOrder.Centrale := 'CENTRALZ4';
//                                     ItemJournalLine.VALIDATE("Location Code", 'CENTRALZ4');
//                                     ItemJournalLine."Job No." := 'CENTRALZ4';
//                                 END;
//                                 ItemJournalLine.VALIDATE(Quantity, BLCarriere.Quantité);
//                                 ItemJournalLine."Lieu De Livraison / Provenance" := BLCarriere."Chantier Client";
//                                 ItemJournalLine.Benificiaire := BLCarriere."Nom Client";
//                                 ItemJournalLine."External Document No." := BLCarriere."N° Sequence";
//                                 ItemJournalLine.INSERT;
//                                 //---Sortie PROD
//                                 CLEAR(ItemJournalLine);
//                                 Ligne += 10000;
//                                 ItemJournalLine."Journal Template Name" := 'SYNCHRO';
//                                 ItemJournalLine."Journal Batch Name" := 'SYNCHRO';
//                                 ItemJournalLine."Line No." := Ligne;
//                                 ItemJournalLine."Document No." := COPYSTR('PROD:' + BLCarriere."N° Sequence", 1, 20);
//                                 ItemJournalLine.VALIDATE("Item No.", BLCarriere."Produit Production");
//                                 ItemJournalLine."Qty. per Unit of Measure" := 1;
//                                 ItemJournalLine."Posting Date" := BLCarriere.Date;
//                                 ItemJournalLine."Entry Type" := ItemJournalLine."Entry Type"::"Negative Adjmt.";
//                                 ItemJournalLine.Consommation := TRUE;
//                                 ItemJournalLine."Source No." := BLCarriere."Produit Production";
//                                 IF BLCarriere."N° Societe" = 'BZ4' THEN BEGIN
//                                     ProductionOrder.Centrale := 'CENTRALZ4';
//                                     ItemJournalLine.VALIDATE("Location Code", 'CENTRALZ4');
//                                     ItemJournalLine."Job No." := 'CENTRALZ4';
//                                 END;
//                                 ItemJournalLine.VALIDATE(Quantity, BLCarriere.Quantité);
//                                 ItemJournalLine."Lieu De Livraison / Provenance" := BLCarriere."Chantier Client";
//                                 ItemJournalLine.Benificiaire := BLCarriere."Nom Client";
//                                 ItemJournalLine."External Document No." := BLCarriere."N° Sequence";
//                                 ItemJournalLine.INSERT;
//                                 // SORTIE AGREGAT
//                                 DetailConsommationCentral.SETCURRENTKEY(Mat_Code);
//                                 DetailConsommationCentral.SETRANGE(Num_BL, BLCarriere."N° Sequence");
//                                 CodeTempo := '';
//                                 CLEAR(ItemJournalLine);
//                                 IF DetailConsommationCentral.FINDFIRST THEN
//                                     REPEAT
//                                         DetailConsommationCentral.CALCFIELDS("Quantité Total", Correspondance);
//                                         IF CodeTempo <> DetailConsommationCentral.Mat_Code THEN BEGIN
//                                             //---Sortie CONSOM
//                                             Ligne += 10000;
//                                             ItemJournalLine."Journal Template Name" := 'SYNCHRO';
//                                             ItemJournalLine."Journal Batch Name" := 'SYNCHRO';
//                                             ItemJournalLine."Line No." := Ligne;
//                                             ItemJournalLine."Document No." := COPYSTR('PROD:' + BLCarriere."N° Sequence", 1, 20);
//                                             ItemJournalLine.VALIDATE("Item No.", DetailConsommationCentral.Correspondance);
//                                             ItemJournalLine."Qty. per Unit of Measure" := 1;
//                                             ItemJournalLine."Posting Date" := BLCarriere.Date;
//                                             ItemJournalLine."Entry Type" := ItemJournalLine."Entry Type"::"Negative Adjmt.";
//                                             ItemJournalLine.Consommation := TRUE;
//                                             ItemJournalLine."Source No." := BLCarriere."Produit Production";
//                                             IF BLCarriere."N° Societe" = 'BZ4' THEN BEGIN
//                                                 ProductionOrder.Centrale := 'CENTRALZ4';
//                                                 ItemJournalLine.VALIDATE("Location Code", 'CENTRALZ4');
//                                                 ItemJournalLine."Job No." := 'CENTRALZ4';
//                                             END;
//                                             MateriauxBLBeton.SETRANGE(Mat_Code, DetailConsommationCentral.Mat_Code);
//                                             IF MateriauxBLBeton.FINDFIRST THEN BEGIN
//                                                 IF MateriauxBLBeton."Divison Par" <> 0 THEN
//                                                     ItemJournalLine.VALIDATE(Quantity, DetailConsommationCentral."Quantité Total" / MateriauxBLBeton."Divison Par")
//                                                 ELSE
//                                                     ItemJournalLine.VALIDATE(Quantity, DetailConsommationCentral."Quantité Total");
//                                             END;
//                                             ItemJournalLine."Lieu De Livraison / Provenance" := BLCarriere."Chantier Client";
//                                             ItemJournalLine.Benificiaire := BLCarriere."Nom Client";
//                                             ItemJournalLine."External Document No." := BLCarriere."N° Sequence";
//                                             ItemJournalLine.INSERT;
//                                             CodeTempo := DetailConsommationCentral.Mat_Code;
//                                         END;
//                                     UNTIL DetailConsommationCentral.NEXT = 0
//                                 ELSE
//                                     ERROR(Text003, BLCarriere."N° Sequence");
//                                 BLCarriere."Selection Production" := FALSE;
//                                 BLCarriere."N° Production" := BLCarriere."N° Sequence";
//                                 BLCarriere.MODIFY;
//                             END;
//                         UNTIL BLCarriere.NEXT = 0;
//                     ItemJrlLine2.SETRANGE("Journal Template Name", 'SYNCHRO');
//                     ItemJrlLine2.SETRANGE("Journal Batch Name", 'SYNCHRO');
//                     IF ItemJrlLine2.FINDFIRST THEN BEGIN
//                         ItemJournalLine.SETRANGE("Journal Template Name", 'SYNCHRO');
//                         ItemJournalLine.SETRANGE("Journal Batch Name", 'SYNCHRO');
//                         CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post 2", ItemJournalLine);
//                         Cdu22event.MajEcritureArticleProd;
//                         Cdu22event.MajEcritureArticleConsom;
//                     END;
//                     CurrPage.UPDATE;
//                     MESSAGE(Text004, NumProdInitial, NumProdFinal);
//                 end;
//             }
//             action(Recuperer)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Recuperer';
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 begin
//                     RecupererBL();
//                 end;
//             }
//         }
//     }

//     // Could not resolve the usercontrol owning 'ADORecSet2@1000000060::WillChangeField@9'
//     //trigger WillChangeField(cFields: Integer;"Fields": Variant;adStatus: Integer;pRecordset: Automation )
//     //begin
//     /*
//     */
//     //end;

//     // Could not resolve the usercontrol owning 'ADORecSet2@1000000060::FieldChangeComplete@10'
//     //trigger FieldChangeComplete(cFields: Integer;"Fields": Variant;pError: Automation ;adStatus: Integer;pRecordset: Automation )
//     //begin
//     /*
//     */
//     //end;

//     // Could not resolve the usercontrol owning 'ADORecSet2@1000000060::WillChangeRecord@11'
//     //trigger WillChangeRecord(adReason: Integer;cRecords: Integer;adStatus: Integer;pRecordset: Automation )
//     //begin
//     /*
//     */
//     //end;

//     // Could not resolve the usercontrol owning 'ADORecSet2@1000000060::RecordChangeComplete@12'
//     //trigger RecordChangeComplete(adReason: Integer;cRecords: Integer;pError: Automation ;adStatus: Integer;pRecordset: Automation )
//     //begin
//     /*
//     */
//     //end;

//     // Could not resolve the usercontrol owning 'ADORecSet2@1000000060::WillChangeRecordset@13'
//     //trigger WillChangeRecordset(adReason: Integer;adStatus: Integer;pRecordset: Automation )
//     //begin
//     /*
//     */
//     //end;

//     // Could not resolve the usercontrol owning 'ADORecSet2@1000000060::RecordsetChangeComplete@14'
//     //trigger RecordsetChangeComplete(adReason: Integer;pError: Automation ;adStatus: Integer;pRecordset: Automation )
//     //begin
//     /*
//     */
//     //end;

//     // Could not resolve the usercontrol owning 'ADORecSet2@1000000060::WillMove@15'
//     //trigger WillMove(adReason: Integer;adStatus: Integer;pRecordset: Automation )
//     //begin
//     /*
//     */
//     //end;

//     // Could not resolve the usercontrol owning 'ADORecSet2@1000000060::MoveComplete@16'
//     //trigger MoveComplete(adReason: Integer;pError: Automation ;adStatus: Integer;pRecordset: Automation )
//     //begin
//     /*
//     */
//     //end;

//     // Could not resolve the usercontrol owning 'ADORecSet2@1000000060::EndOfRecordset@17'
//     //trigger EndOfRecordset(var fMoreData: Boolean;adStatus: Integer;pRecordset: Automation )
//     //begin
//     /*
//     */
//     //end;

//     // Could not resolve the usercontrol owning 'ADORecSet2@1000000060::FetchProgress@18'
//     //trigger FetchProgress(Progress: Integer;MaxProgress: Integer;adStatus: Integer;pRecordset: Automation )
//     //begin
//     /*
//     */
//     //end;

//     // Could not resolve the usercontrol owning 'ADORecSet2@1000000060::FetchComplete@19'
//     //trigger FetchComplete(pError: Automation ;adStatus: Integer;pRecordset: Automation )
//     //begin
//     /*
//     */
//     //end;

//     // Could not resolve the usercontrol owning 'ADORecSet@1000000061::WillChangeField@9'
//     //trigger WillChangeField(cFields: Integer;"Fields": Variant;adStatus: Integer;pRecordset: Automation )
//     //begin
//     /*
//     */
//     //end;

//     // Could not resolve the usercontrol owning 'ADORecSet@1000000061::FieldChangeComplete@10'
//     //trigger FieldChangeComplete(cFields: Integer;"Fields": Variant;pError: Automation ;adStatus: Integer;pRecordset: Automation )
//     //begin
//     /*
//     */
//     //end;

//     // Could not resolve the usercontrol owning 'ADORecSet@1000000061::WillChangeRecord@11'
//     //trigger WillChangeRecord(adReason: Integer;cRecords: Integer;adStatus: Integer;pRecordset: Automation )
//     //begin
//     /*
//     */
//     //end;

//     // Could not resolve the usercontrol owning 'ADORecSet@1000000061::RecordChangeComplete@12'
//     //trigger RecordChangeComplete(adReason: Integer;cRecords: Integer;pError: Automation ;adStatus: Integer;pRecordset: Automation )
//     //begin
//     /*
//     */
//     //end;

//     // Could not resolve the usercontrol owning 'ADORecSet@1000000061::WillChangeRecordset@13'
//     //trigger WillChangeRecordset(adReason: Integer;adStatus: Integer;pRecordset: Automation )
//     //begin
//     /*
//     */
//     //end;

//     // Could not resolve the usercontrol owning 'ADORecSet@1000000061::RecordsetChangeComplete@14'
//     //trigger RecordsetChangeComplete(adReason: Integer;pError: Automation ;adStatus: Integer;pRecordset: Automation )
//     //begin
//     /*
//     */
//     //end;

//     // Could not resolve the usercontrol owning 'ADORecSet@1000000061::WillMove@15'
//     //trigger WillMove(adReason: Integer;adStatus: Integer;pRecordset: Automation )
//     //begin
//     /*
//     */
//     //end;

//     // Could not resolve the usercontrol owning 'ADORecSet@1000000061::MoveComplete@16'
//     //trigger MoveComplete(adReason: Integer;pError: Automation ;adStatus: Integer;pRecordset: Automation )
//     //begin
//     /*
//     */
//     //end;

//     // Could not resolve the usercontrol owning 'ADORecSet@1000000061::EndOfRecordset@17'
//     //trigger EndOfRecordset(var fMoreData: Boolean;adStatus: Integer;pRecordset: Automation )
//     //begin
//     /*
//     */
//     //end;

//     // Could not resolve the usercontrol owning 'ADORecSet@1000000061::FetchProgress@18'
//     //trigger FetchProgress(Progress: Integer;MaxProgress: Integer;adStatus: Integer;pRecordset: Automation )
//     //begin
//     /*
//     */
//     //end;

//     // Could not resolve the usercontrol owning 'ADORecSet@1000000061::FetchComplete@19'
//     //trigger FetchComplete(pError: Automation ;adStatus: Integer;pRecordset: Automation )
//     //begin
//     /*
//     */
//     //end;

//     // Could not resolve the usercontrol owning 'ADOConnection@1000000062::InfoMessage@0'
//     //trigger InfoMessage(pError: Automation ;adStatus: Integer;pConnection: Automation )
//     //begin
//     /*
//     */
//     //end;

//     // Could not resolve the usercontrol owning 'ADOConnection@1000000062::BeginTransComplete@1'
//     //trigger BeginTransComplete(TransactionLevel: Integer;pError: Automation ;adStatus: Integer;pConnection: Automation )
//     //begin
//     /*
//     */
//     //end;

//     // Could not resolve the usercontrol owning 'ADOConnection@1000000062::CommitTransComplete@3'
//     //trigger CommitTransComplete(pError: Automation ;adStatus: Integer;pConnection: Automation )
//     //begin
//     /*
//     */
//     //end;

//     // Could not resolve the usercontrol owning 'ADOConnection@1000000062::RollbackTransComplete@2'
//     //trigger RollbackTransComplete(pError: Automation ;adStatus: Integer;pConnection: Automation )
//     //begin
//     /*
//     */
//     //end;

//     // Could not resolve the usercontrol owning 'ADOConnection@1000000062::WillExecute@4'
//     //trigger WillExecute(var Source: Text[1024];CursorType: Integer;LockType: Integer;var Options: Integer;adStatus: Integer;pCommand: Automation ;pRecordset: Automation ;pConnection: Automation )
//     //begin
//     /*
//     */
//     //end;

//     // Could not resolve the usercontrol owning 'ADOConnection@1000000062::ExecuteComplete@5'
//     //trigger ExecuteComplete(RecordsAffected: Integer;pError: Automation ;adStatus: Integer;pCommand: Automation ;pRecordset: Automation ;pConnection: Automation )
//     //begin
//     /*
//     */
//     //end;

//     // Could not resolve the usercontrol owning 'ADOConnection@1000000062::WillConnect@6'
//     //trigger WillConnect(var ConnectionString: Text[1024];var UserID: Text[1024];var Password: Text[1024];var Options: Integer;adStatus: Integer;pConnection: Automation )
//     //begin
//     /*
//     */
//     //end;

//     // Could not resolve the usercontrol owning 'ADOConnection@1000000062::ConnectComplete@7'
//     //trigger ConnectComplete(pError: Automation ;adStatus: Integer;pConnection: Automation )
//     //begin
//     /*
//     */
//     //end;

//     // Could not resolve the usercontrol owning 'ADOConnection@1000000062::Disconnect@8'
//     //trigger Disconnect(adStatus: Integer;pConnection: Automation )
//     //begin
//     /*
//     */
//     //end;

//     var
//         BLCarriere: Record "BL Carriere";
//         ItemJournalLine: Record "Item Journal Line";
//         ItemJrlLine2: Record "Item Journal Line";
//         //GL2024 ItemJnlPostLine: Codeunit "Item Jnl.-Post Line_CDU22";
//         ItemJnlPostLine: Codeunit "Item Jnl.-Post Line_CDU22";
//         DetailConsommationCentral: Record "Details Consommation BL Beton";
//         DetailConsommationCentral2: Record "Details Consommation BL Beton";
//         NoSeriesMgt: Codeunit NoSeriesManagement;
//         Text001: Label 'Aucun Article Production n''est Paramétré Comme Nomenclature pour Le BL N° %1';
//         Text002: Label 'Vous devez vérifier la correspondance de base article pour l''article %1';
//         Text003: Label 'Aucun Detail Consommation n''est Lié au Bon N° %1 ?';
//         Text004: Label 'Taches Achever Avec Succée';
//         Text005: Label 'Lancer La Creation Des Ordre de Fabrications ?';
//         Text006: Label 'Action Achever Avec Succé';
//         ProductionOrder: Record "Production Order";
//         ProductionBOMHeader: Record "Production BOM Header";
//         ItemJnlPost: Codeunit "Item Jnl.-Post Line";
//         i: Integer;
//         NumProdInitial: Code[20];
//         NumProdFinal: Code[20];
//         CopyProdOrderDoc: Report "Copy Production Order Document";
//         ManuPrintReport: Codeunit "Manu. Print Report";
//         "Production Order": Record "Production Order";
//         "Production Order Line": Record "Prod. Order Line";
//         ProdOrderStatusManagement: Codeunit "Prod. Order Status Management";
//         DateEcheance: Date;
//         ProductionOrder2: Record "Production Order";
//         Item: Record Item;
//         CalcMethod: Option "One Level","All Levels";
//         UpdateReservations: Boolean;
//         UpdateProdOrderCost: Codeunit "Update Prod. Order Cost";
//         ProdOrderLine: Record "Prod. Order Line";
//         MateriauxBLBeton: Record "Materiaux BL Beton";
//         Ligne: Integer;
//         CodeTempo: Code[20];
//         Recuperer: Code[10];
//         //GL2024  FrmCreerDetProdBeton: page 52049027;
//         ParamNumero: Integer;
//         Chaine: Text[30];
//         dec: Decimal;
//         //DYS automation non compatible en cloud
//         // ADOConnection: Automation;
//         // ADORecSet: Automation;
//         // ADORecSet2: Automation;
//         SQLString: Text[1000];
//         ConnectString: Text[1000];
//         ServeurXRT: Text[30];
//         BaseXRT: Text[30];
//         Password: Code[20];
//         "RecEnteteRecupération": Record "BL Carriere";
//         "ClientRecupération": Record "Client Carriere";
//         "ChantierRecupération": Record "Chantier Carriere";
//         "ProduitRecupération": Record "Produit Carriere";
//         SalesReceivablesSetup: Record "Sales & Receivables Setup";
//         ParamClient: Integer;
//         ParamChantier: Integer;
//         ParamProduit: Integer;
//         DetailsConsommationBL: Record "Details Consommation BL Beton";
//         ParamIDdetailsCons: Integer;
//         HeureBL: Text[30];
//         Text007: Label 'Lancer La Récupération ?';


//     procedure CreerProd()
//     begin
//         IF NOT CONFIRM(Text003) THEN EXIT;
//         BLCarriere.COPY(Rec);
//         BLCarriere.SETRANGE("Selection Production", TRUE);
//         IF BLCarriere.FINDFIRST THEN
//             REPEAT
//                 i += 1;
//                 BLCarriere.CALCFIELDS("Produit Production", "Nom Client", "Chantier Client");
//                 IF BLCarriere."Produit Production" = '' THEN ERROR(Text001, BLCarriere."N° Sequence");
//                 CLEAR(ProductionOrder);
//                 ProductionOrder.INIT;
//                 ProductionOrder.Status := ProductionOrder.Status::Released;
//                 ProductionOrder.INSERT(TRUE);
//                 ProductionOrder."Source Type" := ProductionOrder."Source Type"::Item;
//                 ProductionOrder.VALIDATE("Source No.", BLCarriere."Produit Production");
//                 ProductionOrder.VALIDATE("Due Date", BLCarriere.Date);
//                 ProductionOrder.VALIDATE(Quantity, BLCarriere.Quantité);
//                 IF BLCarriere."N° Societe" = 'BZ4' THEN BEGIN
//                     ProductionOrder.Centrale := 'CENTRALZ4';
//                     ProductionOrder."Location Code" := ProductionOrder.Centrale;
//                 END;
//                 ProductionOrder."N° BL" := BLCarriere."N° Sequence";
//                 ProductionOrder.Destination := BLCarriere."Chantier Client";
//                 ProductionOrder.Camion := BLCarriere.Camion;
//                 ProductionOrder.Client := COPYSTR(BLCarriere."Nom Client", 1, 20);
//                 ProductionOrder.Observation := 'Adjuvant : ' + BLCarriere.Adjuvant + ' ---- POMPEE :' + BLCarriere.Pompe +
//                                              ' --- Code Operation : ' + BLCarriere."Code Produit";
//                 ProductionOrder.Automate := TRUE;
//                 ProductionOrder.MODIFY;
//                 BLCarriere."Selection Production" := FALSE;
//                 BLCarriere."N° Production" := ProductionOrder."No.";
//                 IF i = 1 THEN NumProdInitial := ProductionOrder."No.";
//                 IF i > 1 THEN NumProdFinal := ProductionOrder."No.";
//                 BLCarriere.MODIFY;

//             UNTIL BLCarriere.NEXT = 0;
//         CurrPage.UPDATE;
//         MESSAGE(Text004, NumProdInitial, NumProdFinal);
//     end;


//     procedure RecupererBL()
//     var
//         ERR1: Label 'Cannot create ADO Connection automation variable.';
//         ERR2: Label 'Cannot create ADO Recordset automation variable.';
//         //DYS automation non compatible en cloud
//         // ADOConnection: Automation;
//         // ADORecSet: Automation;
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
//         ERR3: Label 'Vous devez saisir le nom du serveur XRT dans paramètre comptabilité';
//         ERR4: Label 'Vous devez saisir le nom de la base XRT dans paramètre comptabilité';
//     begin
//         IF NOT CONFIRM(Text007, FALSE) THEN EXIT;
//         //DYS automation non compatible en cloud
//         // IF ISCLEAR(ADOConnection) THEN BEGIN
//         //     IF NOT CREATE(ADOConnection) THEN BEGIN
//         //         ERROR(ERR1);
//         //     END;
//         // END;
//         //DYS automation non compatible en cloud
//         // IF ISCLEAR(ADORecSet) THEN BEGIN
//         //     IF NOT CREATE(ADORecSet) THEN BEGIN
//         //         ERROR(ERR2);
//         //     END;
//         // END;

//         //IF RecGeneralleadgersetup.GET THEN
//         //  BEGIN
//         //    ServeurXRT :='10.100.192.2';
//         //    BaseXRT    :='CENTRALEZ4';
//         //    Password   :='consultation';
//         //  END;

//         IF RecGeneralleadgersetup.GET THEN BEGIN
//             ServeurXRT := '10.100.192.86\sqlexpress';
//             BaseXRT := 'BD_TRAVAIL';
//             Password := 'consultation';
//         END;


//         IF ServeurXRT = '' THEN
//             ERROR(ERR3);
//         IF BaseXRT = '' THEN
//             ERROR(ERR4);
//         ConnectString := 'Provider=SQLOLEDB.1;Data Source=' + ServeurXRT + ';'
//                          + 'Initial Catalog=' + BaseXRT + ';User ID=consultation;Password=123';

//         //MESSAGE(ConnectString);
//         //DYS automation non compatible en cloud
//         //ADOConnection.ConnectionString(ConnectString);

//         //DYS automation non compatible en cloud
//         //ADOConnection.Open;
//         RecordsAffected := '';
//         RSOption := 0;
//         Datecalcul := WORKDATE;
//         IF SalesReceivablesSetup.GET() THEN BEGIN
//             ParamNumero := SalesReceivablesSetup."Parametre Numero ID";
//             ParamClient := SalesReceivablesSetup."Parametre Numero Client";
//             ParamChantier := SalesReceivablesSetup."Parametre Numero Chantier";
//             ParamProduit := SalesReceivablesSetup."Parametre Numero Produit";
//             ParamIDdetailsCons := SalesReceivablesSetup."Parametre ID details Conso";
//         END;
//         //ParamNumero:=42629;
//         //***************** TABLE BL
//         //SQLString := 'select * from T_BL where BL_ID> 42630';

//         SQLString := 'select *,Cast(BL_CubageLivre as varchar(10)) as CubageLivre,' +
//                 'Cast(BL_Heure_Premiere_Gachee as varchar(10)) as HeurePremiere,' +
//                 'Cast(BL_CubageLivre as Decimal(5,1)) as CubageLivre2 from T_BL where BL_ID>' + FORMAT(ParamNumero);

//         //DYS automation non compatible en cloud
//         // ADORecSet := ADOConnection.Execute(SQLString, RecordsAffected, RSOption);
//         // IF NOT ADORecSet.EOF THEN BEGIN
//         //     ADORecSet.MoveFirst;
//         //     REPEAT
//         //         RecEnteteRecupération."N° Societe" := 'BZ4';
//         //         RecEnteteRecupération.Date := ADORecSet.Fields.Item('BL_DateLanceFab').Value;
//         //         RecEnteteRecupération."N° Sequence" := FORMAT(ADORecSet.Fields.Item('BL_Numero').Value);
//         //         Chaine := ADORecSet.Fields.Item('CubageLivre').Value;
//         //         Chaine := CONVERTSTR(Chaine, '.', ',');
//         //         HeureBL := ADORecSet.Fields.Item('HeurePremiere').Value;
//         //         EVALUATE(RecEnteteRecupération.Quantité, Chaine);
//         //         //RecEnteteRecupération.Quantité:=ADORecSet.Fields.Item('BL_CubageLivre').Value;
//         //         //RecEnteteRecupération.Heure:=ADORecSet.Fields.Item('BL_Heure_Premiere_Gachee').Value;
//         //         EVALUATE(RecEnteteRecupération.Heure, HeureBL);
//         //         RecEnteteRecupération.Nature := ADORecSet.Fields.Item('FOR_Nature_Cim').Value;
//         //         RecEnteteRecupération.Dosage := ADORecSet.Fields.Item('FOR_Dosage_CKA_Reel').Value;
//         //         RecEnteteRecupération.Adjuvant := ADORecSet.Fields.Item('FOR_Adjuvant').Value;
//         //         RecEnteteRecupération.Pompe := ADORecSet.Fields.Item('PRO_Nom0').Value;
//         //         RecEnteteRecupération.Camion := ADORecSet.Fields.Item('CAM_Code').Value;
//         //         RecEnteteRecupération."Nom Chauffeur" := ADORecSet.Fields.Item('CHF_Nom').Value;
//         //         RecEnteteRecupération."Code Client" := ADORecSet.Fields.Item('CLI_Code').Value;
//         //         RecEnteteRecupération.Chantier := ADORecSet.Fields.Item('CHA_Code').Value;
//         //         RecEnteteRecupération."Code Produit" := ADORecSet.Fields.Item('FOR_Code').Value;
//         //         SalesReceivablesSetup."Parametre Numero ID" := ADORecSet.Fields.Item('BL_ID').Value;
//         //         SalesReceivablesSetup.MODIFY;

//         //         IF RecEnteteRecupération.INSERT(TRUE) THEN;
//         //         ADORecSet.MoveNext;
//         //     UNTIL ADORecSet.EOF;
//         // END;
//         // ADORecSet.Close;
//         //***************** TABLE BL

//         //***************** TABLE CLIENT
//         SQLString := 'select * from T_CLIENT where CLI_ID>' + FORMAT(ParamClient);
//         //DYS automation non compatible en cloud
//         // ADORecSet := ADOConnection.Execute(SQLString, RecordsAffected, RSOption);
//         // IF NOT ADORecSet.EOF THEN BEGIN
//         //     ADORecSet.MoveFirst;
//         //     REPEAT
//         //         ClientRecupération."N° Societe" := 'BZ4';
//         //         ClientRecupération."Code Client" := ADORecSet.Fields.Item('CLI_Code').Value;
//         //         ClientRecupération."Designation Client" := ADORecSet.Fields.Item('CLI_Nom').Value;
//         //         SalesReceivablesSetup."Parametre Numero Client" := ADORecSet.Fields.Item('CLI_ID').Value;
//         //         SalesReceivablesSetup.MODIFY;

//         //         IF ClientRecupération.INSERT(TRUE) THEN;
//         //         ADORecSet.MoveNext;
//         //     UNTIL ADORecSet.EOF;
//         // END;
//         // ADORecSet.Close;
//         //***************** TABLE CLIENT

//         //***************** TABLE CHANTIER
//         SQLString := 'select * from T_CHANTIER where CHA_ID>' + FORMAT(ParamChantier);
//         //DYS automation non compatible en cloud
//         // ADORecSet := ADOConnection.Execute(SQLString, RecordsAffected, RSOption);
//         // IF NOT ADORecSet.EOF THEN BEGIN
//         //     ADORecSet.MoveFirst;
//         //     REPEAT
//         //         ChantierRecupération."N° Societe" := 'BZ4';
//         //         ChantierRecupération.Chantier := ADORecSet.Fields.Item('CHA_Code').Value;
//         //         ChantierRecupération.Client := ADORecSet.Fields.Item('CLI_Code').Value;
//         //         ChantierRecupération."Designation Chantier" := ADORecSet.Fields.Item('CHA_Nom').Value;
//         //         SalesReceivablesSetup."Parametre Numero Chantier" := ADORecSet.Fields.Item('CHA_ID').Value;
//         //         SalesReceivablesSetup.MODIFY;

//         //         IF ChantierRecupération.INSERT(TRUE) THEN;
//         //         ADORecSet.MoveNext;
//         //     UNTIL ADORecSet.EOF;
//         // END;
//         // ADORecSet.Close;
//         //***************** TABLE CHANTIER

//         //***************** TABLE PRODUIT
//         SQLString := 'select * from T_FORMULE where FOR_ID>' + FORMAT(ParamProduit);
//         //DYS automation non compatible en cloud
//         // ADORecSet := ADOConnection.Execute(SQLString, RecordsAffected, RSOption);
//         // IF NOT ADORecSet.EOF THEN BEGIN
//         //     ADORecSet.MoveFirst;
//         //     REPEAT
//         //         ProduitRecupération."N° Societe" := 'BZ4';
//         //         ProduitRecupération."Code Produit" := ADORecSet.Fields.Item('FOR_Code').Value;
//         //         ProduitRecupération."Designation Produit" := ADORecSet.Fields.Item('FOR_Nom').Value;
//         //         SalesReceivablesSetup."Parametre Numero Produit" := ADORecSet.Fields.Item('FOR_ID').Value;
//         //         SalesReceivablesSetup.MODIFY;

//         //         IF ProduitRecupération.INSERT(TRUE) THEN;
//         //         ADORecSet.MoveNext;
//         //     UNTIL ADORecSet.EOF;
//         // END;
//         // ADORecSet.Close;
//         //***************** TABLE PRODUIT

//         //***************** TABLE DETAILS CONSOMMATION
//         SQLString := 'select * ,Cast(CON_Quantite as varchar(10)) as Qte from T_CONSO_DETAILS where CON_ID>' + FORMAT(ParamIDdetailsCons);
//         //DYS automation non compatible en cloud
//         // ADORecSet := ADOConnection.Execute(SQLString, RecordsAffected, RSOption);
//         // IF NOT ADORecSet.EOF THEN BEGIN
//         //     ADORecSet.MoveFirst;
//         //     REPEAT
//         //         DetailsConsommationBL.Con_ID := FORMAT(ADORecSet.Fields.Item('CON_ID').Value);
//         //         DetailsConsommationBL.Mat_Code := FORMAT(ADORecSet.Fields.Item('MAT_CODE').Value);
//         //         Chaine := ADORecSet.Fields.Item('Qte').Value;
//         //         Chaine := CONVERTSTR(Chaine, '.', ',');
//         //         EVALUATE(DetailsConsommationBL.Quantité, Chaine);
//         //         DetailsConsommationBL.Num_BL := FORMAT(ADORecSet.Fields.Item('CON_BL').Value);
//         //         SalesReceivablesSetup."Parametre ID details Conso" := ADORecSet.Fields.Item('CON_ID').Value;
//         //         SalesReceivablesSetup.MODIFY;
//         //         IF DetailsConsommationBL.INSERT(TRUE) THEN;
//         //         ADORecSet.MoveNext;
//         //     UNTIL ADORecSet.EOF;
//         // END;
//         // ADORecSet.Close;
//         //***************** TABLE DETAILS CONSOMMATION

//         //***************** TABLE MATERIAUX
//         SQLString := 'select * FROM T_MATERIAU';
//         //DYS automation non compatible en cloud
//         // ADORecSet := ADOConnection.Execute(SQLString, RecordsAffected, RSOption);
//         // IF NOT ADORecSet.EOF THEN BEGIN
//         //     ADORecSet.MoveFirst;
//         //     REPEAT
//         //         MateriauxBLBeton.Mat_ID := FORMAT(ADORecSet.Fields.Item('MAT_ID').Value);
//         //         MateriauxBLBeton.Mat_Code := FORMAT(ADORecSet.Fields.Item('MAT_Code').Value);
//         //         MateriauxBLBeton.Mat_Nom := FORMAT(ADORecSet.Fields.Item('MAT_Nom').Value);
//         //         MateriauxBLBeton.Mat_Unité := FORMAT(ADORecSet.Fields.Item('MAT_DosageUnite').Value);
//         //         IF MateriauxBLBeton.INSERT(TRUE) THEN;
//         //         ADORecSet.MoveNext;
//         //     UNTIL ADORecSet.EOF;
//         // END;
//         // ADORecSet.Close;
//         //***************** TABLE TABLE MATERIAUX


//         //  ADOConnection.Close;
//         MESSAGE(Text006);
//     end;
// }

