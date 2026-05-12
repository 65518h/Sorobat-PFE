PageExtension 50169 "Interaction Log Entries_PagEXT" extends "Interaction Log Entries"

{

    layout
    {

    }

    actions
    {
        modify("Create &Interaction")
        {
            Visible = CreateInterVISIBLE;
        }
    }
    trigger OnOpenPage()
    begin
        //+REF+CRM
        IF gFromSalesDoc THEN
            fHideButton;
        //+REF+CRM//
    end;




    PROCEDURE fHideButton();
    BEGIN
        //+REF+CRM
        CreateInterVISIBLE := (FALSE);
        //+REF+CRM//
    END;

    PROCEDURE fSetFromSalesDoc(pFromSalesDoc: Boolean);
    BEGIN
        //+REF+CRM
        gFromSalesDoc := pFromSalesDoc;
        //+REF+CRM//
    END;

    var
        gFromSalesDoc: Boolean;
        CreateInterVISIBLE: Boolean;

}