PageExtension 50059 "Posted Sales Shipment_PagEXT" extends "Posted Sales Shipment"
{
    layout
    {
        addafter("Responsibility Center")
        {
            field("Job No."; Rec."Job No.")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Date Debut Decompte"; Rec."Date Debut Decompte")
            {
                ApplicationArea = all;

            }
            field("Date Fin Decompte"; Rec."Date Fin Decompte")
            {
                ApplicationArea = all;
            }
        }


        addafter("Shortcut Dimension 2 Code")
        {
            field("No. Printed2"; Rec."No. Printed")
            {
                ApplicationArea = all;
            }
            field("Total Decompte"; Rec."Total Decompte")
            {
                ApplicationArea = all;
            }
        }

        // modify(SalesShipmLines)
        // {
        //     //DYS problème version AL
        //     //Editable = false;
        // }
    }
    actions
    {
        modify("&Print")
        {
            Visible = true;
        }
        addafter("&Print")
        {
            action("&Print2")
            {
                ApplicationArea = all;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Visible = false;
                ToolTip = 'Print the shipping notice.';

                trigger OnAction()
                var
                    SalesShptHeader: Record "Sales Shipment Header";
                begin

                    SalesShptHeader.SETRANGE("No.", rec."No.");
                    REPORT.RUNMODAL(REPORT::"Monadat Minute", TRUE, TRUE, SalesShptHeader);
                end;
            }
        }
        addafter("&Print_Promoted")
        {
            actionref("&Print21"; "&Print2")
            {

            }
            actionref("&Print format A41"; "&Print format A4")
            {

            }
        }
        addafter("&Navigate")
        {
            action("&Print format A4")
            {
                ApplicationArea = all;
                Caption = 'Print format A4';
                Ellipsis = true;
                Image = Print;


                trigger OnAction()
                var
                    SalesShptHeader: Record "Sales Shipment Header";
                begin

                    // >> HJ DSFT 10-10-2012 

                    SalesShptHeader.SETRANGE("No.", rec."No.");
                    REPORT.RUNMODAL(REPORT::"BL enregistré A4", TRUE, TRUE, SalesShptHeader);

                end;
            }
        }

    }

    trigger OnOpenPage()
    VAR
        lMaskMgt: Codeunit "Mask Management";
    begin
        //MASK
        lMaskMgt.SalesShipHeader(Rec);
        //MASK//
    end;
}

