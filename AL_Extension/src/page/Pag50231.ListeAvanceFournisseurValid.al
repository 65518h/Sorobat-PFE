Page 50231 "Liste Avance Fournisseur Valid"
{
    PageType = List;
    SourceTable = "Payment Line";
    SourceTableView = sorting("Due Date")
                      where(Caisse = const(true),
                            "Type Origine" = const(Fournisseur),
                            "Credit Amount" = filter(<> 0),
                            "Integration Avance Fournisseur" = const(true));
    ApplicationArea = all;
    Caption = 'Liste Avance Fournisseur Valid';
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                Editable = true;
                ShowCaption = false;
                field("No."; REC."No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Due Date"; REC."Due Date")
                {
                    ApplicationArea = all;
                    Caption = 'Date';
                    Editable = false;
                }
                field("Integration Avance Fournisseur"; REC."Integration Avance Fournisseur")
                {
                    ApplicationArea = all;
                    Caption = 'Integrer';
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Code Borderaux AV Fourn"; REC."Code Borderaux AV Fourn")
                {
                    ApplicationArea = all;
                    Caption = 'N° Bordereau Paiement';
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Type Origine"; REC."Type Origine")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field(Benificiaire; REC.Benificiaire)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Nom Benificiaire"; REC."Nom Benificiaire")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                // field("Code Opération"; REC."Code Opération")
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                // }
                // field("Type Caisse"; REC."Type Caisse")
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                // }
                field("Libellé"; REC.Libellé)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Credit Amount"; REC."Credit Amount")
                {
                    ApplicationArea = all;
                    Caption = 'Depenses';
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                field("Numero Seq"; REC."Numero Seq")
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

    var
        DecSommDebit: Decimal;
        DecSommCredit: Decimal;
        RecPaymentLineSelect: Record "Payment Line";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Text001: label 'Voulez Vous valider les Lignes selectionner ?';
        RecPaymentHeader: Record "Payment Header";
        RecPaymentLine: Record "Payment Line";
        RecPaymentLine2: Record "Payment Line";
        Text002: label 'Validation Achevé avec succée !!';
        Text003: label 'Il Faut Inserer un code Fournisseur !';
}

