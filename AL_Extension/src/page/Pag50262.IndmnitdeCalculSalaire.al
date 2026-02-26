Page 50262 "Indémnité de Calcul Salaire"
{
    Editable = false;
    PageType = List;
    SourceTable = Indemnities;
    ApplicationArea = all;
    Caption = 'Indémnité de Calcul Salaire';
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("No."; REC."No.")
                {
                    ApplicationArea = all;
                }
                field("Employee No."; REC."Employee No.")
                {
                    ApplicationArea = all;
                }
                field("Employee Posting Group"; REC."Employee Posting Group")
                {
                    ApplicationArea = all;
                }
                field(Indemnity; REC.Indemnity)
                {
                    ApplicationArea = all;
                }
                field(Description; REC.Description)
                {
                    ApplicationArea = all;
                }
                field(Type; REC.Type)
                {
                    ApplicationArea = all;
                }
                field("Evaluation mode"; REC."Evaluation mode")
                {
                    ApplicationArea = all;
                }
                field("Base Amount"; REC."Base Amount")
                {
                    ApplicationArea = all;
                }
                field("Real Amount"; REC."Real Amount")
                {
                    ApplicationArea = all;
                }
                field(Rate; REC.Rate)
                {
                    ApplicationArea = all;
                }
                field("Global Dimension 1"; REC."Global Dimension 1")
                {
                    ApplicationArea = all;
                }
                field("Global Dimension 2"; REC."Global Dimension 2")
                {
                    ApplicationArea = all;
                }
                field("Real Amount PR"; REC."Real Amount PR")
                {
                    ApplicationArea = all;
                }
                field("Minimum value"; REC."Minimum value")
                {
                    ApplicationArea = all;
                }
                field(Nom; REC.Nom)
                {
                    ApplicationArea = all;
                }
                field("Nombre de jours"; REC."Nombre de jours")
                {
                    ApplicationArea = all;
                }
                field("Non déductible accident de Tra"; REC."Non déductible accident de Tra")
                {
                    ApplicationArea = all;
                }
                // field("Inclus dans heures supp"; REC."Inclus dans heures supp")
                // {
                //     ApplicationArea = all;
                // }
                // field("Inclure Jours Fer Cong"; REC."Inclure Jours Fer Cong")
                // {
                //     ApplicationArea = all;
                // }
                // field("Inclure Calcul Exo Impot"; REC."Inclure Calcul Exo Impot")
                // {
                //     ApplicationArea = all;
                // }
                // field("Min Comptabilisable"; REC."Min Comptabilisable")
                // {
                //     ApplicationArea = all;
                // }
                field("Non Inclis en AV NAt"; REC."Non Inclis en AV NAt")
                {
                    ApplicationArea = all;
                }
                field("Compte indemnité"; REC."Compte indemnité")
                {
                    ApplicationArea = all;
                }
                field("Compte contre partie indemnité"; REC."Compte contre partie indemnité")
                {
                    ApplicationArea = all;
                }
                // field("Indemnité conventionnelle"; REC."Indemnité conventionnelle")
                // {
                //     ApplicationArea = all;
                // }
                // field(Retraite; REC.Retraite)
                // {
                //     ApplicationArea = all;
                // }
                // field("Non Cotisable"; REC."Non Cotisable")
                // {
                //     ApplicationArea = all;
                // }
                // field("Panier Au Prorata Deplacement"; REC."Panier Au Prorata Deplacement")
                // {
                //     ApplicationArea = all;
                // }
                // field("Non Imposable"; REC."Non Imposable")
                // {
                //     ApplicationArea = all;
                // }
                // field(STC; REC.STC)
                // {
                //     ApplicationArea = all;
                // }
                field("User ID"; REC."User ID")
                {
                    ApplicationArea = all;
                }
                field("Last Date Modified"; REC."Last Date Modified")
                {
                    ApplicationArea = all;
                }
                field(Taux; REC.Taux)
                {
                    ApplicationArea = all;
                }
                field("Type Indemnité"; REC."Type Indemnité")
                {
                    ApplicationArea = all;
                }
                field("inclus en compta"; REC."inclus en compta")
                {
                    ApplicationArea = all;
                }
                field("Non Inclus en Prime"; REC."Non Inclus en Prime")
                {
                    ApplicationArea = all;
                }
                field("Precision Arrondi Montant"; REC."Precision Arrondi Montant")
                {
                    ApplicationArea = all;
                }
                field("Direction Arrondi"; REC."Direction Arrondi")
                {
                    ApplicationArea = all;
                }
                field("Employee Statistic Group"; REC."Employee Statistic Group")
                {
                    ApplicationArea = all;
                }
                field(direction; REC.direction)
                {
                    ApplicationArea = all;
                }
                field(service; REC.service)
                {
                    ApplicationArea = all;
                }
                field(section; REC.section)
                {
                    ApplicationArea = all;
                }
                field("Non Inclue en jours congé"; REC."Non Inclue en jours congé")
                {
                    ApplicationArea = all;
                }
                field("base deduction indemnité/jours"; REC."base deduction indemnité/jours")
                {
                    ApplicationArea = all;
                }
                field("base deduction indemnité/heure"; REC."base deduction indemnité/heure")
                {
                    ApplicationArea = all;
                }
                field("Avantage en nature"; REC."Avantage en nature")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

