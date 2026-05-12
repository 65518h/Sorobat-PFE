page 52048897 "Employment Contracts List Ind"
{
    //GL2024  ID dans Nav 2009 : "39001418"
    PageType = listPart;
    SourceTable = "Default Indemnities";
    Caption = 'Employment Contracts List Ind';
    ApplicationArea = All;
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            repeater(Control1180250000)
            {
                ShowCaption = false;
                field("Indemnity Code"; Rec."Indemnity Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Code indemnité';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Caption = 'Désignation';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                    Caption = 'Type';
                }
                field("Default amount"; Rec."Default amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Montant par défaut';
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Evaluation mode"; Rec."Evaluation mode")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mode d''évaluation';
                    Editable = true;
                }

                // field("Panier Au Prorata Deplacement"; Rec."Panier Au Prorata Deplacement")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Panier Au Prorata Deplacement';
                // }
                // field("Inclure Calcul Exo Impot"; Rec."Inclure Calcul Exo Impot")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Inclure Calcul Exo Impot';
                // }
                // field("Inclus Base Calcul Ferié-Congé"; Rec."Inclus Base Calcul Ferié-Congé")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Inclus Base Calcul Ferié-Congé';
                // }
                field("Inclus dans heures supp"; Rec."Inclus dans heures supp")
                {
                    ApplicationArea = Basic;
                    Caption = 'Inclus dans heures supp';
                    Visible = false;
                }
                // field(STC; Rec.STC)
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'STC';
                // }
                // field("Ferié Congé Inclus Jours Payés"; Rec."Ferié Congé Inclus Jours Payés")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Ferié Congé Inclus Jours Payés';
                // }
                // field("Min Comptabilisable"; Rec."Min Comptabilisable")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Min Comptabilisable';
                // }
                field("Compte indemnité"; Rec."Compte indemnité")
                {
                    ApplicationArea = Basic;
                    Caption = 'Compte indemnité';
                }
                field("Avantage en nature"; Rec."Avantage en nature")
                {
                    ApplicationArea = Basic;
                    Caption = 'Avantage en nature';
                }
                field("Non Inclis en AV NAt"; Rec."Non Inclis en AV NAt")
                {
                    ApplicationArea = Basic;
                    Caption = 'Non Inclis en AV NAt';
                }
                field("Compte contre partie indemnité"; Rec."Compte contre partie indemnité")
                {
                    ApplicationArea = Basic;
                    Caption = 'Compte contre partie indemnité';
                }
                field("% salaire de base"; Rec."% salaire de base")
                {
                    ApplicationArea = Basic;
                    Caption = '% salaire de base';
                }
                field("Non Inclue en jours congé"; Rec."Non Inclue en jours congé")
                {
                    ApplicationArea = Basic;
                    Caption = 'Non Inclue en jours congé';
                }
                field(Taux; Rec.Taux)
                {
                    ApplicationArea = Basic;
                    Caption = 'Taux';
                    Editable = true;
                    Visible = true;
                }
                field("Indemnité conventionnelle"; Rec."Indemnité conventionnelle")
                {
                    ApplicationArea = Basic;
                    Caption = 'Indemnité conventionnelle';
                }
                field("Inclus dans base assurance"; Rec."Inclus dans base assurance")
                {
                    ApplicationArea = Basic;
                    Caption = 'Inclus dans base assurance';
                }
                field("Non Inclus en Prime"; Rec."Non Inclus en Prime")
                {
                    ApplicationArea = Basic;
                    Caption = 'Non Inclus en Prime';
                }
                field("Non Inclus en Calcul CNSS"; Rec."Non Inclus en Calcul CNSS")
                {
                    ApplicationArea = Basic;
                    Caption = 'Non Inclus en Calcul CNSS';
                }
                field("Inclu Calcul Brut STC"; Rec."Inclu Calcul Brut STC")
                {
                    ApplicationArea = Basic;
                    Caption = 'Inclu Calcul Brut STC';
                }
                field(Abattement; Rec.Abattement)
                {
                    ApplicationArea = Basic;
                    Caption = 'Abattement';
                }
                field("% Abattement"; Rec."% Abattement")
                {
                    ApplicationArea = Basic;
                    Caption = '% Abattement';
                }
                field(Exonération; Rec.Exonération)
                {
                    ApplicationArea = Basic;
                    Caption = 'Exon‚ration';
                }
                field("% Exonération"; Rec."% Exonération")
                {
                    ApplicationArea = Basic;
                    Caption = '% Exonération';
                }
                field("Plafond Exonération"; Rec."Plafond Exonération")
                {
                    ApplicationArea = Basic;
                    Caption = 'Plafond Exonération';
                }
                field("Basis amount"; Rec."Basis amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Montant de base';
                }
                field(Control1000000008; Rec."% salaire de base")
                {
                    ApplicationArea = Basic;
                    Caption = '% salaire de base';
                }
                field("Taux % salaire de base"; Rec."Taux % salaire de base")
                {
                    Caption = 'Taux % salaire de base';
                    ApplicationArea = Basic;
                }
                field(Control1000000040; Rec."Inclus dans heures supp")
                {
                    ApplicationArea = Basic;
                    Caption = 'Inclus dans heures supp';
                }
                field("base deduction indemnité/jours"; Rec."base deduction indemnité/jours")
                {
                    ApplicationArea = Basic;
                    Caption = 'Base deduction indemnité/jours';
                }
                field("base deduction indemnité/heure"; Rec."base deduction indemnité/heure")
                {
                    ApplicationArea = Basic;
                    Caption = 'Base deduction indemnité/heure';
                }
                field("Type Indemnité"; Rec."Type Indemnité")
                {
                    ApplicationArea = Basic;
                    Caption = 'Type Indemnité';
                }
                field("Nombre de jours"; Rec."Nombre de jours")
                {
                    ApplicationArea = Basic;
                    Caption = 'Nombre de jours';
                }
                // field("Non Cotisable"; Rec."Non Cotisable")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Non Cotisable';
                // }
                // field("Non Imposable"; Rec."Non Imposable")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Non Imposable';
                // }
                field("Precision Arrondi Montant"; Rec."Precision Arrondi Montant")
                {
                    ApplicationArea = Basic;
                    Caption = 'Precision Arrondi Montant';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.Update();
    end;
}

