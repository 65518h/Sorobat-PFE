PageExtension 50128 "Resources Setup_PagEXT" extends "Resources Setup"
{

    layout
    {

        addafter("Resource Nos.")
        {
            field("Structure Nos."; Rec."Structure Nos.")
            {
                ApplicationArea = all;
            }
            field("Machine Nos."; Rec."Machine Nos.")
            {
                ApplicationArea = all;
            }
            field("Person Nos."; Rec."Person Nos.")
            {
                ApplicationArea = all;
            }
            field("ressources Projet"; Rec."ressources Projet") { ApplicationArea = all; }
        }
    }


    actions
    {

    }


}

