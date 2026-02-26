PageExtension 50194 "Qualified Employees_PagEXT" extends "Qualified Employees"

{
    layout
    {
        addbefore("Employee No.")
        {
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = all;

            }
        }
    }


}