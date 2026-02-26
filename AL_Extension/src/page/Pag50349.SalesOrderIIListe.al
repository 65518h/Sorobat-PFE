//HS
page 50349 "Sales Order II Liste"
{
    PageType = List;
    Caption = 'Commande vente';
    Editable = false;
    //  ApplicationArea = All;
    // UsageCategory = Lists;
    SourceTable = "Sales Header";
    //CardPageId = "Sales Order II";
    SourceTableView = SORTING("Order Type", "Document Type", "No.", "Invoicing Method", Finished) WHERE("Document Type" = CONST(Order), "Order Type" = FILTER(' '));


    layout
    {
        area(Content)
        {
            repeater("Liste des ventes")
            {
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    caption = 'Journée';
                    ApplicationArea = All;
                }
                field("Order Date"; Rec."Order Date")
                {
                    caption = 'Date saisie';
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    Caption = 'N° BL';
                    ApplicationArea = All;
                }

                // field("Formule Beton"; Rec."Formule Beton")
                // {
                //     ApplicationArea = All;
                // }


                field("Last Shipping No."; Rec."Last Shipping No.")
                {
                    Caption = 'N° expedition';
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    Caption = 'Code Utilisateur';
                    ApplicationArea = All;
                }
                field("Job No."; Rec."Job No.")
                {
                    Caption = 'Centrale';
                    ApplicationArea = All;
                }
                field("Requester ID"; Rec."Requester ID")
                {
                    Caption = 'ID Demandeur';
                    ApplicationArea = All;
                }
                field(Service; Rec.Service)
                {
                    ApplicationArea = All;
                }
                field(Subject; Rec.Subject)
                {
                    Caption = 'Objet';
                    ApplicationArea = All;
                }
                // field(Statut; Rec.Statut)
                // {
                //     ApplicationArea = All;
                // }
                field("Sell-to Contact No."; Rec."Sell-to Contact No.")
                {
                    ApplicationArea = All;
                }
                field("Description Engin"; Rec."Description Engin")
                {
                    Caption = 'Engin';
                    ApplicationArea = All;
                }
                field("Job Description"; Rec."Job Description")
                {
                    Caption = 'Description Affaire';
                    ApplicationArea = All;
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    Caption = 'Ville affaire';
                    ApplicationArea = All;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {

                    ApplicationArea = All;
                }
                field("Amount Excl. VAT (LCY)"; Rec."Amount Excl. VAT (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Deadline Date"; Rec."Deadline Date")
                {
                    Caption = 'Date de validité';
                    ApplicationArea = All;
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = All;
                }


            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }
}