page 52049050 "Fiche indemnité"
{//GL2024  ID dans Nav 2009 : "39001578"
    PageType = Card;
    SourceTable = Indemnity;
    ApplicationArea = all;
    UsageCategory = Administration;
    Caption = 'Fiche indemnité';
    layout
    {
        area(content)
        {
            group("Général")
            {
                Caption = 'Général';
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field("Evaluation mode"; Rec."Evaluation mode")
                {
                    ApplicationArea = Basic;
                }
                field("Default amount"; Rec."Default amount")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Posting Grp. filter"; Rec."Employee Posting Grp. filter")
                {
                    ApplicationArea = Basic;
                }
                field("Payment No. filter"; Rec."Payment No. filter")
                {
                    ApplicationArea = Basic;
                }
                field("Total Indemnity"; Rec."Total Indemnity")
                {
                    ApplicationArea = Basic;
                }
                field("Total Rec. Indemnity"; Rec."Total Rec. Indemnity")
                {
                    ApplicationArea = Basic;
                }
                field("Minimum value"; Rec."Minimum value")
                {
                    ApplicationArea = Basic;
                }
                field(Taux; Rec.Taux)
                {
                    ApplicationArea = Basic;
                }
                field("Type Indemnité"; Rec."Type Indemnité")
                {
                    ApplicationArea = Basic;
                }
                // field("Inclus Base Calcul Ferié-Congé"; Rec."Inclus Base Calcul Ferié-Congé")
                // {
                //     ApplicationArea = Basic;
                // }
                field("Non Inclus en Prime"; Rec."Non Inclus en Prime")
                {
                    ApplicationArea = Basic;
                }
                field("Precision Arrondi Montant"; Rec."Precision Arrondi Montant")
                {
                    ApplicationArea = Basic;
                }
                field("Direction Arrondi"; Rec."Direction Arrondi")
                {
                    ApplicationArea = Basic;
                }
                field("Non Inclue en jours congé"; Rec."Non Inclue en jours congé")
                {
                    ApplicationArea = Basic;
                }
                field("Indemnité conventionnelle"; Rec."Indemnité conventionnelle")
                {
                    ApplicationArea = Basic;
                }
                field("base deduction indemnité/jours"; Rec."base deduction indemnité/jours")
                {
                    ApplicationArea = Basic;
                    Caption = 'Base deduction indemnité/jours';
                }
                field("base deduction indemnité/heure"; Rec."base deduction indemnité/heure")
                {
                    ApplicationArea = Basic;
                }
                field("Non Inclis en AV NAt"; Rec."Non Inclis en AV NAt")
                {
                    ApplicationArea = Basic;
                }
                field("Avantage en nature"; Rec."Avantage en nature")
                {
                    ApplicationArea = Basic;
                }
                field("Non Inclue en jours férier"; Rec."Non Inclue en jours férier")
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

