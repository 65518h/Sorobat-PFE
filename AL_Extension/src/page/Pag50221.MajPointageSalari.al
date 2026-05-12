Page 50221 "Maj Pointage Salarié"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "Ligne Pointage Salarié Chanti";
    ApplicationArea = all;
    Caption = 'Maj Pointage Salarié';
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field(Matricule; REC.Matricule)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field(Nom; REC.Nom)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Annee Attachement"; REC."Annee Attachement")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Mois Attachement"; REC."Mois Attachement")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                // field(Chantier; REC.Chantier)
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                // }
                field(Affectation; REC.Affectation)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        REC.SetRange("Annee Attachement", Date2dmy(WorkDate, 3));
        REC.SetRange("Mois Attachement", Date2dmy(WorkDate, 2));
    end;


    procedure Presence() JoursPres: Integer
    begin
    end;


    procedure GetAncienSoldeHMVT(ParaAnnee: Integer; ParaMois: Integer; "ParaSalarié": Code[20]) SoldeHMVT: Decimal
    var
        "LignePointageSalariéChanti": Record "Ligne Pointage Salarié Chanti";
    begin
    end;
}

