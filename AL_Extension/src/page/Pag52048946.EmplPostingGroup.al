page 52048946 "Empl. Posting Group"
{//GL2024  ID dans Nav 2009 : "39001467"
    Caption = 'Empl. Posting Group';
    Editable = false;
    PageType = List;
    SourceTable = "Employee Posting Group2";
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                Editable = false;
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Salaire Net"; Rec."Salaire Net")
                {
                    ApplicationArea = Basic;
                }
                field("Charge Personnel (Base+Sursal)"; Rec."Charge Personnel (Base+Sursal)")
                {
                    ApplicationArea = Basic;
                }
                field("Heure Supp"; Rec."Heure Supp")
                {
                    ApplicationArea = Basic;
                }
                field("Indemnités Imposable"; Rec."Indemnités Imposable")
                {
                    ApplicationArea = Basic;
                }
                field("Indemnite Non Imposable"; Rec."Indemnite Non Imposable")
                {
                    ApplicationArea = Basic;
                }
                field("Repayable expenses Acc."; Rec."Repayable expenses Acc.")
                {
                    ApplicationArea = Basic;
                }
                field(IUTS; Rec.IUTS)
                {
                    ApplicationArea = Basic;
                }
                field(CNSS; Rec.CNSS)
                {
                    ApplicationArea = Basic;
                }
                field(TPA; Rec.TPA)
                {
                    ApplicationArea = Basic;
                }
                field(Avance; Rec.Avance)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

