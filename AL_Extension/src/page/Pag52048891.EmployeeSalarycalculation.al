page 52048891 "Employee : Salary calculation"
{
    //GL2024  ID dans Nav 2009 : "39001412"
    Caption = 'Salarié : Calcul du salaire';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Salary Lines";
    //ABZ ApplicationArea = all;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'Conditions de réalisation';
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
                field("Employee Posting Group"; Rec."Employee Posting Group")
                {
                    ApplicationArea = Basic;
                    Caption = 'Groupe compta. salarié';
                    Editable = false;
                }
                field("Employee Regime of work"; Rec."Employee Regime of work")
                {
                    ApplicationArea = Basic;
                    Caption = 'Régime de travail';
                }
                field("Emplymt. Contract Code"; Rec."Emplymt. Contract Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Code contrat de travail';
                }
                field("Worked hours"; Rec."Worked hours")
                {
                    ApplicationArea = Basic;
                    Caption = 'Heures travaillées';
                }
                field("Basis hours"; Rec."Basis hours")
                {
                    ApplicationArea = Basic;
                    Caption = 'Heures de base';
                    Editable = false;
                }
                field("Paied days"; Rec."Paied days")
                {
                    ApplicationArea = Basic;
                    Caption = 'Jours payés';
                }
            }
            group(Calcul)
            {
                Caption = 'Calcul';
                field("Employee + ' - ' + Name"; Rec.Employee + ' - ' + Rec.Name)
                {
                    ApplicationArea = Basic;
                    Caption = 'Salarié';
                    Editable = false;
                }
                field("Basis salary"; Rec."Basis salary")
                {
                    ApplicationArea = Basic;
                    Caption = 'Salaire de base';
                }
                field("Taxable indemnities"; Rec."Taxable indemnities")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Caption = 'Indemnités imposables';
                }
                field("Gross Salary"; Rec."Gross Salary")
                {
                    ApplicationArea = Basic;
                    Caption = 'Salaire Brut';
                }
                field(CNSS; Rec.CNSS)
                {
                    ApplicationArea = Basic;
                    Caption = 'CNSS';
                    Editable = false;
                }
                field("Taxable salary"; Rec."Taxable salary")
                {
                    ApplicationArea = Basic;
                    Caption = 'Salaire imposable';
                    DecimalPlaces = 3 : 3;
                }
                field("Taxe (Month)"; Rec."Taxe (Month)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Impôt (Mois)';
                    DecimalPlaces = 3 : 3;
                    Editable = false;
                }
                field("Non Taxable indemnities"; Rec."Non Taxable indemnities")
                {
                    ApplicationArea = Basic;
                    DecimalPlaces = 3 : 3;
                    Caption = 'Indemnités non imposables';
                }
                field("Taxable Soc. Contrib."; Rec."Taxable Soc. Contrib.")
                {
                    ApplicationArea = Basic;
                    DecimalPlaces = 3 : 3;
                    Caption = 'Cot. soc. imposables';
                    Editable = false;
                }
                field("Net salary"; Rec."Net salary")
                {
                    ApplicationArea = Basic;
                    DecimalPlaces = 3 : 3;
                    Caption = 'Salaire Net';
                    trigger OnValidate()
                    BEGIN
                        IF NOT rec.Prime THEN IF rec."Net salary" < xRec."Net salary" THEN ERROR(Text001, xRec."Net salary");
                    END;
                }
                field(Prime; Rec.Prime)
                {
                    ApplicationArea = Basic;
                    Caption = 'Prime';
                }
            }
        }
    }

    actions
    {
        area(Promoted)
        {
            group(Fonct1)
            {
                Caption = 'Fonctions';
                actionref("Fiche de paie1"; "Fiche de paie") { }
                actionref(F11; F1) { }
                actionref(F21; F2) { }
            }

        }
        area(processing)
        {
            group(Fonct)
            {
                Caption = 'Fonctions';
                action("Fiche de paie")
                {
                    ApplicationArea = Basic;
                    Caption = 'Fiche de paie';

                    trigger OnAction()
                    begin
                        Line.SetRange("No.", Rec."No.");
                        Line.SetRange(Employee, Rec.Employee);

                        Report.Run(Report::"Fiche de Paie", true, true, Line);
                    end;
                }
                separator(Action1180250012)
                {
                }
                action(F1)
                {
                    ApplicationArea = Basic;
                    Caption = 'Calculer Salaire Net';
                    ShortCutKey = 'Ctrl+F7';
                    Visible = false;

                    trigger OnAction()
                    begin
                        MngmtSalary.CalculerLigneSalaire(Rec, false, 0, 0, false);
                        CurrPage.Update(false)
                    end;
                }
                action(F2)
                {
                    ApplicationArea = Basic;
                    Caption = 'Calculer Sursalaire';
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        MngmtSalary.PaieInverseFeuilleCalcul(Rec, Rec."Basis salary", Rec."Net salary", 0);
                    end;
                }
            }
        }
    }

    trigger OnInit()
    begin
        FonctEnable := true;
    end;

    trigger OnOpenPage()
    var
        EmpCont: Record "Employment Contract";
        RegWork: record "Regimes of work";
    begin
        if Rec."Employee's type" = 0 then
            FonctEnable := true
        else
            FonctEnable := true;

        // AGA 07 03 10
        Empl.Get(Rec.Employee);
        EmpCont.Get(Empl."Emplymt. Contract Code");
        RegWork.Get(EmpCont."Regimes of work");

        if Rec."Employee's type" = 0 then begin
            Rec."Basis salary" := Empl."Basis salary" * RegWork."Work Hours per month";
            Rec."Employee's type" := 1;
            Rec."Worked hours" := RegWork."Work Hours per month";
            MngmtSalary.CalculerLigneSalaire(Rec, false, 0, 0, false);
            CurrPage.Update(false);
            Rec.Modify;
        end; //else
             //<<AGA
    end;

    var
        Line: Record "Salary Lines";
        MngmtSalary: Codeunit "Management of salary";
        Empl: Record Employee;
        [InDataSet]
        FonctEnable: Boolean;
        Text001: Label 'FRA=Vous Devez Saisir Un Net Supérieure Au Net Actuelle ( %1 )';
}

