PageExtension 50293 "Employee Posting Groups_PagEXT" extends "Employee Posting Groups"
{
    layout
    {
        addafter(code)
        {
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
                Caption = 'Taxes Acccount';
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