PageExtension 50037 "Purchase List_PagEXT" extends "Purchase List"
{
    // Editable = true;
    //GL2024   SourceTableView=WHERE(Status=FILTER(<>Archived));
    layout
    {

        /* addbefore(Control1)
         {
             group(Filters)
             {
                 Caption = 'Filters'; 

                 field("Buy-from Vendor No.2"; gBuyFromVendorNo)
                 {
                     Editable = true;

                     Caption = 'N° preneur d''ordre';
                     ApplicationArea = all;
                     trigger OnLookup(var Text: Text): Boolean
                     var
                         lVendor: Record Vendor;
                     begin

                         //ACHAT_SUIVI
                         lVendor.FIND('-');
                         IF PAGE.RUNMODAL(PAGE::"Vendor List", lVendor) = ACTION::LookupOK THEN
                             IF gBuyFromVendorNo = '' THEN
                                 gBuyFromVendorNo := STRSUBSTNO('%1', lVendor."No.")
                             ELSE
                                 gBuyFromVendorNo += STRSUBSTNO('|%1', lVendor."No.");
                         Filters;
                         CurrPage.UPDATE(FALSE);
                         //ACHAT_SUIVI//
                     end;

                     trigger OnValidate()
                     begin

                         //ACHAT_SUIVI
                         Filters;
                         //ACHAT_SUIVI//

                         //ACHAT_SUIVI
                         CurrPage.UPDATE(FALSE);
                         //ACHAT_SUIVI//
                     end;
                 }
                 field("Next Date Follow-Up"; gDateNextFollowUpFilter)
                 {
                     Editable = true;

                     Caption = 'A relancer au';
                     ApplicationArea = all;
                     trigger OnValidate()
                     begin

                         //ACHAT_SUIVI
                         Filters;
                         //ACHAT_SUIVI//

                         //ACHAT_SUIVI
                         CurrPage.UPDATE(FALSE);
                         //ACHAT_SUIVI//
                     end;
                 }
                 field("Job No."; wJobFilter)
                 {
                     Editable = true;
                     Caption = 'N° affaire';
                     ApplicationArea = all;
                     trigger OnLookup(var Text: Text): Boolean
                     var
                         lJob: Record Job;
                     begin

                         //ACHAT_SUIVI
                         lJob.FIND('-');
                         IF PAGE.RUNMODAL(PAGE::"Job List", lJob) = ACTION::LookupOK THEN
                             IF wJobFilter = '' THEN
                                 wJobFilter := STRSUBSTNO('%1', lJob."No.")
                             ELSE
                                 wJobFilter += STRSUBSTNO('|%1', lJob."No.");
                         Filters;
                         CurrPage.UPDATE(FALSE);
                         //ACHAT_SUIVI//
                     end;

                     trigger OnValidate()
                     begin

                         //ACHAT_SUIVI
                         Filters;
                         //ACHAT_SUIVI//

                         //ACHAT_SUIVI
                         CurrPage.UPDATE(FALSE);
                         //ACHAT_SUIVI//
                     end;
                 }
             }
         }*/
        modify(Control1)
        {
            Editable = false;
        }
        modify("Posting Date")
        {
            Visible = false;
        }

        addafter("No.")
        {
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = all;
                Editable = FALSE;
            }
            field("Posting Date2"; Rec."Posting Date")
            {
                ApplicationArea = all;

            }

        }
        addbefore("Buy-from Vendor No.")
        {
            field("N° Demande d'achat"; rec."N° Demande d'achat")
            {
                ApplicationArea = all;
                Style = Strong;
                StyleExpr = true;
            }
        }
        modify("Buy-from Vendor No.")
        {
            caption = 'N° preneur d''ordre';
        }
        addafter("Buy-from Vendor No.")
        {
            field("Your Reference"; Rec."Your Reference")
            {
                Visible = false;
                ApplicationArea = all;
            }
            field("DTA Coding Line"; Rec."DTA Coding Line")
            {
                ApplicationArea = all;
            }
        }

        addafter("Order Address Code")
        {
            field("User ID"; Rec."User ID")
            {
                ApplicationArea = all;
            }
        }
        addafter("Buy-from Vendor Name")
        {

            field("N° DA Chantier"; rec."N° DA Chantier")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Vendor Cr. Memo No."; rec."Vendor Cr. Memo No.")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Facture En Instance"; rec."Facture En Instance")
            {
                ApplicationArea = all;
                Visible = false;
            }
            /*GL2024   field("Vendor Quote No.";rec."Vendor Quote No.")
               {
   ApplicationArea = all;
               }*/

            /*   field(Engin; rec.Engin)
               {
                   ApplicationArea = all;
               }
               field("Description Engin"; rec."Description Engin")
               {
                   ApplicationArea = all;
               }*/
            field("Shipment Remark"; rec."Shipment Remark")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Vendor Shipment No."; Rec."Vendor Shipment No.")
            {
                ApplicationArea = all;
                Style = Strong;
                StyleExpr = true;
            }
            field("Statut Commande"; rec."Statut Commande")
            {
                ApplicationArea = all;
                Style = Unfavorable;
                Editable = false;
            }
            field(Amount1; Rec.Amount)
            {
                Style = StrongAccent;
                StyleExpr = true;
            }

            field("Motif Annulation"; Rec."Motif Annulation")
            {
                ApplicationArea = all;
                Visible = false;
                Editable = false;
            }
            field("Etat Commande"; Rec."Etat Commande")
            {
                ApplicationArea = all;
                Visible = false;
                Style = Attention;
            }
            field(Status; rec.Status)
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Pay-to Address 2"; rec."Pay-to Address 2")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Pay-to Name 2"; rec."Pay-to Name 2")
            {
                ApplicationArea = all;
                Visible = false;
            }
            /* GL2024 field("Vendor Shipment No."; rec."Vendor Shipment No.")
              {   ApplicationArea = all;
                  Visible = true;
              }*/
            field(wDescr; wDescr)
            {
                ApplicationArea = all;
                Caption = 'Libellé écriture';
            }
            field("Requested Receipt Date"; rec."Requested Receipt Date")
            {
                ApplicationArea = all;
            }
            field("Promised Receipt Date"; rec."Promised Receipt Date")
            {
                ApplicationArea = All;
            }
            /* GL2024 field("Promised Receipt Date"; Rec."Promised Receipt Date")
              {   ApplicationArea = all;
              }*/
            field("Vendor Order No."; rec."Vendor Order No.")
            {
                ApplicationArea = all;
            }
        }
        modify("Vendor Authorization No.")
        {
            Visible = false;
        }
        addafter("Posting Date")
        {
            field("Vendor Authorization No.1"; Rec."Vendor Authorization No.")
            {
                ApplicationArea = all;
            }
            field("Date Next Follow-Up"; Rec."Date Next Follow-Up")
            {
                ApplicationArea = all;
                Editable = false;
                Caption = 'Date de prochaine relance';
            }
            field("Job No.2"; Rec."Job No.")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }

        addafter("Assigned User ID")
        {
            field(Amount; rec.Amount)
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Price Offer Amount"; rec."Price Offer Amount")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Amount Including VAT"; rec."Amount Including VAT")
            {
                ApplicationArea = all;
                Visible = false;
            }
        }
        addafter("Location Code")
        {
            field("Purchaser Code1"; Rec."Purchaser Code")
            {
                ApplicationArea = all;
                Visible = false;
            }
        }

        addafter(Control1)
        {
            part("Sous-form. demande de prix"; "Sous-form. demande de prix")
            {//page 50015
                Caption = 'Sub-form price request';

                ApplicationArea = all;
                SubPageLink = "Document No." = FIELD("No."),
                                  "Document Type" = FIELD("Document Type");
            }
        }


    }

    actions
    {
        addafter(ShowDocument)
        {
            /*   GL2024   action("Update Next Reminder Date")

                  {
                      ApplicationArea = all;
                      Caption = 'Update Next Reminder Date';
                      //DYS page addon non migrer
                      // RunObject = Page 8001459;
                      // RunPageLink = "No." = FIELD("No."),
                      //                   "Document Type" = FIELD("Document Type");
                  }*/
        }

        addafter("&Line")
        {
            group("Create &Interact")
            {
                Caption = 'Create &Interact';

                action("Buy-from Vendor")
                {
                    Caption = 'Fournisseur';
                    ApplicationArea = all;

                    trigger OnAction()
                    begin
                        //ACHAT_SUIVI
                        rec.fCreateInteraction(rec."Buy-from Vendor No.", rec."No.");
                        //ACHAT_SUIVI//
                    end;
                }
                action("Pay-to Vendor")
                {
                    Caption = 'Fournisseur à payer';
                    ApplicationArea = all;
                    trigger OnAction()
                    begin

                        //ACHAT_SUIVI
                        rec.fCreateInteraction(rec."Pay-to Vendor No.", rec."No.");
                        //ACHAT_SUIVI//
                    end;
                }

            }
        }
        addafter(Category_Process)
        {
            group("Create &Interact1")
            {
                Caption = 'Create Interact';
                actionref("Buy-from Vendor1"; "Buy-from Vendor")
                {

                }
                actionref("Pay-to Vendor1"; "Pay-to Vendor")
                {

                }
            }
        }
    }
    trigger OnOpenPage()
    VAR
        lMaskMgt: Codeunit "Mask Management";
    begin
        //GL2024   SourceTableView=WHERE(Status=FILTER(<>Archived));
        Rec.FilterGroup(0);
        Rec.Setfilter(Status, '<>%1', Rec.Status::Archived);
        //GL2024 Filter d Card
        Rec.SetFilter("Document Type", '%1', Rec."Document Type"::Order);
        Rec.SetRange(Contrat, false);
        Rec.FilterGroup(2);
        //GL2024 Filter  Card




        //MASK

        //MASK
        lMaskMgt.PurchaseHeader(Rec);
        //MASK//
        // >> HJ SORO 13-01-2015
        /*  IF UserSetup.GET(UPPERCASE(USERID)) THEN
              IF UserSetup."Filtre Magasin" <> '' THEN
                  IF InventorySetup.GET THEN
                      IF InventorySetup."Appliquer Filtre Magasin" THEN rec.SETRANGE("Location Code", UserSetup."Filtre Magasin");*/
        // >> HJ SORO 13-01-2015
    end;

    trigger OnAfterGetRecord()
    begin

        //POSTING_DESC
        wDescr := rec.wShowPostingDescription(rec."Posting Description");
        //POSTING_DESC//
        // >> HJ DSFT 17-07-2013
        BlnNonLivré := FALSE;
        BlnTotalementLivré := FALSE;
        BlnPartiellementLivé := FALSE;
        RecPurchaseLine.RESET;
        RecPurchaseLine.SETRANGE("Document Type", rec."Document Type");
        RecPurchaseLine.SETRANGE("Document No.", rec."No.");
        RecPurchaseLine.SETRANGE(Type, RecPurchaseLine.Type::Item);
        RecPurchaseLine.SETFILTER("Quantity Received", '<>%1', 0);
        IF NOT RecPurchaseLine.FINDFIRST THEN BEGIN
            BlnNonLivré := TRUE;
            rec."Statut Commande" := 1;
        END;


        RecPurchaseLine.RESET;
        RecPurchaseLine.SETRANGE("Document Type", rec."Document Type");
        RecPurchaseLine.SETRANGE("Document No.", rec."No.");
        RecPurchaseLine.SETRANGE(Type, RecPurchaseLine.Type::Item);
        RecPurchaseLine.SETFILTER("Quantity Received", '<>%1', 0);
        IF RecPurchaseLine.FINDFIRST THEN BEGIN
            BlnPartiellementLivé := TRUE;
            rec."Statut Commande" := 2;
        END;


        RecPurchaseLine.RESET;
        RecPurchaseLine.SETRANGE("Document Type", rec."Document Type");
        RecPurchaseLine.SETRANGE("Document No.", rec."No.");
        RecPurchaseLine.SETFILTER("Outstanding Quantity", '<>%1', 0);
        IF NOT RecPurchaseLine.FINDFIRST THEN BEGIN
            BlnTotalementLivré := TRUE;
            rec."Statut Commande" := 3;
        END;

        // >> HJ DSFT 17-07-2013

    end;



    PROCEDURE Filters();
    BEGIN
        //ACHAT_SUIVI
        IF gBuyFromVendorNo = '' THEN
            rec.SETRANGE("Buy-from Vendor No.")
        ELSE
            rec.SETRANGE("Buy-from Vendor No.", gBuyFromVendorNo);

        IF gDateNextFollowUpFilter <> 0D THEN BEGIN
            rec.SETFILTER("Date Next Follow-Up", '<>%1&<=%2', 0D, gDateNextFollowUpFilter);
            rec.SETRANGE("Completely Received", FALSE);
        END ELSE
            rec.SETRANGE("Date Next Follow-Up");
        //ACHAT_SUIVI//
    END;

    var
        wDescr: Text[100];
        wJobFilter: Text[50];
        gBuyFromVendorNo: Text[50];
        gDateNextFollowUpFilter: Date;
        RecPurchaseLine: Record "Purchase Line";
        BlnNonLivré: Boolean;
        BlnTotalementLivré: Boolean;
        BlnPartiellementLivé: Boolean;
        InventorySetup: Record "Inventory Setup";
        UserSetup: Record "User Setup";
}

