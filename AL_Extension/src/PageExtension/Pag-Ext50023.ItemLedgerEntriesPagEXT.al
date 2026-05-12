PageExtension 50023 "Item Ledger Entries_PagEXT" extends "Item Ledger Entries"
{
    layout
    {
        modify("Entry No.")
        {
            visible = false;
        }
        addbefore("Posting Date")
        {
            field("Entry No.2"; Rec."Entry No.")
            {
                ApplicationArea = all;
                Editable = FALSE;
            }
        }
        addafter("Item No.")
        {
            field("Designation Article"; Rec."Designation Article")
            {
                ApplicationArea = all;
            }
            field("Numero Commande"; Rec."Numero Commande")
            {
                ApplicationArea = all;
            }
            field("External Document No."; Rec."External Document No.")
            {
                ApplicationArea = all;
            }
            field("Sous Affectation Marche"; Rec."Sous Affectation Marche")
            {
                ApplicationArea = all;
            }
            field("Qty. per Unit of Measure2"; Rec."Qty. per Unit of Measure")
            {
                ApplicationArea = all;
            }
            field("Unit of Measure Code2"; Rec."Unit of Measure Code")
            {
                ApplicationArea = all;
            }
        }

        addafter(Description)
        {
            /* field(Emplacement; Rec.Emplacement) 
             {
                 ApplicationArea = all;
             }*/
            field("Source Type2"; Rec."Source Type")
            {
                ApplicationArea = all;
            }
            field("Source No.2"; Rec."Source No.")
            {
                ApplicationArea = all;
            }

        }
        addafter("Expiration Date")
        {
            field("N° Véhicule"; Rec."N° Véhicule")
            {
                ApplicationArea = all;
            }
        }


    }

}



