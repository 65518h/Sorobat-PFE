report 50063 "Monadat Minute"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/MonadatMinute.rdlc';

    dataset
    {
        dataitem("Payment Line"; 10866)
        {
            column(Payment_Line__Nom_Benificiaire_; "Nom Benificiaire")
            {
            }
            column(Payment_Line__Credit_Amount_; "Credit Amount")
            {
            }
            column(STR; STR)
            {
            }
            column(SOROUBATCaption; SOROUBATCaptionLbl)
            {
            }
            column(Payment_Line_No_; "No.")
            {
            }
            column(Payment_Line_Line_No_; "Line No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                STR := '';
                TOT := ROUND("Payment Line"."Credit Amount", 0.001);
                //Convert."Montant en texte"(STR,"Payment Line"."Debit Amount");
                Convert."Montant en texte"(STR, TOT);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Convert: Codeunit 50005;
        STR: Text[250];
        TOT: Decimal;
        SOROUBATCaptionLbl: Label 'SOROUBAT';
}

