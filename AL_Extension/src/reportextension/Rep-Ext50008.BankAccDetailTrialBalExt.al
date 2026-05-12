reportextension 50008 "Bank Acc.Detail Trial Bal.Ext" extends "Bank Acc. - Detail Trial Bal."
{
    //GL2024  Report=1404
    //GL2024    RDLCLayout = './Layouts/DocumentsBureauDordreCopy.rdlc';
    dataset
    {
        add("Bank Account")
        {
            column(CurrReport_OBJECTID_FALSE_; CurrReport.OBJECTID(FALSE))
            {
            }
            column(CodeJourrnal_; CodeJourrnal)
            {
            }
            column(Montantcredit_; Montantcredit)
            {
            }
            column(Montantdebit_; Montantdebit)
            {
            }





        }
        add("Bank Account Ledger Entry")
        {
            column(SourceCode_; "Source Code")
            {
            }
            column(Bank_Account_Ledger_Entry__Debit_Amount_; "Debit Amount")
            {
            }
            column(Bank_Account_Ledger_Entry__Credit_Amount_; "Credit Amount")
            {
            }
        }

        add(Integer)
        {
            column(Bank_Account__Name; "Bank Account".Name)
            {
            }
            column(Bank_Account_Ledger_Entry___Debit_Amount_; "Bank Account Ledger Entry"."Debit Amount")
            {
            }
            column(StartBalanceLCY____Bank_Account_Ledger_Entry___Amount__LCY___Control55; StartBalanceLCY + "Bank Account Ledger Entry"."Amount (LCY)")
            {
                AutoFormatType = 1;
            }
            column(Bank_Account_Ledger_Entry___Credit_Amount_; "Bank Account Ledger Entry"."Credit Amount")
            {
            }
        }

    }

    requestpage
    {

    }

    rendering
    {
        /*GL2024  layout(LayoutName)
          {
              Type = RDLC;
              LayoutFile = 'mylayout.rdl';
          }*/
    }


    var
        CodeJourrnal: label 'Code journal';
        Montantdebit: label 'Montant Débit';
        Montantcredit: label 'Monatant Crédit';
        téléphone: Label 'N° téléphone';


}