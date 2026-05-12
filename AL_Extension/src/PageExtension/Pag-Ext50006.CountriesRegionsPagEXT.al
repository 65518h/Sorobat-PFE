PageExtension 50006 "Countries/Regions_PagEXT" extends "Countries/Regions"
{

    layout
    {
        addafter("Intrastat Code")
        {
            field("SEPA Allowed1"; rec."SEPA Allowed1")
            {
                ApplicationArea = all;
            }
            field("ISO Code A3"; rec."ISO Code A3")
            {
                caption = 'ISO Code A3';
                ApplicationArea = all;
            }
            field("ISO Code N3"; rec."ISO Code N3")
            {
                caption = 'ISO Code N3';
                ApplicationArea = all;
            }

        }
    }

    trigger OnOpenPage()
    begin

        CurrPage.EDITABLE(NOT CurrPage.LOOKUPMODE);
    end;
}

