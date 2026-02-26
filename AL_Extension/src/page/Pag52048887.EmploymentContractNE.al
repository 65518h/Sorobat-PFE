page 52048887 "Employment Contract NE"
{
    //GL2024  ID dans Nav 2009 : "39001408"
    Caption = 'Consultation -> Employment Contract';
    Editable = true;
    PageType = Card;
    SourceTable = "Employment Contract";
    //ABZ ApplicationArea = all;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Code; rec.Code)
                {
                    ApplicationArea = all;

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
                }
                field("Temporary payments"; rec."Temporary payments")
                {
                    ApplicationArea = all;
                }
                field("Employee's type"; rec."Employee's type")
                {
                    ApplicationArea = all;
                }
                field("Regimes of work"; rec."Regimes of work")
                {
                    ApplicationArea = all;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        RegimesWork.SETRANGE(Code, rec."Regimes of work");
                        f.SETTABLEVIEW(RegimesWork);
                        f.RUN
                    end;
                }
                field("Salary grid"; rec."Salary grid")
                {
                    ApplicationArea = all;
                }
                field(Taxable; rec.Taxable)
                {
                    ApplicationArea = all;
                }
                field("Take in account deductions"; rec."Take in account deductions")
                {
                    ApplicationArea = all;
                }
                field("Calculation mode of the taxes"; rec."Calculation mode of the taxes")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        CalculationmodeofthetaxesOnAft;
                    end;
                }
                field("Inclusive ratio"; rec."Inclusive ratio")
                {
                    ApplicationArea = all;
                    Editable = "Inclusive ratioEditable";
                }
                field("Employee's type Contrat"; rec."Employee's type Contrat")
                {
                    ApplicationArea = all;
                }
                field("Appliquer Heure Supp"; rec."Appliquer Heure Supp")
                {
                    ApplicationArea = all;
                }
            }
            group(Indemnities)
            {
                Caption = 'Indemnities';
                part("Employment Contracts List Ind"; "Employment Contracts List Ind")
                {
                    ApplicationArea = all;
                    SubPageLink = "Employment Contract Code" = FIELD(Code);
                }
            }
            group("Soc. Contribution")
            {
                Caption = 'Soc. Contribution';
                part("Employment Contracts List Cot"; "Employment Contracts List Cot")
                {
                    ApplicationArea = all;
                    SubPageLink = "Employment Contract Code" = FIELD(Code);
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
        f: page "Regime of work";
        RegimesWork: record "Regimes of work";
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

