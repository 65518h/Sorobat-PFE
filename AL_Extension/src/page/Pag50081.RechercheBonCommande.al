// GL2024
// Page 50081 "Recherche Bon Commande"
// {
//     PageType = card;
//     SourceTable = "Purchase Line 2";
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     Caption = 'Search Bon Order';
//     layout
//     {
//         area(content)
//         {
//             group("Critéres")
//             {
//                 field("Date Entre"; DateDebut)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Et; DateFin)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Fournisseurs; Fournisseurs)
//                 {
//                     ApplicationArea = all;
//                     TableRelation = Vendor;
//                 }
//                 field(Lieu; Lieu)
//                 {
//                     ApplicationArea = all;
//                     TableRelation = "Entry/Exit Point";
//                 }
//                 field("Observation 1"; Observations)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Observation 2"; Observations2)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Observation 22"; Observations3)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Observation 3';
//                 }
//                 field(Designation; Designation)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Affectation; Affectations)
//                 {
//                     ApplicationArea = all;
//                     TableRelation = "Salesperson/Purchaser";
//                 }
//                 field("BC N°"; BC)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("DA N°"; DA)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Statut; Satut)
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//             repeater("<Control1>")
//             {

//                 ShowCaption = false;
//                 field("<Date de rangement>"; rec."Expected Receipt Date")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("<N° document>"; rec."Document No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("<Nom Fournisseurs>"; rec."Nom Fournisseurs")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Vendor Name';
//                 }
//                 field("<N°>"; rec."No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("<Désignation>"; rec.Description)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("<Code magasin>"; rec."Location Code")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("<Quantité>"; rec.Quantity)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("<Coût unitaire direct>"; rec."Direct Unit Cost")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("<Quantité restante>"; rec."Outstanding Quantity")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("<Quantité reçue>"; rec."Quantity Received")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("<Montant>"; rec.Amount)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("<Montant TTC>"; rec."Amount Including VAT")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("<% remise ligne>"; rec."Line Discount %")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("<Lieu Livraison>"; rec."Lieu Livraison")
//                 {
//                     ApplicationArea = all;

//                 }
//                 field("<Affectation>"; rec.Affectation)
//                 {
//                     ApplicationArea = all;

//                 }
//                 field("<Observation1>"; Observations)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Observation 1';
//                 }
//                 field("<Observation2>"; Observations2)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Observation 2';
//                 }
//                 field("<Observation3>"; Observations3)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Observation 3';
//                 }
//                 field("<Montant remise ligne>"; rec."Line Discount Amount")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("<Qté reçue non facturée>"; rec."Qty. Rcd. Not Invoiced")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("<Quantité facturée>"; rec."Quantity Invoiced")
//                 {
//                     ApplicationArea = all;

//                     trigger OnValidate()
//                     begin
//                         rec.SetRange(Utilisateur, UpperCase(UserId));
//                         PurchseLineTmp.SetRange(Utilisateur, UpperCase(UserId));
//                         PurchseLineTmp.DeleteAll;
//                     end;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(creation)
//         {
//             action(Initialisation)
//             {
//                 ApplicationArea = all;

//                 trigger OnAction()
//                 begin
//                     PurchseLineTmp.SetRange(Utilisateur, UpperCase(UserId));
//                     PurchseLineTmp.DeleteAll;
//                     PurchaseHeader.Reset;
//                     PurchseLine.Reset;
//                     DateDebut := 0D;
//                     DateFin := 0D;
//                     Fournisseurs := '';
//                     rec.Affectation := '';
//                     rec.Affectation := '';
//                     Lieu := '';
//                     Observations := '';
//                     Observations2 := '';
//                     Observations3 := '';
//                     BC := '';
//                     DA := '';
//                     Designation := '';
//                 end;
//             }
//             action(Rafraichir)
//             {
//                 ApplicationArea = all;

//                 trigger OnAction()
//                 begin
//                     PurchseLineTmp.SetRange(Utilisateur, UpperCase(UserId));
//                     PurchseLineTmp.DeleteAll;
//                     PurchaseHeader.SetCurrentkey("Document Type", "Etat Commande", "Posting Date", "Buy-from Vendor No.", "Purchaser Code",
//                     "Ship-to Address", "Shipment Remark", "Pay-to Address 2", "Pay-to Name 2", "No.", "N° Demande d'achat");
//                     PurchaseHeader.SetRange("Document Type", PurchseLine."document type"::Order);
//                     PurchaseHeader.SetRange("Etat Commande", Satut);
//                     if (DateDebut <> 0D) and (DateFin <> 0D) then PurchaseHeader.SetRange("Posting Date", DateDebut, DateFin);
//                     if Fournisseurs <> '' then PurchaseHeader.SetRange("Buy-from Vendor No.", Fournisseurs);
//                     if Affectations <> '' then PurchaseHeader.SetRange("Purchaser Code", Affectations);
//                     if Lieu <> '' then PurchaseHeader.SetFilter("Ship-to Address", '%1', '*' + Lieu + '*');
//                     if Observations <> '' then PurchaseHeader.SetFilter("Shipment Remark", '%1', '*' + Observations + '*');
//                     if Observations2 <> '' then PurchaseHeader.SetFilter("Pay-to Address 2", '%1', '*' + Observations2 + '*');
//                     if Observations3 <> '' then PurchaseHeader.SetFilter("Pay-to Name 2", '%1', '*' + Observations3 + '*');
//                     if BC <> '' then PurchaseHeader.SetFilter("No.", '%1', '*' + BC + '*');
//                     if DA <> '' then PurchaseHeader.SetFilter("N° Demande d'achat", '%1', '*' + DA + '*');
//                     if PurchaseHeader.FindFirst then
//                         repeat
//                             PurchseLine.SetRange("Document Type", PurchaseHeader."document type"::Order);
//                             PurchseLine.SetRange("Document No.", PurchaseHeader."No.");
//                             if Designation <> '' then PurchseLine.SetFilter(Description, '%1', '*' + Designation + '*');
//                             if PurchseLine.FindFirst then
//                                 repeat
//                                     PurchseLineTmp.TransferFields(PurchseLine);
//                                     PurchseLineTmp.Utilisateur := UpperCase(UserId);
//                                     PurchseLineTmp."Buy-from Vendor No." := PurchaseHeader."Buy-from Vendor No.";
//                                     PurchseLineTmp.Observation1 := PurchaseHeader."Shipment Remark";
//                                     PurchseLineTmp.Observation2 := PurchaseHeader."Pay-to Address 2";
//                                     PurchseLineTmp.Observation3 := PurchaseHeader."Pay-to Name 2";
//                                     PurchseLineTmp."Expected Receipt Date" := PurchaseHeader."Posting Date";
//                                     PurchseLineTmp."Nom Fournisseurs" := PurchaseHeader."Pay-to Name";
//                                     if SalespersonPurchaser.Get(PurchaseHeader."Purchaser Code") then;
//                                     if EntryExitPoint.Get(PurchaseHeader."Entry Point") then;
//                                     PurchseLineTmp."Lieu Livraison" := EntryExitPoint.Description;
//                                     PurchseLineTmp.Affectation := SalespersonPurchaser.Name;
//                                     if PurchseLineTmp.Insert then;
//                                 until PurchseLine.Next = 0;

//                         until PurchaseHeader.Next = 0;

//                     CurrPage.Update;
//                     Message(Text001);
//                 end;
//             }
//         }
//     }

//     var
//         PurchaseHeader: Record "Purchase Header";
//         PurchseLine: Record "Purchase Line";
//         PurchseLineTmp: Record "Purchase Line 2";
//         DateDebut: Date;
//         DateFin: Date;
//         Fournisseurs: Code[20];
//         Lieu: Text[30];
//         Designation: Text[30];
//         Observations: Text[30];
//         Observations2: Text[30];
//         Observations3: Text[30];
//         Affectations: Text[30];
//         BC: Text[30];
//         DA: Text[30];
//         Satut: Option Normal,"En Instance",Reclamation,Annulation;
//         SalespersonPurchaser: Record "Salesperson/Purchaser";
//         EntryExitPoint: Record "Entry/Exit Point";
//         Text001: label 'Processing Completed';
// }

