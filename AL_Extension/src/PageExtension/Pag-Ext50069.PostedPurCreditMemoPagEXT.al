PageExtension 50069 "Posted Pur. Credit Memo_PagEXT" extends "Posted Purchase Credit Memo"
{
    layout
    {
        modify("No. Printed")
        {
            visible = false;
        }

        addafter("Responsibility Center")
        {
            field("Job No."; Rec."Job No.")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Applies-to Doc. No.2"; Rec."Applies-to Doc. No.")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }

        addafter("Applies-to Doc. No.")
        {
            field("Subscription Starting Date"; Rec."Subscription Starting Date")
            {
                ApplicationArea = all;
            }
            field("Subscription End Date"; Rec."Subscription End Date")
            {
                ApplicationArea = all;
            }
            field("No. Printed2"; Rec."No. Printed")
            {
                ApplicationArea = all;
            }
        }

    }
    actions
    {
        //GL2024 addafter(IncomingDocument)
        // {
        //     action("Wor&Kflow")
        //     {
        //         Caption = 'Wor&Kflow';
        //         ApplicationArea = all;
        //         //DYS page addon non migrer
        //         // RunObject = Page 8004213;
        //         // RunPageLink = Type = CONST(140),
        //         //                   "No." = FIELD("No.");
        //     }
        // }
    }

}


