page 52048885 "Bon Reglement"
{//GL2024  ID dans Nav 2009 : "39001406"
    PageType = Card;
    SourceTable = "Bon Reglement";
    SourceTableView = where(Statut = const(Ouvert));
    Caption = 'Bon Reglement';
    ApplicationArea = all;
    UsageCategory = Administration;
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
                field(Nombre; Rec.Nombre)
                {
                    ApplicationArea = Basic;
                }
                field(Montant; Rec.Montant)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Heure Sup"; Rec."Heure Sup")
                {
                    ApplicationArea = Basic;
                }
                field("Base Horaire"; Rec."Base Horaire")
                {
                    ApplicationArea = Basic;
                }
                field("Montant HSP"; Rec."Montant HSP")
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
                field(Retenue; Rec.Retenue)
                {
                    ApplicationArea = Basic;
                    DecimalPlaces = 3 : 3;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Net à Payer"; Rec."Net à Payer")
                {
                    ApplicationArea = Basic;
                    DecimalPlaces = 3 : 3;
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
        area(Promoted)
        {
            group(Fonction1)
            {
                Caption = 'Fonction';
                actionref(Imprimer1; Imprimer) { }
                actionref(Valider1; Valider) { }
            }

        }
        area(navigation)
        {
            group(Fonction)
            {
                Caption = 'Fonction';
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
                action("Mise … Jour Avances")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mise … Jour Avances';
                    Visible = false;

                    trigger OnAction()
                    begin
                        BonReglement.SETRANGE("Type Salaire", BonReglement."Type Salaire"::"Bon Reglement");
                        IF BonReglement.FINDFIRST THEN
                            REPEAT
                                BonReglement.VALIDATE(Matricule, BonReglement.Matricule);
                                BonReglement.VALIDATE(Nombre, BonReglement.Nombre);
                                BonReglement.MODIFY;
                            UNTIL BonReglement.NEXT = 0;
                    end;
                }
                action(Valider)
                {
                    ApplicationArea = Basic;
                    Caption = 'Valider';

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
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."N° Bon" := '';
    END;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        IF rec."Type Salaire" = Rec."Type Salaire"::Avance THEN rec.GetInfo;

    end;


    var
        BonReglement: record "Bon Reglement";
        Text002: label 'Confirmer Cette Action ?';
        Regimesofwork: record "Regimes of work";
        EmploymentContract: Record "Employment Contract";
        NbreHeureRegime: Decimal;
        MontantHSP: Decimal;
}

