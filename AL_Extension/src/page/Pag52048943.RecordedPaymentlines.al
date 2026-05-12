page 52048943 "Recorded Payment lines"
{//GL2024  ID dans Nav 2009 : "39001464"
    Caption = 'Lignes de Salaire enreg.';
    Editable = false;
    PageType = List;
    SourceTable = "Rec. Salary Lines";
    SourceTableView = sorting(Year, Month, Employee, "No.");
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field(Quarter; Rec.Quarter)
                {
                    ApplicationArea = Basic;
                    Caption = 'Trimestre';
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'N°';
                }
                field(Employee; Rec.Employee)
                {
                    ApplicationArea = Basic;
                    Caption = 'Salarié';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                    Caption = 'Nom';
                }
                field(Month; Rec.Month)
                {
                    ApplicationArea = Basic;
                    Caption = 'Mois';
                }
                field("Basis salary"; Rec."Basis salary")
                {
                    ApplicationArea = Basic;
                    Caption = 'Salaire de base';
                }
                field("Catégorie"; Rec.Catégorie)
                {
                    ApplicationArea = Basic;
                    Caption = 'Catégorie';
                }
                field(Echellon; Rec.Echellon)
                {
                    ApplicationArea = Basic;
                    Caption = 'Echellon';
                }
                field("Real basis salary"; Rec."Real basis salary")
                {
                    ApplicationArea = Basic;
                    Caption = 'Salaire de base réel';
                }
                field("Supp. hours"; Rec."Supp. hours")
                {
                    ApplicationArea = Basic;
                    Caption = 'Heures supp.';
                }
                field("Taxable indemnities"; Rec."Taxable indemnities")
                {
                    ApplicationArea = Basic;
                    Caption = 'Indemnités imposables';
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = Basic;
                    Caption = 'Année';
                }
                field("Gross Salary"; Rec."Gross Salary")
                {
                    ApplicationArea = Basic;
                    Caption = 'Salaire Brut';
                }
                field("Gross Salary PR"; Rec."Gross Salary PR")
                {
                    ApplicationArea = Basic;
                    Caption = 'Salaire Brut PR';
                    Visible = false;
                }
                field(CNSS; Rec.CNSS)
                {
                    ApplicationArea = Basic;
                    Caption = 'CNSS';
                }
                field("Taxable salary"; Rec."Taxable salary")
                {
                    ApplicationArea = Basic;
                    Caption = 'Salaire imposable';
                }
                field("Real taxable"; Rec."Real taxable")
                {
                    ApplicationArea = Basic;
                    Caption = 'Imposable réel';
                }
                field("Taxe (Month)"; Rec."Taxe (Month)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Impôt (Mois)';
                }
                field("Taxable Soc. Contrib."; Rec."Taxable Soc. Contrib.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cot. soc. imposables';
                }
                field("Non Taxable indemnities"; Rec."Non Taxable indemnities")
                {
                    ApplicationArea = Basic;
                    Caption = 'Indemnités non imposables';
                }
                field("Mission expenses"; Rec."Mission expenses")
                {
                    ApplicationArea = Basic;
                    Caption = 'Frais de mission';
                }
                field("Net salary"; Rec."Net salary")
                {
                    ApplicationArea = Basic;
                    Caption = 'Salaire net';
                }
                field(Loans; Rec.Loans)
                {
                    ApplicationArea = Basic;
                    Caption = 'Prêts';
                }
                field("Ajout  en +"; Rec."Ajout  en +")
                {
                    ApplicationArea = Basic;
                    Caption = 'Ajout  en +';
                }
                field("Report en -"; Rec."Report en -")
                {
                    ApplicationArea = Basic;
                    Caption = 'Report en -';
                }
                field(Advances; Rec.Advances)
                {
                    ApplicationArea = Basic;
                    Caption = 'Advances';
                }
                field("Net salary cashed"; Rec."Net salary cashed")
                {
                    ApplicationArea = Basic;
                    Caption = 'Salaire net perçu';
                }
                field("6 * SMIG"; Rec."6 * SMIG")
                {
                    ApplicationArea = Basic;
                    Caption = '6 * SMIG';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Print...")
            {
                ApplicationArea = Basic;
                Caption = 'Imprimer...';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Line.SetRange("No.", Rec."No.");
                    Line.SetRange(Employee, Rec.Employee);

                    Report.Run(Report::"Etat Annexe IUTS", true, true, Line);
                end;
            }
        }
    }

    var
        Line: Record "Rec. Salary Lines";
}

