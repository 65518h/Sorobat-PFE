PageExtension 50180 "Active Opportunity List_PagEXT" extends "Active Opportunity List"

{
    layout
    {

    }

    actions
    {
        addafter(Category_Process)
        {
            group("F&unctions1")
            {
                Caption = 'F&unctions';
                actionref("Mettre à jour1"; "Mettre à jour") { }
                actionref(Terminer1; Terminer) { }
                actionref("Afficher le devis1"; "Afficher le devis") { }
                actionref("Imprimer détails1"; "Imprimer détails") { }
            }
        }
        addafter("Oppo&rtunity")
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Mettre à jour")
                {
                    Caption = 'Update';
                    ApplicationArea = all;

                    trigger OnAction()
                    begin
                        rec.UpdateOpportunity;
                    end;
                }
                action(Terminer)
                {
                    Caption = 'Close';
                    ApplicationArea = all;
                    trigger OnAction()
                    begin

                        rec.CloseOpportunity;
                    end;
                }
                /*GL2024 action("&Créer devis")
                 {
                     Caption = 'Assign Sales &Quote';
                     ApplicationArea = all;
                     trigger OnAction()
                     begin
                         //DYS fonction supprimer dans BC
                         // rec.AssignQuote;
                     end;
                 }*/
                action("Afficher le devis")
                {
                    Caption = 'Show Sales Quote';
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        SalesHeader: Record "Sales Header";
                    begin

                        rec.TESTFIELD("Sales Document No.");
                        SalesHeader.GET(SalesHeader."Document Type"::Quote, rec."Sales Document No.");
                        PAGE.RUN(PAGE::"Sales Quote", SalesHeader);
                    end;
                }
                separator(separator1)
                {
                }
                action("Imprimer détails")
                {
                    Caption = 'Print Details';
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        Opp: Record Opportunity;
                    begin

                        Opp := Rec;
                        Opp.SETRECFILTER;
                        REPORT.RUN(REPORT::"Opportunity - Details", TRUE, FALSE, Opp);
                    end;
                }
            }
        }
    }



}