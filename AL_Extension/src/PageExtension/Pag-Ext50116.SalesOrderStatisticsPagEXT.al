PageExtension 50116 "Sales Order Statistics_PagEXT" extends "Sales Order Statistics"
{

    layout
    {


    }

    actions
    {

    }
    trigger OnOpenPage()
    VAR
        lOverhead: Codeunit "Overhead Calculation";
    begin
        //#7842
        lOverhead.CopyToSalesDoc(Rec);
        //#7842//
    end;


}
