PageExtension 50148 "Dimension Values_PagEXT" extends "Dimension Values"
{

    layout
    {
        addbefore(code)
        {
            // field(Ordre; Rec.Ordre)
            // {
            //     ApplicationArea = all;
            // }

        }

        addafter(Totaling)
        {
            field(Indentation; Rec.Indentation)
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {

    }
    trigger OnOpenPage()
    begin
        //rec.SETCURRENTKEY(Ordre);
    end;
}