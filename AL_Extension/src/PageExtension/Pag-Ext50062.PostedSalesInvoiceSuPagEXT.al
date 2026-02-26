PageExtension 50062 "Posted Sales Invoice Su_PagEXT" extends "Posted Sales Invoice Subform"
{

    //GL2024   SourceTableView=SORTING(Document No.,Line No.);
    layout
    {
        addafter("Item Reference No.")
        {
            field(Marker; rec.Marker)
            {
                ApplicationArea = all;
                Visible = false;
            }
        }


        addafter("Shortcut Dimension 1 Code")
        {
            field("Work Type Code"; rec."Work Type Code")
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
        rec.SetCurrentKey("Document No.", "Presentation Code", "Line No.");
        Rec.FilterGroup(2);
    end;

    var
        wSalesInvHeader: Record "Sales Invoice Header";




}

