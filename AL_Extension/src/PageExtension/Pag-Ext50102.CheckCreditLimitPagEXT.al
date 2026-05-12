PageExtension 50102 "Check Credit Limit_PagEXT" extends "Check Credit Limit"
{
    layout
    {

    }
    actions
    {

    }

    PROCEDURE ContactShowWarning(pContact: Record Contact) retour: Boolean;
    VAR
        lCust: Record Customer;
        lContBusRel: Record "Contact Business Relation";
    BEGIN
        //#6658
        SalesSetup.GET;
        IF (SalesSetup."Credit Warnings" =
            SalesSetup."Credit Warnings"::"No Warning") THEN
            EXIT(FALSE);
        //#6658//
        retour := FALSE;
        // recherche du client par le contact business relation
        lContBusRel.SETRANGE("Contact No.", pContact."No.");
        lContBusRel.SETRANGE("Link to Table", lContBusRel."Link to Table"::Customer);
        IF (NOT lContBusRel.ISEMPTY()) THEN BEGIN
            lContBusRel.FIND('-');
            IF (lCust.GET(lContBusRel."No.")) THEN BEGIN
                lCust.CALCFIELDS(lCust."Outstanding Orders (LCY)", lCust."Shipped Not Invoiced (LCY)");
                //#6658
                retour := ShowWarning(lCust."No.", 0, 0, TRUE);
                //retour := ShowWarning(lCust."No.", lCust."Outstanding Orders (LCY)" + lCust."Shipped Not Invoiced (LCY)", 0, TRUE);
                //#6658//
            END;
        END;
    END;

    PROCEDURE fSetCalcBalanceDue(pCalcBalanceDue: Boolean);
    BEGIN
        //#6658
        wBalanceDueCalc := pCalcBalanceDue;
        //#6658//
    END;

    PROCEDURE fGetCalcBalanceDue() Retour: Boolean;
    BEGIN
        //#6658
        Retour := wBalanceDueCalc
        //#6658//
    END;

    PROCEDURE fSetDayNumber(pDayNumber: Integer);
    BEGIN
        //#6658
        wDayNumber := pDayNumber;
        //#6658//
    END;

    PROCEDURE fGetDayNumber() retour: Integer;
    BEGIN
        //#6658
        retour := wDayNumber;
        //#6658//
    END;


    trigger OnOpenPage()
    var
    begin
        //#6658
        wBalanceDueCalc := FALSE;
        //#6658//
    end;

    var
        wBalanceDueCalc: Boolean;
        wDayNumber: Integer;
        gAddOnLicencePermission: Codeunit IntegrManagement;
}

