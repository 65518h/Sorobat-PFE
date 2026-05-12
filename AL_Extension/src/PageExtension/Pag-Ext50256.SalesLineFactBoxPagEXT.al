PageExtension 50256 "Sales Line FactBox_PagEXT" extends "Sales Line FactBox"
{
    layout
    {

        addafter(SalesLineDiscounts)
        {
            field("BOQ State"; wBOQState)
            {
                OptionCaption = ',  ,VARIABLE,RESULT,ERROR';
                ApplicationArea = All;
                trigger OnAssistEdit()
                BEGIN

                    //#8919
                    lMetre();
                    //#8919//
                end;
            }
        }
    }

    actions
    {


    }

    trigger OnAfterGetRecord()
    var

        lKOLookup: Boolean;
        lSalesHeader: Record "Sales Header";
    begin

        //#8919
        wMarked := FALSE;
        wShowExtendedText := FALSE;
        lSalesHeader.GET(rec."Document Type", rec."Document No.");
        gOneSubFormMgt.fLoadBOQ(lSalesHeader, wBOQMgt, wBOQLoad);
        gOneSubFormMgt.fCheckBOQLine(wBOQMgt, Rec, wBOQLoad, OkMetre, wBOQState);
        //#8919//

    end;

    PROCEDURE lMetre();
    BEGIN
        //#8919
        IF (Rec."Structure Line No." = 0) THEN BEGIN
            gOneSubFormMgt.fShowBOQ(wBOQMgt, Rec, wShowExtendedText, wMarked, wBOQLoad);
        END ELSE BEGIN
            gOneSubFormMgt.fShowStructureBOQ(Rec, wMarked);
        END;
        CurrPage.UPDATE;
        //#8919//
    END;

    var
        gOneSubFormMgt: Codeunit "NaviOne SubForm Management";
        OkMetre: Integer;
        wBOQMgt: Codeunit "BOQ Management";
        wBOQLoad: Boolean;
        wBOQState: option "",None,"Has Just Variables","Has Results","Has Errors";
        wMarked: Boolean;
        wShowExtendedText: Boolean;
}