PageExtension 50120 "Shipping Agents_PagEXT" extends "Shipping Agents"
{
    //GL2024    DeleteAllowed=false;
    //GL2024 SourceTableView = SORTING(Code)               ORDER(Ascending);
    layout
    {


    }


    actions
    {

    }

    trigger OnOpenPage()
    begin
        Rec.FilterGroup(0);
        rec.SetCurrentKey(Code);
        rec.SetAscending(Code, true);

        Rec.FilterGroup(2);
    end;
}


