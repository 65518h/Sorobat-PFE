pageextension 50308 "Purchase Order Statistics" extends "Purchase Order Statistics"
{
    layout
    {
        modify("VATAmount[1]")
        {
            Editable = false;
        }
        modify("VATAmount_Invoicing")
        {
            Editable = false;
        }
        // Add changes to page layout here 
        addafter(Invoicing)
        {
            // part(SubForm; "VAT Specification Subform")
            // {
            //     ApplicationArea = Basic, Suite;
            // }
        }
    }
    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
        pagefef: page 161;
}