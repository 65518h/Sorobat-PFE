
page 50341 "Heures Travail Occa."
{//GL2024 Dans nav 39001476
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Heures occasionnelles";
    SourceTableView = sorting("N° Salarié", "N° Ligne", "Code departement", "Code dossier")
                      order(ascending);
    ApplicationArea = all;
    UsageCategory = Administration;
    Caption = 'Nbre de Jours';
    layout
    {

        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(dt; dt)
                {
                    ApplicationArea = Basic;
                    Caption = 'Date défaut';
                }
                field("Slr.""No."""; Slr."No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Filtre N° salarié';

                    trigger OnDrillDown()
                    begin
                        Clear(ListeSalarié);
                        if ListeSalarié.RunModal = Action::LookupOK
                          then begin
                            ListeSalarié.GetRecord(Slr);
                        end;
                        Rec.SetFilter("N° Salarié", Slr."No.");
                        CurrPage.Update;
                    end;
                }
            }
            repeater(Control1)
            {
                ShowCaption = false;
                field("N° Salarié"; Rec."N° Salarié")
                {
                    ApplicationArea = Basic;
                }
                field("""Nom usuel"" +' '+Prénom"; Rec."Nom usuel" + ' ' + Rec.Prénom)
                {
                    ApplicationArea = Basic;
                    Caption = 'Nom salarié';
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                }
                field(Quinzaine; Rec.Quinzaine)
                {
                    ApplicationArea = all;
                }
                field("Mois de paiement"; Rec."Mois de paiement")
                {
                    ApplicationArea = Basic;
                }
                field("Année de paiement"; Rec."Année de paiement")
                {
                    ApplicationArea = Basic;
                }
                field("Type Jours"; Rec."Type Jours")
                {
                    ApplicationArea = Basic;
                }
                field("Nbre Jour"; Rec."Nbre Jour")
                {
                    ApplicationArea = Basic;
                }
                field("Nombre d'heures"; Rec."Nombre d'heures")
                {
                    ApplicationArea = Basic;
                }
                field("Nombre Jours Prime Panier"; Rec."Nombre Jours Prime Panier") { ApplicationArea = alll; }





                // field("Heure Travaillé"; Rec."Heure Travaillé")
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Jours Travaillé"; Rec."Jours Travaillé")
                // {
                //     ApplicationArea = Basic;
                // }
                // field(Kmetrage; Rec.Kmetrage)
                // {
                //     ApplicationArea = Basic;
                //     Style = Strong;
                //     StyleExpr = true;
                // }
                // field(Rappel; Rec.Rappel)
                // {
                //     ApplicationArea = Basic;
                // }
                // field(Retenu; Rec.Retenu)
                // {
                //     ApplicationArea = Basic;
                // }
                // field(Cession; Rec.Cession)
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Jours Deplacement"; Rec."Jours Deplacement")
                // {
                //     ApplicationArea = Basic;
                // }
            }
            group(Control7)
            {
                ShowCaption = false;

                field(Control28; Rec."Nom usuel" + ' ' + Rec.Prénom)
                {
                    ApplicationArea = Basic;
                    Caption = 'Salairé';
                    Editable = false;
                }
                field("Montant ligne"; Rec."Montant ligne")
                {
                    Caption = 'Montant ligne';
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Salarié.""Heures sup."""; Salarié."Heures sup.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Caption = 'Total heures Trav.';
                }
            }
        }
    }

    actions
    {
        area(Promoted)
        {


            actionref(Valider1; Valider) { }

        }
        area(navigation)
        {
            group("Fonction&s")
            {
                Caption = 'Fonction&s';
                action(Valider)
                {
                    ApplicationArea = Basic;
                    Caption = 'Valider';
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    var
                        GRH: Codeunit "Management of Work Hours";
                        Window: Dialog;
                        HeuresSupEreg: Record "Heures sup. eregistrées m";
                        NTransaction: Integer;
                    begin
                        HeuresNormale.Copy(Rec);
                        if HeuresNormale.FindFirst then
                            repeat
                                HeuresNormaleEnreg.SetRange("N° Salarié", HeuresNormale."N° Salarié");
                                HeuresNormaleEnreg.SetRange("Mois de paiement", HeuresNormale."Mois de paiement");
                                HeuresNormaleEnreg.SetRange("Année de paiement", HeuresNormale."Année de paiement");
                                if HeuresNormaleEnreg.FindFirst then
                                    Error(Text001, HeuresNormale."Nom usuel" + ' ' + HeuresNormale.Prénom
                                          , HeuresNormale."Mois de paiement");
                            until HeuresNormale.Next = 0;

                        if Rec.Find('-')
                          then begin
                            if HeuresSupEreg.Find('+')
                              then
                                NTransaction := HeuresSupEreg."N° transaction" + 1
                            else
                                NTransaction := 1;
                            Window.Open('Validation des lignes d''heures du travail en cours :\' +
                                         '  N° ligne    : #######1\' +
                                         '  N° salarié  : #######2\');
                            Rec.LockTable;
                            repeat
                                Rec.verifmoispaie;
                                Window.Update(1, Rec."N° Ligne");
                                Window.Update(2, Rec."N° Salarié");
                                GRH.Validerjourtravail(NTransaction, Rec);
                            until Rec.Next = 0;
                            Window.Close;
                        end
                        else
                            Error('Erreur :\Le formulaire est vide.\Impossible de poursuivre.');
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if Salarié.Get(Rec."N° Salarié") then
            Salarié.CalcFields("Heures sup.");
    end;

    trigger OnInit()
    begin
        dt := WorkDate;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Validate(Date, dt);
    end;

    var
        "Salarié": Record Employee;
        "PériodeCompta": Record "Accounting Period";
        "NomPériode": Text[30];
        dt: Date;
        GRH: Codeunit "Management of Work Hours";
        Slr: Record Employee;
        "ListeSalarié": Page "Employee List";
        HeuresNormaleEnreg: Record "Heures occa. enreg. m";
        HeuresNormale: Record "Heures occasionnelles";
        Text001: label 'Heure Normal Déja intégré Pour Le Salarié %1 Mois %2';
        // Complement: Record Complement;
        // DetailComplement: Record "Detail Complement";
        JoursEnAjout: Decimal;
        HeuresSupEnregistrer: Record "Heures sup. m";
        Text19008931: label 'Salarié';
        Text19059386: label 'Total heures Trav.';
}

