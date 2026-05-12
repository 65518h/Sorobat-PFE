Page 50176 "Corrige Client Avec Num Doc"
{
    PageType = Card;
    ApplicationArea = all;
    Caption = 'Corrige Client Avec Num Doc';
    layout
    {
        area(content)
        {
            field(CdeOrigine; CdeOrigine)
            {
                ApplicationArea = all;
                Caption = 'Origine';
                TableRelation = Customer;
            }
            field(CdeDestination; CdeDestination)
            {
                ApplicationArea = all;
                Caption = 'Destination';
                TableRelation = Customer;
            }
            field(NumDoc; NumDoc)
            {
                ApplicationArea = all;
                Caption = 'Document';
                TableRelation = Customer;
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
                    if NumDoc = '' then Error(Text005);


                    RecGLEntry.Reset;
                    RecGLEntry.SetRange("Source Type", RecGLEntry."source type"::Customer);
                    RecGLEntry.SetRange("Document No.", NumDoc);
                    RecGLEntry.SetRange("Source No.", CdeOrigine);
                    RecGLEntry.ModifyAll("Source No.", CdeDestination);

                    RecValueEntry.Reset;
                    RecValueEntry.SetRange("Source Type", RecGLEntry."source type"::Customer);
                    RecValueEntry.SetRange("Document No.", NumDoc);
                    RecValueEntry.SetRange("Source No.", CdeOrigine);
                    RecValueEntry.ModifyAll("Source No.", CdeDestination);

                    RecItemLedgerEntry.Reset;
                    RecItemLedgerEntry.SetRange("Source Type", RecGLEntry."source type"::Customer);
                    RecItemLedgerEntry.SetRange("Document No.", NumDoc);
                    RecItemLedgerEntry.SetRange("Source No.", CdeOrigine);
                    RecItemLedgerEntry.ModifyAll("Source No.", CdeDestination);


                    RecVATEntry.Reset;
                    RecVATEntry.SetRange("Bill-to/Pay-to No.", CdeOrigine);
                    RecVATEntry.SetRange("Document No.", NumDoc);
                    RecVATEntry.ModifyAll("Bill-to/Pay-to No.", CdeDestination);

                    RecVendorLedgerEntry.Reset;
                    RecVendorLedgerEntry.SetRange("Customer No.", CdeOrigine);
                    RecVendorLedgerEntry.SetRange("Document No.", NumDoc);
                    RecVendorLedgerEntry.ModifyAll("Customer No.", CdeDestination);

                    RecDetailedVendorLedgEntry.Reset;
                    RecDetailedVendorLedgEntry.SetRange("Customer No.", CdeOrigine);
                    RecDetailedVendorLedgEntry.SetRange("Document No.", NumDoc);
                    RecDetailedVendorLedgEntry.ModifyAll("Customer No.", CdeDestination);

                    RecPurchRcptHeader.Reset;
                    RecPurchRcptHeader.SetRange("Sell-to Customer No.", CdeOrigine);
                    RecPurchRcptHeader.SetRange("No.", NumDoc);
                    RecPurchRcptHeader.ModifyAll("Sell-to Customer No.", CdeDestination);

                    RecPurchRcptHeader.Reset;
                    RecPurchRcptHeader.SetRange("Bill-to Customer No.", CdeOrigine);
                    RecPurchRcptHeader.SetRange("No.", NumDoc);
                    RecPurchRcptHeader.ModifyAll("Bill-to Customer No.", CdeDestination);

                    RecPurchRcptLine.Reset;
                    RecPurchRcptLine.SetRange("Sell-to Customer No.", CdeOrigine);
                    RecPurchRcptLine.SetRange("Document No.", NumDoc);
                    RecPurchRcptLine.ModifyAll("Sell-to Customer No.", CdeDestination);

                    RecPurchRcptLine.Reset;
                    RecPurchRcptLine.SetRange("Bill-to Customer No.", CdeOrigine);
                    RecPurchRcptLine.SetRange("Document No.", NumDoc);
                    RecPurchRcptLine.ModifyAll("Bill-to Customer No.", CdeDestination);



                    RecPurchInvHeader.Reset;
                    RecPurchInvHeader.SetRange("Sell-to Customer No.", CdeOrigine);
                    RecPurchInvHeader.SetRange("No.", NumDoc);
                    RecPurchInvHeader.ModifyAll("Sell-to Customer No.", CdeDestination);

                    RecPurchInvHeader.Reset;
                    RecPurchInvHeader.SetRange("Bill-to Customer No.", CdeOrigine);
                    RecPurchInvHeader.SetRange("No.", NumDoc);
                    RecPurchInvHeader.ModifyAll("Bill-to Customer No.", CdeDestination);



                    RecPurchInvLine.Reset;
                    RecPurchInvLine.SetRange("Sell-to Customer No.", CdeOrigine);
                    RecPurchInvLine.SetRange("Document No.", NumDoc);
                    RecPurchInvLine.ModifyAll("Sell-to Customer No.", CdeDestination);

                    RecPurchInvLine.Reset;
                    RecPurchInvLine.SetRange("Bill-to Customer No.", CdeOrigine);
                    RecPurchInvLine.SetRange("Document No.", NumDoc);
                    RecPurchInvLine.ModifyAll("Bill-to Customer No.", CdeDestination);

                    RecPurchCrMemoHdr.Reset;
                    RecPurchCrMemoHdr.SetRange("Sell-to Customer No.", CdeOrigine);
                    RecPurchCrMemoHdr.SetRange("No.", NumDoc);
                    RecPurchCrMemoHdr.ModifyAll("Sell-to Customer No.", CdeDestination);


                    RecPurchCrMemoHdr.Reset;
                    RecPurchCrMemoHdr.SetRange("Bill-to Customer No.", CdeOrigine);
                    RecPurchCrMemoHdr.SetRange("No.", NumDoc);
                    RecPurchCrMemoHdr.ModifyAll("Bill-to Customer No.", CdeDestination);


                    RecPurchCrMemoHdr.Reset;
                    RecPurchCrMemoHdr.SetRange("Invoice Disc. Code", CdeOrigine);
                    RecPurchCrMemoHdr.SetRange("No.", NumDoc);
                    RecPurchCrMemoHdr.ModifyAll("Invoice Disc. Code", CdeDestination);


                    RecPurchCrMemoLine.Reset;
                    RecPurchCrMemoLine.SetRange("Sell-to Customer No.", CdeOrigine);
                    RecPurchCrMemoLine.SetRange("Document No.", NumDoc);
                    RecPurchCrMemoLine.ModifyAll("Sell-to Customer No.", CdeDestination);

                    RecPurchCrMemoLine.Reset;
                    RecPurchCrMemoLine.SetRange("Bill-to Customer No.", CdeOrigine);
                    RecPurchCrMemoLine.SetRange("Document No.", NumDoc);
                    RecPurchCrMemoLine.ModifyAll("Bill-to Customer No.", CdeDestination);

                    RecPaymentLine.Reset;
                    RecPaymentLine.SetRange("Account Type", RecPaymentLine."account type"::Customer);
                    RecPaymentLine.SetRange("No.", NumDoc);
                    RecPaymentLine.SetRange("Account No.", CdeOrigine);
                    RecPaymentLine.ModifyAll("Account No.", CdeDestination);

                    Message(Text004);
                end;
            }
        }
    }

    var
        RecGLEntry: Record "G/L Entry";
        RecVendorLedgerEntry: Record "Cust. Ledger Entry";
        RecDetailedVendorLedgEntry: Record "Detailed Cust. Ledg. Entry";
        RecPurchRcptHeader: Record "Sales Shipment Header";
        RecPurchRcptLine: Record "Sales Shipment Line";
        RecPurchInvHeader: Record "Sales Invoice Header";
        RecPurchInvLine: Record "Sales Invoice Line";
        RecPurchCrMemoHdr: Record "Sales Cr.Memo Header";
        RecPurchCrMemoLine: Record "Sales Cr.Memo Line";
        RecPaymentLine: Record "Payment Line";
        RecVATEntry: Record "VAT Entry";
        RecValueEntry: Record "Value Entry";
        RecItemLedgerEntry: Record "Item Ledger Entry";
        RecPurchaseHeader: Record "Sales Header";
        RecPurchaseLine: Record "Sales Line";
        CdeOrigine: Code[20];
        CdeDestination: Code[20];
        Text001: label 'Lancer Le Chagnement De Client ?';
        Text002: label 'Remplir Client Origine';
        Text003: label 'Remplir Client Destination';
        Text004: label 'Traitement Achevé Avec Succé';
        NumDoc: Code[20];
        Text005: label 'Remplir CNum Doc';
}

