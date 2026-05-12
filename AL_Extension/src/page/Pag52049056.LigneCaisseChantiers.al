page 52049056 "Ligne Caisse Chantiers"
{//GL2024  ID dans Nav 2009 : "39001584"
    Caption = 'Ligne Caisse Chantiers';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "Payment Line";
    SourceTableView = where("Caisse Chantier" = const(true));
    ApplicationArea = all;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1000000389)
            {
                ShowCaption = false;
                Editable = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                // field("Code Opération"; Rec."Code Opération")
                // {
                //     ApplicationArea = Basic;
                // }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date Opération';
                }
                field("Libellé"; Rec.Libellé)
                {
                    ApplicationArea = Basic;
                }
                field(Benificiaire; Rec.Benificiaire)
                {
                    ApplicationArea = Basic;
                }
                field("Nom Benificiaire"; Rec."Nom Benificiaire")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                    Style = Strong;
                    StyleExpr = true;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        AmountOnFormat;
    end;

    var
        ChangeExchangeRate: Page "Change Exchange Rate";
        Navigate: Page Navigate;
        Steps: Record "Payment Step";
        Text001: label 'This payment class does not authorize vendor suggestions.';
        Text002: label 'This payment class does not authorize customer suggestions.';
        Text003: label 'You cannot suggest payments on a posted header.';
        Text004: label 'You cannot assign a number to a posted header.';
        Text005: label 'This document has no line. You cannot archive it. You must delete it.';
        Text006: label 'One line is not posted. Are you sure you want to archive this document ?';
        Text007: label 'Some lines are not posted. Are you sure you want to archive this document ?';
        Text008: label 'Are you sure you want to archive this document ?';
        Text009: label 'Do you wish to archive this document ?';
        "-MBK-": Integer;
        PaymentStatus_gr: Record "Payment Status";
        PaymentLine_gr: Record "Payment Line";
        "Chèquemouvementé_gr": Record "Chèque mouvementé";

        Text010: label 'Veuillez saisir le N° Chèque dans la ligne %1';
        Text011: label 'N° chèque %1 utlisé plus d''une fois';
        RecBankAccount: Record "Bank Account";
        "-HJ-": Integer;
        RecAutorisationEtapes: Record "Autorisation Etapes2";
        RecUser: Record "User Setup";
        RecEntetePayement: Record "Payment Header";
        RecPaymentLine: Record "Payment Line";
        RecBank: Record "Bank Account";
        REcPaymentSteps: Record "Payment Step";
        RecPaymentStatus: Record "Payment Status";
        TxtEtapesSuivante: Text[1000];
        RecEntete: Record "Payment Header";

        Text0010: label 'Vous N''ete Pas Autorise A Cette Etape %1,  %2,  %3 ; Consulter Votre Administrateur';
        Text0011: label 'Vous N''ete Pas Autorisé Au Module Encaissement - Decaissement';
        Text0012: label 'Votre Agence %1 Est Différente De Celle De L''Etape ( %2 )';
        Text013: label 'Changement Agence Non Permis A Ce Statut';
        Text014: label 'Vous n''etes pas autoriser à Changer L''agence';
        //  RecAgence: Record "Chantier Loyer";
        RecPaymentMethod: Record "Payment Method";
        RecPaymentMethod2: Record "Payment Method";
        RecSalesReceivablesSetup: Record "Sales & Receivables Setup";
        RecCustomer: Record Customer;
        RecPaymentClass: Record "Payment Class";
        IntClient: Integer;
        IntTypeReglement: Integer;
        Text0015: label 'Mode Paiement Client N° %1 ( %2 ) Ne Peut Pas Etre %3';
        PaymentLine: Record "Payment Line";
        GeneralLedgerSetup: Record "General Ledger Setup";
        PaymentClassList: Page "Payment Class List";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Text016: label 'Nouveau Brouillard ?';
        LoanAdvance: Record "Loan & Advance";
        //   DetailBrouillard: Record "Detail Avancement Production";
        NumSequence: Code[20];
        PaymentLine2: Record "Payment Line";
        Line: Record "Payment Line";
        Text017: label 'Valider Le Brouillards ?';
        Text018: label 'Validation Achevée Avec Succée';
        Text019: label 'Deja Valider';
        Text020: label 'reouvrir Ce Document ?';
        Text021: label 'Document est Ouvert';
        Text022: label 'Deja Ouvert';
        SalaryLines: Record "Salary Lines";
        //  RegroupementPaie: Record "Regroupement Paie";
        PaymentHeader: Record "Payment Header";
    // RegroupementPaieEntete: Record "Regroupement Paie Entete";
    //GL3900   RegroupementPaieRetour: Record "Regroupement Paie Retour";


    procedure ValidatePayment()
    var
        Ok: Boolean;
        PostingStatement: Codeunit "Payment Management";
        Options: Text[400];
        Choice: Integer;
        I: Integer;
    begin
    end;

    local procedure AmountOnFormat()
    begin
        //GL2024
        /*IF Amount>0 THEN BEGIN END
        ELSE   CurrPage.Amount.UPDATEFORECOLOR(255)  */

    end;
}

