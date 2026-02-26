PageExtension 50184 "Purchase List Archive_PagEXT" extends "Purchase List Archive"

{
    layout
    {
        addafter("Archived By")
        {
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = all;
            }
            field("Remarque de Livrison"; Rec."Remarque de Livrison")
            {
                ApplicationArea = all;
            }
            field(Amount; Rec.Amount)
            {
                ApplicationArea = all;
            }
            field("Job No."; Rec."Job No.")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        addafter("&Line")
        {
            action("Imprimer")
            {
                Caption = 'Imprimer';
                ApplicationArea = All;
                Image = Print;
                trigger OnAction()
                var

                begin

                    // >> HJ DSFT 10-10-2012
                    RecPurchaseOrder.SETRANGE("Document Type", rec."Document Type");
                    RecPurchaseOrder.SETRANGE("No.", rec."No.");
                    REPORT.RUNMODAL(REPORT::"BON COMMANDE SOUROUBAT ARCHIVE", TRUE, TRUE, RecPurchaseOrder);
                    // >> HJ DSFT 10-10-2012
                    // STD HJ DSFT 10-10-2012 DocPrint.PrintPurchHeader(Rec);
                end;
            }
        }
    }
    trigger OnOpenPage()
    VAR
        lMaskMgt: Codeunit "Mask Management";
    BEGIN
        //MASK
        lMaskMgt.PurchaseHeaderArchive(Rec);
        //MASK//


    end;

    var
        DocPrint: Codeunit 229;
        RecPurchaseOrder: Record 5109;
}