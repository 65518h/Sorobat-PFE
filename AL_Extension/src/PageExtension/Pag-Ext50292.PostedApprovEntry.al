pageextension 50292 PostedApprovEntry extends "Posted Approval Entries"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;

    procedure setfilters(TableId: Integer; DocumentNo: Code[20])
    begin

        IF TableId <> 0 THEN BEGIN
            REC.FILTERGROUP(2);
            REC.SETRANGE("Table ID", TableId);
            IF DocumentNo <> '' THEN
                REC.SETRANGE("Document No.", DocumentNo);
            REC.FILTERGROUP(0);
        END;
    end;

}