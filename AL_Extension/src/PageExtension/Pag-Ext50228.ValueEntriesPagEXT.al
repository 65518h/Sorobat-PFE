PageExtension 50228 "Value Entries_PagEXT" extends "Value Entries"
{
    layout
    {
        addafter("Cost Amount (Actual)")
        {
            field("Job Cost"; rec."Job Cost")
            {
                ApplicationArea = all;
                Visible = false;
            }
        }
        addafter("Cost per Unit")
        {
            field("Job Quantity"; rec."Job Quantity")
            {
                ApplicationArea = all;
                Visible = false;
            }
        }
    }

    var
        wCostperUnit: Decimal;

    trigger OnAfterGetRecord()
    begin

        //COUT
        IF (rec."Cost Amount (Actual)" <> 0) AND (rec."Invoiced Quantity" <> 0) THEN
            wCostperUnit := rec."Cost Amount (Actual)" / rec."Invoiced Quantity"
        //#8877
        /*
        {DELETE
        ELSE
          IF ("Job Quantity" <> 0) THEN
            wCostperUnit := "Job Cost" / "Job Quantity"
        DELETE}*/
        //#8877//
        ELSE
            wCostperUnit := 0;
        //COUT//

    end;


}

