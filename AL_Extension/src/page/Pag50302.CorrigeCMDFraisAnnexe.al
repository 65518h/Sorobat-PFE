Page 50302 "Corrige  CMD Frais Annexe"
{
    PageType = Card;
    ApplicationArea = all;
    Caption = 'Corrige  CMD Frais Annexe';
    layout
    {
        area(content)
        {
            field(CdeCommande; CdeCommande)
            {
                ApplicationArea = all;
                Caption = 'Commande';
                TableRelation = "Purchase Header"."No." where("Document Type" = const(Order));

                trigger OnValidate()
                begin
                    CdeCommandeOnAfterValidate;
                end;
            }
            field(CdeOrigine; CdeOrigine)
            {
                ApplicationArea = all;
                Caption = 'Frais Annexe';
                TableRelation = "Item Charge";
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
                    if CdeCommande = '' then Error(Text005);
                    if CdeOrigine = '' then Error(Text002);
                    if CdeDestination = '' then Error(Text003);
                    if not Confirm(Text001) then exit;



                    RecPurchaseLine.Reset;
                    RecPurchaseLine.SetRange("Document No.", CdeCommande);
                    RecPurchaseLine.SetRange("No.", CdeOrigine);
                    if RecPurchaseLine.FindFirst then
                        repeat
                            RecPurchaseLine."No." := CdeDestination;

                        until RecPurchaseLine.Next = 0;


                    RecPurchaseLine.Reset;
                    RecPurchaseLine.SetRange("Document No.", CdeCommande);
                    RecPurchaseLine.SetRange("Pay-to Vendor No.", CdeOrigine);
                    RecPurchaseLine.ModifyAll("Pay-to Vendor No.", CdeDestination);



                    Message(Text004);
                end;
            }
        }
    }

    var
        RecGLEntry: Record "G/L Entry";
        RecPurchRcptLine: Record "Purch. Rcpt. Line";
        RecVATEntry: Record "VAT Entry";
        RecValueEntry: Record "Value Entry";
        RecItemLedgerEntry: Record "Item Ledger Entry";
        RecPurchaseHeader: Record "Purchase Header";
        RecPurchaseHeader2: Record "Purchase Header";
        RecPurchaseLine: Record "Purchase Line";
        CdeOrigine: Code[20];
        CdeDestination: Code[20];
        Text001: label 'Lancer Le Chagnement De Fournisseur ?';
        Text002: label 'Remplir Fournisseur Origine';
        Text003: label 'Remplir Fournisseur Destination';
        Text004: label 'Traitement Achevé Avec Succé';
        CdeCommande: Code[20];
        Text005: label 'Remplir Num Commande';

    local procedure CdeCommandeOnAfterValidate()
    begin
        if RecPurchaseHeader2.Get(RecPurchaseHeader2."document type"::Order, CdeCommande) then
            CdeOrigine := RecPurchaseHeader2."Buy-from Vendor No.";
    end;
}

