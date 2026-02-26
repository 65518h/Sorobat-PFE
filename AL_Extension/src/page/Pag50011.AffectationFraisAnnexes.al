Page 50011 "Affectation Frais Annexes"
{
    Editable = false;
    PageType = ListPart;
    SourceTable = "Item Charge Assignment (Purch)";
    Caption = 'Affectation Frais Annexes';
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Type Frais"; rec."Type Frais")
                {
                    ApplicationArea = all;
                }
                field("Item Charge No."; rec."Item Charge No.")
                {
                    ApplicationArea = all;
                }
                field("Qty. to Assign"; rec."Qty. to Assign")
                {
                    ApplicationArea = all;
                }
                field("Qty. Assigned"; rec."Qty. Assigned")
                {
                    ApplicationArea = all;
                }
                field("Amount to Assign"; rec."Amount to Assign")
                {
                    ApplicationArea = all;
                }
                field("Applies-to Doc. Type"; rec."Applies-to Doc. Type")
                {
                    ApplicationArea = all;
                }
                field("Montant associé"; rec."Montant associé")
                {
                    ApplicationArea = all;
                }
                field("Code devise"; rec."Code devise")
                {
                    ApplicationArea = all;
                }
                field("Facteur Devise"; rec."Facteur Devise")
                {
                    ApplicationArea = all;
                }
                field("Montant associé DS"; rec."Montant associé DS")
                {
                    ApplicationArea = all;
                }
                field("Source Type"; rec."Source Type")
                {
                    ApplicationArea = all;
                }
                field("Source No."; rec."Source No.")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

