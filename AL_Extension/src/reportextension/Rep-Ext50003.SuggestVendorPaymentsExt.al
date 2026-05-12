reportextension 50003 "Suggest Vendor Payments Ext" extends "Suggest Vendor Payments"
{
    dataset
    {

    }

    requestpage
    {

    }

    rendering
    {

    }
    procedure wSetAutomaticPayment()
    begin

        IF ISSERVICETIER THEN BEGIN
            PagewSetAutomaticPayment;
        END ELSE BEGIN
            //+PMT+PAYMENT
            //      SummarizePerVend := TRUE;
            //GL2024   RequestOptionsForm.wFldSummarizePerVendor.EDITABLE := FALSE;
            //+PMT+PAYMENT//
        END;


    end;


    procedure PagewSetAutomaticPayment()
    begin


        //+PMT+PAYMENT
        //    SummarizePerVend := TRUE;
        //TRS-2009
        wFldSummarizePerVendorEditable := FALSE;
        //GL2024     IF (NOT ISSERVICETIER) THEN
        //GL2024    RequestOptionsForm.wFldSummarizePerVendor.EDITABLE := FALSE;
        //TRS-2009/
        //+PMT+PAYMENT//

    end;

    var

        wFldSummarizePerVendorEditable: Boolean;


    //    SummarizePerVend: Boolean;

}