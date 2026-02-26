PageExtension 50176 "Opportunity Card_PagEXT" extends "Opportunity Card"

{
    layout
    {
        addafter("Contact Name")
        {
            field("Responsibility Center"; Rec."Responsibility Center")
            {
                ApplicationArea = all;
            }
            field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
            {
                ApplicationArea = all;
            }
            field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        addafter("Co&mments")
        {
            action("A&xes analytiques")
            {
                Caption = 'Dimensions';
                ApplicationArea = all;
                trigger OnAction()
                begin
                    Rec.fShowDocDim;
                end;
            }
        }
        addafter("Co&mments_Promoted")
        {
            actionref("A&xes analytiques1"; "A&xes analytiques")
            {

            }
        }
    }


    trigger OnOpenPage()
    begin
        //+REF+OPPORT
        IF gUserMgt.GetSalesFilter() <> '' THEN BEGIN
            rec.FILTERGROUP(2);
            rec.SETRANGE("Responsibility Center", gUserMgt.GetSalesFilter());
            rec.FILTERGROUP(0);
        END;
        //+REF+OPPORT//
    end;

    var
        gUserMgt: Codeunit "User Setup Management";
}