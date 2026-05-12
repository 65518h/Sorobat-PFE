// page 52049014 "BL BEST BETON"
// {
//     //GL2024  ID dans Nav 2009 : "39001542"
//     DelayedInsert = true;
//     DeleteAllowed = false;
//     InsertAllowed = false;
//     PageType = List;
//     SourceTable = "BL Carriere";
//     SourceTableView = SORTING(Date) WHERE("Integrer BL Best Beton" = CONST(false), "N° Societe" = FILTER('B'));
//     ApplicationArea = all;
//     UsageCategory = lists;
//     Caption = 'BL BEST BETON';
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field("N° Sequence"; rec."N° Sequence")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 field("Selectionner BL Best Beton"; rec."Selectionner BL Best Beton")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Selectionner';
//                     Style = Strong;
//                     StyleExpr = TRUE;

//                     trigger OnValidate()
//                     begin
//                         SelectionnerBLBestBetonOnPush;
//                     end;
//                 }
//                 field(Date; rec.Date)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 field("Code Produit"; rec."Code Produit")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Description Produit"; rec."Description Produit")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Quantité; rec.Quantité)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Style = Unfavorable;
//                     StyleExpr = TRUE;
//                 }
//                 field("Produit Nav"; rec."Produit Nav")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Chantier; rec.Chantier)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Chantier Nav Best-Beton"; rec."Chantier Nav Best-Beton")
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             action(Valider)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Valider';
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 //GL2024 RunObject = Page 8003949;
//                 //GL2024 RunPageLink = "No." = CONST('CMDA-18/001449');
//                 Visible = false;

//                 trigger OnAction()
//                 begin
//                     PurchaseHeader.RESET();
//                     PurchaseHeader.SETRANGE(PurchaseHeader."No.", 'CMDA-18/001449');
//                     IF PurchaseHeader.FINDFIRST THEN BEGIN
//                         PurchaseHeader."Vendor Shipment No." := 'BLTEST01';
//                         PurchaseHeader.MODIFY();

//                     END;


//                     /*IF NOT CONFIRM(Text001) THEN EXIT;
//                     IF Job.GET("Chantier Nav")THEN Job.TESTFIELD(Job."Affectation Magasin");
//                     ItemJournalLine.LOCKTABLE;
//                     ItemJournalLine.SETRANGE("Journal Template Name",'SYNCHRO');
//                     ItemJournalLine.SETRANGE("Journal Batch Name",'SYNCHRO');
//                     ItemJournalLine.DELETEALL;

//                     BlCarriere.SETRANGE(Rapproché,TRUE) ;
//                     BlCarriere.SETRANGE(Integré,FALSE) ;
//                     BlCarriere.SETRANGE(Chantier,Chantier) ;
//                     BlCarriere.SETCURRENTKEY(Chantier,Camion,Date,"N° Sequence");
//                     IF BlCarriere.FINDFIRST THEN REPEAT
//                        //--ENTREE
//                        Ligne+=10000;
//                        BlCarriere.CALCFIELDS("Produit Nav","Chantier Nav","Camion Nav");
//                        ItemJournalLine."Journal Template Name":='SYNCHRO';
//                        ItemJournalLine."Journal Batch Name" :='SYNCHRO';
//                        ItemJournalLine."Line No.":=Ligne;
//                        ItemJournalLine."Document No.":=COPYSTR('ENTREE BL:'+ BlCarriere."N° Sequence",1,20);
//                        ItemJournalLine.VALIDATE("Item No.",BlCarriere."Produit Nav");
//                        ItemJournalLine."Posting Date":=BlCarriere.Date;
//                        ItemJournalLine."Entry Type":=ItemJournalLine."Entry Type"::Purchase;
//                        ItemJournalLine."Document Type":=5;
//                        ItemJournalLine."Source No.":='FRL-2876';
//                        ItemJournalLine.VALIDATE("Qty. per Unit of Measure",1);
//                        ItemJournalLine.VALIDATE("Location Code",Job."Affectation Magasin");
//                        ItemJournalLine.VALIDATE(Quantity,BlCarriere.Quantité);
//                        ItemJournalLine."Lieu De Livraison":=BlCarriere."Chantier Nav";
//                        ItemJournalLine."Job No.":=BlCarriere."Chantier Nav";
//                        ItemJournalLine."Sous Affectation Marche":=BlCarriere."Sous Affectation Marche";
//                        ItemJournalLine."External Document No.":=BlCarriere."N° Sequence";
//                        ItemJournalLine.INSERT;
//                        //---Sortie
//                        Ligne+=10000;
//                        BlCarriere.CALCFIELDS("Produit Nav","Chantier Nav","Camion Nav");
//                        ItemJournalLine."Journal Template Name":='SYNCHRO';
//                        ItemJournalLine."Journal Batch Name" :='SYNCHRO';
//                        ItemJournalLine."Line No.":=Ligne;
//                        ItemJournalLine."Source No.":='FRL-2876';
//                        ItemJournalLine."Document No.":=COPYSTR('SORTIE BL:'+ BlCarriere."N° Sequence",1,20);
//                        ItemJournalLine.VALIDATE("Item No.",BlCarriere."Produit Nav");
//                        ItemJournalLine."Posting Date":=BlCarriere.Date;
//                        ItemJournalLine."Entry Type":=ItemJournalLine."Entry Type"::"Negative Adjmt.";
//                        ItemJournalLine.VALIDATE("Qty. per Unit of Measure",1);
//                        ItemJournalLine.VALIDATE("Location Code",Job."Affectation Magasin");
//                        ItemJournalLine.VALIDATE(Quantity,BlCarriere.Quantité);
//                        ItemJournalLine."Lieu De Livraison":=BlCarriere."Chantier Nav";
//                        ItemJournalLine."Job No.":=BlCarriere."Chantier Nav";
//                        ItemJournalLine."Sous Affectation Marche":=BlCarriere."Sous Affectation Marche";
//                        ItemJournalLine."External Document No.":=BlCarriere."N° Sequence";
//                        ItemJournalLine.INSERT;

//                        // Partie Rendement Camion
//                        EnteteRendemenVehEnr.Journee:=BlCarriere.Date;
//                        EnteteRendemenVehEnr.Provenance:=BlCarriere.Provenance;
//                        EnteteRendemenVehEnr.Destination:=BlCarriere.Destination;
//                        EnteteRendemenVehEnr.Vehicule   :=BlCarriere."Camion Nav";
//                        EnteteRendemenVehEnr.Produit   :=BlCarriere."Produit Nav";
//                        EnteteRendemenVehEnr.Affectation:=BlCarriere."Chantier Nav";
//                        //EnteteRendemenVehEnr.Chauffeur:=BlCarriere.Chauffeur;
//                        EnteteRendemenVehEnr.Volume :=BlCarriere.Volume;
//                        EnteteRendemenVehEnr."Distance Parcourus":=BlCarriere."Distance Parcourus";
//                        EnteteRendemenVehEnr."Durée Theorique (Minute)" :=BlCarriere."Durée Theorique (Minute)";
//                        IF EnteteRendemenVehEnr.INSERT THEN;
//                        Compteur+=60000;
//                        LigneRendVehiculeEnr.Journee:=BlCarriere.Date;
//                        LigneRendVehiculeEnr."Code Affaire" :=BlCarriere."Chantier Nav";
//                        LigneRendVehiculeEnr.Heure  :=BlCarriere.Heure+Compteur;
//                        LigneRendVehiculeEnr.Provenance :=BlCarriere.Provenance;
//                        LigneRendVehiculeEnr.Destination :=BlCarriere.Destination;
//                        LigneRendVehiculeEnr.Vehicule    :=BlCarriere."Camion Nav";
//                        LigneRendVehiculeEnr.Produit     :=BlCarriere."Produit Nav";
//                       // LigneRendVehiculeEnr.Chauffeur   :=BlCarriere.Chauffeur;
//                        LigneRendVehiculeEnr."Distance Parcourus":=BlCarriere."Distance Parcourus";
//                        LigneRendVehiculeEnr.Volume  :=BlCarriere.Volume;
//                        LigneRendVehiculeEnr.Quantité:=BlCarriere.Volume;
//                        LigneRendVehiculeEnr."Durée Theorique (Minute)" :=BlCarriere."Durée Theorique (Minute)";
//                        LigneRendVehiculeEnr2.SETCURRENTKEY(Heure);
//                        LigneRendVehiculeEnr2.SETRANGE(Journee,BlCarriere.Date);
//                        LigneRendVehiculeEnr2.SETRANGE(Provenance,BlCarriere.Provenance);
//                        LigneRendVehiculeEnr2.SETRANGE(Destination,BlCarriere.Destination);
//                        LigneRendVehiculeEnr2.SETRANGE(Produit,BlCarriere."Produit Nav");
//                        LigneRendVehiculeEnr2.SETRANGE(Vehicule,BlCarriere."Camion Nav");
//                        IF LigneRendVehiculeEnr2.FINDLAST  THEN
//                        LigneRendVehiculeEnr."Ecart (Minute)" :=((BlCarriere.Heure-LigneRendVehiculeEnr2.Heure)/60000)-
//                                                                  BlCarriere."Durée Theorique (Minute)";
//                        LigneRendVehiculeEnr.INSERT;
//                        BlCarriere.Integré:=TRUE;
//                        BlCarriere.MODIFY;
//                     UNTIL BlCarriere.NEXT=0;
//                     ItemJrlLine2.SETRANGE("Journal Template Name",'SYNCHRO');
//                     ItemJrlLine2.SETRANGE("Journal Batch Name",'SYNCHRO');
//                     IF ItemJrlLine2.FINDFIRST THEN BEGIN
//                       ItemJournalLine.SETRANGE("Journal Template Name",'SYNCHRO');
//                       ItemJournalLine.SETRANGE("Journal Batch Name",'SYNCHRO');
//                       CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post 2",ItemJournalLine);
//                       END;
//                     MESSAGE(Text002);
//                     */

//                 end;
//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     begin
//         rec.CALCFIELDS("Chantier Nav", "Camion Nav", "Produit Nav");
//     end;

//     trigger OnOpenPage()
//     begin
//         rec.FILTERGROUP(2);
//         Compteur2 := 0;
//         IF UserSetup.GET(UPPERCASE(USERID)) THEN
//             IF UserSetup."Affaire Par Defaut" <> '' THEN BEGIN
//                 ChantierCarriere.SETRANGE(Correspondance, UserSetup."Affaire Par Defaut");
//                 ChantierCarriere.SETRANGE("N° Societe", 'B');
//                 IF ChantierCarriere.FINDFIRST THEN
//                     REPEAT
//                         Compteur2 += 1;
//                         IF Compteur2 = 1 THEN
//                             Filtre := ChantierCarriere.Chantier
//                         ELSE
//                             Filtre += '|' + ChantierCarriere.Chantier
//                     UNTIL ChantierCarriere.NEXT = 0;
//                 rec.SETFILTER(Chantier, Filtre);
//             END;
//         rec.FILTERGROUP(0);
//     end;

//     var
//         Text001: Label '#1 lines selected.\Are you sure to want to validate the selected lines ?';
//         PurchRcptHeader: Record "Purch. Rcpt. Header";
//         PurchRcptLigne: Record "Purch. Rcpt. Line";
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
//         Text002: Label 'Traitement Achevé Avec Succé';
//         Filtre: Text[100];
//         Compteur2: Integer;
//         //   GL2024 PurchaseReceipt: Page 8003949;
//         PurchaseHeader: Record "Purchase Header";
//         NumBL: Code[20];
//         PurchaseLine2: Record "Purchase Line";
//         Text003: Label 'Lancer La Validation du BL ?';
//         NumProduit: Code[20];
//         wPurchPost: Codeunit "Purch. Order - Post";
//         Text004: Label 'Il Faut ajouter Code Produit Navision';
//         Text005: Label 'Article Non Existant Consulter Votre Administrateur';
//         Text006: Label 'Bl Deja Reeptionnée';

//     local procedure SelectionnerBLBestBetonOnPush()
//     begin
//         REC.CALCFIELDS("Produit Nav");
//         PurchRcptHeader.SETRANGE("Vendor Shipment No.", REC."N° Sequence");
//         IF PurchRcptHeader.FINDFIRST THEN BEGIN
//             PurchRcptLigne.SETRANGE("Document No.", PurchRcptHeader."No.");
//             PurchRcptLigne.SETRANGE("No.", REC."Produit Nav");
//             IF PurchRcptLigne.FINDFIRST THEN
//                 IF PurchRcptLigne.Quantity <> 0 THEN ERROR(Text006);
//         END;
//         ItemJournalLine.LOCKTABLE;
//         ItemJournalLine.SETRANGE("Journal Template Name", 'SYNCHRO');
//         ItemJournalLine.SETRANGE("Journal Batch Name", 'SYNCHRO');
//         ItemJournalLine.DELETEALL;
//         IF REC."Produit Nav" = '' THEN BEGIN
//             MESSAGE(Text004);
//             REC."Selectionner BL Best Beton" := FALSE;
//             REC.MODIFY;
//             EXIT;
//         END;

//         IF NOT CONFIRM(Text003) THEN BEGIN
//             REC."Selectionner BL Best Beton" := FALSE;
//             REC.MODIFY;
//             EXIT;
//         END;


//         IF UserSetup.GET(UPPERCASE(USERID)) THEN;
//         PurchaseHeader.RESET();
//         PurchaseHeader.SETRANGE("No.", UserSetup."N° Contrat BL Best Beton");
//         IF PurchaseHeader.FINDFIRST THEN BEGIN
//             PurchaseHeader."Vendor Shipment No." := REC."N° Sequence";
//             PurchaseHeader."Posting Date" := REC.Date;
//             PurchaseHeader.MODIFY();
//         END;
//         PurchaseLine2.RESET();
//         PurchaseLine2.SETRANGE("Document No.", UserSetup."N° Contrat BL Best Beton");
//         IF PurchaseLine2.FINDFIRST THEN
//             REPEAT
//                 PurchaseLine2.VALIDATE(PurchaseLine2."Qty. to Receive", 0);
//                 PurchaseLine2.MODIFY();
//             UNTIL PurchaseLine2.NEXT = 0;
//         REC.CALCFIELDS("Produit Nav");
//         // Debut Verif Article Exist
//         PurchaseLine2.RESET();
//         PurchaseLine2.SETRANGE("Document No.", UserSetup."N° Contrat BL Best Beton");
//         PurchaseLine2.SETRANGE("No.", REC."Produit Nav");
//         IF NOT PurchaseLine2.FINDFIRST THEN ERROR(Text005);
//         // Fin Verif Article Exist
//         PurchaseLine2.RESET();
//         PurchaseLine2.SETRANGE("Document No.", UserSetup."N° Contrat BL Best Beton");
//         PurchaseLine2.SETRANGE("No.", REC."Produit Nav");
//         IF PurchaseLine2.FINDFIRST THEN BEGIN
//             PurchaseLine2.VALIDATE(PurchaseLine2."Qty. to Receive", REC.Quantité);
//             PurchaseLine2.MODIFY();
//         END;


//         wPurchPost.InitRequest(FALSE, TRUE);
//         wPurchPost.RUN(PurchaseHeader);
//         //---Sortie
//         Ligne += 10000;
//         REC.CALCFIELDS("Produit Nav", "Chantier Nav Best-Beton", "Camion Nav");
//         IF Job.GET(REC."Chantier Nav Best-Beton") THEN Job.TESTFIELD(Job."Affectation Magasin");
//         ItemJournalLine."Journal Template Name" := 'SYNCHRO';
//         ItemJournalLine."Journal Batch Name" := 'SYNCHRO';
//         ItemJournalLine."Line No." := Ligne;
//         ItemJournalLine."Source No." := 'FRL-0082';
//         ItemJournalLine."Document No." := COPYSTR('SORTIE BL:' + REC."N° Sequence", 1, 20);
//         ItemJournalLine.VALIDATE("Item No.", REC."Produit Nav");
//         ItemJournalLine."Posting Date" := REC.Date;
//         ItemJournalLine."Entry Type" := ItemJournalLine."Entry Type"::"Negative Adjmt.";
//         ItemJournalLine.VALIDATE("Qty. per Unit of Measure", 1);
//         ItemJournalLine.VALIDATE("Location Code", Job."Affectation Magasin");
//         ItemJournalLine.VALIDATE(Quantity, REC.Quantité);
//         ItemJournalLine."Lieu De Livraison / Provenance" := REC."Chantier Nav";
//         ItemJournalLine."Job No." := REC."Chantier Nav Best-Beton";
//         ItemJournalLine."Sous Affectation Marche" := REC."Sous Affectation Marche";
//         ItemJournalLine."External Document No." := REC."N° Sequence";
//         ItemJournalLine.INSERT;
//         ItemJrlLine2.SETRANGE("Journal Template Name", 'SYNCHRO');
//         ItemJrlLine2.SETRANGE("Journal Batch Name", 'SYNCHRO');
//         IF ItemJrlLine2.FINDFIRST THEN BEGIN
//             ItemJournalLine.SETRANGE("Journal Template Name", 'SYNCHRO');
//             ItemJournalLine.SETRANGE("Journal Batch Name", 'SYNCHRO');
//             CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post 2", ItemJournalLine);
//         END;
//         REC."Integrer BL Best Beton" := TRUE;
//         REC.MODIFY;
//     end;
// }

