PageExtension 50250 "Available Credit_PagEXT" extends "Available Credit"
{
    layout
    {
        addafter("Outstanding Serv.Invoices(LCY)")
        {
            field("Payments not Due (LCY)"; rec."Payments not Due (LCY)")
            {
                ApplicationArea = all;
            }
        }
    }



    trigger OnAfterGetRecord()
    VAR
        lPaymentFormIntegration: Codeunit "Payment Form Integration";
    begin

        IF gAddOnLicencePermission.HasPermissionPMT() THEN
            lPaymentFormIntegration.CUSTUpdTotalAmountLCY(Rec, rec.GetTotalAmountLCYUI());
        //wInitDueDateFilter;
        //CALCFIELDS("Payments not Due (LCY)");
        //TotalAmountLCY := TotalAmountLCY + "Payments not Due (LCY)";
        //+PMT+PAYMENT//
    end;


    var
        gAddOnLicencePermission: Codeunit IntegrManagement;


}

