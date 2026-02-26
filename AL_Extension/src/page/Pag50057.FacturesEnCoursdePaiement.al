Page 50057 "Factures En Cours de Paiement"
{
    // //POSTING_DESCR CW 22/04/04 +"Posting description","Order No."
    // //MISC CW 17/06/06 +"OnHold", +"UserID", "Vendor Shipment No."

    Caption = 'Factures En Cours de Paiement';
    Editable = false;
    PageType = List;
    SourceTable = "Purch. Inv. Header";
    SourceTableView = where("Statut Facture" = filter(<> "Payé Et Archivée"));
    ApplicationArea = all;
    UsageCategory = Lists;


    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Order Date"; rec."Order Date")
                {
                    ApplicationArea = all;
                }
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                }
                field("Buy-from Vendor No."; rec."Buy-from Vendor No.")
                {
                    ApplicationArea = all;
                }
                field("Vendor Invoice No."; rec."Vendor Invoice No.")
                {
                    ApplicationArea = all;
                }
                field("Order Address Code"; rec."Order Address Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Buy-from Vendor Name"; rec."Buy-from Vendor Name")
                {
                    ApplicationArea = all;
                }
                field("Due Date"; rec."Due Date")
                {
                    ApplicationArea = all;
                }
                field(Control1000000012; rec."Vendor Invoice No.")
                {
                    ApplicationArea = all;
                }
                field("Date Bureau Ordre"; rec."Date Bureau Ordre")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Statut Facture"; rec."Statut Facture")
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                    StyleExpr = true;
                    Editable = false;
                }
                field("Order No."; rec."Order No.")
                {
                    ApplicationArea = all;
                }
                field("User ID"; rec."User ID")
                {
                    ApplicationArea = all;
                }
                field("Job No."; rec."Job No.")
                {
                    ApplicationArea = all;
                    Caption = 'N° Affaire';
                }
                field(Control8003910; rec."Order No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Vendor Shipment No."; rec."Vendor Shipment No.")
                {
                    ApplicationArea = all;
                    Caption = 'N° B.L. fournisseur';
                }
                field("Currency Code"; rec."Currency Code")
                {
                    ApplicationArea = all;
                }
                field(Amount; rec.Amount)
                {
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    begin
                        rec.SetRange("No.");
                        page.RunModal(page::"Posted Purchase Invoice", Rec)
                    end;
                }
                field("Amount Including VAT"; rec."Amount Including VAT")
                {
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    begin
                        rec.SetRange("No.");
                        page.RunModal(page::"Posted Purchase Invoice", Rec)
                    end;
                }
                field("Buy-from Post Code"; rec."Buy-from Post Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Buy-from Country/Region Code"; rec."Buy-from Country/Region Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Buy-from Contact"; rec."Buy-from Contact")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Pay-to Vendor No."; rec."Pay-to Vendor No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Pay-to Name"; rec."Pay-to Name")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Pay-to Post Code"; rec."Pay-to Post Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Pay-to Country/Region Code"; rec."Pay-to Country/Region Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Pay-to Contact"; rec."Pay-to Contact")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Ship-to Code"; rec."Ship-to Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Ship-to Name"; rec."Ship-to Name")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Ship-to Post Code"; rec."Ship-to Post Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Ship-to Country/Region Code"; rec."Ship-to Country/Region Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Ship-to Contact"; rec."Ship-to Contact")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Control105; rec."Posting Date")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Document Date"; rec."Document Date")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Purchaser Code"; rec."Purchaser Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Payment Terms Code"; rec."Payment Terms Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Control1102601005; rec."Due Date")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Payment Discount %"; rec."Payment Discount %")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Payment Method Code"; rec."Payment Method Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Shipment Method Code"; rec."Shipment Method Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Date Réclamation"; rec."Date Réclamation")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = true;
                }
            }
        }
    }

    actions
    {
        area(Promoted)
        {

            actionref("En Cours Paiment1"; "En Cours Paiment") { }

            actionref("En Cours Signature1"; "En Cours Signature") { }

            actionref("Signeé1"; "Signeé") { }

            actionref("Payée1"; "Payée") { }

            actionref("Payée Et Archivé1"; "Payée Et Archivé") { }



            actionref("Réclamer1"; "Réclamer")
            { }
        }
        area(navigation)
        {
            group("&Invoice")
            {
                Caption = '&Facture';

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
                action("Payée Et Archivé")
                {
                    ApplicationArea = all;
                    Caption = 'Payée Et Archivé';

                    trigger OnAction()
                    begin
                        CduPurchPost.ChangerStatutFacture(rec."No.", 5);
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

                Visible = false;

                trigger OnAction()
                begin
                    if not Confirm('Envoyer Réclamation', false) then exit;

                    RecRéclamation."N° Facture" := rec."No.";
                    RecRéclamation."date Comptabilisation" := rec."Posting Date";
                    RecRéclamation."N° Fournisseur" := rec."Buy-from Vendor No.";
                    RecRéclamation."Nom Fournisseur" := rec."Buy-from Vendor Name";
                    RecRéclamation."N° facture Fournisseur" := rec."Vendor Invoice No.";
                    RecRéclamation."Date échéance" := rec."Due Date";
                    RecRéclamation."Statut Facture" := rec."Statut Facture";
                    RecRéclamation."Montant HT" := rec.Amount;
                    RecRéclamation."Montant TTC" := rec."Amount Including VAT";
                    RecRéclamation."Date Réclamation" := Today;
                    if not RecRéclamation.Insert then;
                end;
            }
        }
    }

    var
        PurchInvHeader: Record "Purch. Inv. Header";
        CduPurchPost: Codeunit "PurchPostEvent";
        "RecRéclamation": Record "Réclamation Facture Achat";
}

