page 52049006 "Bons Reglement Validé"
{
    //GL2024  ID dans Nav 2009 : "39001534"
    Editable = false;
    PageType = Card;
    SourceTable = "Bon Reglement";
    SourceTableView = where(Statut = const(Validé));
    ApplicationArea = all;
    UsageCategory = Administration;
    Caption = 'Bons Reglement Validé';

    layout
    {
        area(content)
        {
            group("Général")
            {
                Caption = 'Général';
                field("N° Bon"; Rec."N° Bon")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Annee; Rec.Annee)
                {
                    ApplicationArea = Basic;
                }
                field(Mois; Rec.Mois)
                {
                    ApplicationArea = Basic;
                }
                field(Matricule; Rec.Matricule)
                {
                    ApplicationArea = Basic;
                }
                field("Nom Et Prenom"; Rec."Nom Et Prenom")
                {
                    ApplicationArea = Basic;
                }
                field(Affectation; Rec.Affectation)
                {
                    ApplicationArea = Basic;
                }
                field("Description Affectation"; Rec."Description Affectation")
                {
                    ApplicationArea = Basic;
                }
                field(Qualification; Rec.Qualification)
                {
                    ApplicationArea = Basic;
                }
                field("Description Qualification"; Rec."Description Qualification")
                {
                    ApplicationArea = Basic;
                }
                field("Type Salaire"; Rec."Type Salaire")
                {
                    ApplicationArea = Basic;
                }
                field("Date Reglement"; Rec."Date Reglement")
                {
                    ApplicationArea = Basic;
                }
                field(Montant; Rec.Montant)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Nombre; Rec.Nombre)
                {
                    ApplicationArea = Basic;
                }
                field("Jours Deplacement"; Rec."Jours Deplacement")
                {
                    ApplicationArea = Basic;
                }
                field("Montant Deplacement"; Rec."Montant Deplacement")
                {
                    ApplicationArea = Basic;
                }
                field(Divers; Rec.Divers)
                {
                    ApplicationArea = Basic;
                }
                field("Net à Payer"; Rec."Net à Payer")
                {
                    ApplicationArea = Basic;
                }
                field(Observation; Rec.Observation)
                {
                    ApplicationArea = Basic;
                }
                field(Statut; Rec.Statut)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Fonction)
            {
                Caption = 'Fonction';
                Visible = true;
                action(Imprimer)
                {
                    ApplicationArea = Basic;
                    Caption = 'Imprimer';

                    trigger OnAction()
                    begin
                        BonReglement.SetRange("N° Bon", Rec."N° Bon");
                        Report.RunModal(39001429, true, true, BonReglement);
                    end;
                }
                action(Valider)
                {
                    ApplicationArea = Basic;
                    Caption = 'Valider';
                    Visible = false;

                    trigger OnAction()
                    begin
                        if not Confirm(Text002) then exit;
                        Rec.Statut := Rec.Statut::Validé;
                        Rec.Modify;
                    end;
                }
            }
        }
    }

    var
        BonReglement: record "Bon Reglement";
        Text002: label 'Confirmer Cette Action ?';
}

