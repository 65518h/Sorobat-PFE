PageExtension 50060 "Posted Sales Shpt. Sub_PagEXT" extends "Posted Sales Shpt. Subform"
{

    //GL2024 SourceTableView=SORTING(Document No.,Line No.);
    layout
    {
        addafter("type")
        {
            field("Type article"; Rec."Type article")
            {
                Editable = false;
                Visible = false;
                ApplicationArea = all;
            }
        }

        modify("Job No.")
        {
            Visible = true;
        }
        modify("Job Task No.")
        {
            Visible = true;
        }
        addafter(Quantity)
        {
            field("Unit Price"; REC."Unit Price")
            {
                ApplicationArea = all;
            }
        }
        addafter("Job No.")
        {

            field("Work Type Code"; REC."Work Type Code")
            {
                ApplicationArea = all;
                Visible = false;
            }
        }
    }
    trigger OnOpenPage()
    VAR

    begin
        Rec.FilterGroup(0);
        rec.SetCurrentKey("Document No.", "Presentation Code");
        Rec.FilterGroup(2);
    end;
}

