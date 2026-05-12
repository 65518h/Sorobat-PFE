PageExtension 50098 "Req. Worksheet Temp_PagEXT" extends "Req. Worksheet Templates"
{
    layout
    {
        addafter(Recurring)
        {
            field(Type; Rec.Type)
            {
                ApplicationArea = all;
            }
        }
    }
}