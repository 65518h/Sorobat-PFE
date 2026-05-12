PageExtension 50245 "Purchase Return Order_PagEXT" extends "Purchase Return Order"
{

    layout
    {
        modify("Applies-to Doc. No.")
        {
            Visible = false;

        }
        addafter("No. of Archived Versions")
        {
            field("Job No."; Rec."Job No.")
            {
                ApplicationArea = all;
            }
            field("Applies-to Doc. No.2"; Rec."Applies-to Doc. No.")
            {
                // Editable = FALSE;
                ApplicationArea = all;
                //  Enabled = true;

                trigger OnValidate()
                begin
                    // Si l’utilisateur tape une valeur au clavier → erreur
                    if not GuiAllowed then
                        exit;

                    Error('Modification manuelle interdite. Utilisez les "..." pour sélectionner un document.');
                end;


            }
        }

        addafter("VAT Bus. Posting Group")
        {
            field("Apply Stamp fiscal"; Rec."Apply Stamp fiscal")
            {
                ApplicationArea = all;
            }
            field("Appliquer Fodec"; Rec."Appliquer Fodec")
            {
                Visible = false;
                ApplicationArea = all;
            }
        }

        addafter("Expected Receipt Date")
        {
            field("Receiving No."; Rec."Receiving No.")
            {
                ApplicationArea = all;
            }
            field("Return Shipment No."; Rec."Return Shipment No.")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        addafter(Post)
        {
            //DYS fonction non visible dans NAV
            /*
            action(Post2)
            {
                ApplicationArea = all;
                Caption = 'P&ost';
                Ellipsis = true;



                trigger OnAction()
                begin

                    //FACTURATION_ACHAT
                    PurchSetup.GET;
                    IF PurchSetup."Calc. Inv. Discount" THEN BEGIN
                        CurrPage.PurchLines.page.CalcInvDisc;
                        COMMIT;
                    END;
                    gPurchPost.InitRequest(FALSE, FALSE);
                    gPurchPost.RUN(Rec);
                    //FACTURATION_ACHAT//
                end;
            }
            */
        }
        modify(PostAndPrint)
        {
            Visible = false;
        }
        addafter(PostAndPrint)
        {
            action(PostAndPrint2)
            {
                ApplicationArea = all;
                Caption = 'Valider et i&mprimer';


                trigger OnAction()
                begin

                    //FACTURATION_ACHAT
                    PurchSetup.GET;
                    IF PurchSetup."Calc. Inv. Discount" THEN BEGIN
                        //CurrPage.PurchLines.page.CalcInvDisc;
                        CurrPage.PurchLines.page.ApproveCalcInvDisc;
                        COMMIT;
                    END;
                    gPurchPost.InitRequest(TRUE, FALSE);
                    gPurchPost.RUN(Rec);
                    //FACTURATION_ACHAT//
                end;
            }
        }

        addafter(PostAndPrint_Promoted)
        {
            actionref(PostAndPrint21; PostAndPrint2)
            {

            }
        }
    }
    var
        gPurchPost: Codeunit "Purch. Order - Post";
        RecVendorFODEC: Record Vendor;
        RecVendorPostingGroup: Record "Vendor Posting Group";
        CduPurchasePost: Codeunit "Purch.-Post";
        PurchSetup: Record "Purchases & Payables Setup";
}