PageExtension 50139 "Blanket Sales Order_PagEXT" extends "Blanket Sales Order"
{

    layout
    {
        addafter(Status)
        {
            field("Job No."; Rec."Job No.")
            {
                ApplicationArea = all;
            }
        }
        addafter("VAT Bus. Posting Group")
        {
            field("Posting Description"; Rec."Posting Description")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        addafter("Print")
        {
            action(Description)
            {
                Caption = 'Description';
                ApplicationArea = all;
                trigger OnAction()
                begin

                    Currpage.SalesLines.page.wShowDescription;
                end;
            }
        }
        addafter(Print_Promoted)
        {
            actionref(Description1; Description)
            {

            }
        }

    }

    var
        SalesSetup: Record "Sales & Receivables Setup";
}