page 50308 "Liste Chèque Trésor"
{
    //GL2024 NEW PAGE
    Caption = 'Liste Chèque Trésor';
    PageType = list;
    RefreshOnActivate = true;
    SourceTable = "Payment Header";
    SourceTableView = SORTING("N° Bordereau") ORDER(Ascending) WHERE("Payment Class" = FILTER('CHEQUE TRESOR'));
    ApplicationArea = all;
    UsageCategory = lists;
    CardPageId = "Chèque Trésor";
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                    AssistEdit = false;
                    Editable = false;


                }
                field("Payment Class"; rec."Payment Class")
                {
                    ApplicationArea = all;
                    //   Editable = false;
                    Lookup = false;
                }
                field("Payment Class Name"; rec."Payment Class Name")
                {
                    ApplicationArea = all;
                    DrillDown = false;
                    Editable = false;
                }
                field("Status Name"; rec."Status Name")
                {
                    ApplicationArea = all;
                    DrillDown = false;
                    Editable = false;
                }
                field("Currency Code1"; rec."Currency Code")
                {
                    ApplicationArea = all;


                }
                field("Account Type"; rec."Account Type")
                {
                    ApplicationArea = all;
                    //  OptionCaption = 'G/L Account,Customer,Vendor,Bank Account';
                }
                field("Account No."; rec."Account No.")
                {
                    ApplicationArea = all;
                }
                field("Source Code"; rec."Source Code")
                {
                    ApplicationArea = all;
                }
                field(Agence; rec.Agence)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Utilisateur; rec.Utilisateur)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Validé Par"; rec."Validé Par")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = all;
                }

                field("Document Date"; rec."Document Date")
                {
                    ApplicationArea = all;


                }
                field("Amount (LCY)"; rec."Amount (LCY)")
                {
                    ApplicationArea = all;
                    Caption = 'Total Montant DS';
                    DecimalPlaces = 3 : 3;
                }
                field(Amount; rec.Amount)
                {
                    ApplicationArea = all;
                    Caption = 'Total Montant';
                    DecimalPlaces = 3 : 3;
                }
                field(Objet; rec.Objet)
                {
                    ApplicationArea = all;
                }
                field(Bénéficiaire; rec.Bénéficiaire)
                {
                    ApplicationArea = all;
                }
                field("Type paiement"; rec."Type paiement")
                {
                    ApplicationArea = all;
                }
                field(Qualité; rec.Qualité)
                {
                    ApplicationArea = all;
                }
                field(Justificatifs; rec.Justificatifs)
                {
                    ApplicationArea = all;
                }
                field("Code Recouvreur"; rec."Code Recouvreur")
                {
                    ApplicationArea = all;
                }


                field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 2 Code"; rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                }
                field("Currency Code"; rec."Currency Code")
                {
                    ApplicationArea = all;
                }
                field(Presentation; rec.Presentation)
                {
                    ApplicationArea = all;
                }

                /*GL2024
                                field("N° CI"; rec."N° CI")
                                {
                                    ApplicationArea = all;
                                }
                                field("DATE D'EMBARQUEMENT"; rec."DATE D'EMBARQUEMENT")
                                {
                                    ApplicationArea = all;
                                }
                                field("DATE D'EXPIRATION"; rec."DATE D'EXPIRATION")
                                {
                                    ApplicationArea = all;
                                }
                                field("CONDITION DE VENTE"; rec."CONDITION DE VENTE")
                                {
                                    ApplicationArea = all;
                                }
                                field("PORT EMBARQUEMENT"; rec."PORT EMBARQUEMENT")
                                {
                                    ApplicationArea = all;
                                }
                                field("PORT DEBARQUEMENT"; rec."PORT DEBARQUEMENT")
                                {
                                    ApplicationArea = all;
                                }
                                field("Mode Echéance"; rec."Mode Echéance")
                                {
                                    ApplicationArea = all;
                                }
                                field("Objet Lettre"; rec."Objet Lettre")
                                {
                                    ApplicationArea = all;
                                }
                                field("N° Brouillard"; rec."N° Brouillard")
                                {
                                    ApplicationArea = all;
                                }
                                field(Destinataire; rec.Destinataire)
                                {
                                    ApplicationArea = all;
                                }
                                field("Tomber FED"; rec."Tomber FED")
                                {
                                    ApplicationArea = all;
                                }


                                field(TAUX; rec.TAUX)
                                {
                                    ApplicationArea = all;
                                }
                                field(Durée; rec.Durée)
                                {
                                    ApplicationArea = all;
                                }
                                field("Comm Bancaire"; rec."Comm Bancaire")
                                {
                                    ApplicationArea = all;
                                }
                                field(Bénéficiaire2; rec.Bénéficiaire)
                                {
                                    ApplicationArea = all;
                                }
                                field(Période; rec.Période)
                                {
                                    ApplicationArea = all;
                                }*/

            }
        }
    }
}