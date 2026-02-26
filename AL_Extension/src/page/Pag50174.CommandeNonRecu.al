Page 50174 "Commande Non Recu"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Purchase Line";
    SourceTableView = where("Document Type" = const(Order),
                            Type = const(Item),
                            Status = filter(<> Archived),
                            "Quantity Received" = filter(0));
    ApplicationArea = all;
    Caption = 'Commande Non Recu';
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                Editable = false;
                ShowCaption = false;
                field("Order Date"; REC."Order Date")
                {
                    ApplicationArea = all;
                }
                field("Document No."; REC."Document No.")
                {
                    ApplicationArea = all;
                }
                field("Nom Fournisseur"; REC."Nom Fournisseur")
                {
                    ApplicationArea = all;
                    Visible = true;
                }
                field("No."; REC."No.")
                {
                    ApplicationArea = all;
                }
                field(Description; REC.Description)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field(Quantity; REC.Quantity)
                {
                    ApplicationArea = all;
                }
                field("Quantity Received"; REC."Quantity Received")
                {
                    ApplicationArea = all;
                }
                field("Outstanding Quantity"; REC."Outstanding Quantity")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Archiver)
            {
                ApplicationArea = all;
                Caption = 'Archiver';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if not Confirm(Text001) then exit;
                    if PurchaseHeader.Get(PurchaseHeader."document type"::Order, REC."Document No.") then begin
                        PurchaseHeader.Status := PurchaseHeader.Status::Archived;
                        PurchaseHeader.Modify;
                    end;

                    PurchaseLine.SetRange("Document Type", PurchaseLine."document type"::Order);
                    PurchaseLine.SetRange("Document No.", REC."Document No.");
                    if PurchaseLine.FindFirst then
                        repeat
                            PurchaseLine.Status := PurchaseLine.Status::Archived;
                            PurchaseLine.Modify;
                        until PurchaseLine.Next = 0;
                end;
            }
        }
    }

    var
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        Choix: Text[30];
        Text001: label 'Voulez Vous Archiver Cette Commande ?';
}

