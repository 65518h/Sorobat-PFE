page 52048945 "Employee Posting Groups2"
{//GL2024  ID dans Nav 2009 : "39001466"
    Caption = 'Employee Posting Groups';
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
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
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
                field("Salaire Net"; Rec."Salaire Net")
                {
                    ApplicationArea = Basic;
                    Caption = 'Compte salaire net';
                }
                field(Avance; Rec.Avance)
                {
                    ApplicationArea = Basic;
                }
                field("Prêt"; Rec.Prêt)
                {
                    ApplicationArea = Basic;
                }
                field(CNSS; Rec.CNSS)
                {
                    ApplicationArea = Basic;
                }
                field(IUTS; Rec.IUTS)
                {
                    ApplicationArea = Basic;
                    Caption = 'IUTS';
                }
                field(TPA; Rec.TPA)
                {
                    ApplicationArea = Basic;
                }
                field("Charge sociale"; Rec."Charge sociale")
                {
                    ApplicationArea = Basic;
                }
                field("Prestations Familiale"; Rec."Prestations Familiale")
                {
                    ApplicationArea = Basic;
                }
                field("Risque Professionnel"; Rec."Risque Professionnel")
                {
                    ApplicationArea = Basic;
                }
                field("Assurance Vieillesse"; Rec."Assurance Vieillesse")
                {
                    ApplicationArea = Basic;
                }
                field(Arrondissement; Rec.Arrondissement)
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

