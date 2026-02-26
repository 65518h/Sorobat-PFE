reportextension 50004 "Detail Trial Balance" extends "Detail Trial Balance"
{
    // RDLCLayout = './Layouts/DetailTrialBalanceCopy.rdlc';
    dataset
    {
        addlast("G/L Entry")
        {
            // Add changes to the dataset here
            dataitem(Integer; Integer)
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                DataItemLinkReference = PageCounter;
                trigger OnPreDataItem()
                var
                    fefef: Report 104;
                begin
                    //REF+REPORT
                    IF ("G/L Entry"."Debit Amount" = 0) AND
                       ("G/L Entry"."Credit Amount" = 0)
                    THEN
                        CurrReport.BREAK;
                    //REF+REPORT//
                end;
            }
        }
        // modify(PageCounter)
        // {
        //     trigger OnAfterPreDataItem()

        //     // Add changes to the dataset here
        // }
    }

    requestpage
    {
        // Add changes to the requestpage here
    }

    rendering
    {

    }
}