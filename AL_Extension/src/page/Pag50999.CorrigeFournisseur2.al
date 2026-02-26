Page 50999 "Corrige Fournisseur 2"
{
    PageType = Card;
    ApplicationArea = all;
    Caption = 'Corrige Fournisseur 2';
    layout
    {
        area(content)
        {
            field(CdeOrigine; CdeOrigine)
            {
                ApplicationArea = all;
                Caption = 'Origine';
                TableRelation = Vendor;
            }
            field(CdeDestination; CdeDestination)
            {
                ApplicationArea = all;
                Caption = 'Destination';
                TableRelation = Vendor;
            }
            field(CdeDocNo; CdeDocNo)
            {
                Caption = 'N° Doc';
                ApplicationArea = all;
            }

        }
    }

    actions
    {
        area(processing)
        {
            action(OK)
            {
                ApplicationArea = all;
                Caption = 'OK';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if not Confirm(Text001) then exit;
                    if CdeOrigine = '' then Error(Text002);
                    if CdeDestination = '' then Error(Text003);

                    RecPurchaseHeader.Reset;
                    RecPurchaseHeader.SetRange("No.", CdeDocNo);
                    RecPurchaseHeader.SetRange("Buy-from Vendor No.", CdeOrigine);
                    RecPurchaseHeader.ModifyAll("Buy-from Vendor No.", CdeDestination);

                    RecPurchaseHeader.Reset;
                    RecPurchaseHeader.SetRange("No.", CdeDocNo);
                    RecPurchaseHeader.SetRange("Pay-to Vendor No.", CdeOrigine);
                    RecPurchaseHeader.ModifyAll("Pay-to Vendor No.", CdeDestination);

                    RecPurchaseLine.Reset;
                    RecPurchaseLine.SetRange("Document No.", CdeDocNo);
                    RecPurchaseLine.SetRange("Buy-from Vendor No.", CdeOrigine);
                    RecPurchaseLine.ModifyAll("Buy-from Vendor No.", CdeDestination);

                    RecPurchaseLine.Reset;
                    RecPurchaseLine.SetRange("Document No.", CdeDocNo);
                    RecPurchaseLine.SetRange("Pay-to Vendor No.", CdeOrigine);
                    RecPurchaseLine.ModifyAll("Pay-to Vendor No.", CdeDestination);


                    RecPurchRcptHeader.Reset;
                    RecPurchRcptHeader.SetRange("Order No.", CdeDocNo);
                    RecPurchRcptHeader.SetRange("Buy-from Vendor No.", CdeOrigine);
                    RecPurchRcptHeader.ModifyAll("Buy-from Vendor No.", CdeDestination);


                    RecPurchRcptHeader.Reset;
                    RecPurchRcptHeader.SetRange("Order No.", CdeDocNo);
                    RecPurchRcptHeader.SetRange("Pay-to Vendor No.", CdeOrigine);
                    RecPurchRcptHeader.ModifyAll("Pay-to Vendor No.", CdeDestination);


                    RecPurchRcptLine.Reset;
                    RecPurchRcptLine.SetRange("Order No.", CdeDocNo);
                    RecPurchRcptLine.SetRange("Buy-from Vendor No.", CdeOrigine);
                    RecPurchRcptLine.ModifyAll("Buy-from Vendor No.", CdeDestination);

                    RecPurchRcptLine.Reset;
                    RecPurchRcptLine.SetRange("Order No.", CdeDocNo);
                    RecPurchRcptLine.SetRange("Pay-to Vendor No.", CdeOrigine);
                    RecPurchRcptLine.ModifyAll("Pay-to Vendor No.", CdeDestination);



                    Message(Text004);
                end;
            }
        }
    }

    var
        RecGLEntry: Record "G/L Entry";
        RecVendorLedgerEntry: Record "Vendor Ledger Entry";
        RecDetailedVendorLedgEntry: Record "Detailed Vendor Ledg. Entry";
        RecPurchRcptHeader: Record "Purch. Rcpt. Header";
        RecPurchRcptLine: Record "Purch. Rcpt. Line";
        RecPurchInvHeader: Record "Purch. Inv. Header";
        RecPurchInvLine: Record "Purch. Inv. Line";
        RecPurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        RecPurchCrMemoLine: Record "Purch. Cr. Memo Line";
        RecPaymentLine: Record "Payment Line";
        RecVATEntry: Record "VAT Entry";
        RecValueEntry: Record "Value Entry";
        RecItemLedgerEntry: Record "Item Ledger Entry";
        RecPurchaseHeader: Record "Purchase Header";
        RecPurchaseLine: Record "Purchase Line";
        CdeOrigine: Code[20];
        CdeDestination: Code[20];
        Text001: label 'Lancer Le Chagnement De Fournisseur ?';
        Text002: label 'Remplir Fournisseur Origine';
        Text003: label 'Remplir Fournisseur Destination';
        Text004: label 'Traitement Achevé Avec Succé';
        CdeDocNo: Code[20];
        Text19021107: label 'N° Doc';

}

