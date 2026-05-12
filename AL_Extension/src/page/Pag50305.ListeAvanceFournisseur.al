page 50305 "Liste Avance Fournisseur"
{
    AutoSplitKey = true;
    Caption = 'Liste Avance Fournisseur';
    DelayedInsert = true;
    Editable = false;
    PageType = List;
    SourceTable = "Payment Header";
    SourceTableView = SORTING("No.")
                      WHERE("Payment Class" = FILTER('AVAN*'),
                            "Posting Date" = FILTER(> '31/12/19'));
    ApplicationArea = all;
    UsageCategory = lists;

    layout
    {
        area(content)
        {
            repeater(content1)
            {
                ShowCaption = false;

                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Payment Class"; rec."Payment Class")
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field(Utilisateur; rec.Utilisateur)
                {
                    ApplicationArea = all;
                }
                field("Autoriser avance Fournisseur"; rec."Autoriser avance Fournisseur")
                {
                    ApplicationArea = all;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
                field("Approuvé par"; rec."Approuvé par")
                {
                    ApplicationArea = all;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
                field("Date Approbation"; rec."Date Approbation")
                {
                    ApplicationArea = all;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
            }
        }
    }

    actions
    {
        area(Promoted)
        {
            group("&Payment Slip1")
            {
                Caption = '&Payment Slip';
                actionref(Card1; Card) { }
            }
        }
        area(navigation)
        {
            group("&Payment Slip")
            {
                Caption = '&Payment Slip';
                action(Card)
                {
                    ApplicationArea = all;
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Payment Slip";
                    RunPageLink = "No." = FIELD("No.");
                    ShortCutKey = 'Maj+F5';
                }
            }
        }
    }

    var
        Text000: Label 'Assign No. ?';
        Text001: Label 'There is no line to modify';
        Text002: Label 'A posted line cannot be modified.';
        Text003: Label 'Montant Retour Supérieure au Montant Principal';
        Text004: Label 'Veuillez Spécifier Tous Les Champs Pour Ce Type d''Opération';
        Text005: Label 'Champs Rempli Seulement Pour Avance Et Prêt';
        Text006: Label 'Vous Devez Supprimer d''abord le Docment Avance de la Paie Avant de Supprimer Cette Ligne';
}

