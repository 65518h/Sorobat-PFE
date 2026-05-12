report 52048880 "Payroll : Post Loan & Advance"
{
    //GL2024  ID dans Nav 2009 : "39001402"
    ProcessingOnly = true;
    UseSystemPrinter = false;

    dataset
    {
        dataitem("Loan & Advance"; "Loan & Advance")
        {
            DataItemTableView = SORTING("Document type");
            RequestFilterFields = "No.", "Document type";
            RequestFilterHeading = 'Loans && Advances';
            dataitem("Loan & Advance Type"; "Loan & Advance Type")
            {
                DataItemLink = Code = FIELD("Document type"),
                               Type = FIELD(Type);
                DataItemTableView = SORTING(Code)
                                    ORDER(Descending);

                trigger OnPreDataItem()
                begin
                    IF NOT MgmtLoansAdvances.TestValiditeDocument("Loan & Advance") THEN
                        ERROR(errDoc, "Loan & Advance"."No." + ' - ' + "Loan & Advance".Name);

                end;

                trigger OnAfterGetRecord()
                begin


                    IF "Imputation Comptable" = 0 THEN
                        MgmtLoansAdvances.EcrComptaPaiement("Loan & Advance", PostingDate, PostingMode);
                end;
            }

            trigger OnAfterGetRecord()
            begin


                window.UPDATE(1, "Loan & Advance"."No.");
                window.UPDATE(2, "Loan & Advance".Employee + ' - ' + "Loan & Advance".Name);
                window.UPDATE(3, 'Vérification de la validité des documents');
            end;

            trigger OnPostDataItem()
            begin
                IF "Loan & Advance".FIND('-') THEN
                    REPEAT
                        MgmtLoansAdvances.EnregDocument("Loan & Advance", PostingDate);
                        window.UPDATE(3, 'Enregistrement des documents validés');
                    UNTIL "Loan & Advance".NEXT = 0;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("Document type");
                window.OPEN('Validation des Prêts && Avances en cours ...\' +
                             'N° document : ########################1####\' +
                             "Loan & Advance".FIELDCAPTION(Employee) + '     : ########################2####\' +
                             '######################################3####');
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(options)
                {
                    field(PostingDate; PostingDate)
                    {
                        Caption = 'Date de validation';

                    }
                    field(PostingMode; PostingMode)
                    {
                        Caption = 'Mode de validation';

                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        PostingDate := WORKDATE;
    end;

    trigger OnPostReport()
    begin
        HumResSetup.Get();
        CASE PostingMode OF
            0:
                MESSAGE(success, HumResSetup."General Journal Template", HumResSetup."Gen. Journal Batch (L&A)");
        END;

        window.CLOSE;
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        TotalFor: Label 'Total ';
        MgmtLoansAdvances: Codeunit "Mgmt. of Loans and Advances";
        PostingDate: Date;
        PostingMode: Option "Par Feuille de saisie",Directe;
        HumResSetup: Record 5218;
        GenJournalLine: Record 81;
        GenJournalBatch: Record 232;
        GenJnlPostLine: Codeunit 12;
        Line: Integer;
        BankAccount: Record 270;
        errConfig: Label 'Nom du modèle de Feuille de saisie vide dans Paramètres ressources humaines.';
        errLATypeMissing: Label 'Type Prêt & Avance introuvable.';
        errWrongParam: Label 'N° compte ou N° compte contre partie vide dans Paramètre Type Prêt & Avance.';
        success: Label 'Document validé avec succées.\Lignes insérées sur la Feuille de saisie O.D : %1 - %2';
        errDateMissing: Label 'La Date de validation du ducument ne peut pas être vide.';
        window: Dialog;
        errDoc: Label '%1 n''est pas un document valide. Des informations indispensables n''ont pas été mentionnées.';
        LA: Record "Loan & Advance";
        LoanAdvanceType: Record "Loan & Advance Type";
}

