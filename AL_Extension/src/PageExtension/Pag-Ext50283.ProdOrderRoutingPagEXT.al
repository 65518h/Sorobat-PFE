PageExtension 50283 "Prod. Order Routing_PagEXT" extends "Prod. Order Routing"
{

    layout
    {
        modify("Prod. Order No.")
        {
            Visible = "Prod. Order No.VISIBLE";
        }
    }

    actions
    {

    }

    trigger OnOpenPage()
    VAR
        lClassicVisible: Boolean;
    begin

        //#RTC - 2009
        lClassicVisible := TRUE;
        "Prod. Order No.VISIBLE" := lClassicVisible;
        IF rec.GETFILTER("Prod. Order No.") <> '' THEN BEGIN
            lClassicVisible := rec.GETRANGEMIN("Prod. Order No.") <> rec.GETRANGEMAX("Prod. Order No.");
            "Prod. Order No.VISIBLE" := lClassicVisible;
        END;
        //#RTC - 2009//

    end;

    var
        "Prod. Order No.VISIBLE": Boolean;
}