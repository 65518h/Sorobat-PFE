PageExtension 50197 "Causes of Absence_PagEXT" extends "Causes of Absence"

{

    layout
    {
        addafter(Description)
        {
            field(Type; Rec.Type)
            {
                ApplicationArea = all;
            }
        }

        addafter("Unit of Measure Code")
        {
            field("Motif D'absence"; Rec."Motif D'absence")
            {
                ApplicationArea = all;
            }
            field("Imputable Sur Congé"; Rec."Imputable Sur Congé")
            {
                ApplicationArea = all;
            }
            field("Total validated Absence"; Rec."Total validated Absence")
            {
                ApplicationArea = all;
            }
            field("Nbre de J (auto. 1 Période)"; Rec."Nbre de J (auto. 1 Période)")
            {
                ApplicationArea = all;
            }
            field("Code Cause 1 Période"; Rec."Code Cause 1 Période")
            {
                ApplicationArea = all;
            }
            field("Nbre de J (auto. 2 Période)"; Rec."Nbre de J (auto. 2 Période)")
            {
                ApplicationArea = all;
            }
            field("Code Cause 2 Période"; Rec."Code Cause 2 Période")
            {
                ApplicationArea = all;
            }
            field("Nbre de J (auto. 3 Période)"; Rec."Nbre de J (auto. 3 Période)")
            {
                ApplicationArea = all;
            }
            field("Code Cause 3 Période"; Rec."Code Cause 3 Période")
            {
                ApplicationArea = all;
            }
        }
    }


}