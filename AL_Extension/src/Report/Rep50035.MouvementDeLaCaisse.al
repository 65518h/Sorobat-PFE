report 50035 "Mouvement De La Caisse"
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/MouvementDeLaCaisse.rdlc';

    // ApplicationArea = all;
    // UsageCategory = ReportsAndAnalysis;

    // dataset
    // {
    //     dataitem("Payment Line"; 10866)
    //     {
    //         DataItemTableView = SORTING("Code Opération", Benificiaire);
    //         RequestFilterFields = "Code Opération";
    //         column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
    //         {
    //         }
    //         column(COMPANYNAME; COMPANYNAME)
    //         {
    //         }
    //         column(CurrReport_PAGENO; CurrReport.PAGENO)
    //         {
    //         }
    //         column(USERID; USERID)
    //         {
    //         }
    //         column("Payment_Line_Libellé"; Libellé)
    //         {
    //         }
    //         column(Payment_Line__Numero_Seq_; "Numero Seq")
    //         {
    //         }
    //         column("Payment_Line_Opération"; Opération)
    //         {
    //         }
    //         column("Payment_Line_Libellé_Control1000000017"; Libellé)
    //         {
    //         }
    //         column(Payment_Line__Debit_Amount_; "Debit Amount")
    //         {
    //         }
    //         column(Payment_Line__Credit_Amount_; "Credit Amount")
    //         {
    //         }
    //         column(Payment_Line__Nom_Pris_En_Charge_; "Nom Pris En Charge")
    //         {
    //         }
    //         column(Payment_Line__Due_Date_; "Due Date")
    //         {
    //         }
    //         column("Total_Opération__________Libellé"; 'Total Opération' + '  ' + Libellé)
    //         {
    //         }
    //         column(Payment_Line__Credit_Amount__Control1000000008; "Credit Amount")
    //         {
    //         }
    //         column(Payment_Line__Debit_Amount__Control1000000010; "Debit Amount")
    //         {
    //         }
    //         column(Payment_Line__Debit_Amount__Control1000000032; "Debit Amount")
    //         {
    //         }
    //         column(Payment_Line__Credit_Amount__Control1000000033; "Credit Amount")
    //         {
    //         }
    //         column(Payment_LineCaption; Payment_LineCaptionLbl)
    //         {
    //         }
    //         column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
    //         {
    //         }
    //         column(Payment_Line__Numero_Seq_Caption; FIELDCAPTION("Numero Seq"))
    //         {
    //         }
    //         column("Payment_Line_OpérationCaption"; FIELDCAPTION(Opération))
    //         {
    //         }
    //         column("Payment_Line_Libellé_Control1000000017Caption"; FIELDCAPTION(Libellé))
    //         {
    //         }
    //         column(Payment_Line__Debit_Amount_Caption; FIELDCAPTION("Debit Amount"))
    //         {
    //         }
    //         column(Payment_Line__Credit_Amount_Caption; FIELDCAPTION("Credit Amount"))
    //         {
    //         }
    //         column(Payment_Line__Nom_Pris_En_Charge_Caption; FIELDCAPTION("Nom Pris En Charge"))
    //         {
    //         }
    //         column(Payment_Line__Due_Date_Caption; FIELDCAPTION("Due Date"))
    //         {
    //         }
    //         column("OpérationCaption"; OpérationCaptionLbl)
    //         {
    //         }
    //         column(Payment_Line_No_; "No.")
    //         {
    //         }
    //         column(Payment_Line_Line_No_; "Line No.")
    //         {
    //         }
    //         column("Payment_Line_Code_Opération"; "Code Opération")
    //         {
    //         }

    //         trigger OnPreDataItem()
    //         begin
    //             LastFieldNo := FIELDNO("Code Opération");
    //         end;
    //     }
    // }

    // requestpage
    // {

    //     layout
    //     {
    //     }

    //     actions
    //     {
    //     }
    // }

    // labels
    // {
    // }

    // var
    //     LastFieldNo: Integer;
    //     FooterPrinted: Boolean;
    //     TotalFor: Label 'Total ';
    //     Payment_LineCaptionLbl: Label 'Ligne bordereau';
    //     CurrReport_PAGENOCaptionLbl: Label 'Page';
    //     "OpérationCaptionLbl": Label 'Opération';
}

