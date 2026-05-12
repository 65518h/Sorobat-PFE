PageExtension 50067 "Posted Purchase Invoice_PagEXT" extends "Posted Purchase Invoice"
{
    layout
    {
        modify("VAT Reporting Date")
        {
            Visible = false;
        }
        addafter("Responsibility Center")
        {
            field("Job No."; rec."Job No.")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Statut Facture"; rec."Statut Facture")
            {
                ApplicationArea = all;
                Caption = 'Statut Facture';
                Editable = false;
            }
            field(Simulation; rec.Simulation)
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("En instance Controle Facture"; rec."En instance Controle Facture")
            {
                ApplicationArea = all;
                Visible = false;
            }
        }

        addafter("Payment Method Code")
        {
            field("Subscription Starting Date"; rec."Subscription Starting Date")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Subscription End Date"; rec."Subscription End Date")
            {
                ApplicationArea = all;
                Visible = false;
                Editable = false;
            }
            field("Next Invoice Calcultation"; rec."Next Invoice Calcultation")
            {
                ApplicationArea = all;
                Visible = false;
                Editable = false;
            }
            field("Next Invoice Date"; rec."Next Invoice Date")
            {
                ApplicationArea = all;
                Editable = false;
                Visible = false;
            }
            field("Date Vérification"; rec."Date Vérification")
            {
                ApplicationArea = all;
                Visible = false;
            }
        }
        addafter("Expected Receipt Date")
        {
            field("Vendor Shipment No."; Rec."Vendor Shipment No.")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("User ID"; Rec."User ID")
            {
                ApplicationArea = all;
            }
        }


    }
    actions
    {
        addafter("&Invoice")
        {
            group("Fonction&s")
            {
                Caption = 'Fonctions';

                action("Mettre en Attente Chez Contrôle Facture")
                {
                    Caption = 'Mettre en Attente Chez Contrôle Facture';
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        text001: label 'You must have authorization!!';
                        text002: label 'Invoice pending';
                    begin

                        IF RecUserSetup.GET(USERID) THEN;
                        /*  IF RecUserSetup."Modifier Etat facture AchEnreg" = FALSE THEN BEGIN
                              MESSAGE(text001);
                              EXIT;
                          END;*/
                        IF NOT CONFIRM(Text001, FALSE) THEN EXIT;
                        Cdupurchspostevent.MiseAJourEtatFacture(rec."No.", TRUE);
                        MESSAGE(text002);
                    end;
                }
                action("Retour En Circulation")
                {
                    Caption = 'Retour En Circulation';
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        text001: label 'You must have authorization!!';
                        text002: label 'Return to circulation';
                    begin

                        IF RecUserSetup.GET(USERID) THEN;
                        /*   IF RecUserSetup."Modifier Etat facture AchEnreg" = FALSE THEN BEGIN
                               MESSAGE(text001);
                               EXIT;
                           END;*/

                        IF NOT CONFIRM(Text002, FALSE) THEN EXIT;
                        Cdupurchspostevent.MiseAJourEtatFacture(rec."No.", FALSE);
                        MESSAGE(text002);
                    end;
                }
                /*GL2024  action("Reverse Subscription Invoice")
                  {
                      Caption = 'Reverse Subscription Invoice';
                      ApplicationArea = all;
                      trigger OnAction()
                      var
                      //DYS REPORT addon non migrer
                      //   lReverseInvoice: Report 8001920;
                      begin

                          // lReverseInvoice.SetPurchHeader(Rec);
                          // lReverseInvoice.RUN;
                      end;
                  }*/
            }

        }
        addlast(Category_Category5)
        {
            group("Fonction&s1")
            {
                Caption = 'Fonctions';
                actionref("Mettre en Attente Chez Contrôle Facture1"; "Mettre en Attente Chez Contrôle Facture")
                {

                }
                actionref("Retour En Circulation1"; "Retour En Circulation")
                {

                }
            }
        }

        //GL2024 addafter(IncomingDocument)
        // {
        //     action("&Workflow")
        //     {
        //         Caption = 'Wor&Kflow';
        //         ApplicationArea = All;
        //         //DYS page addon non migrer
        //         // RunObject = Page 8004213;
        //         // RunPageLink = Type = CONST(138),
        //         //           "No." = FIELD("No.");
        //     }
        //     action("Contrôle1000000002")
        //     {
        //         Visible = false;
        //         ApplicationArea = All;

        //         trigger OnAction()
        //         begin
        //             //CU90.CalcFodec2(Rec);
        //         end;
        //     }
        // }
    }


    trigger OnOpenPage()
    VAR
        lMaskMgt: Codeunit "Mask Management";
    BEGIN

        //MASK
        lMaskMgt.PurchInvHeader(Rec);
        //MASK//

    end;


    var
        CU90: Codeunit "Purch.-Post";
        CduPurchasePost: Codeunit "Purch.-Post";
        Cdupurchspostevent: Codeunit PurchPostEvent;
        RecUserSetup: Record "User Setup";
        Text001: Label 'Do you want to put the invoice on hold with invoice control ?';
        Text002: Label 'Do you want to return the invoice to circulation ?';
}



