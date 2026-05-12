PageExtension 50221 "Transfer Orders_PagEXT" extends "Transfer Orders"

//GL2024 table dans Nav2009 "Transfer List" id 5742
{
    layout
    {
        addafter("No.")
        {
            field("Last Shipment No."; Rec."Last Shipment No.")
            {
                ApplicationArea = all;
            }


        }
        modify("In-Transit Code")
        {
            Visible = false;
        }
        modify("Shipment Date")
        {
            Visible = true;
        }
        addafter("Shipping Agent Code")
        {
            field("External Document No."; Rec."External Document No.")
            {
                ApplicationArea = all;
            }
        }

        modify("Receipt Date")
        {
            Visible = true;
        }
    }

    actions
    {

    }


    trigger OnOpenPage()
    begin
        // Filtrer pour n'afficher que les lignes 
        Rec.SetRange(Filtre, false);
    end;

    trigger OnAfterGetRecord()
    begin
        // Filtrer pour n'afficher que les lignes 
        Rec.SetRange(Filtre, false);
    end;

    trigger OnAfterGetCurrRecord()
    begin
        // Filtrer pour n'afficher que les lignes 
        Rec.SetRange(Filtre, false);
    end;

}