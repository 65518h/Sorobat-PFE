PageExtension 50022 "Assembly BOM_PagEXT" extends "Assembly BOM"
{
    layout
    {
        addafter("Assembly BOM")
        {
            field("Value 1"; Rec."Value 1")
            {
                ApplicationArea = all;
            }
            field("Value 2"; Rec."Value 2")
            {
                ApplicationArea = all;
            }
            field("Value 3"; Rec."Value 3")
            {
                ApplicationArea = all;
            }
            field("Value 4"; Rec."Value 4")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Value 5"; Rec."Value 5")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Value 6"; Rec."Value 6")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Value 7"; Rec."Value 7")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Value 8"; Rec."Value 8")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Value 9"; Rec."Value 9")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Value 10"; Rec."Value 10")
            {
                ApplicationArea = all;
                Visible = false;
            }
        }



    }


    trigger OnAfterGetRecord()
    begin
        //DEVIS
        //GL2024  Currpage.UPDATECONTROLS;
        //DEVIS//  
    end;
}
