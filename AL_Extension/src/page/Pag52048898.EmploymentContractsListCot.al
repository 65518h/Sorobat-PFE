page 52048898 "Employment Contracts List Cot"
{
    //GL2024  ID dans Nav 2009 : "39001419"
    PageType = ListPart;
    SourceTable = "Default Soc. Contribution";
    Caption = 'Employment Contracts List Cot';
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            repeater(Control1180250000)
            {
                ShowCaption = false;
                field("Social Contribution Code"; Rec."Social Contribution Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Code Cotisation Sociale';
                }
                field("Designation Contribution"; Rec."Designation Contribution")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Plafond SBase*8%"; Rec."Plafond SBase*8%")
                {
                    ApplicationArea = Basic;
                    Caption = 'Plafond SBase*8%';
                }
                field(CNSS; Rec.CNSS)
                {
                    ApplicationArea = Basic;
                    Caption = 'CNSS';
                }
                field("Mode dévaluation"; Rec."Mode dévaluation")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mode dévaluation';
                }
                field("Employer's part"; Rec."Employer's part")
                {
                    ApplicationArea = Basic;
                    Caption = 'Part patronale';
                }
                field("Employee's part"; Rec."Employee's part")
                {
                    ApplicationArea = Basic;
                    Caption = 'Part salariale';
                }
                field("Basis of calculation"; Rec."Basis of calculation")
                {
                    ApplicationArea = Basic;
                    Caption = 'Base de calcul';
                }
                field("Forfait salarial"; Rec."Forfait salarial")
                {
                    ApplicationArea = Basic;
                    Caption = 'Forfait salarial';
                }
                field("Forfait patronal"; Rec."Forfait patronal")
                {
                    ApplicationArea = Basic;
                    Caption = 'Forfait patronal';
                }
                field("Deductible of taxable basis"; Rec."Deductible of taxable basis")
                {
                    ApplicationArea = Basic;
                    Caption = 'Déductible de base imposable';
                }
            }
        }
    }

    actions
    {
    }
}

