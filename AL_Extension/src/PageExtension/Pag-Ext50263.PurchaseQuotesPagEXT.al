PageExtension 50263 "Purchase Quotes_PagEXT" extends "Purchase Quotes"
{
    //GL2024     SourceTableView=WHERE("Document Type"=CONST(Quote),       "Attached to Doc. No."=CONST(''));


    layout
    {
        addafter("No.")
        {
            field("Generer A Partir DA"; Rec."Generer A Partir DA")
            {
                Caption = 'N° Demande d''achat';
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.FilterGroup(0);
        rec.SetRange("Document Type", rec."Document Type"::Quote);
        rec.SetFilter("Attached to Doc. No.", '%1', '');
        Rec.FilterGroup(2);
    end;
}