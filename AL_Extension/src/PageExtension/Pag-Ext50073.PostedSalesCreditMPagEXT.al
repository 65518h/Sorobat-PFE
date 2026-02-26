PageExtension 50073 "Posted Sales Credit M_PagEXT" extends "Posted Sales Credit Memos"
{

    layout
    {
        addafter("Sell-to Customer Name")
        {
            field("Posting Description"; Rec."Posting Description")
            {
                ApplicationArea = all;
            }
            field("User ID"; Rec."User ID")
            {
                ApplicationArea = all;
            }
            field("On Hold"; Rec."On Hold")
            {
                ApplicationArea = all;
            }
            field("Job No."; Rec."Job No.")
            {
                ApplicationArea = all;
            }
        }

        addafter("Applies-to Doc. Type")
        {
            field("Reverse Prepmt. Inv. No."; Rec."Reverse Prepmt. Inv. No.")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        modify("&Print")
        {
            Visible = false;
        }
        addafter("&Print")
        {
            action("&Print2")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Print';
                Ellipsis = true;
                Image = Print;


                trigger OnAction()
                var

                    lSalesInvoiceHeader: Record "Sales Invoice Header";
                begin

                    //+REF+DOCUMENT
                    //CurrForm.SETSELECTIONFILTER(SalesCrMemoHeader);
                    //SalesCrMemoHeader.PrintRecords(TRUE);
                    lSalesInvoiceHeader.SETRANGE("No.", rec."No.");
                    lSalesInvoiceHeader.SETRANGE("Print Document Type", lSalesInvoiceHeader."Print Document Type"::"Posted Credit Memo");
                    lSalesInvoiceHeader.PrintRecords(TRUE);
                    //+REF+DOCUMENT//

                end;
            }
        }
        addafter("&Print_Promoted")
        {
            actionref("&Print21"; "&Print2")
            {

            }
        }
    }

}



