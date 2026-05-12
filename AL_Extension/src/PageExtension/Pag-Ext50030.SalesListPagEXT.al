PageExtension 50030 "Sales List_PagEXT" extends "Sales List"
{
    /*GL2024 SourceTableView=SORTING("Order Type","Document Type","No.","Invoicing Method",Finished)
                       WHERE(Finished=CONST(No),
                             "Document Type"=FILTER(Order|Invoice|"Return Orderr"),
                             "Order Type"=FILTER(<>"Supply Order"));*/

    layout
    {


        addafter("No.")
        {
            field("Job No."; rec."Job No.")
            {
                ApplicationArea = all;
            }
            field("<Ship-to Name2>"; rec."Ship-to Name")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field(Subject; rec.Subject)
            {
                ApplicationArea = all;
            }
        }
        addafter("Sell-to Customer Name")
        {
            field("<Document Date2>"; rec."Document Date")
            {
                ApplicationArea = all;
            }
            field(Amount; rec.Amount)
            {
                ApplicationArea = all;
            }
            field("Amount Including VAT"; rec."Amount Including VAT")
            {
                ApplicationArea = all;
            }
        }
        modify("External Document No.")
        {
            Visible = false;
        }
        addafter("Ship-to Name")
        {
            field("Ship-to Address"; rec."Ship-to Address")
            {
                ApplicationArea = all;
            }
        }
        addafter("Ship-to Post Code")
        {
            field("Ship-to City"; rec."Ship-to City")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {


        //Code Modification on "Card"(Action 20).OnAction".

    }

    trigger OnOpenPage()
    VAR
        lMaskMgt: Codeunit "Mask Management";
    BEGIN
        /*GL2024  SourceTableView=SORTING(Order Type,Document Type,No.,Invoicing Method,Finished)
                            WHERE(Finished=CONST(No),
                                  Document Type=FILTER(Order|Invoice|Return Order),
                                  Order Type=FILTER(<>Supply Order));*/
        Rec.FilterGroup(0);
        //   rec.SetCurrentKey("Order Type", "Document Type", "No.", "Invoicing Method", Finished);
        Rec.SetRange(Finished, false);
        // Rec.SetFilter("Document Type", '%1|%2|%3', Rec."Document Type"::Order, Rec."Document Type"::Invoice, Rec."Document Type"::"Return Order");
        // Rec.SetFilter("Order Type", '<>%1', Rec."Order Type"::"Supply Order");
        Rec.FilterGroup(2);
        //MASK
        lMaskMgt.SalesHeader(Rec);
        //MASK//

    end;


}

