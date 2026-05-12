page 50105 "Entete Pointage Journalier."
{
    DeleteAllowed = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = Card;
    SourceTable = "Entete Pointage Salarié Chan";
    Caption = 'Pointage Journalier';
    ApplicationArea = all;
    UsageCategory = none;
    SourceTableView = WHERE(Statut = CONST(Ouvert));

    layout
    {
        area(content)
        {

            group(Choix)
            {
                Caption = 'Choix';
                field("No. Pointage"; Rec."No. Pointage")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
                field(Affectation; Rec.Affectation)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Annee Attachement"; Rec."Annee Attachement")
                {
                    ApplicationArea = all;
                    Editable = IsEditable2;


                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
                field("Mois Attachement"; Rec."Mois Attachement")
                {
                    ApplicationArea = all;
                    Style = StrongAccent;
                    Editable = IsEditable2;
                    StyleExpr = TRUE;
                }
                field(Statut; Rec.Statut)
                {
                    ApplicationArea = all;
                    Style = AttentionAccent;
                    StyleExpr = true;
                    Editable = false;
                }
            }
            part(Lines; "Ligne Pointage Journalier Val")
            {
                ApplicationArea = all;
                Caption = 'Ligne Pointage Journalier Validé';
                SubPageLink = "No. Pointage" = FIELD("No. Pointage");
                UpdatePropagation = Both;
            }

        }
    }

    actions
    {

        area(processing)
        {
            action("Proposer des lignes de salariés")
            {
                ApplicationArea = all;
                Caption = 'Proposer des lignes de salariés';
                Promoted = true;
                PromotedCategory = Process;


                trigger OnAction()
                begin
                    IF rec."No. Pointage" = '' THEN
                        ERROR('Error');
                    rec.TestField(Affectation);
                    rec.TestField("Annee Attachement");
                    if Rec."Mois Attachement" = Rec."Mois Attachement"::" " then
                        Error('Le mois d''attachement ne peut pas être vide.');

                    // Filtrer les employés par service
                    Employee.Reset();
                    Employee.SetRange(service, rec.Affectation);
                    if not Employee.FindSet() then
                        Error('Aucun employé trouvé pour la service %1.', rec.Affectation);

                    // Insérer les lignes
                    repeat
                        "Ligne PointageSalariéChan".Init();
                        "Ligne PointageSalariéChan"."No. Pointage" := Rec."No. Pointage";
                        "Ligne PointageSalariéChan"."Annee Attachement" := Rec."Annee Attachement";
                        "Ligne PointageSalariéChan"."Mois Attachement" := Rec."Mois Attachement";
                        "Ligne PointageSalariéChan"."Matricule" := Employee."No.";
                        "Ligne PointageSalariéChan"."Nom" := Employee."First Name";
                        "Ligne PointageSalariéChan"."Fonction" := Employee."Fonction";
                        "Ligne PointageSalariéChan".Insert();
                    until Employee.Next() = 0;

                    Message('Lignes de pointage insérées avec succès.');
                    CurrPage.SAVERECORD;
                    CurrPage.UPDATE(TRUE);

                end;
            }
            action(Valider)
            {
                ApplicationArea = all;
                Caption = 'Valider';
                ShortCutKey = 'F11';
                Promoted = true;
                PromotedCategory = Process;
                Image = Post;

                trigger OnAction()
                begin
                    rec.Statut := rec.Statut::Valider;


                end;
            }

            action(Rafraichir)
            {
                ApplicationArea = all;
                Image = Refresh;
                Caption = 'Rafraichir';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    IF LAffecatation = '' THEN ERROR(Text004);
                    IF MoisAttach = 0 THEN ERROR(Text004);
                    AnneeAttach := DATE2DMY(WORKDATE, 3);
                    rec.RESET;
                    rec.SETRANGE(Affectation, LAffecatation);
                    rec.SETRANGE("Annee Attachement", AnneeAttach);
                    rec.SETRANGE("Mois Attachement", MoisAttach);
                end;
            }
        }
    }

    procedure InitRecord()
    var
        HumRessSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        NoSeriesMgt.SetDefaultSeries(rec."No. Pointage", HumRessSetup."Pointage Salarié");
    end;

    trigger OnAfterGetRecord()
    begin
        CurrPage.Lines.page.EDITABLE(TRUE);
        CurrPage.Lines.PAGE.DisableFields(rec."No. Pointage");
        DisableFields2();
    end;

    trigger OnAfterGetCurrRecord()
    begin

        CurrPage.Lines.page.EDITABLE(TRUE);
        CurrPage.Lines.PAGE.DisableFields(rec."No. Pointage");
        DisableFields2();
    end;


    trigger OnNewRecord(BelowxRec: Boolean)
    var
        usersteup: Record "User Setup";
    begin

        if usersteup.Get(UserId) then begin
            rec.Affectation := usersteup.Affectation;
            rec.Statut := rec.Statut::Ouvert
        end;
    end;

    trigger OnOpenPage()
    var
        usersteup: Record "User Setup";
    begin
        if usersteup.Get(UserId) then begin

            Rec.FilterGroup(0);

            Rec.SetRange("Affectation", usersteup.Affectation);

            Rec.FilterGroup(2);
        end;

        CurrPage.Lines.page.EDITABLE(TRUE);
        CurrPage.Lines.PAGE.DisableFields(rec."No. Pointage");
        DisableFields2();
    end;

    var
        Text001: Label 'Valider Cette Attachement';
        EtatMensuellePaie: Record "Ligne Pointage Salarié Chanti";
        EntetePointageJournalier: Record "Entete Pointage Salarié Chanti";
        EntetePointageJournalier2: Record "Entete Pointage Salarié Chanti";
        BonReglement: Record "Bon Reglement";
        RecGEmp: Record 5200;
        i: Integer;
        d: Dialog;
        MgmtSuppHour: Codeunit "Management of Work Hours";
        ToTNbrjours: Decimal;
        ToTNbrHeures: Decimal;
        CodeQualification: Code[20];
        CodeAffectation: Code[20];
        "NombreSalarié": Integer;
        Heure: Time;
        "PointageJournalierValidé": Record "Ligne Pointage Journ. Validé";
        "PointageJournalierValidé2": Record "Ligne Pointage Journ. Validé";
        LignePointageJournalier: Record "Ligne Pointage Salarié Chanti";
        Text002: Label 'Validation Effectuée Avec Succée';
        Text003: Label 'Journee Deja Validé';
        "EntetePointageJournValidé": Record "Entete Pointage Journ. Validé";
        LAffecatation: Code[20];
        MoisAttach: Option " ",Janvier,Fevrier,Mars,Avril,Mai,Jiun,Juillet,Aout,Septembre,Octobre,Novembre,Decembre;
        AnneeAttach: Integer;
        Text004: Label 'Remplir Tous Les Champs';
        DateAttach: Date;
        FinMois: Date;
        k: Integer;
        Dimanche: Integer;
        DateDebut: Date;
        DateFin: Date;
        "Entete PointageSalariéChan": record "Entete Pointage Salarié Chan";
        "Ligne PointageSalariéChan": record "Ligne Pointage Salarié Chanti";
        Text005: Label 'Le Salarié %1 Est Attaché A L''Affectaion  %2 Pour Cette Année et Ce Mois';
        Employee: record 5200;
        Espace: Code[20];
        [InDataSet]
        "27Emphasize": Boolean;
        [InDataSet]
        "28Emphasize": Boolean;
        [InDataSet]
        "29Emphasize": Boolean;
        [InDataSet]
        "30Emphasize": Boolean;
        [InDataSet]
        "1Emphasize": Boolean;
        [InDataSet]
        "2Emphasize": Boolean;
        [InDataSet]
        "3Emphasize": Boolean;
        [InDataSet]
        "4Emphasize": Boolean;
        [InDataSet]
        "5Emphasize": Boolean;
        [InDataSet]
        "6Emphasize": Boolean;
        [InDataSet]
        "7Emphasize": Boolean;
        [InDataSet]
        "8Emphasize": Boolean;
        [InDataSet]
        "9Emphasize": Boolean;
        [InDataSet]
        "10Emphasize": Boolean;
        [InDataSet]
        "11Emphasize": Boolean;
        [InDataSet]
        "12Emphasize": Boolean;
        [InDataSet]
        "13Emphasize": Boolean;
        [InDataSet]
        "14Emphasize": Boolean;
        [InDataSet]
        "15Emphasize": Boolean;
        [InDataSet]
        "16Emphasize": Boolean;
        [InDataSet]
        "17Emphasize": Boolean;
        [InDataSet]
        "18Emphasize": Boolean;
        [InDataSet]
        "19Emphasize": Boolean;
        [InDataSet]
        "20Emphasize": Boolean;
        IsEditable2: Boolean;





    procedure DisableFields2()
    begin

        if (rec.Statut = rec.Statut::Ouvert) then
            IsEditable2 := true
        else
            IsEditable2 := false

    end;



















}

