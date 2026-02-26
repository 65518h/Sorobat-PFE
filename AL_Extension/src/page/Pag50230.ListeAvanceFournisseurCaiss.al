Page 50230 "Liste Avance Fournisseur Caiss"
{
    PageType = List;
    SourceTable = "Payment Line";
    SourceTableView = sorting("Due Date")
                      where(Caisse = const(true),
                            "Type Origine" = const(Fournisseur),
                            "Credit Amount" = filter(<> 0),
                            "Integration Avance Fournisseur" = const(false));
    ApplicationArea = all;
    Caption = 'Liste Avance Fournisseur Caiss';
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
                field(Selectionner; REC.Selectionner)
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Due Date"; REC."Due Date")
                {
                    ApplicationArea = all;
                    Caption = 'Date';
                    Editable = false;
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
                // field(Chrono; REC.Chrono)
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                // }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Valider)
            {
                ApplicationArea = all;
                Caption = 'Valider';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if not Confirm(Text001) then exit;

                    RecPaymentLine.Copy(Rec);
                    RecPaymentLine.SetRange(Selectionner, true);
                    if RecPaymentLine.FindFirst then
                        repeat
                            if RecPaymentLine.Benificiaire = '' then Error(Text003);
                            RecPaymentHeader.Validate(RecPaymentHeader."Payment Class", 'AUTRE-DECAISS');
                            RecPaymentHeader.Validate("No.", NoSeriesMgt.GetNextNo('AUTREDECAI', RecPaymentLine."Due Date", true));
                            RecPaymentHeader.Validate("Posting Date", RecPaymentLine."Due Date");
                            RecPaymentHeader.Validate("Document Date", RecPaymentLine."Due Date");
                            RecPaymentHeader.Validate(RecPaymentHeader."Payment Class", 'AUTRE-DECAISS');
                            RecPaymentHeader.Validate(RecPaymentHeader."Account Type", 3);
                            RecPaymentHeader.Validate(RecPaymentHeader."Account No.", 'BQ001037');
                            RecPaymentHeader.Utilisateur := UpperCase(UserId);
                            if not RecPaymentHeader.Insert then RecPaymentHeader.Modify;

                            // Insertion Lignie Bordereau

                            RecPaymentLine2.Validate(RecPaymentLine2."No.", RecPaymentHeader."No.");
                            RecPaymentLine2."Line No." := 10000;
                            RecPaymentLine2.Validate(RecPaymentLine2."Payment Class", 'AUTRE-DECAISS');
                            RecPaymentLine2.Commentaires := RecPaymentLine.Libellé;
                            RecPaymentLine2.Utilisateur := UpperCase(UserId);
                            RecPaymentLine2.Validate(RecPaymentLine2."Type de compte", 2);
                            RecPaymentLine2.Validate(RecPaymentLine2."Code compte", RecPaymentLine.Benificiaire);
                            RecPaymentLine2.Amount := REC."Credit Amount";
                            RecPaymentLine2."Debit Amount" := REC."Credit Amount";
                            RecPaymentLine2."Amount (LCY)" := REC."Credit Amount";
                            RecPaymentLine2.Validate(RecPaymentLine2."Due Date", RecPaymentLine."Due Date");
                            RecPaymentLine2.Validate(RecPaymentLine2."Compte Bancaire", 'BQ001037');
                            if not RecPaymentLine2.Insert then RecPaymentLine2.Modify;

                            RecPaymentLine."Integration Avance Fournisseur" := true;
                            RecPaymentLine."Code Borderaux AV Fourn" := RecPaymentHeader."No.";
                            //   RecPaymentLine.Chrono := RecPaymentHeader."No.";
                            RecPaymentLine.Selectionner := false;
                            RecPaymentLine.Modify();

                        until RecPaymentLine.Next = 0;
                    CurrPage.Update;
                    Message(Text002);
                end;
            }
        }
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

