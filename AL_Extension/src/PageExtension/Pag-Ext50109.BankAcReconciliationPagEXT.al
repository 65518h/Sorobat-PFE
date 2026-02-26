PageExtension 50109 "Bank Ac. Reconciliation_PagEXT" extends "Bank Acc. Reconciliation"
{
    //GL2024  SourceTableView=WHERE(Bank Type=CONST(" "));
    layout
    {
        modify(BankAccountNo)
        {
            trigger OnAfterValidate()
            VAR
                lBankAccount: Record "Bank Account";
            BEGIN

                //+PMT+PAYMENT
                lBankAccount.GET(rec."Bank Account No.");
                lBankAccount.TESTFIELD("Bank Type", rec."Bank Type"::" ");
                //+PMT+PAYMENT//

            end;

            trigger OnLookup(var Text: Text): Boolean
            VAR
                lBankAccount: Record "Bank Account";
            BEGIN

                //+PMT+PAYMENT
                lBankAccount.FILTERGROUP(10);
                lBankAccount.SETRANGE("Bank Type", rec."Bank Type"::" ");
                lBankAccount.FILTERGROUP(0);
                IF PAGE.RUNMODAL(PAGE::"Bank Account List", lBankAccount) = ACTION::LookupOK THEN
                    rec.VALIDATE("Bank Account No.", lBankAccount."No.");
                //+PMT+PAYMENT//

            end;
        }

        modify(StatementDate)
        {
            trigger OnAfterValidate()

            BEGIN
                // rec.SETFILTER("Filtre Date", '..' + FORMAT(rec."Statement Date"));
                // rec.CALCFIELDS("Solde Comptable");

            end;
        }

        addafter(StatementEndingBalance)
        {
            /*  field("Solde Comptable"; Rec."Solde Comptable")
              {
                  ApplicationArea = all;
              }
              field("Solde Bancaire"; Rec."Solde Bancaire")
              {
                  ApplicationArea = all;
              }
              field(Ecart; Rec."Solde Comptable" - (Rec."Solde Bancaire" + Rec."Statement Ending Balance"))
              {
                  ApplicationArea = all;
                  Caption = 'Ecart';
              }
              field("Nom Banque"; Rec."Nom Banque")
              {
                  ApplicationArea = all;
              }*/
            field("Statement Date"; Rec."Statement Date")
            {
                ApplicationArea = all;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        /*  IF rec."Statement Date" <> 0D THEN BEGIN
              rec.SETFILTER("Filtre Date", '..' + FORMAT(rec."Statement Date"));
              rec.CALCFIELDS("Solde Comptable", "Solde Bancaire");
          END;*/
    end;

    trigger OnOpenPage()
    VAR
        cdu1220: Codeunit 1220;

    begin
        Rec.FilterGroup(0);

        Rec.Setrange("Bank Type", rec."Bank Type"::" ");
        Rec.FilterGroup(2);
    end;
}