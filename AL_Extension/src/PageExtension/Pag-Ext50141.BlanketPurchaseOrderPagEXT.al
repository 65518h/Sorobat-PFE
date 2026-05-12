PageExtension 50141 "Blanket Purchase Order_PagEXT" extends "Blanket Purchase Order"
{

    layout
    {
        addafter("Buy-from Contact")
        {
            field("Job No."; Rec."Job No.")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        addafter(Print_Promoted)
        {
            actionref(Description1; Description)
            { }
        }

        addafter("Print")
        {
            action(Description)
            {
                Caption = 'Description';
                ApplicationArea = all;
                trigger OnAction()
                begin
                    CurrPage.PurchLines.PAGE.wShowDescription;
                end;
            }
            /* GL2024 action("&W")
              {
                  Caption = '&W';
                  ApplicationArea = all;
                  //DYS page addon non migrer
                  // RunObject = Page 8004213;
                  // RunPageLink = Type = CONST(509),
                  //                   "No." = FIELD("No.");
              }*/
        }
    }

    var
        PurchSetup: Record "Purchases & Payables Setup";
}