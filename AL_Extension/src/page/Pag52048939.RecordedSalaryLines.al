page 52048939 "Recorded Salary Lines"
{
    //GL2024  ID dans Nav 2009 : "39001460"
    Caption = 'Calculation lines';
    Editable = false;
    InsertAllowed = false;
    PageType = Listpart;
    SourceTable = "Rec. Salary Lines";
    //ABZApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Control1180250000)
            {
                ShowCaption = false;
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
                // field(Qualification; Rec.Qualification)
                // {
                //     ApplicationArea = Basic;
                // }
                // field(Affectation; Rec.Affectation)
                // {
                //     ApplicationArea = Basic;
                // }
                field(Fonction; Rec.Fonction)
                {
                    ApplicationArea = Basic;
                    Caption = 'Fonction';
                    Editable = false;
                }
                field("Statistics Group Code"; Rec."Statistics Group Code")
                {
                    ApplicationArea = Basic;
                    //  Caption = 'Groupe Statistique';
                    Editable = false;
                }
                field("Statistic Gpe Descrip"; Rec."Statistic Gpe Descrip")
                {
                    ApplicationArea = Basic;
                    // Caption = 'Description Groupe Statistique';
                    Editable = false;
                }
                field(Service; Rec.Service)
                {
                    ApplicationArea = Basic;
                    Caption = 'Service';
                    Editable = false;
                }
                field("Description Service"; Rec."Description Service")
                {
                    ApplicationArea = Basic;
                    Caption = 'Description Service';
                    Editable = false;
                }
                field("Catégorie"; Rec.Catégorie)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Congé Pris"; Rec."Congé Pris")
                {
                    ApplicationArea = Basic;
                }
                // field("Contribution Social"; Rec."Contribution Social")
                // {
                //     ApplicationArea = Basic;
                // }
                field("Paied days"; Rec."Paied days")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                // field("Jours Deplacements"; Rec."Jours Deplacements")
                // {
                //     ApplicationArea = Basic;
                // }
                field("droit de congé du mois"; Rec."droit de congé du mois")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Droit de congé ancienneté"; Rec."Droit de congé ancienneté")
                {
                    ApplicationArea = Basic;
                }
                field("Worked hours"; Rec."Worked hours")
                {
                    ApplicationArea = Basic;
                    Caption = 'Heures travaillées';
                }
                field("Global dimension 1"; Rec."Global dimension 1")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                    Caption = 'Code département';
                }
                field("Global dimension 2"; Rec."Global dimension 2")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                    Caption = 'Code dossier';
                }
                field(Note; Rec.Note)
                {
                    ApplicationArea = Basic;
                    Visible = NoteVisible;
                }
                field(Pourcentage; Rec.Pourcentage)
                {
                    ApplicationArea = Basic;
                    Visible = PourcentageVisible;
                    Caption = 'Pourcentage';
                }
                field("Mois travaillés"; Rec."Mois travaillés")
                {
                    ApplicationArea = Basic;
                    Enabled = true;
                    Visible = "Mois travaillésVisible";
                    Caption = 'Mois travaillés';
                }
                field("Employee Posting Group"; Rec."Employee Posting Group")
                {
                    ApplicationArea = Basic;
                    Caption = 'Groupe compta. salarié';
                    Visible = false;
                }
                field("Retenue SNP"; Rec."Retenue SNP") { ApplicationArea = all; }
                field("Retenue FSP1"; Rec."Retenue FSP") { ApplicationArea = all; Visible = false; }
                field("Regime of work"; Rec."Regime of work")
                {
                    ApplicationArea = Basic;
                    Caption = 'Régime de travail';
                    Visible = false;
                }
                field("Emplymt. Contract Code"; Rec."Emplymt. Contract Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                    Caption = 'Code contrat de travail';
                }
                field("Bank Account Code"; Rec."Bank Account Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                    Caption = 'Compte bancaire';
                }
                field(Absences; Rec.Absences)
                {
                    ApplicationArea = Basic;
                    Caption = 'Absences';
                }
                field("Adjustment of absences"; Rec."Adjustment of absences")
                {
                    ApplicationArea = Basic;
                    Caption = 'Ajustement des absences';
                }
                field("Days off"; Rec."Days off")
                {
                    ApplicationArea = Basic;
                    Caption = 'Jour hors contrat';
                }
                field("Days off remaining"; Rec."Days off remaining")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Days off balacement"; Rec."Days off balacement")
                {
                    ApplicationArea = Basic;
                }
                field("Assiduity (Paid days)"; Rec."Assiduity (Paid days)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Assiduité (Jours payés)';
                }
                field("Assiduity (Worked days)"; Rec."Assiduity (Worked days)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Assiduité (Jours ouvrés)';
                }
                field(Control1180250013; Rec."Worked hours")
                {
                    ApplicationArea = Basic;
                    Caption = 'Heures travaillées';
                }
                field("Basis hours"; Rec."Basis hours")
                {
                    ApplicationArea = Basic;
                    Caption = 'Heures de base';
                }
                field("Basis salary"; Rec."Basis salary")
                {
                    ApplicationArea = Basic;
                    Caption = 'Salaire de base';
                }
                field("Real basis salary"; Rec."Real basis salary")
                {
                    ApplicationArea = Basic;
                    Caption = 'Salaire de base réel';
                }
                field("Taxable indemnities"; Rec."Taxable indemnities")
                {
                    ApplicationArea = Basic;
                    Caption = 'Indemnités imposables';
                }
                field("Supp. hours"; Rec."Supp. hours")
                {
                    ApplicationArea = Basic;
                    Caption = 'Heures supp.';
                }
                field("Gross Salary"; Rec."Gross Salary")
                {
                    ApplicationArea = Basic;
                    Caption = 'Salaire Brut';
                }
                // field("Exclu Declaration CNSS"; Rec."Exclu Declaration CNSS")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Exclu Declaration CNSS';
                //     Editable = false;
                //     Style = Strong;
                //     StyleExpr = true;
                // }
                field(CNSS; Rec.CNSS)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cot. soc. non imposables';
                }
                field("Taxable salary"; Rec."Taxable salary")
                {
                    ApplicationArea = Basic;
                    Caption = 'Salaire imposable';
                }
                field("Deduction Family chief"; Rec."Deduction Family chief")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                    Caption = 'Déduction Chef de famille';
                }
                field("Deduction Loaded child"; Rec."Deduction Loaded child")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                    Caption = 'Déduction Sitaution familiale';
                }
                field("Deduction Prof. expenses"; Rec."Deduction Prof. expenses")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                    Caption = 'Déduction Frais pro.';
                }
                field("Real taxable"; Rec."Real taxable")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                    Caption = 'Imposable réel';
                }
                field("Total taxable rec."; Rec."Total taxable rec.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                    Caption = 'Total imposable enreg.';
                }
                field("Rec. payments"; Rec."Rec. payments")
                {
                    ApplicationArea = Basic;
                    Caption = 'Salaires enreg.';
                    Visible = false;
                }
                field("Real taxable (Year)"; Rec."Real taxable (Year)")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                    Caption = 'Imposable réel (An)';
                }
                field("Taxe (Year)"; Rec."Taxe (Year)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Impôt(Année)';
                }
                field("Total taxes rec."; Rec."Total taxes rec.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Impôts enreg.';
                }
                field("Taxe (Month)"; Rec."Taxe (Month)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Impôt(Mois)';
                }
                field("Non Taxable indemnities"; Rec."Non Taxable indemnities")
                {
                    ApplicationArea = Basic;
                    Caption = 'Indemnités non imposables';
                }
                field("Taxable Soc. Contrib."; Rec."Taxable Soc. Contrib.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cot. soc. imposables';
                }
                field("Net salary"; Rec."Net salary")
                {
                    ApplicationArea = Basic;
                    Caption = 'Salaire net';
                }
                field("Retenue FSP"; Rec."Retenue FSP")
                {
                    ApplicationArea = Basic;
                    Style = Attention;
                    StyleExpr = true;
                }
                field(Loans; Rec.Loans)
                {
                    ApplicationArea = Basic;
                    Caption = 'prêt';
                }
                // field(Cession; Rec.Cession)
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Cession';
                //     Style = Attention;
                //     StyleExpr = true;
                // }
                field(Advances; Rec.Advances)
                {
                    ApplicationArea = Basic;
                    Caption = 'Avances';
                }
                // field("Salaire Net sur fiche"; Rec."Salaire Net sur fiche")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Salaire Net sur fiche';
                // }
                field("Salaire Net Contrat"; Rec."Salaire Net Contrat")
                {
                    ToolTip = 'Specifies the value of the Salaire Net Contrat field.', Comment = '%';
                    StyleExpr = SNetContrat;
                    DecimalPlaces = 0 : 0;
                }
                field("Num Mobile Money"; Rec."Num Mobile Money")
                {
                    ToolTip = 'Specifies the value of the Num Mobile Money field.', Comment = '%';
                }
                field("Net salary cashed"; Rec."Net salary cashed")
                {
                    ApplicationArea = Basic;
                    Caption = 'Salaire net perçu';
                }
            }
            group("Rec. Salary line")
            {
                Caption = 'Ligen de salaire enreg.';
                Editable = false;
                field("Employee + ' - ' + Name"; Rec.Employee + ' - ' + Rec.Name)
                {
                    Caption = 'Employee';
                    ShowMandatory = false;
                    ShowCaption = false;
                    ApplicationArea = Basic;
                }
                field(Control1180250082; Rec."Gross Salary")
                {
                    ApplicationArea = Basic;
                    Caption = 'Salaire Brut';
                }
                field(Control1000000002; Rec.CNSS)
                {
                    ApplicationArea = Basic;
                    Caption = 'CNSS';
                    Visible = false;
                }
                field(Control1180250084; Rec."Taxable salary")
                {
                    ApplicationArea = Basic;
                    Caption = 'Salaire Imposable';
                }
                field(Control1180250086; Rec."Taxe (Month)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Impôt(Mois)';
                }
                field(Control1180250088; Rec."Net salary")
                {
                    ApplicationArea = Basic;
                    Caption = 'Salaire net';
                }
                field(Control1180250090; Rec."Net salary cashed")
                {
                    ApplicationArea = Basic;
                    Caption = 'Salaire net perçu';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        if Rec.Month > 11 then begin
            NoteVisible := true;
            PourcentageVisible := true;
            "Mois travaillésVisible" := true;
        end
        else begin
            //CurrForm.Note.VISIBLE        := FALSE;
            PourcentageVisible := false;
            "Mois travaillésVisible" := false;
        end;
        if rec."Net salary" <> rec."Salaire Net Contrat" then
            SNetContrat := 'UNFAVORABLE'
        else
            SNetContrat := 'FAVORABLE';
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
        SNetContrat: Text;


    procedure ChangerModePaiement(var Mode: Option Virement,"Espèse")
    var
        compteclt: Record "Employee Bank Account";
        clt: Record Employee;
        T1: Record "Rec. Salary Lines";
    begin
        T1.Reset;
        T1.SetFilter("No.", Rec."No.");
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

