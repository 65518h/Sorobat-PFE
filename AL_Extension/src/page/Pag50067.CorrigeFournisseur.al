Page 50067 "Corrige Fournisseur"
{
    PageType = Card;
    ApplicationArea = all;
    UsageCategory = Administration;
    Caption = 'Corrige Fournisseur';
    layout
    {
        area(content)
        {
            field(CdeOrigine; CdeOrigine)
            {
                ApplicationArea = all;
                Caption = 'Origin';
                TableRelation = Vendor;
            }
            field(CdeDestination; CdeDestination)
            {
                ApplicationArea = all;
                Caption = 'Origin';
                TableRelation = Vendor;
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
                    RecPurchaseHeader.SetRange("Buy-from Vendor No.", CdeOrigine);
                    RecPurchaseHeader.ModifyAll("Buy-from Vendor No.", CdeDestination);

                    RecPurchaseHeader.Reset;
                    RecPurchaseHeader.SetRange("Pay-to Vendor No.", CdeOrigine);
                    RecPurchaseHeader.ModifyAll("Pay-to Vendor No.", CdeDestination);

                    RecPurchaseLine.Reset;
                    RecPurchaseLine.SetRange("Buy-from Vendor No.", CdeOrigine);
                    RecPurchaseLine.ModifyAll("Buy-from Vendor No.", CdeDestination);

                    RecPurchaseLine.Reset;
                    RecPurchaseLine.SetRange("Pay-to Vendor No.", CdeOrigine);
                    RecPurchaseLine.ModifyAll("Pay-to Vendor No.", CdeDestination);


                    RecGLEntry.Reset;
                    RecGLEntry.SetRange("Source Type", RecGLEntry."source type"::Vendor);
                    RecGLEntry.SetRange("Source No.", CdeOrigine);
                    RecGLEntry.ModifyAll("Source No.", CdeDestination);

                    RecValueEntry.Reset;
                    RecValueEntry.SetRange("Source Type", RecGLEntry."source type"::Vendor);
                    RecValueEntry.SetRange("Source No.", CdeOrigine);
                    RecValueEntry.ModifyAll("Source No.", CdeDestination);

                    RecItemLedgerEntry.Reset;
                    RecItemLedgerEntry.SetRange("Source Type", RecGLEntry."source type"::Vendor);
                    RecItemLedgerEntry.SetRange("Source No.", CdeOrigine);
                    RecItemLedgerEntry.ModifyAll("Source No.", CdeDestination);


                    RecVATEntry.Reset;
                    RecVATEntry.SetRange("Bill-to/Pay-to No.", CdeOrigine);
                    RecVATEntry.ModifyAll("Bill-to/Pay-to No.", CdeDestination);

                    RecVendorLedgerEntry.Reset;
                    RecVendorLedgerEntry.SetRange("Vendor No.", CdeOrigine);
                    RecVendorLedgerEntry.ModifyAll("Vendor No.", CdeDestination);

                    RecDetailedVendorLedgEntry.Reset;
                    RecDetailedVendorLedgEntry.SetRange("Vendor No.", CdeOrigine);
                    RecDetailedVendorLedgEntry.ModifyAll("Vendor No.", CdeDestination);

                    RecPurchRcptHeader.Reset;
                    RecPurchRcptHeader.SetRange("Buy-from Vendor No.", CdeOrigine);
                    RecPurchRcptHeader.ModifyAll("Buy-from Vendor No.", CdeDestination);

                    RecPurchRcptHeader.Reset;
                    RecPurchRcptHeader.SetRange("Pay-to Vendor No.", CdeOrigine);
                    RecPurchRcptHeader.ModifyAll("Pay-to Vendor No.", CdeDestination);

                    RecPurchRcptLine.Reset;
                    RecPurchRcptLine.SetRange("Buy-from Vendor No.", CdeOrigine);
                    RecPurchRcptLine.ModifyAll("Buy-from Vendor No.", CdeDestination);

                    RecPurchRcptLine.Reset;
                    RecPurchRcptLine.SetRange("Pay-to Vendor No.", CdeOrigine);
                    RecPurchRcptLine.ModifyAll("Pay-to Vendor No.", CdeDestination);



                    RecPurchInvHeader.Reset;
                    RecPurchInvHeader.SetRange("Pay-to Vendor No.", CdeOrigine);
                    RecPurchInvHeader.ModifyAll("Pay-to Vendor No.", CdeDestination);

                    RecPurchInvHeader.Reset;
                    RecPurchInvHeader.SetRange("Buy-from Vendor No.", CdeOrigine);
                    RecPurchInvHeader.ModifyAll("Buy-from Vendor No.", CdeDestination);



                    RecPurchInvLine.Reset;
                    RecPurchInvLine.SetRange("Buy-from Vendor No.", CdeOrigine);
                    RecPurchInvLine.ModifyAll("Buy-from Vendor No.", CdeDestination);

                    RecPurchInvLine.Reset;
                    RecPurchInvLine.SetRange("Pay-to Vendor No.", CdeOrigine);
                    RecPurchInvLine.ModifyAll("Pay-to Vendor No.", CdeDestination);

                    RecPurchCrMemoHdr.Reset;
                    RecPurchCrMemoHdr.SetRange("Pay-to Vendor No.", CdeOrigine);
                    RecPurchCrMemoHdr.ModifyAll("Pay-to Vendor No.", CdeDestination);


                    RecPurchCrMemoHdr.Reset;
                    RecPurchCrMemoHdr.SetRange("Pay-to Vendor No.", CdeOrigine);
                    RecPurchCrMemoHdr.ModifyAll("Pay-to Vendor No.", CdeDestination);

                    RecPurchCrMemoHdr.Reset;
                    RecPurchCrMemoHdr.SetRange("Buy-from Vendor No.", CdeOrigine);
                    RecPurchCrMemoHdr.ModifyAll("Buy-from Vendor No.", CdeDestination);

                    RecPurchCrMemoLine.Reset;
                    RecPurchCrMemoLine.SetRange("Pay-to Vendor No.", CdeOrigine);
                    RecPurchCrMemoLine.ModifyAll("Pay-to Vendor No.", CdeDestination);

                    RecPurchCrMemoLine.Reset;
                    RecPurchCrMemoLine.SetRange("Buy-from Vendor No.", CdeOrigine);
                    RecPurchCrMemoLine.ModifyAll("Buy-from Vendor No.", CdeDestination);

                    RecPaymentLine.Reset;
                    RecPaymentLine.SetRange("Account Type", RecPaymentLine."account type"::Vendor);
                    RecPaymentLine.SetRange("Account No.", CdeOrigine);
                    RecPaymentLine.ModifyAll("Account No.", CdeDestination);

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
        Text001: label 'Démarrer le changement de fournisseur ?';
        Text002: label 'Remplir le fournisseur d’origine.';
        Text003: label 'Remplir le fournisseur de destination.';
        Text004: label 'Traitement terminé avec succès.';
}

