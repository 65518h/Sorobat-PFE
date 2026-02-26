// Page 50224 "Integration BL Beton"
// {
//     PageType = List;
//     SourceTable = "BL Carriere";
//     SourceTableView = sorting("N° Societe", "N° Sequence", Annee, ID)
//                       where("N° Societe" = filter('BZ4'), "Integerer BL Beton" = filter(false), "Code Commande Vente" = filter(' '));

//     ApplicationArea = all;
//     UsageCategory = Administration;
//     Caption = 'Integration BL Beton';

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field(Date; REC.Date)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Enabled = true;
//                 }
//                 field(Heure; REC.Heure)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("N° Sequence"; REC."N° Sequence")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'BL N°';
//                     Editable = false;
//                 }
//                 field("Code Produit"; REC."Code Produit")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Produit';
//                 }
//                 field(Nature; REC.Nature)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Dosage; REC.Dosage)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Adjuvant; REC.Adjuvant)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Pompe; REC.Pompe)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Chantier; REC.Chantier)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Code Client"; REC."Code Client")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Client Nav"; REC."Client Nav")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Nom Client"; REC."Nom Client")
//                 {
//                     ApplicationArea = all;
//                     Style = Unfavorable;
//                     StyleExpr = true;
//                 }
//                 field("Chantier Client"; REC."Chantier Client")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Code Chantier Client"; REC."Code Chantier Client")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Produit Nav"; REC."Produit Nav")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Description Produit Nav"; REC."Description Produit Nav")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Produit Navision 2"; REC."Produit Navision 2")
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Chantier Nav"; REC."Chantier Nav")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Quantité"; REC.Quantité)
//                 {
//                     ApplicationArea = all;
//                     DecimalPlaces = 0 : 3;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field(PU; REC.PU)
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field(Selectionner; REC.Selectionner)
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field(Interne; REC.Interne)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Commande Associer"; REC."Commande Associer")
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             action(Recuperer)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Recuperer';
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 Visible = false;

//                 trigger OnAction()
//                 begin
//                     RecupererBL();
//                 end;
//             }
//             action(Valider)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Valider';
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 begin
//                     if not Confirm(Text003) then exit;
//                     RecSalesReceivablesSetup.Get;
//                     RecBLCarriere.Copy(Rec);
//                     RecBLCarriere.SetRange(Selectionner, true);
//                     RecBLCarriere.SetRange("N° Societe", REC."N° Societe");
//                     if RecBLCarriere.FindFirst then
//                         repeat
//                             Clear(RecSalesHeader);
//                             Clear(RecSalesLine);
//                             RecBLCarriere.CalcFields("Produit Nav", "Client Nav", "Nom Client", "Code Chantier Client");
//                             if RecBLCarriere."Client Nav" = '' then Error(Text001, RecBLCarriere."Code Client");
//                             if RecBLCarriere."Produit Navision 2" = '' then begin
//                                 if RecBLCarriere."Produit Nav" = '' then Error(Text002, RecBLCarriere."Produit Nav");
//                             end;
//                             // Insertion Entet Vente
//                             RecSalesHeader.Validate("Document Type", RecSalesHeader."document type"::Order);
//                             RecSalesHeader.Validate("No.", NoSeriesMgt.GetNextNo(RecSalesReceivablesSetup."Order Nos.", RecBLCarriere.Date, true));
//                             RecSalesHeader.Validate("Posting Date", RecBLCarriere.Date);
//                             if (RecBLCarriere."Code Client" = '1') or (RecBLCarriere."Code Client" = '4546') then begin
//                                 RecSalesHeader.Validate("Sell-to Customer No.", RecBLCarriere."Code Chantier Client");
//                             end
//                             else begin
//                                 RecSalesHeader.Validate("Sell-to Customer No.", RecBLCarriere."Client Nav");
//                             end;
//                             RecSalesHeader.Validate("Job No.", 'VENTECENTZ4'); //RecBLCarriere."Job No"
//                             RecSalesHeader.Validate("External Document No.", RecBLCarriere."N° Sequence");
//                             RecSalesHeader.Validate("No. Series", RecSalesReceivablesSetup."Order Nos.");
//                             RecSalesHeader.Validate("Posting No. Series", RecSalesReceivablesSetup."Posted Invoice Nos.");
//                             RecSalesHeader.Validate("Shipping No. Series", RecSalesReceivablesSetup."Posted Shipment Nos.");
//                             RecSalesHeader."External Document No." := RecBLCarriere."N° Sequence";
//                             RecSalesHeader."Prices Including VAT" := true;
//                             if RecBLCarriere.Interne then
//                                 RecSalesHeader."Commande Interne" := true else
//                                 RecSalesHeader."Commande Interne" := false;
//                             RecSalesHeader."User ID" := UpperCase(UserId);
//                             if RecBLCarriere."Client Nav" = 'CPV-0999' then begin
//                                 RecSalesHeader."Sell-to Customer Name" := RecBLCarriere."Nom Client";
//                                 RecSalesHeader."Bill-to Name" := RecBLCarriere."Nom Client";
//                             end;
//                             if not RecSalesHeader.Insert then RecSalesHeader.Modify;
//                             // Insertion Lignie Vente
//                             RecSalesLine.Validate("Document Type", RecSalesLine."document type"::Order);
//                             RecSalesLine.Validate("Document No.", RecSalesHeader."No.");
//                             RecSalesLine.Validate(Type, RecSalesLine.Type::Item);
//                             RecSalesLine."Line No." := 10000;
//                             if RecBLCarriere."Produit Navision 2" <> '' then begin
//                                 RecSalesLine.Validate("No.", RecBLCarriere."Produit Navision 2");
//                             end
//                             else
//                                 RecSalesLine.Validate("No.", RecBLCarriere."Produit Nav");
//                             begin
//                             end;
//                             RecSalesLine.Validate(Quantity, RecBLCarriere.Quantité);
//                             if REC.PU <> 0 then
//                                 RecSalesLine.Validate("Unit Price", REC.PU)
//                             else
//                                 Error(Text007, RecBLCarriere."N° Sequence");
//                             if not RecSalesLine.Insert then RecSalesLine.Modify;
//                             // Validation Commande Vente
//                             // Insertion N° Bpn de Commande dans la liste des BL Carriere
//                             RecBLCarriere."Integerer BL Beton" := true;
//                             RecBLCarriere."Code Commande Vente" := RecSalesHeader."No.";
//                             RecBLCarriere.Selectionner := false;
//                             RecBLCarriere.Modify;
//                         until RecBLCarriere.Next = 0;
//                     CurrPage.Update;
//                     Message(Text004);
//                 end;
//             }
//         }
//     }

//     var
//         RecBLCarriere: Record "BL Carriere";
//         RecSalesReceivablesSetup: Record "Sales & Receivables Setup";
//         NoSeriesMgt: Codeunit NoSeriesManagement;
//         RecSalesHeader: Record "Sales Header";
//         RecSalesLine: Record "Sales Line";
//         RecSalesHeader2: Record "Sales Header";
//         Text001: label 'Vous devez vérifier la correspondance de base client pour le client %1';
//         Text002: label 'Vous devez vérifier la correspondance de base article pour l''article %1';
//         Text003: label 'Lancer La Creation Des Commandes ?';
//         Text004: label 'Taches Achever Avec Succée';
//         ParamNumero: Integer;
//         Chaine: Text[30];
//         dec: Decimal;
//         //DYS automation supprimer
//         /*  ADOConnection: Automation Connection;
//   ADORecSet: Automation Recordset;
//           ADORecSet2: Automation Recordset;*/
//         SQLString: Text[1000];
//         ConnectString: Text[1000];
//         ServeurXRT: Text[30];
//         BaseXRT: Text[30];
//         Password: Code[20];
//         "RecEnteteRecupération": Record "BL Carriere";
//         "ClientRecupération": Record "Client Carriere";
//         "ChantierRecupération": Record "Chantier Carriere";
//         "ProduitRecupération": Record "Produit Carriere";
//         Text005: label 'Lancer La Récupération ?';
//         Text006: label 'Action Achever Avec Succé';
//         SalesReceivablesSetup: Record "Sales & Receivables Setup";
//         ParamClient: Integer;
//         ParamChantier: Integer;
//         ParamProduit: Integer;
//         DetailsConsommationBL: Record "Details Consommation BL Beton";
//         ParamIDdetailsCons: Integer;
//         MateriauxBLBeton: Record "Materiaux BL Beton";
//         HeureBL: Text[30];
//         Text007: label 'Prix Unitaire doite Etre Mentionné Bon N° %1';


//     procedure RecupererBL()
//     var
//         ERR1: label 'Cannot create ADO Connection automation variable.';
//         ERR2: label 'Cannot create ADO Recordset automation variable.';
//         //DYS automation supprimer
//         /*ADOConnection: Automation Connection;
//         ADORecSet: Automation Recordset;*/
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
//     begin
//         /*
//         //DYS automation supprimer
//         if not Confirm(Text003, false) then exit;
//         if ISCLEAR(ADOConnection) then begin
//             if not Create(ADOConnection) then begin
//                 Error(ERR1);
//             end;
//         end;

//         if ISCLEAR(ADORecSet) then begin
//             if not Create(ADORecSet) then begin
//                 Error(ERR2);
//             end;
//         end;
//         */
//         //IF RecGeneralleadgersetup.GET THEN
//         //  BEGIN
//         //    ServeurXRT :='10.100.192.2';
//         //    BaseXRT    :='CENTRALEZ4';
//         //    Password   :='consultation';
//         //  END;

//         if RecGeneralleadgersetup.Get then begin
//             ServeurXRT := '10.100.192.86\sqlexpress';
//             BaseXRT := 'BD_TRAVAIL';
//             Password := 'consultation';
//         end;


//         if ServeurXRT = '' then
//             Error(ERR3);
//         if BaseXRT = '' then
//             Error(ERR4);
//         ConnectString := 'Provider=SQLOLEDB.1;Data Source=' + ServeurXRT + ';'
//                          + 'Initial Catalog=' + BaseXRT + ';User ID=consultation;Password=123';

//         // //MESSAGE(ConnectString);
//         //DYS automation supprimer
//         // ADOConnection.ConnectionString(ConnectString);

//         //DYS automation supprimer
//         // ADOConnection.Open;
//         RecordsAffected := '';
//         RSOption := 0;
//         Datecalcul := WorkDate;
//         if SalesReceivablesSetup.Get() then begin
//             ParamNumero := SalesReceivablesSetup."Parametre Numero ID";
//             ParamClient := SalesReceivablesSetup."Parametre Numero Client";
//             ParamChantier := SalesReceivablesSetup."Parametre Numero Chantier";
//             ParamProduit := SalesReceivablesSetup."Parametre Numero Produit";
//             ParamIDdetailsCons := SalesReceivablesSetup."Parametre ID details Conso";
//         end;
//         //ParamNumero:=42629;
//         //***************** TABLE BL
//         //SQLString := 'select * from T_BL where BL_ID> 42630';

//         SQLString := 'select *,Cast(BL_CubageLivre as varchar(10)) as CubageLivre,' +
//                 'Cast(BL_Heure_Premiere_Gachee as varchar(10)) as HeurePremiere,' +
//                 'Cast(BL_CubageLivre as Decimal(5,1)) as CubageLivre2 from T_BL where BL_ID>' + Format(ParamNumero);

//         //DYS automation supprimer
//         // ADORecSet := ADOConnection.Execute(SQLString, RecordsAffected, RSOption);
//         // if not ADORecSet.EOF then begin
//         //     ADORecSet.MoveFirst;
//         //     repeat
//         //         RecEnteteRecupération."N° Societe" := 'BZ4';
//         //         RecEnteteRecupération.Date := ADORecSet.Fields.Item('BL_DateLanceFab').Value;
//         //         RecEnteteRecupération."N° Sequence" := Format(ADORecSet.Fields.Item('BL_Numero').Value);
//         //         Chaine := ADORecSet.Fields.Item('CubageLivre').Value;
//         //         Chaine := ConvertStr(Chaine, '.', ',');
//         //         HeureBL := ADORecSet.Fields.Item('HeurePremiere').Value;
//         //         Evaluate(RecEnteteRecupération.Quantité, Chaine);
//         //         //RecEnteteRecupération.Quantité:=ADORecSet.Fields.Item('BL_CubageLivre').Value;
//         //         //RecEnteteRecupération.Heure:=ADORecSet.Fields.Item('BL_Heure_Premiere_Gachee').Value;
//         //         Evaluate(RecEnteteRecupération.Heure, HeureBL);
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
//         //         SalesReceivablesSetup.Modify;

//         //         if RecEnteteRecupération.Insert(true) then;
//         //         ADORecSet.MoveNext;
//         //     until ADORecSet.EOF;
//         // end;
//         // ADORecSet.Close;
//         //DYS automation supprimer
//         //***************** TABLE BL

//         //***************** TABLE CLIENT
//         SQLString := 'select * from T_CLIENT where CLI_ID>' + Format(ParamClient);
//         //DYS automation supprimer
//         // ADORecSet := ADOConnection.Execute(SQLString, RecordsAffected, RSOption);
//         // if not ADORecSet.EOF then begin
//         //     ADORecSet.MoveFirst;
//         //     repeat
//         //         ClientRecupération."N° Societe" := 'BZ4';
//         //         ClientRecupération."Code Client" := ADORecSet.Fields.Item('CLI_Code').Value;
//         //         ClientRecupération."Designation Client" := ADORecSet.Fields.Item('CLI_Nom').Value;
//         //         SalesReceivablesSetup."Parametre Numero Client" := ADORecSet.Fields.Item('CLI_ID').Value;
//         //         SalesReceivablesSetup.Modify;

//         //         if ClientRecupération.Insert(true) then;
//         //         ADORecSet.MoveNext;
//         //     until ADORecSet.EOF;
//         // end;
//         // ADORecSet.Close;
//         //DYS automation supprimer
//         //***************** TABLE CLIENT

//         //***************** TABLE CHANTIER
//         SQLString := 'select * from T_CHANTIER where CHA_ID>' + Format(ParamChantier);
//         //DYS automation supprimer
//         // ADORecSet := ADOConnection.Execute(SQLString, RecordsAffected, RSOption);
//         // if not ADORecSet.EOF then begin
//         //     ADORecSet.MoveFirst;
//         //     repeat
//         //         ChantierRecupération."N° Societe" := 'BZ4';
//         //         ChantierRecupération.Chantier := ADORecSet.Fields.Item('CHA_Code').Value;
//         //         ChantierRecupération.Client := ADORecSet.Fields.Item('CLI_Code').Value;
//         //         ChantierRecupération."Designation Chantier" := ADORecSet.Fields.Item('CHA_Nom').Value;
//         //         SalesReceivablesSetup."Parametre Numero Chantier" := ADORecSet.Fields.Item('CHA_ID').Value;
//         //         SalesReceivablesSetup.Modify;

//         //         if ChantierRecupération.Insert(true) then;
//         //         ADORecSet.MoveNext;
//         //     until ADORecSet.EOF;
//         // end;
//         // ADORecSet.Close;
//         //DYS automation supprimer
//         //***************** TABLE CHANTIER

//         //***************** TABLE PRODUIT
//         SQLString := 'select * from T_FORMULE where FOR_ID>' + Format(ParamProduit);
//         //DYS automation supprimer
//         // ADORecSet := ADOConnection.Execute(SQLString, RecordsAffected, RSOption);
//         // if not ADORecSet.EOF then begin
//         //     ADORecSet.MoveFirst;
//         //     repeat
//         //         ProduitRecupération."N° Societe" := 'BZ4';
//         //         ProduitRecupération."Code Produit" := ADORecSet.Fields.Item('FOR_Code').Value;
//         //         ProduitRecupération."Designation Produit" := ADORecSet.Fields.Item('FOR_Nom').Value;
//         //         SalesReceivablesSetup."Parametre Numero Produit" := ADORecSet.Fields.Item('FOR_ID').Value;
//         //         SalesReceivablesSetup.Modify;

//         //         if ProduitRecupération.Insert(true) then;
//         //         ADORecSet.MoveNext;
//         //     until ADORecSet.EOF;
//         // end;
//         // ADORecSet.Close;
//         //DYS automation supprimer
//         //***************** TABLE PRODUIT

//         //***************** TABLE DETAILS CONSOMMATION
//         SQLString := 'select * ,Cast(CON_Quantite as varchar(10)) as Qte from T_CONSO_DETAILS where CON_ID>' + Format(ParamIDdetailsCons);
//         //DYS automation supprimer
//         // ADORecSet := ADOConnection.Execute(SQLString, RecordsAffected, RSOption);
//         // if not ADORecSet.EOF then begin
//         //     ADORecSet.MoveFirst;
//         //     repeat
//         //         DetailsConsommationBL.Con_ID := Format(ADORecSet.Fields.Item('CON_ID').Value);
//         //         DetailsConsommationBL.Mat_Code := Format(ADORecSet.Fields.Item('MAT_CODE').Value);
//         //         Chaine := ADORecSet.Fields.Item('Qte').Value;
//         //         Chaine := ConvertStr(Chaine, '.', ',');
//         //         Evaluate(DetailsConsommationBL.Quantité, Chaine);
//         //         DetailsConsommationBL.Num_BL := Format(ADORecSet.Fields.Item('CON_BL').Value);
//         //         SalesReceivablesSetup."Parametre ID details Conso" := ADORecSet.Fields.Item('CON_ID').Value;
//         //         SalesReceivablesSetup.Modify;
//         //         if DetailsConsommationBL.Insert(true) then;
//         //         ADORecSet.MoveNext;
//         //     until ADORecSet.EOF;
//         // end;
//         // ADORecSet.Close;
//         //DYS automation supprimer
//         //***************** TABLE DETAILS CONSOMMATION

//         //***************** TABLE MATERIAUX
//         SQLString := 'select * FROM T_MATERIAU';
//         //DYS automation supprimer
//         // ADORecSet := ADOConnection.Execute(SQLString, RecordsAffected, RSOption);
//         // if not ADORecSet.EOF then begin
//         //     ADORecSet.MoveFirst;
//         //     repeat
//         //         MateriauxBLBeton.Mat_ID := Format(ADORecSet.Fields.Item('MAT_ID').Value);
//         //         MateriauxBLBeton.Mat_Code := Format(ADORecSet.Fields.Item('MAT_Code').Value);
//         //         MateriauxBLBeton.Mat_Nom := Format(ADORecSet.Fields.Item('MAT_Nom').Value);
//         //         MateriauxBLBeton.Mat_Unité := Format(ADORecSet.Fields.Item('MAT_DosageUnite').Value);
//         //         if MateriauxBLBeton.Insert(true) then;
//         //         ADORecSet.MoveNext;
//         //     until ADORecSet.EOF;
//         // end;
//         // ADORecSet.Close;
//         //DYS automation supprimer
//         //***************** TABLE TABLE MATERIAUX

//         //DYS automation supprimer
//         // ADOConnection.Close;
//         Message(Text006);
//     end;
// }

