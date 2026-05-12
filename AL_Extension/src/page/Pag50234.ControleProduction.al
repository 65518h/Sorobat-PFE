// Page 50234 "Controle Production"
// {
//     DeleteAllowed = false;
//     InsertAllowed = false;
//     PageType = List;
//     SourceTable = "Production Order";
//     SourceTableView = where("Source No." = filter('BET*'),
//                             "Integrer BL" = const(false),
//                             Controlé = const(false));
//     ApplicationArea = all;
//     Caption = 'Controle Production';

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field("No."; REC."No.")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Description; REC.Description)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Source No."; REC."Source No.")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Quantity; REC.Quantity)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Due Date"; REC."Due Date")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Centrale; REC.Centrale)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("N° BL"; REC."N° BL")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Style = Unfavorable;
//                     StyleExpr = true;
//                 }
//                 field(Service; REC.Service)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field(Camion; REC.Camion)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field(Client; REC.Client)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 // field("Client Nav"; REC."Client Nav")
//                 // {
//                 //     ApplicationArea = all;
//                 //     Editable = false;
//                 // }
//                 field("Client Nav 2"; REC."Client Nav 2")
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field(Destination; REC.Destination)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Selectionner; REC.Selectionner)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Controlé"; REC.Controlé)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Archivé';
//                     Style = Strong;
//                     StyleExpr = true;
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

//                 trigger OnAction()
//                 begin
//                     if not Confirm(Text003) then exit;

//                     RecSalesReceivablesSetup.Get;
//                     RecProductionOrder.Copy(Rec);
//                     RecProductionOrder.SetRange(Selectionner, true);
//                     if RecProductionOrder.FindFirst then
//                         repeat
//                             NumSerie := '';
//                             Clear(RecSalesHeader);
//                             Clear(RecSalesLine);
//                             // RecProductionOrder.CalcFields("Client Nav");
//                             // if RecProductionOrder."Client Nav 2" = '' then begin
//                             //     if RecProductionOrder."Client Nav" = '' then Error(Text002);
//                             // end;
//                             NumSerie := NoSeriesMgt.GetNextNo(RecSalesReceivablesSetup."Order Nos.", RecProductionOrder."Due Date", true);
//                             // Insertion Entet Vente
//                             RecSalesHeader.Validate("Document Type", RecSalesHeader."document type"::Order);
//                             RecSalesHeader.Validate("No.", NumSerie);
//                             RecSalesHeader.Validate("Posting Date", RecProductionOrder."Due Date");
//                             if RecProductionOrder."Client Nav 2" <> '' then begin
//                                 RecSalesHeader.Validate("Sell-to Customer No.", RecProductionOrder."Client Nav 2");
//                             end
//                             else
//                             //   RecSalesHeader.Validate("Sell-to Customer No.", RecProductionOrder."Client Nav");
//                             begin
//                             end;

//                             RecSalesHeader.Validate("Job No.", RecProductionOrder.Client); //RecBLCarriere."Job No"
//                             RecSalesHeader.Validate("External Document No.", RecProductionOrder."N° BL");
//                             RecSalesHeader.Validate("No. Series", RecSalesReceivablesSetup."Order Nos.");
//                             RecSalesHeader.Validate("Posting No. Series", RecSalesReceivablesSetup."Posted Invoice Nos.");
//                             RecSalesHeader.Validate("Shipping No. Series", RecSalesReceivablesSetup."Posted Shipment Nos.");
//                             RecSalesHeader."Commande Interne" := true;
//                             RecSalesHeader.Production := true;
//                             RecSalesHeader."User ID" := UpperCase(UserId);
//                             if not RecSalesHeader.Insert then RecSalesHeader.Modify;
//                             // Insertion Ligne Vente
//                             RecSalesLine.Validate("Document Type", RecSalesLine."document type"::Order);
//                             RecSalesLine.Validate("Document No.", RecSalesHeader."No.");
//                             RecSalesLine.Validate(Type, RecSalesLine.Type::Item);
//                             RecSalesLine."Line No." := 10000;

//                             RecSalesLine.Validate("No.", RecProductionOrder."Source No.");
//                             RecSalesLine.Validate(Quantity, RecProductionOrder.Quantity);
//                             if not RecSalesLine.Insert then RecSalesLine.Modify;
//                             // Validation Commande Vente
//                             // Insertion N° Bpn de Commande dans la liste des BL Carriere
//                             RecProductionOrder."Integrer BL" := true;
//                             RecProductionOrder."Code Commande Vente" := RecSalesHeader."No.";
//                             RecProductionOrder.Selectionner := false;
//                             RecProductionOrder.Modify;

//                             // MH SORO 03-06-2022
//                             RecDetailsCommande.Reset;
//                             //  RecDetailsCommande.SetRange("Code Commande", NumSerie);

//                             if RecDetailsCommande.FindFirst then begin
//                                 RecDetailsCommande.Validate(RecDetailsCommande."Code Commande", NumSerie);

//                                 RecDetailsCommande."Matricule Pompe" := REC.Service;
//                                 RecDetailsCommande."Matricule Véhicule" := REC.Camion;
//                                 RecDetailsCommande.Modify;
//                             end
//                             else
//                                 RecDetailsCommande.Validate(RecDetailsCommande."Code Commande", NumSerie);

//                             RecDetailsCommande."Matricule Pompe" := REC.Service;
//                             RecDetailsCommande."Matricule Véhicule" := REC.Camion;
//                             RecDetailsCommande.Insert;

//                             begin
//                             end;

//                         // MH SORO 03-06-2022

//                         until RecProductionOrder.Next = 0;
//                     CurrPage.Update;
//                     Message(Text004);
//                 end;
//             }
//         }
//     }

//     var
//         RecProductionOrder: Record "Production Order";
//         RecSalesReceivablesSetup: Record "Sales & Receivables Setup";
//         NoSeriesMgt: Codeunit NoSeriesManagement;
//         RecSalesHeader: Record "Sales Header";
//         RecSalesLine: Record "Sales Line";
//         RecSalesHeader2: Record "Sales Header";
//         Text001: label 'Vous devez vérifier la correspondance de base client pour le client %1';
//         Text002: label 'Vous devez vérifier le Code Client';
//         Text003: label 'Lancer La Creation Des Commandes ?';
//         Text004: label 'Taches Achever Avec Succée';
//         RecDetailsCommande: Record "Details Commande Vente Beton";
//         NumSerie: Code[20];
// }

