Page 50198 "Default indemnities"
{
    Editable = false;
    PageType = List;
    SourceTable = "Default Indemnities";
    ApplicationArea = all;
    Caption = 'Default indemnities';
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Employment Contract Code"; REC."Employment Contract Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Indemnity Code"; REC."Indemnity Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Enabled = true;
                }
                field(Description; REC.Description)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Type; REC.Type)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Enabled = true;
                }
                field("Evaluation mode"; REC."Evaluation mode")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Default amount"; REC."Default amount")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Minimum value"; REC."Minimum value")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Nombre de jours"; REC."Nombre de jours")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Non déductible accident de Tra"; REC."Non déductible accident de Tra")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Inclus dans heures supp"; REC."Inclus dans heures supp")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                // field("Ferié Congé Inclus Jours Payés"; REC."Ferié Congé Inclus Jours Payés")
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                // }
                // field("Inclure Calcul Exo Impot"; REC."Inclure Calcul Exo Impot")
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                // }
                // field("Min Comptabilisable"; REC."Min Comptabilisable")
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                // }
                field("Mois d'application"; REC."Mois d'application")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Non Inclis en AV NAt"; REC."Non Inclis en AV NAt")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                // field("Inclus Base Calcul Ferié-Congé"; REC."Inclus Base Calcul Ferié-Congé")
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                // }
                field("Compte indemnité"; REC."Compte indemnité")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Compte contre partie indemnité"; REC."Compte contre partie indemnité")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("% salaire de base"; REC."% salaire de base")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Taux % salaire de base"; REC."Taux % salaire de base")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                // field(Retraite; REC.Retraite)
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                // }
                // field(Trouver; REC.Trouver)
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                // }s
                // field("Non Cotisable"; REC."Non Cotisable")
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                // }
                // field("Panier Au Prorata Deplacement"; REC."Panier Au Prorata Deplacement")
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                // }
                field("User ID"; REC."User ID")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Last Date Modified"; REC."Last Date Modified")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Taux; REC.Taux)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Type Indemnité"; REC."Type Indemnité")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("non inclus en compta"; REC."non inclus en compta")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Non Inclus en Prime"; REC."Non Inclus en Prime")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Precision Arrondi Montant"; REC."Precision Arrondi Montant")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Direction Arrondi"; REC."Direction Arrondi")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Inclus dans base assurance"; REC."Inclus dans base assurance")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Basis amount"; REC."Basis amount")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Non Inclue en jours congé"; REC."Non Inclue en jours congé")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Indemnité conventionnelle"; REC."Indemnité conventionnelle")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("base deduction indemnité/jours"; REC."base deduction indemnité/jours")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("base deduction indemnité/heure"; REC."base deduction indemnité/heure")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Avantage en nature"; REC."Avantage en nature")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

