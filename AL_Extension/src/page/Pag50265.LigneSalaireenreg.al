Page 50265 "Ligne Salaire enreg"
{
    Caption = 'Lignes de calcul';
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Rec. Salary Lines";
    SourceTableView = where(Year = filter(> 2018));
    //ABZ ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Control1180250000)
            {
                ShowCaption = false;
                field("No."; REC."No.")
                {
                    ApplicationArea = all;
                }
                field(Month; REC.Month)
                {
                    ApplicationArea = all;
                }
                field(Year; REC.Year)
                {
                    ApplicationArea = all;
                }
                field(Employee; REC.Employee)
                {
                    ApplicationArea = all;
                }
                field(Name; REC.Name)
                {
                    ApplicationArea = all;
                }
                // field(Qualification; REC.Qualification)
                // {
                //     ApplicationArea = all;
                // }
                // field(Affectation; REC.Affectation)
                // {
                //     ApplicationArea = all;
                // }
                field("Catégorie"; REC.Catégorie)
                {
                    ApplicationArea = all;
                }
                field("Congé Pris"; REC."Congé Pris")
                {
                    ApplicationArea = all;
                }
                field("Paied days"; REC."Paied days")
                {
                    ApplicationArea = all;
                }
                // field("Jours Deplacements"; REC."Jours Deplacements")
                // {
                //     ApplicationArea = all;
                // }
                field("droit de congé du mois"; REC."droit de congé du mois")
                {
                    ApplicationArea = all;
                }
                field("Droit de congé ancienneté"; REC."Droit de congé ancienneté")
                {
                    ApplicationArea = all;
                }
                field("Worked hours"; REC."Worked hours")
                {
                    ApplicationArea = all;
                }
                field("Global dimension 1"; REC."Global dimension 1")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Global dimension 2"; REC."Global dimension 2")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Note; REC.Note)
                {
                    ApplicationArea = all;
                    Visible = NoteVisible;
                }
                field(Pourcentage; REC.Pourcentage)
                {
                    ApplicationArea = all;
                    Visible = PourcentageVisible;
                }
                field("Mois travaillés"; REC."Mois travaillés")
                {
                    ApplicationArea = all;
                    Enabled = true;
                    Visible = "Mois travaillésVisible";
                }
                field("Employee Posting Group"; REC."Employee Posting Group")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Regime of work"; REC."Regime of work")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Emplymt. Contract Code"; REC."Emplymt. Contract Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Bank Account Code"; REC."Bank Account Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Absences; REC.Absences)
                {
                    ApplicationArea = all;
                }
                field("Adjustment of absences"; REC."Adjustment of absences")
                {
                    ApplicationArea = all;
                }
                field("Days off"; REC."Days off")
                {
                    ApplicationArea = all;
                }
                field("Days off remaining"; REC."Days off remaining")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Days off balacement"; REC."Days off balacement")
                {
                    ApplicationArea = all;
                }
                field("Assiduity (Paid days)"; REC."Assiduity (Paid days)")
                {
                    ApplicationArea = all;
                }
                field("Assiduity (Worked days)"; REC."Assiduity (Worked days)")
                {
                    ApplicationArea = all;
                }
                field(Control1180250013; REC."Worked hours")
                {
                    ApplicationArea = all;
                }
                field("Basis hours"; REC."Basis hours")
                {
                    ApplicationArea = all;
                }
                field("Basis salary"; REC."Basis salary")
                {
                    ApplicationArea = all;
                }
                field("Real basis salary"; REC."Real basis salary")
                {
                    ApplicationArea = all;
                }
                field("Taxable indemnities"; REC."Taxable indemnities")
                {
                    ApplicationArea = all;
                }
                field("Supp. hours"; REC."Supp. hours")
                {
                    ApplicationArea = all;
                }
                field("Gross Salary"; REC."Gross Salary")
                {
                    ApplicationArea = all;
                }
                field(CNSS; REC.CNSS)
                {
                    ApplicationArea = all;
                }
                field("Taxable salary"; REC."Taxable salary")
                {
                    ApplicationArea = all;
                }
                field("Deduction Family chief"; REC."Deduction Family chief")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Deduction Loaded child"; REC."Deduction Loaded child")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Deduction Prof. expenses"; REC."Deduction Prof. expenses")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Real taxable"; REC."Real taxable")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Total taxable rec."; REC."Total taxable rec.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Rec. payments"; REC."Rec. payments")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Real taxable (Year)"; REC."Real taxable (Year)")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Taxe (Year)"; REC."Taxe (Year)")
                {
                    ApplicationArea = all;
                }
                field("Total taxes rec."; REC."Total taxes rec.")
                {
                    ApplicationArea = all;
                }
                field("Taxe (Month)"; REC."Taxe (Month)")
                {
                    ApplicationArea = all;
                }
                // field("Contribution Social"; REC."Contribution Social")
                // {
                //     ApplicationArea = all;
                // }
                field("Non Taxable indemnities"; REC."Non Taxable indemnities")
                {
                    ApplicationArea = all;
                }
                field("Taxable Soc. Contrib."; REC."Taxable Soc. Contrib.")
                {
                    ApplicationArea = all;
                }
                field("Net salary"; REC."Net salary")
                {
                    ApplicationArea = all;
                }
                field("Ajout  en +"; REC."Ajout  en +")
                {
                    ApplicationArea = all;
                }
                field("Report en -"; REC."Report en -")
                {
                    ApplicationArea = all;
                }
                field(Loans; REC.Loans)
                {
                    ApplicationArea = all;
                }
                field(Advances; REC.Advances)
                {
                    ApplicationArea = all;
                }
                field("Net salary cashed"; REC."Net salary cashed")
                {
                    ApplicationArea = all;
                }
            }
            group("Rec. Salary line")
            {
                Caption = 'Ligne de salaire enreg.';
                Editable = false;
                field("Employee + ' - ' + Name"; REC.Employee + ' - ' + REC.Name)
                {
                    ApplicationArea = all;
                    ShowCaption = false;
                }
                field(Control1180250082; REC."Gross Salary")
                {
                    ApplicationArea = all;
                }
                field(Control1000000002; REC.CNSS)
                {
                    ApplicationArea = all;
                }
                field(Control1180250084; REC."Taxable salary")
                {
                    ApplicationArea = all;
                }
                field(Control1180250086; REC."Taxe (Month)")
                {
                    ApplicationArea = all;
                }
                field(Control1180250088; REC."Net salary")
                {
                    ApplicationArea = all;
                }
                field(Control1180250090; REC."Net salary cashed")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        if REC.Month > 11 then begin
            NoteVisible := true;
            PourcentageVisible := true;
            "Mois travaillésVisible" := true;
        end
        else begin
            //CurrForm.Note.VISIBLE        := FALSE;
            PourcentageVisible := false;
            "Mois travaillésVisible" := false;
        end
    end;

    trigger OnInit()
    begin
        PourcentageVisible := true;
        NoteVisible := true;
    end;

    var
        [InDataSet]
        NoteVisible: Boolean;
        [InDataSet]
        PourcentageVisible: Boolean;
        [InDataSet]
        "Mois travaillésVisible": Boolean;


    procedure ChangerModePaiement(var Mode: Option Virement,"Espèse")
    var
        compteclt: Record "Employee Bank Account";
        clt: Record Employee;
        T1: Record "Rec. Salary Lines";
    begin
        T1.Reset;
        T1.SetFilter("No.", REC."No.");
        CurrPage.SetSelectionFilter(T1);
        if T1.Find('-') then
            repeat
                Clear(clt);
                clt.Get(T1.Employee);
                case Mode of
                    0:
                        begin
                            Clear(compteclt);
                            if compteclt.Get(T1.Employee, clt."Default Bank Account Code") then begin
                                T1."Bank Account Code" := clt."Default Bank Account Code";
                                T1."Num Compte" := compteclt."Bank Account No.";
                                T1.Modify;
                            end;
                        end;
                    1:
                        begin
                            T1."Bank Account Code" := '';
                            T1."Num Compte" := '';
                            T1.Modify;
                        end;
                end;
            until T1.Next = 0;
    end;
}

