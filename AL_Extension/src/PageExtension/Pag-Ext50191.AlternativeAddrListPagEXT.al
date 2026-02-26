PageExtension 50191 "Alternative Addr List_PagEXT" extends "Alternative Address List"

{
    layout
    {
        addbefore(Code)
        {
            field("Employee No."; Rec."Employee No.")
            {
                ApplicationArea = all;
            }
        }
    }
}