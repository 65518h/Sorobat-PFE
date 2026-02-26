PageExtension 50065 "Posted Purchase Receipt_PagEXT" extends "Posted Purchase Receipt"
{
    Editable = false;
    layout
    {
        addafter("Responsibility Center")
        {
            field("Job No."; Rec."Job No.")
            {
                Caption = 'N° Affaire';
                ApplicationArea = all;
                Editable = FALSE;
            }
            field("N° DA Chantier"; Rec."N° DA Chantier")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field(Demandeur; Rec.Demandeur)
            {
                ApplicationArea = all;
            }
            field(Engin; Rec.Engin)
            {
                ApplicationArea = all;
            }
            field("Description Engin"; Rec."Description Engin")
            {
                ApplicationArea = all;
            }
            field("User ID"; Rec."User ID")
            {
                ApplicationArea = all;
            }
            //hs
            field("N° Demande d'achat"; Rec."N° Demande d'achat")
            {
                ApplicationArea = All;
                Editable = false;

            }
            field("Date DA"; Rec."Date DA")
            {
                ApplicationArea = All;
                Editable = false;
            }
            //hs

        }


    }

    actions
    {
        addafter("&Receipt")
        {
            group("Fonctions")
            {
                Caption = 'Fonctions';
                action("PV Reception")
                {
                    Caption = 'PV Reception';
                    ApplicationArea = all;
                    ShortCutKey = F11;
                    trigger OnAction()
                    begin
                        // >> HJ DSFT 25-04-2012
                        CurrPAGE.PurchReceiptLines.PAGE.ListePvReception;
                        // >> HJ DSFT 25-04-2012
                    end;
                }
                action("Imprimer Pv Reception")
                {
                    Caption = 'Imprimer Pv Reception';
                    ApplicationArea = all;
                    ShortCutKey = F10;
                    trigger OnAction()
                    begin
                        // >> HJ DSFT 25-04-2012
                        CurrPAGE.PurchReceiptLines.PAGE.ImprimerPvReception;
                        // >> HJ DSFT 25-04-2012
                    end;
                }
            }
        }
        modify("&Print")
        {
            Visible = false;
        }
        addafter("&Print")
        {
            action(Imprimer)
            {
                Caption = 'Imprimer';
                ApplicationArea = all;
                Image = Print;


                trigger OnAction()
                var
                    PostedPurchaseReceipt: Record "Purch. Rcpt. Header";
                    ReportReceip: Report "Purchase - ReceiptSpec";
                begin
                    PostedPurchaseReceipt.Reset();
                    PostedPurchaseReceipt.SetRange("No.", Rec."No.");
                    if PostedPurchaseReceipt.FindFirst() then begin
                        ReportReceip.SetTableView(PostedPurchaseReceipt);
                        ReportReceip.Run();
                    end;
                end;
            }
        }
        addafter("&Print_Promoted")
        {
            actionref("ImprimerRef"; "Imprimer")
            {

            }
        }
        addafter(Category_Category4)
        {
            group("F&unctions1")
            {
                Caption = 'F&unctions';
                actionref("PV Reception1"; "PV Reception")
                {

                }
                actionref("Imprimer Pv Reception1"; "Imprimer Pv Reception")
                {

                }

            }
        }
    }

    var

        UserSetup: Record "User Setup";
        Text00: Label 'You do not have the right to delete purchase receipts; please consult your administrator';

}

