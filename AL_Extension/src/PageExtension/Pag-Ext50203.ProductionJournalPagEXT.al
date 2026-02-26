PageExtension 50203 "Production Journal_PagEXT" extends "Production Journal"

{


    layout
    {
        modify("Location Code")
        {
            Visible = true;
        }
        addafter("Location Code")
        {
            field("Sous Affectation Marche"; Rec."Sous Affectation Marche")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        modify(Post)
        {
            trigger OnBeforeAction()

            VAR
                ProductionOrder: Record "Production Order";
                DocNo: Code[20];
            begin
                //>> HJ SORO 20-08-15
                DocNo := rec."Document No.";
                IF ManufacturingSetup.GET THEN;
                //>> HJ SORO 20-08-15

            end;

            trigger OnAfterAction()
            VAR
                ProductionOrder: Record "Production Order";
                DocNo: Code[20];
            begin
                //>> HJ SORO 20-08-15
                ProductionOrder.GET(ProductionOrder.Status::Released, DocNo);
                ProdOrder2.COPY(ProductionOrder);
                ProdOrderStatusManagement.ChangeProdOrderStatus(ProductionOrder, 4, rec."Posting Date", TRUE);
                //DYS fonction modifier dans BC
                //ProdOrderStatusManagement.ChangeStatusOnProdOrder(ProductionOrder, 4, rec."Posting Date", TRUE);

                //>> HJ SORO 20-08-15
            end;
        }
    }
    var
        ProdOrderStatusManagement: Codeunit "Prod. Order Status Management";
        ProdOrder2: Record "Production Order";
        ManufacturingSetup: Record "Manufacturing Setup";
}
