page 52048886 "Employment Contract"
{
    //GL2024  ID dans Nav 2009 : "39001407"
    Caption = 'Contrat de travail';
    PageType = Card;
    SourceTable = "Employment Contract";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'Général';
                field(Code; rec.Code)
                {
                    ApplicationArea = all;
                    Editable = true;

                    trigger OnAssistEdit()
                    begin
                        IF rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Regular payments"; rec."Regular payments")
                {
                    ApplicationArea = all;
                    Caption = 'Paies régulières';
                    Editable = true;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
                field("Temporary payments"; rec."Temporary payments")
                {
                    ApplicationArea = all;
                    Caption = 'Rétributions provisoires';
                }
                field("Employee's type"; rec."Employee's type")
                {
                    ApplicationArea = all;
                    Caption = 'Type du salarié';
                }
                field("Regimes of work"; rec."Regimes of work")
                {
                    ApplicationArea = all;
                    Caption = 'Régime de travail';
                }
                field("Salary grid"; rec."Salary grid")
                {
                    ApplicationArea = all;
                    Caption = 'Grille des Salaires';
                }
                field("Employee's type Contrat"; rec."Employee's type Contrat")
                {
                    ApplicationArea = all;
                    Caption = 'Type de contrat';
                }
                field("Slice of imposition"; rec."Slice of imposition")
                {
                    ApplicationArea = all;
                    TableRelation = "Slices of imposition".Code;
                    Caption = 'Tranche d''imposition';
                }
                field(Taxable; rec.Taxable)
                {
                    ApplicationArea = all;
                    Caption = 'Imposable';
                }
                field("Cotisable Sans Imposable"; rec."Cotisable Sans Imposable")
                {
                    ApplicationArea = all;
                    Caption = 'Cotisable Sans Imposable';
                }
                field("Take in account deductions"; rec."Take in account deductions")
                {
                    ApplicationArea = all;
                    Caption = 'Prendre en comptes les déductions';
                }
                field("Calculation mode of the taxes"; rec."Calculation mode of the taxes")
                {
                    ApplicationArea = all;
                    Caption = 'Mode calcul de l''impôt';

                    trigger OnValidate()
                    begin
                        CalculationmodeofthetaxesOnAft;
                    end;
                }
                field("Inclusive ratio"; rec."Inclusive ratio")
                {
                    ApplicationArea = all;
                    Editable = "Inclusive ratioEditable";
                    Caption = 'Taux forfaitaire';
                }
                field("Appliquer Heure Supp"; rec."Appliquer Heure Supp")
                {
                    ApplicationArea = all;
                    Caption = 'Appliquer Heure Supp';
                }
                field("Type Calendar"; rec."Type Calendar")
                {
                    ApplicationArea = all;
                    Caption = 'Type Calendar';
                    Visible = true;
                }
                field("Code Calendar"; rec."Code Calendar")
                {
                    ApplicationArea = all;
                    Caption = 'Code Calendar';
                    Visible = true;
                }
            }
            group(Indemnities)
            {
                Caption = 'Indemnités';
                part("Employment Contracts List Ind"; "Employment Contracts List Ind")
                {
                    ApplicationArea = all;
                    SubPageLink = "Employment Contract Code" = FIELD(Code);
                }
            }
            group("Soc. Contribution")
            {
                Caption = 'Cotisations Sociales';
                part("Employment Contracts List Cot"; "Employment Contracts List Cot")
                {
                    ApplicationArea = all;
                    SubPageLink = "Employment Contract Code" = FIELD(Code);
                }
            }
            group(Employees)
            {
                Caption = 'Salariés';
                part("Empl - Empl.contract"; "Empl - Empl.contract")
                {
                    ApplicationArea = all;
                    SubPageLink = "Emplymt. Contract Code" = FIELD(Code);
                    SubPageView = SORTING("No.") ORDER(Ascending);
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        IF rec."Calculation mode of the taxes" = 0 THEN
            "Inclusive ratioEditable" := FALSE
        ELSE
            "Inclusive ratioEditable" := TRUE;
    end;

    trigger OnInit()
    begin
        "Inclusive ratioEditable" := TRUE;
    end;

    var
        [InDataSet]
        "Inclusive ratioEditable": Boolean;

    local procedure CalculationmodeofthetaxesOnAft()
    begin
        IF rec."Calculation mode of the taxes" = 0 THEN
            "Inclusive ratioEditable" := FALSE
        ELSE
            "Inclusive ratioEditable" := TRUE;
    end;
}

