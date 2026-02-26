PageExtension 50210 "Location Card_PagEXT" extends "Location Card"

{


    layout
    {
        addafter("Use As In-Transit")
        {
            field("Tracking Not Required"; Rec."Tracking Not Required")
            {
                ApplicationArea = all;
            }
            field("Bal. Job No."; Rec."Bal. Job No.")
            {
                ApplicationArea = all;
            }
            // field(Affectation; Rec.Affectation)
            // {
            //     ApplicationArea = all;
            // }
            // field("Magasin Centrale"; Rec."Magasin Centrale")
            // {
            //     ApplicationArea = all;
            // }
            field("Bon de sortie Nos."; Rec."Bon de sortie Nos.")
            {
                ApplicationArea = all;
                ToolTip = 'Bon de sortie Nos.';
            }
            field("Bon d entree Nos."; Rec."Bon d entree Nos.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Bon d''entrée Nos. field.', Comment = '%';
            }

            field(Affaire; Rec.Affaire)
            {
                ApplicationArea = all;
            }
            field("No. Series Gasoil"; Rec."No. Series Gasoil")
            {
                ApplicationArea = all;
                Caption = 'N° de Souche Gasoil';
            }
            field("Project Location"; Rec."Project Location") { ApplicationArea = all; }


        }

    }
    actions
    {

    }
    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        // rec.TESTFIELD(Affectation);
    end;

    var
        Text001: label 'Fill in the assignment field';

}
