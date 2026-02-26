PageExtension 50143 "Item Disc. Groups_PagEXT" extends "Item Disc. Groups"
{

    layout
    {

    }

    actions
    {
        addafter(Category_Report)
        {
            actionref("Purchases &Line Discounts1"; "Purchases &Line Discounts")
            {

            }
        }
        addafter("Sales &Line Discounts")
        {
            action("Purchases &Line Discounts")
            {
                Caption = 'Purchases &Line Discounts';
                ApplicationArea = all;
                RunObject = page "Purchase Line Discounts";
                RunPageLink = Type = CONST("Item Disc. Group")/*GL2024, Code = FIELD(Code)*/;
                RunPageView = SORTING(Type/*GL2024, Code*/);
            }
            separator(separator100)
            {

            }
            /* GL2024  action("&Calculation Standard Cost / Public Price and Discount")
               {
                   Caption = '&Calculation Standard Cost / Public Price and Discount';
                   ApplicationArea = all;
                   trigger OnAction()
                   VAR
                       lRec: Record "Item Discount Group";
                   BEGIN

                       lRec.COPY(Rec);
                       lRec.SETRECFILTER;
                       //DYS REPORT addon non migrer
                       //REPORT.RUNMODAL(REPORT::"Standard Cost Calculate /Disc.", TRUE, FALSE, lRec);
                   END;
               }*/
        }
    }


}