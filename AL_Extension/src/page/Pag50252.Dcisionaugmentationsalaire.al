Page 50252 "Décision augmentation salaire"
{
    PageType = Card;
    SourceTable = "Decision augmentation salaire";
    ApplicationArea = all;
    UsageCategory = Administration;
    Caption = 'Décision augmentation salaire';

    layout
    {
        area(content)
        {
            group("Général")
            {
                Caption = 'General';
                field("N° Decision"; REC."N° Decision")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Matricule; REC.Matricule)
                {
                    ApplicationArea = all;
                }
                field("Nom et Prénom"; REC."Nom et Prénom")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Qualification; REC.Qualification)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Description Qualification"; REC."Description Qualification")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Affectation; REC.Affectation)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Description Affectation"; REC."Description Affectation")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Date de recrutement"; REC."Date de recrutement")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Salaire actuel"; REC."Salaire actuel")
                {
                    ApplicationArea = all;
                    DecimalPlaces = 3 : 3;
                }
                group("Montant Augmentation")
                {
                    Caption = 'Montant Augmentation';
                    field("Champs Libre"; REC."Champs Libre")
                    {
                        ApplicationArea = all;
                        DecimalPlaces = 3 : 3;
                    }
                    field("Montant d'augmentation"; REC."Montant d'augmentation")
                    {
                        ApplicationArea = all;
                        Caption = 'Sur Salaire';
                        DecimalPlaces = 3 : 3;
                    }
                    field("Augmentation sur complement"; REC."Augmentation sur complement")
                    {
                        ApplicationArea = all;
                        Caption = 'Sur complement';
                        DecimalPlaces = 3 : 3;
                    }
                }
                field("Nouveau Salaire"; REC."Nouveau Salaire")
                {
                    ApplicationArea = all;
                    DecimalPlaces = 3 : 3;
                }
                field("Date d'effet"; REC."Date d'effet")
                {
                    ApplicationArea = all;
                }
                field("Proposé par"; REC."Proposé par")
                {
                    ApplicationArea = all;
                }
                field("Date Création"; REC."Date Création")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Créer par"; REC."Créer par")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Observation; REC.Observation)
                {
                    ApplicationArea = all;
                    MultiLine = true;
                }
                field("Validé"; REC.Validé)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Date Validation"; REC."Date Validation")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                field("Validé Par"; REC."Validé Par")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                field("Motant Complement"; REC."Motant Complement")
                {
                    ApplicationArea = all;
                    DecimalPlaces = 3 : 3;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(BPRINT)
            {
                ApplicationArea = all;
                Caption = '&Imprimer';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin

                    RecDecision.SetRange("N° Decision", REC."N° Decision");
                    Report.RunModal(Report::"Decision Augmentation Salaire", true, true, RecDecision);
                end;
            }
            action(BPRINT1)
            {
                ApplicationArea = all;
                Caption = '&Imprimer';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if not Confirm(Text001) then exit;
                    RecDecision.Reset;
                    RecDecision.SetRange("N° Decision", REC."N° Decision");
                    if RecDecision.FindFirst then begin
                        RecDecision.Validé := true;
                        RecDecision."Date Validation" := Today;
                        RecDecision."Validé Par" := UserId;
                        RecDecision.Modify;
                        Message(Text002);
                    end
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if REC.Validé = true then
            CurrPage.Editable(false)
        else
            if REC.Validé = false then CurrPage.Editable(true);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //RecHumanResourcesSetup.GET;
        REC."N° Decision" := NoSeriesMgt.GetNextNo('PAIE-DEC', 0D, true);
        REC."Date Création" := Today;
        REC."Créer par" := UpperCase(UserId);
        //Type:=Type::"Ordre Virement";
    end;

    trigger OnOpenPage()
    begin
        if REC.Validé = true then
            CurrPage.Editable(false)
        else
            if REC.Validé = false then CurrPage.Editable(true);
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        RecHumanResourcesSetup: Record "Human Resources Setup";
        RecDecision: Record "Decision augmentation salaire";
        Text001: label 'Voulez vous valider la Décision ?';
        Text002: label 'Validation éffectué ';
}

