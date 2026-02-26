page 52048959 "Liste Bon Reglement"
{//GL2024  ID dans Nav 2009 : "39001480"
    PageType = List;
    SourceTable = "Bon Reglement";
    ApplicationArea = all;
    UsageCategory = Lists;
    Caption = 'Liste Bon Reglement';
    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                Editable = false;
                field("N° Bon"; Rec."N° Bon")
                {
                    ApplicationArea = Basic;
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
                field(Chantier; Rec.Chantier)
                {
                    ApplicationArea = Basic;
                }
                field("Nom Et Prenom"; Rec."Nom Et Prenom")
                {
                    ApplicationArea = Basic;
                }
                field(Categorie; Rec.Categorie)
                {
                    ApplicationArea = Basic;
                }
                field(Qualification; Rec.Qualification)
                {
                    ApplicationArea = Basic;
                }
                field(Affectation; Rec.Affectation)
                {
                    ApplicationArea = Basic;
                }
                field(Montant; Rec.Montant)
                {
                    ApplicationArea = Basic;
                }
                field(Mensuel; Rec.Mensuel)
                {
                    ApplicationArea = Basic;
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
                field(Observation; Rec.Observation)
                {
                    ApplicationArea = Basic;
                }
                field("Net à Payer"; Rec."Net à Payer")
                {
                    ApplicationArea = Basic;
                }
                field("Net Initial"; Rec."Net Initial")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

