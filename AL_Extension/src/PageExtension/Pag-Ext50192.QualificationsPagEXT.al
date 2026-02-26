PageExtension 50192 "Qualifications_PagEXT" extends "Qualifications"

{
    layout
    {
        addafter("Qualified Employees")
        {
            field("Groupe Qualification"; Rec."Groupe Qualification")
            {
                ApplicationArea = all;
            }
            field(Amplitude; Rec.Amplitude)
            {
                ApplicationArea = all;
            }
            field(Prime; Rec.Prime)
            {
                ApplicationArea = all;
            }
            field(Conducteur; Rec.Conducteur)
            {
                ApplicationArea = all;
            }
            field("Sans Heure Supp"; Rec."Sans Heure Supp")
            {
                ApplicationArea = all;
            }
            field(Collège; Rec.Collège)
            {
                ApplicationArea = all;
            }
            // field("Qualified Employees"; Rec."Qualified Employees")
            // {
            //     ApplicationArea = all;
            // }


        }
    }
    trigger OnOpenPage()
    begin
        //Currpage.EDITABLE(NOT Currpage.LOOKUPMODE);
    end;
}