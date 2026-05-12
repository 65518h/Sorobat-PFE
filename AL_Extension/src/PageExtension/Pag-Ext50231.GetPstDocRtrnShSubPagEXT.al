PageExtension 50231 "Get Pst.Doc-RtrnSh Sub_PagEXT" extends "Get Pst.Doc-RtrnShptLn Subform"
{
    layout
    {
        addafter("Pay-to Vendor No.")
        {
            field("Return Order No."; rec."Return Order No.")
            {
                ApplicationArea = all;
            }
        }
    }
}

