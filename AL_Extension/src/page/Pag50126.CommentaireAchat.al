// Page 50126 "Commentaire Achat"
// {
//     // //+REF+MEMOPAD CW 11/02/05 OnOpenForm

//     AutoSplitKey = true;
//     Caption = 'Commentaire Achat';
//     DataCaptionFields = "Document Type", "No.";
//     DelayedInsert = true;
//     LinksAllowed = false;
//     MultipleNewLines = true;
//     PageType = ListPart;
//     SourceTable = "Purch. Comment Line";
//     SourceTableView = where("Document Line No." = const(0));
//     ApplicationArea = All;

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field(Comment; REC.Comment)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Observations';
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     trigger OnInsertRecord(BelowxRec: Boolean): Boolean
//     begin
//         // >> HJ SORO 09-10-2015
//         if PurchaseHeader.Get(REC."Document Type", REC."No.") then begin
//             if REC."Line No." = 10000 then PurchaseHeader."Shipment Remark" := CopyStr(REC.Comment, 1, 160);
//             if REC."Line No." = 20000 then PurchaseHeader."Pay-to Address 2" := CopyStr(REC.Comment, 1, 100);
//             if REC."Line No." = 30000 then PurchaseHeader."Pay-to Name 2" := CopyStr(REC.Comment, 1, 100);
//             if RecCopieEntetAchat.Get(REC."Document Type", REC."No.") then begin
//                 RecCopieEntetAchat."N° Demande d'achat" := PurchaseHeader."N° Demande d'achat";
//                 RecCopieEntetAchat."N° DA Chantier" := PurchaseHeader."N° DA Chantier";
//                 RecCopieEntetAchat."Date DA" := PurchaseHeader."Date DA";
//                 RecCopieEntetAchat."N° Devis Fournisseur" := PurchaseHeader."N° Devis Fournisseur";
//                 RecCopieEntetAchat."Code acheteur" := PurchaseHeader."Purchaser Code";
//                 RecCopieEntetAchat."Pays provenance" := PurchaseHeader."Entry Point";
//                 RecCopieEntetAchat."Code condition paiement" := PurchaseHeader."Payment Terms Code";
//                 RecCopieEntetAchat."Observation 1" := PurchaseHeader."Shipment Remark";
//                 RecCopieEntetAchat."Observation 2" := PurchaseHeader."Pay-to Address 2";
//                 RecCopieEntetAchat."Observation 3" := PurchaseHeader."Pay-to Name 2";
//                 RecCopieEntetAchat.Modify;
//             end
//             else begin
//                 // Nouvelle Insertion
//                 RecCopieEntetAchat."Type Document" := PurchaseHeader."Document Type";
//                 RecCopieEntetAchat."N° Demande d'achat" := PurchaseHeader."N° Demande d'achat";
//                 RecCopieEntetAchat."N° DA Chantier" := PurchaseHeader."N° DA Chantier";
//                 RecCopieEntetAchat."Date DA" := PurchaseHeader."Date DA";
//                 RecCopieEntetAchat."N° Devis Fournisseur" := PurchaseHeader."N° Devis Fournisseur";
//                 RecCopieEntetAchat."Code acheteur" := PurchaseHeader."Purchaser Code";
//                 RecCopieEntetAchat."Pays provenance" := PurchaseHeader."Entry Point";
//                 RecCopieEntetAchat."Code condition paiement" := PurchaseHeader."Payment Terms Code";
//                 RecCopieEntetAchat."Observation 1" := PurchaseHeader."Shipment Remark";
//                 RecCopieEntetAchat."Observation 2" := PurchaseHeader."Pay-to Address 2";
//                 RecCopieEntetAchat."Observation 3" := PurchaseHeader."Pay-to Name 2";
//                 RecCopieEntetAchat."N° Document" := PurchaseHeader."No.";
//                 if not RecCopieEntetAchat.Insert then RecCopieEntetAchat.Modify;
//                 // Nouvelle Insertion
//             end;

//             PurchaseHeader.Modify;
//         end;
//         // >> HJ SORO 09-10-2015
//     end;

//     trigger OnModifyRecord(): Boolean
//     begin
//         // >> HJ SORO 09-10-2015
//         if PurchaseHeader.Get(REC."Document Type", REC."No.") then begin
//             if REC."Line No." = 10000 then PurchaseHeader."Shipment Remark" := CopyStr(REC.Comment, 1, 160);
//             if REC."Line No." = 20000 then PurchaseHeader."Pay-to Address 2" := CopyStr(REC.Comment, 1, 100);
//             if REC."Line No." = 30000 then PurchaseHeader."Pay-to Name 2" := CopyStr(REC.Comment, 1, 100);
//             if RecCopieEntetAchat.Get(REC."Document Type", REC."No.") then begin
//                 RecCopieEntetAchat."N° Demande d'achat" := PurchaseHeader."N° Demande d'achat";
//                 RecCopieEntetAchat."N° DA Chantier" := PurchaseHeader."N° DA Chantier";
//                 RecCopieEntetAchat."Date DA" := PurchaseHeader."Date DA";
//                 RecCopieEntetAchat."N° Devis Fournisseur" := PurchaseHeader."N° Devis Fournisseur";
//                 RecCopieEntetAchat."Code acheteur" := PurchaseHeader."Purchaser Code";
//                 RecCopieEntetAchat."Pays provenance" := PurchaseHeader."Entry Point";
//                 RecCopieEntetAchat."Code condition paiement" := PurchaseHeader."Payment Terms Code";
//                 RecCopieEntetAchat."Observation 1" := PurchaseHeader."Shipment Remark";
//                 RecCopieEntetAchat."Observation 2" := PurchaseHeader."Pay-to Address 2";
//                 RecCopieEntetAchat."Observation 3" := PurchaseHeader."Pay-to Name 2";
//                 RecCopieEntetAchat.Modify;
//             end
//             else begin
//                 // Nouvelle Insertion
//                 RecCopieEntetAchat."Type Document" := PurchaseHeader."Document Type";
//                 RecCopieEntetAchat."N° Demande d'achat" := PurchaseHeader."N° Demande d'achat";
//                 RecCopieEntetAchat."N° DA Chantier" := PurchaseHeader."N° DA Chantier";
//                 RecCopieEntetAchat."Date DA" := PurchaseHeader."Date DA";
//                 RecCopieEntetAchat."N° Devis Fournisseur" := PurchaseHeader."N° Devis Fournisseur";
//                 RecCopieEntetAchat."Code acheteur" := PurchaseHeader."Purchaser Code";
//                 RecCopieEntetAchat."Pays provenance" := PurchaseHeader."Entry Point";
//                 RecCopieEntetAchat."Code condition paiement" := PurchaseHeader."Payment Terms Code";
//                 RecCopieEntetAchat."Observation 1" := PurchaseHeader."Shipment Remark";
//                 RecCopieEntetAchat."Observation 2" := PurchaseHeader."Pay-to Address 2";
//                 RecCopieEntetAchat."Observation 3" := PurchaseHeader."Pay-to Name 2";
//                 RecCopieEntetAchat."N° Document" := PurchaseHeader."No.";
//                 if not RecCopieEntetAchat.Insert then RecCopieEntetAchat.Modify;
//                 // Nouvelle Insertion
//             end;

//             PurchaseHeader.Modify;
//         end;
//         // >> HJ SORO 09-10-2015
//     end;

//     trigger OnNewRecord(BelowxRec: Boolean)
//     begin
//         REC.SetUpNewLine;
//     end;

//     trigger OnOpenPage()
//     var
//         lMemoPad: Codeunit "MemoPad Management";
//         lRecordRef: RecordRef;
//         lPurchaseHeader: Record "Sales Header";
//     begin
//         //+REF+MEMOPAD
//         lRecordRef.GetTable(Rec);
//         lPurchaseHeader."Document Type" := REC."Document Type";
//         if lMemoPad.Edit(lRecordRef, Format(lPurchaseHeader."Document Type")) then
//             CurrPage.Close;
//         //+REF+MEMOPAD//
//     end;

//     var
//         PurchaseHeader: Record "Purchase Header";
//         RecCopieEntetAchat: Record "Copie Table Entet Achat";
// }

