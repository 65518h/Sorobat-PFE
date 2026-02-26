Page 50222 "Corrige Article"
{
    PageType = Card;
    ApplicationArea = all;
    Caption = 'Corrige Article';
    layout
    {
        area(content)
        {
            field(CdeOrigine; CdeOrigine)
            {
                ApplicationArea = all;
                Caption = 'Origine';
                TableRelation = Item;
            }
            field(CdeDestination; CdeDestination)
            {
                ApplicationArea = all;
                Caption = 'Destination';
                TableRelation = Item;
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



                    RecPurchaseLine.Reset;
                    RecPurchaseLine.SetRange("No.", CdeOrigine);
                    RecPurchaseLine.ModifyAll("No.", CdeDestination);


                    RecValueEntry.Reset;
                    RecValueEntry.SetRange("Item No.", CdeOrigine);
                    RecValueEntry.ModifyAll("Item No.", CdeDestination);

                    RecItemLedgerEntry.Reset;
                    RecItemLedgerEntry.SetRange("Item No.", CdeOrigine);
                    RecItemLedgerEntry.ModifyAll("Item No.", CdeDestination);


                    RecPurchRcptLine.Reset;
                    RecPurchRcptLine.SetRange("No.", CdeOrigine);
                    RecPurchRcptLine.ModifyAll("No.", CdeDestination);




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
}

