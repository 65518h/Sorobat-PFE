Page 50270 "Réclamation Facture Achat"
{
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Réclamation Facture Achat";
    ApplicationArea = all;
    Caption = 'Réclamation Facture Achat';
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("N° Facture"; REC."N° Facture")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("date Comptabilisation"; REC."date Comptabilisation")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("N° Fournisseur"; REC."N° Fournisseur")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Nom Fournisseur"; REC."Nom Fournisseur")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("N° facture Fournisseur"; REC."N° facture Fournisseur")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                field("Date échéance"; REC."Date échéance")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Statut Facture"; REC."Statut Facture")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Montant HT"; REC."Montant HT")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Montant TTC"; REC."Montant TTC")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Date Réclamation"; REC."Date Réclamation")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Prise en charge"; REC."Prise en charge")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Date Prise en Charge"; REC."Date Prise en Charge")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field(Utilisateur; REC.Utilisateur)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Prendre en charge")
            {
                ApplicationArea = all;
                Caption = 'Prendre en charge';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if not Confirm('Prendre en charge', false) then exit;
                    if not REC."Prise en charge" then begin
                        REC."Prise en charge" := true;
                        REC."Date Prise en Charge" := Today;
                        REC.Utilisateur := UserId;
                        REC.Modify;
                    end;
                end;
            }
        }
    }
}

