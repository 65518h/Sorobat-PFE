// Page 50114 Integration
// {
//     PageType = Card;
//     ApplicationArea = all;
//     UsageCategory = Administration;

//     Caption = 'Integration';
//     layout
//     {
//     }

//     actions
//     {
//         area(processing)
//         {
//             action(Integration)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Integration';
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 begin
//                     InsertDataXRT()
//                 end;
//             }
//         }
//     }

//     var
//         Annee: Code[10];
//         Mois: Code[10];
//         RecLInventorySetup: Record "Inventory Setup";
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
//         "// RB SORO 21/09/2015": Integer;
//         RecValeurPaie: Record "Chiffre Affaire";
//         Tempo: Decimal;
//         Text001: label 'Traitement Achevé Avec Succé';


//     procedure InsertDataXRT()
//     var
//         ERR1: label 'Cannot create ADO Connection automation variable.';
//         ERR2: label 'Cannot create ADO Recordset automation variable.';
//         BLBeton: Record "BL Beton";
//         //DYS automation 
//         // ADOConnection: Automation Connection;
//         // ADORecSet: Automation Recordset;
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
//         ERR3: label 'Vous devez saisir le nom du serveur XRT dans paramètre comptabilité';
//         ERR4: label 'Vous devez saisir le nom de la base XRT dans paramètre comptabilité';
//         DernierBL: Integer;

//     //DYS automation 
//     //adStream: Automation Stream;
//     begin
//         //IF NOT CONFIRM(Text002,FALSE) THEN EXIT;
//         //DYS automation 
//         // if ISCLEAR(ADOConnection) then begin
//         //     if not Create(ADOConnection) then begin
//         //         Error(ERR1);
//         //     end;
//         // end;

//         // if ISCLEAR(ADORecSet) then begin
//         //     if not Create(ADORecSet) then begin
//         //         Error(ERR2);
//         //     end;
//         // end;
//         if RecGeneralleadgersetup.Get then begin
//             ServeurXRT := '.';
//             BaseXRT := 'CB';
//             Password := 'INTEGRATION';
//         end;

//         if ServeurXRT = '' then
//             Error(ERR3);
//         if BaseXRT = '' then
//             Error(ERR4);
//         ConnectString := 'Provider=SQLOLEDB.1;Data Source=' + ServeurXRT + ';'
//                          + 'Initial Catalog=' + BaseXRT + ';User ID=INTEGRATION;Password=INTEGRATION';

//         //MESSAGE(ConnectString);
//         //DYS automation 
//         //  ADOConnection.ConnectionString(ConnectString);

//         if BLBeton.FindLast then DernierBL := BLBeton."N° BL";
//         //DYS automation 
//         //  ADOConnection.Open;
//         RecordsAffected := '';
//         RSOption := 0;
//         Datecalcul := WorkDate;
//         // >> Recupeartion BL
//         SQLString := 'SELECT * FROM T_BL Where BL_Numero > ' + Format(DernierBL);
//         //DYS automation 
//         // ADORecSet := ADOConnection.Execute(SQLString, RecordsAffected, RSOption);
//         // if not ADORecSet.EOF then begin
//         //     ADORecSet.MoveFirst;
//         //     repeat
//         //         BLBeton."N° BL" := ADORecSet.Fields.Item('BL_Numero').Value;
//         //         BLBeton.Site := ADORecSet.Fields.Item('SIT_Code').Value;
//         //         BLBeton.Heure := ADORecSet.Fields.Item('BL_HeureConvenue').Value;
//         //         BLBeton."Heure-gachee" := ADORecSet.Fields.Item('BL_Heure_Premiere_Gachee').Value;
//         //         BLBeton.Article := ADORecSet.Fields.Item('FOR_Code').Value;
//         //         BLBeton.Description := ADORecSet.Fields.Item('FOR_Nom').Value;
//         //         BLBeton."Nature Ciment" := ADORecSet.Fields.Item('FOR_Nature_Cim').Value;
//         //         BLBeton.Camion := ADORecSet.Fields.Item('CAM_Code').Value;
//         //         BLBeton.Client := ADORecSet.Fields.Item('CLI_Code').Value;
//         //         BLBeton."Nom Clinent" := ADORecSet.Fields.Item('CLI_Nom').Value;
//         //         BLBeton."Code Chargement" := ADORecSet.Fields.Item('CHA_Code').Value;
//         //         BLBeton."Nom Chargement" := ADORecSet.Fields.Item('CHA_Nom').Value;
//         //         Clear(adStream);
//         //         Create(adStream);
//         //         adStream.Open;
//         //         adStream.WriteText(ADORecSet.Fields.Item('BL_CubageLivre').Value);
//         //         adStream.Position := 0;
//         //         if Evaluate(Tempo, adStream.ReadText) then;
//         //         BLBeton.Quantité := Tempo;
//         //         // BLBeton."Quantité Transport" := ADORecSet.Fields.Item('PRO_QteFactureTransport').Value;
//         //         BLBeton.Insert;
//         //         ADORecSet.MoveNext;
//         //     until ADORecSet.EOF;
//         // end;
//         // ADORecSet.Close;
//         // ADOConnection.Close;
//         //DYS automation 
//         Message(Text001);
//     end;


//     procedure Connection()
//     var
//         ERR1: label 'Cannot create ADO Connection automation variable.';
//         ERR2: label 'Cannot create ADO Recordset automation variable.';
//         ERR3: label 'Vous devez saisir le nom du serveur XRT dans paramètre comptabilité';
//         ERR4: label 'Vous devez saisir le nom de la base XRT dans paramètre comptabilité';
//         RecLInventorySetup: Record "Inventory Setup";
//         Text001: label 'Module Non Activer Consulter Votre Administrateur ';
//     begin
//         //GL2024 Automation

//         /*IF RecLInventorySetup.GET THEN;
//         //IF NOT RecLInventorySetup."Activer Export Data" THEN
//         //  ERROR(Text001);

//         IF ISCLEAR(ADOConnection) THEN BEGIN
//               IF NOT CREATE(ADOConnection) THEN BEGIN
//               ERROR(ERR1);
//            END;
//         END;

//         IF ISCLEAR(ADORecSet) THEN BEGIN
//               IF NOT CREATE(ADORecSet) THEN BEGIN
//                  ERROR(ERR2);
//            END;
//         END;
//         IF RecGeneralleadgersetup.GET THEN
//           BEGIN
//             ServeurXRT :='192.168.2.103\SQL2005';
//             BaseXRT    :='INTERFACENAV';
//             Password   :='SOBOCO';
//           END;

//         IF ServeurXRT='' THEN
//           ERROR(ERR3);
//         IF BaseXRT='' THEN
//           ERROR(ERR4);
//         ConnectString := 'Provider=SQLOLEDB.1;Data Source='+ ServeurXRT +';'
//                          + 'Initial Catalog='+BaseXRT+';User ID=SOBOCO;Password=SOBOCO';

//         ADOConnection.ConnectionString(ConnectString);
//         ADOConnection.Open;  */

//     end;


//     procedure CloseConnection()
//     begin
//         //GL2024 Automation
//         //ADOConnection.Close;
//         //MESSAGE(Text001);
//     end;


//     procedure ReadADOFieldDecimal()
//     begin
//     end;
// }

