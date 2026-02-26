Page 50111 "Corrige Client"
{
    PageType = Card;
    ApplicationArea = all;
    Caption = 'Corrige Client';
    UsageCategory = Administration;

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
                    RecPurchaseHeader.SetRange("Sell-to Customer No.", CdeOrigine);
                    RecPurchaseHeader.ModifyAll("Sell-to Customer No.", CdeDestination);

                    RecPurchaseHeader.Reset;
                    RecPurchaseHeader.SetRange("Bill-to Customer No.", CdeOrigine);
                    RecPurchaseHeader.ModifyAll("Bill-to Customer No.", CdeDestination);

                    RecPurchaseLine.Reset;
                    RecPurchaseLine.SetRange("Sell-to Customer No.", CdeOrigine);
                    RecPurchaseLine.ModifyAll("Sell-to Customer No.", CdeDestination);

                    RecPurchaseLine.Reset;
                    RecPurchaseLine.SetRange("Bill-to Customer No.", CdeOrigine);
                    RecPurchaseLine.ModifyAll("Bill-to Customer No.", CdeDestination);


                    RecGLEntry.Reset;
                    RecGLEntry.SetRange("Source Type", RecGLEntry."source type"::Customer);
                    RecGLEntry.SetRange("Source No.", CdeOrigine);
                    RecGLEntry.ModifyAll("Source No.", CdeDestination);

                    RecValueEntry.Reset;
                    RecValueEntry.SetRange("Source Type", RecGLEntry."source type"::Customer);
                    RecValueEntry.SetRange("Source No.", CdeOrigine);
                    RecValueEntry.ModifyAll("Source No.", CdeDestination);

                    RecItemLedgerEntry.Reset;
                    RecItemLedgerEntry.SetRange("Source Type", RecGLEntry."source type"::Customer);
                    RecItemLedgerEntry.SetRange("Source No.", CdeOrigine);
                    RecItemLedgerEntry.ModifyAll("Source No.", CdeDestination);


                    RecVATEntry.Reset;
                    RecVATEntry.SetRange("Bill-to/Pay-to No.", CdeOrigine);
                    RecVATEntry.ModifyAll("Bill-to/Pay-to No.", CdeDestination);

                    RecVendorLedgerEntry.Reset;
                    RecVendorLedgerEntry.SetRange("Customer No.", CdeOrigine);
                    RecVendorLedgerEntry.ModifyAll("Customer No.", CdeDestination);

                    RecDetailedVendorLedgEntry.Reset;
                    RecDetailedVendorLedgEntry.SetRange("Customer No.", CdeOrigine);
                    RecDetailedVendorLedgEntry.ModifyAll("Customer No.", CdeDestination);

                    RecPurchRcptHeader.Reset;
                    RecPurchRcptHeader.SetRange("Sell-to Customer No.", CdeOrigine);
                    RecPurchRcptHeader.ModifyAll("Sell-to Customer No.", CdeDestination);

                    RecPurchRcptHeader.Reset;
                    RecPurchRcptHeader.SetRange("Bill-to Customer No.", CdeOrigine);
                    RecPurchRcptHeader.ModifyAll("Bill-to Customer No.", CdeDestination);

                    RecPurchRcptLine.Reset;
                    RecPurchRcptLine.SetRange("Sell-to Customer No.", CdeOrigine);
                    RecPurchRcptLine.ModifyAll("Sell-to Customer No.", CdeDestination);

                    RecPurchRcptLine.Reset;
                    RecPurchRcptLine.SetRange("Bill-to Customer No.", CdeOrigine);
                    RecPurchRcptLine.ModifyAll("Bill-to Customer No.", CdeDestination);



                    RecPurchInvHeader.Reset;
                    RecPurchInvHeader.SetRange("Sell-to Customer No.", CdeOrigine);
                    RecPurchInvHeader.ModifyAll("Sell-to Customer No.", CdeDestination);

                    RecPurchInvHeader.Reset;
                    RecPurchInvHeader.SetRange("Bill-to Customer No.", CdeOrigine);
                    RecPurchInvHeader.ModifyAll("Bill-to Customer No.", CdeDestination);



                    RecPurchInvLine.Reset;
                    RecPurchInvLine.SetRange("Sell-to Customer No.", CdeOrigine);
                    RecPurchInvLine.ModifyAll("Sell-to Customer No.", CdeDestination);

                    RecPurchInvLine.Reset;
                    RecPurchInvLine.SetRange("Bill-to Customer No.", CdeOrigine);
                    RecPurchInvLine.ModifyAll("Bill-to Customer No.", CdeDestination);

                    RecPurchCrMemoHdr.Reset;
                    RecPurchCrMemoHdr.SetRange("Sell-to Customer No.", CdeOrigine);
                    RecPurchCrMemoHdr.ModifyAll("Sell-to Customer No.", CdeDestination);


                    RecPurchCrMemoHdr.Reset;
                    RecPurchCrMemoHdr.SetRange("Bill-to Customer No.", CdeOrigine);
                    RecPurchCrMemoHdr.ModifyAll("Bill-to Customer No.", CdeDestination);


                    RecPurchCrMemoHdr.Reset;
                    RecPurchCrMemoHdr.SetRange("Invoice Disc. Code", CdeOrigine);
                    RecPurchCrMemoHdr.ModifyAll("Invoice Disc. Code", CdeDestination);


                    RecPurchCrMemoLine.Reset;
                    RecPurchCrMemoLine.SetRange("Sell-to Customer No.", CdeOrigine);
                    RecPurchCrMemoLine.ModifyAll("Sell-to Customer No.", CdeDestination);

                    RecPurchCrMemoLine.Reset;
                    RecPurchCrMemoLine.SetRange("Bill-to Customer No.", CdeOrigine);
                    RecPurchCrMemoLine.ModifyAll("Bill-to Customer No.", CdeDestination);

                    RecPaymentLine.Reset;
                    RecPaymentLine.SetRange("Account Type", RecPaymentLine."account type"::Customer);
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
}

