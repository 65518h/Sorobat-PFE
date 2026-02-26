Page 50267 "Factures Fournisseur Enregistr"
{
    // //POSTING_DESCR CW 22/04/04 +"Posting description","Order No."
    // //MISC CW 17/06/06 +"OnHold", +"UserID", "Vendor Shipment No."

    Caption = 'Factures Fournisseur Enregistr';
    Editable = false;
    PageType = List;
    SourceTable = "Purch. Inv. Header";
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Posting Date"; REC."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Order Date"; REC."Order Date")
                {
                    ApplicationArea = all;
                }
                field("No."; REC."No.")
                {
                    ApplicationArea = all;
                }
                field("Buy-from Vendor No."; REC."Buy-from Vendor No.")
                {
                    ApplicationArea = all;
                }
                field("Vendor Invoice No."; REC."Vendor Invoice No.")
                {
                    ApplicationArea = all;
                }
                field("Order Address Code"; REC."Order Address Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Buy-from Vendor Name"; REC."Buy-from Vendor Name")
                {
                    ApplicationArea = all;
                }
                field("Due Date"; REC."Due Date")
                {
                    ApplicationArea = all;
                }
                field(Control1000000012; REC."Vendor Invoice No.")
                {
                    ApplicationArea = all;
                }
                field("Date Réclamation"; REC."Date Réclamation")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Date Bureau Ordre"; REC."Date Bureau Ordre")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Statut Facture"; REC."Statut Facture")
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                    StyleExpr = true;
                    editable = false;
                }
                field("N° Réglement"; REC."N° Réglement")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Date echeance reglement"; REC."Date echeance reglement")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Date echeance reglement2"; REC."Date echeance reglement2")
                {
                    ApplicationArea = all;
                }
                field("N° piece paiement"; REC."N° piece paiement")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("N° piece paiement2"; REC."N° piece paiement2")
                {
                    ApplicationArea = all;
                }
                field("Mode paiement"; REC."Mode paiement")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = true;
                }
                // field("Mode paiement2"; REC."Mode paiement2")
                // {
                //     ApplicationArea = all;
                // }
                field("Order No."; REC."Order No.")
                {
                    ApplicationArea = all;
                }
                field("User ID"; REC."User ID")
                {
                    ApplicationArea = all;
                }
                field("Job No."; REC."Job No.")
                {
                    ApplicationArea = all;
                }
                field(Control8003910; REC."Order No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Vendor Shipment No."; REC."Vendor Shipment No.")
                {
                    ApplicationArea = all;
                }
                field("Currency Code"; REC."Currency Code")
                {
                    ApplicationArea = all;
                }
                field(Amount; REC.Amount)
                {
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    begin
                        REC.SetRange("No.");
                        PAGE.RunModal(PAGE::"Posted Purchase Invoice", Rec)
                    end;
                }
                field("Amount Including VAT"; REC."Amount Including VAT")
                {
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    begin
                        REC.SetRange("No.");
                        PAGE.RunModal(PAGE::"Posted Purchase Invoice", Rec)
                    end;
                }
                field("Buy-from Post Code"; REC."Buy-from Post Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Buy-from Country/Region Code"; REC."Buy-from Country/Region Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Buy-from Contact"; REC."Buy-from Contact")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Pay-to Vendor No."; REC."Pay-to Vendor No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Pay-to Name"; REC."Pay-to Name")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Pay-to Post Code"; REC."Pay-to Post Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Pay-to Country/Region Code"; REC."Pay-to Country/Region Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Pay-to Contact"; REC."Pay-to Contact")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Ship-to Code"; REC."Ship-to Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Ship-to Name"; REC."Ship-to Name")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Ship-to Post Code"; REC."Ship-to Post Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Ship-to Country/Region Code"; REC."Ship-to Country/Region Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Ship-to Contact"; REC."Ship-to Contact")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Control105; REC."Posting Date")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Document Date"; REC."Document Date")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Purchaser Code"; REC."Purchaser Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Payment Terms Code"; REC."Payment Terms Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; REC."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Control1102601005; REC."Due Date")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; REC."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Payment Discount %"; REC."Payment Discount %")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Payment Method Code"; REC."Payment Method Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Shipment Method Code"; REC."Shipment Method Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(Promoted)
        {
            group("&Invoice1")
            {
                Caption = '&Invoice';
                actionref("En Cours Paiment1"; "En Cours Paiment") { }
                actionref("En Cours Signature1"; "En Cours Signature") { }
                actionref("Signeé1"; "Signeé") { }
                actionref("Payée1"; "Payée") { }
            }

            actionref("Réclamer1"; "Réclamer") { }
        }
        area(navigation)
        {
            group("&Invoice")
            {
                Caption = '&Invoice';
                Visible = false;
                action("En Cours Paiment")
                {
                    ApplicationArea = all;
                    Caption = 'En Cours Paiment';

                    trigger OnAction()
                    begin
                        CduPurchPost.ChangerStatutFacture(rec."No.", 1);
                    end;
                }
                action("En Cours Signature")
                {
                    ApplicationArea = all;
                    Caption = 'En Cours Signature';

                    trigger OnAction()
                    begin
                        CduPurchPost.ChangerStatutFacture(rec."No.", 2);
                    end;
                }
                action("Signeé")
                {
                    ApplicationArea = all;
                    Caption = 'Signeé';

                    trigger OnAction()
                    begin
                        CduPurchPost.ChangerStatutFacture(rec."No.", 3);
                    end;
                }
                action("Payée")
                {
                    ApplicationArea = all;
                    Caption = 'Payée';

                    trigger OnAction()
                    begin
                        CduPurchPost.ChangerStatutFacture(rec."No.", 4);
                    end;
                }
            }
        }
        area(processing)
        {
            action("Réclamer")
            {
                ApplicationArea = all;
                Caption = 'Réclamer';


                trigger OnAction()
                begin
                    if not Confirm('Envoyer Réclamation', false) then exit;

                    RecRéclamation."N° Facture" := REC."No.";
                    RecRéclamation."date Comptabilisation" := REC."Posting Date";
                    RecRéclamation."N° Fournisseur" := REC."Buy-from Vendor No.";
                    RecRéclamation."Nom Fournisseur" := REC."Buy-from Vendor Name";
                    RecRéclamation."N° facture Fournisseur" := REC."Vendor Invoice No.";
                    RecRéclamation."Date échéance" := REC."Due Date";
                    RecRéclamation."Statut Facture" := REC."Statut Facture";
                    RecRéclamation."Montant HT" := REC.Amount;
                    RecRéclamation."Montant TTC" := REC."Amount Including VAT";
                    RecRéclamation."Date Réclamation" := Today;
                    if not RecRéclamation.Insert then;
                end;
            }
        }
    }

    var
        PurchInvHeader: Record "Purch. Inv. Header";
        CduPurchPost: Codeunit PurchPostEvent;
        "RecRéclamation": Record "Réclamation Facture Achat";
}

