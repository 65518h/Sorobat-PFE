page 52048894 "Card : Regime of work"
{
    //GL2024  ID dans Nav 2009 : "39001415"
    Caption = 'Fiche : Régime de travail';
    PageType = Card;
    SourceTable = "Regimes of work";
    ApplicationArea = all;
    UsageCategory = Administration;
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
                }
                field(Désignation; rec.Désignation)
                {
                    ApplicationArea = all;
                }
                field("type calcul paie"; rec."type calcul paie")
                {
                    ApplicationArea = all;
                }
                field("Type Calendar"; rec."Type Calendar")
                {
                    ApplicationArea = all;
                }
                field("Work Hours per week"; rec."Work Hours per week")
                {
                    ApplicationArea = all;
                }
                field("Work Hours per month"; rec."Work Hours per month")
                {
                    ApplicationArea = all;
                }
                field("Worked Day Per Month"; rec."Worked Day Per Month")
                {
                    ApplicationArea = all;
                }
                field("Nbre Jour Payé Per Month"; rec."Nbre Jour Payé Per Month")
                {
                    ApplicationArea = all;
                }
                // field("Nombre Heure Par Jour"; rec."Nombre Heure Par Jour")
                // {
                //     ApplicationArea = all;
                // }
                field("Default Regime"; rec."Default Regime")
                {
                    ApplicationArea = all;
                }
                field("Appliquer Régime"; rec."Appliquer Régime")
                {
                    ApplicationArea = all;
                }
                field("Rate of Night"; rec."Rate of Night")
                {
                    ApplicationArea = all;
                }
                field("taux indem panier"; rec."taux indem panier")
                {
                    ApplicationArea = all;
                }
                field("Taux heure supp maj"; rec."Taux heure supp maj")
                {
                    ApplicationArea = all;
                }
                field("From Work day to Work hour"; rec."From Work day to Work hour")
                {
                    ApplicationArea = all;
                }
                field("Taux Jours Férié"; rec."Taux Jours Férié")
                {
                    ApplicationArea = all;
                }
                field("Max. Supp. Hours per month"; rec."Max. Supp. Hours per month")
                {
                    ApplicationArea = all;
                }
            }
            group("Supp. Hours")
            {
                Caption = 'Congés';
                field("Days off per month"; rec."Days off per month")
                {
                    ApplicationArea = all;
                }
                field("Assignement mode"; rec."Assignement mode")
                {
                    ApplicationArea = all;
                }
                field("Rétributions Ancienneté/An"; rec."Rétributions Ancienneté/An")
                {
                    ApplicationArea = all;
                    Editable = RétributionsAnciennetéAnEditab;
                }
                field("Plafond Ancienneté/An"; rec."Plafond Ancienneté/An")
                {
                    ApplicationArea = all;
                    Editable = "Plafond Ancienneté/AnEditable";
                }
                field("Limite ancienneté"; rec."Limite ancienneté")
                {
                    ApplicationArea = all;
                    Editable = "Limite anciennetéEditable";
                }
            }
        }
    }

    actions
    {
        area(Promoted)
        {
            group("Regimes of work1")
            {
                Caption = 'Regime de travail';
                actionref("Overcharge of the hour cost1"; "Overcharge of the hour cost")
                { }
            }
        }
        area(navigation)
        {
            group("Regimes of work")
            {
                Caption = 'Regimes of work';
                separator(separator100)
                {
                }
                action("Overcharge of the hour cost")
                {
                    ApplicationArea = all;
                    Caption = 'Overcharge of the hour cost';
                    RunObject = page "Bon Reglement";
                    RunPageLink =/*GL2024 Field1 */"N° Bon" = FIELD(Code);
                    Visible = false;
                }
            }
        }
    }

    trigger OnInit()
    begin
        "Limite anciennetéEditable" := TRUE;
        "Plafond Ancienneté/AnEditable" := TRUE;
        RétributionsAnciennetéAnEditab := TRUE;
    end;

    trigger OnOpenPage()
    begin
        RecGPramRessHum.GET();
        IF RecGPramRessHum."App.retribution jour ancien." = FALSE THEN BEGIN
            RétributionsAnciennetéAnEditab := FALSE;
            "Plafond Ancienneté/AnEditable" := FALSE;
            "Limite anciennetéEditable" := FALSE;
        END;
    end;

    var
        RegimeTravail: record "Bon Reglement";
        RegimeTravailTmp: record "Bon Reglement";
        RecGPramRessHum: Record "Human Resources Setup";
        [InDataSet]
        "RétributionsAnciennetéAnEditab": Boolean;
        [InDataSet]
        "Plafond Ancienneté/AnEditable": Boolean;
        [InDataSet]
        "Limite anciennetéEditable": Boolean;
}

