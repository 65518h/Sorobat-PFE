PageExtension 50171 "Segment_PagEXT" extends "Segment"

{

    layout
    {

    }

    actions
    {
        addafter("Apply &Mailing Group")
        {
            action("Delete Contacts")
            {
                Caption = 'Delete Contacts';
                ApplicationArea = all;
                trigger OnAction()
                var
                    lSegLine: Record "Segment Line";
                    lContact: Record Contact;
                begin

                    lSegLine.SETRANGE("Segment No.", rec."No.");
                    IF CONFIRM(tDeleteContacts, FALSE, lSegLine.COUNT) THEN BEGIN
                        IF lSegLine.FIND('-') THEN
                            REPEAT
                                IF lContact.GET(lSegLine."Contact No.") THEN
                                    IF lContact.Type = lContact.Type::Person THEN BEGIN
                                        lSegLine.DELETE(TRUE);
                                        lContact.DELETE(TRUE);
                                    END;
                            UNTIL lSegLine.NEXT = 0;
                        IF lSegLine.FIND('-') THEN
                            REPEAT
                                lSegLine.DELETE(TRUE);
                                IF lContact.GET(lSegLine."Contact No.") THEN
                                    lContact.DELETE(TRUE);
                            UNTIL lSegLine.NEXT = 0;
                    END;

                end;
            }
        }
        addafter(Category_Process)
        {
            actionref("Delete Contacts1"; "Delete Contacts")
            {

            }
        }

    }

    var
        tDeleteContacts: Label 'Do you want to delete card for these % contacts ?';
        SegLine: Record "Segment Line";
}