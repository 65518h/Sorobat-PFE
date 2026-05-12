// Page 74798 "Recuperation Commande Achat"
// {//GL2024  ID dans Nav 2009 : "8"
//     PageType = Card;
//     SourceTable = "Purchase Header";
//     ApplicationArea = All;

//     layout
//     {
//         area(content)
//         {
//             field(CodeCommande; CodeCommande)
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'N° Commande Achat';
//                 TableRelation = "Purchase Header";
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             action(Valider)
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Valider';
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 begin
//                     if CodeCommande <> '' then begin
//                         if RecCopieEntetAchat.Get(RecCopieEntetAchat."type document"::Order, CodeCommande) then;
//                         if Rec.Get(Rec."document type"::Order, CodeCommande) then;
//                         REC."N° Demande d'achat" := RecCopieEntetAchat."N° Demande d'achat";
//                         REC."N° DA Chantier" := RecCopieEntetAchat."N° DA Chantier";
//                         REC."Date DA" := RecCopieEntetAchat."Date DA";
//                         REC."N° Devis Fournisseur" := RecCopieEntetAchat."N° Devis Fournisseur";
//                         Rec."Purchaser Code" := RecCopieEntetAchat."Code acheteur";
//                         Rec."Entry Point" := RecCopieEntetAchat."Pays provenance";
//                         Rec."Payment Terms Code" := RecCopieEntetAchat."Code condition paiement";
//                         REC."Shipment Remark" := RecCopieEntetAchat."Observation 1";
//                         Rec."Pay-to Address 2" := RecCopieEntetAchat."Observation 2";
//                         Rec."Pay-to Name 2" := RecCopieEntetAchat."Observation 3";
//                         Rec.Modify;
//                         Message(TEXT001);
//                     end
//                     else begin
//                         RecPurchaseHeader.SetRange(RecPurchaseHeader."Document Type", RecPurchaseHeader."document type"::Order);
//                         if RecPurchaseHeader.FindFirst then
//                             repeat
//                                 if RecCopieEntetAchat.Get(RecPurchaseHeader."Document Type", RecPurchaseHeader."No.") then begin
//                                     RecPurchaseHeader."N° Demande d'achat" := RecCopieEntetAchat."N° Demande d'achat";
//                                     RecPurchaseHeader."N° DA Chantier" := RecCopieEntetAchat."N° DA Chantier";
//                                     RecPurchaseHeader."Date DA" := RecCopieEntetAchat."Date DA";
//                                     RecPurchaseHeader."N° Devis Fournisseur" := RecCopieEntetAchat."N° Devis Fournisseur";
//                                     RecPurchaseHeader."Purchaser Code" := RecCopieEntetAchat."Code acheteur";
//                                     RecPurchaseHeader."Entry Point" := RecCopieEntetAchat."Pays provenance";
//                                     RecPurchaseHeader."Payment Terms Code" := RecCopieEntetAchat."Code condition paiement";
//                                     RecPurchaseHeader."Shipment Remark" := RecCopieEntetAchat."Observation 1";
//                                     RecPurchaseHeader."Pay-to Address 2" := RecCopieEntetAchat."Observation 2";
//                                     RecPurchaseHeader."Pay-to Name 2" := RecCopieEntetAchat."Observation 3";
//                                     RecPurchaseHeader.Modify;
//                                 end;
//                             //MESSAGE(TEXT001,RecVendor."No.");
//                             until RecPurchaseHeader.Next = 0;
//                     end;
//                 end;
//             }
//         }
//     }

//     var
//         CodeCommande: Code[20];
//         RecCopieEntetAchat: Record "Copie Table Entet Achat";
//         TEXT001: label 'MODIFICATION REUISSITE DE la COMMANDE %1';
//         RecPurchaseHeader: Record "Purchase Header";
// }

