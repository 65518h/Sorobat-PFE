page 52048892 "List : Regimes of work"
{
    //GL2024  ID dans Nav 2009 : "39001413"
    Caption = 'Regimes of work';
    Editable = false;
    PageType = List;
    SourceTable = "Regimes of work";
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field(Code; rec.Code)
                {
                    ApplicationArea = all;
                }
                field(Désignation; rec.Désignation)
                {
                    ApplicationArea = all;
                }
                field("Worked Day Per Month"; rec."Worked Day Per Month")
                {
                    ApplicationArea = all;
                }
                // field("Nombre Heure Par Jour"; rec."Nombre Heure Par Jour")
                // {
                //     ApplicationArea = all;
                // }
                field("Work Hours per week"; rec."Work Hours per week")
                {
                    ApplicationArea = all;
                }
                field("Work Hours per month"; rec."Work Hours per month")
                {
                    ApplicationArea = all;
                }
                field("Rate of Night"; rec."Rate of Night")
                {
                    ApplicationArea = all;
                }
                field("Max. Supp. Hours per month"; rec."Max. Supp. Hours per month")
                {
                    ApplicationArea = all;
                }
                field("Days off per month"; rec."Days off per month")
                {
                    ApplicationArea = all;
                }
                field("Assignement mode"; rec."Assignement mode")
                {
                    ApplicationArea = all;
                }
                field("Default Regime"; rec."Default Regime")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Fiche)
            {
                ApplicationArea = all;
                Caption = 'Fiche';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "Card : Regime of work";
                RunPageLink = Code = FIELD(Code);
            }
        }
    }
}

