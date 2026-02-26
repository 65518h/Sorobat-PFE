PageExtension 50055 "Inventory Posting Group_PagEXT" extends "Inventory Posting Groups"
{
    layout
    {
        addafter(Description)
        {
            field("Frequence Changement"; Rec."Frequence Changement")
            {
                ApplicationArea = all;
            }
            field(Pneumatiques; Rec.Pneumatique)
            {
                ApplicationArea = all;
            }
            field("Excess Receip Allow"; Rec."Excess Receip Allow")
            {
                ApplicationArea = all;
            }
            field("Excess Receip (%)"; Rec."Excess Receip (%)")
            {
                ApplicationArea = all;
            }
            field("Characteristic 1"; Rec."Characteristic 1")
            {
                ApplicationArea = all;
            }
            field("Characteristic 2"; Rec."Characteristic 2")
            {
                ApplicationArea = all;
            }
            field("Characteristic 3"; Rec."Characteristic 3")
            {
                ApplicationArea = all;
            }
            field("Characteristic 4"; Rec."Characteristic 4")
            {
                ApplicationArea = all;
            }
            field("Characteristic 5"; Rec."Characteristic 5")
            {
                ApplicationArea = all;
            }
            field("Characteristic 6"; Rec."Characteristic 6")
            {
                ApplicationArea = all;
            }
            field("Characteristic 7"; Rec."Characteristic 7")
            {
                ApplicationArea = all;
            }
            field("Characteristic 8"; Rec."Characteristic 8")
            {
                ApplicationArea = all;
            }
            field("Characteristic 9"; Rec."Characteristic 9")
            {
                ApplicationArea = all;
            }
        }
    }
    trigger OnOpenPage()
    begin
        CurrPage.EDITABLE(NOT CurrPage.LOOKUPMODE);
    end;
}

