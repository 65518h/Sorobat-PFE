PageExtension 50181 "Close Opportunity Codes_PagEXT" extends "Close Opportunity Codes"

{
    layout
    {
        addafter(Control1)
        {
            field("Filtre Type"; gOptionFilter)
            {
                Caption = 'Filtre Type';
                ApplicationArea = all;
                trigger OnValidate()
                begin
                    CASE gOptionFilter OF
                        gOptionFilter::Won:
                            Rec.SETRANGE(Type, rec.Type::Won);
                        gOptionFilter::Lost:
                            Rec.SETRANGE(Type, rec.Type::Lost);
                        ELSE
                            Rec.SETRANGE(Type);
                    END;
                    CurrPage.UPDATE(TRUE);
                end;
            }
        }
    }

    actions
    {

    }
    trigger OnOpenPage()
    begin

        //+REF+OPPORT
        IF rec.GETFILTERS <> '' THEN
            gOptionFilter := gOptionFilter::" ";
        IF rec.GETFILTER(Type) <> '' THEN
            CASE rec.GETRANGEMIN(Type) OF
                rec.Type::Lost:
                    gOptionFilter := gOptionFilter::Lost;
                rec.Type::Won:
                    gOptionFilter := gOptionFilter::Won;
            END;
        //+REF+OPPORT//
    end;

    VAR
        gOptionFilter: Option " ",Won,Lost;
}