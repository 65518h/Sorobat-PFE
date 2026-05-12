PageExtension 50078 "Job Journal_PagEXT" extends "Job Journal"
{
    layout
    {
        modify("No.")
        {
            trigger OnLookup(var Text: Text): Boolean
            var
                lMultiple: Boolean;
            begin
                //MULTIPLE
                rec.wLookUpNo(Rec, lMultiple);
                //MULTIPLE//
            end;
        }
    }
    actions
    {
        modify("Test Report")
        {
            Visible = false;
        }
    }


}

