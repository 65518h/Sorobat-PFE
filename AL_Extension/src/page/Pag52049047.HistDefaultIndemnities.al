page 52049047 "Hist. Default Indemnities"
{//GL2024  ID dans Nav 2009 : "39001575"
    PageType = ListPart;
    SourceTable = "Hist. Default Indemnities";

    Caption = 'Hist. Default Indemnities';
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            repeater(Control1102752000)
            {
                ShowCaption = false;
                Editable = false;
                field("Employment Contract Code"; Rec."Employment Contract Code")
                {
                    ApplicationArea = Basic;
                }
                field("Indemnity Code"; Rec."Indemnity Code")
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
                field("Minimum value"; Rec."Minimum value")
                {
                    ApplicationArea = Basic;
                }
                field("Mois d'application"; Rec."Mois d'application")
                {
                    ApplicationArea = Basic;
                }
                field("Non Inclis en AV NAt"; Rec."Non Inclis en AV NAt")
                {
                    ApplicationArea = Basic;
                }
                field("Non Inclis en Jours Fer"; Rec."Non Inclis en Jours Fer")
                {
                    ApplicationArea = Basic;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
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
                field("non inclus en compta"; Rec."non inclus en compta")
                {
                    ApplicationArea = Basic;
                }
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
                field("Inclus dans base assurance"; Rec."Inclus dans base assurance")
                {
                    ApplicationArea = Basic;
                }
                field("Basis amount"; Rec."Basis amount")
                {
                    ApplicationArea = Basic;
                }
                field("Non Inclue en jours congé"; Rec."Non Inclue en jours congé")
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

