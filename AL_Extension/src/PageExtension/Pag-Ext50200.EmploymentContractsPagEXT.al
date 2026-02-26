PageExtension 50200 "Employment Contracts_PagEXT" extends "Employment Contracts"

{
    /*  InsertAllowed=false;
        DeleteAllowed=false;
        ModifyAllowed=false;*/


    layout
    {
        modify(code)
        {
            Editable = false;
        }
        modify(Description)
        {
            Editable = false;
        }
        modify("No. of Contracts")
        {
            Editable = false;
        }
        addafter("Description")
        {
            field("Calculation mode of the taxes"; Rec."Calculation mode of the taxes")
            {
                Editable = false;
                ApplicationArea = all;
                Caption ='Mode calcul de l''impot';
            }
            field("Salary grid"; Rec."Salary grid")
            {
                Editable = false;
                ApplicationArea = all;
                Caption ='Grilles des salaires';
            }
            field("Default Employment Contract"; Rec."Default Employment Contract")
            {
                Editable = false;
                ApplicationArea = all;
                Caption = 'Contrat de travail par défaut';
            }
            field("Regular payments"; Rec."Regular payments")
            {
                Editable = false;
                ApplicationArea = all;
                Caption = 'Paies Regulières';
            }
            field(Taxable; Rec.Taxable)
            {
                Editable = false;
                ApplicationArea = all;
            }
            field("Temporary payments"; Rec."Temporary payments")
            {
                Editable = false;
                ApplicationArea = all;
                Caption ='Rétributions provisoire';
            }
            field("Take in account deductions"; Rec."Take in account deductions")
            {
                Editable = false;
                ApplicationArea = all;
                caption ='Prendre en compte les déducation';
            }
            field("Adjust indemnity amount"; Rec."Adjust indemnity amount")
            {
                Editable = false;
                ApplicationArea = all;
                Caption ='Ajuster montants indemnités';

            }
            field("Appliquer Heure Supp"; Rec."Appliquer Heure Supp")
            {
                Editable = false;
                ApplicationArea = all;
            }
            field("Employee's type"; Rec."Employee's type")
            {
                Editable = false;
                ApplicationArea = all;
                Caption = 'Types du salarié';
            }
            field("Slice of imposition"; Rec."Slice of imposition")
            {
                Editable = false;
                ApplicationArea = all;
                Caption = 'Tranche d''impositions';
            }
            field("Regimes of work"; Rec."Regimes of work")
            {
                Editable = false;
                ApplicationArea = all;
                Caption ='Régimes de travail';
            }
        }
    }
    actions
    {
        addlast(Creation)
        {

            group("Contrat de travail")
            {
                Caption = 'Employment Contract';
                action("Social Contributions")
                {
                    Caption = 'Fiche';
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = all;
                    RunObject = page "Employment Contract";
                    RunPageLink = Code = FIELD(Code);
                }
            }
        }

    }
}