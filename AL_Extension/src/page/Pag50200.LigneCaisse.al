Page 50200 "Ligne Caisse"
{
    Editable = false;
    PageType = List;
    SourceTable = "Payment Line";
    SourceTableView = sorting("Due Date")
                      where(Caisse = const(true));
    ApplicationArea = all;
    Caption = 'Ligne Caisse';
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                Editable = true;
                field("No."; REC."No.")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Line No."; REC."Line No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Due Date"; REC."Due Date")
                {
                    ApplicationArea = all;
                    Caption = 'Date';
                }
                field("Numero Seq"; REC."Numero Seq")
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; REC."Posting Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("N° Affaire"; REC."N° Affaire")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Type Origine"; REC."Type Origine")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = true;
                }
                field(Benificiaire; REC.Benificiaire)
                {
                    ApplicationArea = all;
                }
                field("Nom Benificiaire"; REC."Nom Benificiaire")
                {
                    ApplicationArea = all;
                }
                // field("Code Opération"; REC."Code Opération")
                // {
                //     ApplicationArea = all;
                // }
                // field("Type Caisse"; REC."Type Caisse")
                // {
                //     ApplicationArea = all;
                // }
                field("Libellé"; REC.Libellé)
                {
                    ApplicationArea = all;
                }
                field("Debit Amount"; REC."Debit Amount")
                {
                    ApplicationArea = all;
                    Caption = 'Recettes';
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Credit Amount"; REC."Credit Amount")
                {
                    ApplicationArea = all;
                    Caption = 'Depenses';
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                field("Numero Seq Retour"; REC."Numero Seq Retour")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("External Document No."; REC."External Document No.")
                {
                    ApplicationArea = all;
                }
                field("Date Debut"; REC."Date Debut")
                {
                    ApplicationArea = all;
                    Caption = 'Date D''affectation';
                }
                field(Affaire; REC.Affaire)
                {
                    ApplicationArea = all;
                    Caption = 'Chantier';
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Validé Caisse"; REC."Validé Caisse")
                {
                    ApplicationArea = all;
                    Caption = 'Caisse Validé ';
                    Style = Strong;
                    StyleExpr = true;
                }
                field(Commentaires; REC.Commentaires)
                {
                    ApplicationArea = all;
                }
                field("N° Paie"; REC."N° Paie")
                {
                    ApplicationArea = all;
                }
                field("Description Paie"; REC."Description Paie")
                {
                    ApplicationArea = all;
                }
                field(Affect; REC.Affect)
                {
                    ApplicationArea = all;
                }
                field(MoisPaie; REC.MoisPaie)
                {
                    ApplicationArea = all;
                }
                field(Qualification; REC.Qualification)
                {
                    ApplicationArea = all;
                }
                field("Designation Affectation"; REC."Designation Affectation")
                {
                    ApplicationArea = all;
                }
                field("Designation Qualification"; REC."Designation Qualification")
                {
                    ApplicationArea = all;
                }
                field("Date Affectation"; REC."Date Debut")
                {
                    ApplicationArea = all;
                    Caption = 'Date Affectation';
                }
                field(Tranche; REC.Tranche)
                {
                    ApplicationArea = all;
                }
                // field(Chrono; REC.Chrono)
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                // }
            }
            field(DecSommDebit; DecSommDebit)
            {
                Caption = 'Débit';
                ApplicationArea = all;
                DecimalPlaces = 3 : 3;
                Editable = false;
                Style = Strong;
                StyleExpr = true;
            }
            field(DecSommCredit; DecSommCredit)
            {
                Caption = 'Crédit';
                ApplicationArea = all;
                DecimalPlaces = 3 : 3;
                Editable = false;
                Style = Attention;
                StyleExpr = true;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Calculer la Sélection")
            {
                ApplicationArea = all;
                Caption = 'Calculer la Sélection';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    RecPaymentLineSelect.Reset;
                    DecSommDebit := 0;
                    DecSommCredit := 0;
                    CurrPage.SetSelectionFilter(RecPaymentLineSelect);
                    if RecPaymentLineSelect.FindFirst then
                        repeat
                            DecSommDebit += RecPaymentLineSelect."Debit Amount";
                            DecSommCredit += RecPaymentLineSelect."Credit Amount";
                        until RecPaymentLineSelect.Next = 0;
                end;
            }
        }
    }

    var
        DecSommDebit: Decimal;
        DecSommCredit: Decimal;
        RecPaymentLineSelect: Record "Payment Line";
}

