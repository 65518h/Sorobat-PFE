report 50160 "List Loans & Advances"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ListLoansAdvances.rdlc';
    Caption = 'Prêts & Avances : Liste';
    //Dans Nav 2009 id"39001405"

    dataset
    {
        dataitem("Company Information"; "Company Information")
        {
            DataItemTableView = SORTING("Primary Key") ORDER(Ascending);
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Proposed_Loans___AdvancesCaption; Proposed_Loans___AdvancesCaptionLbl)
            {
            }
            column(Company_Information_Primary_Key; "Primary Key")
            {
            }
            dataitem("Loan & Advance"; "Loan & Advance")
            {
                DataItemTableView = SORTING(Type);
                RequestFilterFields = Type;
                column(FORMAT_TODAY_0_4__Control1120000; FORMAT(TODAY, 0, 4))
                {
                }
                column(CurrReport_PAGENO_Control1120001; CurrReport.PAGENO)
                {
                }
                column(COMPANYNAME; COMPANYNAME)
                {
                }
                column(Type_du_document_______FORMAT_Type_; 'Type du document : ' + FORMAT(Type))
                {
                }
                column(Loan___Advance__No__; "No.")
                {
                }
                column(Loan___Advance_Employee; Employee)
                {
                }
                column(Loan___Advance_Name; Name)
                {
                }
                column(Loan___Advance__Employee_Posting_Group_; "Employee Posting Group")
                {
                }
                column(Loan___Advance__Document_type_; "Document type")
                {
                }
                column(Loan___Advance_Amount; Amount)
                {
                }
                column(Loan___Advance__Interest___; "Interest %")
                {
                }
                column(Loan___Advance__Total_to_repay_; "Total to repay")
                {
                }
                column(Loan___Advance__Repayment_slices_; "Repayment slices")
                {
                }
                column(Loan___Advance__Montant_tranche_; "Montant tranche")
                {
                }
                column(TotalFor___FIELDCAPTION_Type_; TotalFor + FIELDCAPTION(Type))
                {
                }
                column(Loan___Advance_Amount_Control1180250041; Amount)
                {
                }
                column(Loan___Advance__Total_to_repay__Control1180250042; "Total to repay")
                {
                }
                column(Loan___Advance__Montant_tranche__Control1000000002; "Montant tranche")
                {
                }
                column(CurrReport_PAGENO_Control1120001Caption; CurrReport_PAGENO_Control1120001CaptionLbl)
                {
                }
                column(Proposed_Loans___AdvancesCaption_Control1120003; Proposed_Loans___AdvancesCaption_Control1120003Lbl)
                {
                }
                column(Loan___Advance__No__Caption; FIELDCAPTION("No."))
                {
                }
                column(Loan___Advance_EmployeeCaption; FIELDCAPTION(Employee))
                {
                }
                column(Loan___Advance_NameCaption; FIELDCAPTION(Name))
                {
                }
                column(Loan___Advance__Employee_Posting_Group_Caption; FIELDCAPTION("Employee Posting Group"))
                {
                }
                column(Loan___Advance__Document_type_Caption; FIELDCAPTION("Document type"))
                {
                }
                column(Loan___Advance_AmountCaption; FIELDCAPTION(Amount))
                {
                }
                column(Loan___Advance__Interest___Caption; FIELDCAPTION("Interest %"))
                {
                }
                column(Loan___Advance__Total_to_repay_Caption; FIELDCAPTION("Total to repay"))
                {
                }
                column(Loan___Advance__Repayment_slices_Caption; FIELDCAPTION("Repayment slices"))
                {
                }
                column(Loan___Advance__Montant_tranche_Caption; FIELDCAPTION("Montant tranche"))
                {
                }
                column(Loan___Advance_Type; Type)
                {
                }

                trigger OnPreDataItem()
                begin
                    LastFieldNo := FIELDNO(Type);
                end;
            }
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
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        TotalFor: Label 'Total ';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Proposed_Loans___AdvancesCaptionLbl: Label 'Prêts & Avances proposés';
        CurrReport_PAGENO_Control1120001CaptionLbl: Label 'Page';
        Proposed_Loans___AdvancesCaption_Control1120003Lbl: Label 'Prêts & Avances proposés';
}

